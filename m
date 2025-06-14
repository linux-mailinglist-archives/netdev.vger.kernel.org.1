Return-Path: <netdev+bounces-197709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864C4AD99D9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 04:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB06189F95B
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC319CC3D;
	Sat, 14 Jun 2025 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XSTofRse"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110214A09C;
	Sat, 14 Jun 2025 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869907; cv=none; b=s3uUf6FLIOeXY3rIY+W18CLKdbPCma0ahvV6tYqSts5ylOqj3TM7/uUa5D187MbSMcqb5CuXrWCVwKIn1ylEFmAr9dutAFFcgRknRXUvLt+3kbwQwMqSD0bNyd0PdWfJHTenO5gFD3FTyDA67cR4UAr2kDBsnQTfWD62tk17U10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869907; c=relaxed/simple;
	bh=i3XeoiSRtE1Igjim+9QOgbmDEY2lJymcFPsUApI5d6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bxV8TVBd3kqjxKzLMSPnX+eDzH+WQ+JtOI2q9sI3MyafVB38u137jC2iqnuGmLlBbeEbfC/OePAkCliUootltSubgIRUaiRpHYrDIBJT61jnMUCggbX9PZbMgGv3xME3CdbkGY+HSNVBNKS87P+yT/eYOoUdg6rYw1vgt5OpmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XSTofRse; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3A8BFC00054C;
	Fri, 13 Jun 2025 19:58:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3A8BFC00054C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1749869899;
	bh=i3XeoiSRtE1Igjim+9QOgbmDEY2lJymcFPsUApI5d6I=;
	h=From:To:Cc:Subject:Date:From;
	b=XSTofRse2mupHr6vPQ4GhCaOSQDD5WhsKZZYst8kDjsAVWfM0S1udf3mWZ8xQwOaz
	 H7+ge9velb4/ltqJXLZkncUGfmtivxkLFk7E5fQ8ki6suFtWW1Aupq9QxZR5wKDWQ9
	 9tbrLt+BbKFaZkSBktihUESKhZ6wDjuknl806TcA=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 11F0418000530;
	Fri, 13 Jun 2025 19:58:19 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] net: bcmgenet: update PHY power down
Date: Fri, 13 Jun 2025 19:58:16 -0700
Message-ID: <20250614025817.3808354-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Doug Berger <opendmb@gmail.com>

The disable sequence in bcmgenet_phy_power_set() is updated to
match the inverse sequence and timing (and spacing) of the
enable sequence. This ensures that LEDs driven by the GENET IP
are disabled when the GPHY is powered down.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- use proper "From" email address for Doug

 drivers/net/ethernet/broadcom/genet/bcmmii.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index b6437ba7a2eb..573e8b279e52 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -169,10 +169,15 @@ void bcmgenet_phy_power_set(struct net_device *dev, bool enable)
 
 			reg &= ~EXT_GPHY_RESET;
 		} else {
+			reg |= EXT_GPHY_RESET;
+			bcmgenet_ext_writel(priv, reg, EXT_GPHY_CTRL);
+			mdelay(1);
+
 			reg |= EXT_CFG_IDDQ_BIAS | EXT_CFG_PWR_DOWN |
-			       EXT_GPHY_RESET | EXT_CFG_IDDQ_GLOBAL_PWR;
+			       EXT_CFG_IDDQ_GLOBAL_PWR;
 			bcmgenet_ext_writel(priv, reg, EXT_GPHY_CTRL);
 			mdelay(1);
+
 			reg |= EXT_CK25_DIS;
 		}
 		bcmgenet_ext_writel(priv, reg, EXT_GPHY_CTRL);
-- 
2.43.0


