Return-Path: <netdev+bounces-174924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A5EA61564
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D467416B17C
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 15:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6E120299D;
	Fri, 14 Mar 2025 15:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F35202994;
	Fri, 14 Mar 2025 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967605; cv=none; b=tOwywzhWEamS/tIP/Oubmh6k9uTyZKySg9X3/wn+cJe1n6aRIM67CmDHL1G78NSz1Az1pGCg32MritC39fLSGb8Cg5ZxESiBh27SDH5O2SklA8D4w9nmKQ8YTYti86jbEjin8nyAbFxLxVy5zNsuB+NZzi2MRGfsvviGlWQosNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967605; c=relaxed/simple;
	bh=fvneh1mx/Xz9eGv7D2eQ3GuC3fZef5sZPQDOo870RWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ir26Y9C7CZ1hz+n//AonUsIxVfuiNIJtU+cgqJmtzkBfZsAVP2aJssngznflcmaAvXuYFKVl6SKuO0UuFzDxUMuhngYw8NM7h6cFYQ9+eZYgGk7U0ShWFdWPW0jQ9/p8MnL74pgvDP5Qb/DvFvJ9IjD8mNM7BT7LAaDShNLi5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.193.170.58])
	by mtasvr (Coremail) with SMTP id _____wCXIgzRUNRnXP4dAA--.4062S3;
	Fri, 14 Mar 2025 23:52:50 +0800 (CST)
Received: from localhost (unknown [10.193.170.58])
	by mail-app3 (Coremail) with SMTP id zS_KCgAXw3XQUNRng8sbAA--.17349S2;
	Fri, 14 Mar 2025 23:52:48 +0800 (CST)
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
Subject: [PATCH net] net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES
Date: Fri, 14 Mar 2025 23:52:37 +0800
Message-Id: <20250314155237.81071-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAXw3XQUNRng8sbAA--.17349S2
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?GMRYGQXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHkyPSxI2Xdeyd3ul0ToYuuZO1uQ+Mstj4wZgJ07zDHSgsNdaMO3dDVqVxik8BiDZC3sl
	TXsMkWY9Kjq6shOMukuVKUjJTMQVRzgKF9lnMIMw
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFyftr17GF1xWFy5CF4rWFX_yoWkGFXEgw
	13ZFnak3W5GF1I93WrZwsayFn5Xw18Ka4rAFyIgF9rAa4DJw1Svr18XFZrGFZrCr4UWFn8
	Ar1xWF1UCFs8tosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbTkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x0EwI
	xGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jj7KsUUUUU=

Previous commit 8b5c171bb3dc ("neigh: new unresolved queue limits")
introduces new netlink attribute NDTPA_QUEUE_LENBYTES to represent
approximative value for deprecated QUEUE_LEN. However, it forgot to add
the associated nla_policy in nl_ntbl_parm_policy array. Fix it with one
simple NLA_U32 type policy.

Fixes: 8b5c171bb3dc ("neigh: new unresolved queue limits")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
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
+	[NDTPA_QUEUE_LENBYTES]	= { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
-- 
2.39.0


