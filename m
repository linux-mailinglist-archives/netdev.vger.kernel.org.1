Return-Path: <netdev+bounces-220096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70DB44748
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC37547B16
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D7B27FB2F;
	Thu,  4 Sep 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWnUNe3P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32022253F05
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017613; cv=none; b=Xu5JrYyaIhcKBpfjpmtjrjhSpgdbjFVbb4YMftMWkdHFlZLDxVhAc8Y3SHTdeZT+sNmKZpTiJ68eDrSxfJrVvBeWHwv9Pwa6i8KEmxER++R5dji7JdllxmBZ32D6hQUHMkTojvqe93UqN0cqA6odzuAJxCyq2bQOTwMIhgqcQOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017613; c=relaxed/simple;
	bh=3jq8gL/8fyYI5NeZhwgKmkK68YhvLRKew9hlZyeKQY0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uGJlQxcSc814jo/L9ggnEz2pV9EGYjx/uji56ApRRHQrIKAobsGwKH9XrBDJU3uVSzDiBtSK+qaP3Xun+aTrM/Xa0O66NVX3O3oRBL2Ajv+6Xd8ob8nSobPQHvXrBHzHJMynJN/+LU8lh1mYoNnrSSfr9/oPb8+wfuvY6AmtfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWnUNe3P; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cb4370e7bso2298345a12.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757017610; x=1757622410; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj1/FkTqsYqqeLVCG7Zj4aMYuIelgGiltbJZ37u+yO8=;
        b=JWnUNe3PXNLg4QmsK3Wqa+V/IOuDwWD3I9+n6faQr+B6rJjJO5rETOeximnPKRQUv2
         A6W9VpnvcthB/FWXj4zUPwZxxeHTWBO8+B5QitUx2Uy1EW/0t8SrupeOGhRfp1B7HSXK
         QYO59WJkxUemRWeLbbVZ8nPWFG34fRa+81DdvY1Ktuyw2JjdIYM5mBFDAdm2F2p+f8Oc
         YifoUGc/bOO+n4p+LU5jxVNRPpAn0TV0OD9LR79vq/UwvqMTzJJEsfKQ9k9tzMsLCRTj
         aDRaOmUqSGTL7Hws4eUxLZfP5nCe7FjQUphTkastqMFL2Koqrnl9qmlhyK0QFZHuYm0c
         1U+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017610; x=1757622410;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj1/FkTqsYqqeLVCG7Zj4aMYuIelgGiltbJZ37u+yO8=;
        b=ExYlLsse8NBzwE99Cv5UjuW2KMgpwN8Yf5VVZQ2RKePbtlZQJzfCg1PF7Jzw/6S/Eo
         QW4HyWcBAzMEwJVOrGGhfSXURs1TlWTs/RuhbOzOECwfu7g0GxwqQioC7TWXYROWRyaY
         dSZFY/cTAn82ndeiTOGaicKZVg6sojKB3mxVnKg4yow6l7CCPTPvAaryuLm4nudPAU37
         s7/vnn1ske7x2VEcV0gcqG8wOmYzjI7Iw8BVUz1uOy4zsS9TsZhlw/R9gOeGEGBgCVdN
         uZDolZcJsNYYIjrJjkCuh/kqUeJjfVGyWDMHWU6KTKxmWMMwtmrddk6eEDamIaRbEupi
         1Ohg==
X-Gm-Message-State: AOJu0YzMdKT5/RIKhddQHUD70eMZPBv/Iy9EJJhI82TqmzWx0Nny1MNm
	NPRfBWPb+n9+Unl5k1cC4dqjFXU6nr0RxIf3J0QLeUtySmy34mLP8xz8
X-Gm-Gg: ASbGnctE+5pvNzueK1N5EA3aP67JHPlr1dN2Yp8OGs3Rf1WxAWRJe5qq4qlzOlnOaue
	wpoV0p0tUH93CroNHbx+JzwB4nUmq06QrtJGNTTcr66ICbT0O9M5Xy7LjPc/Cpsyhl8oHy8g8nJ
	O6Y0cv7SNZYm1trkPV+85C6eNF2S9gFdbAgHef1V7tK+ctbxH3WWLDa2UB9nymmhvfKL3FfJoDg
	VLkN3tV34SWRG5KlYXD57fGLkWhDWLaBjzTDwquZNKQrRqfPGpZcGpWEQNoNOZL8aM6JSzlgiYx
	/pYqcjLN+J/E2EYnlg+T8G39NzyFHxxSsBPGPbmnu4kICFubAHhMld5aeldbM08HkAJ4Ygt0fhN
	EhIpo/1yF7B7i9Bq9iKDmW4teJDNEufOMITNBSN02Plu9xK0I2qS2dxxgIETveOMGaaMpIh/MvW
	mSHhXuT3dTKN7pAP8w+pNjqRYsGWkZK4+w1hxZ3jATvUkm6smuWV5CcZy2/2k=
X-Google-Smtp-Source: AGHT+IGWrFQvO26dzDyD2KGz6U7WqGvUsZdl+fHLhxUE7zuYXU19t0INNLZk1bsqfv1rYVgJUZhTYw==
X-Received: by 2002:a17:907:3d16:b0:afe:8bee:fdb9 with SMTP id a640c23a62f3a-b01d8c99b67mr1991054366b.28.1757017610260;
        Thu, 04 Sep 2025 13:26:50 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1f:b00:e9b7:b4fa:46b1:7dfd? (p200300ea8f1f0b00e9b7b4fa46b17dfd.dip0.t-ipconnect.de. [2003:ea:8f1f:b00:e9b7:b4fa:46b1:7dfd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b041f6fb232sm1213984066b.87.2025.09.04.13.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 13:26:49 -0700 (PDT)
Message-ID: <a6c502bc-1736-4bab-98dc-7e194d490c19@gmail.com>
Date: Thu, 4 Sep 2025 22:26:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Madalin Bucur <madalin.bucur@nxp.com>,
 Sean Anderson <sean.anderson@seco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: fman: clean up included headers
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Both headers aren't used in this source code file.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/freescale/fman/mac.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index a39fcea6a..f27ff625f 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -14,8 +14,6 @@
 #include <linux/device.h>
 #include <linux/phy.h>
 #include <linux/netdevice.h>
-#include <linux/phy_fixed.h>
-#include <linux/phylink.h>
 #include <linux/etherdevice.h>
 #include <linux/libfdt_env.h>
 #include <linux/platform_device.h>
-- 
2.51.0


