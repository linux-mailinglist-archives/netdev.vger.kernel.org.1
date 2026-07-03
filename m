Return-Path: <netdev+bounces-304643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zuvFBZL7R2oAigAAu9opvQ
	(envelope-from <netdev+bounces-304643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:12:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAB4704CA0
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 20:12:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=EhBsrqam;
	dmarc=pass (policy=reject) header.from=cisco.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304643-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304643-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7480730731F5
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B631F992;
	Fri,  3 Jul 2026 18:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-5.cisco.com (rcdn-iport-5.cisco.com [173.37.86.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828F31354C;
	Fri,  3 Jul 2026 18:09:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102151; cv=none; b=kpFUToZMtN6zctrtIHpPrnwnLBzSGYXpPplixoYAKzP2zb9TDTm1wqRaZ+bWRxb7me0s9Du6fdiJ7Cuee3dXxTVxANtYa3iUTIEH85qauOcl7i/HfG/vxbsmOa0uIBouh5QOPnoW02hCj98afnT/1rzcWJ+XRsBAMVegK9VFMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102151; c=relaxed/simple;
	bh=vX6oEgIdo4vvhM4Ale5/DlynrIywkUOg/RspjdU6klc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piSbwnXxsUXl8x5h7GfhQUarQSUwpdQmhHqJD+GgcGTcOCVpvRk6y4Tx1Rl2oIqspf2YlC9QhpoxxFt9dGdWTPSmepY6mgUT+Q0eNvmvUCi008UXKm0Fc/ffnDrOTVBhs9omSBGG6W4fYU9spPtgPWwwhhJHmbCykJYUIGWnJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=EhBsrqam; arc=none smtp.client-ip=173.37.86.76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=20144; q=dns/txt;
  s=iport01; t=1783102148; x=1784311748;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=lUGhOb9gRs3en6vUTAnHMZH954xOkLeSo4A8XWlO44Q=;
  b=EhBsrqamsMmsW5TEMffJasj5QwQhpgbOwlan0udP7ylwbYH6IBA/IVat
   EUY+MQrmUW3JS9koCvaPNLkU+WJLdcOkjbYxf3lQ7eGOto0VRdSw+s2bK
   dvJ0Ka2dA8gyZQUvGzRIa/wuGJXYSpo/L/rYBXTwc3xdyYZQhWPsXZE7D
   Ivr06x0hBDYCzKMUOETI8CRBtjFQylTB9qMKeei4b0faU2++ax4Mw3dB9
   0yHLECrroNRo1A8XbAuJWP7VZCzEvRBmebmLNDgD5oHOdQxLGQk4XjbJ/
   CTZq+Qj11TvPXuW9f5Umj/l9ic3FugJNU6Y7Cl14mJTL1lS3xWipgY3qF
   w==;
X-CSE-ConnectionGUID: 64Dx2ZOwTLiQqv4ZCXZwMg==
X-CSE-MsgGUID: GDFxi/evSGaRC0HCYFAw5w==
X-IPAS-Result: =?us-ascii?q?A0AnAADU+Udq/5P/Ja1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?hc/gVJDSYRXiByHN4Ihnh4UgWoPAQEBD1EEAQGFBgKNSwImNAkOAQIEAwIDA?=
 =?us-ascii?q?QEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBEASECUCJgICRhAGA?=
 =?us-ascii?q?RKDAoJ0A7wFen8zgQGEfdlGgWYBCxQBgQouAYVwgmoBgXCEBjuEQScbgUlEg?=
 =?us-ascii?q?RQBg2mBKIMCg3SCagSDHBKRHwk/gQIcA1ksAVUTDQoLBwVhUjMDIAoLEhIYF?=
 =?us-ascii?q?QIULw8EFjIdcAwnEiwXNFgbBwWBHYEVMQQhgQSEeSMfAzl/gTB1SnkzgQIBE?=
 =?us-ascii?q?h4KgVKBJgMLGA1IESw3Bg4bBD0BbgeNABcPgUMCB2oHATwcARsaBwxoBC8CD?=
 =?us-ascii?q?DwDBQ8fAhQZQwKSYwcWg2GNX2uBNZ9ahCeBZqAPATKEBJNjkwWZCCOCNqIBh?=
 =?us-ascii?q?GiBaDyBWTMaCBsVgyJTGQ+OLRYceAEC0SMnMj8HAgcPApFzBIF5AQE?=
IronPort-Data: A9a23:ps94ka4nZ2aOpQwUWXatSgxRtPjGchMFZxGqfqrLsTDasY5as4F+v
 mIaXmHXPa6DY2ejL9kiO4Ti8E0PvMfXyIRhTFdvqy0yZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH2dOC98RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo/qUzBHf/g2Qqaj1MsPrZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eY9E06rxFJn5y0
 f0hMS5RXDuztf2Tz+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGMiFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkEQUrsUIMpWcOOAnXDjciZYq1K9rqss6G+Vxwt0uFToGIeNJoPQHpwOwy50o
 Erp00rpA1YXKuewwACuqlKHt8Hmgn7kDdd6+LqQs6QCbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSQoD/smmo4wpiB/LZshsHbTzjdDvHzz0h
 TeQo0AWgbgPgcMV/7u08EqBgD+2oJXNCAkv6W3qsnmN9Ah1YsuhIoev81WetK4GJ4eCRV7Ht
 38B8ySD0N0z4Vi2vHTlaI0w8HuBvp5p7BW0bYZTIqQc
IronPort-HdrOrdr: A9a23:Zy6MAa/rrpeIF3Txuuluk+AuI+orL9Y04lQ7vn2ZhyYlFvBw8P
 rOoB1773HJYVkqNU3I9errBEDEewK/yXcX2+Ys1MmZPDUO0VHAROpfBMnZsl7d8kbFmtK1u5
 0QFpRWOZncAUd3iMDi7BL9MdoxqeP3iZyAtKPyw2hgSAdyZ7ol1Qd2DQ6HDlZ7LTM2Y6bRbK
 DsgfZvln6HZWkdaNi9Cz0uWujOoMCOqbfdCCR2fyLOLGK1/EmVAHmQKWni4isj
X-Talos-CUID: 9a23:q52el23ZFotoDzGuRl8sKrxfRJwJYifv62jsB06BEHg1epale0C19/Yx
X-Talos-MUID: 9a23:99GhfQgLqeHeoGdAkYnIF8MpG+tG86XpBV42vpw8kJGkHh1eEijAk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,145,1779148800"; 
   d="scan'208";a="504723135"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Jul 2026 18:09:03 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTPS id 37E2618000A76;
	Fri,  3 Jul 2026 18:09:02 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Fri, 03 Jul 2026 11:08:59 -0700
Subject: [PATCH net-next v11 10/12] enic: wire V2 SR-IOV enable with admin
 channel and MBOX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-enic-sriov-v2-admin-channel-v2-v11-10-5b739f1fe9e5@cisco.com>
References: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
In-Reply-To: <20260703-enic-sriov-v2-admin-channel-v2-v11-0-5b739f1fe9e5@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783102134; l=20673;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=vX6oEgIdo4vvhM4Ale5/DlynrIywkUOg/RspjdU6klc=;
 b=KZnk7yTl4Cpa7qjXTu678syGEi58HuoADT3FFNg7NWjPymntoOUiQexUcy94ZVfn7AwJmOJ4J
 EBJqEhq3HAIDKuAaeDUQL7Rx/XVbeCocaxUOSLPnN8PwcvdWOQxlUCm
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304643-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:from_mime,cisco.com:email,cisco.com:mid,cisco.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BAB4704CA0

Extend enic_sriov_configure() to handle V2 SR-IOV VFs. When the PF
detects V2 VF device IDs, the enable path allocates per-VF MBOX state,
opens the admin channel, initializes the MBOX protocol, and then calls
pci_enable_sriov(). The admin channel must be ready before VFs are
created so that VF drivers can immediately begin the MBOX capability
and registration handshake during their probe.

The enic_sriov_configure() dispatcher and its V2 helpers
(enic_sriov_v2_enable, enic_sriov_v2_disable) are defined here but
intentionally not yet wired into struct pci_driver via
.sriov_configure -- hence the __maybe_unused annotations.  This
series introduces only the admin channel and MBOX infrastructure;
sysfs-driven V2 enable/disable will be activated in a follow-up
patch by adding ".sriov_configure = enic_sriov_configure," to
enic_driver.

Because .sriov_configure is not registered yet, enic_sriov_configure()
cannot run concurrently with the rtnl-protected reset paths
(enic_reset(), enic_tx_hang_reset()) in this series, so there is no
reachable locking race between SR-IOV enable/disable and reset.  The
follow-up patch that wires the callback will add the necessary
serialization against those paths.  Note that simply taking rtnl_lock()
around the enable path is not viable, because pci_enable_sriov()
triggers VF probe and register_netdev(), which themselves acquire rtnl;
the wiring patch therefore uses finer-grained serialization.

The disable path first clears ENIC_SRIOV_ENABLED and flushes the
link-notify work, so no further VF link-state broadcast can run, then
calls pci_disable_sriov() (VF drivers unregister via MBOX), closes the
admin channel, and frees per-VF state.  Clearing the flag and flushing
the work before vf_state is freed closes a use-after-free window
against the link-notify path.

Notify registered VFs of PF link transitions: enic_link_check()
schedules link_notify_work on each carrier up/down edge, and the work
handler sends PF_LINK_STATE_NOTIF to the VFs from process context.
The broadcast cannot run directly in enic_link_check() because the
MBOX send path may sleep and link check runs in the notify timer/ISR
context.

Re-establish the admin/MBOX channel across a PF reset.  enic_reset()
and enic_tx_hang_reset() fully close the admin channel before the
soft/hang reset (which wipes all hardware queues, including the admin
WQ/RQ), then reopen it and re-run enic_mbox_init() after the data path
is back up, and re-push the current link state to registered VFs.

Reject VF port profile requests when V2 SR-IOV is active
(enic_is_valid_pp_vf), since enic->pp is not reallocated for V2 VFs
and the V2 protocol uses MBOX instead of port profiles.

Update enic_remove() to run enic_dev_deinit() and vnic_dev_close()
after SR-IOV teardown, so the PF device remains functional while VFs
are being cleaned up.  This ordering applies to both V1 and V2 SR-IOV
paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |   2 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c  | 260 +++++++++++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |  13 +-
 drivers/net/ethernet/cisco/enic/enic_pp.c    |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c   |   1 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h  |   4 +-
 7 files changed, 274 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index a9a376d2cf0e..b5a43fe04877 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -305,6 +305,7 @@ struct enic {
 	struct vnic_intr admin_intr;
 	struct work_struct admin_poll_work;
 	unsigned int admin_intr_index;
+	struct work_struct link_notify_work;
 	struct work_struct admin_msg_work;
 	spinlock_t admin_msg_lock;	/* protects admin_msg_list */
 	struct list_head admin_msg_list;
@@ -324,6 +325,7 @@ struct enic {
 	 */
 	struct completion mbox_comp;
 	u8 mbox_expected_reply;
+	bool mbox_initialized;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index 4b279a142042..69aa49ffd6c8 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -616,6 +616,7 @@ void enic_admin_channel_close(struct enic *enic)
 
 	vnic_intr_mask(&enic->admin_intr);
 	enic_admin_teardown_intr(enic);
+	cancel_work_sync(&enic->link_notify_work);
 	cancel_work_sync(&enic->admin_msg_work);
 	enic_admin_msg_drain(enic);
 
@@ -635,6 +636,8 @@ void enic_admin_channel_close(struct enic *enic)
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	vnic_intr_clean(&enic->admin_intr);
+
+	enic->admin_rq_handler = NULL;
 	enic_admin_free_resources(enic);
 
 	enic->admin_chan_up = false;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 6992411bd3b5..68a293d60ab8 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -60,6 +60,8 @@
 #include "enic_clsf.h"
 #include "enic_rq.h"
 #include "enic_wq.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 
@@ -411,6 +413,24 @@ static void enic_set_rx_coal_setting(struct enic *enic)
 	rx_coal->use_adaptive_rx_coalesce = 1;
 }
 
+static void enic_link_notify_work_handler(struct work_struct *work)
+{
+	struct enic *enic = container_of(work, struct enic,
+					 link_notify_work);
+	u32 state;
+	u16 i;
+
+	if (!enic_sriov_enabled(enic) || !enic->vf_state)
+		return;
+
+	state = netif_carrier_ok(enic->netdev) ?
+		ENIC_MBOX_LINK_STATE_ENABLE :
+		ENIC_MBOX_LINK_STATE_DISABLE;
+
+	for (i = 0; i < enic->num_vfs; i++)
+		enic_mbox_send_link_state(enic, i, state);
+}
+
 static void enic_link_check(struct enic *enic)
 {
 	int link_status = vnic_dev_link_status(enic->vdev);
@@ -420,9 +440,13 @@ static void enic_link_check(struct enic *enic)
 		netdev_info(enic->netdev, "Link UP\n");
 		netif_carrier_on(enic->netdev);
 		enic_set_rx_coal_setting(enic);
+		if (enic_sriov_enabled(enic) && enic->vf_state)
+			schedule_work(&enic->link_notify_work);
 	} else if (!link_status && carrier_ok) {
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
+		if (enic_sriov_enabled(enic) && enic->vf_state)
+			schedule_work(&enic->link_notify_work);
 	}
 }
 
@@ -2154,15 +2178,47 @@ static void enic_reset(struct work_struct *work)
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
+	/* Fully tear down the V2 admin/MBOX channel before the soft reset.
+	 * The reset wipes all hardware queues including the admin WQ/RQ;
+	 * closing first tells firmware to stop the admin QP (so it no longer
+	 * DMAs from the about-to-be-reset rings) and frees the admin resources
+	 * so they are cleanly re-allocated afterwards.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2)
+		enic_admin_channel_close(enic);
+
 	enic_stop(enic->netdev);
+
 	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
 	enic_set_rss_nic_cfg(enic);
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
+
 	enic_open(enic->netdev);
 
+	/* Re-establish the admin/MBOX channel after the data path is back up,
+	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
+	 * channel was fully torn down by enic_admin_channel_close() above.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		if (enic_admin_channel_open(enic)) {
+			netdev_err(enic->netdev,
+				   "admin channel reopen after reset failed\n");
+		} else {
+			enic_mbox_init(enic);
+			/* The link came back up during enic_open() above
+			 * while MBOX sends were still disabled (channel not
+			 * yet reopened), so that link-notify was dropped.
+			 * Re-push current link state to registered VFs now.
+			 */
+			schedule_work(&enic->link_notify_work);
+		}
+	}
+
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
@@ -2180,16 +2236,46 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	/* Stop any activity from infiniband */
 	enic_set_api_busy(enic, true);
 
+	/* Fully tear down the V2 admin/MBOX channel before the hang reset, for
+	 * the same reason as the soft reset path: stop the admin QP and free
+	 * the admin resources before the hardware queues are wiped.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2)
+		enic_admin_channel_close(enic);
+
 	enic_dev_hang_notify(enic);
 	enic_stop(enic->netdev);
+
 	enic_dev_hang_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
 	enic_set_rss_nic_cfg(enic);
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
+
 	enic_open(enic->netdev);
 
+	/* Re-establish the admin/MBOX channel after the data path is back up,
+	 * mirroring the SR-IOV enable path (channel open + mbox init).  The
+	 * channel was fully torn down by enic_admin_channel_close() above.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		if (enic_admin_channel_open(enic)) {
+			netdev_err(enic->netdev,
+				   "admin channel reopen after reset failed\n");
+		} else {
+			enic_mbox_init(enic);
+			/* The link came back up during enic_open() above
+			 * while MBOX sends were still disabled (channel not
+			 * yet reopened), so that link-notify was dropped.
+			 * Re-push current link state to registered VFs now.
+			 */
+			schedule_work(&enic->link_notify_work);
+		}
+	}
+
 	/* Allow infiniband to fiddle with the device again */
 	enic_set_api_busy(enic, false);
 
