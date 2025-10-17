Return-Path: <netdev+bounces-230325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66025BE6954
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59B324FCB95
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4D31987A;
	Fri, 17 Oct 2025 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y25DMYw4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C03148D4;
	Fri, 17 Oct 2025 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681468; cv=none; b=JtNcK5AdXMPqC+TBk4qX/uAnDHFdkkeDxVrwHs14EaRja14iWAbv/jw2uKLX4RsrBHPnQscFKFMW7dI4N3V0w54vCLwKj+fF150sL8j0QW78o5qiaFv4OVO3L+8dUS5POO4Md+s1np4Z4Z+07qQ+N4G7iQyMHIC1+a5fUIcLQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681468; c=relaxed/simple;
	bh=PfFyxtAXmVzgm7ySD5/ARxlZjDDMhRPDwlNCiLIixDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dkziaBOGnEbuJmcb1HxJrGOpQ2FJM35SdQVMm8k6HVCqTxXsx2xCDMiLueiCCV1rj5wZrt/lyXHUAm+iLwpmRTh+75DHUsWSwuMQpczLLSmoMUuGvryfmsiXKRoeCro3f7SNTnqSncvjVOoV5Qy7R3WAJm/b/LL2tQ11OuEb1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y25DMYw4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760681465; x=1792217465;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PfFyxtAXmVzgm7ySD5/ARxlZjDDMhRPDwlNCiLIixDs=;
  b=Y25DMYw471p+b6XItAc/ONJ0CjhCB+IWK+FXWOuihuSadbIpaAcxDlVX
   0hXaSFjIVdyHoh4rK8biOxCNiK4/Qo+I1Cliw4fLxVew+/9rxgOyINPS2
   3qCEHAK25x42dbuUcoF9PZkEzqG7/RM/Fu4Nxkvk2exqTGFtSzG7D04Ih
   oo/3bZbSkLuEdCiBe63jJF3xrZuOoE9wGAX4iFGafGep36wjnMfLB4JWW
   kFa2Ryt75gIEBU+62AjOHyVtF3BhSGTGCpDtocOFz/HkPSHrMdf8o9Bvv
   cqXENAb8ebImseP5euy3tHXeyxoQ9sow425EbPmg37P/xAt22dNnRI08p
   g==;
X-CSE-ConnectionGUID: LBhhxV6VTj2jWskneRZfmw==
X-CSE-MsgGUID: QQd+ykPFQvGzbFBuDzHSNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="50454017"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="50454017"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:55 -0700
X-CSE-ConnectionGUID: FnRR1meHS7S6a4czO6U6dQ==
X-CSE-MsgGUID: rwrNF+yqQzKL+NJrjZO7PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="183059514"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 23:10:55 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Oct 2025 23:08:41 -0700
Subject: [PATCH net-next v2 12/14] ice: refactor to use helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-jk-iwl-next-2025-10-15-v2-12-ff3a390d9fc6@intel.com>
References: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
In-Reply-To: <20251016-jk-iwl-next-2025-10-15-v2-0-ff3a390d9fc6@intel.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>, jbrandeburg@cloudflare.com
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=11520;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=MHa9O69pa1NbdBgHw5fZGpMA1oGHUNyCZVP8K7pBpGo=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhoyPd1+6XueZnVK750Gk5I9Pa79HK+0Q3bRc4U57/uHbf
 4Nj/3++1VHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBElmczMuxJez5nzpF1O9hL
 Mmy1TuYFvP6bHc2z6dabvuSKJdWloqcYGa5KtIX1vjh837tOL8L4ZoDLC6cHC38G5jixzX38b/o
 zRmYA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Use the ice_netdev_to_pf() helper in more places and remove a bunch of
boilerplate code. Not every instance could be replaced due to use of the
netdev_priv() output or the vsi variable within a bunch of functions.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c   | 48 ++++++++------------------
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c |  8 ++---
 drivers/net/ethernet/intel/ice/ice_lag.c       |  3 +-
 drivers/net/ethernet/intel/ice/ice_main.c      | 10 ++----
 drivers/net/ethernet/intel/ice/ice_ptp.c       |  6 ++--
 drivers/net/ethernet/intel/ice/ice_sriov.c     |  3 +-
 6 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 75492a720c68..cb34d4675a78 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -794,8 +794,7 @@ static int ice_get_extended_regs(struct net_device *netdev, void *p)
 static void
 ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	u32 *regs_buf = (u32 *)p;
 	unsigned int i;
@@ -810,8 +809,7 @@ ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 
 static u32 ice_get_msglevel(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 #ifndef CONFIG_DYNAMIC_DEBUG
 	if (pf->hw.debug_mask)
@@ -824,8 +822,7 @@ static u32 ice_get_msglevel(struct net_device *netdev)
 
 static void ice_set_msglevel(struct net_device *netdev, u32 data)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 #ifndef CONFIG_DYNAMIC_DEBUG
 	if (ICE_DBG_USER & data)
@@ -840,16 +837,14 @@ static void ice_set_msglevel(struct net_device *netdev, u32 data)
 static void ice_get_link_ext_stats(struct net_device *netdev,
 				   struct ethtool_link_ext_stats *stats)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	stats->link_down_events = pf->link_down_events;
 }
 
 static int ice_get_eeprom_len(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	return (int)pf->hw.flash.flash_size;
 }
@@ -858,9 +853,7 @@ static int
 ice_get_eeprom(struct net_device *netdev, struct ethtool_eeprom *eeprom,
 	       u8 *bytes)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	struct device *dev;
 	int ret;
