Return-Path: <netdev+bounces-140137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9619B5567
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E0FB20155
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6267E20A5F0;
	Tue, 29 Oct 2024 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg0OzWJP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3199920A5EB;
	Tue, 29 Oct 2024 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239131; cv=none; b=lrnPOIKyNlGS4ShtbTJMM5Vn+7yPR7Ch+VY4m4l2TwzY6dTNphbuoZj/XVgXNpNWLqUfQqspJviUfS0VuYt7YXHManipqq3FVXhR85nPJuA7bMfgJFRIiOsnvOHAQgFjZBh5ZYnObwJD3ZnfLTD5nrt6euxAKYk5zyb2djyZn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239131; c=relaxed/simple;
	bh=TUo6BVTwEgK0jMk21tCwY3ID9VmRPyen/+VLfnQfL9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE7FHYVF0CrEOJHk+4HQpaOHa3Y1ID6y2RC4onQGzkSfL18UalwVkOcqOXY9XazOl6UpxBvQAj4eIgXJxUjQXzSQ0wbqYkaDU9gI0jqm6GuyPqFK3vodfwyrcMMUxpGRJ6taB08btigUgZBQBZ7z+2xalVWGz/n49J3dD7eu9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg0OzWJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81086C4CECD;
	Tue, 29 Oct 2024 21:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730239130;
	bh=TUo6BVTwEgK0jMk21tCwY3ID9VmRPyen/+VLfnQfL9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qg0OzWJPnukTntixOJy6XpQ0luNk6Lxh6mYTVLXE8xggrAXuTftPyLdLyXS93tAD2
	 M19Nx9y2dygO2BIKMuOuZZhJugtSJ9ynH7ePsfCIXXltGErVIc+EYJIqQogT5H4FMq
	 P2jq9qFLlNGUvM4+kk9eYVl4vyIlkkSkFGajNNBCVjQ9o/+ZzdsWnMvazFqfGB3EDU
	 cVl/tYjTdFBTLvTzL3WnEDixlScfI9c0c1UpLXa0eZwbzTPpgoCSGUo5Wet2CVZ4kI
	 g5V3KRHQ531hexPSn+U72ZlUyPfTO8ovohrTQMjLAxKxEyL586Hwr60zU99nE0Frqd
	 8m/LxOrtpTlDg==
Date: Tue, 29 Oct 2024 15:58:47 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Manish Chopra <manishc@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2][next] net: ethtool: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <0bc2809fe2a6c11dd4c8a9a10d9bd65cccdb559b.1730238285.git.gustavoars@kernel.org>
References: <cover.1730238285.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730238285.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Change the type of the middle struct member currently causing trouble from
`struct ethtool_link_settings` to `struct ethtool_link_settings_hdr`.

Additionally, update the type of some variables in various functions that
don't access the flexible-array member, changing them to the newly created
`struct ethtool_link_settings_hdr`. These changes are needed because the
type of the conflicting middle members changed. So, those instances that
expect the type to be `struct ethtool_link_settings` should be adjusted to
the newly created type `struct ethtool_link_settings_hdr`.

Also, adjust variable declarations to follow the reverse xmas tree
convention.

Fix 3338 of the following -Wflex-array-member-not-at-end warnings:

include/linux/ethtool.h:214:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update changelog text in patch to better reflect the changes
   made. (Jakub)
 - Adjust variable declarations to follow the reverse xmas tree
   convention. (Jakub) 

