Return-Path: <netdev+bounces-45131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D218C7DAFEE
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 714471F21D19
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9A14F85;
	Sun, 29 Oct 2023 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqW1Hvee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C35154A9
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 23:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E08C433CC;
	Sun, 29 Oct 2023 23:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620469;
	bh=uEtJBRzg7Zr+VZEfWwug+VgiKu2cYuMf1hhXMXL/dkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqW1Hvee0vuqWBQsU6Zf+N7sCpKuFpjAFp2NIw6UPi0kI9u/RXizzvXlqmiGTXrCV
	 Ri9j3EIjUyKErRqLh0G6ZoUt2qailb1xjV2wt4J65mZ2ZfkhkREx6JqkMVcVdEBKmz
	 fXYuujW4k1VdNFECy4/PoQ9K7oVVIFpCag10Qf4blUCJMb3INjz7TRIVWEYtnqfOpG
	 wM/nPYryn8OtlloJ9EbjAB3YeHsm/2A9jJJO68E5pU69hMBVM0bj06Wru6EVi6rOw1
	 GFNSCXLeJku+ydeEKKZAV4WEF1XgmVlY/CJqVpYFG1g6t/5OvTeMASOL4LgkNEjwOu
	 z4aajbkiD0b3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	kernel test robot <lkp@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/13] netfilter: nfnetlink_log: silence bogus compiler warning
Date: Sun, 29 Oct 2023 19:00:39 -0400
Message-ID: <20231029230057.792930-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230057.792930-1-sashal@kernel.org>
References: <20231029230057.792930-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 2e1d175410972285333193837a4250a74cd472e6 ]

net/netfilter/nfnetlink_log.c:800:18: warning: variable 'ctinfo' is uninitialized

The warning is bogus, the variable is only used if ct is non-NULL and
always initialised in that case.  Init to 0 too to silence this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309100514.ndBFebXN-lkp@intel.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index f087baa95b07b..80c09070ea9fa 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -683,8 +683,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen = 0;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
-- 
2.42.0


