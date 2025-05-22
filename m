Return-Path: <netdev+bounces-192649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34BBAC0A89
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327E5189591E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3002C288C35;
	Thu, 22 May 2025 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X2UF6ukk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA8D286425;
	Thu, 22 May 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912915; cv=none; b=SyuY8pfg2LALJdO2TvhiZ8dSdA8KipF8dtn2/SIAKjTr8RPOZycDesWzKH2FiOsKqYfhphWAHfggGghoyKF/xhCejG1trgXR22C3oVMPoV4tn8EwXmXn9ZdUsfXfgGRIbRVFCO8fVa3KYVlVhZLRPUk38rOT5Njj9GvX+NadTeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912915; c=relaxed/simple;
	bh=GCD+itmTe0b/J+qM5d/v9KELzW7ui94Qc8QFqpcbKRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DpM7q3h0PXUrJ/6emdB/LrHb25vmq8Nso8VT3PJBKzeaPZethEt7/LcVBOq+coGEyETcFJpK8qsr+0Fj8RmCm+S94aNwmDv9Ize3LgJNfTVCG6ArzIo6SsCVGdqjjWnzuHGd/MxWU706pd7HuWjLVucEKA69zp9FqoBf/+qrnLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X2UF6ukk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CB5C4CEE4;
	Thu, 22 May 2025 11:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747912914;
	bh=GCD+itmTe0b/J+qM5d/v9KELzW7ui94Qc8QFqpcbKRU=;
	h=From:To:Cc:Subject:Date:From;
	b=X2UF6ukk+tKDTt0kPLw/7GhH+/e7aKlEhp97dDHCPLmB5yeIHdByPelphTX4hh0Zs
	 p7pdo+v+5HoR4wQc4uxD4Chrl0aItfyGalhUTTqwbtblQnW+EhcroRTIfyd1Y5/yp3
	 ydDrXXADhUJML9MjTBwAZaLIBYEda7aQgZUA4lpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Lobakin <alobakin@pm.me>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next] net: phy: fix up const issues in to_mdio_device() and to_phy_device()
Date: Thu, 22 May 2025 13:21:47 +0200
Message-ID: <2025052246-conduit-glory-8fc9@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 50
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=GCD+itmTe0b/J+qM5d/v9KELzW7ui94Qc8QFqpcbKRU=; b=owGbwMvMwCRo6H6F97bub03G02pJDBn6HKdmMJrd3yc0ewrXk/0MpXzXFie97J75PVmRu6jv7 tvDD2LYOmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAizwUYFswO3Xj21hmN8/Eq zNsDX0isiOE3sGZYcILp8+Tsnn6HzHXbbif6/zkh/FrjGAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Both to_mdio_device() and to_phy_device() "throw away" the const pointer
attribute passed to them and return a non-const pointer, which generally
is not a good thing overall.  Fix this up by using container_of_const()
which was designed for this very problem.

Cc: Alexander Lobakin <alobakin@pm.me>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Fixes: 7eab14de73a8 ("mdio, phy: fix -Wshadow warnings triggered by nested container_of()")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mdio.h | 5 +----
 include/linux/phy.h  | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 3c3deac57894..e43ff9f980a4 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -45,10 +45,7 @@ struct mdio_device {
 	unsigned int reset_deassert_delay;
 };
 
-static inline struct mdio_device *to_mdio_device(const struct device *dev)
-{
-	return container_of(dev, struct mdio_device, dev);
-}
+#define to_mdio_device(__dev)	container_of_const(__dev, struct mdio_device, dev)
 
 /* struct mdio_driver_common: Common to all MDIO drivers */
 struct mdio_driver_common {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a2bfae80c449..bef68f6af99a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -744,10 +744,7 @@ struct phy_device {
 #define PHY_F_NO_IRQ		0x80000000
 #define PHY_F_RXC_ALWAYS_ON	0x40000000
 
-static inline struct phy_device *to_phy_device(const struct device *dev)
-{
-	return container_of(to_mdio_device(dev), struct phy_device, mdio);
-}
+#define to_phy_device(__dev)	container_of_const(to_mdio_device(__dev), struct phy_device, mdio)
 
 /**
  * struct phy_tdr_config - Configuration of a TDR raw test
-- 
2.49.0