@@ -959,8 +952,7 @@ static u64 ice_link_test(struct net_device *netdev)
  */
 static u64 ice_eeprom_test(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	netdev_info(netdev, "EEPROM test\n");
 	return !!(ice_nvm_validate_checksum(&pf->hw));
@@ -1274,9 +1266,8 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
  */
 static u64 ice_loopback_test(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
-	struct ice_pf *pf = orig_vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct ice_vsi *test_vsi;
 	u8 *tx_frame __free(kfree) = NULL;
 	u8 broadcast[ETH_ALEN], ret = 0;
 	int num_frames, valid_frames;
@@ -1365,8 +1356,7 @@ static u64 ice_loopback_test(struct net_device *netdev)
  */
 static u64 ice_intr_test(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	u16 swic_old = pf->sw_int_count;
 
 	netdev_info(netdev, "interrupt test\n");
@@ -1394,9 +1384,8 @@ static void
 ice_self_test(struct net_device *netdev, struct ethtool_test *eth_test,
 	      u64 *data)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	bool if_running = netif_running(netdev);
-	struct ice_pf *pf = np->vsi->back;
 	struct device *dev;
 
 	dev = ice_pf_to_dev(pf);
@@ -1720,9 +1709,7 @@ static int ice_nway_reset(struct net_device *netdev)
  */
 static u32 ice_get_priv_flags(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	u32 i, ret_flags = 0;
 
 	for (i = 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++) {
@@ -4417,9 +4404,7 @@ static int
 ice_get_module_info(struct net_device *netdev,
 		    struct ethtool_modinfo *modinfo)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_hw *hw = &pf->hw;
 	u8 sff8472_comp = 0;
 	u8 sff8472_swap = 0;
@@ -4491,12 +4476,10 @@ static int
 ice_get_module_eeprom(struct net_device *netdev,
 		      struct ethtool_eeprom *ee, u8 *data)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 #define SFF_READ_BLOCK_SIZE 8
 	u8 value[SFF_READ_BLOCK_SIZE] = { 0 };
 	u8 addr = ICE_I2C_EEPROM_DEV_ADDR;
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
 	bool is_sfp = false;
 	unsigned int i, j;
@@ -4774,8 +4757,7 @@ static void ice_get_ts_stats(struct net_device *netdev,
  */
 static int ice_ethtool_reset(struct net_device *dev, u32 *flags)
 {
-	struct ice_netdev_priv *np = netdev_priv(dev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	enum ice_reset_req reset;
 
 	switch (*flags) {
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index f21b9f86a049..10fdc9f32db5 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -574,9 +574,7 @@ ice_destroy_tunnel(struct ice_hw *hw, u16 index, enum ice_tunnel_type type,
 int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
 			    unsigned int idx, struct udp_tunnel_info *ti)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	enum ice_tunnel_type tnl_type;
 	int status;
 	u16 index;
@@ -598,9 +596,7 @@ int ice_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
 int ice_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
 			      unsigned int idx, struct udp_tunnel_info *ti)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	enum ice_tunnel_type tnl_type;
 	int status;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index aebf8e08a297..d2576d606e10 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2177,8 +2177,7 @@ static void ice_lag_chk_disabled_bond(struct ice_lag *lag, void *ptr)
  */
 static void ice_lag_disable_sriov_bond(struct ice_lag *lag)
 {
-	struct ice_netdev_priv *np = netdev_priv(lag->netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(lag->netdev);
 
 	ice_clear_feature_support(pf, ICE_F_SRIOV_LAG);
 	ice_clear_feature_support(pf, ICE_F_SRIOV_AA_LAG);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3d5615caf6d1..ca95b8800bb3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8074,9 +8074,7 @@ static int
 ice_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 		   struct net_device *dev, u32 filter_mask, int nlflags)
 {
-	struct ice_netdev_priv *np = netdev_priv(dev);
-	struct ice_vsi *vsi = np->vsi;
-	struct ice_pf *pf = vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	u16 bmode;
 
 	bmode = pf->first_sw->bridge_mode;
@@ -8146,8 +8144,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		   u16 __always_unused flags,
 		   struct netlink_ext_ack __always_unused *extack)
 {
-	struct ice_netdev_priv *np = netdev_priv(dev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	struct nlattr *attr, *br_spec;
 	struct ice_hw *hw = &pf->hw;
 	struct ice_sw *pf_sw;
@@ -9581,8 +9578,7 @@ ice_indr_setup_tc_cb(struct net_device *netdev, struct Qdisc *sch,
  */
 int ice_open(struct net_device *netdev)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	if (ice_is_reset_in_progress(pf->state)) {
 		netdev_err(netdev, "can't open net device while reset is in progress");
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4f50e952bfb5..985b3e79b312 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2215,8 +2215,7 @@ static int ice_ptp_getcrosststamp(struct ptp_clock_info *info,
 int ice_ptp_hwtstamp_get(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return -EIO;
@@ -2287,8 +2286,7 @@ int ice_ptp_hwtstamp_set(struct net_device *netdev,
 			 struct kernel_hwtstamp_config *config,
 			 struct netlink_ext_ack *extack)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	int err;
 
 	if (pf->ptp.state != ICE_PTP_READY)
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 843e82fd3bf9..6b1126ddb561 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1190,8 +1190,7 @@ ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event)
  */
 int ice_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool ena)
 {
-	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_pf *pf = np->vsi->back;
+	struct ice_pf *pf = ice_netdev_to_pf(netdev);
 	struct ice_vsi *vf_vsi;
 	struct device *dev;
 	struct ice_vf *vf;

-- 
2.51.0.rc1.197.g6d975e95c9d7


