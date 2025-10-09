Return-Path: <netdev+bounces-228412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAABC9F01
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 18:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01A3E3544FC
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E008D2EFD8F;
	Thu,  9 Oct 2025 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2Rwh1V6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0012EF64C
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025513; cv=none; b=GvhRhMARyecF6QgipzCk5ybOF1K16MsW3gLcvrb5V6A6GAjnJnmv/Bo/MbQKhj53kOdhbZTWXIBTf1uLw6QoPJpeUznoY3W5ryVe310rwhPz3tdfVw9OSINiLu1w2j3JAqC0Lf71qA/yTZli7Ej5siV1YtiaQ3ses+eHOhEb3cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025513; c=relaxed/simple;
	bh=8OZiH1BDPLJdfYF0II7is8iKCCoKggl/I/ld9NWAY60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNTvynThIwPkRVqRfFqT8RkTshn1o2pwQAHo5tIgeF7IOs0vaTk8ZPWgXGH1L4lOmQVfkzWHEBLOwmDQZUAOxMMK/aWqqnrxqtlnNLiOv8G8GDr/S6SQ0ybQlq/YQp3u7jhrlvDeH+NcuhnXc9obpnN8ykjybhMVI0mHgKY0iCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2Rwh1V6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b60971c17acso956428a12.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025512; x=1760630312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAdLvpKJCv4jbHmMWHwPbYfzoSafhf17EqbwEP2QLrE=;
        b=B2Rwh1V6gts6iIuIMsEzf7WL/5UrgNanQjsNccUtZ3RRhDYGWsGgkseljHazD1Zkaq
         NRxZz6j8b3TAau/Urexf7coUW+LPRnSyuDvjQqaWxMVSVMRonPS00WfeNTSpd1wwLHmI
         T8CLJwJTSHSIKcoyZZBi1BI6QQ3aKkdLnUjj9b5jBynY4Wd44BdcE4dKaLbJ9CRnFCdB
         /jq15Pafb8FjSRFnSUfvYd+8jBqt2CjyKXcPh4fyIXHi+i2SD2zNsNPKHlsWM1nBq4l4
         MR1VhOg+Ary13CsqogyPZlVIocW//BdR6tRN5BHKpTchPZFd7CUpgkoyWUTdiT+2wWhe
         4i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025512; x=1760630312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAdLvpKJCv4jbHmMWHwPbYfzoSafhf17EqbwEP2QLrE=;
        b=CnMDfHeWgP00eLQwV4Q4NXdAUzGZICmuSe8UxpIJuPNBnhf2cnD8mNdyf+pHzX1nLg
         j4773pC0+Q81lvcAL6u651QIbWnO7B8mR05WXysGRoPt1bnDFmB7xoAMC9rzMQI3lKQp
         saxSEEhcK0MCGWHnDLYkaVRDf0WMfylSvBF9D2UPdnIGuLVomKNRh4QtWO4Tu7bLBaYH
         0M4WI4zYhxot8C933eX2b+JSjzHRDQmhfI1MCbhaBu6Bl+K3NULld0nkaTfpl0UJHS4D
         SVHhW4kaqImXI5dzs0KxlJhLxSfNJeFLNnI6zJ5cbABfAB/fimWQpArbq8WQzuKdvYBE
         pd8A==
X-Gm-Message-State: AOJu0YxPduPMC9mGexKuvujI3YSrH0SuPhRqJXIVOQN/wZ1OMUcOVY/h
	ABqTdrFeb3A9Q/1xTunmYgMnOqE57YeKqrfj+vrH8fZ+En4ht7G8gWn9
X-Gm-Gg: ASbGncvdZ4gVTIUBlc6Fe8EdxxROl0AHrHqr8Y9E/j7lC0NEGUE2pfp8HqazlT/LOBR
	8BPVGY5OA8nOH/vlq5QDg8HTDiwDlsD4PGfGYNnUD4X2iFjYFUgHuyOoOcE3En7k8cqCpmXnMx8
	IcLENwq3uMdXBWtbPi5OtN7fSPZs2j/ZolyYgKK1bBiPPytk3i1SbzUqeO1RwJ3PjPOtxcxDHpQ
	sWX9Y0IfeXfgloDzgysqtV3fFIJwwiIvu63xdg+2oiECKsBvD3D/TRM4jNQh6EanipqEnAp8qUw
	tlJsHqcCMoAUtiT9hHZR7b9CQeW9QGxqM1zRxXbRrQXrFt/ToYyeXJBkK5SZQJhRNZ0H9K/QF42
	4qNVqRt2dwbaf7zjz3sKmEq7Evg/I+NUVLXs2mzGLDf1pufCX0wtw8l5kAA==
X-Google-Smtp-Source: AGHT+IH6oXZ0R/UodGK/kVJXi2B1T3lBvL0TuIS/Hh1ntLXXA4peFkl0J++JBh6etU+8qLRjDNuweA==
X-Received: by 2002:a17:903:3885:b0:256:9c51:d752 with SMTP id d9443c01a7336-290273069bbmr105229465ad.56.1760025511618;
        Thu, 09 Oct 2025 08:58:31 -0700 (PDT)
Received: from mythos-cloud ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e44ef9sm32585005ad.52.2025.10.09.08.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:58:31 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: dlink: handle dma_map_single() failure properly
Date: Fri, 10 Oct 2025 00:57:16 +0900
Message-ID: <20251009155715.1576-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no error handling for `dma_map_single()` failures.

Add error handling by checking `dma_mapping_error()` and freeing
the `skb` using `dev_kfree_skb()` (process context) when it fails.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
Tested-on: D-Link DGE-550T Rev-A3
Suggested-by: Simon Horman <horms@kernel.org>
---
Changelog:
v2:
- fix one thing properly
- use goto statement, per Simon's suggestion
v1: https://lore.kernel.org/netdev/20251002152638.1165-1-yyyynoom@gmail.com/
---
 drivers/net/ethernet/dlink/dl2k.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 1996d2e4e3e2..7077d705e471 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -508,25 +508,34 @@ static int alloc_list(struct net_device *dev)
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		/* Allocated fixed size of skbuff */
 		struct sk_buff *skb;
+		dma_addr_t addr;
 
 		skb = netdev_alloc_skb_ip_align(dev, np->rx_buf_sz);
 		np->rx_skbuff[i] = skb;
-		if (!skb) {
-			free_list(dev);
-			return -ENOMEM;
-		}
+		if (!skb)
+			goto err_free_list;
+
+		addr = dma_map_single(&np->pdev->dev, skb->data,
+				      np->rx_buf_sz, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&np->pdev->dev, addr))
+			goto err_kfree_skb;
 
 		np->rx_ring[i].next_desc = cpu_to_le64(np->rx_ring_dma +
 						((i + 1) % RX_RING_SIZE) *
 						sizeof(struct netdev_desc));
 		/* Rubicon now supports 40 bits of addressing space. */
-		np->rx_ring[i].fraginfo =
-		    cpu_to_le64(dma_map_single(&np->pdev->dev, skb->data,
-					       np->rx_buf_sz, DMA_FROM_DEVICE));
+		np->rx_ring[i].fraginfo = cpu_to_le64(addr);
 		np->rx_ring[i].fraginfo |= cpu_to_le64((u64)np->rx_buf_sz << 48);
 	}
 
 	return 0;
+
+err_kfree_skb:
+	dev_kfree_skb(np->rx_skbuff[i]);
+	np->rx_skbuff[i] = NULL;
+err_free_list:
+	free_list(dev);
+	return -ENOMEM;
 }
 
 static void rio_hw_init(struct net_device *dev)
-- 
2.51.0


