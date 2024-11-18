Return-Path: <netdev+bounces-145760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB59D0A4A
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9217280FE0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7B196C9C;
	Mon, 18 Nov 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="bAgzxkIA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260D1946DA
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915000; cv=none; b=ALXdncCJWHJbsl3dTFGm8YERjybKHyYwPo7doHXI8xEcf6N3HeJNo3mVeGlLanSMlFS9VvraHBR5igdswz0X1lEW/RiffsrP0fl5hMudyy1SjRyc3+aq17LP1RZaWqTDZRE5Qb1PIIeINl1mUAZ1J8uEEU8CzWlqFMM+lM61TL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915000; c=relaxed/simple;
	bh=d61pyvr9pJx3za2OmQBCSQeX1hFLCfyTEKq8mTGQBKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hg0Sd5ZMqXtH44O+8qV/9zQY6AwKGf3+b5NfVPtX7uMgUSAuD3dO6UHtraYOEzJ0rOXLQGmpLmAaZdWWuuPmPMQTx7/9ItjsHdOkbhEkqbuW3vCRUWaekowOS4pugQhFBXPYNFgIjnoLTOkjonY/wvTliOgbIeAy6c7nRXkOnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=bAgzxkIA; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=VR+CAEN8pxbCcmFzLXZ5IDr4DL+PJgQOT9bL2ruog/c=; b=bAgzxk
	IAj6jtuM/w7j1l9AtfZZ2onTodlUySSDSvYKGOLHR1U35D+kTnQpYF7sLwDaZJQn
	MB4U80ortCWDzaIZEJofopaTNSVOm/dBbXY/F/kFuX2sMit1h7NR26oU3HY+Ze9S
	VZPcxggvbaS7hfEGTCM1xXPrxWodPm9O3DIs/KY6uEA+WJYFs69SwEIzkJRMjo+t
	WdGXl1fxsynbJLZst1MNbRCG7tmyp/QcoeaE8KaFJ1wiMLs537Bz+ZPyn6Z05+gN
	TEjkWDzUb8otfBbcyG+adUyJjX55AHncOEiWGGwWhWQhcXjB0Og3+nzM+dwUuN4H
	gw/kytzXH6g621+Q==
Received: (qmail 112513 invoked from network); 18 Nov 2024 08:29:41 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:41 +0100
X-UD-Smtp-Session: l3s3148p1@x4I64SonGNYujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 10/15] net: wwan: t7xx: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:09 +0100
Message-Id: <20241118072917.3853-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e556e5bd49ab..5ce169461c7b 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -32,7 +32,6 @@
 #include <linux/pci.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
-#include <linux/pm_wakeup.h>
 #include <linux/spinlock.h>
 
 #include "t7xx_mhccif.h"
-- 
2.39.2


