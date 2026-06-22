Return-Path: <netdev+bounces-301074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dlrmKRQfOWqbnAcAu9opvQ
	(envelope-from <netdev+bounces-301074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:40:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1155F6AF2BA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:40:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="P/jH1mxi";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301074-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301074-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B2483055C57
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866762D0617;
	Mon, 22 Jun 2026 11:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908AE2C375E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:34:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128082; cv=none; b=TcjeuSk2VvxO4lka+B0cHb4FYAecoL6sU7Fy/ZSaunvxUjazvZnuaPMN1dd9h1J37t8BdGRP9+2AJjvmWfN6P4ES+ZFLqJerQ/I7RK7bvA07Rd604b21niqv1eWQ2AcrseyxoYbdLKNf/JE9v54MnoeJGIlvup+AiMZWEfXug+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128082; c=relaxed/simple;
	bh=8X6ZyoFARiFIXPG3KZs4wKZ7276Ubb8j30paQJShhUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTMHkjISszzjvPaYjA9+xJsDeMQQK4AGYMRwFm06FGb7ldodUmTqWL8mpqq6LG20w79v21jg3nT3xUn2FDUwoIgxmpi3us/+Rw/UaDnSIphsS09D6FbBaZ5UvJnfmkjT7sAxa0XcFF1bdoVv0zuu7bNL5Xmi6pKpshmK5VyAHWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/jH1mxi; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782128079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXNuTNPNmFT0QAGIQtJNOKGzjACyu1h6mG5eONSQz4M=;
	b=P/jH1mxi2ssDKjiAt9NZPHX+1/GHNYMk46woRI+XMCT4uyjWaaFKS/vR0n3rJbl2t+ABF/
	nnanD/TbsTs0OS3HgypQ8jnIU6srtZKxeAa60BII//yHEeIl8/fIYQidS3KM2cu5yX+HTI
	LdVI80jlAusZFE2bz4CFj2u17Sl5BKU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-iuo1yOQ0MhOsqkXz5qUyfw-1; Mon,
 22 Jun 2026 07:34:38 -0400
X-MC-Unique: iuo1yOQ0MhOsqkXz5qUyfw-1
X-Mimecast-MFC-AGG-ID: iuo1yOQ0MhOsqkXz5qUyfw_1782128077
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB3AF195DE12;
	Mon, 22 Jun 2026 11:34:33 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3072195608D;
	Mon, 22 Jun 2026 11:34:32 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v2 1/2] ice: skip per-VLAN promisc rules when default VSI Rx rule is set
Date: Mon, 22 Jun 2026 13:34:27 +0200
Message-ID: <20260622113428.2565255-2-poros@redhat.com>
In-Reply-To: <20260622113428.2565255-1-poros@redhat.com>
References: <20260622113428.2565255-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301074-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1155F6AF2BA

When an ice port is part of a vlan-filtering bridge with a wide VLAN
trunk and the netdev is in IFF_PROMISC (typical for bond slaves
attached to a bridge), the driver installs per-VLAN
ICE_SW_LKUP_PROMISC_VLAN entries (recipe 9) in addition to the broad
ICE_SW_LKUP_DFLT VSI Rx rule (recipe 5). Each per-VLAN rule consumes
one Flow Lookup Unit (FLU) entry from a fixed hardware pool of "up to
32K FLU entries" per device, documented in the E810 datasheet
(613875-009 section 7.8.10, Table 7-18, page 1015).

With three active PFs sharing one switch context and a bridge trunk of
vid 2-4094, the configuration would require roughly

  3 PFs * 4093 VLANs * 3 rules per VLAN per PF ~= 36,800 rules

which exceeds the 32K FLU budget. Firmware then responds to further
Add Switch Rules requests with AQ retval 0x10 (LIBIE_AQ_RC_ENOSPC) and
the user-visible failure surfaces as

  ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
                    VSI, error -5
  ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule

After a switch context has been driven into overrun, subsequent
retries can come back as AQ retval 0x2 (LIBIE_AQ_RC_ENOENT), which has
misled triage attempts toward a perceived recipe binding defect
rather than a capacity issue.

When the DFLT VSI Rx rule is in place it catches every packet on the
lport regardless of VLAN tag, so the per-VLAN PROMISC_VLAN expansion
is redundant. The recipe 4 VLAN prune entries are still installed
per VLAN and continue to track the allowed VID set, but the
IFF_PROMISC sync path disables their enforcement on the VSI via
vlan_ops->dis_rx_filtering() before ice_set_promisc() runs.
ena_rx_filtering() is restored when IFF_PROMISC is cleared.

Skip the per-VLAN expansion at the two call sites that drive it:
ice_set_promisc() falls through to ice_fltr_set_vsi_promisc() and
ice_vlan_rx_add_vid() omits the per-VLAN ICE_MCAST_VLAN_PROMISC_BITS
add. Plain IFF_ALLMULTI without an installed DFLT VSI rule is
unchanged and still installs per-VLAN multicast promisc rules.

