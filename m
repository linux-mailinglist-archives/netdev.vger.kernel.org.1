Return-Path: <netdev+bounces-129613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC69984C05
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 22:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C0F01C228EE
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 20:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25217146A71;
	Tue, 24 Sep 2024 20:14:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143AC13D8A3;
	Tue, 24 Sep 2024 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208858; cv=none; b=L7KISZ2Y/2aV62lc/wQBEhSlmxsqIx6SlotQIaGo+AKncPrD56F7M87IrG66SAf1mpVgrx1RoAQxGiQYOJv8l8Kh0YvQwZbOlt+Zmi6uaV0iLkZRPs/ukcq8SfSOmK9UZgUvwbWSWXziQBjtKK7rDBWLnc11WR3TUUdYzypi8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208858; c=relaxed/simple;
	bh=d0J+XOjoXL27hbOrukUJ95qoYSMyTJSXYFMwK47w3SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q83NTOfrE73Oy9E5EpZpu8cHWHVBfpK88Pp4ZCpRFWXDQoHXhkCZ0fbwFzH9fVmZTR/iUoAvzjSS6E3ofRukj8CuP8gR5uP0g3G5sQcudSwA+qaHk9nyzUa5IIRHxE0V+77uce34EKm0vyMQmqVpVHfyYTBVxxpmtDEvTMGnWRY=
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
Subject: [PATCH net 10/14] netfilter: nf_tables: use rcu chain hook list iterator from netlink dump path
Date: Tue, 24 Sep 2024 22:13:57 +0200
Message-Id: <20240924201401.2712-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240924201401.2712-1-pablo@netfilter.org>
References: <20240924201401.2712-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockless iteration over hook list is possible from netlink dump path,
use rcu variant to iterate over the hook list as is done with flowtable
hooks.

Fixes: b9703ed44ffb ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
Reported-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 042080aeb46c..8f073e6c772a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1849,7 +1849,7 @@ static int nft_dump_basechain_hook(struct sk_buff *skb, int family,
 		if (!hook_list)
 			hook_list = &basechain->hook_list;
 
-		list_for_each_entry(hook, hook_list, list) {
+		list_for_each_entry_rcu(hook, hook_list, list) {
 			if (!first)
 				first = hook;
 
-- 
2.30.2


