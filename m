Return-Path: <netdev+bounces-92940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B68B9668
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708E61F2130A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7B364D2;
	Thu,  2 May 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLxyJg+3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB0171AA
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638238; cv=none; b=lxXn3kSSZQjBKa/NJ2NxKAkZRKQqlxdbL34toddugRyioka2/XaFed0r7oQj+YxV8JCOImc7ICTcpUfuncecE6jZKljsmQ30sPyvvq7rW9ohWGA5W88ITRpGsZm7c4bU9dUGKqkDxlvaFFhosurb7RV6SAqpxGk1BOPql4sc2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638238; c=relaxed/simple;
	bh=zWIpRnRxEy9l3LsNyh3F/3Wo3GYUb9ZiflzKXUfyORg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtLtrEZw/EEO6IiO68WPF2da2fYJorKG4V9bC4yLCyIEVl9/K0s034BEiMNbBGkQ5b40wFXT2p7E3zLAE8Nb1X86L1bEAtTphxqztdbHiTawYPyDlXhyi0vY4E/aBbtHvmnZ2agpwzgl4ewW1jsl3TPX4B3N7SvMEq9sfxtqKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLxyJg+3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714638236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X7dwuOjw1abAFiF1m2v6AVjHJ1TjRsupxojkzVCFJds=;
	b=HLxyJg+3dP5eoYXUZFfMis/nt8vlCPzqgu97T7dhKq+yz+njbPvvRZMqzOj2oRZTdSLHkU
	NTTz4Nem4Pa1EM9+NPPU+cudHk665GJUzgS7jLcVfTrJWESPGVUnNn4xvcWqiw/SXz7N8h
	azQlMwxnWfDX00d29lQmvMuIgg1JoZw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-6l9JikH8N525W-mV0XvVcw-1; Thu, 02 May 2024 04:23:54 -0400
X-MC-Unique: 6l9JikH8N525W-mV0XvVcw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ed25ed4a5fso8785348b3a.1
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 01:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714638233; x=1715243033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7dwuOjw1abAFiF1m2v6AVjHJ1TjRsupxojkzVCFJds=;
        b=AZxLquqQPQUWa59r/BR9zUdOVkKDncavvenNId84fA3v4LQtWGSG4ATf8rDTCAx3z/
         3+niTO3lscCGRWbuhIjT7e3ZQOMfYibNVWX+BCQ5TlVGPjFTSC08GIX8TROK0Oelp+eg
         tXnWDks3E0L14bxC44Aje/ojpv9x3JFmZjayFw5ouC1isw8+mozA9DDfhM5AuMyNyCdH
         Pf9Nm4U7rGffrkrs9hYb7UrKs2Y5lzRNlVYVUK6FxRfpVWHrTxMyk4IkJTVHfWGGMiL8
         ybCqU+NliruryR+hKoJKpVeJd7VU9o6c+Gjucczhpnj+W87tUJ3Z8o4tVnGCAB0HxtvW
         +bPg==
X-Forwarded-Encrypted: i=1; AJvYcCWzJuR/W+xZISP2azUaIuc9P4IPz+HjdIryZRuKBZ82uiFl7oDP/Fge1t9wJ8YCKVdrdU8OSOX3pHzp0nn4KvI9s+c+l34G
X-Gm-Message-State: AOJu0YwzlLmnicKopKYHXjc7iEc83RcpvDcqKwV2y/Zkhf/Gmp0FtXVm
	Kn3VIqXErHLC33tTu525pGndJNE+KEcmxxz26EJfCnZgBnV4+W5vg6oEB59IG2l6GCKz0pD8Jeb
	tHE9itYGueFM1r55HG224MghF5kYja4MkFZpf79ZZA4AdwyQj5hJvgQ==
X-Received: by 2002:a05:6a20:f39a:b0:1aa:927d:75f1 with SMTP id qr26-20020a056a20f39a00b001aa927d75f1mr4763685pzb.10.1714638233681;
        Thu, 02 May 2024 01:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr+Y5EURRxol+AnlNW0Nbu2NhQmMcabDe55lXJsfh4Z2ooxH1uEgrJlL9EaAXW8kf5yGTvUA==
X-Received: by 2002:a05:6a20:f39a:b0:1aa:927d:75f1 with SMTP id qr26-20020a056a20f39a00b001aa927d75f1mr4763612pzb.10.1714638231312;
        Thu, 02 May 2024 01:23:51 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d3-20020a056a0010c300b006ecfd0bf326sm686984pfu.99.2024.05.02.01.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 01:23:50 -0700 (PDT)
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
Subject: [PATCH net v3] nfc: nci: Fix uninit-value in nci_rx_work
Date: Thu,  2 May 2024 17:22:40 +0900
Message-ID: <20240502082323.250739-1-ryasuoka@redhat.com>
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

v3
- As Simon pointed out, the valid packets will reach invalid_pkt_free
and kfree_skb(skb) after being handled correctly in switch statement.
It can lead to double free issues, which is not intended. So this patch
uses "continue" instead of "break" in switch statement.

- In the current implementation, once zero payload size is detected, the
for statement exits. It should continue processing subsequent packets. 
So this patch just frees skb in invalid_pkt_free when the invalid 
packets are detected.

v2
https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/

- The v1 patch only checked whether skb->len is zero. This patch also
  checks header size, payload size and total packet size.


v1
https://lore.kernel.org/linux-kernel/CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com/T/


 net/nfc/nci/core.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..e4f92a090022 100644
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
@@ -1516,30 +1526,35 @@ static void nci_rx_work(struct work_struct *work)
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
-			break;
+			continue;
 
 		case NCI_MT_NTF_PKT:
+			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_ntf_packet(ndev, skb);
-			break;
+			continue;
 
 		case NCI_MT_DATA_PKT:
+			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
+				goto invalid_pkt_free;
 			nci_rx_data_packet(ndev, skb);
-			break;
+			continue;
 
 		default:
 			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
-			kfree_skb(skb);
-			break;
+			goto invalid_pkt_free;
 		}
+invalid_pkt_free:
+		kfree_skb(skb);
 	}
 
 	/* check if a data exchange timeout has occurred */
-- 
2.44.0


