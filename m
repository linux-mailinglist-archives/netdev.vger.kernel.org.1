Return-Path: <netdev+bounces-64158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65050831819
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90AC1F24162
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A82223754;
	Thu, 18 Jan 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAmOt34m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59375C127
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576090; cv=none; b=mCG5Z7XkJxRh1QOqbH704lBeLQWjCQcGV5AV8XLHU0WMUhBKM+7feTkEHnfrDlvrVFwX9i7UV5T69IrdAZ7iwac4ltDasUIVz8XWIRPd3UWYJBR+ySTUJGVSliHYyL+Fq+cHFtrzMWwXaSWMYL7g89kPzNYwUohxXsWhnbfyM1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576090; c=relaxed/simple;
	bh=tNBwY3kZ4r8uZhtCj/MeQOThus6o5Qjxil/+o3CPPvE=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=CDS1Wfr2nGS5kbjqEZwaO27nVjoejR4pauRULx27ZwW1a/9P1L+/K0jEnS67Do5MF65NyUQRg2FqyRA7JMum2awjeS3LWczOdsZ418n/0bk15RIcIDW3VH6p9XVhhRL5xwuXIsBGfzAwNjBgJUug4lyB7kEBwgsa6kAW/EMq6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAmOt34m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705576087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wyIKMqu1j/C3Lm7LUQ36mtXxb2sNFngMDGFf93Ohduw=;
	b=gAmOt34m7uG6Pi5iAXaPcn32dJzdqJfBjm2JiBMPh/OSa0s9Wrsk+VEl+lIKJLMHjmn7Y3
	aTRw5fgYv1vi2K7zuYtSvxMyZJnPLgaL0d/dtJu2Oeo2jCZw5mw/47h4VmJWrGYkCCeuK2
	dwNbgfUOFn/vWXQOfXsbUEZi9SaynW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-zXUsXUb-Md-M4fnxqly_BA-1; Thu, 18 Jan 2024 06:08:06 -0500
X-MC-Unique: zXUsXUb-Md-M4fnxqly_BA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40e4997b828so16999115e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 03:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576085; x=1706180885;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wyIKMqu1j/C3Lm7LUQ36mtXxb2sNFngMDGFf93Ohduw=;
        b=MAtCttGNTW/yLP7hXk+ITVyeuFwXIo8G60GcmJ4vDyEwSoeb1MCVsLPatrYwsSRGJY
         LubdJzT5eM3tdKs43C/2y8vBAPIwlMtqbc4MRs0TVkB/jTRueAjtsEiYi/w7uFtElFCk
         IXcUXazs7F42gZV8PnbJ8UwTYYYwGcA3pI15rM4tsA/3yacyxXDd4uV+7LU/SHVWsM28
         VEVFh0iB4ev9W9TvuP7Lw/hYITO4y+gqj0qM5jhNdNABmqgvyR6rMlAn07aoxjo/wP5Q
         1+okyBYmOMyw/BZ5MQ0Hdvm/2GFCKCOD9xD3jgiypZMLJ+k+JYlfkV2TUf1Ro8bKAGJ6
         PEcw==
X-Gm-Message-State: AOJu0YyK7LX66mj71TAQMQ5hkxJSaziBWuWaBSW5jKD/zB0CaTULABjt
	4QSXBjwpaKVkSyiARShkG7Et9vgNDCjFk3Mu0H9ajhXVqIIMJzIrZCzjD9LUBLpwf6O/qnxdBKP
	MgQ1wQbiohYhEAlVGJVuGhsSUsuDHCoOLTlq0VjrrK4oBYm8sVzuJGA==
X-Received: by 2002:a05:600c:1c12:b0:40e:89ad:8b77 with SMTP id j18-20020a05600c1c1200b0040e89ad8b77mr914207wms.3.1705576084840;
        Thu, 18 Jan 2024 03:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbwYHLGHnJ+67DW8pgoOe65NuBRP6H9vxFNmXdRicomgGIXcGVR8YhSlVp0IV7R5Vl+QW4CQ==
