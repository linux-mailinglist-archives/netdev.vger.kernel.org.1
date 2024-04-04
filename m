Return-Path: <netdev+bounces-84785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D9389853A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5253D288657
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607B780BF7;
	Thu,  4 Apr 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGQ6lWzb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D67F7FF
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227248; cv=none; b=MGxeFN6EH+HYMUbXyp3/S7NKYpJTPretIlFndDH3nSJZsu/8FDRTEzlGwpzzwBGV1Gt4SkgHe4M86PfM90E7QN38jJ+pCMIPrYGqWu4h+YGG5blJzKgD2MDXE/OusRoflhsSs9SEhdOwlAr34NVe3o4EGgO5m5nRjZN7xfJ1xqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227248; c=relaxed/simple;
	bh=j6S1pM1Rhkz+8qgQx/WACVD+lnZ8tWloWcxfHeTksGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/xDsBlIcfRNy5FD1jbtrrnciPPyqAQe4UrGbjKRxxfqj1VXsHnTppcm1anWfU7cEaTEhnmtyPQvktvXNTIlT5SjaJ3GrEwou5PYGJEp0p++LqQ/AC8nwmt5S5+Qusz52tL6Qt0014BWnGs9B8EnZOeF+J1IwIPbWw6DkvVPrT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGQ6lWzb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712227244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gEu4cBn378/joci9QMSBd+Fr2ZU6q36lFExgj65cyUc=;
	b=IGQ6lWzbLJsOvKNedT1AKf9myUbzp27fvwWP7rbIvdnwUpMd56iwWc0syEg4fvr8n1yrhE
	gl5sroOdefY+s74PVNQMMK/l00xTCGtYCv7kWl3baBuI0QlWtI/Dw2AC+ULw+k68WjZWn3
	0NHT7o1XYFfvTucLGD3We+BegWscUoU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-cJziv7PqPI2dCXce3oInCw-1; Thu, 04 Apr 2024 06:40:42 -0400
X-MC-Unique: cJziv7PqPI2dCXce3oInCw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d6884f6de1so1640291fa.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 03:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227241; x=1712832041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEu4cBn378/joci9QMSBd+Fr2ZU6q36lFExgj65cyUc=;
        b=lHzpIq5JBNrxE+YzrTv9yiRU1I7+v8tFBzgWpJb9IS0rkAr0/ekifBW78Ogu6mJeJm
         P4rkLpGbdruKikuqc+HdjYfWp5C7SaH0I02MVY8lMd0D3VVGoR0zH5LzcawniSZMJDWw
         yGNlMLDtmr6DjR/Wt/XHJANWHFOe8BhcTpAINfBMMp4g/quK/lJRZu2lY06Lm9KgMIf6
         KQEgaHvoN4vAtuj7spP2WpZoclNghfbES8B3QMGDugxUHYnROumNd5UEIE3IgcPB5n2O
         g5Svi23vR6CBRRmlhfLDXF8VSxRyNBdzsZUs6iEvHgrIUW7oOoX0x7U3xw2nz6zZdptW
         xEVw==
X-Forwarded-Encrypted: i=1; AJvYcCVNT8RTWHz3NYgZdABu4x73QJavFrmDqsgR0pSC8YQGcXkDccrWoHFwXq0Ktz1b6ZDNWRHC0azmz092NSv/3UIif1eUVmga
X-Gm-Message-State: AOJu0YxD9uY5wS5DDN1tAVh9I5fLdD5FVu0+y0ZHEOFYXqqEQNswim0i
	+j7V+2Bpqr/HK12ix+YtgIsYBg71rdKGsz8DkKlPgKTInOrgNwz5Xf/wU9DAJUDajonyoInxeY9
	xZxHrGIrZCacaKBCdme/tRSzuCsXsFZOn1REqeOGo20cxWpwXpsoy9g==
X-Received: by 2002:a2e:8495:0:b0:2d4:25c5:df1e with SMTP id b21-20020a2e8495000000b002d425c5df1emr1381600ljh.5.1712227241077;
        Thu, 04 Apr 2024 03:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOqqpc0zMsq8F67opVCRWDd5x9RuRRtKzOo4yudL9Wr4/77EV/Ftug3z+4/OZdIogqGpstpQ==
X-Received: by 2002:a2e:8495:0:b0:2d4:25c5:df1e with SMTP id b21-20020a2e8495000000b002d425c5df1emr1381580ljh.5.1712227240636;
        Thu, 04 Apr 2024 03:40:40 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-213.dyn.eolo.it. [146.241.247.213])
        by smtp.gmail.com with ESMTPSA id bg35-20020a05600c3ca300b004162020cee2sm2314012wmb.4.2024.04.04.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:40:40 -0700 (PDT)
Message-ID: <7c8be16329668d343a971e265e923543cba5e304.camel@redhat.com>
Subject: Re: [PATCH net-next v5 1/2] net: ethernet: ti: am65-cpts: Enable RX
 HW timestamp for PTP packets using CPTS FIFO
From: Paolo Abeni <pabeni@redhat.com>
To: Chintan Vankar <c-vankar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>,  Siddharth Vadapalli <s-vadapalli@ti.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Roger
 Quadros <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 04 Apr 2024 12:40:38 +0200
In-Reply-To: <20240402114405.219100-2-c-vankar@ti.com>
References: <20240402114405.219100-1-c-vankar@ti.com>
	 <20240402114405.219100-2-c-vankar@ti.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-02 at 17:14 +0530, Chintan Vankar wrote:
> Add a new function "am65_cpts_rx_timestamp()" which checks for PTP
> packets from header and timestamps them.
>=20
> Add another function "am65_cpts_find_rx_ts()" which finds CPTS FIFO
> Event to get the timestamp of received PTP packet.
>=20
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>=20
> Link to v4:
> https://lore.kernel.org/r/20240327054234.1906957-1-c-vankar@ti.com/
>=20
> Changes from v4 to v5:
> - Updated commit message.
> - Replaced "list_del_entry()" and "list_add()" functions with equivalent
>   "list_move()" function.
>=20
>  drivers/net/ethernet/ti/am65-cpts.c | 64 +++++++++++++++++++++++++++++
>  drivers/net/ethernet/ti/am65-cpts.h |  6 +++
>  2 files changed, 70 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/t=
i/am65-cpts.c
> index c66618d91c28..bc0bfda1db12 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c
> @@ -906,6 +906,70 @@ static int am65_skb_get_mtype_seqid(struct sk_buff *=
skb, u32 *mtype_seqid)
>  	return 1;
>  }
> =20
> +static u64 am65_cpts_find_rx_ts(struct am65_cpts *cpts, u32 skb_mtype_se=
qid)
> +{
> +	struct list_head *this, *next;
> +	struct am65_cpts_event *event;
> +	unsigned long flags;
> +	u32 mtype_seqid;
> +	u64 ns =3D 0;
> +
> +	am65_cpts_fifo_read(cpts);
> +	spin_lock_irqsave(&cpts->lock, flags);

am65_cpts_fifo_read() acquires and releases this same lock. If moving
to a lockless schema is too complex, you should at least try to acquire
the lock only once. e.g. factor out a lockless  __am65_cpts_fifo_read
variant and explicitly acquire the lock before invoke it.

> +	list_for_each_safe(this, next, &cpts->events) {
> +		event =3D list_entry(this, struct am65_cpts_event, list);
> +		if (time_after(jiffies, event->tmo)) {
> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);

Jakub suggested to use list_move() in v4, you should apply that here,
too.

Cheers,

Paolo