@@ -2200,6 +2286,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 static int enic_set_intr_mode(struct enic *enic)
 {
+	unsigned int admin_reserve = enic->has_admin_channel ? 1 : 0;
+	unsigned int min_intr = ENIC_MSIX_MIN_INTR + admin_reserve;
 	unsigned int i;
 	int num_intr;
 
@@ -2210,12 +2298,12 @@ static int enic_set_intr_mode(struct enic *enic)
 	 */
 
 	if (enic->config.intr_mode < 1 &&
-	    enic->intr_avail >= ENIC_MSIX_MIN_INTR) {
+	    enic->intr_avail >= min_intr) {
 		for (i = 0; i < enic->intr_avail; i++)
 			enic->msix_entry[i].entry = i;
 
 		num_intr = pci_enable_msix_range(enic->pdev, enic->msix_entry,
-						 ENIC_MSIX_MIN_INTR,
+						 min_intr,
 						 enic->intr_avail);
 		if (num_intr > 0) {
 			vnic_dev_set_intr_mode(enic->vdev,
@@ -2310,7 +2398,13 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->cq_count = 2;
 		enic->intr_count = enic->intr_avail;
 		break;
-	case VNIC_DEV_INTR_MODE_MSIX:
+	case VNIC_DEV_INTR_MODE_MSIX: {
+		/* Reserve one MSI-X slot for the admin channel interrupt
+		 * when V2 SR-IOV admin channel resources are present.
+		 */
+		unsigned int admin_reserve =
+			enic->has_admin_channel ? 1 : 0;
+
 		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
 		 * used based on which resource is the most constrained
 		 */
@@ -2319,7 +2413,8 @@ static int enic_adjust_resources(struct enic *enic)
 				 ENIC_RQ_MIN_DEFAULT);
 		rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
 		max_queues = min(enic->cq_avail,
-				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR -
+				 admin_reserve);
 		if (wq_avail + rq_avail <= max_queues) {
 			enic->rq_count = rq_avail;
 			enic->wq_count = wq_avail;
@@ -2337,6 +2432,7 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
 
 		break;
+	}
 	default:
 		dev_err(enic_get_dev(enic), "Unknown interrupt mode\n");
 		return -EINVAL;
@@ -2689,6 +2785,140 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
 		enic->vf_type = ENIC_VF_TYPE_NONE;
 	}
 }
+
+static int __maybe_unused
+enic_sriov_v2_enable(struct enic *enic, int num_vfs)
+{
+	int err;
+
+	if (!enic->has_admin_channel) {
+		netdev_err(enic->netdev,
+			   "V2 SR-IOV requires admin channel resources\n");
+		return -EOPNOTSUPP;
+	}
+
+	enic->vf_state = kcalloc(num_vfs, sizeof(*enic->vf_state), GFP_KERNEL);
+	if (!enic->vf_state)
+		return -ENOMEM;
+
+	err = enic_admin_channel_open(enic);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "Failed to open admin channel: %d\n", err);
+		goto free_vf_state;
+	}
+
+	enic_mbox_init(enic);
+
+	enic->num_vfs = num_vfs;
+
+	err = pci_enable_sriov(enic->pdev, num_vfs);
+	if (err) {
+		netdev_err(enic->netdev,
+			   "pci_enable_sriov failed: %d\n", err);
+		goto close_admin;
+	}
+
+	enic->priv_flags |= ENIC_SRIOV_ENABLED;
+	return num_vfs;
+
+close_admin:
+	enic->num_vfs = 0;
+	enic_admin_channel_close(enic);
+free_vf_state:
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	return err;
+}
+
+static void enic_sriov_v2_disable(struct enic *enic)
+{
+	/* Stop new VF link-state broadcasts before tearing down vf_state.
+	 * Clearing ENIC_SRIOV_ENABLED makes enic_link_check() (called from
+	 * the notify timer/ISR) skip the VF notify path, and cancelling
+	 * link_notify_work ensures any already-queued broadcast has finished
+	 * before vf_state is freed, closing a use-after-free window.
+	 */
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+	cancel_work_sync(&enic->link_notify_work);
+
+	pci_disable_sriov(enic->pdev);
+	enic_admin_channel_close(enic);
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	enic->num_vfs = 0;
+}
+
+/*
+ * enic_sriov_configure() and its V2 helpers are defined but not yet wired
+ * into enic_driver via .sriov_configure (see the __maybe_unused annotations);
+ * V2 enable/disable is activated in a follow-up series.  Because the callback
+ * is not registered, it cannot run concurrently with the rtnl-protected reset
+ * paths (enic_reset(), enic_tx_hang_reset()) yet.  Serialization against those
+ * paths is added together with the .sriov_configure wiring in that series.
+ */
+static int __maybe_unused
+enic_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct enic *enic = netdev_priv(netdev);
+	struct enic_port_profile *pp;
+	int err;
+
+	if (num_vfs > 0) {
+		if (enic->config.mq_subvnic_count) {
+			netdev_err(netdev,
+				   "SR-IOV not supported with multi-queue sub-vnics\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_NONE) {
+			netdev_err(netdev,
+				   "SR-IOV not supported on this firmware version\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (enic->vf_type == ENIC_VF_TYPE_V2)
+			return enic_sriov_v2_enable(enic, num_vfs);
+
+		pp = kcalloc(num_vfs, sizeof(*pp), GFP_KERNEL);
+		if (!pp)
+			return -ENOMEM;
+
+		err = pci_enable_sriov(pdev, num_vfs);
+		if (err) {
+			kfree(pp);
+			return err;
+		}
+
+		kfree(enic->pp);
+		enic->pp = pp;
+		enic->num_vfs = num_vfs;
+		enic->priv_flags |= ENIC_SRIOV_ENABLED;
+		return num_vfs;
+	}
+
+	if (!enic_sriov_enabled(enic))
+		return 0;
+
+	if (enic->vf_type == ENIC_VF_TYPE_V2) {
+		enic_sriov_v2_disable(enic);
+		return 0;
+	}
+
+	pp = kzalloc_obj(*enic->pp, GFP_KERNEL);
+	if (!pp)
+		return -ENOMEM;
+
+	pci_disable_sriov(pdev);
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+
+	kfree(enic->pp);
+	enic->pp = pp;
+
+	return 0;
+}
 #endif
 
 static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
@@ -2787,12 +3017,18 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_vnic_unregister;
 
 #ifdef CONFIG_PCI_IOV
-	/* Get number of subvnics */
+	enic_sriov_detect_vf_type(enic);
+
+	/* Auto-enable SR-IOV if VFs were pre-configured (e.g. at boot).
+	 * V2 VFs require the admin channel, which is not yet set up at probe
+	 * time; use sysfs (enic_sriov_configure) to enable V2 SR-IOV instead.
+	 */
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
 	if (pos) {
 		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF,
 			&enic->num_vfs);
-		if (enic->num_vfs) {
+		if (enic->num_vfs &&
+		    enic->vf_type != ENIC_VF_TYPE_V2) {
 			err = pci_enable_sriov(pdev, enic->num_vfs);
 			if (err) {
 				dev_err(dev, "SRIOV enable failed, aborting."
@@ -2804,7 +3040,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			num_pps = enic->num_vfs;
 		}
 	}
-	enic_sriov_detect_vf_type(enic);
 #endif
 
 	/* Allocate structure for port profiles */
@@ -2881,6 +3116,7 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&enic->reset, enic_reset);
 	INIT_WORK(&enic->tx_hang_reset, enic_tx_hang_reset);
 	INIT_WORK(&enic->change_mtu_work, enic_change_mtu_work);
+	INIT_WORK(&enic->link_notify_work, enic_link_notify_work_handler);
 
 	for (i = 0; i < enic->wq_count; i++)
 		spin_lock_init(&enic->wq[i].lock);
@@ -3034,14 +3270,16 @@ static void enic_remove(struct pci_dev *pdev)
 		cancel_work_sync(&enic->tx_hang_reset);
 		cancel_work_sync(&enic->change_mtu_work);
 		unregister_netdev(netdev);
-		enic_dev_deinit(enic);
-		vnic_dev_close(enic->vdev);
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
-			pci_disable_sriov(pdev);
-			enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+			if (enic->vf_type == ENIC_VF_TYPE_V2)
+				enic_sriov_v2_disable(enic);
+			else
+				pci_disable_sriov(pdev);
 		}
 #endif
+		enic_dev_deinit(enic);
+		vnic_dev_close(enic->vdev);
 		kfree(enic->pp);
 		vnic_dev_unregister(enic->vdev);
 		enic_iounmap(enic);
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index 701972f90627..6fb6a1027bb6 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -624,8 +624,17 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
 void enic_mbox_init(struct enic *enic)
 {
+	/* mbox_lock and mbox_comp must be initialized exactly once per
+	 * device lifetime; the PF sriov_configure path can re-enter this
+	 * on each enable cycle where these primitives are already set up.
+	 */
+	if (!enic->mbox_initialized) {
+		mutex_init(&enic->mbox_lock);
+		init_completion(&enic->mbox_comp);
+		enic->mbox_initialized = true;
+	} else {
+		reinit_completion(&enic->mbox_comp);
+	}
 	enic->mbox_msg_num = 0;
-	mutex_init(&enic->mbox_lock);
-	init_completion(&enic->mbox_comp);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_pp.c b/drivers/net/ethernet/cisco/enic/enic_pp.c
index 4720a952725d..3f611e240c25 100644
--- a/drivers/net/ethernet/cisco/enic/enic_pp.c
+++ b/drivers/net/ethernet/cisco/enic/enic_pp.c
@@ -25,6 +25,11 @@ int enic_is_valid_pp_vf(struct enic *enic, int vf, int *err)
 	if (vf != PORT_SELF_VF) {
 #ifdef CONFIG_PCI_IOV
 		if (enic_sriov_enabled(enic)) {
+			/* V2 SR-IOV uses MBOX, not port profiles */
+			if (enic->vf_type == ENIC_VF_TYPE_V2) {
+				*err = -EOPNOTSUPP;
+				goto err_out;
+			}
 			if (vf < 0 || vf >= enic->num_vfs) {
 				*err = -EINVAL;
 				goto err_out;
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index 2b7545d6a67f..436326ace049 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -59,6 +59,7 @@ int enic_get_vnic_config(struct enic *enic)
 	GET_CONFIG(intr_timer_usec);
 	GET_CONFIG(loop_tag);
 	GET_CONFIG(num_arfs);
+	GET_CONFIG(mq_subvnic_count);
 	GET_CONFIG(max_rq_ring);
 	GET_CONFIG(max_wq_ring);
 	GET_CONFIG(max_cq_ring);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_enet.h b/drivers/net/ethernet/cisco/enic/vnic_enet.h
index 9e8e86262a3f..519d2969990b 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_enet.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_enet.h
@@ -21,7 +21,9 @@ struct vnic_enet_config {
 	u16 loop_tag;
 	u16 vf_rq_count;
 	u16 num_arfs;
-	u8 reserved[66];
+	u8 reserved1[32];
+	u16 mq_subvnic_count;
+	u8 reserved2[32];
 	u32 max_rq_ring;	// MAX RQ ring size
 	u32 max_wq_ring;	// MAX WQ ring size
 	u32 max_cq_ring;	// MAX CQ ring size

-- 
2.43.0


