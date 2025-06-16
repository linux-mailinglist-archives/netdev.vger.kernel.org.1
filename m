Return-Path: <netdev+bounces-198275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FCADBBE6
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1C53AE6EA
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5F720F085;
	Mon, 16 Jun 2025 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ/3TqWr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731BC136349
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750109034; cv=none; b=Z2lheNelTEZ8XfVq31Lf1uumQAlcMkyZwS5os3hbBdM846oEHUlYCEpYH4HbcVwSHWABQhFQUqXfuL+hPVmvhsR/7fJAs2uuP+eL7xYoSzKEdyTgXPixUY9t+TTZO3jTa/IXNiHzOP9WLYf6fK2t9eeEMFl4f4RNgPM3VkgQyTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750109034; c=relaxed/simple;
	bh=BEfeQkfzemjsG4c0rfeh9+WMRLslVBqRWDAdMt28o/Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IxOgeROm4JQHh70lTrkSj4E8uIeDq4Qofai5RTn6SzxpYuxnHJ5rsWRMvdrJn5RBIrS32EB9w2QJlxvQ3WmtHul0Afclh75Q7HAs/pWErI/kVqd45bBaMrQA5Ww1jMpOR39pqFh8K+831vZBbJZMvwHBjXNZRlH6nNOZMi2zsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ/3TqWr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso1638694f8f.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750109031; x=1750713831; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ziW1DSedPnjkZgyJYjxAHOApjnIl0vtU3HI8Gc7Yr0M=;
        b=IJ/3TqWrLNVfI2X9LxRFZuWG6WvLO5XekFl3s44QvsdD0Cpr1adlFBo+x4mtfgFGD5
         0jGhNkUL+qwF4QVECPZyDLhtkcqYUzxj0kncxFQ7KOP7vJOtlrroevAismXHp0arg7+0
         d3q43audjpVvcmhU9GgKtXgJYcGhDVc6048V/e441ireJiDNcRgN0qSuAC0YYbNoDN/O
         1k9fDSlrVNEv+7+SX4QqPMgbqcchB1EKmXsSfWWSGVClZRhujl/PWgt08iWZv5e6hjbr
         BQt116XCbjY0KzyKzwUskx2xnbwGUzoXOi/71BDARsMxeWdm+w3tBLNGi73qh6wCLlK+
         9Tlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750109031; x=1750713831;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziW1DSedPnjkZgyJYjxAHOApjnIl0vtU3HI8Gc7Yr0M=;
        b=eIofYaoVml/TxW9r7aJX1YrE1Q7TePJcEf3rzkjBGiXftQGtGjsEO7a3xqjd1S+t0U
         ow0oj/wkhLJrhvZgqJLscoDHXpV4WwHhcMmUY5p3D6PzmIhSiwuOQkvWnTxH99nbn+db
         6f1Gam+6OZQSAhs1FIqMtkP5l9gkDZLK8q3TkVxRt0gA+F1r94Po3uPLB2AKvA+XziYz
         FBtt0F+3coLih53PWgRJ82ScwXJEiA/6YmI8KM97q/f3EDQMfV3s1noUT8+xB1mk4gq3
         5ewqHY4kPqoJtasaaR8qbUdavqTYjC2hbg6QNmCLPlhCxy8Tm9QcwFMpSNkMlQ7O/3s5
         Khdg==
X-Gm-Message-State: AOJu0Yw9X/HocZT4//ugyVVhYYxkDcIU/2i/+YRchfXeyjsSZEJJkqcP
	bi2y7TaOytUMX6LVKjFFdzFGhF0saV5JBY3XpfdGkQRpt9soQr3yaqoW
X-Gm-Gg: ASbGncs0hDKPNuTCWoV4gySHQb19hLMl9UF/TLVgzuE4Pg8pTpifxjP13e0AF0vkdvD
	3sVnTuhojsEVh5cL2XTw8fUgZbHlzLpFOYa4uiH9j4GHKz4M8TSyCL+FQTr05vYRRobDjYHqBg0
	a3oYpnPOSUftRZy7RpBlmj+jF5lipFUeqoKPzYGCV493yv8sqEzvqhOtVjCtwwHPbu9x9jDqqd5
	BNDC1zbc2iXHnF+mxaX/mBGja7giiOicKBXEUkldrAp5bYnwj5It4oV//Ar81UZoEtQGTtgnMbB
	fps93NxeJwJfL/7Zd3+379QjyurGeN3oKt7jCQMfuL3Hy5wQEeQ8PQqfCtepK3atbqyZLsw9Dex
	OIXcxA8XpsWqufEslfH9QdUGDj2Edj8kUhCjiILNfZX92XfP8ZwJE+mk65sf/Xk0gDeO+w9+C/E
	gV1n5S6okSP2OiV7Ujn5/iXB8=
X-Google-Smtp-Source: AGHT+IFt/0I9JfeN1Kh/sh2ILDmCFybL5Es+txoEXVhFZqCi9QF2Ie2Po1V/mEZWhb19oGWjNCTFeQ==
X-Received: by 2002:a05:6000:290b:b0:3a5:2e84:cc7b with SMTP id ffacd0b85a97d-3a57238b7f2mr8525405f8f.11.1750109030390;
        Mon, 16 Jun 2025 14:23:50 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4e:1600:59de:3cc:3fa9:3c6b? (p200300ea8f4e160059de03cc3fa93c6b.dip0.t-ipconnect.de. [2003:ea:8f4e:1600:59de:3cc:3fa9:3c6b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568a54d7fsm12219746f8f.18.2025.06.16.14.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 14:23:50 -0700 (PDT)
Message-ID: <7eb189b3-d5fd-4be6-8517-a66671a4e4e3@gmail.com>
Date: Mon, 16 Jun 2025 23:24:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] dpaa_eth: don't use fixed_phy_change_carrier
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Joakim Tjernlund <joakim.tjernlund@infinera.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This effectively reverts 6e8b0ff1ba4c ("dpaa_eth: Add change_carrier()
for Fixed PHYs"). Usage of fixed_phy_change_carrier() requires that
fixed_phy_register() has been called before, directly or indirectly.
And that's not the case in this driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 23c23cca2..3edc8d142 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -28,7 +28,6 @@
 #include <linux/percpu.h>
 #include <linux/dma-mapping.h>
 #include <linux/sort.h>
-#include <linux/phy_fixed.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <soc/fsl/bman.h>
@@ -3150,7 +3149,6 @@ static const struct net_device_ops dpaa_ops = {
 	.ndo_stop = dpaa_eth_stop,
 	.ndo_tx_timeout = dpaa_tx_timeout,
 	.ndo_get_stats64 = dpaa_get_stats64,
-	.ndo_change_carrier = fixed_phy_change_carrier,
 	.ndo_set_mac_address = dpaa_set_mac_address,
 	.ndo_validate_addr = eth_validate_addr,
 	.ndo_set_rx_mode = dpaa_set_rx_mode,
-- 
2.49.0




