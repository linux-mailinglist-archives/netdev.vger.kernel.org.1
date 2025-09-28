Return-Path: <netdev+bounces-227039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A91BA7681
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 21:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5E63B868B
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0C218827;
	Sun, 28 Sep 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYyKhnVE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966442065
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759086109; cv=none; b=Dh3KTcv3q7GBCZdkexhhfmvJB0C0z4NOfP3579SKyytAqK8iltNv47gPZL7gI7j30qNFGn0XzO/tdf1wdk5zisl8dz0VfgfetxRPtLfDiDoELJXGuo9iYjYcXwF9S8owPDEKUKoz+9RMOXPBlWzNIY/v85rpQFs4OKX5Bi5SwuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759086109; c=relaxed/simple;
	bh=RPEu8e4XCkPY2pLmJdc73bu5mi6Bblw8TU1IqAT1O4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7XNIAQJsTUB8tucuZS+LqMUWFhBiFwghzBFqjTWOkrqB4izNP5d6V3TLW3br3XTq79h2i+YIbSbN8wkHyRTYZ/UFIGs9NVNY2j81lAUXTL4JY5quSzUS68Kbm/7jOvwYYCvBU8STLlZDa7s4pj0K+FwZDRvtHY9uBWDx3FXWvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYyKhnVE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-330b0bb4507so3269210a91.3
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759086108; x=1759690908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I79Wagnj8/O18vtzNLBvXOz+ty+xd3W7AiEb254seu0=;
        b=MYyKhnVE6V7pR71qumFP/KCJ/0WbbhhCFekP6XsxiOkbSfA8uYIz68797yKBZmf9Il
         D04DEPw3pMgK5ahV/0EtU9056brrvUnstxmm3xgu9IPhC7FdvFGxbGkR981XmCyDaOoR
         Z4zLx+9ROIBLPqWkDcgXQP0t9idFWoR+LzLJJ1q+njuBu4lsLIo1itfbu0yLojhCR8v8
         p8SWhFl8qUezkDBTtmp8RLaRdwqL1LkTBL0FIaNlk8k/hTT0Qhk+MmD2lS/bfbpRwbMv
         II8ogPu24J9gAB0eDw7hJA+A8qHJTp4KjYHNo/mSOXQBBBNwRVEZb0ORhPz/+fbW46MP
         VVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759086108; x=1759690908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I79Wagnj8/O18vtzNLBvXOz+ty+xd3W7AiEb254seu0=;
        b=a9p/E2jKAc4U7fGf87AKxXUHnXaRzy2HfXjROo8zDFzSvcj8QSddLNYydwnpQpgMhj
         AlUOkuFRr3AdqE/31aX2X8YRgJx1AymJwcU8tnSKdosG8pfg9whSwO08TvCrAqhBeSeZ
         Wo8AhcsN5mXwGdn/IMnyz2qQblobFXMmyWGy8/otHx+ao9t483p2A3qtiQ0ideSCJnb7
         QgmPbxriYdMIXHgtd2aOQa+BTJJPrcBPyYF7lMfAStNyLLl/7eezvmQeVbzHCk2bh6kH
         BoEc6s8Wg+DbSWWamLnoL/9Jd5frIenGHFHBdcZUh0N1wcfY2iVq9oeHdtzXgyVRwqmi
         96UQ==
X-Gm-Message-State: AOJu0YzSvBa5hNBdfDvGw84Wm90HUiulVUzG0rtes7cVFO2WGsCK+qun
	j5nbyAZdyWAc9K8UawU1fa/RACBQtxfjACBvREZtRnyFL7gbbHBqGkCz
X-Gm-Gg: ASbGncudMGa5yg3Tet3OQ4OYnVE6rpUP2hW/aUmh+z4YAIUmnG1rEKfZnRxoLx4fIjO
	lxNCLXAZttTqQGRqFmUoGD4cKGDFxq6vI9PUri1DhehT+qdL5s46dHZ4j7AA2fB/mNenl6aRJzY
	i91CYvFDYHcivI0XTgAoqa6DrjAVG6UulX0pIMZLpdHq1vBOHRscZ7BdmEq1ulRzAwk06mcmexF
	wdo6uBcxrFk2IKh0J+etdgyKT5va+KopQEJ5QmZyqBE7VS1AAh4TobOz9Cpr10ynYgR2rBz5gBR
	Yn2fIJ9we32dX23p1uLCoDCdexPL5GFGdJg7fK2RgKlJQpDiBAtp+0WSTvKBWaYoQeMCtqlgKno
	+PaXy0nRze3LPOX4Ps9FMz948nfXkOfehjdzqOvXq2yudtK0Le/zK0/ImxXMpAtEJltI=
X-Google-Smtp-Source: AGHT+IEc2dfZk4XueBpA/vhO8PC4wSZ2gwbHX8LW4yim98oAg19DqgmTWCz1ul+VviYXhrkwDHaEfA==
X-Received: by 2002:a17:90b:380a:b0:32e:5d87:8abc with SMTP id 98e67ed59e1d1-3342a306014mr13768315a91.36.1759086107740;
        Sun, 28 Sep 2025 12:01:47 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be148e8sm14807455a91.16.2025.09.28.12.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 12:01:47 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v4] net: dlink: handle copy_thresh allocation failure
Date: Mon, 29 Sep 2025 04:01:24 +0900
Message-ID: <20250928190124.1156-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
If the allocation failed, dereferencing `skb->protocol` could lead to
a NULL pointer dereference.

This patch tries to allocate `skb`. If the allocation fails, it falls
back to the normal path.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/dlink/dl2k.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
---
Changelog:
v4:
- consolidated into a single patch
- removed goto statement, per Jakub's suggestion
- reorder changelog for clarity
v3: https://lore.kernel.org/netdev/20250916183305.2808-1-yyyynoom@gmail.com/
- change confusing label name
v2: https://lore.kernel.org/netdev/20250914182653.3152-4-yyyynoom@gmail.com/
- split into two patches: whitespace cleanup and functional fix
v1: https://lore.kernel.org/netdev/20250912145339.67448-2-yyyynoom@gmail.com/
---

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..1996d2e4e3e2 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -964,15 +964,18 @@ receive_packet (struct net_device *dev)
 		} else {
 			struct sk_buff *skb;
 
+			skb = NULL;
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
+			if (pkt_len <= copy_thresh)
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+			if (!skb) {
 				dma_unmap_single(&np->pdev->dev,
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
 				skb_put (skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			} else {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
-- 
2.51.0


