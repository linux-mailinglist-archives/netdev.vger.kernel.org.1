Return-Path: <netdev+bounces-100041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048528D7A48
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 05:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7992CB20BBA
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 03:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0767AEAC2;
	Mon,  3 Jun 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d6kT8xAZ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B68F72;
	Mon,  3 Jun 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383632; cv=none; b=hzSXt9UhyCpzldcF5UOZeImYequO+niw2criMeoG3lufUWwZjdw9pwTQV71WibcmCywA2mKSXLsNLcv8C8XTE7grlYFJE287+6HddD3cxsvnkAwPWdeCxhUDuedsJn4D9kle112iLATtmK8kQ9I6Ln4qskyqewF1SdMinJP6f38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383632; c=relaxed/simple;
	bh=lugJqSJ1/XUwiPdotA8v7i7A6PAzS0bTvnu+1nr0uCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBKhjQbCPA6kKHagELsYfe1/tk4UOgyO7c64tajZr4NPmdL3F7V6o/YzfkNu997UU2EAHj9XSpg1Ld50nCJ2Hg68/VdrwxrELxL27t88uiJ6XRRHR8XiY7W4H8IOhrw6n6iy4SxW3/ELWjlKB74vAWWRaU1ljJuIeohiy12ACMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d6kT8xAZ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717383628; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=c8Qrefu5m5AiWDhNk1XblbhGEG6YihUTmhwULb3d7Ck=;
	b=d6kT8xAZmdam3huNTuqTvHIkBxpS+8xxIZgSt8fL1br02/0QFmiZd5rX0b00CXkX9BHsy/C/uLd/Muz/bVsSx5ZZjJbTi9IN2ZZxgJkYIDyz0vKU3vOIismp53PPbKDE8HhnlIYiohJ96WKuG0RqIssYDv8f+bttpqzOq2Evxk4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7gQbUV_1717383627;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7gQbUV_1717383627)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 11:00:27 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kgraul@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net/smc: change SMCR_RMBE_SIZES from 5 to 15
Date: Mon,  3 Jun 2024 11:00:19 +0800
Message-Id: <20240603030019.91346-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240603030019.91346-1-guangguan.wang@linux.alibaba.com>
References: <20240603030019.91346-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMCR_RMBE_SIZES is the upper boundary of SMC-R's snd_buf and rcv_buf.
The maximum bytes of snd_buf and rcv_buf can be calculated by 2^SMCR_
RMBE_SIZES * 16KB. SMCR_RMBE_SIZES = 5 means the upper boundary is 512KB.
TCP's snd_buf and rcv_buf max size is configured by net.ipv4.tcp_w/rmem[2]
whose default value is 4MB or 6MB, is much larger than SMC-R's upper
boundary.

In some scenarios, such as Recommendation System, the communication
pattern is mainly large size send/recv, where the size of snd_buf and
rcv_buf greatly affects performance. Due to the upper boundary
disadvantage, SMC-R performs poor than TCP in those scenarios. So it
is time to enlarge the upper boundary size of SMC-R's snd_buf and rcv_buf,
so that the SMC-R's snd_buf and rcv_buf can be configured to larger size
for performance gain in such scenarios.

The SMC-R rcv_buf's size will be transferred to peer by the field
rmbe_size in clc accept and confirm message. The length of the field
rmbe_size is four bits, which means the maximum value of SMCR_RMBE_SIZES
is 15. In case of frequently adjusting the value of SMCR_RMBE_SIZES
in different scenarios, set the value of SMCR_RMBE_SIZES to the maximum
value 15, which means the upper boundary of SMC-R's snd_buf and rcv_buf
is 512MB. As the real memory usage is determined by the value of
net.smc.w/rmem, not by the upper boundary, set the value of SMCR_RMBE_SIZES
to the maximum value has no side affects.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Co-developed-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index acca3b1a068f..3b95828d9976 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2006,7 +2006,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 }
 
 #define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
-#define SMCR_RMBE_SIZES		5 /* 0 -> 16KB, 1 -> 32KB, .. 5 -> 512KB */
+#define SMCR_RMBE_SIZES		15 /* 0 -> 16KB, 1 -> 32KB, .. 15 -> 512MB */
 
 /* convert the RMB size into the compressed notation (minimum 16K, see
  * SMCD/R_DMBE_SIZES.
-- 
2.24.3 (Apple Git-128)


