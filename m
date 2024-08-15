Return-Path: <netdev+bounces-118846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36A952FE1
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A1E1F2143D
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD3019DF9E;
	Thu, 15 Aug 2024 13:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E471714AE;
	Thu, 15 Aug 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729023; cv=none; b=PKSxDEKvG0XIzrA+VaWDyk2M5mzswpv/UoGv3EizPUx5jZnTW8cF4E6UjsGmKkuDRujpXsTHzcwJ5YNE+hwA4vHuOB8BGPgtUTau9SusvcyUsNuvGxCEoFLJ7DehMarwgqEC6AHhHVHw8wz5GtGbd77lNkyDVSc24tJV9OLidFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729023; c=relaxed/simple;
	bh=tq7t/is/d+c/coOXCCU7VrTmWNejKvA/lI1Oeh8yr2E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=irURVkdDcg2rTlyHwLtz6K4/xPwj+HUo+6QrD2xsLWuqLq/Q70509RMuVCTeplTzKeP9l/lt2UoRaWwT+LEh5UKsHL4zxEaSqSHTp8m5VI7WzuYSQuFWPJ1+uXQweGBTrbmS09mMat5dpS+66mLnlP90g4GptS+V3X4mig5NN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wl5hX3dGKzDqW9;
	Thu, 15 Aug 2024 21:34:52 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (unknown [7.185.36.76])
	by mail.maildlp.com (Postfix) with ESMTPS id 43D7618006C;
	Thu, 15 Aug 2024 21:36:50 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 dggpeml500006.china.huawei.com (7.185.36.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 21:36:49 +0800
From: Zhang Changzhong <zhangchangzhong@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Zhang Changzhong <zhangchangzhong@huawei.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: remove redundant check in skb_shift()
Date: Thu, 15 Aug 2024 22:09:42 +0800
Message-ID: <1723730983-22912-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500006.china.huawei.com (7.185.36.76)

The check for '!to' is redundant here, since skb_can_coalesce() already
contains this check.

Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 net/core/skbuff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8..f915234 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4169,8 +4169,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	/* Actual merge is delayed until the point when we know we can
 	 * commit all, so that we don't have to undo partial changes
 	 */
-	if (!to ||
-	    !skb_can_coalesce(tgt, to, skb_frag_page(fragfrom),
+	if (!skb_can_coalesce(tgt, to, skb_frag_page(fragfrom),
 			      skb_frag_off(fragfrom))) {
 		merge = -1;
 	} else {
-- 
2.9.5


