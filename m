Return-Path: <netdev+bounces-222634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4625B55274
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B77B6129C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749C30AAC1;
	Fri, 12 Sep 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIzKm/Ol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD83115B8
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688982; cv=none; b=A0Wm9NJq9uERnwGBCDLr1RmFJ2/cIx/T2Bh8IArKG0LoBjReQ2r5p69oD3BHo9oU4065b6nSgKXrwHm332+FJbIIB3Rfm+MA7lryhpyygNn8BABCaSB9DVvPd/vjIOtHo3uMquFgGTSUbZF+SiuLXPH9A/e6mDe/uoWtBOM8ooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688982; c=relaxed/simple;
	bh=5bychSERzZRu0Ga8fDtteTf82tNnxalxzUdhbU5SWh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pp6HL5bafxBNClSeuxQiefmUE6IdF5qNNJE4Zjgfw/MXhewwe32CQ5w5JpO1EdhTS2g+PnDkX7Pr1Dj1zM0VIzggdc9KMIkOwtRElYDSnN/kfI6I5048axFJSwEaWLLIO4/QzK02Xc9SLWrvBlSbjLYiR1BHX6nQp+UQGAJYu9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIzKm/Ol; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445824dc27so17262465ad.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757688979; x=1758293779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+rg6DF0J93LU8FePNSoWpCTSyon+Ho3xdECyOIRM0Js=;
        b=BIzKm/OllJ8zWi4IW2lD8FnjACcau83CL1SMfh9ZJeSwOK/C5QR+TT2BAXZHMHJrY2
         60f3/lmGBP58K7LpLa+uBD0ug24vv6IclHu/AF9/9M+Si1T2NzQGWVaKmwWXeCRTqW7a
         K+H/jOwi7Vk31+0yzw22EQR63p+XqI6Zd22CpS4cqp067lbo5/AKqEmmnNjbqYl0rVTj
         zRoK49+zG5kyhFq5dNDjhpOuBUWXWXh5RtaeHxVrv6Xfj3OqskcdnIOxhuECaJH1Zgwy
         rDKyrV4uC2o8XrS0bTt76kDJUL5kmJdl//hxSOVt+V3nR7Oj00GFFgTEOKRYY0HSftSG
         VqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757688979; x=1758293779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rg6DF0J93LU8FePNSoWpCTSyon+Ho3xdECyOIRM0Js=;
        b=YvKAHItqDcFs9VtpIWNrqeN8PRhX3jESkhbQYzBriL8vh0nIREobB0TfDKdUqU8aOU
         aZk3iPV/DXd4Y+3usg8vP7fH3TjOGhIvoJ5cLh5UnxxnixSzd+PbHyZG2kO02AouqcG4
         v/96zViTRvots8/Pc11Ja4cDMCaoroAdfFiUw+wzUmcQ/TpVg/x21nEe4XiB3noM59C+
         H0UipeKksHsrCcGL3ZA9CbwaeECrx8opCPP6pCKNGE9AZzSdwBsQBcEMHsn1V15FuXOb
         yxH5vr4BmwjEcWjTcQa3PywylsdI3zewPLSeHY8mCfssZjh+yEQ7qAfIR5pRAU0Cw7NJ
         /j4w==
X-Forwarded-Encrypted: i=1; AJvYcCWlY6sc8cnCQIeN6j/NeMKhnzZY87ct3ziK4tmKf6xwy437ErFfcafnyMsqbTjjnrOnJVVlmAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJyko6hov6sjUURJaoPBjmAvK32Nt8nrt0Sa81c32Lw0ekLU/B
	SNfC2sVXo/xx4qbSz4zFtt/xNSD7RcIBCAPjNNWZmAQ+GA+fvbVBQaPG
X-Gm-Gg: ASbGnct6fMp/o5HXTenOAXjHtmMOstVmKTLD+ULcLRwUU+JVxo1AYE8nW7RkJFgJ/r2
	9t8jTswLEOQzwPqQg1UscPEy6E8pNDM+F4dBvgl4Tm+9+6+RPWP26wqcGu09hEeNbyMl0jDRZ3A
	/vY0UdWrEIPQgUo8oMwOetydxUkO8PMhOkx7jjYoTUcHss3ChYbNUaWrgFRNIoqZEeMjyHDEFDW
	g8EiPAZkVrYhL6NoXjOLMJplLAIo9Xfx6KNJq13+s45bwiNZoAGRRnmzfE2Ch5wPaS8377mHQAv
	T3le3p29Vbc3A83b5spD2hQ/cXML6+OGdpuoBiqFgVJt9/hSpCmSclzKTtLZEGZ4sELxDbX1zTd
	vqofbEvK6JZCJ1cFGoKwxir5AIgl6RZyX4vAZCAv79rkJyupA7/o/BHbLKsHwS8Z0eHw=
X-Google-Smtp-Source: AGHT+IGiXFtqjikU8V69Zf2Ja2YTA63RXXh9wfLmsxrcrmVtFj+KeZN6bse3bgKpBr9gnSj742KUmQ==
X-Received: by 2002:a17:902:dac2:b0:24d:64bc:1495 with SMTP id d9443c01a7336-25d26c4670bmr34394125ad.41.1757688979158;
        Fri, 12 Sep 2025 07:56:19 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b3b5bsm5957854a91.16.2025.09.12.07.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:56:18 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yeounsu Moon <yyyynoom@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dlink: handle copy_thresh allocation failure
Date: Fri, 12 Sep 2025 23:53:35 +0900
Message-ID: <20250912145339.67448-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
If the allocation failed, dereferencing `skb->protocol` could lead to a
NULL pointer dereference.

This patch adds proper error handling by falling back to the `else` clause
when the allocation fails.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..a82e1fd01b92 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -965,26 +965,31 @@ receive_packet (struct net_device *dev)
 			struct sk_buff *skb;
 
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
-				dma_unmap_single(&np->pdev->dev,
-						 desc_to_dma(desc),
-						 np->rx_buf_sz,
-						 DMA_FROM_DEVICE);
-				skb_put (skb = np->rx_skbuff[entry], pkt_len);
-				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			if (pkt_len <= copy_thresh) {
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+				if (!skb)
+					goto reuse_skbuff;
+
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
 							DMA_FROM_DEVICE);
-				skb_copy_to_linear_data (skb,
+				skb_copy_to_linear_data(skb,
 						  np->rx_skbuff[entry]->data,
 						  pkt_len);
-				skb_put (skb, pkt_len);
+				skb_put(skb, pkt_len);
 				dma_sync_single_for_device(&np->pdev->dev,
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
+			} else {
+reuse_skbuff:
+				dma_unmap_single(&np->pdev->dev,
+						 desc_to_dma(desc),
+						 np->rx_buf_sz,
+						 DMA_FROM_DEVICE);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
+				np->rx_skbuff[entry] = NULL;
 			}
 			skb->protocol = eth_type_trans (skb, dev);
 #if 0
-- 
2.51.0


