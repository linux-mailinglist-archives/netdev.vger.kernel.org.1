Return-Path: <netdev+bounces-71260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851E0852D9C
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 11:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5F41F22070
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7FD24211;
	Tue, 13 Feb 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmvKw1gj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26E2BB0E
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819228; cv=none; b=IA9RiZBj3FDSlUfrzU9YgM3gSy6B5crCfDfvZRQgI9De7Tj7mB6kAgbWbDnEARRZNHLS1sRUw+EGteLvuLbIu1H8A80bwPie7yhBjhk/TUvR0m+NKxabAwnRB0/NvRfwWcfI3UM8qj8pXfgerWsD44dj/c71EkFyVincPj3OeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819228; c=relaxed/simple;
	bh=v/fFUdlreoGAMwezQEu4Ao8whLg7P/aH6MXbPoiKIno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvOPh3LDixFcyfUkEGNdXxiJ846QyfZglUCaW5vrzTxkV29r9TB0X1jL0pFY8RB4sagG2tWjHqPzc+G2hSfTDu4jXK57VF6rkrcWfjNEKNpQHZgaq0ntPj2pswW0EOIQmUJwg1DHi4QIjUHjivK6Cyjh/5LkAFM4gw+S1sysg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PmvKw1gj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707819225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T9JNjK37kEShPSWsTbFmjnhKfVAIRZeocmsRj7z3d2o=;
	b=PmvKw1gjA4bh6mIgUAIQdPQ2YSc7wYks5Bg7MDPWrs+l0weXOHj4RwALAw8u+ujQ/sbqFf
	/rzrYJGTlMoQlZ/p4U0WRE/vrDTH8wKK5tjRUyp8YDfnKcnjkaUvMBTj02OR28JoLMW5FJ
	nwt8CwOMftRv3k323ZBIU7MsGjMfuec=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-NnOQVEgdPKuSZrKNev8K0g-1; Tue, 13 Feb 2024 05:13:43 -0500
X-MC-Unique: NnOQVEgdPKuSZrKNev8K0g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78130939196so239672485a.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 02:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707819223; x=1708424023;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9JNjK37kEShPSWsTbFmjnhKfVAIRZeocmsRj7z3d2o=;
        b=LjxLEwYKZ/GWrnlWoq3O7rEb3EGtLjwjq5x7ye9eqTlsj4GOn1UY6069XHKq0YugXm
         POCrE9KWG28KORhTILIZGYXp4pn5psOcyJlPW8asJWHU/ShakXzEdp1MHvtOs0s2Q3H5
         ntcJhIvbu+evLXk5rKXqqJ7Zm1kgcz8D5M4YgibB+BRcwa+/Rvi1zbmhmryTJLmqsYwJ
         h2KZCWnrKpkG/XbV1ecnyNDkJbx89k1zDe4XIG+Ff2yLj9nxIbU3Y5NoNl7UpPJWzXXW
         FOcsEjxahZgZKsJJ6Jmkk6pmEdeaHO1JDc/dH8umWmsHWIm0kiYL+e/116TC0ueI/E/x
         jMXg==
X-Forwarded-Encrypted: i=1; AJvYcCXOrkYmzfAU5iLlqSAjKL0fb27DhJcMaooHq3Aldfw9bVuaqvtJCuangysMj11wbsqNQ1dQNZJeTJ/oKWHcxaR2V+S8Ubnh
X-Gm-Message-State: AOJu0YyJ59+e1Ld2CSgh0vY66zLwc2C24cAz9KLGNUdwpUE1TMHxeoMy
	kSs+4CLwnNiTPW4NwBtTQgAyRUhWMbJL+7yYGWAuqpvU0ZMYzlm9FgBtS34O66NoQxZvuJ1RH+N
	Fx5nWCqudAPHmuvw5DTC/Jm/Qd2i7pVOySyWkNKOyrx+dNWX3h4SekA==
