Return-Path: <netdev+bounces-120507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C44959A46
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA7B1F2135A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9FA1C86E8;
	Wed, 21 Aug 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5b4TChp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE901B791F;
	Wed, 21 Aug 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238152; cv=none; b=noidBitPEmZBlTRhAtnX0cfm426jNbyP9SGPaCw3ZFfSk5YhvObE1zvQsqoUr4kySMMqM3UWkbHfi3AeZP9XvJBlmXwsVmUCqVaJD1AMEld2KduUboIdvwNXe/PMFD5jYZZH97Zbmh7tdOoRQflQnhn+KQD0gib6DKjr0IuR2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238152; c=relaxed/simple;
	bh=oL0apQfwO/GowPgbcjjEALNj9lR6lpp6lqvX9gU/D1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDp0Dtn3lwVGIe3kcuA21jw83waySnkDMy1RI9A4KbnGnlo71y5nuCRsXYphb1K9aYclDMco/OtlUIi9nGBMRPVeMIu+gaX0yioyCd6awztfd25POQhhhkiYwkoEpFFbvQN650yC5Rl8108FFqnmNV4M61VHJRV7eb+Rsthjcaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5b4TChp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53345dcd377so1925896e87.2;
        Wed, 21 Aug 2024 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724238149; x=1724842949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48VNhxHd3dlbgyZpDomEeFdSD/WONmnc2OyXHZjBz2M=;
        b=e5b4TChpuNqSBLVM6j150rHB1lsb50P5+jSSKLQh7NhlzYuJI3UkN+k7Z7B5zHAuat
         509x7DYyoh/N8wPdN4UrmDWTD7PlKTVhkU2ozWflVZHT3IlyB2BuVOqBZf3vRuFJi/SD
         vfL8RCGA9cMLcoY3QMbCyJaV5bgD9N4l47R9ljp0R6q1rEdEpDHVSLReWdeSX01xMGhn
         qi7CjYIFm8RKu+LaXHgyMY+vTu0xdRaIgfslHEgaLX4HUB5h99V9t/2Mpa2HkATgCrDD
         H2tZbAlhGj6RF0x3c6UAo2Xy2A5czNEKN7nbCBFxWuD+I8vJQqIQdtA/5kuO46l7ciM/
         3OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724238149; x=1724842949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48VNhxHd3dlbgyZpDomEeFdSD/WONmnc2OyXHZjBz2M=;
        b=DEvIFI5LJz8GnMacmsGa2TCiSHVCcepVA1bruJTUdtXSiW+9xr+T7TLQlbndMgHk5p
         sKEUvfmtmdYSxt8ByVTb9YSeD1LU8k+v7OA8Iz2/36HZfnDGHC2ACwBXyURR5CJI0NK0
         uLH9LgxY3CdnkTZpWEwXsOVwltvi7TZB9ztTKEdgzxF0VDVYv78kgatQRcTQvZaGdVuT
         bUjezj4aN0+83TNxAEDY7alqpKufhxRfuVHdMtGizfy8cWpiISAn+Pi/f9HcrPlPozqn
         nQjoQufuk2zTP10F2vfhx3My2Hbn8Ri2+dkBrEKFglhDvPwrGHzetuhYG64yJ/TLZW2n
         NikA==
X-Forwarded-Encrypted: i=1; AJvYcCULusbQBNVqjc/L/oSetk7BcE3dRpCySYdSELbek7uCyAZvhKVV2LFKI0Hm4xAj9AMSQ9meBpYV2RTk@vger.kernel.org, AJvYcCV2BZXh/SMTKalB6Vef07TGTCv4RWBTwX3LlSY3idfoH8JFwyvkdbf2+KAdVm6d6GFSgy1LcP/F@vger.kernel.org, AJvYcCXxvKoEUgRI1ymEVP/Q+qyt2PEbQXFls/LoSf78gFguvZZw2+avKOLAUyPxI1JRx89HMW4prdtK7AOEXhSX@vger.kernel.org
X-Gm-Message-State: AOJu0YykEWkP3pP7Z5MKg1Z4wjsv3p1j/QgmWFHER8kpICKGYgqUhoya
	qzzdMepCB7L0gxQeqiy2ZbPGdOsxaUkNkKteZkCd6XWXdBxpIsmd
X-Google-Smtp-Source: AGHT+IGxjlmlSKQ9/+92re/HMTFwZmWbjOWsLYGh2baVOkKFR23ifRgfEFcguTFqmpd+2iXPG8qUEg==
X-Received: by 2002:a05:6512:334f:b0:533:4b38:3983 with SMTP id 2adb3069b0e04-5334b383becmr194675e87.20.1724238148297;
        Wed, 21 Aug 2024 04:02:28 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394647esm890970566b.147.2024.08.21.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:02:27 -0700 (PDT)
From: vtpieter@gmail.com
To: pabeni@redhat.com
Cc: Tristram.Ha@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	f.fainelli@gmail.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	olteanv@gmail.com,
	robh@kernel.org,
	woojung.huh@microchip.com
Subject: [PATCH net-next v4 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864 switch support
Date: Wed, 21 Aug 2024 13:02:26 +0200
Message-ID: <20240821110226.1899167-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <584ce622-2acf-4b6f-94e0-17ed38a491b6@redhat.com>
References: <584ce622-2acf-4b6f-94e0-17ed38a491b6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tristram,

> @@ -325,7 +327,7 @@ void ksz8_r_mib_pkt(struct ksz_device *dev, int port, u16 addr,
>
>  void ksz8_freeze_mib(struct ksz_device *dev, int port, bool freeze)
>  {
> -	if (ksz_is_ksz88x3(dev))
> +	if (ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev))

Small comment, would it not be more clear and consistent to introduce
a new ksz_is_ksz88xx function in ksz_common.h, being ksz_is_ksz88x3 ||
ksz_is_8895_family?

That would help with the renamed ksz88x3_dev_ops that you will
encounter when rebasing. In fact, seeing your additions here, I would
propose to rename this struct to ksz88xx_dev_ops.

Cheers, Pieter