Both checks use ice_is_vsi_dflt_vsi() which inspects the recipe
filter list for an installed DFLT rule on this VSI, not
netdev->flags & IFF_PROMISC. The HW-state predicate avoids two
regression vectors that a user-intent predicate would introduce:

1. ice_lag_is_switchdev_running() short-circuits ice_set_dflt_vsi()
   to return 0 without installing the DFLT rule for a PF in
   switchdev LAG mode. An IFF_PROMISC-only check would also
   suppress the per-VLAN fallback, leaving the PF with no rule.

2. When ice_set_dflt_vsi() returns a non-EEXIST error (FLU
   exhausted, switch context divergence), the driver clears
   IFF_PROMISC from vsi->current_netdev_flags but the netdev's own
   flags retain IFF_PROMISC. The user-intent predicate would still
   suppress the per-VLAN fallback even though DFLT failed to
   install.

The predicate is install-time only. The IFF_PROMISC off path closes
the lifecycle gap in ice_vsi_exit_dflt_promisc(): for an IFF_ALLMULTI
VSI with VLANs it reinstates the per-VID rules before clearing the
default rule, so multicast coverage never lapses. If that AQ call
fails the default rule is left in place, ice_vsi_exit_dflt_promisc()
returns the error, and the sync_fltr pass bails with
vsi->current_netdev_flags |= IFF_PROMISC; the current/netdev flag
mismatch re-fires the IFF_PROMISC off path on the next sync. Clearing
the default rule first would instead expose a window where neither
the default rule nor the per-VID rules carry multicast.

If ice_clear_dflt_vsi() fails after the per-VID rules were reinstated
they are deliberately not rolled back. Clearing the default rule is a
removal that frees an FLU entry rather than allocating one, so it
cannot fail for lack of space; a failure is a transient AdminQ error.
The per-VID rules are the steady state for an IFF_ALLMULTI VLAN VSI,
so the only redundant entry left behind is the single un-removed
default rule, not the per-VID set. The retry re-enters this path,
ice_fltr_set_vlan_vsi_promisc() returns -EEXIST for the rules that
already exist so nothing is reallocated, and the default rule is
removed on the next attempt. Rolling the per-VID rules back here would
instead churn thousands of removes and re-adds on every retry.

After the default rule is gone the vid=0 PROMISC rule that paired
with it is redundant and is dropped, but only to reclaim a filter
entry, so a failure there is logged and does not abort the
transition.

ice_set_vsi_promisc() and ice_clear_vsi_promisc() dispatch the
recipe based on whether ICE_PROMISC_VLAN_RX/TX bits are present in
the mask: with the bits set, recipe ICE_SW_LKUP_PROMISC_VLAN is
used; otherwise ICE_SW_LKUP_PROMISC. The else branch in
ice_set_promisc() installs the vid=0 rule in ICE_SW_LKUP_PROMISC.
Because ice_clear_promisc() with VLANs present adds the VLAN bits
and would search ICE_SW_LKUP_PROMISC_VLAN, the recipe mismatch
would leave the vid=0 ICE_SW_LKUP_PROMISC rule orphaned when VLANs
are configured. This is a single stale rule, not a per-cycle leak:
re-adding it on the next promisc on returns -EEXIST rather than
allocating a new entry. The set-time recipe is not recorded, so
ice_clear_promisc() clears both recipes; clearing a rule that is not
present succeeds, both clears run unconditionally, and the first
error is returned.

The two VLAN-0 recipe transition blocks in ice_vlan_rx_add_vid()
and ice_vlan_rx_kill_vid() that promote / demote the vid=0 rule
between ICE_SW_LKUP_PROMISC and ICE_SW_LKUP_PROMISC_VLAN are
likewise guarded by !ice_is_vsi_dflt_vsi(). With DFLT in place the
vid=0 rule already covers every VID and a recipe swap would only
install a redundant rule.

Lab reproduction on an E810-C with the same firmware family (4.80,
NVM 1.3805.0, DDP 1.3.43.0) using four PFs in vlan-filtering bridges
with vid 2-4094 and the slaves brought to IFF_PROMISC before the
bridge VLAN bulk add:

  before fix:  ~12,279 AQ Add Switch Rules per PF, ENOSPC and ENOENT
               responses in dmesg, DFLT VSI Rx rule install fails on
               the affected PF
  after fix:   ~4,093 AQ Add Switch Rules per PF, no AQ errors, DFLT
               VSI Rx rule installs on every PF

The 66.7% reduction in installed switch rules per PF matches the
expected per-VLAN saving: a single DFLT rule replaces the per-VID
PROMISC_VLAN expansion.

