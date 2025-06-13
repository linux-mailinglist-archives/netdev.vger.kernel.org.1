Return-Path: <netdev+bounces-197276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45270AD7FF4
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDCF3AAD9F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6061DE8A4;
	Fri, 13 Jun 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsxLI3+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B91DE4FC
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749776498; cv=none; b=fSZrT8z2r8abJO/AxfSoc6KINkla7MNlgbnvznvZOcifPrX8104+fJo+awQ3+KjWPfewpkXSyKt1bRmMcMd9ORh7SGihsca0RPvGRxfQpZgu274TkHKTXdEC6w1EjDAFl0qQH0D3oAd7Nrcr92CnOnVwfzMrnnyU2cZHIdpkfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749776498; c=relaxed/simple;
	bh=HK2AeD3XJ4OWXWWBdY5aiiZ6qWJ669IK5xUN6wC3TG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq4ObnY7EDh1QNY4vjU1UcwgY1vWEOMeYICCmI3Ax+7qjmNqp1+m4RMCb/HYuYL6BQA1NsAaXeHJu7mCnuQuYYCGQjiX3ODOdN22YeJ/VR54D8bCShx05t3Y59Lr3ia2ORd6XXArO/Fo1GOIyLJ7aAwg0OoY5ydBXda17Y0YvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsxLI3+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403ADC4CEEB;
	Fri, 13 Jun 2025 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749776497;
	bh=HK2AeD3XJ4OWXWWBdY5aiiZ6qWJ669IK5xUN6wC3TG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsxLI3+pe5sKoj5g3g7RHkRjdkw66QkD9Gx1V+7AjK4Oc7XPaiUkZ9oYK9+XaVqty
	 hv/mb0SNq/3cQTc4w8sDWKnPAztLBddw6XXagv8WDKZVk4vRZ+wyMQwOFnFyhWXZ/9
	 X+kxeDdxgqN5tnNCMdDnVJ3nlzecQD3bVGx2PRZivecLn8Zo46COyU99/Fr34AUxH7
	 M9pDK/GMVHpSgtBDoPcHGUAvg7PW/8WyGlPKu7TDIa7b9RR7Ir/dsyGJBO/tbDdYSj
	 T1Gf3G8N9ayoISP1U+b2iau23InCdvtwPnd5HjBVHdkTkfvRmBQZpRFcYXCrB2YHl3
	 aBImPc98XMccg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/7] eth: i40e: migrate to new RXFH callbacks
Date: Thu, 12 Jun 2025 18:01:09 -0700
Message-ID: <20250613010111.3548291-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613010111.3548291-1-kuba@kernel.org>
References: <20250613010111.3548291-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

I'm deleting all the boilerplate kdoc from the affected functions.
It is somewhere between pointless and incorrect, just a burden for
people refactoring the code.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 38 +++++++------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c7f2d85eafcd..2ff17d50135c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3139,15 +3139,12 @@ static int i40e_set_per_queue_coalesce(struct net_device *netdev, u32 queue,
 	return __i40e_set_coalesce(netdev, ec, queue);
 }
 
-/**
- * i40e_get_rss_hash_opts - Get RSS hash Input Set for each flow type
- * @pf: pointer to the physical function struct
- * @cmd: ethtool rxnfc command
- *
- * Returns Success if the flow is supported, else Invalid Input.
- **/
-static int i40e_get_rss_hash_opts(struct i40e_pf *pf, struct ethtool_rxnfc *cmd)
+static int i40e_get_rxfh_fields(struct net_device *netdev,
+				struct ethtool_rxfh_fields *cmd)
 {
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	u8 flow_pctype = 0;
 	u64 i_set = 0;
@@ -3545,9 +3542,6 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 		cmd->data = vsi->rss_size;
 		ret = 0;
 		break;
-	case ETHTOOL_GRXFH:
-		ret = i40e_get_rss_hash_opts(pf, cmd);
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = pf->fdir_pf_active_filters;
 		/* report total rule count */
@@ -3576,7 +3570,7 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
  * Returns value of bits to be set per user request
  **/
 static u64 i40e_get_rss_hash_bits(struct i40e_hw *hw,
-				  struct ethtool_rxnfc *nfc,
+				  const struct ethtool_rxfh_fields *nfc,
 				  u64 i_setc)
 {
 	u64 i_set = i_setc;
@@ -3621,15 +3615,13 @@ static u64 i40e_get_rss_hash_bits(struct i40e_hw *hw,
 }
 
 #define FLOW_PCTYPES_SIZE 64
-/**
- * i40e_set_rss_hash_opt - Enable/Disable flow types for RSS hash
- * @pf: pointer to the physical function struct
- * @nfc: ethtool rxnfc command
- *
- * Returns Success if the flow input set is supported.
- **/
-static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
+static int i40e_set_rxfh_fields(struct net_device *netdev,
+				const struct ethtool_rxfh_fields *nfc,
+				struct netlink_ext_ack *extack)
 {
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	u64 hena = (u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(0)) |
 		   ((u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(1)) << 32);
@@ -4964,13 +4956,9 @@ static int i40e_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
 	struct i40e_vsi *vsi = np->vsi;
-	struct i40e_pf *pf = vsi->back;
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = i40e_set_rss_hash_opt(pf, cmd);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		ret = i40e_add_fdir_ethtool(vsi, cmd);
 		break;
@@ -5846,6 +5834,8 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.get_rxfh_indir_size	= i40e_get_rxfh_indir_size,
 	.get_rxfh		= i40e_get_rxfh,
 	.set_rxfh		= i40e_set_rxfh,
+	.get_rxfh_fields	= i40e_get_rxfh_fields,
+	.set_rxfh_fields	= i40e_set_rxfh_fields,
 	.get_channels		= i40e_get_channels,
 	.set_channels		= i40e_set_channels,
 	.get_module_info	= i40e_get_module_info,
-- 
2.49.0


