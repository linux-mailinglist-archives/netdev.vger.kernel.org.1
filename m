Return-Path: <netdev+bounces-81021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6725C885887
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6754B1C21A8A
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C458AAB;
	Thu, 21 Mar 2024 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yaJrH0+m"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580858AB2
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021566; cv=none; b=VSj8/Yjvtz/e85PUMDp+W2Y+A0r60w0tjfkIg9NTGsipH9ElwLTYZgkco6kJ5aYdKSeNIM/iLsqhcoSZkH6arVTl8TYyVic8XptYAyQODiZ/K3ApO9YWmHoWTLR1udSGYPCroRZ5ZGTQuowk323wKiqORpkjxFcg2qm5LTZwGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021566; c=relaxed/simple;
	bh=y7vhwJDbfR/pyHv7tLrbktjX+2/gjAeaMv8Vh9VLBHQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=rrkKQb2t17d48hz+jLoYbELjhSH/NOBJJqUyW3WVfawmLfm+2pXLKRp0W/EzyxkPI/vYSEbhTO2FZhr9MJ7XuJ5FZc6NPJEvNFy75bTWQwP83MEwLBheTzwYqNsHAPIev2YMP8MJ/bat8mqcEEENX2caMpZtDPZkx7FOqcwoqws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yaJrH0+m; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711021560; h=From:To:Subject:Date:Message-Id;
	bh=snpPl9cVjbUVzPpVA4/bBW2CfSDJ+eDM49gIlo0FimA=;
	b=yaJrH0+mL6TBMgH5svdm8z/jHolB21+PwW3wHFMMfH0xchMXwhuYoL9Egz39eTqCe+aqtM8KpLSkEUqveRYoBkXtdmeAR5ys5ALnXjZzBrkoUJt2pJ6ALCt/ZwqE79rVgH3WCD0tyM6q/gZLu6iqdre2X6XVIgSHArQ1evgXUQw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3-aiJx_1711021558;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3-aiJx_1711021558)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 19:45:59 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH 1/2] virtio-net: fix possible dim status unrecoverable
Date: Thu, 21 Mar 2024 19:45:56 +0800
Message-Id: <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

When the dim worker is scheduled, if it fails to acquire the lock,
dim may not be able to return to the working state later.

For example, the following single queue scenario:
  1. The dim worker of rxq0 is scheduled, and the dim status is
     changed to DIM_APPLY_NEW_PROFILE;
  2. The ethtool command is holding rtnl lock;
  3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
     to acquire the lock and exits;

Then, even if net_dim is invoked again, it cannot work because the
state is not restored to DIM_START_MEASURE.

Fixes: 6208799553a8 ("virtio-net: support rx netdim")
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d111..0ebe322 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct dim_cq_moder update_moder;
 	int i, qnum, err;
 
-	if (!rtnl_trylock())
+	if (!rtnl_trylock()) {
+		schedule_work(&dim->work);
 		return;
+	}
 
 	/* Each rxq's work is queued by "net_dim()->schedule_work()"
 	 * in response to NAPI traffic changes. Note that dim->profile_ix
-- 
1.8.3.1


