Return-Path: <netdev+bounces-104652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859B490DCA3
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7531F2309C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E9516CD39;
	Tue, 18 Jun 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9RbOLTj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877F16CD22
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739557; cv=none; b=WHfvh7YF0soBDeEGnfYp/HYwxXjszHxBvi8FGn+YftjzxYSzgEMNByVGrLhgFltZaAmaRlF926s8RT9UhbZlhJ3B0nsTh80AnwyZmHbbDLLxvPq0ThRVxkMiqEFzJmGTGEHcIBxwZPYZKP+H4Fsi3Dvsqyr6cXQUocUtAy0cuO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739557; c=relaxed/simple;
	bh=TG1etluQKPLYUEy9BxqT/rOeCcggTySfVISqQkDJXv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iui95A13LrE8oxM8+HkAYC+CpLIOR6BFFYrsEX96yFnpRxCcsdn/LVd01CUQlUsmBL+1jPXU6uXLf5L7o5d7cl3KmE3bEiOwaabVPxp8DmjEvZ22DKQjHGR5cRM5szOt1wc2nEyunScrkLwAKhYrshKm1yRVUSxC0Ky3QFK63+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9RbOLTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B235C3277B;
	Tue, 18 Jun 2024 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718739557;
	bh=TG1etluQKPLYUEy9BxqT/rOeCcggTySfVISqQkDJXv4=;
	h=From:To:Cc:Subject:Date:From;
	b=X9RbOLTj7+hqW7ct29vEXTL+4vHVsaN3zqn2kXyZRtIODRwqL8hoEAAfUKjrvUs3J
	 cSlsqee39Rsy/hAU0lDY+J0r9FHTZ2qB3TbmQ5CdQvr0HRlBQn7KZxux4GC0n/ip4S
	 MGZTWKmdwoqPd3M82VKiLYapvc/hc5c9Bwzmh0HzMX1yylSIIzDKX6pMPcB3ZMD7rR
	 PH3c9/eDF3s3vd+hlsl6igFrE1HduI9phjI22IthULAB8ldBDcT5ayXk7PoAjM8FJl
	 8krsTGxUDNCHJqPKXMjASQ78/3qJcQwSpW5JxOpf3JUJzZ/tOiZpkYu2J6HYpBPbnC
	 twBZEV3k62guA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dsahern@kernel.org,
	donald.hunter@gmail.com,
	maze@google.com
Subject: [PATCH net] ipv6: bring NLM_DONE out to a separate recv() again
Date: Tue, 18 Jun 2024 12:39:14 -0700
Message-ID: <20240618193914.561782-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit under Fixes optimized the number of recv() calls
needed during RTM_GETROUTE dumps, but we got multiple
reports of applications hanging on recv() calls.
Applications expect that a route dump will be terminated
with a recv() reading an individual NLM_DONE message.

Coalescing NLM_DONE is perfectly legal in netlink,
but even tho reporters fixed the code in respective
projects, chances are it will take time for those
applications to get updated. So revert to old behavior
(for now)?

This is an IPv6 version of commit 460b0d33cf10 ("inet: bring
NLM_DONE out to a separate recv() again").

Reported-by: Maciej Żenczykowski <zenczykowski@gmail.com>
Link: https://lore.kernel.org/all/CANP3RGc1RG71oPEBXNx_WZFP9AyphJefdO4paczN92n__ds4ow@mail.gmail.com
Reported-by: Stefano Brivio <sbrivio@redhat.com>
Link: https://lore.kernel.org/all/20240315124808.033ff58d@elisabeth
Reported-by: Ilya Maximets <i.maximets@ovn.org>
Link: https://lore.kernel.org/all/02b50aae-f0e9-47a4-8365-a977a85975d3@ovn.org
Fixes: 5fc68320c1fb ("ipv6: remove RTNL protection from inet6_dump_fib()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: dsahern@kernel.org
CC: donald.hunter@gmail.com
CC: maze@google.com
---
 net/ipv6/ip6_fib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index d9c9a542a414..eb111d20615c 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2514,7 +2514,8 @@ int __init fib6_init(void)
 		goto out_kmem_cache_create;
 
 	ret = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETROUTE, NULL,
-				   inet6_dump_fib, RTNL_FLAG_DUMP_UNLOCKED);
+				   inet6_dump_fib, RTNL_FLAG_DUMP_UNLOCKED |
+				   RTNL_FLAG_DUMP_SPLIT_NLM_DONE);
 	if (ret)
 		goto out_unregister_subsys;
 
-- 
2.45.2


