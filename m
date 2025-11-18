Return-Path: <netdev+bounces-239341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25749C66FCE
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CFBB4E7E64
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3422FE054;
	Tue, 18 Nov 2025 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmgknfWF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7624DCE5
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431895; cv=none; b=LVbGiH2fStZ02XUaO5AVJ9YwBVPPDS/Hvd89GtDzyz0gSd48bnoUCy2dHrXmSaBqNt1ZowjFH98TELImh2sPb1jYf06chjGrf1OBCq7haWyAZ7rLgNOFe+6Z8VRH5fd4HeKrpkVh/fOKgpkw1gG+8a7hpZK8nUHIlFui8DyNwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431895; c=relaxed/simple;
	bh=gyY7WV1Wzxl043qvEn0hHsBdG2b2C70TUY7KApCszTw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XEVhMfFGWvxfYMfZdth7YzKhjQEGzJG9xMVJO37DiLB+iSXEyGKZsf0Jbdve1ccBVCcmZ3xwgaRquOd5KGNFmTzUHK35H7VvXtRpxHwhC4p+zI8CO/ubEXPTZOYWMRpwbUlcKrDqvCOEkgi1sg8YUYmro/DKXjUQaYhs/4TkgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmgknfWF; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e393c49f1so4028330d50.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763431893; x=1764036693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tv/ZgeiRPcv1LDz/7V5oxrd6Xuy+RZn3CBBx5mE8xY=;
        b=NmgknfWFoJTOkZCXtAPccx08Ehi+fhBzkvJ337Q3xbZwIgXKd0OGUSVcwm9G70IaAF
         ZxRIFnf4dc4tpluB1r2KCtmUYllyhOnojQTfKHx1q+mbUX28Y2Ca6RleqEJAhtSMln6M
         xZhp0E+FyISDwbdaQySOuCCw3eOH4X4ojNbhr1mKBgSc+fURq0iZJA/UksTRKKTTQ1fy
         ghFe8uF4ofIt/Y/4yZaJZRAz7M4KJFG+uEJnpbGcGGAdg1S/cmaMpKMoOb0fHcjL9zhW
         a4bOteQe9GV5LEXxTBvTTjPHfan0JXQGKD58EzaurB2ohxvbJ3IriAjuBpOL47+wKxKp
         mANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763431893; x=1764036693;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tv/ZgeiRPcv1LDz/7V5oxrd6Xuy+RZn3CBBx5mE8xY=;
        b=H3r2tjieybjYzr967wza/39lSgBr5qBLY18RWQf6GLrVcrTmghRUY8VR6HAF/9X5ld
         ESK03QFVy07jBs0n8TT3bbHzfg9+e2VZjtaM4/ajK4JyqhCsQ5d1haLXMSFI4N8wu2kK
         DG1P9yXFXJuQoWVB9tB2GyqY0Wq3UaIVUCiCwVvVXdoiOJ6BoN/x9omIcVlM0TL6ts5i
         Lbuhh9toG7UirDluIvJjidafk6U1+I1wqYubezwFuo+KfYF7/65YQQnt/rR3PEEBc7/6
         S3wehyJOFMa4tIqjBaW659H9SMPL+ugeuKTv0d/WTaU/oo3pWQDLxM0BviaxsV9qpgoI
         L7dA==
X-Gm-Message-State: AOJu0Yy+d/UhAmJ9ZpXPMwH5uueT9pEo+pMTQjvAyPa2Pu41O/JEIISY
	6IFkxIARu5M/r7FkKBQFeR6w4i1In4vrwNw2k6uHql9YG2WafuuTRSlz
