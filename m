Return-Path: <netdev+bounces-149551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1E9E631D
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 02:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729F6188597F
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 01:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CAB154449;
	Fri,  6 Dec 2024 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WVSFZufw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED814E2C2
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733447524; cv=none; b=CQMNJGVRPBD+YV3dM2MvtFf17NZIImSnpezvt1BONuprK9TXteqDSgijx9z6f5KTyv+lvaYqDrolTc9zOMW1jwOWJBKOd31r+vyK05ooqWID7dN+wjd1a3HTm+dWAP+Ey2b44niGOaMsIA4EMClkRykYGK1i1Nw1tqq8zENH3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733447524; c=relaxed/simple;
	bh=HSdpSrosBpFjoXoHgEPxOFMdxecD/sTFHyHuYcmRo44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdDglczj5im25MP1Lf5KRJUBV6aCAMQUv0Qv2yl+TCUIjEB3yJXS3O2fwiJo2X+tRsGQXm4y0r4A9YWjjN0kAIiUB+DZAP3v3hcJxR+lM+TzUys1Cc4Sbk4uU93q5XgvhYTZOjAfAXaWjguP226SxlIUfdcO8J28QQUb84XFRUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WVSFZufw; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B3D663F766
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 01:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733447521;
	bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=WVSFZufwjVKhu4yRnjBZTKUu9ekh8yusoUluxqdFQ2eGrPlNETrecQg7hYutwekVO
	 a3Wd1ojmYG1PraRBOIGf5pU1Xv23ewX9h+uN6z6niujtQWg3JMkXg5QHauGkcwTaUv
	 UO74UrsftylXeO0zwifADvh2UZwj5lyskzT5e6/iXs2Ho4Nwt6FS7BgLpjOjG1u7gu
	 YbtxU95uIFnFPb5y6OvYWx4tDix1L9xDHwVFW5lWNAz0UzVo0O/OjD2NqSDPqP+aiO
	 B47b1fezTgD2Dooy/kobZCk1ao6BJVW+xxyQD+P6lwkx/ImAqW4st3k2WVrzwb66RJ
	 Te7si/Stohz9A==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-215936689e4so13619985ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 17:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733447519; x=1734052319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3okZ7Dk5bsE+ZlwnvoQtqX4jE3/LzcC69p28rg/sS/E=;
        b=J1ZPmOSIscb7k67m5Bv1J+gSLfTblf834ry6cZzWx52+oGOQyfGD1qm9NqhwtbkWpO
         fecT4VMfT94gGxD+i5j0iE82S0JfMGreHjRY7KHK53TVCqCF1N/lWmT2tAxLeTuPQLcS
         cc+7jldmjXdxbFG4RFt0VrDTDe7t2laenaFhxtPdCv5u5Jwg6HgSK4dYtza8kJ0UYOQk
         /rMcJVS18pXG54JqT5ZXOqPigiQMQdL/vD9LfMcSqlnPUNl7tAmHYy+rjsTDXjoyOYT9
         UZg+RhmkQ/P+0DchmLHtOWmnJNmL7i6SCUwoyrfHSVe1Cj7ebNpmYoZzp72GSRvHiJXY
         clGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJRaBadVMGD5otbexZVHHPvZMpi8P6bSyiBSgQqKcxg+5IUBboN0SDZ3CThyJS6hXMyC78uYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwujWEvllZL9Qm7HwFzistl4H8qiPETDUHpNcPngXkvr7SKoXpT
	oKjfmnWAzUjZ8Fg1sIxSbtC1Gbr9GaIhnmY9F+WLflEGV2BkOnrnosn1F9Zfpp8odN5zRMOidaq
	b/Bssec+lvuiFZoBXVVVHrsHe7b6xzs+1DkPoWfAejzmaJUMBlPJ82LIg73+mTP9CaGVz2Q==
X-Gm-Gg: ASbGncuG48K5YmZVcPFtOAujZBKJJzGcy8laP4wazxEansvw8+4KO5BSKrXoB1a8COg
	30w7+tjEISViQW/IYtLsj9by8iu4MEtjw8mj/s0wXNV5n1oUk5k81NMYbW1w3Cq8hHBhJlkRPeS
	OflB7jtJ3S8+wEqRwvhJYXv0WvWgENfJKi7nGroouhzPlOFM4FPsUCUNBwsiJK++CuJdNzZT1pO
	T2+XjEJ16vAZAer+80hlq+zsieaaPuxXypQvA2Ild58EwcF1sw=
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12429285ad.25.1733447519045;
        Thu, 05 Dec 2024 17:11:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQJN3aYvWonWOaVQbbwag0krwaPJYzGL0PhqRtYyRPCKfavtSDhMd7s04xv5fglvYMegTrDg==
X-Received: by 2002:a17:902:f601:b0:215:b13e:9b14 with SMTP id d9443c01a7336-21614d75a53mr12428985ad.25.1733447518781;
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:9740:f048:7177:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8efa18esm17979355ad.123.2024.12.05.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 17:11:58 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 4/6] virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
Date: Fri,  6 Dec 2024 10:10:45 +0900
Message-ID: <20241206011047.923923-5-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206011047.923923-1-koichiro.den@canonical.com>
References: <20241206011047.923923-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, requiring DQL counters to
be reset when flushing has actually occurred. Add
virtnet_sq_free_unused_buf_done() as a callback for virtqueue_reset() to
handle this.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index e10bc9e6b072..3a0341cc6085 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -503,6 +503,7 @@ struct virtio_net_common_hdr {
 static struct virtio_net_common_hdr xsk_hdr;
 
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			       struct net_device *dev,
 			       unsigned int *xdp_xmit,
@@ -3394,7 +3395,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 
 	virtnet_tx_pause(vi, sq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, NULL);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf,
+			       virtnet_sq_free_unused_buf_done);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
@@ -6233,6 +6235,14 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 	}
 }
 
+static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	int i = vq2txq(vq);
+
+	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, i));
+}
+
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
-- 
2.43.0


