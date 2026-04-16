Return-Path: <netdev+bounces-278923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIR0Kcpw4GlkgwAAu9opvQ
	(envelope-from <netdev+bounces-278923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2547740A4A1
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 295EF30D4C40
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 05:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612E33F369;
	Thu, 16 Apr 2026 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUKPg3s4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935833E35B
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316546; cv=none; b=fcbdxSynl7wid+dYjH6S1z7zyO6YNbwD1mlIYsrmgyTe4FNSRMYmvn471boBLRcUmJ3m6dQ/8izVbijbnUZs1patSkXruA0YEOgmltayUgaP2+m6sQbWFfCKFypbg6ApTi5mQW3Hwzs2j/9Dsy6rtRc/cfY0/GhtjgwJsCNWng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316546; c=relaxed/simple;
	bh=eLfXVXZgzEWyDhaVKa2jFIH9cYfs2PbpAApwiSrZmhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JlzJFL0qcsZ3r+1iZsQCepYq6sOA/i2MoVv/lNcqzYV4ft3K8ms4yGH2yz1skcyVQXlohseCQnSKUikQeT/yP3JfFCadONM0IIrGmzyYJH1Q43bLDm27+LU5Yjbhu/94eZtB/bjidUfKBnqFkZ+e37881neBRnWZdZYsrzymBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUKPg3s4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8dbbc6c16b2so42696385a.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 22:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776316543; x=1776921343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+z6WLGdATwt4kYxsahocIe5C/Hu+LLRPnaW7GZKwbKc=;
        b=aUKPg3s4THsVTqzeW9Y7zlvGEH+P8s5f2a/vu6UGV/3MHKwjCLGYTnoB+9eSac7373
         kqJ8NuzuMKGUpFqO1DvqRSS7Dd39Y3rbU3l8se/IYg9HWUvztxRvVv0+iN61VnhqM2Ob
         ZHR/2uv5ymP7RjH0Q8vWqx88he+AzYPyqv/ouYw92t+Gp36rnO+AqimvJtdI7VxuPzkr
         zsAfTPE2FzwMwMJ+J9xPqT/TqeDbbiE/zaN1WUDFxxWdSCGje58cwNZRPXWkbG7VWUjn
         gc9uiT1tgODXpkzMgNVh9lyqSWaFhaZqA/J1gwSuCxKhL5azGcAO87A2qJO/LsZanS8c
         OQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316543; x=1776921343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+z6WLGdATwt4kYxsahocIe5C/Hu+LLRPnaW7GZKwbKc=;
        b=kf017buEoFgRhCRjkxeoiqeAyPUojNYzYIGNCsy9JBqmQRl3OdIMhd3hqHPniSiyFk
         8Xp2+lwaLPauAMrP3g+IpEgpjeDPVvNv+AwR+WUMnWH12HUYFJE83kFoi1bR93gRYke5
         M9FOfuVGE0v8OUXsoV5WssBFCP/9pyyNt5Xud8zzOSs8AII15jO0Hug/W+9x2N9U8V51
         yi6xoS3/6xZLYQknBJMbkj0DvQWy427JZuTB/Fju50/P15e9q+julPv45lbh/oydm22P
         hnhPj3xrli48vPQqDlmkhnSTnOocMLn0ujJIDEjGaCFmjf5u5cyjf6i/0owZlUStad8C
         nYNw==
X-Gm-Message-State: AOJu0YzXJCGsaykyyhY/ohtZrzKG3midKlNcEUEHWtBbrxih1hCYKrKe
	wI5ki9MKjI7gb1cJnm/pxo/X5vzc4A4PfRBm1sk2s1l/N2qKX3IxQpfHqS4KGBYKtQCPKw==
X-Gm-Gg: AeBDietaM/pYjuHQ1g0fT7RFrNXSwYJTh3RHOuyYwq0H073LEvvMTbqLQVQt4Jk5SSz
	sOynyIZww2b55F6WFRnx2UIjKNais26mwTi2RPwCj1rFLUATKbwmrerYkwsKAYNqNWFsn37caOr
	02hfNFbBO1tVucf6WH//Zi0dpifkpp+bIwQ8433dJcMUU9ffv5QGti2TqKlE9edt+oe7E9ey6a+
	P5LwyDzYYivU9iHACPzBd2RQ1AMVPm2v+5y2DieKcs7rxtO7kwJVVYbLN41VRStSfyq1ueNQ9Dl
	73I5VOpFe5v2gm/Kyr5uakyo3OklldKHVuNQB1AjCnulKmoe3tC8IjXn5N4qTmhZTgxah1lb7ut
	yZxIjDUoj+qXAIqGfUgpCjQhFiDrqj9HJKzWX6XGDzb+lSPak5n9JhDbvwcvT9rFNrmZvsHhdTU
	GfbdtCvNiJ4Rlu5yXgHUY/bPKk+PdzXoPvVU+o7nxlj6MhK36lCO+FlB6FNX5ezOcB00ZkI2zze
	KPpIVtv0AAgkga+kjZqVQ2RVKtXmtia6apif772Dns87AvvXw==
X-Received: by 2002:a05:620a:4690:b0:8cd:aa61:ad8f with SMTP id af79cd13be357-8e689330904mr24288685a.14.1776316543080;
        Wed, 15 Apr 2026 22:15:43 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f2926001sm278457985a.34.2026.04.15.22.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:15:42 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v5 net] nfc: hci: fix out-of-bounds read in HCP header parsing
Date: Thu, 16 Apr 2026 05:15:22 +0000
Message-Id: <20260416051522.4154698-1-ashutoshdesai993@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-278923-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2547740A4A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfc_hci_recv_from_llc() and nci_hci_data_received_cb() cast skb->data
to struct hcp_packet and read the message header byte without checking
that enough data is present in the linear sk_buff area. A malicious NFC
peer can send a 1-byte HCP frame that passes through the SHDLC layer
and reaches these functions, causing an out-of-bounds heap read.

Fix this by adding pskb_may_pull() before each cast to ensure the full
2-byte HCP header is pulled into the linear area before it is accessed.

Fixes: 8b8d2e08bf0d ("NFC: HCI support")
Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V4 -> V5: fix whitespace damage
V3 -> V4: add Fixes tags
V2 -> V3: drop redundant checks from nfc_hci_msg_rx_work/nci_hci_msg_rx_work;
          remove incorrect Suggested-by tag
V1 -> V2: use pskb_may_pull() instead of skb->len check

v4: https://lore.kernel.org/netdev/177614425081.3600288.2536320552978506086@gmail.com/
v3: https://lore.kernel.org/netdev/20260413024329.3293075-1-ashutoshdesai993@gmail.com/
v2: https://lore.kernel.org/netdev/20260409150825.2217133-1-ashutoshdesai993@gmail.com/
v1: https://lore.kernel.org/netdev/20260408223113.2009304-1-ashutoshdesai993@gmail.com/

 net/nfc/hci/core.c | 5 +++++
 net/nfc/nci/hci.c  | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 0d33c81a15fe..cd9cf6c94a50 100644
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
index 40ae8e5a7ec7..6e633da257d1 100644
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


