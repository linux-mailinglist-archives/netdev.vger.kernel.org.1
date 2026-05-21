Return-Path: <netdev+bounces-290156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mq+3AsJPDmpQ9wUAu9opvQ
	(envelope-from <netdev+bounces-290156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:20:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78D59D41E
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7767330053C7
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33D72618;
	Thu, 21 May 2026 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwMtHCJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE1226ACC
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322415; cv=none; b=YTpSdzu9H68d+krPYgulHmc/V36TtsTKrae/I3FIvX6nmKG8cxamaSXMe6Zo7eYsi8corJRugHSP+ZjiJV0Qek+IQo7j/CdBDY9b8Baljs1aaT11m7jfZi2W7iCvVNLpZlrkVeX7BBCw+LmpjBATV6P0uIsh1e2AabJPigvl/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322415; c=relaxed/simple;
	bh=FlsmVjLwUtTt/F4MvdmnB8CMJCrNXKRgcWVC4IHb4pY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lie/UZgdBq/A+nlopAQ9o2xCSLQfxc3Rl1CI7fn7FAKq2TpMSVbCV2IOaAn5twaSWQSqPYQB8w87aY0hkFGczdI9E8dUqmnvJ6XqTnhNHqCk8uGsExY3ssKVf3i860QqYVXpYGYBvI++hvQktbI+J1CfbFtfT5eTeOqJSpzRfeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwMtHCJh; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b4000e51fdso59179776d6.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322413; x=1779927213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ec1/vUBu03Pfy6PXr2QzxM/B7hkCHbmI2D/iRwpt3o=;
        b=rwMtHCJhbWKvdE2kSBfBRrgi++M1yJlOZWSPo8LWbCUeT+w7n3HTtU4Ef2ogwE2Cbd
         UlKX8nKutirYHy+XjM3HgLiyJ1tetB7EeTKunPuApm7pI5UjPv0J7dXfAbMYbW9Dkmsl
         uvOfO3s4kpjrDI2uumV7H0QWWjPGHBQG8Yw73k84Mi6lTRoMnaRwC+p70FkoCz1xxmcf
         bsvBkl6JL6lLT9Lo4+w+9klVt996+XbXt5mVC1ZL95uyb1sV+nlodp4ejH+eaXqp/6rW
         qjGFEsFE3hQjuBuuoahRr63edSLpfqQY7F8yYGWkE+WTLbPigdb9Q9xp0FXeUHzOnztB
         Bdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322413; x=1779927213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ec1/vUBu03Pfy6PXr2QzxM/B7hkCHbmI2D/iRwpt3o=;
        b=IrDrJHNyUB0eiIKxnqIFsIkeIC40YfCLRJDU+nKqSI0zk/QFHjrFr7+uMo0wdTSHix
         wa/XgYdlmMSgiCELoYzsD8dJJ0i22Gzk380+rhHFsA9O0I8lbxQmTCrdgILHOYiKo4m3
         04fElUXm4w1Sv5QHFu9jPfRBGWsB8MmG4RKxsNpI9cPFtG3o6rexSLzw39ysB8SbwLSb
         YQny9wohr8hY77mziyEuTiTmV2XKI3GVkAxy8P8XasFvK2E9xr9rd0l2I6XOUEvg+Cvw
         9jpbfEaNLJYrxj0FTonWo5CJt5C/6WuwjdmI96spGeWL9ShcMBWDTsYKICPC+AyQAB15
         AuQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8F1xeahfZkYcPHgDwgAUFltjUmK3SWJRF0BX4z8/YUZKieol8wPW/V7iSWKQaemqQEVElT+DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHFfx0goXvYZhwrzmCw91pOIGB7dbV5Qzj9yWiDtzcdN4dGqS
	IJg1ziBfqm7UFUoNSyMOxHJKlZSeuQkqUG0n0XT386ti2NGzk35MBdq1
X-Gm-Gg: Acq92OGl3pHM0mVWaC1h+HyAAl28Dwapxc2BbORPwZ7Y2KZOjpoam/ozsqM/G+d/McG
	PBIFHwGfn3iAkvY6MdX0nCxVENXK7sSs40H1wNKZ+sO+uNHpYy5ZSnTNOAm4iwQvCzrm0+kdhxS
	8/1UymV5LX8RZa8QXHq+37Lw9KuPLX3igLBB+xV5BsSsAu1EvEu7jKmI+V+MxwqfwiKKKZnHmdW
	kiVoPNzMRVAzq6q9Kc/lqQJk1NzQCa0xCmC3c6pK6xMRGl3aAEBmE6QAO/4uYXX6sgINtg0k2cN
	p3lTP4BXG3jPYVvQAVgkjBTh1B6R8hO3DzUWd3GPoIMHddQZ6kuFHoXIyJ9PNlV7ic2FfcaxbmX
	R/UmASbZ1+jcF5D1OllK4FC1YYZ4rJu9+dhlBHn1EPW6ArRhOVj3SPUWN6BTyGnxzjcF6Hvozpo
	O1CKjUP26er4hfNBlOR4TSJeQruPlElkyRCDEArjs8ytl70GDogLq7fCsAQYsmkmcKTG7Fe5B91
	RNa7oyOuBbFhn/1S7yC
X-Received: by 2002:a05:6214:1d0d:b0:8ca:1d2d:4a51 with SMTP id 6a1803df08f44-8cc6e6b5769mr11687466d6.49.1779322412647;
        Wed, 20 May 2026 17:13:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36096575sm134875496d6.13.2026.05.20.17.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:13:32 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
Date: Wed, 20 May 2026 20:13:27 -0400
Message-ID: <20260521001327.3729880-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290156-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 4C78D59D41E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
signaling packets up to the channel MTU and dispatches each command
without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
within radio range can send a fixed-channel CID 0x0001 packet that is
larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
pairing. In a real-radio stock-kernel run, one 681-byte signaling
packet containing 168 zero-length ECHO_REQ commands made the target
transmit 168 ECHO_RSP frames over about 220 ms.

Impact: a Bluetooth BR/EDR peer within radio range, before pairing, can
force 168 ECHO_RSP frames from one 681-byte fixed-channel signaling
packet containing packed ECHO_REQ commands.

Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
reject any larger signaling packet with one L2CAP_COMMAND_REJECT_RSP
carrying L2CAP_REJ_MTU_EXCEEDED before any command is dispatched.

The Bluetooth Core spec wording for MTUExceeded says the reject
identifier shall match the first request command in the packet, and
that packets containing only responses shall be silently discarded.
Linux intentionally deviates from that prescription: silently
discarding desynchronizes the peer because the remote stack never
learns its responses were dropped, and locating the first request
command requires walking command headers past MTUsig, i.e. processing
bytes from a packet we have already decided is too large to process.
We therefore always emit one reject and use the identifier from the
first command header (a single fixed-offset byte read), falling back
to zero when the packet is too short to carry a header at all.

The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
trace to the initial git import; no later introducing commit is
available for a Fixes tag.

Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Resending as top level message per netdev guidance.

I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
harness that sends a single fixed-channel signaling packet containing
packed zero-length ECHO_REQ commands, and confirmed on a patched kernel
that the same packet now produces one L2CAP_REJ_MTU_EXCEEDED command
reject and zero ECHO_RSP frames. The patched code builds for
net/bluetooth/l2cap_core.o on x86_64 defconfig with W=1. There are no
in-tree Bluetooth selftests that reference l2cap_sig_channel(),
L2CAP_SIG_MTU, or L2CAP_ECHO_REQ.

Changes in v3:
- Drop l2cap_sig_cmd_is_req() and l2cap_sig_first_req_ident(); the
  reject is now unconditional and uses only the first command
  header's identifier byte at a fixed offset. Per Luiz, the spec's
  "match the first request command identifier" rule would require
  parsing past MTUsig, and the spec's "silently discard if only
  responses" rule desynchronizes the peer.
- Replace the v2 walk with a verbose comment quoting the relevant
  Bluetooth Core section and documenting why Linux deviates.

Changes in v2:
- Replace the per-PDU echo-count cap with the MTUsig direction from
  review.
- Reject the whole over-MTUsig signaling packet with one
  L2CAP_REJ_MTU_EXCEEDED command reject.
- Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
  command identifier is found.

v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
v2: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@gmail.com
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 47 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5172afee54943..e0a1f2293679a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -33,6 +33,7 @@
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
+#define L2CAP_SIG_MTU			48	/* BR/EDR signaling MTU */
 #define L2CAP_DEFAULT_FLUSH_TO		0xFFFF
 #define L2CAP_EFS_DEFAULT_FLUSH_TO	0xFFFFFFFF
 #define L2CAP_DEFAULT_TX_WINDOW		63
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7701528f11677..0b1e062057695 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5618,6 +5618,15 @@ static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
 	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 }
 
