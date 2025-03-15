Return-Path: <netdev+bounces-175072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E492A6304C
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 17:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BFB189B213
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DE2036E3;
	Sat, 15 Mar 2025 16:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FB12F3B;
	Sat, 15 Mar 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742057522; cv=none; b=MIQvislGf+jflZjEnJZ6kVsubvNCkAAsc2ZVrsh0SElLMSHkYEdMjY1jU849+PR5VC2LrDoLj/mcFNxUcWiVntWPX79tlHwa1UOd7rCuesaYj7MuI9BsoX5qMnKPQIlq/qKkF8p/vLpzK+dnIASffCMsBO4fB9m2KSJCwX6+CuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742057522; c=relaxed/simple;
	bh=8T+np47owgnigutCHYOzKjuo3Ga5K1nLZb10k6JA44w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H2EU5SFlgdRB8m/eJ9XIZZ7NOJoAzTxgofCR70vZ3/kid76AT5K8eWWvVr/zTkeT4Pk5GWlWIitdztrfmPnZzIQGIJLapPDDhHAxU1zhBFVGq9sAV9JUiXIL2taid1o5eAKF6+qDPh301QWHTaMg9Jb/Q6Gv7eOnka1xFlC4vAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.193.170.58])
	by mtasvr (Coremail) with SMTP id _____wB3YQ8GsNVnxHspAA--.260S3;
	Sun, 16 Mar 2025 00:51:19 +0800 (CST)
Received: from localhost (unknown [10.193.170.58])
	by mail-app3 (Coremail) with SMTP id zS_KCgDHA3cGsNVnwdcnAA--.23963S2;
	Sun, 16 Mar 2025 00:51:18 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@amazon.com,
	gnaaman@drivenets.com,
	joel.granados@kernel.org,
	lizetao1@huawei.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net v2] net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES
Date: Sun, 16 Mar 2025 00:51:13 +0800
Message-Id: <20250315165113.37600-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgDHA3cGsNVnwdcnAA--.23963S2
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?ccMXkQXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHkyPSxI2Xdeyd3ul0ToYuubMXDNQRyrdFbJY3tTDqaw5woA2x6JcZHja/9e2zpiPcgL1
	dESBEk/L4HN0QWYZ4ES7IioAAjnOAt8rYZw12Biq
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFyftr17GF1xWFy5CF4rWFX_yoWkuwbEgw
	13ZFnak3W5GF1I93WrZwsayFn5Xw1UKas5JFyIgF9rAa4Dtwnavr18XrZrJFZrCr4UWFn8
	Ar1xGF1UCFs8tosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

Previous commit 8b5c171bb3dc ("neigh: new unresolved queue limits")
introduces new netlink attribute NDTPA_QUEUE_LENBYTES to represent
approximative value for deprecated QUEUE_LEN. However, it forgot to add
the associated nla_policy in nl_ntbl_parm_policy array. Fix it with one
simple NLA_U32 type policy.

Fixes: 8b5c171bb3dc ("neigh: new unresolved queue limits")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
v1 -> v2: add one extra tab as suggested by Kuniyuki <kuniyu@amazon.com>

 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index bd0251bd74a1..b4f89fbb59df 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2250,6 +2250,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
+	[NDTPA_QUEUE_LENBYTES]		= { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
-- 
2.39.0


