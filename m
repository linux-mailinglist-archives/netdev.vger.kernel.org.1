Return-Path: <netdev+bounces-80356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C887E802
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C363B21A70
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F006376EC;
	Mon, 18 Mar 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vQfvi6DF"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF531A83;
	Mon, 18 Mar 2024 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759979; cv=none; b=HowtuJtDAQYPdvQ8MEdl8wS3zQ/7C4/xjP9LOsdczSvbvAnu7V6MTJX9s0w0V0i4l+MqQMRS4XrXooaWpbPPQjFBDvjBpnVaDi17mRIR1iTCbGFADyDBPjcpZKwxAkVV7MDD1JmUFnpZKtZDDBWVL5fOGdXcumCYH5KfTjorNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759979; c=relaxed/simple;
	bh=6CQx/+xAUCEFNNWbsvBxnHQzcdNfNR8IFL8HVy+7I50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hVRYfohhjVns9wQSKAVJokot7WqT3zA704o2wV0oS05VFrL5+s0qPHzaDPb34h2qKqJRdeN/IXGB/l4lvglckEfnfeXlp4iA19B4HXpclJsr8r8We+O5jv55v/m5i9NmzdvIizcNo9HdL18AdvafmS+lZldXYdbOqBfmNsgOoTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vQfvi6DF; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710759968; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=g7AhWHIocOr3xD8BOnGmLvpategqK4NzZU7nuJWPaSo=;
	b=vQfvi6DFYU8khhWx46G1mNq0eOHgRPRX/9tYa2wMzDTjJksEoPlXIWHyv0/jjOPvqz+dFRr55VLGtpfqpAS16sSFMVF7bTaHbdwdwFSRBKhEu0sHXp4t37yPXXSzdAsAL5E4yF10f/uhi75qf5Wk57pW9mLE4j3Dk7ne6eh0yx0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2mza12_1710759966;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2mza12_1710759966)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 19:06:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 3/9] virtio_net: remove "_queue" from ethtool -S
Date: Mon, 18 Mar 2024 19:05:56 +0800
Message-Id: <20240318110602.37166-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 0059ee1bd6b4
Content-Transfer-Encoding: 8bit

The key size of ethtool -S is controlled by this macro.

ETH_GSTRING_LEN 32

That includes the \0 at the end. So the max length of the key name must
is 31. But the length of the prefix "rx_queue_0_" is 11. If the queue
num is larger than 10, the length of the prefix is 12. So the
key name max is 19. That is too short. We will introduce some keys
such as "gso_packets_coalesced". So we should change the prefix
to "rx0_".

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af512d85cd5b..8cb5bdd7ad91 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3273,13 +3273,13 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 	case ETH_SS_STATS:
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
+				ethtool_sprintf(&p, "rx%u_%s", i,
 						virtnet_rq_stats_desc[j].desc);
 		}
 
 		for (i = 0; i < vi->curr_queue_pairs; i++) {
 			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
-				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
+				ethtool_sprintf(&p, "tx%u_%s", i,
 						virtnet_sq_stats_desc[j].desc);
 		}
 		break;
-- 
2.32.0.3.g01195cf9f


