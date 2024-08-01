Return-Path: <netdev+bounces-114971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6C4944D1B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B471D1F256C1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38191A38C9;
	Thu,  1 Aug 2024 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yCGnYMuS"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F358B1A255A
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518631; cv=none; b=Vapdauis+/fr8P0/SmwHfteyN0aNX/52djbm82q/HEL5AxMPsh+CGbMLbckJEmJvxwqmmFBV83PhaYem4mv/aH//xCAEGmRwCa/t8ZGnHM7nKh3GIVaIduY6Vo2qHJJ7Sr0k5mW+o5W0Or2RQWGKyq/2MOJ8+8U4IApSeeyNmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518631; c=relaxed/simple;
	bh=wuruu1gVyucbxUH3Qf7G/JYs6iQmFD1AW8zZkd5bSFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn4RJt+DKp7nhovFglZ/C0UWKoFoW8CWoPeHctaT1SBZ7hIJB9l6JSayI6vKVVuZirScmLNN0O+Cac3nFGxlAfaDxAckqIfwyRzNsdZTPon27EvrA+H/tuRMWpGU4aGJO8SPC/9DujMfrtKwXuQBQQL4q3TLkgfOTl98oQCA8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yCGnYMuS; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722518622; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=21Crsi8z2e5Y5WnMRGR745jK4syZ6mZ6kO+JL+4hvkM=;
	b=yCGnYMuSZXjuCaq1bncHoe0RkMIkRI1iU4kyM9AZcHohAKU+xHKs0xQ8mkq156FeRoeubU5CzQfgd9wp3HEFSyH5dU+uxJPTg0VIb7nLswYmuOam7MARt/HVHPohh0ZJXFIvVgnDLPYGQQkhiP7QRpdstjZY8aIUT+I+BuznPkk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtsEFx_1722518621;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtsEFx_1722518621)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 21:23:42 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net v4 2/2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Thu,  1 Aug 2024 21:23:38 +0800
Message-Id: <20240801132338.107025-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240801132338.107025-1-hengqi@linux.alibaba.com>
References: <20240801132338.107025-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't break the resize action if the vq coalescing feature
named VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated.

Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Eugenio Pé rez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
v3->v4:
  - Add a comment.

v2->v3:
  - Break out the feature check and the fix into separate patches.

v1->v2:
  - Rephrase the subject.
  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().

 drivers/net/virtio_net.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b1176be8fcfd..3f10c72743e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3749,7 +3749,11 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_tx.max_usecs,
 							       vi->intr_coal_tx.max_packets);
-			if (err)
+
+			/* Don't break the tx resize action if the vq coalescing is not
+			 * supported. The same is true for rx resize below.
+			 */
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 
@@ -3764,7 +3768,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
 							       vi->intr_coal_rx.max_usecs,
 							       vi->intr_coal_rx.max_packets);
 			mutex_unlock(&vi->rq[i].dim_lock);
-			if (err)
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 	}
-- 
2.32.0.3.g01195cf9f


