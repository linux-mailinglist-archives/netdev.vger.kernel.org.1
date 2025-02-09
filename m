Return-Path: <netdev+bounces-164465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17E4A2DDA3
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 13:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FE5188740D
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87AC1CCB40;
	Sun,  9 Feb 2025 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlFxqHM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345B13D28F
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739104042; cv=none; b=sb4gw9m4LShHi2oiVK3oS9kK3qH95gZSBmk82DHsoiHuRuohBMMmhUbHj4QpI0Al9DkdcMtIUOt+I51vxSZBUnOcJKfd2e3BTGTtpYALPNiaMPsqCKQ8MhMpqHaoYmPX6TD09JUtzxmcj8jBfMOcI20Ech7K0wx9tvZa6XWOIjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739104042; c=relaxed/simple;
	bh=E9gKBFdyLEywmq4SoPqWCF85XLRR29CXjhxqRejXufU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BT7TINdLndOTjOrMfMuoh4600HD3ZuBw1a9RLGDTCHzSr9HX3RAu3CfQ3jGhGu43GvWJnRmvNOWHk/2Pu50XjTT0/droxaRrwJNKyOrO28z3TE5ycyLG1lRtE6HsaJc7OzDn+9WyDDCigzyjICcp1QktjVynv4yrVLtbw85WsQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlFxqHM2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dcdb56c9d3so5579532a12.0
        for <netdev@vger.kernel.org>; Sun, 09 Feb 2025 04:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739104039; x=1739708839; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/Q0g45wO/Vm5iLpg41l4hJpa4Tg12cuaqUPd3vVcdI=;
        b=IlFxqHM2/HkEQhHwoiDPH3IJSUCpJ4WfHx2/ikr17L1rN4gDqwwLfQU0yk4Vgz7gbY
         OJ9lp5K6ac++ngdRaERIPjcuIfU+kQEays0ObUtPGj0oRtacS9p1XZKaw3OV6To3osiM
         Fz7MCp9lB8LQAZIbC5ZXyTruXjyLKvhMTr1ab+CYsLYl6KWHgnjZPmirEre9f4ikd8FH
         kJAQexfGPfGsZt8F9W4ye8GeGkT3jdJb9U1sFi/zNGtNvoTb2gNBy2y9eS0c1nCOSIJH
         HnijNbZDco+4OzmWmNIknZAEnrvD9Sh5RITDmE+ESOQHm9YweOvvM67PUEzQCA8yU5oS
         pedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739104039; x=1739708839;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/Q0g45wO/Vm5iLpg41l4hJpa4Tg12cuaqUPd3vVcdI=;
        b=gnO4o8j+8D0/KtN3Nf/vVhvjvayAEBDvgqqyAwAWyZ8CUdpZRUcBySo7HIlb5AnjZX
         vc9By2hnKKhwWobmtutQLm6kTEQM+J1pbq24VSyg0uy8GsMKAcBm+qcj7oBhz0jxe07/
         ojyZRCnchuRqcacZV72EVa9QlTZXspaK+JStFkHD4JwBogbI4Bus1uNXP5IIBKsKtfQu
         3tWxXWtNI6t5tLO3/w4kT0sfQ3ItknD8Ch+SVYGZksxQatmHxTJl+TAfUXpmfNFYLMb5
         7h3IcLI6gx/Ue4JniXRRkQIwguArr+RAnNyryAlY8+nhWIYfz6kA+pTFpdwtl/gnEamq
         iWpQ==
X-Gm-Message-State: AOJu0YwyxWvUMNBnoj95jQBrO/OR0nvU0fqjxw4+2RhgHFMAHzms0h0c
	PktTwiFjPnqF+1H5iLbupZGLbGnMu1D4zlow1pubj7fb+7Rqw6Ew
X-Gm-Gg: ASbGncuZPpA2+r1yL3j4bAGchuHZvwRPs6eASVQrf/17+w3MRz92Nu/zT3wBOq+nIA6
	6avvKWSkXf1NwF0TeOf2ZK1anaZ5Nlf87jYamdN74YHNo2TPoTblZPNBWEOMdyteJtHWzZpyOOO
	0MZC1j4d17iatiqMeFjFJe/SQpREQI3plsOQDDKxoQNfAgWKqYkAYXucIwoGxk3Uip3XxY6C4Tw
	FbEtA3MVVFf1R4QPls0f+rkGn1vNCE6RzJMr0pKuGby7p/n4Dxz3kWLGuKIH4JRDXMHhti74Hj9
	TeyVVNy/xVHFkcuDNv7jzOpjQSz9WEJFLRhPLtWSLQAk7CbdxclBsJdlALHdr2QKsd1sgnIz27G
	nwivxSxtrgbUMJwYuhYAnOvYkAfslKokOxIIJoms7aKjgQbnqsqJ9wrn4VND3ysx5+KGLfd06Ad
	tFIGdIEWQ=
X-Google-Smtp-Source: AGHT+IEhfxVc23G9a45HCrUbZrYLCTwURq5kvHB3aPAZ0j7Kz+eR1B9m+52RTg+woKuLjm2dzMnWlw==
X-Received: by 2002:a05:6402:210e:b0:5dc:58c8:3154 with SMTP id 4fb4d7f45d1cf-5de450800a4mr29998512a12.28.1739104039232;
        Sun, 09 Feb 2025 04:27:19 -0800 (PST)
Received: from ?IPV6:2a02:3100:acf0:cb00:e533:c1d0:f45f:da1c? (dynamic-2a02-3100-acf0-cb00-e533-c1d0-f45f-da1c.310.pool.telefonica.de. [2a02:3100:acf0:cb00:e533:c1d0:f45f:da1c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab772f48882sm667378466b.19.2025.02.09.04.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 04:27:18 -0800 (PST)
Message-ID: <62e9429b-57e0-42ec-96a5-6a89553f441d@gmail.com>
Date: Sun, 9 Feb 2025 13:27:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: freescale: ucc_geth: remove unused
 PHY_INIT_TIMEOUT and PHY_CHANGE_TIME
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Both definitions are unused. Last users have been removed with:

1577ecef7666 ("netdev: Merge UCC and gianfar MDIO bus drivers")
728de4c927a3 ("ucc_geth: migrate ucc_geth to phylib")

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index 38789faae..84f92f638 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -890,8 +890,6 @@ struct ucc_geth_hardware_statistics {
 							   addresses */
 
 #define TX_TIMEOUT                              (1*HZ)
-#define PHY_INIT_TIMEOUT                        100000
-#define PHY_CHANGE_TIME                         2
 
 /* Fast Ethernet (10/100 Mbps) */
 #define UCC_GETH_URFS_INIT                      512	/* Rx virtual FIFO size
-- 
2.48.1


