Return-Path: <netdev+bounces-85715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80889BE5A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5D31F22F23
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FC069E01;
	Mon,  8 Apr 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3hpI5v2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2F745C3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576857; cv=none; b=elBWfByjro9OihxkRZg7xR4muXtzk5BKHMLYVmPmenINs26cA05GRkPGXhTuDphyFi4uKJ7is7t5wLaHjy37bQEee07MSIRGukscYKCMahC2w00oCEG+PlvT/LbIDqowFdixFr4Lth9U3iYR4LMXRIa+gUxYzUj6v+xDzO6hv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576857; c=relaxed/simple;
	bh=EomgZY0VzEQ9ke8AS1TswXN4F0HhI5IurYd3Wu/0xK0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIeH0aCwtFg5iujyozmDQ6OSWVdLDp9mSJszs77H5S75di9lvsY4nskOnKiH+40J6oqN+TFkmJ91BWifJmtdEJrGFQIq8Ovx02tAYVxizcn145q4GhqAA5xDn/oxvxfxEvS87d7Hmu5YwTTocU/fC6GCSQAvWtuynMVztJfhNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3hpI5v2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712576854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tAyZusgXC+hi0oZxmqmMT7xPpLcaN6WvuFyr8mteK+Y=;
	b=i3hpI5v2TpdGqY81K36qmyTsGN91kI1B2VpDoIgQFQA5DjrUDg0D3BmF82omF9nlxhdAoK
	qicY3g4Kmt6sLnhuG/6ufA+vqfzdXDJdJpxZeHDNCBIW2gc2HFRKSyepl7EaGyomODj3cV
	ykZPVAmoHsjy2qvkDF5r63jGY81flFQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-y1QxaZEZN7G7GQaCkn_O6A-1; Mon, 08 Apr 2024 07:47:33 -0400
X-MC-Unique: y1QxaZEZN7G7GQaCkn_O6A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78a5e62931cso59220685a.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 04:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576852; x=1713181652;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAyZusgXC+hi0oZxmqmMT7xPpLcaN6WvuFyr8mteK+Y=;
        b=UIe92Ffk51jLDSHrSaaaENkAkpLqXW0MthBTV2kUpgce0qmgwMsiKo3/dL4+YIeM77
         DSjfZnwsDCaHLaXgq7YgO2yVp5IY/2aJ1knPlf29REAsHO/CFt0zfMNmyFTToek+9TC5
         URTeJGaZ2iUDqtEvufvEwwLnNPIBKcnOBXucBfL2cutRAWS3TSVgJ/lYrQoA2jeTjEpF
         YFfrMA+bsKthg77HdgtltaBg0+bAEbhQgM6Ypf3Ax5eC3E7H0VHiF0sCBOlNtM2/5pfq
         Qk/fVheX2hz8Hl0hd0LRvECo12MmHkLYzEoRc70Nzi95VH8UA0Eq66kM7KorTIz8QTen
         Mt8g==
X-Forwarded-Encrypted: i=1; AJvYcCXoH0ZjeS3Aj6XOzxb+n0COLPmcZzMWBK0P2hauvcI1sgT/rDOEccCFc1l5pt7S9dy57t9ghFtnJYEmgxcnz5G4OfuIFBr1
X-Gm-Message-State: AOJu0YxVwIUd18Fy/ZJ/S1JyztWjnTmZpzI513Sy9IC/svf8dSoHjBJm
	UFinN1QZxR9MxTI4xlefwSjIgf/aMwTO3QAI/tPklSUhDovFYlvnzm8Wl5sAWFl9vp/C4cgC9Jh
	m2A4dCHw0y+EWuGCK+U13kg6mSDzmqwJndwEoyhq6elMGA7t6/YHyuQ==
X-Received: by 2002:a05:620a:1793:b0:78d:67a6:4f34 with SMTP id ay19-20020a05620a179300b0078d67a64f34mr1824145qkb.2.1712576852502;
        Mon, 08 Apr 2024 04:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNkGVrA+Hr/hJmtk/0L2G4hIFkN7pbCA1+3V1qW/+LmTvTY7tEHRpQv57nY8bma7By4p9NOg==
X-Received: by 2002:a05:620a:1793:b0:78d:67a6:4f34 with SMTP id ay19-20020a05620a179300b0078d67a64f34mr1824125qkb.2.1712576852155;
        Mon, 08 Apr 2024 04:47:32 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-253-22.dyn.eolo.it. [146.241.253.22])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a088300b0078d342e3710sm3134161qka.110.2024.04.08.04.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:47:31 -0700 (PDT)
