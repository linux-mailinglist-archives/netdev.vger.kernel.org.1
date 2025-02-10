Return-Path: <netdev+bounces-164690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76227A2EB74
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B2F3A3C6A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE601E1A20;
	Mon, 10 Feb 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DYGNwCzt"
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B011E4110
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187426; cv=none; b=MolqbXgLgVISmLuppPQZrJZrQLLVlpzZeiAOQERnWdnZI2rFnkCn1MSiyxyiCWzKydfJTi4/QYItCowRR7cIZLsOgRtN1xJJV4CqgHzpa4RTWf1bhnOioNa7KCPN9IbyHYXoqnZKksaogTqLPTFq1ZaQesDWlcko0JaDALCLd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187426; c=relaxed/simple;
	bh=iwjlzWWb4j42o4N5gBeh6yth4Qn7dlK5hrzog2qb5tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UplAJeYoSTaaM7nXu0cdgF2C+FqN9lDxCYq5BzbzfQiTP62VBMbCIVInmR0kc87yaVM5+SsqAhT08whOIwxAoDaBmGS/yh1/x0rh6hmtVp9ru6mE1Vi5F63TnqzLstLDBIkeVTt343YGsq8x+Hom1cWgmh5pUu3/FOLq6iaBjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DYGNwCzt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=lBjfgugfgAto5I
	/jSWQhEbQKNqUboP7NBqO+waDrghw=; b=DYGNwCztWpfE0kWXeUdZt1lKRJLPpZ
	ofdmIbj6QUlPbqvBZ4JDNRdK7PxcmkEXk5ZANPF5LmwQQNYCJK1a65WS4QMelV+S
	U8BD0P7ujYrInTNy2T4QvQSmT+HmT9CLBY3DF5wWdEWiGKpifkwmll2979/6SNhw
	wEgfTcZwpjUahnzFsf76GRoDHLP7UofF3IoQyPSDHTv55CoSTcZ2OMFsXW61mRsH
	QF/STGiN2/Gf0wIP6npNX2pQcn5EidRvi4jp6QvxCu1Z6G2z+sd3/MegFVxjDCRx
	68FIHbAEYxCi9Cpvgbmzgip3Dq58V6Cxf0DXjJz9216OeyjzNJMU91cQ==
Received: (qmail 802486 invoked from network); 10 Feb 2025 12:37:02 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Feb 2025 12:37:02 +0100
X-UD-Smtp-Session: l3s3148p1@TEGBIMgt2MNehh99
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH RESEND] net: phy: broadcom: don't include '<linux/pm_wakeup.h>' directly
Date: Mon, 10 Feb 2025 12:36:59 +0100
Message-ID: <20250210113658.52019-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via '<linux/(platform_)?device.h>'. Replace the include accordingly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/broadcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 22edb7e4c1a1..13e43fee1906 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -16,7 +16,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/phy.h>
-#include <linux/pm_wakeup.h>
+#include <linux/device.h>
 #include <linux/brcmphy.h>
 #include <linux/of.h>
 #include <linux/interrupt.h>
-- 
2.45.2


