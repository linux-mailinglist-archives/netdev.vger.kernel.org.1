Return-Path: <netdev+bounces-280929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PLDFO3k6mlnFQAAu9opvQ
	(envelope-from <netdev+bounces-280929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:35:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E591D459799
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AE0A301F98D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B672561A2;
	Fri, 24 Apr 2026 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTB8tU3i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC61B4F1F
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001641; cv=none; b=KX9u9yjafmBOCZBDWTAw2LoVwCD9QbExUj8ZjMBtrrXhGZd/0rDy4qyyB2CjEN8gtVWnRL8lTyI4M9MGuUV1/B5zLIVpMhc9zERbUS/FjM765ad6uqdTMWSxqQsYmSlGTtCYsbL7CXFjeE9bL2HQE0jQQC1uMAlls62WnNzc6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001641; c=relaxed/simple;
	bh=0QosxY/o8tb5B1JTDe6dmHhKbgTsbsBuSRx2bY8e0xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/MWf9sFYwOG35GNHcTUWdFzXDyI9p0f4yRcOowbl2raQmaGXwkEoSwcQ5UX5V3gtWSFl5jSK9DXVxlSCL83cfCvpvv4BmNHsYs9lBw/rQT5TOvd74vRklOndEmwfsqMmjDk0SqoXzlWqXO4aCpy9ejbhcwxA5rV1yJiL4H+0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTB8tU3i; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82f83bd32efso5724400b3a.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777001640; x=1777606440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKZeI69AMY1zWybSYtDN8RDRjMihnobL/AcJ00QScLc=;
        b=qTB8tU3i60ZkW0mNwY+wvqEU3BSm/bxn2dh1BD0nCst9sg5To596uy4Wlnhj7AC7R5
         PQWHPiBeCXL4b4sI+GFIb0SoA1LahNNz9IbLZyUWszH+EqIG+BzvBQTsy6IsJfSuGk7w
         jPPcgHNl/qwB2NeNXAd35QMgF0fySWcNWt/vyfmX/Z1EDMF7v3F9ciovH5BRU4ZeKO/1
         80LCS9iEKHFgKO4Q+/NKMfsSJ33MVKlvJPb1vr1yTIZsK6e3XUfDaOGpO+mHr8w7cmeK
         4AnW4Hm9wW/x9hgHABjY5X5aUJPQsFvKtfnK6qfV65xMdx2PNKM48MCynSUWD6cLkQd+
         IzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777001640; x=1777606440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKZeI69AMY1zWybSYtDN8RDRjMihnobL/AcJ00QScLc=;
        b=LuGEpzVkaY+UFD2yvm0hMUvaffib3vbgVupWPdAcJIndLlqnSS+Xu7P0DIyMeom7Wp
         mkntlDFSuf2LFdvg+k7LBrLwD+rFHme0R62RNbEXQr3p2FX1uj5WePwQR4AwPr3Re6o7
         +pezHHaWegFklGFHic8qe4gbluRnwYrzxu5CPkoJ/MWMgA08RB1TcvMALE6LIxTgCLSR
         hX93xwDJ6Z9ISWf6ay0UC551kMj8LVwDQsVR3X8RU9C6kDzW5jfY6XO40EZOvZJkrxkv
         m73ht3zylAcnZt7dOU0n20knathiBmVUWFIT12mm8Ox4uBbWIl7NTMzyy0KhplKQL+UR
         CzAw==
X-Gm-Message-State: AOJu0YwC7tW6cDBYkoGCZOkO/K2Jy7oziJzb0cnlgfw5Gz6H3eRINxdI
	J8K4wLK2EX5Al6ziCx74Y1kS5hS91MoUyMzaBG34K5ObjqxCgW16scW+
X-Gm-Gg: AeBDievnsV8OCNbq+n2lCrJGxVSQXcErRQKI5DPKyfs6B8CGGGwYGTFtibK362TgJdT
	eAs4XZIiL00gFHdfkoA9NtUmX2Y8LBqYrd5B5/h0KaqD4AeYUEMmOXCqODD0dDy1bTq8wIopQA1
	vIWMDCJimgW1oULDko4fB88dPCCMlXSQZ0oIcpNyY2wD8V9AzqBgi8hlfTntuCoPdF3KxbmjNhe
	eIj0sXdgTiv1XBaQRYxUSA9EiLroY5FKT4gIOAGOwgm4x/m8k9fHv4OyIkKYUtoJS9VA8GjtRG0
	M6M9f+uL16unKiKXq+MMOOJJYSJRjraCrD9e2hW3YwbQGNeCfqC6dHODPdfopCYizH+acm34txg
	mbfMSy5t8I/Elf0mQSu8AjCI7KvINSyfkoAH3mwO02wI1whfgHpof5pAros0gLsGhW6g9Piq1z3
	T3eOcCrVzeUEDBQgJtbyAl4ed1hNFFDcJj0kH4jjw6xm0oQ5bDh43CN8JTMvqTbmiDZLF1zaii
X-Received: by 2002:a05:6a00:928b:b0:82f:6dad:7b75 with SMTP id d2e1a72fcca58-82f8c8ebc91mr33576208b3a.33.1777001639902;
        Thu, 23 Apr 2026 20:33:59 -0700 (PDT)
Received: from ubunut-vm.. (c-73-240-82-137.hsd1.or.comcast.net. [73.240.82.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm23797624b3a.14.2026.04.23.20.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:33:59 -0700 (PDT)
From: Joel <joelcrouch@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel <joelcrouch@gmail.com>
Subject: [PATCH v2 2/2] sungem: validate BCM5411 PHY register reads
Date: Fri, 24 Apr 2026 03:33:48 +0000
Message-ID: <20260424033348.1917-3-joelcrouch@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424033348.1917-1-joelcrouch@gmail.com>
References: <20260424033348.1917-1-joelcrouch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E591D459799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280929-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joelcrouch@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Check for -EIO and 0xffff during initialization to prevent silent failures. Add error logging to gem_init_phy to report failures.
---
 drivers/net/ethernet/sun/sungem.c | 8 ++++++--
 drivers/net/sungem_phy.c          | 7 ++++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index 8e69d917d..525aba527 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -1707,8 +1707,12 @@ static void gem_init_phy(struct gem *gp)
 		sungem_phy_probe(&gp->phy_mii, gp->mii_phy_addr);
 
 		/* Init PHY */
-		if (gp->phy_mii.def && gp->phy_mii.def->ops->init)
-			gp->phy_mii.def->ops->init(&gp->phy_mii);
+		if (gp->phy_mii.def && gp->phy_mii.def->ops->init) {
+			int err = gp->phy_mii.def->ops->init(&gp->phy_mii);
+
+			if (err)
+				netdev_err(gp->dev, "PHY init failed: %d\n", err);
+		}
 	} else {
 		gem_pcs_reset(gp);
 		gem_pcs_reinit_adv(gp);
diff --git a/drivers/net/sungem_phy.c b/drivers/net/sungem_phy.c
index 44cbe1938..ec8800c93 100644
--- a/drivers/net/sungem_phy.c
+++ b/drivers/net/sungem_phy.c
@@ -296,7 +296,12 @@ static int bcm5411_init(struct mii_phy *phy)
 	sungem_phy_write(phy, MII_BMCR, BMCR_RESET);
 	sungem_phy_write(phy, MII_BMCR, 0x1340);
 
-	data = sungem_phy_read(phy, MII_BCM5400_GB_CONTROL);
+	val = sungem_phy_read(phy, MII_BCM5400_GB_CONTROL);
+
+	if (val < 0 || val == 0xffff)
+		return -EIO;
+
+	data = (u16)val;
 	data |= MII_BCM5400_GB_CONTROL_FULLDUPLEXCAP;
 	sungem_phy_write(phy, MII_BCM5400_GB_CONTROL, data);
 
-- 
2.43.0


