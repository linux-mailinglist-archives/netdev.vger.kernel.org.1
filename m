Return-Path: <netdev+bounces-229843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C44EBBE12D2
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67ED74E934A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAE91F12F8;
	Thu, 16 Oct 2025 01:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2OLqd4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78B4A21
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578618; cv=none; b=OCZHdHW6ozLppmpWlDD/iVJCqR83NoCk02T4o8uJ3oOLuU6o519206Uqhrviywm6CxFw64NvPTIqrV4Iyr0QkKjUqctD/zae5wktB49vgU6iSSaP1YpITT0WmV010wTtFcoNLFGXgn2cQ8ayNMa70IlfQKcgA2dFEwaEreLxrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578618; c=relaxed/simple;
	bh=etlF0Hr3mOpkQbxkU5UtJz0vKlKGKeKMYuxVn159xBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOKZ6S8GXDdM55750wVzDLVOGjtRn0MOSryruGibDUIXNRXEqnRfd/MkJA2DKIrwLIdlg8iDTX6pE94uvEn7v6YP1h+qGtTLKDsdhGu2lKuUYEPqbGtU98k90cz0Z2Wr8jF6biKrgJyYkp2SstVFIQFQx/KJAFrUDxIBHtq6C8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2OLqd4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E69C4CEF8;
	Thu, 16 Oct 2025 01:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760578617;
	bh=etlF0Hr3mOpkQbxkU5UtJz0vKlKGKeKMYuxVn159xBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2OLqd4ni5hKDBabZCFFgxtdOHxyTuRE+nxby+5Bfcse8gEC0nJRhX3xtbikwVjiQ
	 iQfqDJkM+oiym/tgux/zKCpFqc35jkSS9lvRVuRIRo9VntZ5AbaH+zYDaNPvZpmCQZ
	 zNT+opR+ODXSQ45RMNu4ZEoEVWLOBnX81HbixOF2ZbYykVdDdID2pDQx/cYvnarEf8
	 gddSwmf7s4/HUXW5l/RjCGw4DjTxzfOP1qREwBpu+s1Tm/BAqIJFLORbRUrKpJxGJD
	 270IerLEXrjkz63iyQYSYVlCfk2LgBcJDzG6O+psxY930v5AP/RLFYN101EKgFKLEQ
	 HQnONAYOYEkEQ==
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
	mbloch@nvidia.com,
	Parav Pandit <parav@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next 1/3] devlink: Introduce devlink eswitch state
Date: Wed, 15 Oct 2025 18:36:16 -0700
Message-ID: <20251016013618.2030940-2-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016013618.2030940-1-saeed@kernel.org>
References: <20251016013618.2030940-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Introduce a new state to eswitch (active/inactive) and
enable user to set it dynamically.

A user can start the eswitch in switchdev mode in either active or
inactive state.

Active: Traffic is enabled on this eswitch FDB.
Inactive: Traffic is ignored/dropped on this eswitch FDB.

An example of starting the switch in active state is following.
  1. devlink dev eswitch set pci/0000:08:00.1 mode switchdev
     (default is active, backward compatible)

  2. devlink dev eswitch set pci/0000:08:00.1 mode switchdev state
     active

To bring up the esw in 'inactive' state:

   devlink dev eswitch set pci/0000:08:00.1 mode switchdev state
inactive

Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      | 13 ++++++++
 .../devlink/devlink-eswitch-attr.rst          | 15 ++++++++++
 include/net/devlink.h                         |  5 ++++
 include/uapi/linux/devlink.h                  |  7 +++++
 net/devlink/dev.c                             | 30 +++++++++++++++++++
 net/devlink/netlink_gen.c                     |  5 ++--
 6 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 3db59c965869..4242a3431320 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -119,6 +119,14 @@ definitions:
         name: none
       -
         name: basic
+  -
+    type: enum
+    name: eswitch-state
+    entries:
+      -
+        name: none
+      -
+        name: basic
   -
     type: enum
     name: dpipe-header-id
@@ -857,6 +865,10 @@ attribute-sets:
         name: health-reporter-burst-period
         type: u64
         doc: Time (in msec) for recoveries before starting the grace period.
+      -
+        name: eswitch-state
+        type: u8
+        enum: eswitch-state
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1609,6 +1621,7 @@ operations:
             - eswitch-mode
             - eswitch-inline-mode
             - eswitch-encap-mode
+            - eswitch-state
 
     -
       name: eswitch-set
