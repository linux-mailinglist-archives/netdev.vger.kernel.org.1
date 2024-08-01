Return-Path: <netdev+bounces-114932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30870944B47
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D391C23220
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB901A01DF;
	Thu,  1 Aug 2024 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VzMd5OL7"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECD1A01B9
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515273; cv=none; b=SpjX/SR/9NZEX+goVEQRkyxjMd+Nr/AgOEd9qSqbpIBm2q93kZ3V6KRK/gDWbg/+KJtCfrVIxjlmbO8ewRN+aeWxstOcL/9A1yT9SPspoeRnYBVgRBp3Ei5ejaeMkW64kXCg9HGiwcyZciUGxQMpWic9YKtpRqSpdkD3Ed1ZnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515273; c=relaxed/simple;
	bh=ZCbf4dagKeXob6Jv7lK9X2wnUSfRPgMXFasbsE/FxhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iizv99C+J/BcpIxVngVzLHQjfVBqCJ8bbfyMfyppMn1cZC5MlKcKRbCHT0Di75TLKMtMoLmqJVDdJLwNtw6KrCB5jfJxxoevpUoaBkRiqBlIdzraHbmrni4CmTmuH0CQ3EmrrsHZGDzbjrfGCuX66xFokb2A4AaKP/znjLM0ggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VzMd5OL7; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722515262; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=39RrBFAmDzvWDA7/34qtG1o/5bUpFe1kib+dVzow0vA=;
	b=VzMd5OL7lAVJMvUbWe8gsX/NWCiRcEiTn1/XessF8b4fwohK5fki+7iKO/ugKEqfJSYBKJbLIuPvZ2orM5GU3WR5qMC7KiX1m0HpKQPPv9x06+DqboQNuWyRMsl7duqh9XgwR5JU6ttbe22BiSzsyFgUpRCaiT52mkVcbtyzy4g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBtHmkj_1722515261;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBtHmkj_1722515261)
          by smtp.aliyun-inc.com;
          Thu, 01 Aug 2024 20:27:42 +0800
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
Subject: [PATCH net v3 2/2] virtio-net: unbreak vq resizing when coalescing is not negotiated
Date: Thu,  1 Aug 2024 20:27:39 +0800
Message-Id: <20240801122739.49008-3-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240801122739.49008-1-hengqi@linux.alibaba.com>
References: <20240801122739.49008-1-hengqi@linux.alibaba.com>
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
v2->v3:
  - Break out the feature check and the fix into separate patches.

v1->v2:
  - Rephrase the subject.
  - Put the feature check inside the virtnet_send_{r,t}x_ctrl_coal_vq_cmd().

 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b1176be8fcfd..2b566d893ea3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3749,7 +3749,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
 			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
 							       vi->intr_coal_tx.max_usecs,
 							       vi->intr_coal_tx.max_packets);
-			if (err)
+			if (err && err != -EOPNOTSUPP)
 				return err;
 		}
 
@@ -3764,7 +3764,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
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


