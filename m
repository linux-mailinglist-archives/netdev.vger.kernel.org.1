Return-Path: <netdev+bounces-164691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83737A2EB72
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104AF188CE65
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7D71E47C7;
	Mon, 10 Feb 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="B82ZamFc"
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE231E3DDB
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187437; cv=none; b=BBP/jU2zOFPzi/00bFJ3MWzTHO99kDEXsnVrdWdaYHMtUu6F7VUQjGWweoscxWmj+ZKGCH8UyndUGYUyoXiohxXi+6i5eJta4KMWgdok6S5MrE75EtrKtLTP++w9EpKT5Mq28hZrvf70ugLK/pVNx9s/6so3K9fgbe3gOXb3jKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187437; c=relaxed/simple;
	bh=dj16zRWTqQPCmO/IMt/Qf5Rbz5jWnudMaUWiRMPX2zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8Yt0805LcDzox2TRhbY2kPIKmTh0lyLJx8E6K++VjEYx44A8M5JOW3UtgFDwaJWl6dEhu9pCaJvDO5CqQ8q76UYDoePgkynNUCCdesnPRVFQxxW0Evo2BaPOWmdQ9fK1qOf0YBuqz9BBdwywju9KkPRYK/02uP/N/QWzJL0XJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=B82ZamFc; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=b47nZ9piEfV1rD
	Sj/fw9EJJHVA2NEGkk2xnU2LdxNHo=; b=B82ZamFcjfSF4LPXsKtIz/ELwao5v+
	1PhTgkrnwPSWRMaWw5U6kIF617XcZV6prmPTJ51Jul2pkgKVAohIMk+zIrKACjU2
	F4o7yIRbtmyl4WT1am6lxYJ0qoaW6n6XmPdD4u7UgYxMTj+18pFs5Mt0talz9w6m
	1RuXppZgI5Y7UbSSGWCKupB7oWVWsbyhm0vyEZ4NO7OwEqDmJ0qXFa3G/bosH80R
	xMeacFOVDCQULb1857CbMqtfk6RF/X0yxRQPYK7Tl/CvCOaWmPLFWYeofmu0u3RB
	78Nkz9rbREjVSTkxUkqwf0SkX2Ac/6LeMftdMuC36Bjdwl48sDT3h1Zg==
Received: (qmail 802608 invoked from network); 10 Feb 2025 12:37:13 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Feb 2025 12:37:13 +0100
X-UD-Smtp-Session: l3s3148p1@Bm4mIcgtEIFehh99
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	Liu Haijun <haijun.liu@mediatek.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RESEND] net: wwan: t7xx: don't include '<linux/pm_wakeup.h>' directly
Date: Mon, 10 Feb 2025 12:37:11 +0100
Message-ID: <20250210113710.52071-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via '<linux/(platform_)?device.h>'. Which is already present, so
delete the superfluous include.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 02f2ec7cf4ce..8bf63f2dcbbf 100644
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
2.45.2


