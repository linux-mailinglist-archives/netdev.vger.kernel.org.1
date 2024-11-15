Return-Path: <netdev+bounces-145405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D367F9CF64C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 21:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762D3282B5B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D331E32C0;
	Fri, 15 Nov 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm8m68M2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABF1E1C03;
	Fri, 15 Nov 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703392; cv=none; b=R7mui4qe+vYq9aqvk/4wc9AbpvMtXR1ct58VxfTpIWWOuQCgRDFs3UbtiLw0G5OgVrHuvwcJsihlHx//Na5eWEjCtfzNtEJp9X9Zk9HOeCeMOuEWFukU0jpwHDJzvb+nThVmjg/sGezMhNxomedW66edB24pNJjYjn7IprasxzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703392; c=relaxed/simple;
	bh=XLhDTh1a0RlNEhdf185AQJjpHS1kO/YS0NoMJwKDK5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YecCdjjEwZqjoE37Wk1KHieXWS6tv2lkQy06YVEIaMqkLpMTKPewO0HQO7jxw0dokNSICnut/tN9xnDGtLz3+DLrGYyDitIKkV2N7dT9Bbs0hPXahjMd7fRn+Uvshjet7ISsv+knawDqw39TzQECGoyh5UZTKBXFS9pjbhG82Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm8m68M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC096C4AF09;
	Fri, 15 Nov 2024 20:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731703391;
	bh=XLhDTh1a0RlNEhdf185AQJjpHS1kO/YS0NoMJwKDK5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tm8m68M2sXmiIaaghoRkb9xgH8AldtLdOyJ4Ock0V1j7q23c9F9YXwxXupFKe1YBl
	 t72qKAiy+ho61d2ZJuHqaPH2smilJKq6M25YckvbiU8pnNtOjU/cylAss/frr76Gu4
	 v/VrL3W1CaQHhpk+i9lFgtQSCfZxzUwRNV69TiF11ud0m7SAta2HHCQVZa+kUp5XJ+
	 T7rMsyfdsva7V26456V1cqv69WZqc0k60tvufr/1ESQVjBKHH7nEAIQptHRBFCuv8V
	 PQ2jIcH0VbEN5E5XEq2Vf+0uHtvFDFMSqG5LKKPI3aaiTJ37YTrG+KvX+x9BrPVLrQ
	 h3KPnoAfsbUmQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Takeru Hayasaka <hayatake396@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] Revert "net: ethtool: Avoid thousands of -Wflex-array-member-not-at-end warnings"
Date: Fri, 15 Nov 2024 12:43:03 -0800
Message-Id: <20241115204308.3821419-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115204115.work.686-kees@kernel.org>
References: <20241115204115.work.686-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10698; i=kees@kernel.org; h=from:subject; bh=XLhDTh1a0RlNEhdf185AQJjpHS1kO/YS0NoMJwKDK5U=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnmmyJ4HefI33+UWRVqdumNbGRw/c8z3w/pZRxW6322O SA7V2FnRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwEScnzIyzM8OEX0ew2Ep8fyI JVNQzT+tr3/vverrCTA5LMqfV8+Yxshw6ceyV7cj3z0yudLA88TA5vU5qwPxKVn//T+K/b95oMa dAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

