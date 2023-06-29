Return-Path: <netdev+bounces-14645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D96742CC8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720C1280C46
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40715486;
	Thu, 29 Jun 2023 19:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820515495
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68917C433C9;
	Thu, 29 Jun 2023 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688065311;
	bh=IHOl7DVaJ5zd4yNvVL82z0xO/mASETxZTPOpk7yUvNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfP6mynT7aplOltW3BYySiKf6BCNChYSZD3b2vUQX3qOFysv6tqwu7u9TZ85zJOIh
	 1RAonazK7BeVEwpTGTQrQ4vnkZL+pNKbUxK1k6dmDp5seTKS59zre5hWJJoA0sOH84
	 lJqcBmjdmwrZAxnZcP/I2pQaD9VoAXPcT8L6DbKlXh62hQwx9B+u70HK9v39uVKTpy
	 bzhQCIjP4YwNi2ozLakLVo3xSQtnlvDLMmgvELmnxYd57pVKGy6JdB87KbyjF0UVCO
	 oIQiOIVLbkGSmt1fxMiTAytFHOXR8NswOGJNeyNQe4vVqNWGU3w6hVeSD14Sp6BNrT
	 t8Uj8YH3phaTA==
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
Subject: [PATCH AUTOSEL 6.1 10/12] netfilter: nf_tables: disallow timeout for anonymous sets
Date: Thu, 29 Jun 2023 15:01:30 -0400
Message-Id: <20230629190134.907949-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190134.907949-1-sashal@kernel.org>
References: <20230629190134.907949-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
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
index 13d4913266b4d..564935a12bfcc 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4588,6 +4588,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (!(flags & NFT_SET_TIMEOUT))
 			return -EINVAL;
 
+		if (flags & NFT_SET_ANONYMOUS)
+			return -EOPNOTSUPP;
+
 		err = nf_msecs_to_jiffies64(nla[NFTA_SET_TIMEOUT], &desc.timeout);
 		if (err)
 			return err;
@@ -4596,6 +4599,10 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
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


