Return-Path: <netdev+bounces-302745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +2qtGKOrQmr7/QkAu9opvQ
	(envelope-from <netdev+bounces-302745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:30:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 024396DDBBD
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:30:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cisco.com header.s=iport01 header.b=R1Nn1nvR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302745-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-302745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cisco.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BB343052FDC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8976247A0A6;
	Mon, 29 Jun 2026 17:26:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B3478E2B;
	Mon, 29 Jun 2026 17:26:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753973; cv=none; b=R3Ie6Lt/r/iU3XkalZZh7qBQOCwmUCsERztcxqeMos2nZ75iLTL0+5r8DoUFvspUjBwklqEMapeVZCZNMM7+wpkmau8KrMfzmsGU/WYb2GZZccu72726YixeQRohZweF8I+ZFLtusVmlLZKE24q9P3uYktJdVcjdle8HWGWMgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753973; c=relaxed/simple;
	bh=g9r2nMWr4IiSOm55XqthrmvPeTLBvPsdUVRXpVRBLHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hf02mJ7QFt+0JJeaKPMZPTDYs8SUhqQ5yZTUCDZuyQ2M7iI746qH8cpO1TC3Jv84H6WpuPcoloSrxVg0eNcFAy7Xheq32r1ijHALgl+UlDtXG2jZaY5yj+AtNL4BVaqV7/qktTtmx38vQNfe6kQ4vkpUxsgJi3QuWhNNaZfGtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=R1Nn1nvR; arc=none smtp.client-ip=173.37.86.75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=11909; q=dns/txt;
  s=iport01; t=1782753971; x=1783963571;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rbU/dokjqEPyFrB1Fv2ifKbFBLUIsJFjdS+LYCnzdyU=;
  b=R1Nn1nvRPpUDex4oi7n0dP+nvKdxdGiO+eXqmtTKpOjX7pfDttwy54gU
   qpFO3jLeyti1cVQen4pW5fcoSaeOJhTIZdcuXveZ8Msmwr/rMlZn3d+wg
   +hzcSsXIyBD5KIQ6bbNp6RyXHPxfMK6fDRNDf1zIm9v8p30O1SadfoW+v
   c8ccPBUsT7xbVKbFpIZf1dW3OnutppXqHzItBEnmvQKhpcGinVBqi9XNB
   3klhWoMH+hdeukCsmg5U4dq1KO0xSlNi8XVhGM4DdjhwE6lTsKJYWba6d
   7YWuwyXN73PNtT+0JOrUe7Oz8xKxopCkFhxzq9l4HcrKVW/GNi7Lu9AOZ
   A==;
X-CSE-ConnectionGUID: dCVdv5aYQ06H/TXi9OFJcA==
X-CSE-MsgGUID: Vl5K4w2ZRlS2xLB0BK2Azg==
X-IPAS-Result: =?us-ascii?q?A0BHAgBvqUJq/5D/Ja1aHgEBCxIMggULgleBUkNJhFePU?=
 =?us-ascii?q?4IhkU2MURSBag8BAQEPUQQBAYUGAo1LAiY0CQ4BAgQDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQUBAQECAQcFgQ4ThlyGWwIBAyMECwE0EhAlAiYCAkYQBgESgwKCdAO4d?=
 =?us-ascii?q?np/M4EB3kOBZgELFAGBCi6FcYJqAYFwhAY7g0Z7JxuBSUSBFYJYgRGEBQUVg?=
 =?us-ascii?q?3+CagSCInoSgVuBBoMVixAJP4ECHANZLAFVEw0KCwcFYVIzAyAKCxISGBUCF?=
 =?us-ascii?q?C8PBBYyHXAMEBcSLBc0WBsHBYEdgRUvBCGBBIR9Ix8DOX+BMHVYZhUwNYERH?=
 =?us-ascii?q?gqBUicDCxgNSBEsNwYOGwQ9AW4HjF0XD4FMagcWeUwvBC1MGxUFMCySfEKDP?=
 =?us-ascii?q?I5KgTWfWoQngWagDwEyhASTYzSSUZkII4I2oSgJUIRogWg8gVkzGggbFYMiU?=
 =?us-ascii?q?xkPji0WHMwTJzI9AgcCBw4DC5FoEReBVQEB?=
IronPort-Data: A9a23:75bPdKLhIG9OZZq9FE+REZQlxSXFcZb7ZxGr2PjKsXjdYENS1mQPz
 mUbCm/XOa2ONzTzfIpxOdizpE4PvZXXxtVlGlQd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnR0
 T/Oi5eHYgH9hWQlajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1iJ386I9ARy98vX0EJy
 cwZeRcjTBuq0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBUrAtQIvIROPB4towMDUY358VW62BI
 ZBENHw2MEiojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZjeC3aoCKJYbSLSlTtnic+
 0Ga4D7LOBUhbsy742Kv0SiFlOCayEsXX6pXTtVU7MVCjFSNy2k7BBQIWF6/pvelzEizR7p3J
 kAJ/yM8oLQa+0usQd3wGRa/pRasvQMWUvJTHvc85QXLzbDbiy6QAGQeQyECbtE6uMIobTg30
 FnPlNOBLSRmurCTSFqH+7uUpC/0Mi8QRUcGZCkZXU4G7sPlrYUbkB3CVJBgHbSzg9mzHiv/q
 xiMoTQyiqs7k8EGzeO48ErBjjbqoYLGJjPZ/S3NVW6jqwc8b4m/asnwth7Q7O1LK8CSSVzpU
 GU4pvVyJdsmVfml/BFhis1XdF11z55p6AHhvGM=
IronPort-HdrOrdr: A9a23:arbqUKF+NQ9SkMnhpLqEHseALOsnbusQ8zAXPo5KOHhom6uj9v
 xG/c506faaslsssR0b8+xofZPwI080lqQb3WBuB9eftWDd0QPCEGgh1/qA/9SKIUHDH4BmpM
 JdWpk7JdHuAV19lMrgpCu1A78bsaC62ZHtqOvAw3JqVA1wL5th4QBwFxqBHiRNNW977OICZf
 2hz/sCgSa8cnIKacn+LHwEU+/f4+DvrvvdEGY779pN0nj1sdtug4SKaCSl4g==
X-Talos-CUID: =?us-ascii?q?9a23=3A7X9zXmjyaWMhEF1+XUnJwK8o8zJuflbjwGmNKn6?=
 =?us-ascii?q?BUThJD4GlSA631oFvup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3Aw13KsQ/zwC1efDBErbxfde2Qf/lsvofyFxo/q5E?=
 =?us-ascii?q?94dmgH3RaGG20njviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,232,1774310400"; 
   d="scan'208";a="502227720"
Received: from rcdn-l-core-07.cisco.com ([173.37.255.144])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 29 Jun 2026 17:26:05 +0000
Received: from [127.0.0.1] (unknown [10.25.130.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-07.cisco.com (Postfix) with ESMTPS id 78E96180000B5;
	Mon, 29 Jun 2026 17:26:04 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
Date: Mon, 29 Jun 2026 10:26:01 -0700
Subject: [PATCH net-next v10 09/12] enic: add MBOX VF handlers for
 capability, register and link state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-enic-sriov-v2-admin-channel-v2-v10-9-62569af83417@cisco.com>
References: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
In-Reply-To: <20260629-enic-sriov-v2-admin-channel-v2-v10-0-62569af83417@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sesidhar Baddela <sebaddel@cisco.com>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753956; l=12353;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=g9r2nMWr4IiSOm55XqthrmvPeTLBvPsdUVRXpVRBLHM=;
 b=Ka0iaSozI0PI/my5yPAJo7V6WNm7A2xzTNF93PoQDW8gfwLWo9BFS0ajN0BSfB6XhIfAJxqIq
 CJYFrEmNNU3DDXDO3ualQlBJzuGxSmzcjXKsT3vQTuolvpGI2IINndY
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.130.254];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.130.254, [10.25.130.254]
X-Outbound-Node: rcdn-l-core-07.cisco.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[cisco.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-302745-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cisco.com:dkim,cisco.com:email,cisco.com:mid,cisco.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 024396DDBBD

Implement VF-side mailbox message processing for SR-IOV V2
admin channel communication.

VF receive handlers:
  - VF_CAPABILITY_REPLY: store PF protocol version, signal
    completion
  - VF_REGISTER_REPLY: mark VF as registered, signal completion
  - VF_UNREGISTER_REPLY: mark VF as unregistered, signal
    completion
  - PF_LINK_STATE_NOTIF: update carrier state via
    netif_carrier_on/off, send ACK back to PF

VF initiation functions for the probe-time handshake:
  - enic_mbox_vf_capability_check: send capability request,
    wait for PF reply via completion
  - enic_mbox_vf_register: send register request, wait for
    PF confirmation via completion
  - enic_mbox_vf_unregister: send unregister request, wait
    for PF confirmation

The wait helper (enic_mbox_wait_reply) uses
wait_for_completion_timeout, signaled when the admin ISR and
CQ-poll/dispatch workqueue pipeline delivers the reply message.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic.h      |  11 ++
 drivers/net/ethernet/cisco/enic/enic_mbox.c | 277 +++++++++++++++++++++++++++-
 drivers/net/ethernet/cisco/enic/enic_mbox.h |   3 +
 3 files changed, 290 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index d459318c46fc..a9a376d2cf0e 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -258,6 +258,8 @@ struct enic {
 	u32 tx_coalesce_usecs;
 	u16 num_vfs;
 	enum enic_vf_type vf_type;
+	bool vf_registered;
+	u32 pf_cap_version;
 	unsigned int enable_count;
 	spinlock_t enic_api_lock;
 	bool enic_api_busy;
@@ -313,6 +315,15 @@ struct enic {
 	/* MBOX protocol state — mbox_lock serializes admin WQ sends */
 	struct mutex mbox_lock;
 	u64 mbox_msg_num;
+	/* MBOX request-reply state.  Written by the process-context request
+	 * helpers (capability/register/unregister) and read/cleared by the
+	 * admin_msg_work receive handlers.  No explicit lock is needed because
+	 * only one request is in flight at a time: requesters run under RTNL or
+	 * single-threaded probe/remove, so each request is serialized and its
+	 * reply completes mbox_comp before the next request is issued.
+	 */
+	struct completion mbox_comp;
+	u8 mbox_expected_reply;
 
 	/* PF: per-VF MBOX state, allocated when SRIOV V2 is enabled */
 	struct enic_vf_state {
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.c b/drivers/net/ethernet/cisco/enic/enic_mbox.c
index b6f05b03ae26..4676a9a15af5 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.c
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.c
@@ -5,6 +5,7 @@
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
+#include <linux/completion.h>
 
 #include "vnic_dev.h"
 #include "vnic_wq.h"
@@ -135,6 +136,16 @@ int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 	return err;
 }
 
+static int enic_mbox_wait_reply(struct enic *enic, unsigned long timeout_ms)
+{
+	unsigned long left;
+
+	left = wait_for_completion_timeout(&enic->mbox_comp,
+					   msecs_to_jiffies(timeout_ms));
+
+	return left ? 0 : -ETIMEDOUT;
+}
+
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state)
 {
 	struct enic_mbox_pf_link_state_notif_msg notif = {};
@@ -306,6 +317,166 @@ static void enic_mbox_pf_process_msg(struct enic *enic,
 			    hdr->msg_type, vf_id, err);
 }
 
+static void enic_mbox_vf_handle_capability_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_capability_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_CAPABILITY_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale capability reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major) == 0)
+		enic->pf_cap_version = le32_to_cpu(reply->version);
+	else
+		netdev_warn(enic->netdev,
+			    "MBOX: PF rejected capability request: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_register_reply(struct enic *enic,
+					       void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_REGISTER_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale register reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF register rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = true;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_unregister_reply(struct enic *enic,
+						 void *payload)
+{
+	struct enic_mbox_vf_register_reply_msg *reply = payload;
+
+	if (enic->mbox_expected_reply != ENIC_MBOX_VF_UNREGISTER_REPLY) {
+		netdev_warn(enic->netdev,
+			    "MBOX: stale unregister reply (expected %u), drop\n",
+			    enic->mbox_expected_reply);
+		return;
+	}
+
+	if (le16_to_cpu(reply->reply.ret_major)) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF unregister rejected by PF: %u/%u\n",
+			    le16_to_cpu(reply->reply.ret_major),
+			    le16_to_cpu(reply->reply.ret_minor));
+	} else {
+		enic->vf_registered = false;
+	}
+	complete(&enic->mbox_comp);
+}
+
+static void enic_mbox_vf_handle_link_state(struct enic *enic, void *payload)
+{
+	struct enic_mbox_pf_link_state_notif_msg *notif = payload;
+	struct enic_mbox_pf_link_state_ack_msg ack = {};
+	int err;
+
+	switch (le32_to_cpu(notif->link_state)) {
+	case ENIC_MBOX_LINK_STATE_ENABLE:
+		if (!netif_carrier_ok(enic->netdev))
+			netif_carrier_on(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> UP\n");
+		break;
+	case ENIC_MBOX_LINK_STATE_DISABLE:
+		if (netif_carrier_ok(enic->netdev))
+			netif_carrier_off(enic->netdev);
+		netdev_dbg(enic->netdev, "MBOX: link state -> DOWN\n");
+		break;
+	default:
+		netdev_warn(enic->netdev, "MBOX: unknown link state %u\n",
+			    le32_to_cpu(notif->link_state));
+		ack.ack.ret_major = cpu_to_le16(ENIC_MBOX_ERR_GENERIC);
+		break;
+	}
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_PF_LINK_STATE_ACK,
+				 ENIC_MBOX_DST_PF, &ack, sizeof(ack));
+	if (err && net_ratelimit())
+		netdev_warn(enic->netdev,
+			    "MBOX: failed to send link state ACK: %d\n", err);
+}
+
+static bool enic_mbox_vf_payload_ok(struct enic *enic, u8 msg_type,
+				    u16 payload_len, size_t min_len)
+{
+	if (payload_len < min_len) {
+		netdev_warn(enic->netdev,
+			    "MBOX: short payload for type %u (%u < %zu)\n",
+			    msg_type, payload_len, min_len);
+		return false;
+	}
+	return true;
+}
+
+static void enic_mbox_vf_process_msg(struct enic *enic,
+				     struct enic_mbox_hdr *hdr, void *payload,
+				     u16 payload_len)
+{
+	switch (hdr->msg_type) {
+	case ENIC_MBOX_VF_CAPABILITY_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_capability_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_capability_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_REGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_register_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_VF_UNREGISTER_REPLY: {
+		size_t exp = sizeof(struct enic_mbox_vf_register_reply_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_unregister_reply(enic, payload);
+		break;
+	}
+	case ENIC_MBOX_PF_LINK_STATE_NOTIF: {
+		size_t exp = sizeof(struct enic_mbox_pf_link_state_notif_msg);
+
+		if (!enic_mbox_vf_payload_ok(enic, hdr->msg_type,
+					     payload_len, exp))
+			return;
+		enic_mbox_vf_handle_link_state(enic, payload);
+		break;
+	}
+	default:
+		netdev_dbg(enic->netdev,
+			   "MBOX: VF unhandled msg type %u\n",
+			   hdr->msg_type);
+		break;
+	}
+}
+
 static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 				   unsigned int len)
 {
@@ -344,13 +515,117 @@ static void enic_mbox_recv_handler(struct enic *enic, void *buf,
 
 	payload = buf + sizeof(*hdr);
 
-	if (enic->vf_state)
+	if (enic->vf_state) {
 		enic_mbox_pf_process_msg(enic, hdr, payload);
+	} else if (le16_to_cpu(hdr->src_vnic_id) == ENIC_MBOX_DST_PF) {
+		/* src_vnic_id was overwritten from the hardware-verified CQ
+		 * VLAN sender field, so a VF only accepts messages that the
+		 * adapter attributes to the PF.  Its sole admin-channel peer is
+		 * the PF; drop anything else as a spoofed notification.
+		 */
+		enic_mbox_vf_process_msg(enic, hdr, payload,
+					 msg_len - (u16)sizeof(*hdr));
+	} else if (net_ratelimit()) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF dropping non-PF message from vnic %u\n",
+			    le16_to_cpu(hdr->src_vnic_id));
+	}
+}
+
+int enic_mbox_vf_capability_check(struct enic *enic)
+{
+	struct enic_mbox_vf_capability_msg req = {};
+	int err;
+
+	enic->pf_cap_version = 0;
+	reinit_completion(&enic->mbox_comp);
+	enic->mbox_expected_reply = ENIC_MBOX_VF_CAPABILITY_REPLY;
+	req.version = cpu_to_le32(ENIC_MBOX_CAP_VERSION_1);
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_CAPABILITY_REQUEST,
+				 ENIC_MBOX_DST_PF, &req, sizeof(req));
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: no capability reply from PF\n");
+		return err;
+	}
+
+	if (enic->pf_cap_version < ENIC_MBOX_CAP_VERSION_1) {
+		netdev_warn(enic->netdev,
+			    "MBOX: PF version %u too old\n",
+			    enic->pf_cap_version);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int enic_mbox_vf_register(struct enic *enic)
+{
+	int err;
+
+	enic->vf_registered = false;
+	reinit_completion(&enic->mbox_comp);
+	enic->mbox_expected_reply = ENIC_MBOX_VF_REGISTER_REPLY;
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_REGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err) {
+		netdev_warn(enic->netdev,
+			    "MBOX: VF registration with PF timed out\n");
+		return err;
+	}
+
+	if (!enic->vf_registered)
+		return -ENODEV;
+
+	return 0;
+}
+
+int enic_mbox_vf_unregister(struct enic *enic)
+{
+	int err;
+
+	if (!enic->vf_registered)
+		return 0;
+
+	reinit_completion(&enic->mbox_comp);
+	enic->mbox_expected_reply = ENIC_MBOX_VF_UNREGISTER_REPLY;
+
+	err = enic_mbox_send_msg(enic, ENIC_MBOX_VF_UNREGISTER_REQUEST,
+				 ENIC_MBOX_DST_PF, NULL, 0);
+	if (err) {
+		enic->mbox_expected_reply = 0;
+		return err;
+	}
+
+	err = enic_mbox_wait_reply(enic, 3000);
+	enic->mbox_expected_reply = 0;
+	if (err)
+		return err;
+	if (enic->vf_registered)
+		return -EACCES;
+	return 0;
 }
 
 void enic_mbox_init(struct enic *enic)
 {
 	enic->mbox_msg_num = 0;
 	mutex_init(&enic->mbox_lock);
+	init_completion(&enic->mbox_comp);
 	enic->admin_rq_handler = enic_mbox_recv_handler;
 }
diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
index f1de67db1273..15e30ee2b0ed 100644
--- a/drivers/net/ethernet/cisco/enic/enic_mbox.h
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -88,5 +88,8 @@ void enic_mbox_init(struct enic *enic);
 int enic_mbox_send_msg(struct enic *enic, u8 msg_type, u16 dst_vnic_id,
 		       void *payload, u16 payload_len);
 int enic_mbox_send_link_state(struct enic *enic, u16 vf_id, u32 link_state);
+int enic_mbox_vf_capability_check(struct enic *enic);
+int enic_mbox_vf_register(struct enic *enic);
+int enic_mbox_vf_unregister(struct enic *enic);
 
 #endif /* _ENIC_MBOX_H_ */

-- 
2.43.0


