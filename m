Return-Path: <netdev+bounces-277945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK+XOGNY3GnjPgkAu9opvQ
	(envelope-from <netdev+bounces-277945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:43:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4812C3E6CF5
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 04:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D12D0300B124
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCB922D785;
	Mon, 13 Apr 2026 02:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXlrxA2l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD11A682A
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776048225; cv=none; b=UrXcGvpHI5MgIEkz8xPHfwxGqDRjNyy7U0YK1UAzDpAj3GhLMSWdm/WuXfqEpNSTJUCvAknWd7GDftw2d5rD5hdErX5rMuWmajxKIK3VRWcS/bkc0avEzmSMZoKD8Olt+CPJPyKFcmmbq7WUwhcLk/Dl7uKc5PE70TV2XNYY2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776048225; c=relaxed/simple;
	bh=fPlzSFSfzETLLb5TQfBBEcxKEV71pXKM+WrPpneZZTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GgDBHbJi8WuyY7fC6nrapxOPf1k6HiyrxIq2GZTNqw9/2BfhSpdvBr+aL9Fc10Zl3n0yTRcU6nh9qHSRcfkt++r8Lm9S+197Cv2cAGxO02y0bVMbQeAdq+prwTI0w1r7Cr8fBBxOJgfdrgWvqBGLoq6mt2HeTCcPwMZQD+kLw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXlrxA2l; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8aca4e14411so10832846d6.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776048223; x=1776653023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN1ZThU+Pitkel3yIJoVzzx8LIHrm/czHWWd6RHRo6g=;
        b=lXlrxA2l7A3QN672hkuD8SQCt/xBqQ43TXsev2u9upu47IqnGvZXTS3WIR+ubwpfBp
         KqtMCso9zZCD/InsVJfeoBtXNr/02OJN09G7xZhJf3cnxdgSP5aFdxYEieeiP2rVc/9K
         FZZe0W6v7qirwA5H2A4eBBM3CqLugf+0PWqVoJrrcLYBgPD+22IgiKX64PF486zGE/JI
         KLlEVQwZCM0347mOWqP33ApeWGyEeKcpKQ3MxQEqrEvZi/1IWl/nJw5LjbtuBRpLvQI0
         lybWScWurePGK2x4G+g6naBy8p8sonCeZ1/gfoEc8CTqnyIKXByoWgd+gpZGXBAJTGxv
         8SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776048223; x=1776653023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NN1ZThU+Pitkel3yIJoVzzx8LIHrm/czHWWd6RHRo6g=;
        b=IAfLgZAKR0rIyajApzG7/qnSRTlCtGmX+cCVpM9OhiXBTCfTrcjPCDe9IERKPww4eS
         X0fSzk6fg0SlwJNq2bqRpLNznayXDRxagyczrw4f+SX+670d1OMsDyfDjaUJy3G0leSv
         lLO+CscQ+Cvh5uyMCvFybJd3/J4yHnTUQeeRAz6GxR6x3D2Qe/WoTFWUi+/IIZ9ejIuS
         wg0Y8uvhisHzf9iuVjF8OGIu76+muSqz8UX/A936uv1QORjsa/jey+WubvGLX4nh6ex2
         Y/xiWJWn2RcX9yY+PacklVPBRP4D45dv/PEcoPp43XtezYRhWFruemtZ3DYGlTUzCQt3
         o4/g==
X-Gm-Message-State: AOJu0YzpNEI4soq4LpsFrw9ihMLrL4lg0tNQHRWmsGMywPAoFc5XQWOQ
	9887c+sflNDu6Ts6b1C6Mnz0kagsyvSGRlCjO4IrlX3axAIsJlXrMi2zDwPsH/OOfFaZgg==
X-Gm-Gg: AeBDieugEX3AUOwOCuOI/QtTR/8knAbqpb3e7CWW/OhNfHdPmV1TwZn5ebEpsarFPaj
	21YIFNoqAMwRHLkqOWLADcar1njwG3dnZ+g1dO2ZPkkqpTf/ctkZDLBFTIOoz6lk3l5bxXbgwbZ
	T/ysRdReFOUlVT6pVvPFkwNos6MAqAawFcQu+F01Zwwvxh/k2/IC4xvHFSZ0DIccO4rzwL0MAWX
	1Rza9hLU6BQO37jt2Jfwm6+jWU3CdK0tR89PAdNuNROJxzyE5NQ3mvO52jtg4w2oFhOIYwZQv+G
	C8Z+/U1OOu4UvgymhyzpCsVF11dTjpjFTFqDJF08fNpasic7YQKoLmpWu5LHt/pOiNzh53qXNtZ
	5tw03ye4BoCFleXJdjqtaD5sHFpBesbHJPQIuwi9poyT38eJa48J3BzRutkSl5m52vMNRVNj79T
	awkN4EuHoEBp8QX+dqi2qhlhmIqXz4xQQaGwSIBJFmpHqQ1tvIHpZHfiFNu7FuurTeruTHSLB19
	6ppiYw40/wSFNN+AKbiD0kTzJgk
X-Received: by 2002:a0c:f40b:0:b0:8a6:17d7:286f with SMTP id 6a1803df08f44-8ac8613a142mr195661396d6.10.1776048222897;
        Sun, 12 Apr 2026 19:43:42 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8acb25f5a09sm7359646d6.17.2026.04.12.19.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 19:43:42 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v3] nfc: hci: fix out-of-bounds read in HCP header parsing
Date: Mon, 13 Apr 2026 02:43:29 +0000
Message-Id: <20260413024329.3293075-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413000627.3273477-1-ashutoshdesai993@gmail.com>
References: <20260413000627.3273477-1-ashutoshdesai993@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277945-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4812C3E6CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_hci_recv_from_llc() and nci_hci_data_received_cb() cast skb->data
to struct hcp_packet and read the message header byte without checking
that enough data is present in the linear sk_buff area. A malicious NFC
peer can send a 1-byte HCP frame that passes through the SHDLC layer
and reaches these functions, causing an out-of-bounds heap read.

Fix this by adding pskb_may_pull() before each cast to ensure the full
2-byte HCP header is pulled into the linear area before it is accessed.

Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
v3: drop redundant pskb_may_pull checks from msg_rx_work functions,
    remove incorrect Suggested-by tag
v2: switch skb->len check to pskb_may_pull

 net/nfc/hci/core.c | 5 +++++
 net/nfc/nci/hci.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 0d33c81a1..cd9cf6c94 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -904,6 +904,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
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
index 40ae8e5a7..6e633da25 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -482,6 +482,11 @@ void nci_hci_data_received_cb(void *context,
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


