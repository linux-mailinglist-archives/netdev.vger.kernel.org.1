Return-Path: <netdev+bounces-96597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812C58C6986
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D132282E57
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F65155747;
	Wed, 15 May 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdOto+Lk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04E62A02
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786320; cv=none; b=JUObaPadtJgGtHlNj/E06SyPdZqbhhwzcThvaBb3aW5ItX7+RTW/rGjq8k/TJY+45dw7gPfZuX+XYAeJrOQClEUhB+hLbIRFERyTGgg9B+zogf82JcOTpk6K9HqJeJYIpfmvemnpE1wXAQKFp/TcllYetGNmVC/G9eljefDEC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786320; c=relaxed/simple;
	bh=PO5Hrp3Nr6H/80MkjK7F9uae9kOvvMoIqj/65Dc2M7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WsgXawVfGSP5bnIMgqdLebkFXoZ1DxiWEPVEzNuft23I8qyFg8PrPfou+kjVQrb3E44FvnOxTxSkjTdCyJ2SecR/OlTk2nc3p84tTjcQ6nVX8OzZYHvkC7V3cZOXs/mz/E8alCOJ2ENqfOXduOocFtiaAxMSIVrQ344x970u5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdOto+Lk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715786317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bSTKu6LYn+5Gisp7sWtG4MHxfLZbzeoOCn381GwpTG8=;
	b=YdOto+Lk8WlfajBbOm6rPhVlIweB+GkEMsZJycpmL73d4+JwD+4CUnh+d+QyiG7t5XSCuE
	qD3XkOcBGIBpdKM8NyUv+Jw980nlIJbn0lt5GarEo+TUdTO8MaDP2sI9lutwHDvVyjxvqF
	WXt1Ay8OL+F2+10j4Gs4YVjxuC1iBOU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-GN_kWRvfMVed2hbs4mMoeA-1; Wed, 15 May 2024 11:18:23 -0400
X-MC-Unique: GN_kWRvfMVed2hbs4mMoeA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ee3b4f8165so69401065ad.3
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 08:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786302; x=1716391102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSTKu6LYn+5Gisp7sWtG4MHxfLZbzeoOCn381GwpTG8=;
        b=F3L/ReUAVy2btW0i4+p/DmN5MZJ4BCWKLGPt7zcVGmkrRwGvmKg5t9o9FORh/mEMtf
         N2bWUd7PMJ9PWi34DDjaPp+LLWdDV93/RKQ5Z24XswKkCaKTEYLGV4t6vDemAvlZdCvd
         eAQhP5zUSuJ5u+OTFIfpc4YhF7oBrYhLXe3BHzcGgvzPAX8ajskTJt1RIr5hgV2AkLn3
         zdGzS3BG6AydHpI8/GxFNJFtumZRHz6gwe5fY7IMmvXzaY3x8hYE6gIKg8gNvaYx+g7k
         HpnV3YFabZWRmI0goTIaTundBs7A8qBVC91plKquTtNIl5Agsah33eyJvI/V+sWFiYfT
         yTKw==
X-Forwarded-Encrypted: i=1; AJvYcCXfcXaIk/btEkXOL8aXmFoDC4q9zkJd9u/n4TErv+++sgp/6fZdmB5cVyhVfiGD/HqBwtSNp4SdUjK+H2jEsWtzgbA88ECU
X-Gm-Message-State: AOJu0YxtXoIbp7pbDfRrLBw9QlR30lLBqlK8ZMAcB3Cmdt4Y7lKihVRP
	2X1MxKPMHDrg9h/lqvFpb9O89CQJHBIIMla0Xi+2493udr6p7440sVdZ8Kwy5AqAvw1t8ALWJ7E
	IpoJVvBUI6XCzCpwYRV3UDgwBsrm4P6HHBSjcR8YLjSXWC/LQczLPVQ==
X-Received: by 2002:a17:902:c40c:b0:1eb:1663:c7f7 with SMTP id d9443c01a7336-1ef44161405mr183201925ad.43.1715786302641;
        Wed, 15 May 2024 08:18:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxNuB9g/yxB7jNpObTwnphr3YV5yLb2dx2g9RP2qj+ZSAIMayXguP0kUjhfAI0s+ScUOrASA==
X-Received: by 2002:a17:902:c40c:b0:1eb:1663:c7f7 with SMTP id d9443c01a7336-1ef44161405mr183201675ad.43.1715786302246;
        Wed, 15 May 2024 08:18:22 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d168esm119731935ad.32.2024.05.15.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:18:21 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syoshida@redhat.com
Subject: [PATCH net] nfc: nci: Fix handling of zero-length payload packets in nci_rx_work()
Date: Thu, 16 May 2024 00:17:07 +0900
Message-ID: <20240515151757.457353-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nci_rx_work() receives a zero-length payload packet, it should
discard the packet without exiting the loop. Instead, it should continue
processing subsequent packets.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Closes: https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
Reported-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 net/nfc/nci/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..f2ae8b0d81b9 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1518,8 +1518,7 @@ static void nci_rx_work(struct work_struct *work)
 
 		if (!nci_plen(skb->data)) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
-- 
2.44.0


