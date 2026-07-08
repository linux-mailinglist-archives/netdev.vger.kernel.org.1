Return-Path: <netdev+bounces-305808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zIoJIuBJTmoHKQIAu9opvQ
	(envelope-from <netdev+bounces-305808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:00:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 188827268CA
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Vl0Ax1sP;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305808-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305808-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6720C304A699
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817F4508F7;
	Wed,  8 Jul 2026 12:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CE9478846
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 12:58:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515498; cv=none; b=IV9gG8aIsflcPznL4p+biRZxqzN5LC3n/OAheu4G1E2IaPqEtgCDGOVx+gK8zWjZdX9O0sA8dR/QfIdcBcR5SgRfHP4F/5YOFVJVtUMK4YqmJ6V7Qaz/CYCAcAlOVGPKkg+ouizSGcidMmlTSMH2N13BOiHUU5LuIpQfft8BMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515498; c=relaxed/simple;
	bh=hS6CECWyr6qlHFutdtP1hx4GVQCHogJxgFVEdyX2UyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz4n7o6sBg3tMK34IfWfAs0k0EBxw+1YQTL2Ro7XZD+lP9sCJvu4XiE+kmFKIalD5hLsAIUEZJbdVVaU0n+bHKbDvWG251Xxu/4jAq7+mU2B24PMDNEZGLZcGiAdNW1gtXkR+oR55p8KdIIDXQM5w+sR2DWKDmBoidkhtXKtvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vl0Ax1sP; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783515495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOICHt1OIeEkSPFglSYe8rsXFOyGOkVBxzGa9CU+V/k=;
	b=Vl0Ax1sPT7HRZjmbRBE3qPZtntTcvpPGylvLV2nCRz4DV7zXzcSUQBdFMuEqKtRRgmzDFP
	qTOwF5syqHBDAXtni0qH8IvoI/fKuy+lWPToPyoOkiZeRF/XPqdo8yc57FCBDsMe1KfPaF
	Qmxsac/e++asDWbAaoDZHUxHeTG+fX8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-E79b9dnZM52bULJZQIV53w-1; Wed,
 08 Jul 2026 08:58:12 -0400
X-MC-Unique: E79b9dnZM52bULJZQIV53w-1
X-Mimecast-MFC-AGG-ID: E79b9dnZM52bULJZQIV53w_1783515490
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EF9F1955F44;
	Wed,  8 Jul 2026 12:58:10 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.48.104])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C37A180066F;
	Wed,  8 Jul 2026 12:58:05 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alice Michael <alice.michael@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v4 1/2] ice: skip per-VLAN promisc rules when default VSI Rx rule is set
Date: Wed,  8 Jul 2026 14:57:54 +0200
Message-ID: <20260708125755.706263-2-poros@redhat.com>
In-Reply-To: <20260708125755.706263-1-poros@redhat.com>
References: <20260708125755.706263-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305808-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:alice.michael@intel.com,m:jacob.e.keller@intel.com,m:ivecera@redhat.com,m:horms@kernel.org,m:martyna.szapar-mudlaw@linux.intel.com,m:marcin.szycik@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 188827268CA

When an ice port in a vlan-filtering bridge goes promiscuous (typical for
bond slaves), the driver installs a per-VLAN ICE_SW_LKUP_PROMISC_VLAN rule
for every VID on top of the broad ICE_SW_LKUP_DFLT VSI Rx rule. Each rule
consumes one of the ~32K Flow Lookup Unit (FLU) entries the device shares
across PFs, so a wide trunk (vid 2-4094) over several PFs overruns the
pool: firmware rejects further Add Switch Rules with ENOSPC (AQ 0x10) and
the DFLT Rx rule itself fails to install:

  ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
                    VSI, error -5
  ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule

Once a switch context is overrun the retries can also come back as ENOENT
(AQ 0x2), which has misled triage toward a perceived recipe binding defect
rather than a capacity issue.

