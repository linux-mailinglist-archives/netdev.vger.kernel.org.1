Return-Path: <netdev+bounces-247908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FB0D0073A
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 01:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC333011759
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2071CD2C;
	Thu,  8 Jan 2026 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvgiW9Mg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A304317D
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767831597; cv=none; b=k7eca7qVce072mNcbqxiTlCoioMw47tw5LBtirnlDlgzajCIBdptkxXf88msuS5Lyb+RjXHH9N4WZero5P3PPnlw2zl+M84VSE0IN1tuzaYG6w27jNAv0QGdEpliUepJMGLVMmkJfnr2yIhBNUc25dz4UJZx8BYZiBjTEnLV+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767831597; c=relaxed/simple;
	bh=rJBPFvV9TvGFTU1hwUwktme9dmG32CVBy0pKMXdKkZ8=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oQYrlQArK+uI3krGjksPsfFhl5pajgeWRDq4KaG/C0HSnoaghoUFVpZHbp5ieA/dZ5ttlESaN5qGwJHs3RYqt59bNlgBahW+X7XolwNEMrbg+tGNa8CnJ92iBGBnEuokSIQQ+8RUJ3jn5e8/x/nvd29SNnFAMvGcn7YHZD+HGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvgiW9Mg; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78fb9a67b06so28712537b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 16:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767831595; x=1768436395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzfpvUKVDh30dQJeYHzqr99FhFp9YQnEB1OZNLwAWI8=;
        b=NvgiW9MgBaD4BnLMfb802YsSfP5xW+Td8B4Is/ECXeDmmt36cPu7Zdhw3OKaJOnz8u
         kZIjI95gAO6a79NK0KUsBWCoyAFStlP4QVeHx4jffb3ZnteDbAVxidXlcDAsfhCBIbEp
         C7ui7c6FXLVy4oyQDFYp7oYhnOhbPRX7W0IuCPAFaqnwgfGXE9+y4U1KiZSAntNnpUrf
         hwxkV34y3tzKGZ0uz/SJ1FrS6+sz7NKsq/q1Bb9sbEm7J4Q6GoKXpArkXCp+aHfDlJkL
         5gHgDKdL15TYE2doCw13Ep4qRyhwDX7yNAag5Dkea0QPIxTOqfiQxbZBqBGemHmDvq78
         Js8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767831595; x=1768436395;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzfpvUKVDh30dQJeYHzqr99FhFp9YQnEB1OZNLwAWI8=;
        b=bIh7tbJIKqfmqOoyDC44zqlLczYEFKynclW6V+jLBsjuEGSBTyCY5VCVN1yXggmys5
         HYnplcT1nrDr07+3SETlhQjWmJZ27kRsJ499wz3rcgCQaSNG8tusgAvde1mDJ5K9Iiay
         DOo3TwfnBoE9xyGYdGa6nPvZJeYIa6AKXVSvIpRaqlV9INazF+t7cHoPhHt+vO32kOZt
         idhHg8QOjGkBXTu8PBcaBmI18YkVadGVM7htaHANGTSE3Vi+zMl9dU2/X8Y5ahMK6hMw
         3Tqeeoanrr0ZeNYQQM8x4MxzoL9lFRLyCCW5BIQhL6FXQU35Wzw2IKe11kK4RVwF3Vk5
         Izyw==
X-Forwarded-Encrypted: i=1; AJvYcCUscGTDZ11xclWV22vh6dJ2fzo2CBg6XCA00PS8E2beqDIMSeb/XFYIv/SQikP46UydrJCQEfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ffn7WmCyjzHEb7XJORrNMusEgGrirvHrMIsOt576SbjSjYpv
	1/x/Pr0toppDJ2p51MW5TdhyyqbY1Cy/IPGBYALuOvy/6aSHLVACbtdi
