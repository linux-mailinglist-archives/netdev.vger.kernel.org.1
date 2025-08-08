Return-Path: <netdev+bounces-212268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA35B1EE3D
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E4A7A2BF1
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8A01F1317;
	Fri,  8 Aug 2025 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5FTgaYR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3B1DA3D;
	Fri,  8 Aug 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676518; cv=none; b=SjMR8ynHzvjBk9jL251tNFZriDoadrApYEDSLja2LAcHSza7PIS9tj7Dmms3BzX69mxtRmRz5SVSd0aCOJW6d54lRV6g7AD4ySsk3oJBgJNEKJbbCiaV0oGZc35AngEkw28ygqWuZ9LDmzkyfEvI0T+PT1N2Yf0WKSXx+EnSMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676518; c=relaxed/simple;
	bh=WoRcyAvFtefQJKPJN5K901aNTzk7WtDxvV5PyRrDmtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCJhXzlNZmEbotUcEoP344E4nP9+ojr5HNtuj+GZhzOUp7YdKCHPQPJYouTyNiwfP6rucU90a5y5mFBwvrPfcD8DaK9ag6O4IXNXM9rCnEhOo30TJEm6m8PW4QdPC/tf7/mEtFi7clczYKDGgEsF2JmQVcG6cfJNt9a+Kqxy1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5FTgaYR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso15995355e9.0;
        Fri, 08 Aug 2025 11:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754676515; x=1755281315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsQUh3v0djwd+KvEMTd0ddcYvhAfqpwCDe1nN241KeI=;
        b=H5FTgaYR9F6MsdY8H5ra1Qe05ps3k2MCZRNY+OYaZaPgbRcNzxKmplJDrL0CP4I07m
         QMmy+aX0H16By0KgDU44P0pEBeh7TZgErB3+Zgz1lRhIuHjq4wTkSYEjFKIvlfnkaUfv
         uBCZ/+sQNPj1aPYmwe79DOF5TWvfkTpgnE93eiethDsyZia3x6tG8Y2VQztXMKqiRaUo
         ZywEfSbdnjdQtgWuXWAbdeXjXYJ7YTyEMr8zt0185MSWb9SfoUyQ8J2KUnfZGOw4KO5+
         50KGwiEyRD4Kr8Ch1xTZg6l7tWPt/g+BFtG88XR8JM5h1+z4M8DWPiUliWnhh+ahcHYu
         2Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754676515; x=1755281315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsQUh3v0djwd+KvEMTd0ddcYvhAfqpwCDe1nN241KeI=;
        b=Klk7Y4003lRfcRqtqcGiHlYb5rQEF59oNJoW+BVquB2PfpTcwXpkhNsvKU6pd+lN1L
         d+fQ0ieca6NDcm2pu2mMmNqdyaOjt8tTcFzT+Vz6aL8gjL7Tx7bkJXFIsezBfdj7chTn
         8okTEGt944uYdd2nPTNuKA8ncanWNL3aqYoxbu9D1obmytI/U06flX5WITDhv9Tmcvvx
         fcozWYK4wmojRI9lbGrM4aKKb0QmTBMc/BDkdP326BvJBy2N+Otis2sNDi7olUP3GiEf
         Ou/bqIJhUorfbqam3XSKLbe2xNSEozOyIwOIfkHMItcnFZZ4Hd5/80I57F5gb4VVcfQH
         UXUg==
X-Forwarded-Encrypted: i=1; AJvYcCWKIPBqi3FaOzhnrhWSgf06iNDZXGQPu0fKON/2GbwbvzR+ELX8NnBydmp3YJt3/Iof5ZvCReYOhUwbECU=@vger.kernel.org, AJvYcCWl1/uHjRUrJtohkneTxRZYrI0riteLy2O6CTX19jSOulv/YAyq5JL5DfBCtpXmHtY7d/2xv3Rc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2leM4s81g0RJFe0epQO9Ta/OUuGxkRpQmqF3Q7prAOOYvThR0
	/5q4nicVNSuySgcUCn8/ni2UuBO4tgxDMqai9IDEEQ8g7dqrofmttverE6PPXw==
X-Gm-Gg: ASbGncsgMz1exhDnJuXSygKB4BLVOxkP15/XkzECek2rWFShXCDeH0lgSeFVf7FyWns
	cPISPhyHUWj38Ta/pNKDbgQ8VjIsv9lVAEjCumXp+5DkhBXzYWvCQdlC/3TVMhHb8XzxMTa5IR6
	TLqm/P5ZSCIcQvUfVBAh198cM5/qFKzblGT4MVGpKn1R4VTgBC+adyotID01O39gPE5pMnxjGOl
	aaHJp50pxnyrhhtI0vBbDZLtT8gkOQ/o81Q7Eb+aYpobHC1J4wEmgMVoPL1u250wpQwK/sk7BjF
	q+XblD3s+uI6rabm27DXq/ahzgfB/Exl2hmHHdNw9xWNGWA2fNWiaKPOGgz4pdIcNDNPnFxU2G5
	wDzjLyXhoDvA4GO5R7/Qg1+gi7A==
X-Google-Smtp-Source: AGHT+IEfIksgKYWk/jodFqlDcl1ZPcJbdWnBTog22+QajfLte78zJ5WcFpMGDMVlV7lr9Pz09n1wqw==
X-Received: by 2002:a05:600c:474f:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-459f4fc32fbmr41578095e9.30.1754676514889;
        Fri, 08 Aug 2025 11:08:34 -0700 (PDT)
Received: from [192.168.0.2] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5868fd7sm157169535e9.18.2025.08.08.11.08.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 11:08:34 -0700 (PDT)
Message-ID: <046fee31-07ac-4967-ba6f-bb0266ea9982@gmail.com>
Date: Fri, 8 Aug 2025 21:08:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Mark Intel WWAN IOSM driver as orphaned
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <20250808174505.C9FF434F@davehans-spike.ostc.intel.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20250808174505.C9FF434F@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 20:45, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> This maintainer's email no longer works. Remove it from MAINTAINERS.
> 
> I've been unable to locate a new maintainer for this at Intel. Mark
> the driver as Orphaned.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org

Unfortunately, this looks true. Thank you, Dave, for taking care of this.

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

