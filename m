Return-Path: <netdev+bounces-289951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK7OEoy/DWr32wUAu9opvQ
	(envelope-from <netdev+bounces-289951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:05:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A5F58F465
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 16:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BDDE300B13C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62C3939D3;
	Wed, 20 May 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLuaInrL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6A72F549C
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285050; cv=none; b=LClR4LOiCwZessJOxSuQxkEasnEqBh3zlKI32cy2n1+QQly0tb1EiovxUmhMnKmocbyElkEYo6wUCm3mW+0tSYoLDcC4shSYSUWf4wmymRy8pJFtPiBN5ttjFxZVU38SpJorJ8p5TvYZ5SJt5aJzCAOkqpV4mMtl+EiZXvVQJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285050; c=relaxed/simple;
	bh=V8kEWX7aacPDgr69xJjI766tL4M9rqVYuHze2pOIrps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0dNbEJx1epHdDJ438cKQTA5GIMRzPrnxGIBY9clnC81g58FFHy30toYOH2LTzFLTux12OaaZNhfP1hDlrl0k/Phlc4YU1b329hpnsI5A0cggKXtrjMFwyOqyTUWlCjMetOmdR03TIdNZataXVc5yRsrWo/DZCf9hNdSMPx5Eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLuaInrL; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51306c9f2e1so60171691cf.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285048; x=1779889848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWLZlw1o5rrWsIR88B5vFwajJpqsIVjTgSharoBZII8=;
        b=NLuaInrLfwbvjbCjfPE90t+InoopK+JcVVBlyiccs6vKFaHPeSIApxcHagNnO3F6OF
         NYdPJZXRllw3Y6x6c+aSDSnw2ywYjdbkGJpiasB8VtZPqxb24w4NHA1yIw2cN0iDIEc9
         UpjuGI3JRjCPZ4helqTCseWKnzUB5Ki5OYdv5u77m4T29aJ6sj8aHu5j+TeDa+XEYnGA
         +WkgqPiT3hBkEky6shAe1QlDSOhMQ46JPSm0fgmSVtwMS4jfWIDy2pqAYG6AbMmeUjao
         4issY2+GGYBsVGtcwk/4VM6ufzEdQ4Ug1+SQy1mtNlCyYHKWU2HLGF3NuqEG/YDR1Yuo
         QSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285048; x=1779889848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWLZlw1o5rrWsIR88B5vFwajJpqsIVjTgSharoBZII8=;
        b=nlcI9Cz3TVulKsB8kx+xkayl3kB8+CHCdMMwB7rChTnFZSDIWF3KAgLJg5HILbdP6b
         RUlMpld8Wphv71rc5t6xaGIj+3WD2gCbkB2TQUHaQ5x3Wmf94QkDPNTAgEB5nxRTEzc3
         ivWnxXYyQ5F+dM0WzDaSRboQYCef3cYasvuZbn+iK1E8Swc6NmlLg7NFULvE8IX9tQNq
         2wdKQwfiZYRlye0MuPYNg7sk6yZYUEeKdMs6Ihm3PIqznHu9tL4C90NxZCgL/Nz7r9yr
         RY5Yzo31ZuaSXfASVoDb3koD5B/JdeMhHACblulhQicXuJAHH9xY/pzQMRbIgzcc3tEG
         eP8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9BQmngEiQKSGh4AZrn6B5Rl4mgZe60qQ+rqJUn78DEP+z3NWpPqGHBvAPKSnQHWVXlf0C8RgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8vV/LG0YkszYexmDon16aCkGcFMj9OyrPAUdVodyg95pio7eQ
	m7SPx/cISK606euFjHbDaAE2C27F7cN9VXZZLioqzwvnuee8qtqnH1ynK+N5EOAa
X-Gm-Gg: Acq92OEWhb7KjjcltDGZm4GLyuTBuNS8f3he5jYu/fXE6mZsqxxYNNpbY2l5n3nXdbi
	KDrSChElxDZzdElbtKO2xVIRwIBFSXJzuNBxsUYTO731tMb1Z/1+PGCoCmbE5zcY3J+nDCw5Qoa
	x0FbSFvNo5jbP82xtjeEGqxoNsjgtGy6r5rL85taO1hWY/IZoGw+Yp6BpBhgxoKBK5lHw3f2jf7
	jOV047EMqQ8jY5/JA5whXUuQj4nnKtkgmHPWfhXA7W85eWPeIhOHzDwluLe9Xa8HACsVVx7tixc
	rySewcmLFf/JngUSsVusWXvpvtTYEHCG2690Pc5PBzSx6BjktEps/ki90NMlSmbNke1deAo4YFw
	V+p586Egt7/I+abM9TjcIDlTRhmvoXp4Ytubry4mqCB1BIyM3ztbnaGDIolDqCqaVEcsZNeI83t
	cmMBK212v5HypC8Q1DzwmwKwyBbcx7vm2WLkPHXPdo45iQFAj9laYClcw/LUil4SwWgfFwjDEe/
	6vtltuobY0vceBtC4ESDQP5j8G9fgg=
X-Received: by 2002:ac8:5cd0:0:b0:50e:60b7:bb40 with SMTP id d75a77b69052e-51659ede9c0mr359598541cf.0.1779285047670;
        Wed, 20 May 2026 06:50:47 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456889dcsm202159561cf.2.2026.05.20.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:50:46 -0700 (PDT)
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
Subject: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
Date: Wed, 20 May 2026 09:50:34 -0400
Message-ID: <20260520135034.1060859-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E0A5F58F465
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
signaling packets up to the channel MTU and dispatches each command
without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
within radio range can send a fixed-channel CID 0x0001 packet that is
larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
pairing.

In a real-radio stock-kernel run, one 681-byte signaling
packet containing 168 zero-length ECHO_REQ commands made the target
transmit 168 ECHO_RSP frames over about 220 ms.

Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
reject larger signaling packets before dispatching their commands. When
the over-MTUsig packet contains a request command, send one
L2CAP_COMMAND_REJECT_RSP with L2CAP_REJ_MTU_EXCEEDED and the first
request identifier; packets for which no valid request command is found
are dropped.

Cc: stable@vger.kernel.org
Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
harness that sends a single fixed-channel signaling packet containing
packed zero-length ECHO_REQ commands. The patched code builds for
net/bluetooth/l2cap_core.o on x86_64 defconfig. There are no in-tree
Bluetooth selftests that reference l2cap_sig_channel(), L2CAP_SIG_MTU,
or L2CAP_ECHO_REQ.

The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
trace to the initial git import; no later introducing commit is
available for a Fixes tag.

Changes in v2:
- Replace the per-PDU echo-count cap with the MTUsig direction from
  review.
- Reject the whole over-MTUsig signaling packet with one
  L2CAP_REJ_MTU_EXCEEDED command reject.
- Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
  command identifier is found.

v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@gmail.com
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index 77dec104a9c36..5417e3cb0636d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5626,6 +5626,55 @@ static inline void l2cap_sig_send_rej(struct l2cap_conn *conn, u16 ident)
 	l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 }
 
