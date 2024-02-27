Return-Path: <netdev+bounces-75226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D8868B4D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95FD2872DE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845B131748;
	Tue, 27 Feb 2024 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJGHmv43"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ECA130E48
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024029; cv=none; b=tl9c8OaIx/Ek4U1Jf82D4/E1MbMf3O1nV6E3wFduTNw3kZo2LwzrSS50tvNZU7OESXYd2ira4Am4HtOPE1mgRmies8E7syMYw1EyA+bYHv5uMeVxK4HirYep3NztU6EIWteZNYcgKJ7PboeU2BiapDhPgVt4c+ttxvYVg6dCeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024029; c=relaxed/simple;
	bh=VxZgwU1rUdVEih6OXI6fuKRKAbb8uvMl0V3+UAnCOHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7gxfoSml5ejeu+MN0ByKbbPKKsoBohANWcEH1qSbNV0Wlw52ZpFtRdg4/a+PIcWHau8rtgefGBBWJ5TwQsUcmImf4IQCASAXpKN3PQi4EsuHlGBtLvDJyPMSUOD2SH8BP5lL8JKMma8BUwYKWnrIt4FfAVsdAMpx9Pkt+WfOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJGHmv43; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709024027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VxZgwU1rUdVEih6OXI6fuKRKAbb8uvMl0V3+UAnCOHo=;
	b=NJGHmv43WVkY1CgbEr3ozBfgf8/I1SmqM2e0drLU3J2/tjML18ELaRjmgrIA/nFMXhcoKe
	nMF9fsY2MPVA2rGfwzP5fpXTas2k/fqnQxI/gFlNquuKX2DoXhIAWpm20HWTd5hAYzU3eH
	wokY7uxkaOqAY6Xyq/GVmLmTLyUnbzM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-yJpeav-tMQ6lpGNqBwOpAA-1; Tue, 27 Feb 2024 03:53:45 -0500
X-MC-Unique: yJpeav-tMQ6lpGNqBwOpAA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d283054eabso3491571fa.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 00:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024024; x=1709628824;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxZgwU1rUdVEih6OXI6fuKRKAbb8uvMl0V3+UAnCOHo=;
        b=Vkr6/6QHEGMOsVE/ePnMriGYTvlZnWNgjZKR5/uMw7IO9W2kOCuZAcGEOSlzVQkzzX
         w2+VenHrSPtppA6Nmyi5nmm8s+BaPUjsmcnn1Obk7rK5V4lGem5kvbYAUru4gHPpObgd
         TJdJD16e/Yg636GHEFnj4a/3cFtoB5BWCpXz7J0zII9sARRZCPgehTmw2mO+aG4mJ+f7
         aA9XcXoOQxbeo5A5BhkLoqcWwazEZIb3uajf5eTY8sXIo3zY7doYbSE/unKMW+eCtPQE
         Ze9p3OezSXzgZSz1kt2Fo6s3iZU8S85pcUvBh3Wimd4lrEA+qqtxY+v/GeM+9oz6nlxq
         Kclg==
X-Gm-Message-State: AOJu0YzWJDa2vGnf3GT5lPqy0g8h45c7LrkDi+ST+NGxcCY7qr2+ctoB
	bmeD/+441GECnsr8VKQvUT72wtifsRqBQj6FlqXsWOjFWppYPuApaiHYCRNcEZEEpQ+suXcLVER
	d2e6Ee62GYjZSBho75SGW8xxK+51R8+U+8v+k2+6W7HyeTDeeHtxujg==
X-Received: by 2002:a05:6512:3681:b0:512:ec76:629c with SMTP id d1-20020a056512368100b00512ec76629cmr4075926lfs.1.1709024024500;
        Tue, 27 Feb 2024 00:53:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVa5Cal4GolLlGdfZGDRlIUTA3hLpjXsGKcayO9UvyT/xTZSMaczC/Ik8MvFXNOEASLEvT1w==
X-Received: by 2002:a05:6512:3681:b0:512:ec76:629c with SMTP id d1-20020a056512368100b00512ec76629cmr4075918lfs.1.1709024024128;
        Tue, 27 Feb 2024 00:53:44 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id hg26-20020a05600c539a00b0041297d7e181sm10735730wmb.6.2024.02.27.00.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:53:43 -0800 (PST)
Message-ID: <8a5c0919075a964ae8ada94e5ee9e104917cbf67.camel@redhat.com>
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a
 test.
From: Paolo Abeni <pabeni@redhat.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, 
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 kuifeng@meta.com
Date: Tue, 27 Feb 2024 09:53:42 +0100
In-Reply-To: <bba650ea-54b1-45ea-a8b0-2b30f1af17c2@gmail.com>
References: <20240223081346.2052267-1-thinker.li@gmail.com>
	 <20240223182109.3cb573a2@kernel.org>
	 <bba650ea-54b1-45ea-a8b0-2b30f1af17c2@gmail.com>
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

On Fri, 2024-02-23 at 20:40 -0800, Kui-Feng Lee wrote:
>=20
> On 2/23/24 18:21, Jakub Kicinski wrote:
> > On Fri, 23 Feb 2024 00:13:46 -0800 Kui-Feng Lee wrote:
> > > Due to the slowness of the test environment
> >=20
> > Would be interesting if it's slowness, because it failed 2 times
> > on the debug runner but 5 times on the non-debug one. We'll see.
>=20
> The code was landed on Feb 12, 2024.
> It is actually 1 time with debug runner but 3 times on the non-debug=20
> one. 1 time with debug runner and 2 times with the non-debug runner=20
> happened in a 12 hours period.

The only failure in a debug run was causes by an unrelated issue:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/467362/7-fib-tests-s=
h/stdout

(grep for UBSAN)

Basically the problems happens quite sporadically only in "fast" env. I
think it's worthy a deeper investigation (it sounds like a race
somewhere).

I guess/hope then raising the number of temporary and permanent routes
created by the relevant test-case could help making the issue more
easily reproducible.

Thanks,

Paolo


