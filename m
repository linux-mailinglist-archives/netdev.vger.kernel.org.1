Return-Path: <netdev+bounces-276729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DFRMjnX1mmPJAgAu9opvQ
	(envelope-from <netdev+bounces-276729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:31:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55E3C4867
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71D8C3019F07
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 22:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA06F35DA6F;
	Wed,  8 Apr 2026 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+5xqbTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8A8213E89
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687477; cv=none; b=MW2e8Py5nE+y99B7M3S+AA1NktZexDs6+Vh+yB2v3EAWcFM2puV8uZxGq5e0YTasno67zuXLsSHdM03E8H8i2a2YCvdswSk2S2gXmAdVqxKBVjyrXetHnoOg/Op8bV+pzIJ50sE0qtN//t9+gMzZ1iR/DIk1gc/Y7I0Qax94ExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687477; c=relaxed/simple;
	bh=i3KyVwABR6+ZY8Q5eBZZyBAgpBvsE/xVF8DDLOkQ1Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g2v+dE0K27cMyO1Quu+h9rXhujHGuCAKp1doTveh6T890mVNtG2EI5rSHFwbaemoewXEKJjILpGJyADU2kDmtl+ZUNVHhuazg0gMlnvTh489icd2StAcQDq5OjBdXHhg3l9KqyxYbal2nOhP+vpqzei9Z805q6zr4tR0fZ+oEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+5xqbTG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a151012558so3358886d6.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 15:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775687475; x=1776292275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9XPq8wWbnhUEnIYaI58LkI4aSrWX20R2iSZ085DrZ4Q=;
        b=k+5xqbTG5l8zVphhaBhucEQDfg/UeGr9a07F1K8eeEQmHT9mYdgKr6+JotCm1S9kWd
         tIbVjWTQSdZdfxQr9wPiT8sJyF9h/oW0RoOlLwuXcF4EgittkUqf9Vxb4SYUZFNf8w9e
         0XAjrKDzm16xh5dABXrHN3MR4Q/hfGMTETtzBJra3MHbNbaQOVAfhm1zhoVXCNA72bKE
         3wWVWRzULJ5Z6CObzwLwuTZLH97kHprsZzEA8liufOkpwz8CGRWtHYnui4HuX+OTQAdP
         BMH9asQjyNr6GVaRxyVrzbkPDYVwrH5Z67+t2fxcnDMU3FZeam/PzxJU32hswL0pK038
         hHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775687475; x=1776292275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XPq8wWbnhUEnIYaI58LkI4aSrWX20R2iSZ085DrZ4Q=;
        b=dvVyVKiWK5Ueg7vP/WQgulsDtVNXe+lm98lH0tHQ9jlG9OY/V0WVTiShlknve22vz+
         r4km7dYsTGd3msgB74cypDlvopUKJVA9ck5Wj1Spl5SyHta6Dom3d1jgHzK6T0XMMFgr
         j70uDhLp7HzbQGWSeF3YjAq26/gG8sbuGndsOhngVVb6SVdqnwj+60H30Wa4AyMD7Ziz
         AEJNmM/64x+DWQqaSmVAhS9k7OmJJGQntffTjwnQhJEFx3QSrcWSkXkufLtJmbdSB7xP
         KX/eM8nMGlNroVa5JRq+F5ty7lruU49Nyh0WydpPBGrJjoekSwurWhVLUolC/aAi3Wal
         xyNg==
X-Gm-Message-State: AOJu0YyDra7BEXiLrhclbdK3jFeKIlPqU49HPXv7UPLtWirJdLADClk3
	irq4SduliLMRY9EwQ7v3fPHBjzUnqrnY2fxqQyndEevcmWcLOpasbCWV9d57ENYBDws=
X-Gm-Gg: AeBDiesJxvJ8SMYtNUZmRDzx5dweZGSPVTQ8rHb7HmDGx2pS2MOwMZ/+QAejN+5J7vD
	lTT+4SEPcGZA6WzXC7dLzKFUqOITKFIqSkbjHJF5jmnpsZa5PX/Q7vsosI7Fsu/x0Jt0QjZSWoj
	FF6nI1vn6SLZ/Cji1ZXaNeE+UcRdc+jSyhBAFMFSOYItQ5wwXWo2KwRFaK/XfcONke0zKvP0fwo
	EiWpiVJsC4iVfmu6T3tseMB8ARbbu5bTUvsx4hJZluSqfsEHosoTmuKIYPksAqolz7KoD3zXNXZ
	td50lXQ5XyieGfGEAQZYYs0nilZj0W3e1jz6Kwetz9NDf8Zt8hAUjX+QFjjcwlXObB2oxFgg2IE
	6FZm7zKdhduwjmAHEnHt/WeSssfpukJpk+JKEkDiAmBi6eQyFIeRevDkpM9QEkZwv++JvyjNXN1
	pHrJtDCSciphtmS0gHb6TXlIZKjDWJycIQx1w+7CmmBzlccls54hqXqrjISY4EQMmxNvRX++qAD
	HhqD3Q3rCmLi6Dd9Kyy9yj45Pvb
X-Received: by 2002:a05:620a:25d1:b0:8d7:cf69:3bf5 with SMTP id af79cd13be357-8dc3b802ad8mr230235085a.14.1775687475324;
        Wed, 08 Apr 2026 15:31:15 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8db1ca507c6sm253606785a.26.2026.04.08.15.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 15:31:14 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH] nfc: hci: fix OOB heap read on short HCP frames.
