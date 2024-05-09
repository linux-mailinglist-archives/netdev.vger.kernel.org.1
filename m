Return-Path: <netdev+bounces-94880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AA38C0ED7
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC0283293
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D341311AC;
	Thu,  9 May 2024 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i99lmOdj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223F131192
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254280; cv=none; b=o6sLJqKwXOHMp9S4arCOloaaN4EjPk0KDqEZXDeELcEHtzOu9wQxeAX+Yp19JO7/Y6nTI1lPAon0dttvKpe9wPmVSJ/MpVvTSqTyTHxtgEKkEJdJ0QDCvW4yfQ8aXO2jjWwPc57YtoHU1XYDkdI8MZ0CNozneXI5EFgI2K+AlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254280; c=relaxed/simple;
	bh=KbSJqTXIym8X1LZZSbDqHy2oc5PTnuYaFn9rlqkiybc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0xeDQ622c1nVXH+ckxaOut2Jfrm1ilzWBlQxz8oI1F571LWijL8GweEUgWpujnvjsitEbnkBA357BYCu0UCPGyYlTqwLGRxKAkrpK1oWKbJO6BP7sZBsvBcILi1VKXe0T4MA9doQ+stu87pEcRK2ISKktXsKoi+qoiwU/8yXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i99lmOdj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715254278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kZ1oYNvf/jlHzYagQ7dAZFEVJALyTuqemntwu0w6jKw=;
	b=i99lmOdjJt6OZpMXl+4iv18Pf9vJ671+RVgOwXt3a3m143Lf0ABqRYkxbRWM0dAUuLcjou
	fY882dj8rD9BORJXNLHkYB82b8UxZL3ZXuWz56HwdmPQF0rrl9bgBxKMOuKDhu1b4+rAMy
	fIsQkUr/hmsGidkH14Ni5JCHbifrD5Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-NtgFnCvUNzaltDQOkpbEfA-1; Thu, 09 May 2024 07:31:16 -0400
X-MC-Unique: NtgFnCvUNzaltDQOkpbEfA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6efef492e79so861421b3a.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715254274; x=1715859074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZ1oYNvf/jlHzYagQ7dAZFEVJALyTuqemntwu0w6jKw=;
        b=it/E5wET3iExINMpUSXnyCNJOA+qiYAj4QMRAR+Ca+RpOoVckg2CGUY6W62htVlhU2
         i0y1a2Xipr/wh7AuANrEypYx8wiVNpdYoGWETjB1x2elYdd0SoZoeFA2Y+3AAN8z237/
         YHNIv7F71ISYR2v3wHP+2n71cHBBO+J/uXkKDNuN2kXC/AQVQKgCyQBqE8DP4xWdI9Wv
         3g9NpxM8UeoNXCfmNLVtWxi/kY4/jenQFufYJJ/hWlShjscAQAon6N049jMzM7Hgkim3
         sMajCLfhU3PxUO7wBOnO4CB6jBOoRg8x5BCIAhlIpb0mEAcwG5xNe8lNxIoaKI7WL+TQ
         xPMw==
X-Forwarded-Encrypted: i=1; AJvYcCXEELV8U+S9xM1NRk25hZIOTPzoMEOcdwCiy+xQAJYJ9cPtZozi8qpifwyDOBICOmAEPJJD0lAS4DLGK0v+47zWmHiA+upl
X-Gm-Message-State: AOJu0Ywh/aIms2dt+mPuhtqzcUS9pTkcjGOmEv3IypobMDkDagZGVNuG
	8z/mc1Mf5c08pJ9j25W/PZcN9wWdjkOw/8y//PssE6Hyy1JvsKbBSqo7Fzm0dhn6jwhLI+SqLYM
	JaJR1oO0u7BvdvEeyCrPbAQtcRzxyI4KNAu0Hzd9o1k3Id7s+dj4Fx8HbGBjtG5Z6
X-Received: by 2002:a05:6a20:9494:b0:1af:c0f9:b155 with SMTP id adf61e73a8af0-1afc8d8eb58mr5402212637.38.1715254274439;
        Thu, 09 May 2024 04:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEznRBomI8zqavjnHRv+qhrEvXhhgPA38IG4MHjby0WMFKowdUH6+SUrWT3PbTYHv67iCKEGw==
X-Received: by 2002:a05:6a20:9494:b0:1af:c0f9:b155 with SMTP id adf61e73a8af0-1afc8d8eb58mr5402187637.38.1715254274006;
        Thu, 09 May 2024 04:31:14 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2567ccsm12023495ad.301.2024.05.09.04.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:31:13 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: [PATCH net v4] nfc: nci: Fix uninit-value in nci_rx_work
Date: Thu,  9 May 2024 20:30:33 +0900
Message-ID: <20240509113036.362290-1-ryasuoka@redhat.com>
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
v4
- v3 patch uses goto statement and it makes codes complicated. So this
  patch simply calls kfree_skb inside loop and remove goto statement.
- [2] inserted kcov_remote_stop() to fix kcov check. However, as we
  discuss about my v3 patch [3], it should not exit the for statement
  and should continue processing subsequent packets. This patch removes
  them and simply insert continue statement.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=19e35f24750d

v3
https://lore.kernel.org/netdev/20240502082323.250739-1-ryasuoka@redhat.com/T/
- As Simon pointed out, the valid packets will reach invalid_pkt_free
and kfree_skb(skb) after being handled correctly in switch statement.
It can lead to double free issues, which is not intended. So this patch
uses "continue" instead of "break" in switch statement.

- In the current implementation, once zero payload size is detected, the
for statement exits. It should continue processing subsequent packets. 
So this patch just frees skb in invalid_pkt_free when the invalid 
packets are detected. [3]

v2
https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/

- The v1 patch only checked whether skb->len is zero. This patch also
  checks header size, payload size and total packet size.


v1
https://lore.kernel.org/linux-kernel/CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com/T/

 net/nfc/nci/core.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..0aaff30cb68f 100644
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
@@ -1516,24 +1526,32 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!skb->len) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
 		switch (nci_mt(skb->data)) {
 		case NCI_MT_RSP_PKT:
-			nci_rsp_packet(ndev, skb);
+			if (nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				nci_rsp_packet(ndev, skb);
+			else
+				kfree_skb(skb);
 			break;
 
 		case NCI_MT_NTF_PKT:
-			nci_ntf_packet(ndev, skb);
+			if (nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				nci_ntf_packet(ndev, skb);
+			else
+				kfree_skb(skb);
 			break;
 
 		case NCI_MT_DATA_PKT:
-			nci_rx_data_packet(ndev, skb);
+			if (nci_valid_size(skb, NCI_DATA_HDR_SIZE))
+				nci_rx_data_packet(ndev, skb);
+			else
+				kfree_skb(skb);
 			break;
 
 		default:
-- 
2.44.0


