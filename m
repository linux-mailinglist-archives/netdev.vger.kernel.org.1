Return-Path: <netdev+bounces-304645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 54J5MMP7R2oLigAAu9opvQ
	(envelope-from <netdev+bounces-304645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:13:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B992E704CA9
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:13:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=RPZFUpkt;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304645-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304645-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3A353016AC7
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AC3128D5;
	Fri,  3 Jul 2026 18:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A9F247291;
	Fri,  3 Jul 2026 18:09:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102165; cv=none; b=SQuUG3j/0rj4rtvGg9rMrrsq4D8hq9egCPZAg+neQrhhXjVGDyluOPmttK5WgNFGcJOyxskF22Qoin+376ylZJYylKUWQqZtst0LbDx1qm8Us8EFNUjQIMaCfVt41OJLSWZtbIWU0qnvPiQaRJk48VQBWMgyUjg2QDKluvGaIhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102165; c=relaxed/simple;
	bh=UVy3/H0RMuEKNl5Vs6NEqyAwXoJIsI4AzdpjTFTi9yQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgvSuO76JfHxqJKVN6l3J948qvmx+3wx5Xv2pWJssxiaMgwAbn5c/291svuXGGnehM2/608FxqEqKzAKlcq8wbWZDDXRRvU7vhWoqQd5WaGOWAxe4BvpcdUcxH569N5ZiGvdx4zijhV1mPpB96ye30IRqnBk0Nr3egfY4MSDZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=RPZFUpkt; arc=none smtp.client-ip=173.37.86.79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8939; q=dns/txt;
  s=iport01; t=1783102164; x=1784311764;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CXMacmSzG4Vh/h4v1BbunYRM6XQpMQSp/sageLt5vm4=;
  b=RPZFUpktKyBNlpsRUp32JfqNFKDlaltF3cNsR+NFcgxYwvvvA6buQmNf
   cRSRQHeZQDiFwpNUXbo2mGJ2ueO1Gc7hPj30KyLceN93vM+COfM0rOGJ+
   aRJn4YlpVjxgSqA307bQ3brWS9qMSK9K7DfHEUXD1OtyHeMBQtZAKltLd
   x7hpz/IKTWC7tGL0auqO5iO6Xf9xXCV16L9ro/F+8GZPLMVuJ1yD1rais
   wMspo/IAquZ6f+qsTyjWDKww2FlKXqBBWkLnplr3hv21ULkPpzMP/PGZZ
   K5LzGfo3rS4TItyFI3drb4X7QrFVPPsSJTYzm6LMSzZJSkXNbwhBJ50vj
   Q==;
X-CSE-ConnectionGUID: lRJ2xc+iSjCESqgG5jRG2w==
X-CSE-MsgGUID: 2p9p1DqSSWW/ZrTX5M/F8Q==
X-IPAS-Result: =?us-ascii?q?A0BHAgBN+kdq/5P/Ja1aglmCV4FSQ0mEV49TgiGRTYxRF?=
 =?us-ascii?q?IFqDwEBAQ9RBAEBhQYCjUsCJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBA?=
 =?us-ascii?q?QIBBwWBDhOGXIZbAgEDIwQLATQSECUCJgICRhAGARKDAoJ0A7wKen8zgQGEf?=
 =?us-ascii?q?dlGgWYBCxQBgQouhXGCagGBcIQGO4RBJxuBSUSBFYNphAUag3+CagSDHBKCS?=
 =?us-ascii?q?I5XCT+BAhwDWSwBVRMNCgsHBWFSMwMgCgsSEhgVAhQcEw8EFjIdcAwQFxIsF?=
 =?us-ascii?q?zRYGwcFgR2BFTEEIYEEhHkjHwM5f4EwdUp5M4ECARIeCoFSgSYDCxgNSBEsN?=
 =?us-ascii?q?wYOGwQ9AW4HjQAXD4FMagc9DjAUQjkxAXsFMJMLHYN+jkqBNZ9ahCeBZqAPA?=
 =?us-ascii?q?TKXZ4xVhjCZCCOjTBJZhGiBaDyBWTMaCBsVgyJTGQ+OLRYc0h4nMj0CBwIHD?=
 =?us-ascii?q?gMLkXmBbAEB?=
IronPort-Data: A9a23:RL/qWaBTHKHmmRVW/+niw5YqxClBgxIJ4kV8jS/XYbTApDok1zMAn
 2EdCmqBMvuLNGf8edonaN+/9UoAu8PQyoNiOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYAD9gGYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEx89MVlE9fowj+M1aOnhB2
 qEaEh9XcUXW7w626OrTpuhEnM8vKozveYgYoHwllGmfBvc9SpeFSKLPjTNa9G5v3YYVQrCEO
 pdfMGYwBPjDS0Un1lM/E5sinfyohXnXeDxDo1XTrq0yi4TW5FAgjuGwYIaIKrRmQ+0PhheA/
 07fxF/GPVYoLuCvlB/C3CKV07qncSTTHdh6+KeD3vJjnlCW7mAaFhATUVy1vb+/h1LWc99TN
 kkd6Ccyhac180OvQ5/2WBjQiH2ZtBc0WNdKFeA+rgaXxcL86gCVHGUbDThMdNArqucyWDosk
 FSJ9/vxDDZitry9U3+R9r6I6zi1PEA9KW4EeD9BTgYf5dTniJ88gwiJTdt5FqOxyNrvFlnYx
 T2WoCUgr6scgNRN1Kih+13DxTW2qfD0ohUd/A7bWCehqwh+foPgPtTu4lnA5vEGJ4GcJrWcg
 EU5dwGlxLhmJfmweOalGo3hwJnBCy65DQDh
IronPort-HdrOrdr: A9a23:rueWs65D+HBORn7TDwPXwD7XdLJyesId70hD6qm+c20wTiX+ra
 GTdZUguyMc5wx9ZJhNo7q90ey7MBHhHP1OjrX5Q43DYOCOggLBR72Kr7GSoAEIcBeTygcy79
 YET4FOTPD9ElR+i9/3+02bH8ZI+qj/zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefnghOXNALu
 v62uN34xy9ZH8QcsO3QlMBX+TFupn3saiOW29/O/bigzP+9w9BL9XBYmOl4is=
X-Talos-CUID: =?us-ascii?q?9a23=3A/2eS2GpcM4v8ReMV4U0zScnmUcQfUCfNxzTRGE2?=
 =?us-ascii?q?TJF1wR5LIS2W/orwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABzz/rw7zRF5ysAy6jtYrmzymxowy+/W2UWwUqq4?=
 =?us-ascii?q?5hI62LxBAZhLaomSOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="496158458"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:09:01 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id C1A76180008AC;
	Fri,  3 Jul 2026 18:09:00 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:08:57 -0700
Subject: [PATCH net-next v11 08/12] enic: add MBOX PF handlers for VF
 register and capability
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-8-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=9297;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=UVy3/H0RMuEKNl5Vs6NEqyAwXoJIsI4AzdpjTFTi9yQ=;
 b=q68ELivdQNSx6vA1PGeAM7J1wjuKxCjS+bBO1IHfmqjDbUyKwZmDIT1O2HsOZwXa6l7+S2Wxd
 0dELI8fWD6XBs2V6a1iewxhqoaIX7x013Z5zn5/Dtp+tGXClXytaUDt
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-10.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebaddel@cisco.com,m:satishkh@cisco.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B992E704CA9

Implement PF-side mailbox message processing for SR-IOV V2
admin channel communication.

When the PF receives messages from VFs, the dispatch routes
them to type-specific handlers:
  - VF_CAPABILITY_REQUEST: reply with protocol version 1
  - VF_REGISTER_REQUEST: send the register reply, mark the
    VF registered on success, then send PF_LINK_STATE_NOTIF
    reflecting the PF's current carrier state
  - VF_UNREGISTER_REQUEST: mark VF unregistered, send reply
  - PF_LINK_STATE_ACK: log errors from VF acknowledgment

Per-VF state (struct enic_vf_state) is tracked via enic->vf_state
which will be allocated when SRIOV V2 is enabled.

Remove the CONFIG_PCI_IOV guard from num_vfs in struct enic. The
PF handlers reference enic->num_vfs for VF ID bounds checking in
enic_mbox.c, which is compiled unconditionally. The field must be
visible regardless of CONFIG_PCI_IOV to avoid build failures.

Add enic_mbox_send_link_state() helper for PF-initiated link
state notifications, also used later by ndo_set_vf_link_state.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |   7 +-
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 190 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   1 +
 3 files changed, 194 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index b009d87da4bd..d459318c46fc 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -256,9 +256,7 @@ struct enic {
 	struct enic_rx_coal rx_coalesce_setting;
 	u32 rx_coalesce_usecs;
 	u32 tx_coalesce_usecs;
-#ifdef CONFIG_PCI_IOV
 	u16 num_vfs;
-#endif
 	enum enic_vf_type vf_type;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
@@ -315,6 +313,11 @@ struct enic {
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
+
+	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
+	struct enic_vf_state {
+		bool registered;
+	} *vf_state;
 };
 
 static inline struct net_device *vnic_get_netdev(struct vnic_dev *vdev)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 3709704bee02..b6f05b03ae26 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -135,10 +135,183 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 	return err;
 }
 
+int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
+{
+	struct enic_mbox_pf_link_state_notif_msg notif = {};
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs ||
+	    !enic->vf_state[vf_id].registered) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: skip link state to unregistered VF %u\n",
+			   vf_id);
+		return 0;
+	}
+
+	notif.link_state = cpu_to_le32(link_state);
+	return enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_NOTIF, vf_id,
+				  &notif, sizeof(notif));
+}
+
+static int enic_mbox_pf_handle_capability(struct enic *enic, void *msg,
+					  u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_capability_reply_msg reply = {};
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	reply.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
+
+	return enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REPLY, vf_id,
+				  &reply, sizeof(reply));
+}
+
+static int enic_mbox_pf_handle_register(struct enic *enic, void *msg,
+					u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_register_reply_msg reply = {};
+	u32 link_state;
+	int err;
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: register from invalid VF %u\n",
+				    vf_id);
+		return -EINVAL;
+	}
+
+	/* VF re-registering (e.g. guest reboot without clean unregister):
+	 * mark the previous registration inactive before accepting the new one.
+	 */
+	if (enic->vf_state[vf_id].registered) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: VF %u re-register, cleaning previous state\n",
+			   vf_id);
+		enic->vf_state[vf_id].registered = false;
+	}
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REPLY, vf_id,
+				 &reply, sizeof(reply));
+	if (err)
+		return err;
+
+	enic->vf_state[vf_id].registered = true;
+	if (net_ratelimit())
+		netdev_info(enic->netdev, "VF %u registered via MBOX\n", vf_id);
+
+	link_state = netif_carrier_ok(enic->netdev) ?
+		ENIC_MBOX_LINK_STATE_ENABLE :
+		ENIC_MBOX_LINK_STATE_DISABLE;
+	err = enic_mbox_send_link_state(enic, vf_id, link_state);
+	if (err && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "VF %u: failed to send initial link state: %d\n",
+			    vf_id, err);
+	/* Registration succeeded; initial link state notification sent
+	 * above.  Subsequent link state changes are sent from the PF
+	 * when enic_link_check() detects carrier changes.
+	 */
+	return 0;
+}
+
+static int enic_mbox_pf_handle_unregister(struct enic *enic, void *msg,
+					  u16 vf_id, u64 msg_num)
+{
+	struct enic_mbox_vf_register_reply_msg reply = {};
+	int err;
+
+	if (!enic->vf_state || vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: unregister from invalid VF %u\n",
+				    vf_id);
+		return -EINVAL;
+	}
+
+	/* VF is unloading; clear local state regardless of whether
+	 * the reply is successfully delivered to avoid the PF treating
+	 * a dead VF as still registered.
+	 */
+	enic->vf_state[vf_id].registered = false;
+
+	reply.reply.ret_major = cpu_to_le16(0);
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REPLY, vf_id,
+				 &reply, sizeof(reply));
+
+	if (net_ratelimit())
+		netdev_info(enic->netdev,
+			    "VF %u unregistered via MBOX\n", vf_id);
+
+	return err;
+}
+
+static void enic_mbox_pf_process_msg(struct enic *enic,
+				     struct enic_mbox_hdr *hdr, void *payload)
+{
+	u16 vf_id = le16_to_cpu(hdr->src_vnic_id);
+	u16 msg_len = le16_to_cpu(hdr->msg_len);
+	int err = 0;
+
+	if (!enic->vf_state) {
+		netdev_dbg(enic->netdev,
+			   "MBOX: PF received msg but SRIOV not active\n");
+		return;
+	}
+
+	if (vf_id >= enic->num_vfs) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: PF received msg from invalid VF %u\n",
+				    vf_id);
+		return;
+	}
+
+	switch (hdr->msg_type) {
+	case ENIC_MBOX_VF_CAPABILITY_REQUEST:
+		err = enic_mbox_pf_handle_capability(enic, payload, vf_id,
+						     le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_VF_REGISTER_REQUEST:
+		err = enic_mbox_pf_handle_register(enic, payload, vf_id,
+						   le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_VF_UNREGISTER_REQUEST:
+		err = enic_mbox_pf_handle_unregister(enic, payload, vf_id,
+						     le64_to_cpu(hdr->msg_num));
+		break;
+	case ENIC_MBOX_PF_LINK_STATE_ACK: {
+		struct enic_mbox_pf_link_state_ack_msg *ack = payload;
+
+		if (msg_len < sizeof(*hdr) + sizeof(*ack))
+			break;
+		if (le16_to_cpu(ack->ack.ret_major) && net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: VF %u link state ACK error %u/%u\n",
+				    vf_id,
+				    le16_to_cpu(ack->ack.ret_major),
+				    le16_to_cpu(ack->ack.ret_minor));
+		break;
+	}
+	default:
+		netdev_dbg(enic->netdev,
+			   "MBOX: PF unhandled msg type %u from VF %u\n",
+			   hdr->msg_type, vf_id);
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	if (err && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "MBOX: PF handler for msg type %u from VF %u failed: %d\n",
+			    hdr->msg_type, vf_id, err);
+}
+
 static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 				   unsigned int len)
 {
 	struct enic_mbox_hdr *hdr = buf;
+	void *payload;
+	u16 msg_len;
 
 	if (len < sizeof(*hdr)) {
 		if (net_ratelimit())
@@ -156,10 +329,23 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 		return;
 	}
 
+	msg_len = le16_to_cpu(hdr->msg_len);
+	if (msg_len < sizeof(*hdr) || msg_len > len) {
+		if (net_ratelimit())
+			netdev_warn(enic->netdev,
+				    "MBOX: invalid msg_len %u (buf len %u)\n",
+				    msg_len, len);
+		return;
+	}
+
 	netdev_dbg(enic->netdev,
 		   "MBOX recv: type %u from vnic %u len %u\n",
-		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id),
-		   le16_to_cpu(hdr->msg_len));
+		   hdr->msg_type, le16_to_cpu(hdr->src_vnic_id), msg_len);
+
+	payload = buf + sizeof(*hdr);
+
+	if (enic->vf_state)
+		enic_mbox_pf_process_msg(enic, hdr, payload);
 }
 
 void enic_mbox_init(struct enic *enic)
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index 73fd7f783ee2..f1de67db1273 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -87,5 +87,6 @@ struct enic;
 void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
+int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


