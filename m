Return-Path: <netdev+bounces-297178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3h6GMlDKGomBQMAu9opvQ
	(envelope-from <netdev+bounces-297178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC779662942
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:48:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=kJa+16Tn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297178-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297178-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C80EB315FF1A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABFC3F65EB;
	Tue,  9 Jun 2026 16:34:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE943BED06;
	Tue,  9 Jun 2026 16:34:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022846; cv=none; b=OijGJ1VVR3eb70Y728A7Tgag4hb2eNwm9fC84tVbXU2Cis4iU3AnsU55iIRQXc17WM+3BFULuH2QFHGUZ1CeMCEbqT52CxL0WRMdzCTOLA17eRPoIQdiXcFxyiT+kTE1KQB4yGKOnqsb9lIjiE5UkuaMmo1vs0krXbnL/xoTP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022846; c=relaxed/simple;
	bh=szP8rXffRleDqcavWfN+/gJvXlOeIz69R9WtT+h3M28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nxeo3a7hdv7RCvZJHwKbY1ew5HFBE+zSShyg008x0MD7NfA60oc63kLr5RZwCKT88QHekCFUhZxpLo9nHrMKcQEPpqJTPj6KDII24ClC9OZGPNddabfPBROTuW5+1VmgNDnvXYnaLEPsEio4d3oZh2tkVbtsqiE7+zI4qA8MNds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=kJa+16Tn; arc=none smtp.client-ip=173.37.86.74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=13970; q=dns/txt;
  s=iport01; t=1781022844; x=1782232444;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Mjbt3NH5Y58mjrLcQa6OkHrtbp8zWLDEfJzAuphfUlM=;
  b=kJa+16Tn5hCCvgge7/covHA4IOm+obFo137hWbg56TFFqlJsEeaban6T
   eWITq+UIASLVsFE5NPukJybl2oiWFntjI+1Sb9HbETNIejGVL8hNG690k
   PQc5RViJ3K2cRZsUgrdBNE8Rdbi7dU0W2Qi+Zj3IHTaHi3Ycit/PaKqIE
   IyfqgdRZ47zPIU5tVJAy8tg/Fnthf3csTTLJnDbfvQqpMGk5pUHC0L3Rc
   KglqbQ6cqXJ1GJLgLB6ZIrAP5m+fns7B/SbUE/WBQdT9+vKoKcrohxVMA
   KBV1emRTweu5R+/NVuSwnirJE5agfQNlq3PaBCo2e1SnLxDSpyARY5ZcK
   w==;
X-CSE-ConnectionGUID: pgzNT4r/RgSGJczHTR1CyQ==
X-CSE-MsgGUID: e8aeQdfoT0KfRVQfFBCd/Q==
X-IPAS-Result: =?us-ascii?q?A0AaAACmPyhq/4//Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?AcBAQsBghc/gVJDSYRXiByHN4Ihnh4UgWoPAQEBD1EEAQGFBgKNNwImNAkOA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4ZchlsCAQMjBFIQJQImA?=
 =?us-ascii?q?gJGEAYBEoMCgnQDtRx6fzOBAYR92UWBZgELFAGBCi4BhXCCaQGBcIQGO4RBJ?=
 =?us-ascii?q?xuBSUSBFAGDaIEogwKDdIJqBIMcEpBnCT+BAhwDWSwBVRMNCgsHBWFSMwMgC?=
 =?us-ascii?q?gsSEhgVAhQvDwQWMh1wDCcSLBc0WBsHBYFKgTsUMQQhgQWFEiMfAzmBFYF8g?=
 =?us-ascii?q?ShnaRUxNU0DCxgNSBEsNwYOGwQ9AW4HjDoXD4E/CVEZBw5LHBoHdDUMPxQfA?=
 =?us-ascii?q?hRekmMHFoNhjV9rgTWfWYQmgWagDwEyhASTY5MEmQYigjaiAIRogWg8gVkzG?=
 =?us-ascii?q?ggbFYMiUxkPji0WHHgBAspnJzI/BwIHDwKRcwSBeQEB?=
IronPort-Data: A9a23:AVCFdaxnwpeNc/4v1A96t+f3xyrEfRIJ4+MujC+fZmUNrF6WrkUEn
 DMWUGuFOamONmekfNpxPdnkp0gCsMeBnIdiGQE//lhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/VH1buSJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 4+aT/H3Ygf/hWYqajNMsspvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJFk5L6skpvwwO2512
 t4TOhAxVEmoltvjldpXSsE07igiBNPgMIVavjRryivUSK54B5vCWK7No9Rf2V/chOgXQq2YP
 JVfM2cyKk2cOHWjOX9PYH46tPyhmnjkcz5YgFmUvqEwpWPUyWSd1ZCxYYCLIo3bGJ09ckCwq
 zLP8l31DBYmbP+R8wS8/FyGreOIpHauMG4VPPjinhJwu3Wfz3IeDTUaXEW2pP2+hFL4Xd9DQ
 2QZ9jcrpLo/6GSkSd7yWxD+q3mB1jYfRtBZO+438geAzuzT+QnxLmECQiRMd58gudM6SCIC0
 kKPmZXiBVRHqLSfRHSc3q2ZoTO7JW4eKmpqTSsFSxYVptruuoc+ijrRQdt5Vq24lNv4HXf32
 T/ihC4zm7kek+YV2Kihu1PKmTShot7OVAFd2+nMdniu4gU8YMuuYJalrACFq/1BN42eCFKGu
 RDohvSj0QzHNrnV/ATlfQnHNO3BCyqtWNEEvWNSIg==
IronPort-HdrOrdr: A9a23:XZH2ma679Rjy1KGtmgPXwD7XdLJyesId70hD6qm+c20wTiX+ra
 GTdZUguyMc5wx9ZJhNo7q90ey7MBHhHP1OjrX5Q43DYOCOggLBR72Kr7GSoAEIcBeTygcy79
 YET4FOTPD9ElR+i9/3+02bH8ZI+qj/zImYwcrT0HtpSxhncOVb7wl/AhuGCUEefnghOXNALu
 v62uN34xy9ZH8QcsO3QlMBX+TFupn3saiOW29/O/bigzP+9w9BL9XBYmOl4is=
X-Talos-CUID: =?us-ascii?q?9a23=3AOnIJNWlFJvieI+LKsodDbmi0qpXXOWXS3lHsf1X?=
 =?us-ascii?q?/M2lSZ5+eW3+swvpPgvM7zg=3D=3D?=
X-Talos-MUID: 9a23:AU4rGgnqqCfrjBlf4OEpdnpvZM5l2qigD3xVsps8hfCKGwZbN3Ck2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,196,1774310400"; 
   d="scan'208";a="492609950"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 09 Jun 2026 16:32:53 +0000
Received: from [127.0.0.1] (unknown [10.25.128.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id 0AD76180004B4;
	Tue,  9 Jun 2026 16:32:52 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Tue, 09 Jun 2026 09:32:35 -0700
Subject: [PATCH net-next v8 09/10] enic: wire V2 SR-IOV enable with admin
 channel and MBOX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-enic-sriov-v2-admin-channel-v2-v8-9-8ad8babbb826@cisco.com>
References: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
In-Reply-To: <20260609-enic-sriov-v2-admin-channel-v2-v8-0-8ad8babbb826@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781022766; l=14360;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=szP8rXffRleDqcavWfN+/gJvXlOeIz69R9WtT+h3M28=;
 b=pYJUhSYB78JkZ6wA+7IB91wHlbi4GvTagfy6bC/iRZ62Ow7iFL6riGPh8kYZdiBrEShpsnGIx
 fG0jAz7QpM1DVNQvvrsfCeU3o6Cicjq+i1Ake2Xz51OzSYcBCnHeCs7
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.186];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.186, [10.25.128.186]
X-Outbound-Node: rcdn-l-core-06.cisco.com
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
	TAGGED_FROM(0.00)[bounces-297178-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC779662942

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

The disable path reverses this order: pci_disable_sriov() first (so VF
drivers unregister via MBOX), then the admin channel is closed and
per-VF state is freed.

Reject VF port profile requests when V2 SR-IOV is active
(enic_is_valid_pp_vf), since enic->pp is not reallocated for V2 VFs
and the V2 protocol uses MBOX instead of port profiles.

Update enic_remove() to run enic_dev_deinit() and vnic_dev_close()
after SR-IOV teardown, so the PF device remains functional while VFs
are being cleaned up.  This ordering applies to both V1 and V2 SR-IOV
paths.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h       |   1 +
 drivers/net/ethernet/cisco/enic/enic_admin.c |   2 +
 drivers/net/ethernet/cisco/enic/enic_main.c  | 192 +++++++++++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_mbox.c  |  13 +-
 drivers/net/ethernet/cisco/enic/enic_pp.c    |   5 +
 drivers/net/ethernet/cisco/enic/enic_res.c   |   1 +
 drivers/net/ethernet/cisco/enic/vnic_enet.h  |   4 +-
 7 files changed, 204 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 2854b8016fff..db9c76d1150a 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -315,6 +315,7 @@ struct enic {
 	 */
 	struct completion mbox_comp;
 	u8 mbox_expected_reply;
+	bool mbox_initialized;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
diff --git a/drivers/net/ethernet/cisco/enic/enic_admin.c b/drivers/net/ethernet/cisco/enic/enic_admin.c
index b950417f9842..cfd0f0a6d263 100644
--- a/drivers/net/ethernet/cisco/enic/enic_admin.c
+++ b/drivers/net/ethernet/cisco/enic/enic_admin.c
@@ -569,5 +569,7 @@ void enic_admin_channel_close(struct enic *enic)
 	vnic_cq_clean(&enic->admin_cq[0]);
 	vnic_cq_clean(&enic->admin_cq[1]);
 	vnic_intr_clean(&enic->admin_intr);
+
+	enic->admin_rq_handler = NULL;
 	enic_admin_free_resources(enic);
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 53d68272d06a..f3d335f06fbc 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -60,6 +60,8 @@
 #include "enic_clsf.h"
 #include "enic_rq.h"
 #include "enic_wq.h"
+#include "enic_admin.h"
+#include "enic_mbox.h"
 
 #define ENIC_NOTIFY_TIMER_PERIOD	(2 * HZ)
 
@@ -424,6 +426,16 @@ static void enic_link_check(struct enic *enic)
 		netdev_info(enic->netdev, "Link DOWN\n");
 		netif_carrier_off(enic->netdev);
 	}
+
+	if (enic_sriov_enabled(enic) && enic->vf_state) {
+		u16 i;
+		u32 state = link_status ?
+			ENIC_MBOX_LINK_STATE_ENABLE :
+			ENIC_MBOX_LINK_STATE_DISABLE;
+
+		for (i = 0; i < enic->num_vfs; i++)
+			enic_mbox_send_link_state(enic, i, state);
+	}
 }
 
 static void enic_notify_check(struct enic *enic)
@@ -2155,12 +2167,35 @@ static void enic_reset(struct work_struct *work)
 	enic_set_api_busy(enic, true);
 
 	enic_stop(enic->netdev);
+
+	/* Quiesce admin channel before soft reset.  The reset disables
+	 * all hardware queues including the admin WQ/RQ; mask the admin
+	 * interrupt, drain workqueue and work, and block further MBOX sends
+	 * so the channel is cleanly idle when we reinitialise.
+	 */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		vnic_intr_mask(&enic->admin_intr);
+		cancel_work_sync(&enic->admin_poll_work);
+		cancel_work_sync(&enic->admin_msg_work);
+		WRITE_ONCE(enic->mbox_send_disabled, true);
+	}
+
 	enic_dev_soft_reset(enic);
 	enic_reset_addr_lists(enic);
 	enic_init_vnic_resources(enic);
 	enic_set_rss_nic_cfg(enic);
 	enic_dev_set_ig_vlan_rewrite_mode(enic);
 	enic_ext_cq(enic);
+
+	/* Re-enable admin channel after reinitialising hardware */
+	if (enic_sriov_enabled(enic) &&
+	    enic->vf_type == ENIC_VF_TYPE_V2) {
+		WRITE_ONCE(enic->mbox_send_disabled, false);
+		/* workqueue re-enables on next interrupt */
+		vnic_intr_unmask(&enic->admin_intr);
+	}
+
 	enic_open(enic->netdev);
 
 	/* Allow infiniband to fiddle with the device again */
@@ -2200,6 +2235,8 @@ static void enic_tx_hang_reset(struct work_struct *work)
 
 static int enic_set_intr_mode(struct enic *enic)
 {
+	unsigned int admin_reserve = enic->has_admin_channel ? 1 : 0;
+	unsigned int min_intr = ENIC_MSIX_MIN_INTR + admin_reserve;
 	unsigned int i;
 	int num_intr;
 
@@ -2210,12 +2247,12 @@ static int enic_set_intr_mode(struct enic *enic)
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
@@ -2310,7 +2347,13 @@ static int enic_adjust_resources(struct enic *enic)
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
@@ -2319,7 +2362,8 @@ static int enic_adjust_resources(struct enic *enic)
 				 ENIC_RQ_MIN_DEFAULT);
 		rq_avail = min3(enic->rq_avail, ENIC_RQ_MAX, rq_default);
 		max_queues = min(enic->cq_avail,
-				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR -
+				 admin_reserve);
 		if (wq_avail + rq_avail <= max_queues) {
 			enic->rq_count = rq_avail;
 			enic->wq_count = wq_avail;
@@ -2337,6 +2381,7 @@ static int enic_adjust_resources(struct enic *enic)
 		enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
 
 		break;
+	}
 	default:
 		dev_err(enic_get_dev(enic), "Unknown interrupt mode\n");
 		return -EINVAL;
@@ -2689,6 +2734,124 @@ static void enic_sriov_detect_vf_type(struct enic *enic)
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
+	pci_disable_sriov(enic->pdev);
+	enic_admin_channel_close(enic);
+	kfree(enic->vf_state);
+	enic->vf_state = NULL;
+	enic->num_vfs = 0;
+	enic->priv_flags &= ~ENIC_SRIOV_ENABLED;
+}
+
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
@@ -2787,12 +2950,18 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -2804,7 +2973,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			num_pps = enic->num_vfs;
 		}
 	}
-	enic_sriov_detect_vf_type(enic);
 #endif
 
 	/* Allocate structure for port profiles */
@@ -3033,14 +3201,16 @@ static void enic_remove(struct pci_dev *pdev)
 		cancel_work_sync(&enic->reset);
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
index b5c9c5e51410..22a5e50fff4d 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -602,8 +602,17 @@ int enic_mbox_vf_unregister(struct enic *enic)
 
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