X-Received: by 2002:a05:620a:26a2:b0:785:cb89:56e with SMTP id c34-20020a05620a26a200b00785cb89056emr9021022qkp.1.1707819222940;
        Tue, 13 Feb 2024 02:13:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2nHGTnYtIvzMYJCP7aD3ZfBOWw6PRl0KhmCmDmC03dTLKJXg4ImEXwotSMVeIT+Kn5ZQm4Q==
X-Received: by 2002:a05:620a:26a2:b0:785:cb89:56e with SMTP id c34-20020a05620a26a200b00785cb89056emr9021006qkp.1.1707819222609;
        Tue, 13 Feb 2024 02:13:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9O5fELLo5VHpM34ducb+lTNntK9qyTkFKeXiVakNFDKrs6DEIy3pd4yRY/CoSPwwLE3AX4MXU7GGgzUEBlU63HXF4rwQSm7ML7m3ZGvq7xJunRFchjN7c3SmWxyR690g8/ye3JZXBzvxpuNyhhNnLAgOtBaIwqeRNzzhTcEOzcntQAYthaapWl6k/OR8m5bCLjGV16ypSGotqg8zOFMUdgjKAsnqrfEgLoDZQl9UhhG3hYfhjvCeEgkc=
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id bm33-20020a05620a19a100b0078724351313sm6207qkb.36.2024.02.13.02.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 02:13:42 -0800 (PST)
Message-ID: <13efb9e14d378cf6ed81650f52fce21ce6faafe1.camel@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: ipv6/addrconf: clamp preferred_lft to
 the minimum required
From: Paolo Abeni <pabeni@redhat.com>
To: dsahern@kernel.org
Cc: edumazet@google.com, kuba@kernel.org, jikos@kernel.org, Alex Henrie
	 <alexhenrie24@gmail.com>, netdev@vger.kernel.org, dan@danm.net, 
	bagasdotme@gmail.com, davem@davemloft.net
Date: Tue, 13 Feb 2024 11:13:39 +0100
In-Reply-To: <20240209061035.3757-3-alexhenrie24@gmail.com>
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
	 <20240209061035.3757-3-alexhenrie24@gmail.com>
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

On Thu, 2024-02-08 at 23:10 -0700, Alex Henrie wrote:
> If the preferred lifetime was less than the minimum required lifetime,
> ipv6_create_tempaddr would error out without creating any new address.
> On my machine and network, this error happened immediately with the
> preferred lifetime set to 5 seconds or less, after a few minutes with
> the preferred lifetime set to 6 seconds, and not at all with the
> preferred lifetime set to 7 seconds. During my investigation, I found a
> Stack Exchange post from another person who seems to have had the same
> problem: They stopped getting new addresses if they lowered the
> preferred lifetime below 3 seconds, and they didn't really know why.
>=20
> The preferred lifetime is a preference, not a hard requirement. The
> kernel does not strictly forbid new connections on a deprecated address,
> nor does it guarantee that the address will be disposed of the instant
> its total valid lifetime expires. So rather than disable IPv6 privacy
> extensions altogether if the minimum required lifetime swells above the
> preferred lifetime, it is more in keeping with the user's intent to
> increase the temporary address's lifetime to the minimum necessary for
> the current network conditions.
>=20
> With these fixes, setting the preferred lifetime to 5 or 6 seconds "just
> works" because the extra fraction of a second is practically
> unnoticeable. It's even possible to reduce the time before deprecation
> to 1 or 2 seconds by setting /proc/sys/net/ipv6/conf/*/regen_min_advance
> and /proc/sys/net/ipv6/conf/*/dad_transmits to 0. I realize that that is
> a pretty niche use case, but I know at least one person who would gladly
> sacrifice performance and convenience to be sure that they are getting
> the maximum possible level of privacy.
>=20
> Link: https://serverfault.com/a/1031168/310447
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  net/ipv6/addrconf.c | 43 ++++++++++++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 0b78ffc101ef..8d3023e54822 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1347,6 +1347,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr=
 *ifp, bool block)
