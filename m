Return-Path: <netdev+bounces-157266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D33A09C64
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 21:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23830188E9A5
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9C21C9E6;
	Fri, 10 Jan 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gp5aYnAY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3820B21B1BF
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540785; cv=none; b=UFY8QvTQII0vo8mbibkCk7hmq3uE7elkxt+S4IvFLj3ykLEeuPwFEyM6ACuByE/x1VxBfso023A6RFqiZehaK5yfbNhqJx8VewpKEVOXYnrPfAF9PfGmpelP2W+wfk26iW8LVOf+aFUS8MUTcn2xawHQknx/dqwsF5Oqm4bxEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540785; c=relaxed/simple;
	bh=z8f+xuxsM4TN11cQa7K629H96IgZ46RfWlBQbRy438c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0ycFORZ6aDFpHNbf0f555oeNJ/e37et9ydkZrU+3PjRJk3PLvSjUEVBPE0fjrYTs6pzN1AAK9Tp7ZcOQ51A7JFNGCNr93nOrNrTktm2mnadc/B9zSSTTiZf+/25QQr7OtEvR14ZkZ/kosJWYGVacT57J1H33HX0hkrKcfGKd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gp5aYnAY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so3366722a91.0
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540783; x=1737145583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ik/OAXhd/zh+RJRbmUQzcFN2s3YuP0CmCWofX99x/A=;
        b=gp5aYnAYEQfwMWPhkjTTo6N3CLV14Ga1Ta6uQtOinO1zVB7leANLUrv4Uhk+hV4W8t
         RehtH3vA+4TLLzAW5KHeTd4y2frd3EWEpMsVrtMTziKQys7AOqyT4rO7ksWaFqvF5VBb
         FySkdRuL/SWC3QdrZxSf9It2AdqWLtCV8ElBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540783; x=1737145583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ik/OAXhd/zh+RJRbmUQzcFN2s3YuP0CmCWofX99x/A=;
        b=X4ZDt165NbUZ0a3TBOgyaCAl2IV9bK8+6VHikJ/UW093ONBvtoJdFWiS4iqpY395OJ
         e5ZcYc0NhSNwp0FWLlYrr8QqltYnxHoMoJh3m58dcIY8KnXdp0WCrr/pGdYH78sWojut
         8Q6eUiWhBnmU0E/JIGuu9W9Jd+A70b/sJEGbG3DCZUyPcnI3DianUZu/M/CreIz0Tsa3
         1FkTbW7T2APh4kb7MDq3TchsrHRU0olhK2mLGE0Pvv0r279ZcPv3KwYJxxIHHvfutFcP
         b20wvQXhL1wE2pTNXOBs4Sb8RQHq2jiExEkpfUoY2h44S7pSZXFrSGwQQiYFnp1QSE6E
         dsAg==
X-Gm-Message-State: AOJu0YwWS9U7x5Lr9G1mIbQ3u+PxtGCsR1Ng6vxT1DzMI1hrN9WrVWB9
	fl3zL9DAEUdOAHoeIQ8leHEYhyt2bntZx5shzkLEp5OC0im7603/EbAZmi58XNKcjyFCu1nI/2G
	N6kp3szUbl4ZEdWaXY+sGbHu9USqRUTMgsHCVY0xHVEKDYVHNUcVJh5gdSFJCuIDdgAhsFVAEyJ
	EQPTPA/V++dkEytT1c5Ne1M6lkFnNm9XLRzZI=
X-Gm-Gg: ASbGnctFdIdFWG+rqzF7D2ICPZZfSRYu9qq2O1R+wfgh8zvSrQNYdwZP4tIHoOQnOWL
	ktZY3AOBvvRQsH0EQAN50K7LVOusL/F8+zIvMsBJvHaHSv7eP039fpFmcJVsEkdY1pSbB5jBZv0
	j09spb8Q7b7vbVggPaBwqJ75WCcyoCEUnbSvgg7EvsW+KY7pFRfjCWJo+SgLPQs/U6V5J5O5FBS
	g6PtsijA4Ctlml/ptaJ2qddoGJJue3t0MuSFgncljm1CVGMoCGF9uDYiH33V1gB
X-Google-Smtp-Source: AGHT+IGukifaC2WcNQEFeWzn03HlxqND0jHU8i/CmAXEOKXmIs5P2HeRfZRbh+3c5FScxgk06QKRWg==
X-Received: by 2002:a17:90b:6d0:b0:2ee:889b:b11e with SMTP id 98e67ed59e1d1-2f5490bd257mr17730230a91.30.1736540781585;
        Fri, 10 Jan 2025 12:26:21 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:21 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/3] virtio_net: Hold RTNL for NAPI to queue mapping
Date: Fri, 10 Jan 2025 20:26:03 +0000
Message-Id: <20250110202605.429475-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110202605.429475-1-jdamato@fastly.com>
References: <20250110202605.429475-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for NAPI to queue mapping by holding RTNL in code paths where
NAPIs will be mapped to queue IDs and RTNL is not currently held.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/virtio_net.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index cff18c66b54a..4e88d352d3eb 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2803,11 +2803,17 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
 	local_bh_enable();
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+static void virtnet_napi_enable_lock(struct virtqueue *vq,
+				     struct napi_struct *napi)
 {
 	virtnet_napi_do_enable(vq, napi);
 }
 
+static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+{
+	virtnet_napi_enable_lock(vq, napi);
+}
+
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
 				   struct virtqueue *vq,
 				   struct napi_struct *napi)
@@ -2844,7 +2850,7 @@ static void refill_work(struct work_struct *work)
 
 		napi_disable(&rq->napi);
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-		virtnet_napi_enable(rq->vq, &rq->napi);
+		virtnet_napi_enable_lock(rq->vq, &rq->napi);
 
 		/* In theory, this can happen: if we don't get any buffers in
 		 * we will *never* try to fill again.
@@ -5621,8 +5627,11 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
-	if (netif_running(vi->dev))
+	if (netif_running(vi->dev)) {
+		rtnl_lock();
 		virtnet_close(vi->dev);
+		rtnl_unlock();
+	}
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5642,7 +5651,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 	enable_rx_mode_work(vi);
 
 	if (netif_running(vi->dev)) {
+		rtnl_lock();
 		err = virtnet_open(vi->dev);
+		rtnl_unlock();
 		if (err)
 			return err;
 	}
-- 
2.25.1