X-Received: by 2002:a05:600c:1c12:b0:40e:89ad:8b77 with SMTP id j18-20020a05600c1c1200b0040e89ad8b77mr914185wms.3.1705576084468;
        Thu, 18 Jan 2024 03:08:04 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-180.dyn.eolo.it. [146.241.241.180])
        by smtp.gmail.com with ESMTPSA id l26-20020a056000023a00b0033775980d26sm3797652wrz.2.2024.01.18.03.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:08:04 -0800 (PST)
Message-ID: <8834c825579a054d51be3d60405c0b204fa5c24b.camel@redhat.com>
Subject: Re: [PATCH net 14/14] netfilter: ipset: fix performance regression
 in swap operation
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Jozsef Kadlecsik
 <kadlec@netfilter.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
 netfilter-devel@vger.kernel.org,  davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, fw@strlen.de
Date: Thu, 18 Jan 2024 12:08:02 +0100
In-Reply-To: <CANn89iK_oa5CzeJVbiNSmPYZ6K+4_2m9nLqtSdwNAc9BtcZNew@mail.gmail.com>
References: <20240117160030.140264-1-pablo@netfilter.org>
	 <20240117160030.140264-15-pablo@netfilter.org>
	 <CANn89i+jS11sC6cXXFA+_ZVr9Oy6Hn1e3_5P_d4kSR2fWtisBA@mail.gmail.com>
	 <54f00e7c-8628-1705-8600-e9ad3a0dc677@netfilter.org>
	 <CANn89iK_oa5CzeJVbiNSmPYZ6K+4_2m9nLqtSdwNAc9BtcZNew@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 17:28 +0100, Eric Dumazet wrote:
> On Wed, Jan 17, 2024 at 5:23=E2=80=AFPM Jozsef Kadlecsik <kadlec@netfilte=
r.org> wrote:
> >=20
> > Hi,
> >=20
> > On Wed, 17 Jan 2024, Eric Dumazet wrote:
> >=20
> > > On Wed, Jan 17, 2024 at 5:00=E2=80=AFPM Pablo Neira Ayuso <pablo@netf=
ilter.org> wrote:
> > > >=20
> > > > From: Jozsef Kadlecsik <kadlec@netfilter.org>
> > > >=20
> > > > The patch "netfilter: ipset: fix race condition between swap/destro=
y
> > > > and kernel side add/del/test", commit 28628fa9 fixes a race conditi=
on.
> > > > But the synchronize_rcu() added to the swap function unnecessarily =
slows
> > > > it down: it can safely be moved to destroy and use call_rcu() inste=
ad.
> > > > Thus we can get back the same performance and preventing the race c=
ondition
> > > > at the same time.
> > >=20
> > > ...
> > >=20
> > > >=20
> > > > @@ -2357,6 +2369,9 @@ ip_set_net_exit(struct net *net)
> > > >=20
> > > >         inst->is_deleted =3D true; /* flag for ip_set_nfnl_put */
> > > >=20
> > > > +       /* Wait for call_rcu() in destroy */
> > > > +       rcu_barrier();
> > > > +
> > > >         nfnl_lock(NFNL_SUBSYS_IPSET);
> > > >         for (i =3D 0; i < inst->ip_set_max; i++) {
> > > >                 set =3D ip_set(inst, i);
> > > > --
> > > > 2.30.2
> > > >=20
> > >=20
> > > If I am reading this right, time for netns dismantles will increase,
> > > even for netns not using ipset
> > >=20
> > > If there is no other option, please convert "struct pernet_operations
> > > ip_set_net_ops".exit to an exit_batch() handler,
> > > to at least have a factorized  rcu_barrier();
> >=20
> > You are right, the call to rcu_barrier() can safely be moved to
> > ip_set_fini(). I'm going to prepare a new version of the patch.
> >=20
> > Thanks for catching it.
>=20
> I do not want to hold the series, your fix can be built as another
> patch on top of this one.

Given the timing, if we merge this series as is, it could go very soon
into Linus' tree. I think it would be better to avoid introducing known
regressions there.=C2=A0

Any strong opinions vs holding this series until the problems are
fixed? Likely a new PR will be required.

Thanks,

Paolo


