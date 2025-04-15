Return-Path: <netdev+bounces-182871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EC7A8A3A0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274C83AAB39
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140CB20ADE6;
	Tue, 15 Apr 2025 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gK7VuYa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC328F5E
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733178; cv=none; b=b7nvo8ENTBwx/hQfTBrsNlZiCT2W6gPQAzPnnTyVwf7JqDPNJzIxGSo/CSKbp5kCfLVyyYoWavYbWPVvgp63SfOawhECAa6PyohstbIVWrdXzIynzDrLwB78heI32pGQbE6meALFl9q4IP8ADQTn7Me8r47trsqe5LtZbYEQGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733178; c=relaxed/simple;
	bh=hgZy3Bs5bZtFb1xBAHv8Wk2VAlSG2m8POnP/PmcT6P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQhgJd8y7+unsUOgm+gRMqckgf2BAMhVR18ADxA2BvaPh3JzhwpHT/8PJ3NItqFU/Zw9xQgpqwboBsC1sTJpeOmNAK3A2djGWR1i5Zp2mOlszetS0G4IvxYJLISXU3cyoYXb9rM8BBQJ+tsD7qsOSe7zSsbswNgvGWmCFexwYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gK7VuYa+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so62866125e9.2
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744733174; x=1745337974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgZy3Bs5bZtFb1xBAHv8Wk2VAlSG2m8POnP/PmcT6P4=;
        b=gK7VuYa+0pKQ4E+ZfumwQapOyIwoEcOhko7opvwZbU/Er5aCxvmq7iBYGbIEPX4SPC
         1BvVEmV1+UhbXR1Ug6ywIATZbmywzZevnBBorWljaBiM+9D/zdg0OkJ7ExY1/Egvc8p1
         CILBY+toPDLBEPrnUyjg2VJmjxe/g560NxNj1m3QwyPksABbpn09VbuxYrUq8lFJqjvQ
         ikAxo+nWZavShlEk2JCeND19P44mQPKLLiIA0biH/Vx+Z6KLOGXJAUSWf/r3XThgSB8Z
         26hPU9r7JHJUCPdbnjVeSk36G77uwdQDeA7+tTvs3BpRC/yjwi80bfkq0xRReExqT5YT
         ajfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744733174; x=1745337974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgZy3Bs5bZtFb1xBAHv8Wk2VAlSG2m8POnP/PmcT6P4=;
        b=wXLslngIdzEGeQC1N6sRcbl6LngttipzxkIMUIZxQDsW3h6SR373aOr2ezzIj3SV42
         HZ0XlIMRfYmA19uZBXSozM/YpHWC5ZdSeUuEL5Hdm9pvN+0Zfii3e5Ck30/idoEcUDoW
         /r7Pfw/5a4E70mu7fEAyDtlunXjXZ3dOhc8YJ3yB3a+uaDuU0lZaKLfdywCAruQFh4U8
         tDqmdMS5R6SziHPtvOBvckEWaqck2hFKthQVGyueN2Q5tI02u8dD2Br2H6gSCD7Md79q
         WbfrpKtWbe63XiK2L/ghVeGF0wdNrSJS1V/O2sAKOXZ1dJMzwgInmouAIbi3d/fF6fZH
         +Clg==
X-Forwarded-Encrypted: i=1; AJvYcCX2kPzTJvn4kIekp6pcmI5aYQpXNfPIXXpvIt2VJgjoqDDB3x019l5UslxbA3pZIGBzN6lb1KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbBEe3MXskcIDP8oNVMqS33af6Mg5OE5Gy0ddrRstUTrX7Sdo
	Z8NeXmHcotBW+1p8nitO6iieFi+4gqk5HEffS7cfqA97hpdUxPQyHOVbhLz+VtI=
X-Gm-Gg: ASbGnctaBVSAVViS9D4iPIwroKihTwFy7WpbESXJVFups2uvCFjY140nQ4ZgoDYdbu7
	vC2w/QYUwZHb2cEOR6Dk/A+Q9Up8UoaGFzFRsNNj1BxpY9ZrunZ/GPRCQyr68pt1UJ2953giuFw
	rJVYPPyfO4PziaL+HvBJ7QL7QqyJmRL7BVnJh+gSXBg+fvvS6KosH/SL6+meSSJuPy7rDsmOgu2
	AMrunAnTQlvH/ibGCsL9WC+JnttTKx3MuB8/W5bFJNWGCleQn5Hwp/1M59PS5EiE2i5U5XI5CCl
	icT9dA79fhxDX2fp+G5DfFf+ZrvVzHPUwjBtJfqT4cA=
X-Google-Smtp-Source: AGHT+IGTKkmP0oe0fauFieWns1mCFUH/1vQsWUwM+pO9VnG6/65IgNgDirpko2Yd+tXf8f74r72J5Q==
X-Received: by 2002:a05:600c:1e02:b0:43d:22d9:4b8e with SMTP id 5b1f17b1804b1-43f86e1f246mr49614045e9.10.1744733173992;
        Tue, 15 Apr 2025 09:06:13 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338db0dsm219073455e9.7.2025.04.15.09.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 09:06:13 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:06:11 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <zu5vvfmz2kfktu5tuedmcm5cpajt6dotkf72okrzxnyosbx7k7@kss7qnr4lenr>
References: <20250401115736.1046942-1-mkoutny@suse.com>
 <o4q7vxrdblnuoiqbiw6qvb52bg5kb33helpfynphbbgt4bjttq@7344qly6lv5f>
 <Z_52r_v9-3JUzDT7@calendula>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pqcmzdxhrghzvc3f"
Content-Disposition: inline
In-Reply-To: <Z_52r_v9-3JUzDT7@calendula>


--pqcmzdxhrghzvc3f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 0/3] netfilter: Make xt_cgroup independent from net_cls
MIME-Version: 1.0

On Tue, Apr 15, 2025 at 05:09:35PM +0200, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> I am going to apply 1/3 and 2/3 to nf-next.git

Thanks.

> I suggest, then, you follow up to cgroups tree to submit 3/3.

OK.

> 3/3 does not show up in my patchwork for some reason.

The reason is -- my invocation of get_maintainer.pl on the 3rd patch
excluded anything netdev. Sorry.

Michal

--pqcmzdxhrghzvc3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/6D8QAKCRAt3Wney77B
SdAMAQDdLxRxMCm8JCPMZyX9ZYadyzJ6nkt7nq78k1iLIvQDawD+ICbdnSZr7N2t
wIYe9I+drbFtQ44kwYWEDcKUdGL5wAs=
=zr9E
-----END PGP SIGNATURE-----

--pqcmzdxhrghzvc3f--