This reverts commit 3bd9b9abdf1563a22041b7255baea6d449902f1a. We cannot
use the new tagged struct group because it throws C++ errors even under
"extern C".

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  6 +++---
 .../net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  4 ++--
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |  2 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |  2 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c    |  4 ++--
 include/linux/ethtool.h                        |  2 +-
 net/ethtool/ioctl.c                            |  2 +-
 net/ethtool/linkinfo.c                         |  8 ++++----
 net/ethtool/linkmodes.c                        | 18 +++++++-----------
 9 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index cfd2c65b1c90..061a40b1974b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2780,7 +2780,7 @@ u32 bnxt_fw_to_ethtool_speed(u16 fw_link_speed)
 static void bnxt_get_default_speeds(struct ethtool_link_ksettings *lk_ksettings,
 				    struct bnxt_link_info *link_info)
 {
-	struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
+	struct ethtool_link_settings *base = &lk_ksettings->base;
 
 	if (link_info->link_state == BNXT_LINK_STATE_UP) {
 		base->speed = bnxt_fw_to_ethtool_speed(link_info->link_speed);
@@ -2799,7 +2799,7 @@ static void bnxt_get_default_speeds(struct ethtool_link_ksettings *lk_ksettings,
 static int bnxt_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *lk_ksettings)
 {
-	struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
+	struct ethtool_link_settings *base = &lk_ksettings->base;
 	enum ethtool_link_mode_bit_indices link_mode;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_link_info *link_info;
@@ -3022,9 +3022,9 @@ u16 bnxt_get_fw_auto_link_speeds(const unsigned long *mode)
 static int bnxt_set_link_ksettings(struct net_device *dev,
 			   const struct ethtool_link_ksettings *lk_ksettings)
 {
-	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_link_info *link_info = &bp->link_info;
+	const struct ethtool_link_settings *base = &lk_ksettings->base;
 	bool set_pause = false;
 	u32 speed, lanes = 0;
 	int rc = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 45d28a65347e..7f3f5afa864f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -662,8 +662,8 @@ static unsigned int lmm_to_fw_caps(const unsigned long *link_mode_mask)
 static int get_link_ksettings(struct net_device *dev,
 			      struct ethtool_link_ksettings *link_ksettings)
 {
-	struct ethtool_link_settings_hdr *base = &link_ksettings->base;
 	struct port_info *pi = netdev_priv(dev);
+	struct ethtool_link_settings *base = &link_ksettings->base;
 
 	/* For the nonce, the Firmware doesn't send up Port State changes
 	 * when the Virtual Interface attached to the Port is down.  So
@@ -717,9 +717,9 @@ static int get_link_ksettings(struct net_device *dev,
 static int set_link_ksettings(struct net_device *dev,
 			    const struct ethtool_link_ksettings *link_ksettings)
 {
-	const struct ethtool_link_settings_hdr *base = &link_ksettings->base;
 	struct port_info *pi = netdev_priv(dev);
 	struct link_config *lc = &pi->link_cfg;
+	const struct ethtool_link_settings *base = &link_ksettings->base;
 	struct link_config old_lc;
 	unsigned int fw_caps;
 	int ret = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 61d08547e3f9..2fbe0f059a0b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -1436,8 +1436,8 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 static int cxgb4vf_get_link_ksettings(struct net_device *dev,
 				  struct ethtool_link_ksettings *link_ksettings)
 {
-	struct ethtool_link_settings_hdr *base = &link_ksettings->base;
 	struct port_info *pi = netdev_priv(dev);
+	struct ethtool_link_settings *base = &link_ksettings->base;
 
 	/* For the nonce, the Firmware doesn't send up Port State changes
 	 * when the Virtual Interface attached to the Port is down.  So
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 4fe85780a950..f7986f2b6a17 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -129,8 +129,8 @@ static void enic_intr_coal_set_rx(struct enic *enic, u32 timer)
 static int enic_get_ksettings(struct net_device *netdev,
 			      struct ethtool_link_ksettings *ecmd)
 {
-	struct ethtool_link_settings_hdr *base = &ecmd->base;
 	struct enic *enic = netdev_priv(netdev);
+	struct ethtool_link_settings *base = &ecmd->base;
 
 	ethtool_link_ksettings_add_link_mode(ecmd, supported,
 					     10000baseT_Full);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index c553da16d4b1..e50e1df0a433 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -504,7 +504,7 @@ static int qede_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	typeof(cmd->link_modes) *link_modes = &cmd->link_modes;
-	struct ethtool_link_settings_hdr *base = &cmd->base;
+	struct ethtool_link_settings *base = &cmd->base;
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qed_link_output current_link;
 
@@ -537,7 +537,7 @@ static int qede_get_link_ksettings(struct net_device *dev,
 static int qede_set_link_ksettings(struct net_device *dev,
 				   const struct ethtool_link_ksettings *cmd)
 {
-	const struct ethtool_link_settings_hdr *base = &cmd->base;
+	const struct ethtool_link_settings *base = &cmd->base;
 	const struct ethtool_forced_speed_map *map;
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qed_link_output current_link;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1199e308c8dd..12f6dc567598 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -211,7 +211,7 @@ void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
  * fields, but they are allowed to overwrite them (will be ignored).
  */
 struct ethtool_link_ksettings {
-	struct ethtool_link_settings_hdr base;
+	struct ethtool_link_settings base;
 	struct {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7da94e26ced6..5cc131cdb1bc 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -425,7 +425,7 @@ convert_link_ksettings_to_legacy_settings(
 
 /* layout of the struct passed from/to userland */
 struct ethtool_link_usettings {
-	struct ethtool_link_settings_hdr base;
+	struct ethtool_link_settings base;
 	struct {
 		__u32 supported[__ETHTOOL_LINK_MODE_MASK_NU32];
 		__u32 advertising[__ETHTOOL_LINK_MODE_MASK_NU32];
diff --git a/net/ethtool/linkinfo.c b/net/ethtool/linkinfo.c
index 2d5bc57160be..30b8ce275159 100644
--- a/net/ethtool/linkinfo.c
+++ b/net/ethtool/linkinfo.c
@@ -8,9 +8,9 @@ struct linkinfo_req_info {
 };
 
 struct linkinfo_reply_data {
-	struct ethnl_reply_data			base;
-	struct ethtool_link_ksettings		ksettings;
-	struct ethtool_link_settings_hdr	*lsettings;
+	struct ethnl_reply_data		base;
+	struct ethtool_link_ksettings	ksettings;
+	struct ethtool_link_settings	*lsettings;
 };
 
 #define LINKINFO_REPDATA(__reply_base) \
@@ -98,7 +98,7 @@ static int
 ethnl_set_linkinfo(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct ethtool_link_ksettings ksettings = {};
-	struct ethtool_link_settings_hdr *lsettings;
+	struct ethtool_link_settings *lsettings;
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
 	bool mod = false;
diff --git a/net/ethtool/linkmodes.c b/net/ethtool/linkmodes.c
index 17e49cf89f03..259cd9ef1f2a 100644
--- a/net/ethtool/linkmodes.c
+++ b/net/ethtool/linkmodes.c
@@ -11,10 +11,10 @@ struct linkmodes_req_info {
 };
 
 struct linkmodes_reply_data {
-	struct ethnl_reply_data			base;
-	struct ethtool_link_ksettings		ksettings;
-	struct ethtool_link_settings_hdr	*lsettings;
-	bool					peer_empty;
+	struct ethnl_reply_data		base;
+	struct ethtool_link_ksettings	ksettings;
+	struct ethtool_link_settings	*lsettings;
+	bool				peer_empty;
 };
 
 #define LINKMODES_REPDATA(__reply_base) \
@@ -62,12 +62,10 @@ static int linkmodes_reply_size(const struct ethnl_req_info *req_base,
 {
 	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
 	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
+	const struct ethtool_link_settings *lsettings = &ksettings->base;
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
-	const struct ethtool_link_settings_hdr *lsettings;
 	int len, ret;
 
-	lsettings = &ksettings->base;
-
 	len = nla_total_size(sizeof(u8)) /* LINKMODES_AUTONEG */
 		+ nla_total_size(sizeof(u32)) /* LINKMODES_SPEED */
 		+ nla_total_size(sizeof(u32)) /* LINKMODES_LANES */
@@ -105,12 +103,10 @@ static int linkmodes_fill_reply(struct sk_buff *skb,
 {
 	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
 	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
+	const struct ethtool_link_settings *lsettings = &ksettings->base;
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
-	const struct ethtool_link_settings_hdr *lsettings;
 	int ret;
 
-	lsettings = &ksettings->base;
-
 	if (nla_put_u8(skb, ETHTOOL_A_LINKMODES_AUTONEG, lsettings->autoneg))
 		return -EMSGSIZE;
 
@@ -241,7 +237,7 @@ static int ethnl_update_linkmodes(struct genl_info *info, struct nlattr **tb,
 				  struct ethtool_link_ksettings *ksettings,
 				  bool *mod, const struct net_device *dev)
 {
-	struct ethtool_link_settings_hdr *lsettings = &ksettings->base;
+	struct ethtool_link_settings *lsettings = &ksettings->base;
 	bool req_speed, req_lanes, req_duplex;
 	const struct nlattr *master_slave_cfg, *lanes_cfg;
 	int ret;
-- 
2.34.1


