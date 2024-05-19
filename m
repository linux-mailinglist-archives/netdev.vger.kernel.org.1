Return-Path: <netdev+bounces-97126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2B8C943C
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46BB1B20DCE
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA892E84A;
	Sun, 19 May 2024 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULehZoeb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371BBE40
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716111818; cv=none; b=USaK0ros5I+VDpA1BXc4jKl+Z+Vk90gggPNZvqrfE8NqpQZCkEVUFQzG4uw2L3kVLwvg9ZnvIaJEkeQshL0fAP7twyvJGFRGYMDYsuspCvx/2pKJHIdTnEgShAbHLyR7WcpiRDbDI8iJRAa1EBvhAXdNe655QpssSUz0Gye5ONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716111818; c=relaxed/simple;
	bh=XVYZJf19fhwCKob2ZPTjv3MkpTN7Dd7FH6bhQyS3Dzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HaLLguj5IttgUifn++xGyI33VAvyWe59dOX0vfIjQ1+ipUgYmER2Mi6XOA3/fJP+uXenI37H1yi+hs98pmdYugGduIPYhkcxvPBJbNKXUZXCThKVb60i43LTRrAwWS1JuypBVBDroPw7wMHAZ1jo9nGDAjXdEQsFEP86Lble4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULehZoeb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716111814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l+hPEPEJikrCYY8v7MJr/p3bxjRpLE6cykpaByeIXXA=;
	b=ULehZoeb6wbVFSj7snOVy69RNakb0ptHUmvGq6uke1dTS+YvztIuFPJRC97cYG7xon+K+R
	T9ehMMFn5wVUPqY8wysC7skaMwA+pvetrKXh4Bd7/JOO80dLwSeVhSn/Ib2zcgh7h0rqfm
	nlM9S8DFf4k1otgEzKj56n+/8UlzqoE=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-05bbU_F6OK-dcwyWMMzqbQ-1; Sun, 19 May 2024 05:43:33 -0400
X-MC-Unique: 05bbU_F6OK-dcwyWMMzqbQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5b2769e8382so11795392eaf.2
        for <netdev@vger.kernel.org>; Sun, 19 May 2024 02:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716111812; x=1716716612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+hPEPEJikrCYY8v7MJr/p3bxjRpLE6cykpaByeIXXA=;
        b=ModHnp5bBy41GYdxO1fdr5LC2O6JyEBpHsEKkRhr9QDFi9w10ER83ITm4/Zrh4BYO9
         zJFM0qeHKJl4x/yOsCOHf74TrIh1CcfD0I7/7EAwxxDnl/Wi7LizgjcNuwv6lfMjRCmB
         WTyTaZAAVBHTfqaA6dVJaHeY1ydZ2D1qlqsdui0uYvNB276e/PHyHAjM5zLiUTocNVYV
         aKE4R7PilY5PAZqfb09JDGNm5BgCzphhNhU6FnC8Fv3pW1eQJqZG4OsDGdp3biRRzEQB
         r0EkJRg86PeV+eEImV4if0tWBD5YmAYLbEc0Ck6A9lb4HK0kFnW31kXLf5/JG6GL68qT
         riUA==
X-Forwarded-Encrypted: i=1; AJvYcCV3x5fFb2yb/gcHNBaTPKt4xGwWOBvVcWXa8srrkza35xTYKh/fW/DLbBTz7LumjeCpy6rXFP/Nz+89gGY1y/ltzvcr3cPI
X-Gm-Message-State: AOJu0Yy7cpTiFRcA7mtKu1pVf734j+VXKt90p+8bcr2UQQ2uUI9179tK
	5LEnj+CdO7eP58oHHQeixa1BDvd35Irzj6cplT/N9z/CvnJuS8A4s9agv9NPrn/0HTL/uTJ/f5k
	iH+vo93uGMP6elI8CGSfE9Xqt8+BplUD0th+k2pW4giPyFX6xnAq5SQ==
X-Received: by 2002:a05:6871:2117:b0:229:7d01:7e03 with SMTP id 586e51a60fabf-24172e1266amr33035208fac.43.1716111812084;
        Sun, 19 May 2024 02:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt1tMp7gyyVrNXvf2t4LAiDyJ1ABapt5/NoN/KBr74FpK9ackGjMs+w1p3k55TmmXjwAInhw==
X-Received: by 2002:a05:6871:2117:b0:229:7d01:7e03 with SMTP id 586e51a60fabf-24172e1266amr33035189fac.43.1716111811484;
        Sun, 19 May 2024 02:43:31 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2d767sm17355304b3a.186.2024.05.19.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 02:43:30 -0700 (PDT)
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
Subject: [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
Date: Sun, 19 May 2024 18:43:03 +0900
Message-ID: <20240519094304.518279-1-ryasuoka@redhat.com>
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
v5
- As Jakub pointed out, add BUILD_BUG_ON() and make the patch simpler.
  All validating packet size has been done in nci_valid_size() before
  switch statement.
- Also, v4 patch changed break to continue when the invalid packet is
  detected. Since it is unrelated to this patch, leave it in this patch.
  This fix was proposed in another patch.

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


 net/nfc/nci/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..7a9897fbf4f4 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1463,6 +1463,19 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
+	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
+
+	if (skb->len < hdr_size ||
+	    !nci_plen(skb->data) ||
+	    skb->len < hdr_size + nci_plen(skb->data)) {
+		return false;
+	}
+	return true;
+}
+
 /* ---- NCI TX Data worker thread ---- */
 
 static void nci_tx_work(struct work_struct *work)
@@ -1516,7 +1529,7 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
 			kcov_remote_stop();
 			break;
-- 
2.44.0