The DFLT rule already catches every packet on the port regardless of VLAN
tag, so the per-VLAN promisc expansion is redundant while it is installed.
Skip it at the two sites that drive it, ice_set_promisc() and
ice_vlan_rx_add_vid(), keyed on ice_is_vsi_dflt_vsi() rather than the
netdev IFF_PROMISC flag so a failed or LAG-suppressed DFLT install still
falls back to the per-VLAN rules.

IFF_ALLMULTI and IFF_PROMISC can reach ice_vsi_sync_fltr() in separate
passes (a bridge join sets them through separate calls), so the allmulti
pass may expand the per-VID rules before the DFLT rule exists. Drop those
now-redundant rules right after ice_set_dflt_vsi() installs the DFLT rule;
ice_vsi_exit_dflt_promisc() reinstates them when promisc is cleared.

ice_vsi_sync_fltr() subscribed multicast promiscuity only inside the
"default VSI not yet in use" branch, so a promiscuous VSI that finds the
default VSI rule already present (owned by another VSI, or preserved
across a switchdev session) ended up in unicast promisc with no multicast
subscription. Issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the
netdev is promiscuous; it is idempotent and returns 0 if the rule is
already present.

Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v4 (review comments from Marcin Szycik):
- Reworded the ice_clear_promisc() and the per-VID cleanup comments.
- Flipped the ice_vsi_clear_vlan_mc_promisc() guard to an early return to
  reduce indentation, and noted that the clear is best-effort.
No functional change.

v3: https://lore.kernel.org/all/20260701133601.2118382-2-poros@redhat.com/
v2: https://lore.kernel.org/all/20260622113428.2565255-2-poros@redhat.com/
v1: https://lore.kernel.org/all/89efbea9831175e6f57e9fe8557f7a0e48e050b7.1781786935.git.poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 109 +++++++++++++++++-----
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b43d420ece99ca..f1fef26eeadac9 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -274,7 +274,8 @@ static int ice_set_promisc(struct ice_vsi *vsi, u8 promisc_m)
 	if (vsi->type != ICE_VSI_PF)
 		return 0;
 
-	if (ice_vsi_has_non_zero_vlans(vsi)) {
+	/* skip per-VID expansion; the DFLT Rx rule already covers every VID */
+	if (ice_vsi_has_non_zero_vlans(vsi) && !ice_is_vsi_dflt_vsi(vsi)) {
 		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
 		status = ice_fltr_set_vlan_vsi_promisc(&vsi->back->hw, vsi,
 						       promisc_m);
@@ -304,9 +305,20 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
 		return 0;
 
 	if (ice_vsi_has_non_zero_vlans(vsi)) {
-		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
+		u8 vlan_promisc_m = promisc_m | ICE_PROMISC_VLAN_RX |
+				    ICE_PROMISC_VLAN_TX;
+		int vid0_status;
+
+		/* the vid=0 rule may be in either recipe (the recipe used to
+		 * set it is not recorded), so clear both; clearing an absent
+		 * rule returns 0
+		 */
 		status = ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
-							 promisc_m);
+							 vlan_promisc_m);
+		vid0_status = ice_fltr_clear_vsi_promisc(&vsi->back->hw,
+							 vsi->idx, promisc_m, 0);
+		if (!status)
+			status = vid0_status;
 	} else {
 		status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
 						    promisc_m, 0);
@@ -317,6 +329,61 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
 	return status;
 }
 