v1:
 - Link: https://lore.kernel.org/linux-hardening/f4f8ca5cd7f039bcab816194342c7b6101e891fe.1729536776.git.gustavoars@kernel.org/

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |  6 +++---
 .../net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c |  4 ++--
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c    |  2 +-
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |  2 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c    |  4 ++--
 include/linux/ethtool.h                        |  2 +-
 net/ethtool/ioctl.c                            |  2 +-
 net/ethtool/linkinfo.c                         |  8 ++++----
 net/ethtool/linkmodes.c                        | 18 +++++++++++-------
 9 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f71cc8188b4e..e0ebe69110bf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2781,7 +2781,7 @@ u32 bnxt_fw_to_ethtool_speed(u16 fw_link_speed)
 static void bnxt_get_default_speeds(struct ethtool_link_ksettings *lk_ksettings,
 				    struct bnxt_link_info *link_info)
 {
-	struct ethtool_link_settings *base = &lk_ksettings->base;
+	struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
 
 	if (link_info->link_state == BNXT_LINK_STATE_UP) {
 		base->speed = bnxt_fw_to_ethtool_speed(link_info->link_speed);
@@ -2800,7 +2800,7 @@ static void bnxt_get_default_speeds(struct ethtool_link_ksettings *lk_ksettings,
 static int bnxt_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *lk_ksettings)
 {
-	struct ethtool_link_settings *base = &lk_ksettings->base;
+	struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
 	enum ethtool_link_mode_bit_indices link_mode;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_link_info *link_info;
@@ -3023,9 +3023,9 @@ u16 bnxt_get_fw_auto_link_speeds(const unsigned long *mode)
 static int bnxt_set_link_ksettings(struct net_device *dev,
 			   const struct ethtool_link_ksettings *lk_ksettings)
 {
+	const struct ethtool_link_settings_hdr *base = &lk_ksettings->base;
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_link_info *link_info = &bp->link_info;
-	const struct ethtool_link_settings *base = &lk_ksettings->base;
 	bool set_pause = false;
 	u32 speed, lanes = 0;
 	int rc = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 7f3f5afa864f..45d28a65347e 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -662,8 +662,8 @@ static unsigned int lmm_to_fw_caps(const unsigned long *link_mode_mask)
 static int get_link_ksettings(struct net_device *dev,
 			      struct ethtool_link_ksettings *link_ksettings)
 {
+	struct ethtool_link_settings_hdr *base = &link_ksettings->base;
 	struct port_info *pi = netdev_priv(dev);
-	struct ethtool_link_settings *base = &link_ksettings->base;
 
 	/* For the nonce, the Firmware doesn't send up Port State changes
 	 * when the Virtual Interface attached to the Port is down.  So
@@ -717,9 +717,9 @@ static int get_link_ksettings(struct net_device *dev,
 static int set_link_ksettings(struct net_device *dev,
 			    const struct ethtool_link_ksettings *link_ksettings)
 {
+	const struct ethtool_link_settings_hdr *base = &link_ksettings->base;
 	struct port_info *pi = netdev_priv(dev);
 	struct link_config *lc = &pi->link_cfg;
-	const struct ethtool_link_settings *base = &link_ksettings->base;
 	struct link_config old_lc;
 	unsigned int fw_caps;
 	int ret = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 2fbe0f059a0b..61d08547e3f9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -1436,8 +1436,8 @@ static void fw_caps_to_lmm(enum fw_port_type port_type,
 static int cxgb4vf_get_link_ksettings(struct net_device *dev,
 				  struct ethtool_link_ksettings *link_ksettings)
 {
+	struct ethtool_link_settings_hdr *base = &link_ksettings->base;
 	struct port_info *pi = netdev_priv(dev);
-	struct ethtool_link_settings *base = &link_ksettings->base;
 
 	/* For the nonce, the Firmware doesn't send up Port State changes
 	 * when the Virtual Interface attached to the Port is down.  So
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index f7986f2b6a17..4fe85780a950 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -129,8 +129,8 @@ static void enic_intr_coal_set_rx(struct enic *enic, u32 timer)
 static int enic_get_ksettings(struct net_device *netdev,
 			      struct ethtool_link_ksettings *ecmd)
 {
+	struct ethtool_link_settings_hdr *base = &ecmd->base;
 	struct enic *enic = netdev_priv(netdev);
-	struct ethtool_link_settings *base = &ecmd->base;
 
 	ethtool_link_ksettings_add_link_mode(ecmd, supported,
 					     10000baseT_Full);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 97b059be1041..24ff154285ac 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -508,7 +508,7 @@ static int qede_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *cmd)
 {
 	typeof(cmd->link_modes) *link_modes = &cmd->link_modes;
-	struct ethtool_link_settings *base = &cmd->base;
+	struct ethtool_link_settings_hdr *base = &cmd->base;
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qed_link_output current_link;
 
@@ -541,7 +541,7 @@ static int qede_get_link_ksettings(struct net_device *dev,
 static int qede_set_link_ksettings(struct net_device *dev,
 				   const struct ethtool_link_ksettings *cmd)
 {
-	const struct ethtool_link_settings *base = &cmd->base;
+	const struct ethtool_link_settings_hdr *base = &cmd->base;
 	const struct ethtool_forced_speed_map *map;
 	struct qede_dev *edev = netdev_priv(dev);
 	struct qed_link_output current_link;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 12f6dc567598..1199e308c8dd 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -211,7 +211,7 @@ void ethtool_rxfh_context_lost(struct net_device *dev, u32 context_id);
  * fields, but they are allowed to overwrite them (will be ignored).
  */
 struct ethtool_link_ksettings {
-	struct ethtool_link_settings base;
+	struct ethtool_link_settings_hdr base;
 	struct {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5cc131cdb1bc..7da94e26ced6 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -425,7 +425,7 @@ convert_link_ksettings_to_legacy_settings(
 
 /* layout of the struct passed from/to userland */
 struct ethtool_link_usettings {
-	struct ethtool_link_settings base;
+	struct ethtool_link_settings_hdr base;
 	struct {
 		__u32 supported[__ETHTOOL_LINK_MODE_MASK_NU32];
 		__u32 advertising[__ETHTOOL_LINK_MODE_MASK_NU32];
diff --git a/net/ethtool/linkinfo.c b/net/ethtool/linkinfo.c
index 30b8ce275159..2d5bc57160be 100644
--- a/net/ethtool/linkinfo.c
+++ b/net/ethtool/linkinfo.c
@@ -8,9 +8,9 @@ struct linkinfo_req_info {
 };
 
 struct linkinfo_reply_data {
-	struct ethnl_reply_data		base;
-	struct ethtool_link_ksettings	ksettings;
-	struct ethtool_link_settings	*lsettings;
+	struct ethnl_reply_data			base;
+	struct ethtool_link_ksettings		ksettings;
+	struct ethtool_link_settings_hdr	*lsettings;
 };
 
 #define LINKINFO_REPDATA(__reply_base) \
@@ -98,7 +98,7 @@ static int
 ethnl_set_linkinfo(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct ethtool_link_ksettings ksettings = {};
-	struct ethtool_link_settings *lsettings;
+	struct ethtool_link_settings_hdr *lsettings;
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
 	bool mod = false;
diff --git a/net/ethtool/linkmodes.c b/net/ethtool/linkmodes.c
index 259cd9ef1f2a..17e49cf89f03 100644
--- a/net/ethtool/linkmodes.c
+++ b/net/ethtool/linkmodes.c
@@ -11,10 +11,10 @@ struct linkmodes_req_info {
 };
 
 struct linkmodes_reply_data {
-	struct ethnl_reply_data		base;
-	struct ethtool_link_ksettings	ksettings;
-	struct ethtool_link_settings	*lsettings;
-	bool				peer_empty;
+	struct ethnl_reply_data			base;
+	struct ethtool_link_ksettings		ksettings;
+	struct ethtool_link_settings_hdr	*lsettings;
+	bool					peer_empty;
 };
 
 #define LINKMODES_REPDATA(__reply_base) \
@@ -62,10 +62,12 @@ static int linkmodes_reply_size(const struct ethnl_req_info *req_base,
 {
 	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
 	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
-	const struct ethtool_link_settings *lsettings = &ksettings->base;
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	const struct ethtool_link_settings_hdr *lsettings;
 	int len, ret;
 
+	lsettings = &ksettings->base;
+
 	len = nla_total_size(sizeof(u8)) /* LINKMODES_AUTONEG */
 		+ nla_total_size(sizeof(u32)) /* LINKMODES_SPEED */
 		+ nla_total_size(sizeof(u32)) /* LINKMODES_LANES */
@@ -103,10 +105,12 @@ static int linkmodes_fill_reply(struct sk_buff *skb,
 {
 	const struct linkmodes_reply_data *data = LINKMODES_REPDATA(reply_base);
 	const struct ethtool_link_ksettings *ksettings = &data->ksettings;
-	const struct ethtool_link_settings *lsettings = &ksettings->base;
 	bool compact = req_base->flags & ETHTOOL_FLAG_COMPACT_BITSETS;
+	const struct ethtool_link_settings_hdr *lsettings;
 	int ret;
 
+	lsettings = &ksettings->base;
+
 	if (nla_put_u8(skb, ETHTOOL_A_LINKMODES_AUTONEG, lsettings->autoneg))
 		return -EMSGSIZE;
 
@@ -237,7 +241,7 @@ static int ethnl_update_linkmodes(struct genl_info *info, struct nlattr **tb,
 				  struct ethtool_link_ksettings *ksettings,
 				  bool *mod, const struct net_device *dev)
 {
-	struct ethtool_link_settings *lsettings = &ksettings->base;
+	struct ethtool_link_settings_hdr *lsettings = &ksettings->base;
 	bool req_speed, req_lanes, req_duplex;
 	const struct nlattr *master_slave_cfg, *lanes_cfg;
 	int ret;
-- 
2.43.0


