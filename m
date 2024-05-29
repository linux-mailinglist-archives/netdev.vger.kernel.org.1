Return-Path: <netdev+bounces-99122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F42F8D3C37
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F081F22257
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D011836E0;
	Wed, 29 May 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn325voV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BB1836DA
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999931; cv=none; b=tvcHGc9I/kBaSrIqnhS9Y+tI5vvg1fwvQxdx+1ggjZ+rDv5AFl9BwOLh4gA+XxXFVSRMYcjSUmhowxXLUYqTRs3QlI+bTTjmlYOJcNcmqnIfrceopBhG4+YMamr7uB8/Oan/3tWV6IQGxvxLYjD1ss92AzHnCJMY8k6AeYh4dYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999931; c=relaxed/simple;
	bh=IPjYoECZ6Pg4IPao1wBYJDCRPpAVXaGolknuEMngxTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J2Aq5Y/vXu5H9XbHqGIoKVdbAA9FOjKxVj5Vq4SDUzkz0yihw8MzoeQVMpShiACvLCYBAgUk7EcE/ucT5asVQdOBGktMhttpnUxe4lkdB/F2511Oq428MVsSxAkClvhWYq0Kobl+4/nCi0hwugxeuGlOqYvbuhvU8one9GhRCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn325voV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E002C113CC;
	Wed, 29 May 2024 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716999930;
	bh=IPjYoECZ6Pg4IPao1wBYJDCRPpAVXaGolknuEMngxTM=;
	h=From:To:Cc:Subject:Date:From;
	b=Dn325voVzvst+2oU8IHZt771z2y4nve2LXuldsUjTy1gtJ2H5Me+AGclDO2MoI9sd
	 v59FjCd2ssePRR4E01upkKD0jm1dBpnIntdFq8UxprKL40TfmSOI3yz007g0Ex0Ybs
	 7ItMNl0dzWGN38nd3HtxhnN5YCvV8jW0nfBeYYHTh1D3uNeWfOiMJ5f7LRtoUjdjvr
	 66polln6PQ4bInM3DrBTssdiA4b20OxTEHjR58eP2whe/PMhL9WJGx9UjM4sMilY14
	 hESLqqqYCVQRrDldbrpTqtnN+tCZaX5Zms9zg/IpmK3R5UnpM3xo+DJbCoVv/c2wj6
	 YOrnHtLRri2XA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next] net: count drops due to missing qdisc as dev->tx_drops
Date: Wed, 29 May 2024 09:25:27 -0700
Message-ID: <20240529162527.3688979-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Catching and debugging missing qdiscs is pretty tricky. When qdisc
is deleted we replace it with a noop qdisc, which silently drops
all the packets. Since the noop qdisc has a single static instance
we can't count drops at the qdisc level. Count them as dev->tx_drops.

  ip netns add red
  ip link add type veth peer netns red
  ip            link set dev veth0 up
  ip -netns red link set dev veth0 up
  ip            a a dev veth0 10.0.0.1/24
  ip -netns red a a dev veth0 10.0.0.2/24
  ping -c 2 10.0.0.2
  #  2 packets transmitted, 2 received, 0% packet loss, time 1031ms
  ip -s link show dev veth0
  #  TX:  bytes packets errors dropped carrier collsns
  #        1314      17      0       0       0       0

  tc qdisc replace dev veth0 root handle 1234: mq
  tc qdisc replace dev veth0 parent 1234:1 pfifo
  tc qdisc del dev veth0 parent 1234:1
  ping -c 2 10.0.0.2
  #  2 packets transmitted, 0 received, 100% packet loss, time 1034ms
  ip -s link show dev veth0
  #  TX:  bytes packets errors dropped carrier collsns
  #        1314      17      0       3       0       0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 net/sched/sch_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 2a637a17061b..1417f1991452 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -633,6 +633,7 @@ EXPORT_SYMBOL_GPL(netif_carrier_event);
 static int noop_enqueue(struct sk_buff *skb, struct Qdisc *qdisc,
 			struct sk_buff **to_free)
 {
+	dev_core_stats_tx_dropped_inc(skb->dev);
 	__qdisc_drop(skb, to_free);
 	return NET_XMIT_CN;
 }
-- 
2.45.1


