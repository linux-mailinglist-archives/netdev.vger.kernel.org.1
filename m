Return-Path: <netdev+bounces-246597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1509BCEEDBE
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6D223034A37
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EAC2673AA;
	Fri,  2 Jan 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMtEg4lF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3925F98B
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767367263; cv=none; b=Y2YL7MI92+BzIFViaEoteWK5UxxK9TQxHuoIXtt0lx7VImaBiUqmers+K7HnKR/5zGVDPVTmhTuXcxh4gnXHnFTy4vj+F78ciukULZ870JrT6SOp6fLkJ3chpJxExN3rYHlbrQ0rUtxlyAr2TGxpeBQuIhbTUhEGqmw3EHqDxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767367263; c=relaxed/simple;
	bh=/4eiguhDqiumviny97YbX/V0ioG/S7VlDOjqS+Yf6c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHP0V/LFTcCB74Rq7/9a7P7ldyEHGjqgS5x6fRB2m2Ejp4gp9kjH2zJPGSCwMLrGWt1y478v2x0wW2AIADBB0EZi26M9oNYcTaZ4R4LaWVYalr/O5JleINoG+1P+L+kOsvAn9/fA8Uh0DnkOcH80PUUR3I3WQuqb7yMHsVEsJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMtEg4lF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c902f6845so17249553a91.2
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 07:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767367260; x=1767972060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9jxgbD+/yxl3j2kHcSn/k4rVRA0Pzivb1lp5AvUuyE=;
        b=fMtEg4lFf06H+5Uz4Nw99Dw09SIhxEiIMRs6w8pMj7dKJQof0b0YcXHySIaCkTb1xm
         k+/ms4lhK/2j5CE2y7rXZfq2KJJs1Gt358lsPCkEPyI6tVMIWFwxl1SG2ThhP4Wnxyx3
         Z1qOTS8W6nF8zuplxpyXl71ak5LBm0ZmzOkomW3E9t3J0R6JV3bcdHhQATiXIcRCUd/u
         pEYj9AqHSgBajjN9SPUgCiG1GP6JOBR5zf6EPnf406/8JBihowLwnP3fRLRio2koZOU7
         mwP2ZvaM51T5BKUOh6uE4boZtU2JLnInpZ4xYH318MsKups0msNln4q8xrPy/SG+vGPk
         +4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767367260; x=1767972060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n9jxgbD+/yxl3j2kHcSn/k4rVRA0Pzivb1lp5AvUuyE=;
        b=k2yoZ7xWUl/6/oCMl64Ocu51o30lw6k00VF3K6MnrNzSeMfto8BiJ5+eZdo7c223lr
         efVpaoCI5RZBKBJvRJl5rHnuFwcwyeTyDNhZ9dxvXY2CXxX9PdPrwLwdUpm7QpIqZqBz
         gSPDLAFfZ2KNty5/Thgqv1J5rsjF6Wm7Omz7XlbySeeqAgAzKHouqYp7E6am8Pa3f5jQ
         xKXdHZWt2V5WMEZlGSi4G8ovzjF+41HmxR5Fhhgh1yZ4eyR2Q2O4ZE/vXd7SbJQ84Wse
         ipzh0pYkgbxWsdK/vlxZPkZMPr0g5/5xKtqqYzaY/rttw1VxzBigqlz+cF3JbnjUpCNs
         ngZA==
X-Gm-Message-State: AOJu0Ywppczg5VgYQ/egQ1uswgiF0iQL2t4hyzrCpQkiZ1J0GxRx4A2w
	cFazLUxUKNuZkQhU+DiklDOriI/RpEfNrYY2rL9C9p8ePgLaEWLl0SXaEEQ5Ki6p