diff --git a/Documentation/networking/devlink/devlink-eswitch-attr.rst b/Documentation/networking/devlink/devlink-eswitch-attr.rst
index 08bb39ab1528..13ad1ed300ee 100644
--- a/Documentation/networking/devlink/devlink-eswitch-attr.rst
+++ b/Documentation/networking/devlink/devlink-eswitch-attr.rst
@@ -57,6 +57,18 @@ The following is a list of E-Switch attributes.
        * ``none`` Disable encapsulation support.
        * ``basic`` Enable encapsulation support.
 
+   * - ``state``
+     - enum
+     - The state of the E-Switch.
+       In situations where the user want to bring up the e-switch, they want to
+       have the ability to block traffic towards the FDB until FDB is fully
+       programmed.
+       The state can be one of the following:
+
+       * ``active`` Traffic is enabled on this eswitch FDB - default mode
+       * ``inactive`` Traffic is disabled on this eswitch FDB - no traffic
+         will be forwarded to/from this eswitch FDB
+
 Example Usage
 =============
 
@@ -74,3 +86,6 @@ Example Usage
 
     # enable encap-mode with legacy mode
     $ devlink dev eswitch set pci/0000:08:00.0 mode legacy inline-mode none encap-mode basic
+
+    # enable switchdev mode in inactive state
+    $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev state inactive
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 8d4362f010e4..aca56a905ab8 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1369,6 +1369,11 @@ struct devlink_ops {
 	int (*eswitch_encap_mode_set)(struct devlink *devlink,
 				      enum devlink_eswitch_encap_mode encap_mode,
 				      struct netlink_ext_ack *extack);
+	int (*eswitch_state_get)(struct devlink *devlink,
+				 enum devlink_eswitch_state *state);
+	int (*eswitch_state_set)(struct devlink *devlink,
+				 enum devlink_eswitch_state state,
+				 struct netlink_ext_ack *extack);
 	int (*info_get)(struct devlink *devlink, struct devlink_info_req *req,
 			struct netlink_ext_ack *extack);
 	/**
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index bcad11a787a5..a01443810658 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -195,6 +195,11 @@ enum devlink_eswitch_encap_mode {
 	DEVLINK_ESWITCH_ENCAP_MODE_BASIC,
 };
 
+enum devlink_eswitch_state {
+	DEVLINK_ESWITCH_STATE_INACTIVE,
+	DEVLINK_ESWITCH_STATE_ACTIVE,
+};
+
 enum devlink_port_flavour {
 	DEVLINK_PORT_FLAVOUR_PHYSICAL, /* Any kind of a port physically
 					* facing the user.
@@ -638,6 +643,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
 
+	DEVLINK_ATTR_ESWITCH_STATE,	/* u8 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 02602704bdea..1eea3e2c1ade 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -672,6 +672,17 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 			goto nla_put_failure;
 	}
 
+	if (ops->eswitch_state_get) {
+		enum devlink_eswitch_state state;
+
+		err = ops->eswitch_state_get(devlink, &state);
+		if (err)
+			return err;
+		err = nla_put_u8(msg, DEVLINK_ATTR_ESWITCH_STATE, state);
+		if (err)
+			return err;
+	}
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -706,6 +717,7 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	struct devlink *devlink = info->user_ptr[0];
 	const struct devlink_ops *ops = devlink->ops;
 	enum devlink_eswitch_encap_mode encap_mode;
+	enum devlink_eswitch_state state;
 	u8 inline_mode;
 	int err = 0;
 	u16 mode;
@@ -722,6 +734,24 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	state = DEVLINK_ESWITCH_STATE_ACTIVE;
+	if (info->attrs[DEVLINK_ATTR_ESWITCH_STATE]) {
+		if (!ops->eswitch_state_set)
+			return -EOPNOTSUPP;
+		state = nla_get_u8(info->attrs[DEVLINK_ATTR_ESWITCH_STATE]);
+	}
+	/* If user did not supply the state attribute, the default is
+	 * active state. If the state was not explicitly set, set the default
+	 * state for drivers that support eswitch state.
+	 * Keep this after mode-set as state handling can be dependent on
+	 * the eswitch mode.
+	 */
+	if (ops->eswitch_state_set) {
+		err = ops->eswitch_state_set(devlink, state, info->extack);
+		if (err)
+			return err;
+	}
+
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_INLINE_MODE]) {
 		if (!ops->eswitch_inline_mode_set)
 			return -EOPNOTSUPP;
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 9fd00977d59e..e0910fb2214d 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -226,12 +226,13 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
 };
 
 /* DEVLINK_CMD_ESWITCH_SET - do */
-static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
+static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_STATE + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U8, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
+	[DEVLINK_ATTR_ESWITCH_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 /* DEVLINK_CMD_DPIPE_TABLE_GET - do */
@@ -822,7 +823,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_eswitch_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_eswitch_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
+		.maxattr	= DEVLINK_ATTR_ESWITCH_STATE,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.51.0


