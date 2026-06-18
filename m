Return-Path: <netdev+bounces-300471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f8HtEQ0LNGqsLwYAu9opvQ
	(envelope-from <netdev+bounces-300471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:13:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983E56A1254
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:13:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IY2SbNsz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300471-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300471-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1361308A2FA
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7E9364EBF;
	Thu, 18 Jun 2026 15:09:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E903F413D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:09:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795378; cv=none; b=AGkkCqGrFjnJaRjJiumrRYROC+rfWe5NUZ6/0JMWHYJy+3CltaWqb2VSYei1mzoPNA8vjeLiMv++2QK1kIAB4gGDLm4te+b5ZjlSOzv/IB1HIZn1wiKv0dqZpQHY2FbbVvpt7DukXzhGqUjtf1hAIX0wer8QPdWy5jczFRyq8Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795378; c=relaxed/simple;
	bh=nzGZJFbhBOm1hddP5+9aFdF3xlsdHhiFkZ1/wpBDTTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgzmW6VL2RKihyOYWNWD4d2nrvdcEYMYG2ydfAXK1KPaZwiucCYAjzjV6Xjkgv5yFdKKwCQMsN2eLJJRxVQbMZ2I1A6RECW0DA3RZlpfwILSXx6R1Uu6R9PcPcxVPlxUKoW5i7E55wqEI7tgH9p0eW3Lo+6cTa8jk5X21/j2vZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IY2SbNsz; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781795376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzYZekGzO/AOSypQh+DSKpcUdDPg1Q6wQEiH39OSTDI=;
	b=IY2SbNszfayrypwdoEB4cLv2bTavGgA6Eyx3mzt6X+W1Ur9+aD6TMg/S7vLV0FHbzT0kh3
	3jCVTiy4s95BJCIfDJue8zpdH+5LYnFMafHeaLtzSSRVwBweCt+Wcm817SAzgVfP3ebXWu
	UkbqgYAu7/MOqZ+ZPXxWy4WpbKUvvEQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-kM1hXvrUMpuq9N-QMvgNkw-1; Thu,
 18 Jun 2026 11:09:31 -0400
X-MC-Unique: kM1hXvrUMpuq9N-QMvgNkw-1
X-Mimecast-MFC-AGG-ID: kM1hXvrUMpuq9N-QMvgNkw_1781795369
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE5718011C0;
	Thu, 18 Jun 2026 15:09:28 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.243])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAB8B1800675;
	Thu, 18 Jun 2026 15:09:24 +0000 (UTC)
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 2/2] ice: preserve uplink DFLT Rx rule on switchdev release
Date: Thu, 18 Jun 2026 17:09:11 +0200
Message-ID: <deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com>
In-Reply-To: <cover.1781786935.git.poros@redhat.com>
References: <cover.1781786935.git.poros@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300471-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:alice.michael@intel.com,m:jacob.e.keller@intel.com,m:ivecera@redhat.com,m:michal.swiatkowski@linux.intel.com,m:grzegorz.nitka@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 983E56A1254

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

Skip the Rx DFLT removal when the uplink is still promiscuous, both in
ice_eswitch_release_env() and in the err_def_tx unwind of
ice_eswitch_setup_env(). The Tx leg installed by switchdev is always
removed since switchdev owns it.

The ena_rx_filtering() call earlier in ice_eswitch_release_env() is
left unconditional: it calls ice_cfg_vlan_pruning(), which returns
without enabling pruning while the netdev is in IFF_PROMISC, so it
cannot re-enable VLAN pruning under the preserved DFLT rule and drop
tagged traffic. Pruning is re-enabled later, when the IFF_PROMISC sync
path runs after promisc is actually cleared.

Use vsi->current_netdev_flags rather than the live netdev->flags for
this test. netdev->flags is written under RTNL by dev_change_flags(),
while ice_eswitch_release_env() runs under devl_lock, so reading it
here would be a TOCTOU against a concurrent promisc change. The
IFF_PROMISC bit of current_netdev_flags is written only under
ICE_CFG_BUSY by ice_vsi_sync_fltr(), and ice_set_rx_mode() gates that
sync off for the uplink while ice_is_switchdev_running() is true. The
bit is therefore frozen for the whole session and stable when
release_env reads it.

Because the sync is gated off during the session, a promisc change the
operator makes while switchdev runs never reaches ice_vsi_sync_fltr():
current_netdev_flags keeps the value captured before the session while
netdev->flags carries the new one. Once switchdev is torn down and
pf->eswitch.is_running is cleared, schedule a filter sync from
ice_eswitch_disable_switchdev() so the suppressed change is replayed
and the DFLT Rx rule is reconciled with the current netdev flags. This
also closes the window where release_env kept the rule based on the
frozen flag but the operator had since cleared IFF_PROMISC.

Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 32 +++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e4f0969035f77..b6073fc2375019 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -66,8 +66,10 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
 err_def_tx:
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+	/* keep the Rx DFLT rule if still promiscuous (see release_env) */
+	if (!(uplink_vsi->current_netdev_flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
 err_def_rx:
 	ice_vsi_del_vlan_zero(uplink_vsi);
 err_vlan_zero:
@@ -275,11 +277,23 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
 	vlan_ops = ice_get_compat_vsi_vlan_ops(uplink_vsi);
 
 	ice_vsi_update_local_lb(uplink_vsi, false);
+	/* No-op while IFF_PROMISC is set: ice_cfg_vlan_pruning() self-gates on
+	 * it, so this cannot re-enable VLAN pruning under a preserved DFLT rule.
+	 */
 	vlan_ops->ena_rx_filtering(uplink_vsi);
 	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
 			 ICE_FLTR_TX);
-	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
-			 ICE_FLTR_RX);
+
+	/* Keep the Rx DFLT rule if the uplink is still promiscuous; it must
+	 * outlive the session. current_netdev_flags is used because its
+	 * IFF_PROMISC bit only changes under ice_vsi_sync_fltr(), gated off
+	 * during switchdev, so the read cannot race the RTNL netdev->flags.
+	 * Any change made during the session is replayed on teardown.
+	 */
+	if (!(uplink_vsi->current_netdev_flags & IFF_PROMISC))
+		ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx,
+				 false, ICE_FLTR_RX);
+
 	ice_fltr_add_mac_and_broadcast(uplink_vsi,
 				       uplink_vsi->port_info->mac.perm_addr,
 				       ICE_FWD_TO_VSI);
@@ -327,10 +341,20 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
  */
 static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 {
+	struct ice_vsi *uplink_vsi = pf->eswitch.uplink_vsi;
+
 	ice_eswitch_br_offloads_deinit(pf);
 	ice_eswitch_release_env(pf);
 
 	pf->eswitch.is_running = false;
+
+	/* ice_set_rx_mode() was gated off during the session; replay a filter
+	 * sync so any suppressed promisc change reconciles the DFLT Rx rule.
+	 */
+	set_bit(ICE_VSI_UMAC_FLTR_CHANGED, uplink_vsi->state);
+	set_bit(ICE_VSI_MMAC_FLTR_CHANGED, uplink_vsi->state);
+	set_bit(ICE_FLAG_FLTR_SYNC, pf->flags);
+	ice_service_task_schedule(pf);
 }
 
 /**
-- 
2.53.0


