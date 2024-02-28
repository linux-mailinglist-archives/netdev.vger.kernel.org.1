Return-Path: <netdev+bounces-75569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645C86A930
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879041F26EE5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014525579;
	Wed, 28 Feb 2024 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFmwNLhT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E122F1C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106369; cv=none; b=rgIC82b59KvLRX9zAGaYmJFa9TKJMm6M+2F98pgzOfvgssFvVGt0He2238uW3bQFe94+xmN+FA5S/496pw6woLRRGjLvIOJjQ+ISLtGtxzbnSs6xNEfFTq77i4dVjksqTS7N0m9hasjxyf28Jlr1OtkMOUtr0bFKh44X89waXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106369; c=relaxed/simple;
	bh=WIv/ytZPC0gZ1D50cmv4rx8mx5kZjVh5M0M7B5UUYHU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ViVhpF/F9O8knh/25kobp5qEI4D4QGUdTV587Ngs+wAMZ4qadklQcLDBWUoh8UTGApOHiTXwy32j3WU8jPbWcVu+i3E3iosqodHw3c2dB3B/n0CFYBxI1LcQML5fwRuFMVT0XrU3yBAsk5WI5BCQBwtfZBX8GGF7J5tEygBv9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFmwNLhT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709106366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YblT7gBEcZmHTFnl8+ECuio4cmPTlV1P9r7ZheTH7lU=;
	b=BFmwNLhTebkt/UpzQOjfNjopXd5lRMCT96qFaaHajaCGB2yiVVTXE4hFUzM8r6NJTNoY2s
	YND7ZodtyfRjuDNfEhxtQ46tP0p6gpPH2Onxb9A+GquLOA4pvVhV59/bpZ4ac6sEGpU/ZM
	XRXLW/miXAJs7N4JJYJbbvWZ5XIFFEk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654--f_JMod7M9iYGGOeK5TxGA-1; Wed, 28 Feb 2024 02:46:04 -0500
X-MC-Unique: -f_JMod7M9iYGGOeK5TxGA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41293adf831so10997455e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 23:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709106363; x=1709711163;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YblT7gBEcZmHTFnl8+ECuio4cmPTlV1P9r7ZheTH7lU=;
        b=VVy0ijU6dwq3lDSePu/qPPEWIFnhISitYc0RL/2WkWZMpYU4Dpy2z4OzkOStPrYmlP
         6qEsMQLzyY7I9rXzxwpAfayFAUiAVl/lGP2X/X4KiTKgJtIWeX0Q09KOM/3TmFm55iz2
         kThSA9GxQ72Ba15FmmNH+WgQrR1uEY/znMx1fN/VXyARmvV33SN6MPBol/oa21cG8CWT
         zUvNo+JHb3vxs09DKNrh8nfKEwuQY4SU7jcrmH4lMvPVtrnMe+t1i+fkI7h6HGIYcXy7
         jLLpKuOqU0Y9t98xJI+sdfjTMGfpTtW6RKKDFml7HAWOUXfUo+SJu+VlR08HZEvBQ9aG
         stDg==
X-Forwarded-Encrypted: i=1; AJvYcCX0ABfm3CPHw2nGVArmdRm3Em9gadgpW0e31YP+e1LvFO8hgrvQEcs94U7CT/faA0GNlFJ55mT7lUbX6SQqYXJzZ+tUooAx
X-Gm-Message-State: AOJu0YxAaWREooijXazItKF3iWNdCOmkay+D5zxxfKERX7U9p3MmU/EL
	rouTPdj+TXRn1oNhILxf06GVHdz1lnuvaprUOYznt+7q3i8gO/qy/spmZK9UF5vYj5QqSf29jmK
	jm3+UyWdP2oIIk3PcVyBYf1M6lMWrq8YZ7SBJGN31d7Dsd2fFgFRaDw==
X-Received: by 2002:a05:600c:1c08:b0:412:a0a3:cea with SMTP id j8-20020a05600c1c0800b00412a0a30ceamr6863272wms.1.1709106363363;
        Tue, 27 Feb 2024 23:46:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0BnP2ZjUvnIKh7NatCMX69QfUUDlTV0SbmQQVDKPzbRvX4oWrb6uARD5PFipDOtoXbdRKhQ==
X-Received: by 2002:a05:600c:1c08:b0:412:a0a3:cea with SMTP id j8-20020a05600c1c0800b00412a0a30ceamr6863261wms.1.1709106363015;
        Tue, 27 Feb 2024 23:46:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-156.dyn.eolo.it. [146.241.246.156])
        by smtp.gmail.com with ESMTPSA id dx14-20020a05600c63ce00b004129f28e2cdsm1204524wmb.3.2024.02.27.23.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:46:02 -0800 (PST)
Message-ID: <c2a73a3b11970a4aefd020764e19284ba347cc1c.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 04/14] af_unix: Bulk update
 unix_tot_inflight/unix_inflight when queuing skb.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 kuni1840@gmail.com,  netdev@vger.kernel.org
Date: Wed, 28 Feb 2024 08:46:01 +0100
In-Reply-To: <20240228023445.28279-1-kuniyu@amazon.com>
References: <d90b617800cedf03ce8d93d2df61a724f2775f56.camel@redhat.com>
	 <20240228023445.28279-1-kuniyu@amazon.com>
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

On Tue, 2024-02-27 at 18:34 -0800, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Tue, 27 Feb 2024 11:47:23 +0100
> > On Fri, 2024-02-23 at 13:39 -0800, Kuniyuki Iwashima wrote:
> > > diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> > > index 96d0b1db3638..e8fe08796d02 100644
> > > --- a/net/unix/garbage.c
> > > +++ b/net/unix/garbage.c
> > > @@ -148,6 +148,7 @@ static void unix_free_vertices(struct scm_fp_list=
 *fpl)
> > >  }
> > > =20
> > >  DEFINE_SPINLOCK(unix_gc_lock);
> > > +unsigned int unix_tot_inflight;
> > > =20
> > >  void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *recei=
ver)
> > >  {
> > > @@ -172,7 +173,10 @@ void unix_add_edges(struct scm_fp_list *fpl, str=
uct unix_sock *receiver)
> > >  		unix_add_edge(fpl, edge);
> > >  	} while (i < fpl->count_unix);
> > > =20
> > > +	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
> > >  out:
> > > +	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl=
->count);
> >=20
> > I'm unsure if later patches will shed some light, but why the above
> > statement is placed _after_ the 'out' label? fpl->count will be 0 in
> > such path, and the updated not needed. Why don't you place it before
> > the mentioned label?
>=20
> fpl->count is the total number of fds in skb, and fpl->count_unix
> is the number of AF_UNIX fds.

Ah right you are! Sorry, I misread the variable name. This code looks
good.

Cheers,

Paolo


