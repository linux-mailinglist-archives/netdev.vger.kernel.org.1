Return-Path: <netdev+bounces-236553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B055AC3DF59
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 993BF4E01FA
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7CA226D1E;
	Fri,  7 Nov 2025 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8FRhsM3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9997E221D87
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474490; cv=none; b=Fgo5UL4PxaXAeaJMyMCUNJVqbY5v6+C0wZ/MXU0F99X9wcmH4BLXRu6zhr1JSzJgAzPPQzqj8fJc2k5+jj2rZofRCb/90adtjG5W483wU/IZQoXm5dzIVfMQQ+/0t61BVBspyQapyzWQq1nW0FXkMimhXnlloSaPtEibSKKJSdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474490; c=relaxed/simple;
	bh=qk1m3VxZ37KxE5FApJ5wbTRsroWNt/MXDoMPZyAinh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTVlI7HJAUg+gEo1CMH0vYkuZbRc9KD3hml+I7MVYNaG3vGt4ccaa9VfAq9m5103Zhjo8aCF9xYeAj+ZGSvD/dbEPNTwvxyQ5Ba+ofvaOiBLP0alqM+M8wfH/fCdB2WClAjPsikeQIqbEbpnJjmsjO4UfR0qi0tRctEnfGdg9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8FRhsM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A658C4CEF7;
	Fri,  7 Nov 2025 00:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762474488;
	bh=qk1m3VxZ37KxE5FApJ5wbTRsroWNt/MXDoMPZyAinh4=;
	h=From:To:Cc:Subject:Date:From;
	b=s8FRhsM3F82M9rBo0GnS2wKRcI5GrZ0qKel2YKoUOzhui2ug7geampFF/rqPeJexu
	 qnjMeh0xPs1RDgY/OhslrVC2Snx5bEdQHf9weCJOQtx1E/uni5QLCDbW3Fe+PBNGZx
	 9nIAoexFVqHgLZtubveRWePYHywneoTYIllTIbhQExlsY5Gd1SeVfFcNX/6YJsJ9/1
	 CS99tQ+SMGeZBLcMymOenorEbf/1ohbE6BkpeCi/NVZni/5atHCurZDNyFBmJXysGB
	 EzEkM5d/TZsQ76MREQvyp2hql2LS9374bPfXKFFffwh0dUrdE8Ip59A6YR6bMFYibt
	 Qra7i88G9SOgg==
From: Saeed Mahameed <saeed@kernel.org>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2] devlink: Support DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE
Date: Thu,  6 Nov 2025 16:14:35 -0800
Message-ID: <20251107001435.160260-1-saeed@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Add support for the new inactive switchdev mode [1].

A user can start the eswitch in switchdev or switchdev_inactive mode.

Active: Traffic is enabled on this eswitch FDB.
Inactive: Traffic is ignored/dropped on this eswitch FDB.

An example use case:
$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev_inactive
Setup FDB pipeline and netdev representors
...
Once ready to start receiving traffic
$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev

[1] https://lore.kernel.org/all/20251107000831.157375-1-saeed@kernel.org/

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 devlink/devlink.c            | 7 ++++++-
 include/uapi/linux/devlink.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 35128083..fd9fac21 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -45,6 +45,7 @@
 
 #define ESWITCH_MODE_LEGACY "legacy"
 #define ESWITCH_MODE_SWITCHDEV "switchdev"
+#define ESWITCH_MODE_SWITCHDEV_INACTIVE "switchdev_inactive"
 #define ESWITCH_INLINE_MODE_NONE "none"
 #define ESWITCH_INLINE_MODE_LINK "link"
 #define ESWITCH_INLINE_MODE_NETWORK "network"
@@ -1428,6 +1429,8 @@ static int eswitch_mode_get(const char *typestr,
 		*p_mode = DEVLINK_ESWITCH_MODE_LEGACY;
 	} else if (strcmp(typestr, ESWITCH_MODE_SWITCHDEV) == 0) {
 		*p_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
+	} else if (strcmp(typestr, ESWITCH_MODE_SWITCHDEV_INACTIVE) == 0) {
+		*p_mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
 	} else {
 		pr_err("Unknown eswitch mode \"%s\"\n", typestr);
 		return -EINVAL;
@@ -2848,7 +2851,7 @@ static bool dl_dump_filter(struct dl *dl, struct nlattr **tb)
 static void cmd_dev_help(void)
 {
 	pr_err("Usage: devlink dev show [ DEV ]\n");
-	pr_err("       devlink dev eswitch set DEV [ mode { legacy | switchdev } ]\n");
+	pr_err("       devlink dev eswitch set DEV [ mode { legacy | switchdev | switchdev_inactive } ]\n");
 	pr_err("                               [ inline-mode { none | link | network | transport } ]\n");
 	pr_err("                               [ encap-mode { none | basic } ]\n");
 	pr_err("       devlink dev eswitch show DEV\n");
@@ -3284,6 +3287,8 @@ static const char *eswitch_mode_name(uint32_t mode)
 	switch (mode) {
 	case DEVLINK_ESWITCH_MODE_LEGACY: return ESWITCH_MODE_LEGACY;
 	case DEVLINK_ESWITCH_MODE_SWITCHDEV: return ESWITCH_MODE_SWITCHDEV;
+	case DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE:
+		return ESWITCH_MODE_SWITCHDEV_INACTIVE;
 	default: return "<unknown mode>";
 	}
 }
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index bcd5fde1..317c088b 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -181,6 +181,7 @@ enum devlink_sb_threshold_type {
 enum devlink_eswitch_mode {
 	DEVLINK_ESWITCH_MODE_LEGACY,
 	DEVLINK_ESWITCH_MODE_SWITCHDEV,
+	DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE,
 };
 
 enum devlink_eswitch_inline_mode {
-- 
2.51.1


