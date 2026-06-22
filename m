Return-Path: <netdev+bounces-301073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lM0PKx0fOWqcnAcAu9opvQ
	(envelope-from <netdev+bounces-301073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:40:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0C6AF2BF
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XlfEA+qv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301073-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301073-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E013055C0F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6D2C032E;
	Mon, 22 Jun 2026 11:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2952D0C7B
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:34:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128082; cv=none; b=QDF0A/I5jfKFx+EUFClY2bsw/MRm3Fsd8G97xuzJ5NhxkwswNHszc87LlpTb9CZeLwvKtfPUT9XaTHfx6+cEm0pwBqzR2/s96eTunmI+jyNsBw5cRedd+9gA7l03dT2M+yDHSs21UasVhy5KZGWcqXHTFQ/FRLl6gP1oRifr630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128082; c=relaxed/simple;
	bh=NoWDhDBoNRbbiGmxxgaWMOVPkECSfLdZtuu8eAL2jjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+oj5iTlnFySE62oi3MvTFLeejUWex4Vz+aQ9ZoA8+3ukDeoWJsSI2WzI0apygiJUT0b8eD6JjQRjc823Wr80V8VQXhIiyY/RyAxrcgFFjZMGwtnq2y0IEJ0NEQLEAGMJdavb5dA3ebRBkcpi0PlmL9FQqD/RNMzpLFOvfTkjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlfEA+qv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782128079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NauiKu2rkPRKqMllROR4VesbGag7e2HnHJoylFBV24=;
	b=XlfEA+qvmgRpU6crPnfIdYdKzJrDWtLItBYzybeAijbPgshMcfhbA+eK7yZfvDMN50wRpf
	2VaLFIDLZfVLamDG7sA86aoFpLuMflVqiy38hz0wRK4w3sE3iC/GG+oXMBCmEPIKnEPwjK
	1EGg8xyjQ1v8GJQF2UWUti1YSSxwkGM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-zb2xTyO8OoqePGaQLS_Tmg-1; Mon,
 22 Jun 2026 07:34:38 -0400
X-MC-Unique: zb2xTyO8OoqePGaQLS_Tmg-1
X-Mimecast-MFC-AGG-ID: zb2xTyO8OoqePGaQLS_Tmg_1782128077
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3927A1955F30
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:34:35 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 46B0D195608D;
	Mon, 22 Jun 2026 11:34:34 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>
Subject: [PATCH iwl-net v2 2/2] ice: preserve uplink DFLT Rx rule on switchdev release
Date: Mon, 22 Jun 2026 13:34:28 +0200
Message-ID: <20260622113428.2565255-3-poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301073-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BF0C6AF2BF

ice_eswitch_setup_env() calls ice_set_dflt_vsi() to install the
ICE_SW_LKUP_DFLT Rx rule on the uplink VSI. The helper returns 0 even
when the rule is already in place, so the call is a no-op if
ice_vsi_sync_fltr() had previously installed the DFLT rule in response
to IFF_PROMISC on the uplink netdev. ice_remove_vsi_fltr() called
earlier in ice_eswitch_setup_env() does not affect this rule because
ice_remove_vsi_lkup_fltr() lacks a case for ICE_SW_LKUP_DFLT and falls
into its default branch which only logs. Switchdev mode then adds an
ICE_FLTR_TX leg via ice_cfg_dflt_vsi() on the same VSI handle.

ice_eswitch_release_env() unconditionally removed both the Rx and Tx
DFLT rules. When the Rx DFLT was installed by ice_vsi_sync_fltr()
before the switchdev session started, this clobbered promisc state the
operator had asked for: the DFLT Rx rule disappeared while IFF_PROMISC
was still set on the netdev, and the IFF_PROMISC sync path was not
retriggered, so the uplink ended the session without the catch-all
rule the netdev flags requested.

Skip the Rx DFLT removal when the uplink is promiscuous, both in
ice_eswitch_release_env() and in the err_def_tx unwind of
ice_eswitch_setup_env(). The Tx leg installed by switchdev is always
removed since switchdev owns it.

Test the live netdev->flags for this decision. The ena_rx_filtering()
call right above in ice_eswitch_release_env() reaches
ice_cfg_vlan_pruning(), which already keys on the live netdev->flags
IFF_PROMISC bit, so reusing the same value keeps the preserved DFLT
rule and the VLAN pruning state mutually consistent across every
promisc transition, including one the operator made while switchdev
ran: ice_set_rx_mode() is gated off for the uplink during the session,
so such a change never reaches the filter sync, but it is reflected in
netdev->flags and is therefore honored here on release.

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v2:
- Reworked the fix to avoid the service task entirely. v1 scheduled a
  filter sync in ice_eswitch_disable_switchdev() to reconcile the uplink
  DFLT Rx rule; that work could run after ice_remove() freed the uplink
  VSI (use-after-free) and was not guaranteed to fire if ice_set_rx_mode()
  never ran again. v2 keeps or drops the DFLT Rx rule synchronously in
  ice_eswitch_release_env() (and the setup_env error unwind) by testing
  the live netdev->flags IFF_PROMISC, the same value ice_cfg_vlan_pruning()
  already keys on, so the preserved rule and the pruning state stay
  consistent. No service task is scheduled and no symbol is exported.
- Dropped the Reviewed-by since the fix mechanism changed.

v1: https://lore.kernel.org/all/deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f77..48273ef9f69dc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
 err_def_tx:
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+	/* keep the Rx DFLT rule if the uplink is promiscuous (see release_env) */
+	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
 err_def_rx:
 	ice_vsi_del_vlan_zero(uplink_vsi);
 err_vlan_zero:
@@ -278,8 +280,16 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+
+	/* Keep the Rx DFLT rule if the uplink is promiscuous; it must outlive
+	 * the session. Test the live netdev->flags, the same value
+	 * ena_rx_filtering() -> ice_cfg_vlan_pruning() above keys its decision
+	 * on, so the preserved DFLT rule and the pruning state stay consistent.
+	 */
+	if (!(uplink_vsi->netdev->flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
+
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
-- 
2.53.0