X-Gm-Gg: ASbGncsc7pqd5AozrXCr3SNXiBgVAwT4Yf3rI4ztmJsB109yLiUzAMlzVJy6ln8lEnR
	HRp8dURxoArCXrMBR1OfBZMb/aUiXXhpeGIK7nBwLh1OX1IlHq+CJWe4osC4IFPyrMj+0inLarn
	3VQX2F9QJ8bbJvKIGFHkaPfQhE85Zcdq6+Y7zDKKJdeCxSLQNY4ScI6PltJjxI6VMUIkwSiW6c2
	dFgCobLERJ7HP88xDI5q3dpXiX4l50uaXK+AT3+323ICJnStdUhL1P9fxZ4JIvXvn5up4mXcsNg
	NsFungAmQ3Ld/LEgUj0w91u3qEEDo7B4WFNUI7KXNqFDuRaIy3fMmg/g1KwjNobghO7VNl86y4L
	7x+Lmdyz915bWkqRIzLw87zyVSZ0vZYXvKZP3pYBAuVPXiETi/KpqWFrQUoovuhHdSh9GMlh4hy
	v/zlWBbvW7TY9uyfWmXHy1fROCpjPekBDBfPpjV2DFUv5LQT5Km64opcKO
X-Google-Smtp-Source: AGHT+IGlyZXbpAc4FMrl63x+aCIc7nbnDZkFH9Gh+Dw2gNE8Pm1S5ViPDKo1zgyuxUCgQz/c4m19pw==
X-Received: by 2002:a05:690e:d86:b0:642:84a:7ba4 with SMTP id 956f58d0204a3-642084a7c6bmr3585674d50.85.1763431893027;
        Mon, 17 Nov 2025 18:11:33 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6410ea037besm5292626d50.9.2025.11.17.18.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 18:11:32 -0800 (PST)
Date: Mon, 17 Nov 2025 21:11:31 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 krakauer@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.31c286e47985d@gmail.com>
In-Reply-To: <20251117205810.1617533-1-kuba@kernel.org>
References: <20251117205810.1617533-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 00/12] selftests: drv-net: convert GRO and
 Toeplitz tests to work for drivers in NIPA
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
> Main objective of this series is to convert the gro.sh and toeplitz.sh
> tests to be "NIPA-compatible" - meaning make use of the Python env,
> which lets us run the tests against either netdevsim or a real device.
> 
> The tests seem to have been written with a different flow in mind.
> Namely they source different bash "setup" scripts depending on arguments
> passed to the test. While I have nothing against the use of bash and
> the overall architecture - the existing code needs quite a bit of work
> (don't assume MAC/IP addresses, support remote endpoint over SSH).
> If I'm the one fixing it, I'd rather convert them to our "simplistic"
> Python.
> 
> This series rewrites the tests in Python while addressing their
> shortcomings. The functionality of running the test over loopback
> on a real device is retained but with a different method of invocation
> (see the last patch).
> 
> Once again we are dealing with a script which run over a variety of
> protocols (combination of [ipv4, ipv6, ipip] x [tcp, udp]). The first
> 4 patches add support for test variants to our scripts. We use the
> term "variant" in the same sense as the C kselftest_harness.h -
> variant is just a set of static input arguments.
> 
> Note that neither GRO nor the Toeplitz test fully passes for me on
> any HW I have access to. But this is unrelated to the conversion.

You observed the same failures with the old and new tests? Are they
deterministic failures or flakes.

> This series is not making any real functional changes to the tests,
> it is limited to improving the "test harness" scripts.
> 
> Jakub Kicinski (12):
>   selftests: net: py: coding style improvements
>   selftests: net: py: extract the case generation logic
>   selftests: net: py: add test variants
>   selftests: drv-net: xdp: use variants for qstat tests
>   selftests: net: relocate gro and toeplitz tests to drivers/net
>   selftests: net: py: support ksft ready without wait
>   selftests: net: py: read ip link info about remote dev
>   netdevsim: pass packets thru GRO on Rx
>   selftests: drv-net: add a Python version of the GRO test
>   selftests: drv-net: hw: convert the Toeplitz test to Python
>   netdevsim: add loopback support
>   selftests: net: remove old setup_* scripts

Thanks for converting these tests!

No significant actionable comments, just a few trivial typos.

