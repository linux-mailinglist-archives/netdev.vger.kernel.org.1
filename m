Return-Path: <netdev+bounces-236970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0EC428AE
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 08:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B093AE612
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC772DC767;
	Sat,  8 Nov 2025 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9zYnovt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DD2D5C6C
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762585471; cv=none; b=mow2KkdV2OblRy1YIjaT69jyLLmOvyW81oPdUNjuHWiFV1RuznvXrWLBnl4mRKcmBa8wAxhHOtac7krYvOwUY681CO072rsJRfGff+EnakMbx5MVDujeufWiRPSW8raRR489IduaXiW5ETaMcBuxpe3bLFYpAWjn9yi51GXhF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762585471; c=relaxed/simple;
	bh=qB3UJgZKO4pLe2klvg11v11rwr3rwA7JmxvTY26QNQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m91flxAXponaURbVlOg9cA2BWWSxQWC2PBIHU2/4gMmv9twCMV+zfAeChPLHaSVRE81yGGTtU5u7HGewcoz/TnkBoHJ+WSftToeuunjhFvjPQkpS0ug/WKAoJyth0hAL36S5ITsseVIhrPWF4/8eg0nG4XEYmDmgPdR2jra4k6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9zYnovt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CB0C4CEFB;
	Sat,  8 Nov 2025 07:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762585471;
	bh=qB3UJgZKO4pLe2klvg11v11rwr3rwA7JmxvTY26QNQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g9zYnovtZrHXJuJ7KXjSbwa9/No3w10LUGBM4FIYJBz/zsTU98+Aie9XfqQU6VIrV
	 YLAj47Cq5EpNAGBhXiJoRXVRSkI0f9lmXqAPs7yGFSrT+TIRXLeNEVUdWxYFWDCCNr
	 cP9vz3IovNLVUHxa5Rd1WnlXIA1t8J6nX7KqPuRCxRxIlvD6iFe4JEVeXXmo0HBxn7
	 yIXBcy4f4x8tOfbxDh8jQM9J0PqKO1vmtHeACX2BT/POHWHVi4pWsG6JH/7zKpRKM8
	 yDC5+ReXXRrKNSSyb08mmd8XFyGTZqZYF0JeN4RI2LJZQnB1m7zqeWzZWMsczlDr0R
	 AHOKQrNBsKIIA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	mbloch@nvidia.com
Subject: [PATCH net-next V3 1/3] devlink: Introduce switchdev_inactive eswitch mode
Date: Fri,  7 Nov 2025 23:04:02 -0800
Message-ID: <20251108070404.1551708-2-saeed@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251108070404.1551708-1-saeed@kernel.org>
References: <20251108070404.1551708-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Adds DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE attribute to UAPI and
documentation.

Before having traffic flow through an eswitch, a user may want to have the
ability to block traffic towards the FDB until FDB is fully programmed and
the user is ready to send traffic to it. For example: when two eswitches
are present for vports in a multi-PF setup, one eswitch may take over the
traffic from the other when the user chooses.
Before this take over, a user may want to first program the inactive
eswitch and then once ready redirect traffic to this new eswitch.

switchdev modes transition semantics:

legacy->switchdev_inactive: Create switchdev mode normally, traffic not
  allowed to flow yet.

switchdev_inactive->switchdev: Enable traffic to flow.

switchdev->switchdev_inactive: Block traffic on the FDB, FDB and
  representros state and content is preserved.

When eswitch is configured to this mode, traffic is ignored/dropped on
this eswitch FDB, while current configuration is kept, e.g FDB rules and
netdev representros are kept available, FDB programming is allowed.

Example:
 # start inactive switchdev
devlink dev eswitch set pci/0000:08:00.1 mode switchdev_inactive
 # setup TC rules, representors etc ..
 # activate
devlink dev eswitch set pci/0000:08:00.1 mode switchdev

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml            |  2 ++
 .../networking/devlink/devlink-eswitch-attr.rst     | 13 +++++++++++++
 include/uapi/linux/devlink.h                        |  1 +
 net/devlink/netlink_gen.c                           |  2 +-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 3db59c965869..426d5aa7d955 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -99,6 +99,8 @@ definitions:
         name: legacy
       -
         name: switchdev
+      -
+        name: switchdev-inactive
   -
     type: enum
     name: eswitch-inline-mode
diff --git a/Documentation/networking/devlink/devlink-eswitch-attr.rst b/Documentation/networking/devlink/devlink-eswitch-attr.rst
index 08bb39ab1528..eafe09abc40c 100644
--- a/Documentation/networking/devlink/devlink-eswitch-attr.rst
+++ b/Documentation/networking/devlink/devlink-eswitch-attr.rst
@@ -39,6 +39,10 @@ The following is a list of E-Switch attributes.
          rules.
        * ``switchdev`` allows for more advanced offloading capabilities of
          the E-Switch to hardware.
+       * ``switchdev_inactive`` switchdev mode but starts inactive, doesn't allow traffic
+         until explicitly activated. This mode is useful for orchestrators that
+         want to prepare the device in switchdev mode but only activate it when
+         all configurations are done.
    * - ``inline-mode``
      - enum
      - Some HWs need the VF driver to put part of the packet
@@ -74,3 +78,12 @@ Example Usage
 
     # enable encap-mode with legacy mode
     $ devlink dev eswitch set pci/0000:08:00.0 mode legacy inline-mode none encap-mode basic
+
+    # start switchdev mode in inactive state
+    $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev_inactive
+
+    # setup switchdev configurations, representors, FDB entries, etc..
+    ...
+
+    # activate switchdev mode to allow traffic
+    $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index bcad11a787a5..157f11d3fb72 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -181,6 +181,7 @@ enum devlink_sb_threshold_type {
 enum devlink_eswitch_mode {
 	DEVLINK_ESWITCH_MODE_LEGACY,
 	DEVLINK_ESWITCH_MODE_SWITCHDEV,
+	DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE,
 };
 
 enum devlink_eswitch_inline_mode {
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 9fd00977d59e..5ad435aee29d 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -229,7 +229,7 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
 static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
-	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
+	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 2),
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U8, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
-- 
2.51.1


