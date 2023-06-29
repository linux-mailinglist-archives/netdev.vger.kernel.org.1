Return-Path: <netdev+bounces-14649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D38742CE6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9272C1C20BB2
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEB714A89;
	Thu, 29 Jun 2023 19:02:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7116405
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2BAC43397;
	Thu, 29 Jun 2023 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065323;
	bh=2HSM9jt94Ioc5k2cDaysedSQk9sOrAH9Flmss0JUBKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSUN/DwP3L+Fk10FVtCGMrM2CtXwPbBrckH4HHAzCiV2+mXDfrYJkywqiuKE0JuGO
	 pwtZkthrrHsTidkBuOqu8sd38R1IZ4GRDiYS+xkbjaUi9+JzklQbEKnNfthdOBuUP7
	 D7e4VLWksBsRDReBzB8CC9fADl6w6TMOBdjl81qAUHOHPXhgKSktjPC9RmqUr0vXXw
	 2NuOz8cVdwNbZzJ6rAcoNB7ZkjwJegyq2eV+BLQTuUbRi9y/TBs3FU/EVWoxhpVBEC
	 REbF7FT2obzWiQ4DB31gN1v2kBhzZRAFAR2BxERhac5D5j7K+Qc1RHbZ5GkLLOj8Q4
	 H7/2M5Flz8CBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/5] netfilter: nf_tables: disallow timeout for anonymous sets
Date: Thu, 29 Jun 2023 15:01:55 -0400
Message-Id: <20230629190158.908169-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190158.908169-1-sashal@kernel.org>
References: <20230629190158.908169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.118
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit e26d3009efda338f19016df4175f354a9bd0a4ab ]

Never used from userspace, disallow these parameters.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 35b9f74f0bc61..72f206b591a6a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4491,6 +4491,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
 
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_TIMEOUT], &desc.timeout);
 		if (err)
 			return err;
@@ -4499,6 +4502,10 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	if (nla[NFTA_SET_GC_INTERVAL] != NULL) {
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
+
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		desc.gc_int = ntohl(nla_get_be32(nla[NFTA_SET_GC_INTERVAL]));
 	}
 
-- 
2.39.2


