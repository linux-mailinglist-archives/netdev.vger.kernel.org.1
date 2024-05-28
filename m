Return-Path: <netdev+bounces-98416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F48D158C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90337281411
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D9770F9;
	Tue, 28 May 2024 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WTNi3KVM"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4874424
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716882761; cv=none; b=MB0Aqgxnd7uB+wYyX0woEzOCoBVi373MeAf7po/fl+t8zRtYj6KGh7OrX2xM/srOWpXO7grofH3mcN5LLP7ZbP2zx0mWKbvnhm/uXHrgbvLilxslqvHyiuED9ki90vopc9j2Jhg3YCb2Dg/t0JUUvTNYHP2q1X/wYxVaPwq7+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716882761; c=relaxed/simple;
	bh=MVeOCp1eOAx/0XTSeLRydwTDlUF4aqpYkuUWaZcOeb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewHywDj4kRha2OXraCbeA2hPPDrTVGBJc5+1ukxaBS9NcQ7hJ+L4f0WF8hywPHUpXkIqpGPROlOJMvvp3DbltGElZ006eRmFFHR+gyVd6KTkX6xKfXI8u+NKrYoqBuCIK66LX872/TezdXkFpTbHoROW4SgBx2+VXpCH3bt2goo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WTNi3KVM; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716882751; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gyTS35yXfP4O3KiWeOE7WQ81O2elpED7DfkLuUKlI5k=;
	b=WTNi3KVM6wHmXUHJA5blVA/eIRtcQ4yJbo1SGDzSdZ5H6U1NSeM7tzKiYv3ACOfmeJxHP6jEhNdjX6kOFIP9sYV4cXg+eWndGoFKlawe3KWL8TAZQ8yTF8TBs+FwDHzcNMLXNKM+4iYhJo6eW0bEW3u7lIL+/PZzWBmryeOwwS4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7Ospqd_1716882749;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7Ospqd_1716882749)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 15:52:30 +0800
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
Subject: [PATCH net 2/2] virtio_net: fix missing lock protection on control_buf access
Date: Tue, 28 May 2024 15:52:26 +0800
Message-Id: <20240528075226.94255-3-hengqi@linux.alibaba.com>
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

Refactored the handling of control_buf to be within the cvq_lock
critical section, mitigating race conditions between reading device
responses and new command submissions.

Fixes: 6f45ab3e0409 ("virtio_net: Add a lock for the command VQ.")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6b0512a628e0..3d8407d9e3d2 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2686,6 +2686,7 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 {
 	struct scatterlist *sgs[5], hdr, stat;
 	u32 out_num = 0, tmp, in_num = 0;
+	bool ret;
 	int err;
 
 	/* Caller should know better */
@@ -2731,8 +2732,9 @@ static bool virtnet_send_command_reply(struct virtnet_info *vi, u8 class, u8 cmd
 	}
 
 unlock:
+	ret = vi->ctrl->status == VIRTIO_NET_OK;
 	mutex_unlock(&vi->cvq_lock);
-	return vi->ctrl->status == VIRTIO_NET_OK;
+	return ret;
 }
 
 static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
-- 
2.32.0.3.g01195cf9f


