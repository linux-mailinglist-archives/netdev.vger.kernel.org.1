Return-Path: <netdev+bounces-69270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CAD84A8D3
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B7A1F2FC8B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4C3527F;
	Mon,  5 Feb 2024 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1WZ88my"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B595B1E1
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170051; cv=none; b=VKSCo8f4w/JH36Grl5ZttdfkORrgQmri26DwWlqs6YLRbDEChMM0sFURwQxmN3qOpbKXa0hu1z6rVi6ZVc1f5P7Ii422H4TpC5Pjs2doPhxkbwo2xAbvdEqhwxs5u7fNvHQoIMqDijuhPoQuEegPmrS8UKjJdPeZH8WPwMGndU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170051; c=relaxed/simple;
	bh=2wyNoSeZ9lGIAJ0nHqhOljChbnjNYWPzPDWHB8xnZD0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=b2hw3rMZPwyautQsPMe/E2Y/Jp8CMl6D+xufSNGUXhzyL7dxtDO+8L8V8R7YoqttOV5OABnS032znon3Akb886R6JOEzyEDT1mzm/BayQENM5MPZ3MCzumz65j8OGvveTQw42UfZ/GHF8/5p45IvQ2Lm68HR7YFru5asr3lsDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1WZ88my; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so3541874a12.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 13:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707170048; x=1707774848; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYMxrs5wlTlCJWD1Pk8GH8HZEjzCXj8yCaLkoN/Baho=;
        b=k1WZ88my6wRFxWLRGaqU7m9M2qoP5Ha+lsc/e7d7LimLc9Sbxr5VFsev0H6CDqQ/df
         z7zWr6TEHGK0TCfu4gteBqJQGBS6zFZzKxTCiLBMOUJSxCTMK/6KM0nYe13YuKYPfBdy
         5bkBWEF3hS613/hbk32keOzH38EvIFn7XzPfgXyhPgfr6rzk9/DSiMIUHFe2TjTFqrG7
         lOySQ/Uvy7dVq9FlA2H9Gune+T78QeRDSaxh71DAygUM86C4T3p/RaAr4StqPU1H+bKA
         AIr/tDqKN1/dBbAV8ugcoGdI8iwoR9aoKQSVYSrndde2Z2sRbHB3kLJ83YST3CvCfxJr
         LkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170048; x=1707774848;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYMxrs5wlTlCJWD1Pk8GH8HZEjzCXj8yCaLkoN/Baho=;
        b=an2Xu2rlHmHyeBLudRnIPus9N01QcW8+02/WJtDCGuzgdrSrO9VzFjZcITHepcRWpu
         L0257Jy1RT8ZYBsQH6uf48rwChB1uQCIugSfkwLxwGYtkbfQg3liQR84cmjXSI9arPDj
         bty99LWNLTi52kOgFElIO1lLnCpdzNl+9GtTK9LmDa2CJ29ZDldlyXoai7+Ba+jSLWSN
         TVph5D2u4bFks4udbXGGaIXuoRM2g3zniYwGQlxBaHFccyeIv7H2iBJHtQx8fsYsxCXl
         ebUVBCnqALs2H3HAJbnOaQ61DFZexSOMG62bCMUcMJ4EdwqAnCrmXd+jft8enRUfpjPz
         3muQ==
X-Gm-Message-State: AOJu0YyhLyZymZjj/hEfRC8x1rsQr426BOOV0GiNx2O3CPJw5Al5lkEh
	FquBRKSlYwWPvycd3MNinHeefBIwetV5ImJXlpR5feSyGSZNrf+b
X-Google-Smtp-Source: AGHT+IFqIAChmSZBPzkWvkgqbgiSsFlCZbMX6k51dGV9R6ZR1wKNOTV2DzKkUMWavZr+RCe0ZMig9w==
X-Received: by 2002:aa7:d050:0:b0:55f:d670:9f36 with SMTP id n16-20020aa7d050000000b0055fd6709f36mr235578edo.27.1707170047378;
        Mon, 05 Feb 2024 13:54:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpggcC2+gm73WnQt/62p2k+qszPhxrmDhmLwvM4R+Lnee2Ne091Gr5spwKPiCAzTuwTm+UmWqf2pzFQEd3T1xFvU0qCrqnleQfs5KNITnN/l2Xyi2vI6pCVYMRqzsO6IrcudTaN+qO402SkQm/sijWdT2XXTx5oZUP/1Uo
Received: from ?IPV6:2a01:c22:73fe:ef00:8df8:55eb:9537:b97d? (dynamic-2a01-0c22-73fe-ef00-8df8-55eb-9537-b97d.c22.pool.telefonica.de. [2a01:c22:73fe:ef00:8df8:55eb:9537:b97d])
        by smtp.googlemail.com with ESMTPSA id c1-20020aa7df01000000b005606b3d835fsm331154edy.50.2024.02.05.13.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 13:54:06 -0800 (PST)
Message-ID: <3a9cd1a1-40ad-487d-8b1e-6bf255419232@gmail.com>
Date: Mon, 5 Feb 2024 22:54:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove setting LED default trigger, this is
 done by LED core now
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After 1c75c424bd43 ("leds: class: If no default trigger is given, make
hw_control trigger the default trigger") this line isn't needed any
longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_leds.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
index 007d077ed..f082bd7d6 100644
--- a/drivers/net/ethernet/realtek/r8169_leds.c
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -129,7 +129,6 @@ static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
 
 	r8169_get_led_name(tp, index, led_name, LED_MAX_NAME_SIZE);
 	led_cdev->name = led_name;
-	led_cdev->default_trigger = "netdev";
 	led_cdev->hw_control_trigger = "netdev";
 	led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
 	led_cdev->hw_control_is_supported = rtl8168_led_hw_control_is_supported;
-- 
2.43.0


