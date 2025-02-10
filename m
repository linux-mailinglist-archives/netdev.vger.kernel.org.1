Return-Path: <netdev+bounces-164922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C5A2FB03
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 21:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9E31885A41
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1C26460F;
	Mon, 10 Feb 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+xdI52h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4C5264609
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739220498; cv=none; b=Dc/VImA5jT6101oCWIpMx3GoAlzThffex2ALReqdhZ2kOfqeKMrdLyEv98pkwjTPh+zOCCvwAwcTPxXvn8Fbl6B2F+Y3ipqXos43TrKEuTgO11r6Jc75N8CfyADB9Jbt4ubjmrq9mplfEbnCptxPRmt8uYSBQ9fau3czEF9yAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739220498; c=relaxed/simple;
	bh=Jams4NuJMcu6hxctm+w4AFEDUnz4wmRU4ytw7mPxqE8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=EI/bwbUUtN2a0HOFxVBhlb56znhacL0zi+OPC5ys211SstOW6r7ED9o+0UrhOSVZmHnt47m/yzQLUf2VfPD8CfMnMdT4mmr6UQ/0mFiWvGB6hES5g/Ni3AGlvPV1k2E2Gx3L9SaH5E7WoSS/sUjzf/h8j9e7eT5jpgoqxz9aYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+xdI52h; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de4d3bbc76so6172743a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739220495; x=1739825295; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLw3SEwk5jKA5SlGlbe0Swmc6P6Pk3jdeJVP/PwmQLQ=;
        b=S+xdI52h2iloKxeZT5wjsuCaSLfyNttb217ho3RNJ/+eDTdW4Y54PztZfGxfAZXaII
         zXliRVhF7dsNqXSLPd+GAWy6Qp9U4LTBtJFJiviN2kJBSLlCD7szaKjfau4DgpBkINqJ
         YslW7UlJ132TGJ6qoMd14JAYPRg1VnR6NDHxKNMbf6xdbu6o+Wuq8iZK6rdqT2Taq6NS
         WqUKbymOYavUDKnfWfaZKWOAuxafa9ldlswBP/O0UJGae9RzjiUiJ/m4+VLbVWZx7YD0
         R4QVaOuLsGpqbPUgx1cvU40HMWCRAe06b8/wP9d0CPX6VWN6lBkVlqJqSwaNsXmad9aE
         2esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739220495; x=1739825295;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLw3SEwk5jKA5SlGlbe0Swmc6P6Pk3jdeJVP/PwmQLQ=;
        b=sbTxd739ftBL1c1z/tDbQegsWKGtfgZGhW4wTESHavLUzDKZHhIIJk0C+z0iTlmmuy
         O97bvEoAf5ykGbZPK1IcNWfUV9gHeABDj3+p4SojYoHxdeVmUK0iFi0vuddQai4SWaEn
         ywJi9vX4qEDnjosrpMZ1QutRCP/k5aiuDVLmSfuxaBwm4aVn7VNcLyQ9n593GdG89zu7
         8SML100ctj74/qbUfwXlfevIVc0uru4E11VNBTEqBnqshCwEu2Fq3OBI8ibFhubACIHD
         23Fp4q6UTqTTsRgj0OmQ0GQxezgAGSM4YYRnos9GyInMtp0TdjhXXRM0M6XiegT8DT51
         Yjlg==
X-Gm-Message-State: AOJu0YzlEjCZcKYuNf2jpn4HGiom20Ss++GU4XTbSxbCr8XyJO9K9f80
	sZcFZNmFe8zl6f5n/AXMyw8wSKFfEw05iiYQUFiBkS7C8UDdsxZi
X-Gm-Gg: ASbGncsWlsm04MMD6kr4y2RH6aeQ/ZHN7/dYahbuQJXDr0Ogxa4DmreGjOHrrWCtn4D
	AtsHaNUOS+1YO5znR+uRDH4g6i4E1Cly2G5fhBBqe63hC9kz9XxeIjOMhfpOgEj9KR8vsxskTut
	ur6mV4NZW+oZtgM5IJaaX4MugAm1ff7nBom4yCu1uJUpNMMEcE2ITZpfK7GCm4WCppxyOlyY8xA
	8LN3xn8KhXHdY+P0N+JfumqFnCEdbUsyzHRApysIeSjtahp7peRlYA57DJAdM7mbjGPvIGxEgNq
	Sl/N7wn0NWOWkbRIYgtSrl3sBQza1EVfd5y7Yhw8ROhH/JnfKwcgaFrd8RS/cgmzeE54niKGyFL
	5oi1AT7wDtE84C8aCfI+RV7+WriV2UZQaBffgfewM8OctM44xtsyYTXpV/7TG4skZw+xDR9PY2J
	IJfVP0
X-Google-Smtp-Source: AGHT+IHcQPoKLG6A7oNNZNwYFnGjxoLukMiD8SIExaxXLgdSiM8MGfTD1IBDsAQ57P1qpNUFDeYQkw==
X-Received: by 2002:a05:6402:5290:b0:5cf:e9d6:cc8a with SMTP id 4fb4d7f45d1cf-5de4507350emr13972453a12.20.1739220495175;
        Mon, 10 Feb 2025 12:48:15 -0800 (PST)
Received: from ?IPV6:2a02:3100:af5b:5100:3572:f08a:34f2:f31? (dynamic-2a02-3100-af5b-5100-3572-f08a-34f2-0f31.310.pool.telefonica.de. [2a02:3100:af5b:5100:3572:f08a:34f2:f31])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5de5d484c76sm5423047a12.35.2025.02.10.12.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 12:48:14 -0800 (PST)
Message-ID: <d7924d4e-49b0-4182-831f-73c558d4425e@gmail.com>
Date: Mon, 10 Feb 2025 21:48:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: rename eee_broken_mode
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

eee_broken_mode is used also if an EEE mode isn't actually broken
but e.g. not supported by MAC. So rename it.

This is split out from a bigger series that needs more rework.

Heiner Kallweit (2):
  net: phy: rename eee_broken_modes to eee_disabled_modes
  net: phy: rename phy_set_eee_broken to phy_disable_eee_mode

 drivers/net/ethernet/realtek/r8169_main.c |  6 +++---
 drivers/net/phy/phy-c45.c                 |  2 +-
 drivers/net/phy/phy-core.c                |  2 +-
 drivers/net/phy/phy_device.c              |  2 +-
 include/linux/phy.h                       | 12 ++++++------
 5 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.48.1


