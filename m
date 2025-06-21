Return-Path: <netdev+bounces-199992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA913AE2A8F
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEBA178F74
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1947D2222A9;
	Sat, 21 Jun 2025 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5rjzKde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6B221FD0
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526393; cv=none; b=oW0G5NLiII299duXvqHrrNEb21YCgaG8KDwsDN6/QmJZ6PEsS63rI/C3QdjlE4MaVDcH05tRk3JuLreW5/9uSLKQPO88KnmGcbI5UPglKyvw302082SzGokfEXB7uZv61rRaePF9iJsIslwLsIihcG1Rzjuwp20mx/VPXxEg010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526393; c=relaxed/simple;
	bh=ixJpU/GJ7AygrQGjRR/tNJIUPh7BTYO17A/+tFVsG6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfTTT5op/xlYqFu0Tek0wCgFCzEpq1jKtJXGddffqgFZSNn8xN1mH6IVgXP5IbSrAXkQ9EtfPYoPXXeQn+ln1xMZ2AMdQ/ve4jxdwjAwYUYvzOk5fhiXPcarua9skOh0dKhd/vtSRaBLwf4BxZYoBJWFXA9u+MfFb0H+kg1tJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5rjzKde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161F3C4CEEF;
	Sat, 21 Jun 2025 17:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526392;
	bh=ixJpU/GJ7AygrQGjRR/tNJIUPh7BTYO17A/+tFVsG6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5rjzKde5TBrpbYahGOxgSyEQGM+gO9amt0Ypr6RCt6KAVQGFt0ZjV2qKdlluNnYF
	 uICEk/u/OogPr1L/6qe/leKDXFJUXWOQYbTgY6K+8yL9xlF/yLXL0ml/1Ax3P4k0k5
	 vL0piV3n1VEu/CZA9FOnHbPfegi6kZbZLw4yd6pzr+nxX53zryaUvydyphfb7jO3eo
	 mI13Gzk2b+tjQnD7AeEcbC926MPr3N69XtRS52QTElX6HQcF+EfZU8uvJDOUCW7VtF
	 P6z7HXfXKPeSs8U7S/HbcPBL9ZlY+6Ct+p/uy0abMZ5GyYPW4IEDEkT/yDv7DDl1nh
	 7JcNqNFNOxV+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/9] netlink: specs: add the multicast group name to spec
Date: Sat, 21 Jun 2025 10:19:36 -0700
Message-ID: <20250621171944.2619249-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621171944.2619249-1-kuba@kernel.org>
References: <20250621171944.2619249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the multicast group's name to the YAML spec.
Without it YNL doesn't know how to subscribe to notifications.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml       | 6 ++++++
 include/uapi/linux/ethtool_netlink.h           | 2 --
 include/uapi/linux/ethtool_netlink_generated.h | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index c1651e175e8b..cfe84f84ba29 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2492,3 +2492,9 @@ c-version-name: ethtool-genl-version
         attributes:
           - header
           - events
+
+mcast-groups:
+  list:
+    -
+      name: monitor
+      c-define-name: ethtool-mcgrp-monitor-name
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 09a75bdb6560..fa5d645140a4 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -208,6 +208,4 @@ enum {
 	ETHTOOL_A_STATS_PHY_MAX = (__ETHTOOL_A_STATS_PHY_CNT - 1)
 };
 
-#define ETHTOOL_MCGRP_MONITOR_NAME "monitor"
-
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_H_ */
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 4944badf9fba..859e28c8a91a 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -867,4 +867,6 @@ enum {
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
 };
 
+#define ETHTOOL_MCGRP_MONITOR_NAME	"monitor"
+
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H */
-- 
2.49.0


