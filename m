Return-Path: <netdev+bounces-98415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43A58D1589
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F091F2173F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBB374BF5;
	Tue, 28 May 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GDRg9ws3"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA73E73472
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882759; cv=none; b=MuCdpJNZXmvCRI9yUg4+PUzWxKT+SxT2c6X8W32SyG8uLSq6FuKkd7vjQtVRpc4JbEWX/sEm+FE2zGOgxjS9/pCX+367MyJ7Ww7nlWLD4ddzSdneOF2hjvL9R/VBGfLB2o0QhMu7CycandJDHXUO5QHhQCE82a6CjRsLZgkFHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882759; c=relaxed/simple;
	bh=GfEulMx2KhtrizCd56h3xXWnS2UCVQN4StF4rpSymzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=InoNLR+5lAQ+fZZXE7vgfI9U3bbI0wiw+2yzRHZvDZ1pCAoeorphG8D8oBCZRgYyPvS0nQjTVb3emK47I3dwoBaVEpgAzpL/6RIjnwUGeMZhh47Wb/+wyoASY0WbYOu13aDHcsbUnnf+WeenMsKyOVHdDlgotdKu4ezLeMyPPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GDRg9ws3; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716882749; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KdpOhLozJ8bbzcbkjkEZg/h/Suz653QXLD5WRKflAzk=;
	b=GDRg9ws3UVT2sUua2Xbx1eq8EnaiYjbEONvaCJkPfma4jlSaH2CPBoDyA2GnNfZtKSZPEhNpDYgkn09IfzwMEolJt0ZKI3dYjJXsSZJGGZs78VczTlF208bPkJMNph00tAaUWIFGDWBAwchg5p2TB35+aGJKkQZpd9dgkfPsWmQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7OsRbZ_1716882748;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7OsRbZ_1716882748)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 15:52:29 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net 1/2] virtio_net: rename ret to err
Date: Tue, 28 May 2024 15:52:25 +0800
Message-Id: <20240528075226.94255-2-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240528075226.94255-1-hengqi@linux.alibaba.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The integer variable 'ret', denoting the return code, is mismatched with
the boolean return type of virtnet_send_command_reply(); hence, it is
renamed to 'err'.

The usage of 'ret' is deferred to the next patch.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..6b0512a628e0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2686,7 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 {
 	struct scatterlist *sgs[5], hdr, stat;
 	u32 out_num = 0, tmp, in_num = 0;
-	int ret;
+	int err;
 
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
@@ -2710,10 +2710,10 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 		sgs[out_num + in_num++] = in;
 
 	BUG_ON(out_num + in_num > ARRAY_SIZE(sgs));
-	ret = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
-	if (ret < 0) {
+	err = virtqueue_add_sgs(vi->cvq, sgs, out_num, in_num, vi, GFP_ATOMIC);
+	if (err < 0) {
 		dev_warn(&vi->vdev->dev,
-			 "Failed to add sgs for command vq: %d\n.", ret);
+			 "Failed to add sgs for command vq: %d\n.", err);
 		mutex_unlock(&vi->cvq_lock);
 		return false;
 	}
-- 
2.32.0.3.g01195cf9f