Date: Wed,  8 Apr 2026 22:31:13 +0000
Message-Id: <20260408223113.2009304-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276729-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D55E3C4867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both nfc_hci_recv_from_llc() and nfc_hci_msg_rx_work() read byte 1 of
an sk_buff (the HCP message header field) without first verifying the
buffer contains at least NFC_HCI_HCP_HEADER_LEN (2) bytes.

The SHDLC LLC layer only filters zero-length frames; a single-byte
I-frame from a malicious NFC peer therefore reaches the HCI reassembly
path where packet->message.header is read one byte past the valid data.
The same issue is present in the NCI HCI implementation (nci/hci.c)
via nci_hci_data_received_cb() and nci_hci_msg_rx_work().

Add an explicit length check before accessing the message header at
all four locations, freeing the skb on malformed input.

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 net/nfc/hci/core.c | 9 +++++++++
 net/nfc/nci/hci.c  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 0d33c81a1..13d10b841 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -134,6 +134,10 @@ static void nfc_hci_msg_rx_work(struct work_struct *work)
 	u8 instruction;
 
 	while ((skb = skb_dequeue(&hdev->msg_rx_queue)) != NULL) {
+		if (skb->len < NFC_HCI_HCP_HEADER_LEN) {
+			kfree_skb(skb);
+			continue;
+		}
 		pipe = skb->data[0];
 		skb_pull(skb, NFC_HCI_HCP_PACKET_HEADER_LEN);
 		message = (struct hcp_message *)skb->data;
@@ -904,6 +908,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (hcp_skb->len < NFC_HCI_HCP_HEADER_LEN) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)hcp_skb->data;
 	type = HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NFC_HCI_HCP_RESPONSE) {
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 40ae8e5a7..2a6432878 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -412,6 +412,10 @@ static void nci_hci_msg_rx_work(struct work_struct *work)
 
 	for (; (skb = skb_dequeue(&hdev->msg_rx_queue)); kcov_remote_stop()) {
 		kcov_remote_start_common(skb_get_kcov_handle(skb));
+		if (skb->len < NCI_HCI_HCP_HEADER_LEN) {
+			kfree_skb(skb);
+			continue;
+		}
 		pipe = NCI_HCP_MSG_GET_PIPE(skb->data[0]);
 		skb_pull(skb, NCI_HCI_HCP_PACKET_HEADER_LEN);
 		message = (struct nci_hcp_message *)skb->data;
@@ -482,6 +486,11 @@ void nci_hci_data_received_cb(void *context,
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (hcp_skb->len < NCI_HCI_HCP_HEADER_LEN) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)hcp_skb->data;
 	type = NCI_HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NCI_HCI_HCP_RESPONSE) {
-- 
2.34.1