+static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 ident)
+{
+	struct l2cap_cmd_rej_mtu rej;
+
+	rej.reason = cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
+	rej.max_mtu = cpu_to_le16(L2CAP_SIG_MTU);
+	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
+}
+
 static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 				     struct sk_buff *skb)
 {
@@ -5630,6 +5639,44 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
+	/*
+	 * Bluetooth Core v5.4, Vol 3, Part A, Section 4: the BR/EDR
+	 * signaling channel has a fixed signaling MTU (MTUsig) whose
+	 * minimum and default is 48 octets.  Section 4.1 says that on
+	 * an MTUExceeded command reject the identifier "shall match
+	 * the first request command in the L2CAP packet" and that
+	 * packets containing only response commands "shall be
+	 * silently discarded".
+	 *
+	 * Linux intentionally deviates from that prescription:
+	 *
+	 *   1. Silently discarding desynchronizes the peer.  The
+	 *      remote stack never learns its responses were dropped,
+	 *      so any state machine waiting on a paired response
+	 *      stalls until its own timer fires.
+	 *
+	 *   2. Locating "the first request command" requires walking
+	 *      command headers past MTUsig, i.e. processing bytes
+	 *      from a packet we have already decided is too large to
+	 *      process.
+	 *
+	 * Reject every over-MTUsig signaling packet with one
+	 * L2CAP_REJ_MTU_EXCEEDED command reject.  The reject's
+	 * reason field is what tells the peer that the whole packet
+	 * was discarded; the identifier value is informational, so
+	 * we use the identifier from the first command header (a
+	 * single fixed-offset byte read) or zero when the packet is
+	 * too short to carry even one header.
+	 */
+	if (skb->len > L2CAP_SIG_MTU) {
+		u8 ident = (skb->len >= L2CAP_CMD_HDR_SIZE) ?
+			   skb->data[1] : 0;
+
+		BT_DBG("signaling packet exceeds MTU");
+		l2cap_sig_send_mtu_rej(conn, ident);
+		goto drop;
+	}
+
 	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
 		u16 len;
 
-- 
2.53.0


