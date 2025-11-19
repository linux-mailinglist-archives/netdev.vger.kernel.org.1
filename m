Return-Path: <netdev+bounces-239981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDC6C6EBA2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F9414F0FA9
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F430E855;
	Wed, 19 Nov 2025 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="OkjEXQMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF62BE7D7;
	Wed, 19 Nov 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557059; cv=none; b=UbrHaQrnbu1n7KL+APAagYA035kjUIIBXlowLbYR7BYchDQwGaodZGThVANdNfS9l4Cf3/LD5rJDWRTlV8zIbnFLO4CseoBxNNlPSFwvMYZq/IfBwapPCPFnMLDVsgjSw0soLwJsVEEBW9T/hIKtq8uVOsWtIF26NL99Fy8sdBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557059; c=relaxed/simple;
	bh=qer/MU4Xiqg2QsZiDCsJn7cY11mF+aGdA2s+ti6SlII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNIf8guQRJ4UfY8Z9x0Xw5rtfIE9CKpokxfswGt3f/c31+LJpBOnUy7+84CQyrKzgfvp3HCdN8pfsbiCFofWza6AOvDcauHY0368hEvBmSUtowNxjw7EDG3kUdAYhlbBTa1ANLgXAGxh/y+3hMqdbArOTEtxvv4lYGh8ITm3NCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=OkjEXQMS; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 254791484179;
	Wed, 19 Nov 2025 13:47:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1763556467; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WxOdph6OaEBkdz9E6b3zCLSSqZjvX0CCWefqIGHuD8c=;
	b=OkjEXQMSIA5tMhJcaDP4PznsrqPTpRd/eArfyM4RhVBHwJ+vna6LUr8Hd2NdNa12DebSkb
	gYHqSupgul5yCQyt+mvYyAYZUySs5fkXhkukfyGJYLyj/x1loxqdjORYaGKc7lsvxDLyCY
	YgzBRYie2+v5T9Inl0w3rjJmZe3uaP4yo20in/gVmwWSAS1dcifA0OXs0vs5lKtYOuq8Wb
	+0L/eH9tcTIZpGm+VeJShhfhRYYdA1LA67P1MUkAOIX+2Py0gV8YoLqthlmLV5+q77FeOB
	+SfMZhP2CG2bS0qkc92ZBA5W0AyFDTPZAuIojUW61A4Rr6cq2G3Q2l8scujhnQ==
From: Alexander Dahl <ada@thorsis.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] net: phy: adin1100: Fix software power-down ready condition
Date: Wed, 19 Nov 2025 13:47:36 +0100
Message-Id: <20251119124737.280939-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119124737.280939-1-ada@thorsis.com>
References: <20251119124737.280939-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Value CRSM_SFT_PD written to Software Power-Down Control Register
(CRSM_SFT_PD_CNTRL) is 0x01 and therefor different to value
CRSM_SFT_PD_RDY (0x02) read from System Status Register (CRSM_STAT) for
confirmation powerdown has been reached.

The condition could have only worked when disabling powerdown
(both 0x00), but never when enabling it (0x01 != 0x02).

Result is a timeout, like so:

    $ ifdown eth0
    macb f802c000.ethernet eth0: Link is Down
    ADIN1100 f802c000.ethernet-ffffffff:01: adin_set_powerdown_mode failed: -110
    ADIN1100 f802c000.ethernet-ffffffff:01: adin_set_powerdown_mode failed: -110

Fixes: 7eaf9132996a ("net: phy: adin1100: Add initial support for ADIN1100 industrial PHY")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/net/phy/adin1100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index bd7a47a903ac..10b796c2daee 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -201,7 +201,7 @@ static int adin_set_powerdown_mode(struct phy_device *phydev, bool en)
 		return ret;
 
 	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, ADIN_CRSM_STAT, ret,
-					 (ret & ADIN_CRSM_SFT_PD_RDY) == val,
+					 !!(ret & ADIN_CRSM_SFT_PD_RDY) == en,
 					 1000, 30000, true);
 }
 
-- 
2.39.5


