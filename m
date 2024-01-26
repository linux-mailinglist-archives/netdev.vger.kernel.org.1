Return-Path: <netdev+bounces-66142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D383D8F7
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 12:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA82B3AD70
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336817BBB;
	Fri, 26 Jan 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2opWXVp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834551006
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262823; cv=none; b=MFuFOQ/rSLjc/s4LJzsOtIPUy0cy1MAFLU7z3AK6lRzXJ0PoIPpiDSpYkwKTswKDO5ZK0ERSunfSvkBDXVeS+3dWlhMpKJxPvsZtlAzBDLYAUztVwZyv1Sc69PmXODC8zKTdPBua3KdpBouz3RjFHIf4l6aGEopIQcOdz5qmM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262823; c=relaxed/simple;
	bh=8Beg/GZD3NOgsphJ4h0Ay/3nnecCyIqKIgWBUUliB9A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brZ5Cq5DEjJHJBL6wS9A1hviTXyuYBOYfCjZN5XZho+OLPLoVaeSjihPO/KdJNjRCYoDYE5clcGmB0dq/E8ED1vm4tTQK8RpC3NBJ/mk5t1d8TcP090vrQ+TOg+oFpgFiQEDZBt0rezNccSdcSZRxOF+MfMD3PN6v19YLWO4koc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2opWXVp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706262821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tq7If854ckovFMW4ba/uZhxfAY6UAi/uFwIpsE5dy3Q=;
	b=V2opWXVpMwW2UxpnZ6O+BQ4eAbqNa0g/ZJMQvxk8BHxdTffZhdanceicVR/bu5MfZyp0ti
	EWYIcIFiBN6HWMYCidNw8+DrY/KTIsR6uvaJNyYBuzrvcN22MmXLkh547jc/+KctcjMmr9
	DUwomkornA6Yf8L6G1lou+IE/63Ga6o=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-X44wdb1FMHan5ntm_MgJMw-1; Fri, 26 Jan 2024 04:53:39 -0500
X-MC-Unique: X44wdb1FMHan5ntm_MgJMw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-51025c44076so43353e87.1
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706262818; x=1706867618;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq7If854ckovFMW4ba/uZhxfAY6UAi/uFwIpsE5dy3Q=;
        b=cMY6PvZY9OpT4uTbQ/vGCemBlc5eq/EqTb5eGRvDnsuZwHHxcSjkJtxTFdNM5f7c2r
         DoSKes+wZuDoYnpjIXyMLWgoSeJBZ41euRYIeh2XPCOh9kQIP4Wcl5f0HvwLC2hPGEUh
         aCsERPIMGdQSUMPaeZMKlvNycGs0mduVjSqIVWovtn1T/lXhU331JggFsDSgzQ5zWaMk
         NEfWYF8UGNharo98x0HFMJDlU4E2mACYB65XG7hbChVJ+UnpOgqIxhGX23hIcgCCE3zX
         K+aV3Ms3rSV9LrReu/YUBufALFKam6eyCE+AFwYuTeEFX8r/Cuu9uPcfnGHj1kpR57bI
         joYw==
X-Gm-Message-State: AOJu0Yx1E/UJzy5QaXwHepdeSyVm5xao5cFukXIMxtVnySq+kj0+vYLC
	uFEsWfLi5SoXAdpUjmU64TZBwjWZChhEAI+NJ6fn4OGso7QHAOhlRLsQCdmDfDzWnln3s6of9LC
	uBda3azlVQPvPIvK2C3flwMDD1HF4PoOmeTbnMb58P1kj8izYpCBGTZhmINR1Hw==
X-Received: by 2002:a19:910c:0:b0:510:544:792 with SMTP id t12-20020a19910c000000b0051005440792mr1487171lfd.0.1706262817878;
        Fri, 26 Jan 2024 01:53:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGawM3XAMzPd555Z3AeHDwlygdttxmSyYn/Pr3NyGvEwDEf4DPuBAUhrHaOT88R03Dsm2o54A==
X-Received: by 2002:a19:910c:0:b0:510:544:792 with SMTP id t12-20020a19910c000000b0051005440792mr1487153lfd.0.1706262817507;
        Fri, 26 Jan 2024 01:53:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-68.dyn.eolo.it. [146.241.246.68])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b0040ecea22794sm1337797wmq.45.2024.01.26.01.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:53:37 -0800 (PST)
Message-ID: <b73a2b50ca75de97bd4f1693969b485498b506f6.camel@redhat.com>
Subject: Re: [PATCH net-next 1/4] selftests/net/forwarding: add slowwait
 functions
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, Przemek Kitszel
	 <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,  Liang Li <liali@redhat.com>
Date: Fri, 26 Jan 2024 10:53:35 +0100
In-Reply-To: <ZbN5uAeqEKJth5Jv@Laptop-X1>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
	 <20240124095814.1882509-2-liuhangbin@gmail.com>
	 <31c8afe0-86fe-4b39-ba7d-a26d157972c9@intel.com>
	 <ZbN5uAeqEKJth5Jv@Laptop-X1>
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

On Fri, 2024-01-26 at 17:22 +0800, Hangbin Liu wrote:
> On Wed, Jan 24, 2024 at 02:25:57PM +0100, Przemek Kitszel wrote:
> >=20
> > > +			echo -n "$out"
> > > +			return 0
> > > +		fi
> > > +
> > > +		local current_time=3D"$(date -u +%s)"
> > > +		if ((current_time - start_time > timeout)); then
> > > +			echo -n "$out"
> > > +			return 1
> > > +		fi
> > > +
> > > +		sleep 1
> >=20
> > I see that `sleep 1` is simplest correct impl, but it's tempting to
> > suggest exponential back-off, perhaps with saturation at 15
> >=20
> > (but then you will have to cap last sleep to don't exceed timeout by
> > more than 1).
>=20
> Do you mean sleep longer when cmd exec failed? I'm not sure if it's a goo=
d
> idea as the caller still wants to return ASAP when cmd exec succeeds.

I think exponential backoff is not needed here: we don't care about=20
minimizing the CPU usage overhead, and there should not be 'collision'
issues.

Instead I *think* you could use a smaller sleep, e.g.

	sleep 0.1

and hopefully reduce the latency even further.

Cheers,

Paolo