Message-ID: <25b2e5fd1d63fc21c6f52fe6adebdbd63f9907fb.camel@redhat.com>
Subject: Re: [PATCH net-next v2] mptcp: add reset reason options in some
 places
From: Paolo Abeni <pabeni@redhat.com>
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, matttbe@kernel.org,
 martineau@kernel.org,  geliang@kernel.org
Cc: mptcp@lists.linux.dev, netdev@vger.kernel.org, Jason Xing
	 <kernelxing@tencent.com>
Date: Mon, 08 Apr 2024 13:47:28 +0200
In-Reply-To: <20240406014848.71739-1-kerneljasonxing@gmail.com>
References: <20240406014848.71739-1-kerneljasonxing@gmail.com>
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

On Sat, 2024-04-06 at 09:48 +0800, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
>=20
> The reason codes are handled in two ways nowadays (quoting Mat Martineau)=
:
> 1. Sending in the MPTCP option on RST packets when there is no subflow
> context available (these use subflow_add_reset_reason() and directly call
> a TCP-level send_reset function)
> 2. The "normal" way via subflow->reset_reason. This will propagate to bot=
h
> the outgoing reset packet and to a local path manager process via netlink
> in mptcp_event_sub_closed()
>=20
> RFC 8684 defines the skb reset reason behaviour which is not required
> even though in some places:
>=20
>     A host sends a TCP RST in order to close a subflow or reject
>     an attempt to open a subflow (MP_JOIN). In order to let the
>     receiving host know why a subflow is being closed or rejected,
>     the TCP RST packet MAY include the MP_TCPRST option (Figure 15).
>     The host MAY use this information to decide, for example, whether
>     it tries to re-establish the subflow immediately, later, or never.
>=20
> Since the commit dc87efdb1a5cd ("mptcp: add mptcp reset option support")
> introduced this feature about three years ago, we can fully use it.
> There remains some places where we could insert reason into skb as
> we can see in this patch.
>=20
> Many thanks to Mat and Paolo for help:)
>=20
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> Link: https://lore.kernel.org/all/5046e1867c65f39e07822beb0a19a22743b1064=
b.camel@redhat.com/
> 1. complete all the possible reset reasons in the subflow_check_req() (Pa=
olo)
> ---
>  net/mptcp/subflow.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1626dd20c68f..b7ce2ca1782c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -150,8 +150,10 @@ static int subflow_check_req(struct request_sock *re=
q,
>  	/* no MPTCP if MD5SIG is enabled on this socket or we may run out of
>  	 * TCP option space.
>  	 */
> -	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info))
> +	if (rcu_access_pointer(tcp_sk(sk_listener)->md5sig_info)) {
> +		subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
>  		return -EINVAL;
> +	}
>  #endif
> =20
>  	mptcp_get_options(skb, &mp_opt);
> @@ -219,6 +221,7 @@ static int subflow_check_req(struct request_sock *req=
,
>  				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
>  			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
>  				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
> +				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
>  				return -EPERM;
>  			}
>  			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
> @@ -227,10 +230,12 @@ static int subflow_check_req(struct request_sock *r=
eq,
>  		subflow_req_create_thmac(subflow_req);
> =20
>  		if (unlikely(req->syncookie)) {
> -			if (mptcp_can_accept_new_subflow(subflow_req->msk))
> -				subflow_init_req_cookie_join_save(subflow_req, skb);
> -			else
> +			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
> +				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
>  				return -EPERM;
> +			}
> +
> +			subflow_init_req_cookie_join_save(subflow_req, skb);
>  		}
> =20
>  		pr_debug("token=3D%u, remote_nonce=3D%u msk=3D%p", subflow_req->token,
> @@ -873,13 +878,18 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
>  					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
>  				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
>  					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
> +					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
>  					goto dispose_child;
>  				}
>  				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
>  			}
> =20
> -			if (!mptcp_finish_join(child))
> +			if (!mptcp_finish_join(child)) {
> +				struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(child);
> +
> +				subflow_add_reset_reason(skb, subflow->reset_reason);
>  				goto dispose_child;
> +			}
> =20
>  			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
>  			tcp_rsk(req)->drop_req =3D true;

LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>



