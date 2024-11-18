Return-Path: <netdev+bounces-145759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8111B9D0A4C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474FE280F95
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D161F194A53;
	Mon, 18 Nov 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="BNYKDxgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594D192D80
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914998; cv=none; b=A6J8cejx/kNgWNc+43qECY2Y2fHHnEFLMG2P5ixppiQKZN9M5XfTRpuDiWqIPSr0uXe4KgpBTjrutWO892rHSXvil4FqXxDLd/JeMErSNEXCWy0w0Ex+ItWm22ub8FeglojpIVy+r20EICm4naN9S7o4wyO4k+tewfJt7ibB0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914998; c=relaxed/simple;
	bh=uQ1T56TYuNCOPZ5PR+UdSX4hgLyYi4afMVp3XFbzVuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r6gYcr6JXIj4MYCuUftolEXVbRAgHZvqcOy8DpoanYZ+5BatmEBXZ3Tw+PrndWVJki46fFZAd/Bdxe4jvmGyqEOHyl63f+ZB6FMWFEbjDVG/6m1sHxiPwA/nT0sdOko6iVci2HLjwDU3GHG9RgIjFk+d1o0pOXzCGc0bnYKBJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=BNYKDxgs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=y0XyrUg96ZZS1QFaM8OqueFKIMml64CiZTHIvthrgck=; b=BNYKDx
	gsMAswLoKsC0QXpufXq4uOF+/g0Tf8+7LUFcXOVpGU8CX6QqgCsH3gCsPriFib5N
	dTbxRxWzUL+hFyIOnV9iTAGrv3IPNkzDztoMmoMm40OWHfI2BOouZhXBpSbigZcY
	NxcJi9Uj1h60p3THa1H+9it+4bq9YFclhm6qozLERoJD/VjjMz2dIRmFosqy04qJ
	gsql8xqOPNfK+XEQlU/yJnBj7LvhFn3YAefyWQLZqM50SbKyxF8WoeHlzpN8UMWD
	pPoBWxnvlklRrlwuabLnDJewLxiNWyPDwxmQe/ItMkWIk0zDMh2DE7Y9wwgfv4sc
	Z1qc119oU/9B4nWA==
Received: (qmail 112494 invoked from network); 18 Nov 2024 08:29:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:40 +0100
X-UD-Smtp-Session: l3s3148p1@79ow4SonDNYujntT
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
Subject: [PATCH 09/15] net: phy: broadcom: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:08 +0100
Message-Id: <20241118072917.3853-10-wsa+renesas@sang-engineering.com>
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
 drivers/net/phy/broadcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index ddded162c44c..5b55137c9d55 100644
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
2.39.2


