Return-Path: <netdev+bounces-277041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMF2JvzA12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:08:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025A3CC6C0
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E9C5300955E
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A523C3C0E;
	Thu,  9 Apr 2026 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+dHj5FT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F13DD52A
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747310; cv=none; b=C+4ya/yyOP+hu/L/YOYvlQFgshgm/hb603jynNYOXO/QqMFD2pxcNc1IVRBndXFTAhyGyuzrZfPpKIoOWvZrE/hkO/9EjvOyvVVh/PFZ97GOalzrdbs/RiuImLiRpeGFUc2qG74bmiZp4dqQphxlP1VS+OBowHTX1RfXlfK19pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747310; c=relaxed/simple;
	bh=tsWV9xKNk8ZRfQF0qdjf8bnZvwJ4yjJqcyzT5DpB9KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=he4RA8VYI4DRP1QFcNADAYVRMO+lUidshdT5usAOT1CEiiB1x4c4Wn8yYbZ/TY+YCFVVKGZ3m8nILeZAmeLPsu/RfuCpBazkk33eJC8QwFlgCYyE6gpol3fYKJ90UfM8Mk8deBg1Rvoyi0yMLJnteFOCQX+hQv2Y0m768u98Uvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+dHj5FT; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65009bfdcfdso1121825d50.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775747308; x=1776352108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zmbdYu+fcv9A3MvczPkc6WO3ccIW1T8auH+a7GvTMc=;
        b=H+dHj5FTl48dyFoew8YjzvftvoX11yYQ6COMIaw9Ty/8SUnZ6PFN9D12dnkqNICO/r
         04IKT7XqsyJhzEvY3VZcktHvYIL1IRwWNN9MpBNptCq43sWJrpgM3rbwo27EutOsaLZf
         50DqpSqH+nYJBLv23ZcY/3qHv2n7tzvI4Hjam7HfolJiJs8svUc+wiUNWNy6DC1yFV+5
         PspPIB8D7zIBUHD0GKg8KnxDtaWYHrMYBBhkDBB5DNHqaH1UdwEc8nQwvApKeFsHJeSR
         b5AOdtzIXoCIiqPkzPtc7WtChexzc6kkqYKPgTeJS6L9nJGSwDnXdD0QbuQAsqh2HSKU
         GrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747308; x=1776352108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0zmbdYu+fcv9A3MvczPkc6WO3ccIW1T8auH+a7GvTMc=;
        b=dXNEXEcUcfXzprvantj73PD3IcwleJdwG8ab/5bfkNs5QQkHPpOgxGVXfbOLz3wY2S
         Smkbqzg41Deg3IRtrdJ8NOtgDuhGynQrPiY79Xu9ntL2BqShOG7iRM5ZqIL5AHStaXu+
         xMs9KOcvpTfrXFTZ+MTfdO6/Rv4AyCNknB3Eqbz3e3IKHffCZR61FobDyqIdOngwtuXp
         R2DFqBlircMHCfn8bD64/NX4X76OW+Pu39TH0Bom2fm3tGFea89da2cvqjtvAmzZ8Rq+
         ltBYAt5C6iugjrSY+Dr6ShXsfOF4ZhI+3gEbMcxICinawhEQ0/c35D8zU0hjnM3SLJhp
         HxsA==
X-Gm-Message-State: AOJu0YyBatoDYLyduvNmuKspjRUW8gOSYgr2yif2jVlHzvtCW9ZrBcFn
	4OfEYx+uk4TgTy6FHi2mb2BRr2dbqEvCg6740RLoLb/eYxUBaMbK4z/tspZiqft7d9iIWw==
X-Gm-Gg: AeBDiev5hCYcbIZ9+X5YbrEdjv9JCP2URul9yMJ1mXcGISBfwMQUET54Ld5cHl0TtUf
	dLyQr3gUqN0X2fW0Am6XttI2amCjpedf6xgOEt0N4fBM8/te0LlWG59nIb0lOCztsVEToPHAHUx
	jc4OUeD/bUqkCnXSwb716YcZMYuEACE/+IzHr0XRvIkRDfV4ppwrBdVJx+UI0O77zF0BLHflCog
	86PtbY/Ie+htcjIkgjT9vcSHHIwsbGgtDPJOSPwOiWjffH29S3LdR8oiK4nkH+n1KB05hObZ6ja
	5xN5ZbWGaMu4jlOUvtfb8S3r33+zz7HDk0DCu0jokAo7n23y/u3q+sMR7uwslJGsbnRmj0uXYlB
	t+wH26et+fNZlqBc0PmFHTSTzXdxjmiag3DmGYk3bJbB0BhA9nFPyhaFLFlK140fjyfvz/tJJAB
	YEeS9sHlp/tOmzGixcyzvkTDlg7bNKgDU6JRS/a0ALmoHglFHHYwHb5Yc+psu3a+dihhckOvsWK
	RKs58mnnJLwqzg/6sylqRl/C1RS
X-Received: by 2002:a05:690e:4841:b0:650:15ad:33cf with SMTP id 956f58d0204a3-6504883dc62mr17719652d50.50.1775747307656;
        Thu, 09 Apr 2026 08:08:27 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm11157265d50.3.2026.04.09.08.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:08:27 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] nfc: hci: fix OOB heap read on short HCP frames
Date: Thu,  9 Apr 2026 15:08:25 +0000
Message-Id: <20260409150825.2217133-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iKq=oQOmvDtK-Vtr7r9yrD29cURgv8VOJ15mFHyJ0kXmw@mail.gmail.com>
References: <CANn89iKq=oQOmvDtK-Vtr7r9yrD29cURgv8VOJ15mFHyJ0kXmw@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277041-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4025A3CC6C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both nfc_hci_recv_from_llc() and nfc_hci_msg_rx_work() cast skb->data
to struct hcp_packet and read the message header byte without verifying
the data is present in the linear sk_buff area. The same issue exists in
the NCI HCI path via nci_hci_data_received_cb() and nci_hci_msg_rx_work().

The initial fix checked skb->len, but that counts bytes in non-linear
fragments too. skb->data only covers the linear head, so a fragmented
skb with len >= 2 but the payload in a fragment would still result in
an out-of-bounds read. Eric Dumazet pointed this out.

Switch to pskb_may_pull() which validates that the requested bytes are
available and pulls fragment data into the linear area if needed, which
is the correct approach here.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 net/nfc/hci/core.c | 9 +++++++++
 net/nfc/nci/hci.c  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 0d33c81a1..b8fe59f44 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -134,6 +134,10 @@ static void nfc_hci_msg_rx_work(struct work_struct *work)
 	u8 instruction;
 
 	while ((skb = skb_dequeue(&hdev->msg_rx_queue)) != NULL) {
+		if (!pskb_may_pull(skb, NFC_HCI_HCP_HEADER_LEN)) {
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
+	if (!pskb_may_pull(hcp_skb, NFC_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)hcp_skb->data;
 	type = HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NFC_HCI_HCP_RESPONSE) {
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 40ae8e5a7..4243ca9b1 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -412,6 +412,10 @@ static void nci_hci_msg_rx_work(struct work_struct *work)
 
 	for (; (skb = skb_dequeue(&hdev->msg_rx_queue)); kcov_remote_stop()) {
 		kcov_remote_start_common(skb_get_kcov_handle(skb));
+		if (!pskb_may_pull(skb, NCI_HCI_HCP_HEADER_LEN)) {
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
+	if (!pskb_may_pull(hcp_skb, NCI_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)hcp_skb->data;
 	type = NCI_HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NCI_HCI_HCP_RESPONSE) {
-- 
2.34.1


