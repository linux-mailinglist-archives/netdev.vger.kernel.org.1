Return-Path: <netdev+bounces-203650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F379AAF69C1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 07:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC076487381
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 05:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413A28F92E;
	Thu,  3 Jul 2025 05:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42541C07F6;
	Thu,  3 Jul 2025 05:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520537; cv=none; b=Ktv8hlWZedx6nGoDAS4wZMx5H8JaFxyFbq78Qj4k38oTuqbSKm87pMkG0W8rygaH+MMG26RcYYoYg1VPVF4APxmR7LF7M9f6etzDUT75zCqJMPcJYn43gc6ODS2To/hZ/UEHgGciIUJQsqExOj9Rm9I3MFstAn6ESPs0UoT7LNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520537; c=relaxed/simple;
	bh=xXjg+mMtePg8ixC8zfpL06ib7Pt5Av0xiipOlmFlMmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7O+OxUMYhoPcD+81Pa30xT9v1RqX3FR7k1i+Er/rKK0kYDxnfqM+n4pPLE0rQl6XAt9TgwjtlprXAp9bCrFcrKwf+6Z1N02TCWkzbYin0FHNsWmrIHfLcIm5UNHqS+KH1EYL1oQy6CLLQs5p5jpbNwZobg0L9toU1ibUQSgC14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.197.243.13])
	by mtasvr (Coremail) with SMTP id _____wD3ZiwNFWZo2DzaAw--.9240S3;
	Thu, 03 Jul 2025 13:28:45 +0800 (CST)
Received: from localhost (unknown [115.197.243.13])
	by mail-app2 (Coremail) with SMTP id zC_KCgAnGIAMFWZoPLtZAA--.10948S2;
	Thu, 03 Jul 2025 13:28:45 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: davem@davemloft.net,
	kuba@kernel.org,
	linma@zju.edu.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: stable@kernel.org
Subject: [PATCH v1 2/2] appletalk: Fix type confusion in handle_ip_over_ddp
Date: Thu,  3 Jul 2025 13:28:37 +0800
Message-Id: <20250703052837.15458-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAnGIAMFWZoPLtZAA--.10948S2
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?4GeRVgXKKxbFmtjJiESix3B1w3tPqcowV1L23Bze5QtIr9Db75bEBiiEybVhThS0pI
	APHuzd9MjVyyPJ6TZADBymyvbsvqc/VSH5eqB8r7G4h2xJViVvYU3nEJt6lpmy7wnJutiH
	yVTGVaZNpjEjEL/klx6E69bPlRaDnS6o/Is3qDBX
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw4xGryUZr1kZFyxtF47Awc_yoWDCFXE9F
	W0yrZ3Ww48JFn2vw47Can5Ar1ftr1jqFyrXr1xtFWxJ3W5Aa9Yqr1FyFWxZF15W3yruFZ8
	JFn0grs5Kr1xCosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbskYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjxU7nNVDUUUU

This code uses "ipddp0" calling __dev_get_by_name(), believing it must
return device created in ipddp_init() function, ignoring the fact that a
malicious user could hijack the interface name.

Fortunately, the upstream kernel already removed the code via commit
85605fb694f0 ("appletalk: remove special handling code for ipddp"). This
fix should be applied to other stable versions.

Cc: stable@kernel.org
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 net/appletalk/ddp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 8daa3a1bfa4c..9ecf90102d62 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1296,7 +1296,7 @@ static int handle_ip_over_ddp(struct sk_buff *skb)
 	struct net_device_stats *stats;
 
 	/* This needs to be able to handle ipddp"N" devices */
-	if (!dev) {
+	if (!dev || dev->type != ARPHRD_IPDDP) {
 		kfree_skb(skb);
 		return NET_RX_DROP;
 	}
-- 
2.17.1