+/**
+ * ice_vsi_exit_dflt_promisc - drop the default VSI Rx rule on promisc off
+ * @vsi: the VSI leaving promiscuous mode
+ *
+ * For an IFF_ALLMULTI VSI with VLANs the per-VID multicast rules are
+ * reinstated before the default rule is cleared so coverage never lapses;
+ * the then redundant vid=0 rule is dropped best-effort. The callees log
+ * their own failures, so error returns are not re-logged here.
+ *
+ * Return: 0 on success, negative on error with the default rule left in place.
+ */
+static int ice_vsi_exit_dflt_promisc(struct ice_vsi *vsi)
+{
+	struct ice_vsi_vlan_ops *vlan_ops = ice_get_compat_vsi_vlan_ops(vsi);
+	struct net_device *netdev = vsi->netdev;
+	struct ice_hw *hw = &vsi->back->hw;
+	bool restore_mc;
+	int err;
+
+	restore_mc = (vsi->current_netdev_flags & IFF_ALLMULTI) &&
+		     ice_vsi_has_non_zero_vlans(vsi);
+
+	if (restore_mc) {
+		err = ice_fltr_set_vlan_vsi_promisc(hw, vsi,
+						    ICE_MCAST_VLAN_PROMISC_BITS);
+		if (err && err != -EEXIST)
+			return err;
+	}
+
+	err = ice_clear_dflt_vsi(vsi);
+	if (err)
+		return err;
+
+	if (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		vlan_ops->ena_rx_filtering(vsi);
+
+	if (restore_mc)
+		ice_fltr_clear_vsi_promisc(hw, vsi->idx, ICE_MCAST_PROMISC_BITS,
+					   0);
+
+	return 0;
+}
+
+/* Drop the per-VID multicast promisc rules made redundant by the default
+ * VSI Rx rule; best-effort, a leftover is harmless while that rule stands.
+ */
+static void ice_vsi_clear_vlan_mc_promisc(struct ice_vsi *vsi)
+{
+	if (!ice_vsi_has_non_zero_vlans(vsi))
+		return;
+
+	ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
+					ICE_MCAST_VLAN_PROMISC_BITS);
+}
+
 /**
  * ice_vsi_sync_fltr - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
@@ -429,30 +496,31 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
 				err = 0;
 				vlan_ops->dis_rx_filtering(vsi);
 
-				/* promiscuous mode implies allmulticast so
-				 * that VSIs that are in promiscuous mode are
-				 * subscribed to multicast packets coming to
-				 * the port
+				/* a prior allmulti pass may have added per-VID
+				 * rules now covered by the DFLT rule
 				 */
-				err = ice_set_promisc(vsi,
-						      ICE_MCAST_PROMISC_BITS);
-				if (err)
-					goto out_promisc;
+				ice_vsi_clear_vlan_mc_promisc(vsi);
 			}
+
+			/* Promiscuous mode implies allmulticast. Subscribe
+			 * the VSI to all multicast even when the default VSI
+			 * rule is already in use and the block above is
+			 * skipped (it may be owned by another VSI, or
+			 * preserved across a switchdev session); the unicast
+			 * catch-all does not cover the multicast subscription.
+			 */
+			err = ice_set_promisc(vsi, ICE_MCAST_PROMISC_BITS);
+			if (err)
+				goto out_promisc;
 		} else {
 			/* Clear Rx filter to remove traffic from wire */
 			if (ice_is_vsi_dflt_vsi(vsi)) {
-				err = ice_clear_dflt_vsi(vsi);
+				err = ice_vsi_exit_dflt_promisc(vsi);
 				if (err) {
-					netdev_err(netdev, "Error %d clearing default VSI %i Rx rule\n",
-						   err, vsi->vsi_num);
 					vsi->current_netdev_flags |=
 						IFF_PROMISC;
 					goto out_promisc;
 				}
-				if (vsi->netdev->features &
-				    NETIF_F_HW_VLAN_CTAG_FILTER)
-					vlan_ops->ena_rx_filtering(vsi);
 			}
 
 			/* disable allmulti here, but only if allmulti is not
@@ -3676,10 +3744,9 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	while (test_and_set_bit(ICE_CFG_BUSY, vsi->state))
 		usleep_range(1000, 2000);
 
-	/* Add multicast promisc rule for the VLAN ID to be added if
-	 * all-multicast is currently enabled.
-	 */
-	if (vsi->current_netdev_flags & IFF_ALLMULTI) {
+	/* skip the per-VID rule when the DFLT Rx rule already covers this VID */
+	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
+	    !ice_is_vsi_dflt_vsi(vsi)) {
 		ret = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx,
 					       ICE_MCAST_VLAN_PROMISC_BITS,
 					       vid);
-- 
2.54.0


