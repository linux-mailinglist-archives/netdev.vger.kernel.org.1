Return-Path: <netdev+bounces-106988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E49185E9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815001F213B8
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A392718C358;
	Wed, 26 Jun 2024 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="spa45wpe"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225F18C347
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719416072; cv=none; b=nDW8VLny3zYUV8i6ae5ur3vGrG3ueFQNCXOqtaJPPtPFC41Ce76+TVtFL6Fdw1dnIl2SkCM05q8eIJyth3iZTNb1dCfIoolRTxEbg4nlQnJ8MaFNmKA/kf6eliZTE2kZsJRPpkafGmuMuzgpNQIb1r2Qk0YlgafkxoNZYQXtmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719416072; c=relaxed/simple;
	bh=Sds+/XRrUC3rCdFDUi5xk8kzT1KcsK6N8NjteQozq7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKPPsrzYlbbQ9ZqurSGLpdZYTvLcD8EYIWdmjU7HABtUjSmsMfrfiUTtrNYAFP/mu29lix61MDNYsuoyD/rrvXZQVhqh0jcEYUBAXYl9/VuBgrJkCc5LKpVC2NO0MvdbwM2w6VgFuYWvNAJqkxjZ3+Md8rgOnm90nI5BbwHF34U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=spa45wpe; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719416062; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=llyO7GfseVLUfiq9yN0ifl2rjGE5OqqC1qNWNAoUGmE=;
	b=spa45wpehHdyccWa8jyKZYDfUOM+rQPZIUvVR1dUgt8c6n88PG6zE1Pi9ITKcWjW0RG47QVzkIt9ywVjf1FrBlbxKJEn/9upMtiXn81w3ugRqSITIZHUuQkHyD7VPAgoDNFX7+xXcnH2+4jlElgG38n5cVXj2QPqYQW0E2KyAOc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9Jv-AE_1719416061;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W9Jv-AE_1719416061)
          by smtp.aliyun-inc.com;
          Wed, 26 Jun 2024 23:34:22 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
Subject: [PATCH net] net: ethtool: Fix the panic caused by dev being null when dumping coalesce
Date: Wed, 26 Jun 2024 23:34:21 +0800
Message-Id: <20240626153421.102107-1-hengqi@linux.alibaba.com>
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
The problematic commit targeted by this fix may still be in the next branch.

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


