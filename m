Return-Path: <netdev+bounces-303678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 07C9HC8gRWrI7QoAu9opvQ
	(envelope-from <netdev+bounces-303678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABC6EE8DE
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:11:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Qmqlk3wO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303678-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303678-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82AC730B2E60
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DFD4949E0;
	Wed,  1 Jul 2026 13:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C149250B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 13:36:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912990; cv=none; b=TZ3X6TPT0fEN3OOAEco9z/kJVvOiCRs4Z6iYXtNwIlF90HSLrWhUcVUGfvry72QbvdgVlD/UAG+CmStNiXXaiulnybPs6/Ii1saIEINE5r5z8jRJlJHJ68vN/y6WhreW4IlHVjjykvpHzrwJUhCvYQCKR1nbymDmZXCBVLjHq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912990; c=relaxed/simple;
	bh=Hjw3sRrnHXJgJRf4LESpaU+TTsO62EHbXTHSieIZZX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeVJfc3rPT+HiK9tTuNHdF8ickzxO0HLMgJMnY8KL8RPbBsTNYEKm1h1D/oVdPqaFeHGiNFSn0tWSDnXYnmcdPpdn+60ooTc9pgHRWHUxhBchJDFb76taeAbw9psuRrZ1iv/zMhUDus6Ar+++6xlmsaJzsDs7vkqYFkuyFt3RPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qmqlk3wO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782912986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FaQqKWe1A+SJoHq5B5QalZHgHJG98WSXNQHkK70ytgM=;
	b=Qmqlk3wOOkn7k8ZGZFxDku0wOEHWHicNTEcVVS74FMI7E95Rz3cn1xBNC0BPkOAkBZrG8B
	IbuxH7Zm5Mlcl2jRZoerEhIviZ1/Jn3bHCYh0n0yYpfsXA6eTe30yuLGwwL413zfEU8xLu
	Fn1Dt37ZWLk5xjdgVUXvhzjBx14vo9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-FKf5wlHyPC2FqAvItdaLFg-1; Wed,
 01 Jul 2026 09:36:23 -0400
X-MC-Unique: FKf5wlHyPC2FqAvItdaLFg-1
X-Mimecast-MFC-AGG-ID: FKf5wlHyPC2FqAvItdaLFg_1782912980
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5E5A1954237;
	Wed,  1 Jul 2026 13:36:19 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2EAD3180076D;
	Wed,  1 Jul 2026 13:36:14 +0000 (UTC)
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
	Ivan Vecera <ivecera@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v3 2/2] ice: preserve uplink DFLT Rx rule on switchdev release
Date: Wed,  1 Jul 2026 15:36:01 +0200
Message-ID: <20260701133601.2118382-3-poros@redhat.com>
In-Reply-To: <20260701133601.2118382-1-poros@redhat.com>
References: <20260701133601.2118382-1-poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303678-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ivecera@redhat.com,m:jacob.e.keller@intel.com,m:alice.michael@intel.com,m:horms@kernel.org,m:martyna.szapar-mudlaw@linux.intel.com,m:marcin.szycik@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FABC6EE8DE

When the uplink PF is promiscuous, ice_vsi_sync_fltr() installs an
ICE_SW_LKUP_DFLT catch-all Rx rule on the uplink VSI. Entering switchdev
re-affirms it through the idempotent ice_set_dflt_vsi(), but
ice_eswitch_release_env() removed both the Rx and Tx DFLT rules
unconditionally on teardown. That clobbered a promisc-owned Rx rule: it
disappeared while IFF_PROMISC was still set and the sync path was not
retriggered, leaving the uplink without the catch-all the netdev
requested.

Skip the Rx DFLT removal when the uplink is promiscuous, both in
ice_eswitch_release_env() and the err_def_tx unwind of
ice_eswitch_setup_env(); the Tx leg, owned by switchdev, is still removed.
Test the live netdev->flags, the same value ena_rx_filtering() ->
ice_cfg_vlan_pruning() above already keys on, so the preserved rule and
the pruning state stay consistent, including for a promisc change made
while switchdev ran (which never reached the gated filter sync).

Fixes: 5c07be96d8b3 ("ice: Avoid setting default Rx VSI twice in switchdev setup")
Signed-off-by: Petr Oros <poros@redhat.com>
---
v3:
- Corrected the Fixes tag from 1a1c40df2e80 ("ice: set and release
  switchdev environment") to 5c07be96d8b3 ("ice: Avoid setting default
  Rx VSI twice in switchdev setup"), the commit that made
  ice_eswitch_setup_env() use the idempotent ice_set_dflt_vsi(); before
  it a pre-existing promisc DFLT rule made setup fail with -EEXIST so the
  release path was never reached. No code change.

v2: https://lore.kernel.org/all/20260622113428.2565255-3-poros@redhat.com/
v1: https://lore.kernel.org/all/deef5756e534ef06c12d910c5305d3fd205d30a0.1781786935.git.poros@redhat.com/
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index c30e27bbfe6e25..07e2016fb9481f 100644
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
@@ -276,8 +278,16 @@ static void ice_eswitch_release_env(struct ice_pf *pf)
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
2.54.0


