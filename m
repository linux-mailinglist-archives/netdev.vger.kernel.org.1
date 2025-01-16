Return-Path: <netdev+bounces-158993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A0A140AB
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773C6188DFEE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CD234CF9;
	Thu, 16 Jan 2025 17:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (unknown [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60839234981;
	Thu, 16 Jan 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047971; cv=none; b=hmhAKyCpceqn7III/QeTWToT+DAFE1+Jvb3u+nYjH9NZo9XkEkkbq0cz/vULHF6oR3W/Eu4zeLewSSXFCGkTrrRuQwvEVv7R/noUFTaj0hcelM1EqtEl1+x06IRYnKrISRh0KF4yokLyHxusRMLZfzQczK/PbMi6C6CxcG7Kn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047971; c=relaxed/simple;
	bh=sOOiXELOLHGTDAG4yU5ZQHuv+9It1vE7voNAEewZqrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9MdIBvMjPcUXii64b8MJrT8WnthlGiLiqQvguLMZGjv+d3eLcj9pulLvXeCV/cZqHCbmxPjNzK+iVMuR7nvAL4V0vFlTAKFL6XNT9OikwlF0OUwtcpy19yyudZ3q+nxqCPhNnU7fBZtePfIB4QQly4xU3eKB4uJ12ATtWPz/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 06/14] netfilter: nf_tables: Compare netdev hooks based on stored name
Date: Thu, 16 Jan 2025 18:18:54 +0100
Message-Id: <20250116171902.1783620-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250116171902.1783620-1-pablo@netfilter.org>
References: <20250116171902.1783620-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

The 1:1 relationship between nft_hook and nf_hook_ops is about to break,
so choose the stored ifname to uniquely identify hooks.

Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 87175cd1d39b..ed15c52e3c65 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2317,7 +2317,7 @@ static struct nft_hook *nft_hook_list_find(struct list_head *hook_list,
 	struct nft_hook *hook;
 
 	list_for_each_entry(hook, hook_list, list) {
-		if (this->ops.dev == hook->ops.dev)
+		if (!strcmp(hook->ifname, this->ifname))
 			return hook;
 	}
 
-- 
2.30.2