+static bool l2cap_sig_cmd_is_req(u8 code)
+{
+	switch (code) {
+	case L2CAP_CONN_REQ:
+	case L2CAP_CONF_REQ:
+	case L2CAP_DISCONN_REQ:
+	case L2CAP_ECHO_REQ:
+	case L2CAP_INFO_REQ:
+	case L2CAP_CONN_PARAM_UPDATE_REQ:
+	case L2CAP_LE_CONN_REQ:
+	case L2CAP_ECRED_CONN_REQ:
+	case L2CAP_ECRED_RECONF_REQ:
+		return true;
+	}
+
+	return false;
+}
+
+static u8 l2cap_sig_first_req_ident(const struct sk_buff *skb)
+{
+	const u8 *data = skb->data;
+	unsigned int len = skb->len;
+
+	while (len >= L2CAP_CMD_HDR_SIZE) {
+		const struct l2cap_cmd_hdr *cmd = (const void *)data;
+		u16 cmd_len = le16_to_cpu(cmd->len);
+
+		if (cmd->ident && l2cap_sig_cmd_is_req(cmd->code))
+			return cmd->ident;
+
+		if (cmd_len > len - L2CAP_CMD_HDR_SIZE)
+			break;
+
+		data += L2CAP_CMD_HDR_SIZE + cmd_len;
+		len -= L2CAP_CMD_HDR_SIZE + cmd_len;
+	}
+
+	return 0;
+}
+
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
@@ -5638,6 +5687,17 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 	if (hcon->type != ACL_LINK)
 		goto drop;
 
+	if (skb->len > L2CAP_SIG_MTU) {
+		u8 ident = l2cap_sig_first_req_ident(skb);
+
+		BT_DBG("signaling packet exceeds MTU");
+
+		if (ident)
+			l2cap_sig_send_mtu_rej(conn, ident);
+
+		goto drop;
+	}
+
 	while (skb->len >= L2CAP_CMD_HDR_SIZE) {
 		u16 len;
 
-- 
2.53.0


