Return-Path: <netdev+bounces-111647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D12C931EB2
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 04:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB9D1C20E85
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2AF63AE;
	Tue, 16 Jul 2024 02:16:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515811723;
	Tue, 16 Jul 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721096173; cv=none; b=XcGLgUrqppC9hxKFugnE5FPtXLp5AS8/rvPOXus01tH8ZMijLL8yHZmsASdLiR4wgJjm5HDn1bqiTD5SggbmoSWmIaAnwzSvaZxt5E9Se0/afe8UigouskItMGYQycnC4bMqpEdDiMDwcIroy5MHfgm/H7x254+vTLKuIsj/TyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721096173; c=relaxed/simple;
	bh=JRNqMFdxO5c2iVlkX2j6tqUBK7s+kP8+tw4YAUTIdjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qGGZkDab1vd5L4nFJh8UJaXFNWCPbyvFR0zxvNfeb7UDgcd8SWvmkpLTC0dF//aH+ToC8pmQVKWjBwYZe7krzdZWTvyKBbBIExHucI31sDw+yArVdVV4I5FjVD1Q84Inq6OX5wNXdfon6U0H5p1o7MGDv1AqIeYTO5XJOtYMO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHz+fV15Vm6I6LAw--.50509S2;
	Tue, 16 Jul 2024 10:15:56 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	johannes.berg@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] ipv6: prevent possible NULL dereference in ndisc_recv_na()
Date: Tue, 16 Jul 2024 10:15:48 +0800
Message-Id: <20240716021548.339364-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHz+fV15Vm6I6LAw--.50509S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1fZFWkuw4DGr4xGr1UGFg_yoW3trgEk3
	WqyryUCF1xXw1Fy3y7AF43AFWkA34UAF1rZry2qr97J34UKwsavr4kKr9Yyry7uFW7Wr98
	Awn7KFy3J3y7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQZ2
	3UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In ndisc_recv_na(), __in6_dev_get() could return NULL, which is a NULL
pointer dereference. Add a check to prevent bailing out.

Fixes: 7a02bf892d8f ("ipv6: add option to drop unsolicited neighbor advertisements")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 net/ipv6/ndisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d914b23256ce..f7cafff3f6a9 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1000,6 +1000,8 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	struct ndisc_options ndopts;
 	struct net_device *dev = skb->dev;
 	struct inet6_dev *idev = __in6_dev_get(dev);
+	if (!idev)
+		return SKP_DROP_REASON_NOT_SPECIFIED;
 	struct inet6_ifaddr *ifp;
 	struct neighbour *neigh;
 	SKB_DR(reason);
-- 
2.25.1


