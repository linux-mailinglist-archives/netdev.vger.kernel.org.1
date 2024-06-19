Return-Path: <netdev+bounces-104947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 447A190F3E6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F0AB2319F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC87E155301;
	Wed, 19 Jun 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YXGOofeT"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6515253F
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813963; cv=none; b=ICiAUq2zrytEVeD/vd8ATgqm9/0DVaGamqJp+AaopTSGjwWgjjPIQkT9xQQFHrodbosZPt5DjUe0wxNNvuDxlo7TPMeUvffmlCcKnaJTm3hceZVqxaTRtwXsH8DlG4wQO6Peb/AeE50k4r2NBRrLJyAmCahGXSdjmt90wfYSV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813963; c=relaxed/simple;
	bh=H0wPUkKA0zpWUqJrsXS1wYKydUW5738e7/3qTUtPPuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bqs4p6kMeH5dJ0yF5rU81o6MCudDn44pE1cw4EDrlhFbdMg77EULcSqfjpHtuUMqg3xL7bSSK9VCjEs1B9op/HtkAjj8hlvEeQ8XhIhXqxdODi7w6dK+We8mb0TtVwkrcC8U0UUxLIq4sxqxvc5qUjFgBEsBMNx3A4AaLs0QuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YXGOofeT; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718813954; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nth99UAEiHeYJcFkVNJBhPlOnKEG+7hPVJACVVD5W88=;
	b=YXGOofeTnYQb/dBUC8CqE3Piom8paEQC5GhBINoGl9+w2w78pB6fSrPZDPjs3UeGkVY7npEEuqqdTEG+1fTyW1MnoncHJwwXTZsMr/OFpC1xn37/yTFzcjzh9KVMv6uTcPnD8ssedA1saohxqukfwlSfyFqusDXwIql1ztX07uk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W8om-3u_1718813952;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8om-3u_1718813952)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 00:19:13 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 4/5] virtio_net: refactor command sending and response handling
Date: Thu, 20 Jun 2024 00:19:07 +0800
Message-Id: <20240619161908.82348-5-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240619161908.82348-1-hengqi@linux.alibaba.com>
References: <20240619161908.82348-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the command handling logic by splitting
virtnet_send_command_reply into virtnet_add_command_reply
and virtnet_wait_command_response for better clarity and
subsequent use.

Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 53 ++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4256b1eda043..807724772bcf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2684,20 +2684,14 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 	return err;
 }
 
-/*
- * Send command via the control virtqueue and check status.  Commands
- * supported by the hypervisor, as indicated by feature bits, should
- * never fail unless improperly formatted.
- */
-static bool virtnet_send_command_reply(struct virtnet_info *vi,
-				       u8 class, u8 cmd,
-				       struct control_buf *ctrl,
-				       struct scatterlist *out,
-				       struct scatterlist *in)
+static bool virtnet_add_command_reply(struct virtnet_info *vi,
+				      u8 class, u8 cmd,
+				      struct control_buf *ctrl,
+				      struct scatterlist *out,
+				      struct scatterlist *in)
 {
 	struct scatterlist *sgs[5], hdr, stat;
-	u32 out_num = 0, tmp, in_num = 0;
-	bool ok;
+	u32 out_num = 0, in_num = 0;
 	int ret;
 
 	/* Caller should know better */
@@ -2731,18 +2725,47 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi,
 		return false;
 	}
 
-	if (unlikely(!virtqueue_kick(vi->cvq)))
-		goto unlock;
+	if (unlikely(!virtqueue_kick(vi->cvq))) {
+		mutex_unlock(&vi->cvq_lock);
+		return false;
+	}
+
+	return true;
+}
+
+static bool virtnet_wait_command_response(struct virtnet_info *vi,
+					  struct control_buf *ctrl)
+{
+	unsigned int tmp;
+	bool ok;
 
 	wait_for_completion(&ctrl->completion);
 	virtqueue_get_buf(vi->cvq, &tmp);
 
-unlock:
 	ok = ctrl->status == VIRTIO_NET_OK;
 	mutex_unlock(&vi->cvq_lock);
 	return ok;
 }
 
+/* Send command via the control virtqueue and check status. Commands
+ * supported by the hypervisor, as indicated by feature bits, should
+ * never fail unless improperly formatted.
+ */
+static bool virtnet_send_command_reply(struct virtnet_info *vi,
+				       u8 class, u8 cmd,
+				       struct control_buf *ctrl,
+				       struct scatterlist *out,
+				       struct scatterlist *in)
+{
+	bool ret;
+
+	ret = virtnet_add_command_reply(vi, class, cmd, ctrl, out, in);
+	if (!ret)
+		return ret;
+
+	return virtnet_wait_command_response(vi, ctrl);
+}
+
 static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 				 struct scatterlist *out)
 {
-- 
2.32.0.3.g01195cf9f


