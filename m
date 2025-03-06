Return-Path: <netdev+bounces-172420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E0AA5486C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4378189548C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4C0202984;
	Thu,  6 Mar 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtsVXzx3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F853BE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258362; cv=none; b=g7n3Wmhf4R/0Fghj27YqRdefMFJXnq1DFNgNs0MfA0n6qt8gsosxQvUKNvIouPq3QogIewmuNuIIskQy25FUa+U5bONfV1zD/ox+kZ/iUknM3fJwishNUyMVY4RYFsUmdopHU+IDlYO3/TbEdh+q/pG52CLST30kapurQGwjdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258362; c=relaxed/simple;
	bh=4wBmKoamW4VIKq3KNVffFzcXkM+UWTMyMnJddbkt4JA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JSLTWMMWCu73NsvR/l0yZqTIBfVEdLpFf47FfQ0BpcsMjRwa6QAb2nlzG3zY2SWIswpyWy5bijk4OmhDtJPbk2v4XcSkoWukjsuS9sqCdLPn79ykp33OqILUUjiH0YwHyEUZXRAz+SMFVWz8EekCYudlVrjCS8M4njn6d6tK+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtsVXzx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45820C4CEE0;
	Thu,  6 Mar 2025 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258361;
	bh=4wBmKoamW4VIKq3KNVffFzcXkM+UWTMyMnJddbkt4JA=;
	h=From:Date:Subject:To:Cc:From;
	b=GtsVXzx3rFKfpmZF9MGnZUCjhbtnI9UwV4URFGF5lNpc6E+fCQJ6PTCinjZN+nwco
	 EKHXQf0WLgByJV3CKrc+f91wnhjkYp5UdQUTIQA9UFpAHw5cQmYq/Hmm2ZVqWNpwAF
	 ONM9O2nFfMta20nqVt23u5/oO1DyXq7YD3ht+2Ogt/5+JOUVo2RL4eQFrdqyOpjqFj
	 +8oYo72DdD2eXheGySeEmkbKSUEuSGY1UEM0hTclC71UhTP6Gl8CQCbysXdA9VXbT+
	 fduGvjwpg4aXvAxZ1wzPJv3QwVGpckUGiwAFB9tkCYGBagdfQG4j9fVLBbgSqArL9p
	 vRwzoWyU+82CQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 06 Mar 2025 11:52:20 +0100
Subject: [PATCH net-next] net: airoha: Fix dev->dsa_ptr check in
 airoha_get_dsa_tag()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-airoha-flowtable-fixes-v1-1-68d3c1296cdd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGR+yWcC/x3LSwqAMAwA0atI1gbait+riIuoqQbESisqFO9uc
 fkYJkJgLxygyyJ4viSI2xN0nsG00r4wypwMRplSFapCEu9WQru5+6RxY7TycEBqNWtT12q2DaT
 58PyH9PbD+371RMV2aAAAAA==
X-Change-ID: 20250306-airoha-flowtable-fixes-a91e12770df8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix the following warning reported by Smatch static checker in
airoha_get_dsa_tag routine:

drivers/net/ethernet/airoha/airoha_eth.c:1722 airoha_get_dsa_tag()
warn: 'dp' isn't an ERR_PTR

dev->dsa_ptr can't be set to an error pointer, it can just be NULL.
Remove this check since it is already performed in netdev_uses_dsa().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/Z8l3E0lGOcrel07C@lore-desk/T/#m54adc113fcdd8c5e6c5f65ffd60d8e8b1d483d90
Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ff837168845d6cacf97708b8b9462829162407bd..021e64d29183418b669e364985e785615b05ab66 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1711,18 +1711,13 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 {
 #if IS_ENABLED(CONFIG_NET_DSA)
 	struct ethhdr *ehdr;
-	struct dsa_port *dp;
 	u8 xmit_tpid;
 	u16 tag;
 
 	if (!netdev_uses_dsa(dev))
 		return 0;
 
-	dp = dev->dsa_ptr;
-	if (IS_ERR(dp))
-		return 0;
-
-	if (dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
+	if (dev->dsa_ptr->tag_ops->proto != DSA_TAG_PROTO_MTK)
 		return 0;
 
 	if (skb_cow_head(skb, 0))

---
base-commit: f130a0cc1b4ff1ef28a307428d40436032e2b66e
change-id: 20250306-airoha-flowtable-fixes-a91e12770df8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


