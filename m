Return-Path: <netdev+bounces-45114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953507DAEFC
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DD71C208A7
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5613AE1;
	Sun, 29 Oct 2023 22:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXFR4Msx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC4C12E67
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 22:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D878C433D9;
	Sun, 29 Oct 2023 22:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620118;
	bh=V10r/fY0B71Jt12SKb4l4Gur1/4PIp2XJND+EDLBO/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXFR4MsxTL+6GAzYJWIjjOY7ychtp2gxeGU+j+b7bbuXMv8HX7RWlvOhUSrvylVHx
	 xo3gf+PwMUYH+wGweFw++sJNNHCOOh9mn1HllLRxlbuRMh7mwTP496Hgyn+KzB9Yzy
	 NGZcXZxqrNn7XBXiEGqvr/DgLjXuxst+8xVWtec0GhKhXp+jJAoeZGUmxe/nrD1mH2
	 e4BmJ7NQWg45UyuRwx8DS7Azf9dCoV0mkHFXj25SZUOKlMeCKQ2ESxH9c2rMCawDg9
	 9KdtRkL4iABQTP5S8Hun1iyhCy2pMHqKH1/q2vgVbasV1cLF3kDbCHE4WvO3BKR97A
	 2LPJ2tSU+Mnng==
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
Subject: [PATCH AUTOSEL 6.5 24/52] netfilter: nfnetlink_log: silence bogus compiler warning
Date: Sun, 29 Oct 2023 18:53:11 -0400
Message-ID: <20231029225441.789781-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
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
index e57eb168ee130..984f6f106e4ac 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -700,8 +700,8 @@ nfulnl_log_packet(struct net *net,
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


