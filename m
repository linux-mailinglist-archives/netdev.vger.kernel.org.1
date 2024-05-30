Return-Path: <netdev+bounces-99274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416C8D4441
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE7A1F22F8F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18162139CE9;
	Thu, 30 May 2024 03:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ovf3pRF0"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A8139CE3
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717040510; cv=none; b=XolhgVMcamWFm8uF0XM+1uf7vwcG6jHnUgxCmPtFcn/vVvduXort1dRZGKlc4xja7tWYFjELBFGqktLhuCRSES8Z85f6lSRwJ/a9B7rgoMZqSCJcLA5kcqLVCeFzyUYjQOLw9vBi3ruEfqHE+fGzTxLx0HPwJCpSqTeQP+d2vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717040510; c=relaxed/simple;
	bh=d5IYyCOrENFZuQLW4i8/kTfbF8Kihrp2FFXSsobY8S4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oVgtYlzv81A3aopRwKRzDE8vGyU78if87WitkpRp/19M0xK9r7ydOOwKHo9of4rS0bPSzMcCNspmyplRWwlOTmm2lj8TLHb00W1ArIAS+VK950+SYo/IJZpGGEV3HRHmrC3SokG66mx7IIocrLtcJ4Ln6A6sYmDzAkCR2WES8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ovf3pRF0; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717040504; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ubSNF7pPhU/p0V/lXsQM6gqp6+odk35S45rtnYfCj5A=;
	b=ovf3pRF0OqFamAN3E/lGzklhmFgyS75tnp/lmzAbhRF2/Dc+QNYVRf/9Z1GvdAUVi8SBarYwX6rBMP0E7zqjR+lLNyu82HVBDG8u+Yy/LkaCmGxM/w7q0ESuo378sdQ/0Ec3cIB4CN9GYttjLL5Bm4R06TodunToh/46EneE9Nk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7VdGrC_1717040503;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7VdGrC_1717040503)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 11:41:44 +0800
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
	Daniel Jurgens <danielj@nvidia.com>,
	Hariprasad Kelam <hkelam@marvell.com>
Subject: [PATCH net v2] virtio_net: fix missing lock protection on control_buf access
Date: Thu, 30 May 2024 11:41:43 +0800
Message-Id: <20240530034143.19579-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactored the handling of control_buf to be within the cvq_lock
critical section, mitigating race conditions between reading device
responses and new command submissions.

Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com>
---
v1->v2:
  - Use the ok instead of ret.

 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..1ea8e6a24286 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 {
 	struct scatterlist *sgs[5], hdr, stat;
 	u32 out_num = 0, tmp, in_num = 0;
+	bool ok;
 	int ret;
 
 	/* Caller should know better */
@@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	}
 
 unlock:
+	ok = vi->ctrl->status == VIRTIO_NET_OK;
 	mutex_unlock(&vi->cvq_lock);
-	return vi->ctrl->status == VIRTIO_NET_OK;
+	return ok;
 }
 
 static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
-- 
2.32.0.3.g01195cf9f


