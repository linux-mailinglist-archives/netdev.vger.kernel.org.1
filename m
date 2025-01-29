Return-Path: <netdev+bounces-161549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAC1A2240D
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B2F7A30C5
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3C1E25F7;
	Wed, 29 Jan 2025 18:36:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223B1E1027
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738175816; cv=none; b=pfhnXFdG5opLv+G+IWTw2Rb/ZmskqiFkycGxsoRG8XAj+g33hE+XQV4ft+lJlrTlbcsxAPCSE4EXvwY056sVXjE0wQBxvjTOJzp1FNUx6JIDbR/5B6ma7q+aaMmVqF0/DZTi2rHvRsTu7TnNzT4Q6hfabJxU2OjzUqdj5TQfQAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738175816; c=relaxed/simple;
	bh=phb5tRUTLbCN4g7XtsOaY8/p1buAQ2NdbxTHdqnWY/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmV7jnzW8LObWuxamDCYE1JOFoPRbZm03lml+F64OdACI+643PHQxhH1t+T03z8mHZE5eJDxurwrysj4W0FNw6gWF7KScikRSn2WetO4j/UhVj7QhL2UM7d8Xuul+do9zYfb0jERnkiLkjs0ivhffEhYcxDHqo0qv+sRCvQv0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ecsmtp.an.intel.com; spf=none smtp.mailfrom=ecsmtp.an.intel.com; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ecsmtp.an.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.an.intel.com
X-CSE-ConnectionGUID: u1R2V1oKT0Gp7K1/aLpubQ==
X-CSE-MsgGUID: PDUPCnaSTZe8DbHcJUadvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="37950480"
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="37950480"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:36:53 -0800
X-CSE-ConnectionGUID: 89Cg6OraSA+H6GiCywKzPQ==
X-CSE-MsgGUID: AIhIHuEmSLWOFtzEJTMHSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="114142979"
Received: from anls2093.an.intel.com ([10.123.15.112])
  by orviesa004.jf.intel.com with ESMTP; 29 Jan 2025 10:36:52 -0800
Received: from aus-labsrv3.an.intel.com (aus-labsrv3.an.intel.com [10.123.116.23])
	by anls2093.an.intel.com (Postfix) with SMTP id 305651006B1D;
	Wed, 29 Jan 2025 12:36:51 -0600 (CST)
Received: by aus-labsrv3.an.intel.com (sSMTP sendmail emulation); Wed, 29 Jan 2025 12:36:51 -0600
From: "sreedevi.joshi" <joshisre@ecsmtp.an.intel.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>
Subject: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Date: Wed, 29 Jan 2025 12:36:38 -0600
Message-Id: <20250129183638.695010-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreedevi Joshi <sreedevi.joshi@intel.com>

When attaching a fixed phy to devices like veth, it is
possible that there is no parent. The logic in
phy_attach_direct() tries to access the driver member
without checking for the null. This causes segfault in the
case of fixed phy.

Checks are in place now to ensure the parent is not null
before accessing to address this scenario.

Fixes: 2db2d9d1ac37 ("net: phy: Guard against the presence of a netdev")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 46713d27412b..be813962cb89 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1471,7 +1471,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	 * our own module->refcnt here, otherwise we would not be able to
 	 * unload later on.
 	 */
-	if (dev)
+	if (dev && dev->dev.parent)
 		ndev_owner = dev->dev.parent->driver->owner;
 	if (ndev_owner != bus->owner && !try_module_get(bus->owner)) {
 		phydev_err(phydev, "failed to get the bus module\n");
-- 
2.25.1