Functional regression test with vid 2-100 trunk between two ice
ports through the lab switch (40/40 PASS, 0 AQ errors, 0 ENOSPC
at 4093-VID customer scale):

  vid 50 unicast, vid 100 unicast, vid 50 broadcast ARP,
    vid 100 multicast IPv6 ND
  vid 200/500/1500/4000 isolation (out-of-trunk) and untagged not
    leaked: 0 packets reach any bridge endpoint
  IGMP/MLD snooping, Jumbo MTU 9000, reserved-multicast STP BPDU
  IFF_PROMISC + IFF_ALLMULTI transition (off while allmulti stays)
  Regression reproducer for commit 1273f89578f2 ("ice: Fix broken
    IFF_ALLMULTI handling"): allmulti on -> add vid -> allmulti off
    -> allmulti on plus the orphan-rule Scenario 2; both converge
    with no stale rules
  100-VID, 1000-VID, 4093-VID stress cycles (5/3/2 iterations each)
  switchdev mode toggle preserves IFF_PROMISC pruning state across
    the session (vid 999 multicast received before and after the
    legacy -> switchdev -> legacy cycle)
  SR-IOV: VFs unaffected because ice_set_promisc() early-returns
    for non-PF VSI and VF representors do not register
    ndo_vlan_rx_add_vid

Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- No functional changes; collected the Reviewed-by.

v1: https://lore.kernel.org/all/89efbea9831175e6f57e9fe8557f7a0e48e050b7.1781786935.git.poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 90 ++++++++++++++++++-----
 1 file changed, 70 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6d24056c247cf4..af8df81fc45623 100644
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
@@ -304,9 +305,19 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
 		return 0;
 
 	if (ice_vsi_has_non_zero_vlans(vsi)) {
-		promisc_m |= (ICE_PROMISC_VLAN_RX | ICE_PROMISC_VLAN_TX);
+		int vid0_status;
+
+		/* set time used either recipe (per-VID PROMISC_VLAN, or vid=0
+		 * PROMISC via the ice_set_promisc() else branch), so clear
+		 * both; clearing an absent rule succeeds
+		 */
 		status = ice_fltr_clear_vlan_vsi_promisc(&vsi->back->hw, vsi,
-							 promisc_m);
+				promisc_m | ICE_PROMISC_VLAN_RX |
+				ICE_PROMISC_VLAN_TX);
+		vid0_status = ice_fltr_clear_vsi_promisc(&vsi->back->hw,
+							 vsi->idx, promisc_m, 0);
+		if (!status)
+			status = vid0_status;
 	} else {
 		status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
 						    promisc_m, 0);
@@ -317,6 +328,49 @@ static int ice_clear_promisc(struct ice_vsi *vsi, u8 promisc_m)
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
 /**
  * ice_vsi_sync_fltr - Update the VSI filter list to the HW
  * @vsi: ptr to the VSI
@@ -442,17 +496,12 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
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
@@ -3676,10 +3725,9 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
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
@@ -3697,11 +3745,12 @@ int ice_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
 	if (ret)
 		goto finish;
 
-	/* If all-multicast is currently enabled and this VLAN ID is only one
-	 * besides VLAN-0 we have to update look-up type of multicast promisc
-	 * rule for VLAN-0 from ICE_SW_LKUP_PROMISC to ICE_SW_LKUP_PROMISC_VLAN.
+	/* On the first non-zero VLAN, promote the VLAN-0 multicast promisc
+	 * rule from ICE_SW_LKUP_PROMISC to ICE_SW_LKUP_PROMISC_VLAN. Skip when
+	 * the DFLT Rx rule is installed; it already covers every VID.
 	 */
 	if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
+	    !ice_is_vsi_dflt_vsi(vsi) &&
 	    ice_vsi_num_non_zero_vlans(vsi) == 1) {
 		ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
 					   ICE_MCAST_PROMISC_BITS, 0);
@@ -3764,11 +3813,12 @@ int ice_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
 					   ICE_MCAST_VLAN_PROMISC_BITS, vid);
 
 	if (!ice_vsi_has_non_zero_vlans(vsi)) {
-		/* Update look-up type of multicast promisc rule for VLAN 0
-		 * from ICE_SW_LKUP_PROMISC_VLAN to ICE_SW_LKUP_PROMISC when
-		 * all-multicast is enabled and VLAN 0 is the only VLAN rule.
+		/* Last non-zero VLAN gone: demote the VLAN-0 multicast promisc
+		 * rule back to ICE_SW_LKUP_PROMISC. Skip when the DFLT Rx rule
+		 * is installed; no recipe swap is needed.
 		 */
-		if (vsi->current_netdev_flags & IFF_ALLMULTI) {
+		if ((vsi->current_netdev_flags & IFF_ALLMULTI) &&
+		    !ice_is_vsi_dflt_vsi(vsi)) {
 			ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx,
 						   ICE_MCAST_VLAN_PROMISC_BITS,
 						   0);
-- 
2.53.0


