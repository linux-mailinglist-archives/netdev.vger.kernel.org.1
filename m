Return-Path: <netdev+bounces-122871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3862962EBC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 19:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450F11F21A8A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD947F46;
	Wed, 28 Aug 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8pk8fXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087A36130;
	Wed, 28 Aug 2024 17:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867050; cv=none; b=VYdA2mlVP90Xt06Pow9Sv0eH5tFu6nTPUbu+rNOVd3LLy6BC+W55KogFemBhq8N+tSfqRZC7+3yj30Dy2kVJK9gXcp0FVL+fALvyDqiDAMnOmMGjpWmEjWNsk4Yiv17GNlpX3iYajAb3oz9BBMc7xJnjygvv5BrpiiSLdQ+W0pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867050; c=relaxed/simple;
	bh=HhYJ1Q+JW2O2E82gUkC4FDEG14SxIpf8BG2OWoLr240=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFjAN77qudqFFRbD/tfU7t+mIZ6cm1hrhcIkD0s4jdbYy3ecK/FH1cDEUjRUeSZDebkAxtX4Rfg0TsMvLXoxE6fbAPjo7ZaQC81Ogknx+StuQWdMln/g38+n2LX9aGjSFuSofZZHqsNGnV8/8AZXYxy0mR5c5VTEF+CtlLnQFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8pk8fXR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2023dd9b86aso55991695ad.1;
        Wed, 28 Aug 2024 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724867048; x=1725471848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxJv0j8wKqbtmeIVheEQj51qn9RSR7kYGGnN4GDdIuY=;
        b=Q8pk8fXR+P+wDZYoKkVgUBb0QeIeZcR1tmR003Rg6qcyVkkbdzW2Yy/BYvyiSnC9u7
         g6yZ7o+w9g81I/4/15m4gJOMqbiZ7xy1J1BRH+DOVQGiwlfU4DrofrPDVlEa3wKa8wwf
         b0StIvvY+6KMkcclk4jC0ufd0en0ugkiwOctA+vYM/9QNDX+dfhQOfBgq6tH1JhTCawc
         lOugc+Fa45OSByS07VFShfWGG5r94L722ETQf2x6y5sCd//8JBZK2MHyoc5cqSfy3olk
         +XbPWNFvxxLNv/oCf7IJ9cJXeYCQvTSwvfoZedg4W8wm8970ONgdhEqpoU2j4zvso1TU
         z7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867048; x=1725471848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxJv0j8wKqbtmeIVheEQj51qn9RSR7kYGGnN4GDdIuY=;
        b=EDq6Hcu10I2nVL1wWsrORvuFWiX0Pnw1+5nhpFMmo96CRwexn+4i1dj/ybUrIapI8e
         q/pbSpmV3nassS+W/yRxMql81Opmo3dsao1sxxpqoDghz0exed9G54XCbaX8E4j1e3Qv
         fn2BKZqIVojXtixsexSgt4IdmVfVNfR5CvkM1hAg+pwNKh5tp1k+auMJ82kgDlJFAt/O
         M0OxQMghYSPvV4D19XwGGu2U665BI8EFRPlcdLtmtbUZmAcgQSC7yqZyZYfImuvRDWph
         bPQbQ0YqRJNyoH/jX8uGG1a+8+/+CPFCckaApNPevZxiTBGtK7klc4uQ0kBv1Vi5m/XV
         nNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCxYisFBNyCCTrz+tJXyMNXdpJYYvQP60k44iy02sYMDyFp8x3fO7OMEmAPtQtiX7j+3d3FoKHcCQsJxU=@vger.kernel.org, AJvYcCWjGAbsOJ5quoEobSoPBWf2Dsj6AE2ZNStX+nmC2CfPvWYxKygjbnHGM3OKZNXVD9Rse0T3ICsy@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSwck+Nb+R34UMUug5uZA9q3we234hpY7WF6c7oQs3YPu0pt3
	msXQrghAeiQEmtiU2KlWMgu441fKX928OZztezBEpId+3/0uv1dN
X-Google-Smtp-Source: AGHT+IGsm+dbJ6cPf1eeSjmrqFdfGokz2YD/9qsUdLpGxvvgIhqs6t70Gmr2X8oxRcFHuogflQxwyQ==
X-Received: by 2002:a17:903:a88:b0:202:46cc:696c with SMTP id d9443c01a7336-2050c237b48mr2694325ad.18.1724867048062;
        Wed, 28 Aug 2024 10:44:08 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-204f1b80cf5sm18259845ad.164.2024.08.28.10.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 10:44:07 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [patch net-next v4] ethtool: pse-pd: move pse validation into set
Date: Wed, 28 Aug 2024 14:43:17 -0300
Message-ID: <20240828174340.593130-2-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move validation into set, removing .set_validate operation as its current
implementation holds the rtnl lock for acquiring the PHY device, defeating
the intended purpose of checking before grabbing the lock.

Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the requested PHY")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
v4:
  - remove .set_validate op, move validation to set
v3: https://lore.kernel.org/all/20240826173913.7763-1-djahchankoike@gmail.com/
  - hold rtnl lock while interacting with the PHY device
  - rollback to v1
v2: https://lore.kernel.org/all/20240826140628.99849-1-djahchankoike@gmail.com/
v1: https://lore.kernel.org/all/20240826130712.91391-1-djahchankoike@gmail.com/
---
 net/ethtool/pse-pd.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 507cb21d6bf0..b56b79f41a3a 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -222,13 +222,10 @@ const struct nla_policy ethnl_pse_set_policy[ETHTOOL_A_PSE_MAX + 1] = {
 };
 
 static int
-ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
+ethnl_set_pse_validate(struct phy_device *phydev, struct genl_info *info)
 {
 	struct nlattr **tb = info->attrs;
-	struct phy_device *phydev;
-
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
-				      info->extack);
+	
 	if (IS_ERR_OR_NULL(phydev)) {
 		NL_SET_ERR_MSG(info->extack, "No PHY is attached");
 		return -EOPNOTSUPP;
@@ -254,7 +251,7 @@ ethnl_set_pse_validate(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EOPNOTSUPP;
 	}
 
-	return 1;
+	return 0;
 }
 
 static int
@@ -262,12 +259,13 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct nlattr **tb = info->attrs;
 	struct phy_device *phydev;
-	int ret = 0;
+	int ret;
 
 	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
 				      info->extack);
-	if (IS_ERR_OR_NULL(phydev))
-		return -ENODEV;
+	ret = ethnl_set_pse_validate(phydev, info);
+	if (ret)
+		return ret;
 
 	if (tb[ETHTOOL_A_C33_PSE_AVAIL_PW_LIMIT]) {
 		unsigned int pw_limit;
@@ -314,7 +312,6 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
 	.fill_reply		= pse_fill_reply,
 	.cleanup_data		= pse_cleanup_data,
 
-	.set_validate		= ethnl_set_pse_validate,
 	.set			= ethnl_set_pse,
 	/* PSE has no notification */
 };
-- 
2.43.0