>  	unsigned long regen_advance;
>  	unsigned long now =3D jiffies;
>  	s32 cnf_temp_preferred_lft;
> +	u32 if_public_preferred_lft;

[only if a repost is needed for some other reason] please respect the
reverse x-mas tree above.

>  	struct inet6_ifaddr *ift;
>  	struct ifa6_config cfg;
>  	long max_desync_factor;
> @@ -1401,11 +1402,13 @@ static int ipv6_create_tempaddr(struct inet6_ifad=
dr *ifp, bool block)
>  		}
>  	}
> =20
> +	if_public_preferred_lft =3D ifp->prefered_lft;
> +
>  	memset(&cfg, 0, sizeof(cfg));
>  	cfg.valid_lft =3D min_t(__u32, ifp->valid_lft,
>  			      idev->cnf.temp_valid_lft + age);
>  	cfg.preferred_lft =3D cnf_temp_preferred_lft + age - idev->desync_facto=
r;
> -	cfg.preferred_lft =3D min_t(__u32, ifp->prefered_lft, cfg.preferred_lft=
);
> +	cfg.preferred_lft =3D min_t(__u32, if_public_preferred_lft, cfg.preferr=
ed_lft);
>  	cfg.preferred_lft =3D min_t(__u32, cfg.valid_lft, cfg.preferred_lft);
> =20
>  	cfg.plen =3D ifp->prefix_len;
> @@ -1414,19 +1417,41 @@ static int ipv6_create_tempaddr(struct inet6_ifad=
dr *ifp, bool block)
> =20
>  	write_unlock_bh(&idev->lock);
> =20
> -	/* A temporary address is created only if this calculated Preferred
> -	 * Lifetime is greater than REGEN_ADVANCE time units.  In particular,
> -	 * an implementation must not create a temporary address with a zero
> -	 * Preferred Lifetime.
> +	/* From RFC 4941:
> +	 *
> +	 *     A temporary address is created only if this calculated Preferred
> +	 *     Lifetime is greater than REGEN_ADVANCE time units.  In
> +	 *     particular, an implementation must not create a temporary addres=
s
> +	 *     with a zero Preferred Lifetime.
> +	 *
> +	 *     ...
> +	 *
> +	 *     When creating a temporary address, the lifetime values MUST be
> +	 *     derived from the corresponding prefix as follows:
> +	 *
> +	 *     ...
> +	 *
> +	 *     *  Its Preferred Lifetime is the lower of the Preferred Lifetime
> +	 *        of the public address or TEMP_PREFERRED_LIFETIME -
> +	 *        DESYNC_FACTOR.
> +	 *
> +	 * To comply with the RFC's requirements, clamp the preferred lifetime
> +	 * to a minimum of regen_advance, unless that would exceed valid_lft or
> +	 * ifp->prefered_lft.
> +	 *
>  	 * Use age calculation as in addrconf_verify to avoid unnecessary
>  	 * temporary addresses being generated.
>  	 */
>  	age =3D (now - tmp_tstamp + ADDRCONF_TIMER_FUZZ_MINUS) / HZ;
>  	if (cfg.preferred_lft <=3D regen_advance + age) {
> -		in6_ifa_put(ifp);
> -		in6_dev_put(idev);
> -		ret =3D -1;
> -		goto out;
> +		cfg.preferred_lft =3D regen_advance + age + 1;
> +		if (cfg.preferred_lft > cfg.valid_lft ||
> +		    cfg.preferred_lft > if_public_preferred_lft) {
> +			in6_ifa_put(ifp);
> +			in6_dev_put(idev);
> +			ret =3D -1;
> +			goto out;
> +		}
>  	}
> =20
>  	cfg.ifa_flags =3D IFA_F_TEMPORARY;

The above sounds reasonable to me, but I would appreciate a couple of
additional eyeballs on it. @David, could you please have a look?

Thanks,

Paolo


