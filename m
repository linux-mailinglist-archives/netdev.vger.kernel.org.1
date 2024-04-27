Return-Path: <netdev+bounces-91891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6AD8B458F
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 12:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D6B21BF9
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 10:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A54482E9;
	Sat, 27 Apr 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvvLsVkX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B5171B0
	for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714214195; cv=none; b=Oos6KGhLmoSDxNBv1iT8xTC3srf4229GYmI9KUSDnJSKZ9Br19Lu1plrCaXSJddtUb+JLvrCt4P2zTCYrNKbIENGeeJPQaimcnGEaVYJSri8xU5qadNK5OseEoxHlBoi+Hpcxvuagp+opg4+XeUsGHHEv8vubE1kUFN/jWnpPug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714214195; c=relaxed/simple;
	bh=oAPdOSh/rjxGtOL6G8o5F47TBLVel6VTqGGDaQAG060=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wkccbl1U75AKcVnlcpMJ709nWP9uSs9AhgJgvfSLSYA+E0GtV6MU9A8hclX1Egzf97fRLOmZlB8c50j3aN1NgP0xS7fElKewd6lbJPqoMAi40q5eZz6JKL5O2vboW1BsHuTlIkTxs2rNnAGCv9sXKR51aR5xNApoTa5yJCmxCAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvvLsVkX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714214189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AyJe8k+NKSRTclt6v7W5z/MPBrviSINpP3m1bDdfQMM=;
	b=CvvLsVkXXYgwP1HCGtWYB6BLkLcTh5FOWT95mdxExTwAGWdJpd8eyDx5oD7L4o84tVnEKN
	THPQppxyuDDNut3MYgrVvFCdfDYpJfXpimzIzaM9a7j190M5G10lL/ld98+3iURgqZ4mN7
	YQ9zejvQuUTuLhqgDjh+SAiiv+oGhUc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-49PQn5exOMm_luAw3cuBJQ-1; Sat, 27 Apr 2024 06:36:27 -0400
X-MC-Unique: 49PQn5exOMm_luAw3cuBJQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a537ab9d7eso3028804a91.1
        for <netdev@vger.kernel.org>; Sat, 27 Apr 2024 03:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714214186; x=1714818986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyJe8k+NKSRTclt6v7W5z/MPBrviSINpP3m1bDdfQMM=;
        b=QEQkwDi3/dzAdRvdkc+gM6hBJQdvXa7JubEovezNZgy26BbTXeFbCf8Xxf8s27FNgl
         gqnyu9lxUr8LbRXOGe0Nvmjjw32W1OjpE6XPQ8Djrm+jxdIhpfK3a+tvhmJm1Tfy3H+F
         /pbIX4DX2y4zYsZq8AIn/AV5Sum9Rn9WSrIaeCq9h/N671T699grsa+ZLlMR7m16Ep9a
         rXfpuG0Zphbwe9zhvTUjG9D69lXHqtH969DMy2TjRuJ+ojykrHjyVllhj6DjOccFzr7J
         Ot295RccZk5GPO6kALlH0JAgXadJhFjjse4+wCFQsvkbg0f6ccTPZU3cobS2LSqZerI7
         FdNA==
X-Forwarded-Encrypted: i=1; AJvYcCWzLEjDdytb5uYPXQv2Bj4rSDtj01hLixcecWVU02T+XbFem3IA+QFxHSgmah/0eRcV53HjD0wHgEa9Gghu7ewkdWof8PlW
X-Gm-Message-State: AOJu0YxWRC2sKQR/9zNbhUd9LHK7HSFAhqsNMCb8AC3y97nthJCI4NC5
	A1kk5N/EY3vkOjVYx6hzfhPy4/Eq7cUElGG3M/c4intfiApPyfZ1dU9sGVHO1ndv+ZsZFxHxg4L
	MyvUpCLChjTPzY3qRjV0ZSY4qnJgoUpPdkkmvlQTvjJi0zehfhx6bWw==
X-Received: by 2002:a17:902:bc85:b0:1e2:6d57:c1bb with SMTP id bb5-20020a170902bc8500b001e26d57c1bbmr4547978plb.21.1714214186362;
        Sat, 27 Apr 2024 03:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPhm2AjNWsFzTcfueWhdIMlYbfKnl7zRR2EMxPFfPsRJVtSdfGB+SUmrzXYVW1aA3Ve7C77A==
X-Received: by 2002:a17:902:bc85:b0:1e2:6d57:c1bb with SMTP id bb5-20020a170902bc8500b001e26d57c1bbmr4547962plb.21.1714214185940;
        Sat, 27 Apr 2024 03:36:25 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902768500b001e4478e9b21sm16838908pll.244.2024.04.27.03.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:36:25 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: [PATCH net v2] nfc: nci: Fix uninit-value in nci_rx_work
Date: Sat, 27 Apr 2024 19:35:54 +0900
Message-ID: <20240427103558.161706-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported the following uninit-value access issue [1]

nci_rx_work() parses received packet from ndev->rx_q. It should be
validated header size, payload size and total packet size before
processing the packet. If an invalid packet is detected, it should be
silently discarded.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
v2
- The v1 patch only checked whether skb->len is zero. This patch also
  checks header size, payload size and total packet size.

v1
https://lore.kernel.org/linux-kernel/CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com/T/


 net/nfc/nci/core.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..ab07b5f69664 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1463,6 +1463,16 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb, unsigned int header_size)
+{
+	if (skb->len < header_size ||
+	    !nci_plen(skb->data) ||
+	    skb->len < header_size + nci_plen(skb->data)) {
+		return false;
+	}
+	return true;
+}
+
 /* ---- NCI TX Data worker thread ---- */
 
 static void nci_tx_work(struct work_struct *work)
@@ -1516,30 +1526,36 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
-			kfree_skb(skb);
-			break;
-		}
+		if (!skb->len)
+			goto invalid_pkt_free;
 
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_rsp_packet(ndev, skb);
 			break;
 
 		case NCI_MT_NTF_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_ntf_packet(ndev, skb);
 			break;
 
 		case NCI_MT_DATA_PKT:
+			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_rx_data_packet(ndev, skb);
 			break;
 
 		default:
 			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
-			kfree_skb(skb);
-			break;
+			goto invalid_pkt_free;
 		}
+invalid_pkt_free:
+		kfree_skb(skb);
+		break;
 	}
 
 	/* check if a data exchange timeout has occurred */
-- 
2.44.0