X-Gm-Gg: AY/fxX6d0PVY9/acoQsF8nGh7Ed4q9Hvi63PkURr8xdGQ3AxxcJEfZKvUroh1hWWeGl
	gniNml/pi1Vrdt5GFUq+KF3qslZrBaiVYrfnQB04CWT4mwyAV1sPvlkOHGgYYZ0E6lfTfhuXRI1
	D6GbslNwJelJbvcUpyc5Qo/wvMFbkZiPxjvMz6aSTLyAmCjH9sbQpz39INl7qJ68hGMpc4Y0rok
	wCmoQfG1OZYmUfQGttMSKoLyxJCOwm8iDSY2sjLpMZU73z73XWwbqAiPvoMLTlawR0mDtCqazZz
	cwEueYF0E13h6UjU3bkv3ct7OLC+HgJSFglLCvHFI2oU+hOyllW4vvt7PRPk+415svqp7NI9Qs3
	gYLLLOfOb7gv2bf4ltJtWO8x0YbkYfiY3Tzpn0TJWsiKBoeXidxRWjls5y4SW5wUZ05lqN0D5sJ
	0Cx14zI1MZiMxoOosxhr49CVw=
X-Google-Smtp-Source: AGHT+IG+uB/bwtxyi8mZp0xNuzYOVJCRuR6o1MY96JjPiCTZmrbu0bFieKOLX9lXthIPYGtwJPA6DA==
X-Received: by 2002:a17:90b:5188:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-34e92139e2dmr36663487a91.14.1767367260086;
        Fri, 02 Jan 2026 07:21:00 -0800 (PST)
Received: from minh.192.168.1.1 ([2001:ee0:4f4c:210:a612:725:7af0:96ca])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c1e7c146aabsm35041268a12.25.2026.01.02.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 07:20:59 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH net v2 3/3] virtio-net: clean up __virtnet_rx_pause/resume
Date: Fri,  2 Jan 2026 22:20:23 +0700
Message-ID: <20260102152023.10773-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delayed refill worker is removed which makes virtnet_rx_pause/resume
quite the same as __virtnet_rx_pause/resume. So remove
__virtnet_rx_pause/resume and move the code to virtnet_rx_pause/resume.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/net/virtio_net.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7e77a05b5662..95c80f55fa9a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3366,8 +3366,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static void __virtnet_rx_pause(struct virtnet_info *vi,
-			       struct receive_queue *rq)
+static void virtnet_rx_pause(struct virtnet_info *vi,
+			     struct receive_queue *rq)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3382,17 +3382,12 @@ static void virtnet_rx_pause_all(struct virtnet_info *vi)
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++)
-		__virtnet_rx_pause(vi, &vi->rq[i]);
+		virtnet_rx_pause(vi, &vi->rq[i]);
 }
 
-static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
-{
-	__virtnet_rx_pause(vi, rq);
-}
-
-static void __virtnet_rx_resume(struct virtnet_info *vi,
-				struct receive_queue *rq,
-				bool refill)
+static void virtnet_rx_resume(struct virtnet_info *vi,
+			      struct receive_queue *rq,
+			      bool refill)
 {
 	bool running = netif_running(vi->dev);
 
@@ -3412,17 +3407,12 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			__virtnet_rx_resume(vi, &vi->rq[i], true);
+			virtnet_rx_resume(vi, &vi->rq[i], true);
 		else
-			__virtnet_rx_resume(vi, &vi->rq[i], false);
+			virtnet_rx_resume(vi, &vi->rq[i], false);
 	}
 }
 
-static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
-{
-	__virtnet_rx_resume(vi, rq, true);
-}
-
 static int virtnet_rx_resize(struct virtnet_info *vi,
 			     struct receive_queue *rq, u32 ring_num)
 {
@@ -3436,7 +3426,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 	return err;
 }
 
@@ -5814,7 +5804,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 
 	rq->xsk_pool = pool;
 
-	virtnet_rx_resume(vi, rq);
+	virtnet_rx_resume(vi, rq, true);
 
 	if (pool)
 		return 0;
-- 
2.43.0


