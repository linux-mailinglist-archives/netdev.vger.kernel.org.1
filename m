Return-Path: <netdev+bounces-107532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28291B5BD
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 06:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C436E1F22A1F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 04:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A1224CC;
	Fri, 28 Jun 2024 04:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vRKf7xtV"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B6822339
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 04:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719549624; cv=none; b=QoBNmSE0BqeLHEqQQdp9TgTPlDvd46+PQqAnqK/4nCKhNL+zGTkVylZAQMJ+/n9iisN9fGxuodeTvv6MYYcRWZ8uSScMDyTUiaQnoVaF0WXzwofi739js5VzRpLGkG2s0iKh4zH1TC3xkETaIywVq6jrtoyEYIJSZWVc4qnlsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719549624; c=relaxed/simple;
	bh=OQm1lQsLxgD/2WMMUztScoEwsMvA0CpYZa4MWPM2SdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWORIi8d+uoPOuAASkpiB847PJ5K4+EkE5lmTSlVD9+4WMkV3M7YfVQwWWkJNfgxvn+1wRp3b8fQOHcyhCuu52dVgfVnHz/biPyy8JCft+3IEith5lgJjWs6nbxQrY2KLx+CHPC/6T8teqeOeGG7sUrfdoz5Km9vFdNwbKAh5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vRKf7xtV; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719549619; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=bBzfghZdoues1oIVA9d4rstypECEb4Xh2DfyhJIUWCA=;
	b=vRKf7xtVTTTH4L0XHYPlSYePc5MImj6eJhhVKLgg2MuTsbYQ4wgRx73gAVY7u4ojcnyHeh6kRBUGIg0iFtaVHvLMVvBKPvCrXXZ3oEoP1BLE+81deYUVHQPNbtoIUY+1BRjrpXyGV4N4pHD5TSk7+D+kKg5BGyg8Zog/2Gz+lw4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9P4Y28_1719549618;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W9P4Y28_1719549618)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 12:40:19 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
Subject: [PATCH RESEND net-next] net: ethtool: Fix the panic caused by dev being null when dumping coalesce
Date: Fri, 28 Jun 2024 12:40:18 +0800
Message-Id: <20240628044018.73885-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a general protection fault caused by a null pointer
dereference in coalesce_fill_reply(). The issue occurs when req_base->dev
is null, leading to an invalid memory access.

This panic occurs if dumping coalesce when no device name is specified.

Fixes: f750dfe825b9 ("ethtool: provide customized dim profile management")
Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e77327e34cdc8c36b7d3
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
This fix patch is re-sent to next branch instead of net branch
because the target commit is in the next branch.

 net/ethtool/coalesce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 759b16e3d134..3e18ca1ccc5e 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -211,9 +211,9 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 {
 	const struct coalesce_reply_data *data = COALESCE_REPDATA(reply_base);
 	const struct kernel_ethtool_coalesce *kcoal = &data->kernel_coalesce;
-	struct dim_irq_moder *moder = req_base->dev->irq_moder;
 	const struct ethtool_coalesce *coal = &data->coalesce;
 	u32 supported = data->supported_params;
+	struct dim_irq_moder *moder;
 	int ret = 0;
 
 	if (coalesce_put_u32(skb, ETHTOOL_A_COALESCE_RX_USECS,
@@ -272,9 +272,10 @@ static int coalesce_fill_reply(struct sk_buff *skb,
 			     kcoal->tx_aggr_time_usecs, supported))
 		return -EMSGSIZE;
 
-	if (!moder)
+	if (!req_base->dev || !req_base->dev->irq_moder)
 		return 0;
 
+	moder = req_base->dev->irq_moder;
 	rcu_read_lock();
 	if (moder->profile_flags & DIM_PROFILE_RX) {
 		ret = coalesce_put_profile(skb, ETHTOOL_A_COALESCE_RX_PROFILE,
-- 
2.32.0.3.g01195cf9f