X-Gm-Gg: AY/fxX6uaKSC/c3eMiBOm/cfEVidXrf99QGUxKxdLPQl1tv2gtVI3LAMuV2TOj//Hr/
	RfA48b+PmCAs6BlPDjnVLvIXFKP7fbBx6PfsdxP1WRJ8gWJSuNRncwIwndnJjtPLrVtAPQhrQ5C
	iKI0r8XUx0P5xqL3xoKJ28dfaF2qVpJ1Kj+b0cnUM/KrQAThA3X3NDO8nbIh3PR0cym7BzQQ5UL
	bl+Uub/zJFPStUTTCsS9jVyEXIOGWkS5Ihjo7cIQF+k1lO89LXaSkCyMWxQMHEvLYVsPLO+QFbZ
	dS15PgGuueEKb+XOEFFgWcj+TOOV3w1miD9aKCnDekus1bi3fFXqrLJqBmRAIp9Eu8fEQOwkzSD
	OxtrqCr1FDihAQIuNwf9bcaSbuCalpRIGGd3uOtlkjiJXJRvEkSbMu34Nz7R2D5L9/Erg5iccmf
	EfxDngD0ZzwZWLGzFw3NajDpHEYH7nKJ6/kdkwPew2AOLXoSEsLwZUO3TgBOk=
X-Google-Smtp-Source: AGHT+IF9knqaYC0nC7clPwfKpER0E3T+XpidK31VC+UjqOsUeEfbieG1uD+bLHc6x2kDkegj96FRFA==
X-Received: by 2002:a05:690e:1243:b0:63f:9979:2f9e with SMTP id 956f58d0204a3-64716b35d5dmr4096466d50.17.1767831594648;
        Wed, 07 Jan 2026 16:19:54 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa58afa3sm24075867b3.22.2026.01.07.16.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 16:19:54 -0800 (PST)
Date: Wed, 07 Jan 2026 19:19:53 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.276cd2b2b0063@gmail.com>
In-Reply-To: <20260107110521.1aab55e9@kernel.org>
References: <20260107110521.1aab55e9@kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Hi Willem!
> 
> We discussed instability of txtimestamp.sh in the past but it has
> gotten even worse after we migrated from AWS to netdev foundation
> machines. Possibly because it's different HW. Possibly because we
> now run much newer kernels (AWS Linux vs Fedora).
> 
> The test flakes a lot (we're talking about non-debug builds):
> https://netdev.bots.linux.dev/contest.html?test=txtimestamp-sh
> 
> I tried a few things. The VM threads (vCPU, not IO) are now all pinned
> to dedicated CPUs. I added this patch to avoid long idle periods:
> https://github.com/linux-netdev/testing/commit/d468f582c617adece2a576788746a09d91e91574
> 
> These both help a little bit, but w still get 10+ flakes a week.
> I believe you have access to netdev foundation machines so feel
> free to poke if you have cycles..

From a first look at the most recent 20 flakes 
(ignoring two unrelated sockaddr failures).

17 out of 20 happen in the first SND-USR calculation.
One representative example:

    # 7.11 [+0.00] test SND
    # 7.11 [+0.00]     USR: 1767443466 s 155019 us (seq=0, len=0)
    # 7.19 [+0.08] ERROR: 18600 us expected between 10000 and 18000
    # 7.19 [+0.00]     SND: 1767443466 s 173619 us (seq=0, len=10)  (USR +18599 us)
    # 7.20 [+0.00]     USR: 1767443466 s 243683 us (seq=0, len=0)
    # 7.27 [+0.07]     SND: 1767443466 s 253690 us (seq=1, len=10)  (USR +10006 us)
    # 7.27 [+0.00]     USR: 1767443466 s 323746 us (seq=0, len=0)
    # 7.35 [+0.08]     SND: 1767443466 s 333752 us (seq=2, len=10)  (USR +10006 us)
    # 7.35 [+0.00]     USR: 1767443466 s 403811 us (seq=0, len=0)
    # 7.43 [+0.08]     SND: 1767443466 s 413817 us (seq=3, len=10)  (USR +10006 us)
    # 7.43 [+0.00]     USR-SND: count=4, avg=12154 us, min=10006 us, max=18599 us

These are just outside the bounds of 18000. So increasing the
tolerance in txtimestamp.sh will probably mitigate them. All 17
would have passed with the following change.

-        local -r args="$@ -v 10000 -V 60000 -t 8000 -S 80000"
+        local -r args="$@ -v 10000 -V 60000 -t 8000 -S 100000"

Admittedly a hacky workaround that will only reduce the rate.

It's interesting that

- every time it is the first of the four measurements that fails.
- it never seems to occur for TCP sockets.

