Return-Path: <netdev+bounces-276582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEwOEmpw1ml2FQgAu9opvQ
	(envelope-from <netdev+bounces-276582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:12:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D43FC3BE06A
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87D03085D84
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AC3D7D8F;
	Wed,  8 Apr 2026 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm8bZtwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA83D6480;
	Wed,  8 Apr 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660897; cv=none; b=GJYm6cyt1DMDK4SmNnejeYerKHEoecTESGaUas/3URqmMbG+ZL/jaGwTSXYE0HWMiuqfYSAYSDjCkx0idAyXIvGshpUo7pMYCKZl19Kjqx6Ohu0yZwG7QJqhny9MSFZ3H0RX1ijeSSnEU2T8i35ZL8ydNdQf65Oj2AaR/cdOOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660897; c=relaxed/simple;
	bh=CHD2sGmHFADoajsajVO5DHFLgnLfs7K8NFH7Cqwp6P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mXuyOrK3rTq4zBSUuaTm8s/yJ1Ga4NMdf/i+3W/QGiaghr7d/Jan7OFz81ivCWDwv5Eiu7u4nMiyORfqa8VTmvbWqzF/awJiHvrqbjRLERVmLsl8/qcJQobKwOqZtl1/aCSJSSfrLvrRH73np4XWPg+J4FrTJ35WAD13v19Hd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm8bZtwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57139C2BC9E;
	Wed,  8 Apr 2026 15:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775660897;
	bh=CHD2sGmHFADoajsajVO5DHFLgnLfs7K8NFH7Cqwp6P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hm8bZtwVEAxaLpGXkYBwgnyZqYf28O7SJkVdXxvUsQ8b37CnAWxYHa+kepdUkdZP0
	 8B1iFmI7hU8U7TAC+Uhuxx47YUEgCTUxQlwHmJ4vQ8SPbdvMcnAnPt2HWEYeHzh9fz
	 pUcHvABXmWIlWkJtNzoEXGiZk55qgiIxei4O0bUBknQ8tX859ruGHyOCTmq8b0Y8PZ
	 3hkDacjWlAKOvrYz4pGm+e8AtISwfdTFcI4Gf7Q0SRxKXNmVNr+RJuD94L+pO6/Aje
	 DqZZMJ5YaDlTzzmDi0q5adFQ4avNi6Ns9UqWKo0xToK3VK62xEp04jheWuJYET1D5r
	 vwvtpllsaq+Tw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDC910F9951;
	Wed,  8 Apr 2026 15:08:17 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 08 Apr 2026 08:08:15 -0700
Subject: [PATCH net-next v2 05/10] enic: define MBOX message types and
 header structures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-enic-sriov-v2-admin-channel-v2-v2-5-d05dd3623fd3@cisco.com>
References: <20260408-enic-sriov-v2-admin-channel-v2-v2-0-d05dd3623fd3@cisco.com>
In-Reply-To: <20260408-enic-sriov-v2-admin-channel-v2-v2-0-d05dd3623fd3@cisco.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, 
 Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775660895; l=2895;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=QgPYsFppAoUswndbEnI+khJeTR1Tn6EJVQstlZ2VNn8=;
 b=SvcPPF0rDJm5105r42W0Nqh0xzJqjTabA2xP9zdHaIFdMUKYNv/7RZ3LyRu/DIc+ILZwlKa4b
 fqoXXRD4tAfAqmg5IGGKYIbJjTaE0IRWyn/1Fzw2ngAcEErcH9WCBn4
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276582-lists,netdev=lfdr.de,satishkh.cisco.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:email,cisco.com:replyto,cisco.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D43FC3BE06A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Satish Kharat <satishkh@cisco.com>

Define the mailbox protocol used for PF-VF communication over the
admin channel. The protocol uses request/reply pairs where even
message types are requests and odd are replies.

Initial message types cover the core SR-IOV handshake:
  - VF_CAPABILITY: version negotiation
  - VF_REGISTER/UNREGISTER: VF lifecycle management
  - PF_LINK_STATE_NOTIF: PF-initiated link state changes

Each message carries a common header (src/dst vnic ID, type,
length, sequence number) followed by a type-specific payload.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_mbox.h | 75 +++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_mbox.h b/drivers/net/ethernet/cisco/enic/enic_mbox.h
new file mode 100644
index 000000000000..84cb6bbc1ead
--- /dev/null
+++ b/drivers/net/ethernet/cisco/enic/enic_mbox.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright 2025 Cisco Systems, Inc.  All rights reserved. */
+
+#ifndef _ENIC_MBOX_H_
+#define _ENIC_MBOX_H_
+
+/*
+ * Mailbox protocol for PF-VF communication over the admin channel.
+ *
+ * Even numbers are requests, odd numbers are replies/acks.
+ * The prefix indicates the initiator: VF_ = VF-initiated, PF_ = PF-initiated.
+ */
+enum enic_mbox_msg_type {
+	ENIC_MBOX_VF_CAPABILITY_REQUEST		= 0,
+	ENIC_MBOX_VF_CAPABILITY_REPLY		= 1,
+	ENIC_MBOX_VF_REGISTER_REQUEST		= 2,
+	ENIC_MBOX_VF_REGISTER_REPLY		= 3,
+	ENIC_MBOX_VF_UNREGISTER_REQUEST		= 4,
+	ENIC_MBOX_VF_UNREGISTER_REPLY		= 5,
+	ENIC_MBOX_PF_LINK_STATE_NOTIF		= 6,
+	ENIC_MBOX_PF_LINK_STATE_ACK		= 7,
+	ENIC_MBOX_MAX
+};
+
+struct enic_mbox_hdr {
+	__le16 src_vnic_id;
+	__le16 dst_vnic_id;
+	u8 msg_type;
+	u8 flags;
+	__le16 msg_len;
+	__le64 msg_num;
+};
+
+struct enic_mbox_generic_reply {
+	__le16 ret_major;
+	__le16 ret_minor;
+};
+
+#define ENIC_MBOX_ERR_GENERIC		BIT(0)
+#define ENIC_MBOX_ERR_VF_NOT_REGISTERED	BIT(1)
+#define ENIC_MBOX_ERR_MSG_NOT_SUPPORTED	BIT(2)
+
+/* ENIC_MBOX_VF_CAPABILITY_REQUEST / _REPLY */
+#define ENIC_MBOX_CAP_VERSION_0		0
+#define ENIC_MBOX_CAP_VERSION_1		1
+
+struct enic_mbox_vf_capability_msg {
+	__le32 version;
+	__le32 reserved[32];
+};
+
+struct enic_mbox_vf_capability_reply_msg {
+	struct enic_mbox_generic_reply reply;
+	__le32 version;
+	__le32 reserved[32];
+};
+
+/* ENIC_MBOX_VF_REGISTER / _UNREGISTER */
+struct enic_mbox_vf_register_reply_msg {
+	struct enic_mbox_generic_reply reply;
+};
+
+/* ENIC_MBOX_PF_LINK_STATE_NOTIF / _ACK */
+#define ENIC_MBOX_LINK_STATE_DISABLE	0
+#define ENIC_MBOX_LINK_STATE_ENABLE	1
+
+struct enic_mbox_pf_link_state_notif_msg {
+	__le32 link_state;
+};
+
+struct enic_mbox_pf_link_state_ack_msg {
+	struct enic_mbox_generic_reply ack;
+};
+
+#endif /* _ENIC_MBOX_H_ */

-- 
2.43.0



