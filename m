Return-Path: <netdev+bounces-137048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A749A4204
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5011A28A1CE
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409720010F;
	Fri, 18 Oct 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcn0AAZs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9525A16BE3A;
	Fri, 18 Oct 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264343; cv=none; b=NsLidQWFbKeA9t35bBzQ2XiI2Z3cFU7YMtyyAXQPEMv33vfi96rYi3anKOAnEL/R1hoGvwZ0l5DBjcMkFYjxnMvgJ5UC25gGIYmzkGTn6zbC/DerTzSOkBMW0gtDVwXJcdcZaD3u2BpeKdQxfo4MRZldJ+zzyw5vvuKQkkjf280=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264343; c=relaxed/simple;
	bh=W1Y5OK/NY7K9m461uBKMk468dZHpDUW5Foz6lCJa0Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IZh+qx8gPneoaCtzny5J61yX9Yx8M28U/Tst0s0ipmnORQSFWAB5Qm1RSYk4eyT0+hiR2igDQK+UnuaBxAdXzGG/p+z2ZbfeRsWYD0gHhmXdZ6fI0jZIOOOQJck90UvsM2sM5cEBKP0VzucDc6FQBiNjkN0AZLgCCM+j2GtXzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcn0AAZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649B8C4CEC3;
	Fri, 18 Oct 2024 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729264343;
	bh=W1Y5OK/NY7K9m461uBKMk468dZHpDUW5Foz6lCJa0Gk=;
	h=From:To:Cc:Subject:Date:From;
	b=lcn0AAZsD7toXxaY4C6Q6zLbhLYNaYscIBQuhZtqo7dXj2ymsphuZmlVCFtId664c
	 prY6s0r3UJYbxI5vieHUEqK6DXmStZ0XsLuYaCk+NGqlB3GYkQD4otK2P8YQHFTiJT
	 VHQ1PCsWg45UIyFmDgSUnzOLXJhlSyKVuXdZncqj6Ri9iPfXFj6BSSOt8DBtjSoG8l
	 dZWMT89U/IBvM3RwEINHoKwClharcgqsnvUSaxgsX/Pcgl2ppWCDrlKbsW4rG7cNDJ
	 1OU1GIS0UM2T/J7ouiAf31jV1FNBUwNNAfO/13GUQuWFayt3BDSfYedyCKjum1aS+l
	 QlPMJq9SShqIw==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Li Zetao <lizetao1@huawei.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipmr: Don't mark ip6mr_rtnl_msg_handlers as __initconst
Date: Fri, 18 Oct 2024 15:12:14 +0000
Message-Id: <20241018151217.3558216-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This gets referenced by the ip6_mr_cleanup function, so it must not be
discarded early:

WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x14 (section: .exit.text) -> ip6mr_rtnl_msg_handlers (section: .init.rodata)
ERROR: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

Fixes: 3ac84e31b33e ("ipmr: Use rtnl_register_many().")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 437a9fdb67f5..f7892afba980 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1367,7 +1367,7 @@ static struct pernet_operations ip6mr_net_ops = {
 	.exit_batch = ip6mr_net_exit_batch,
 };
 
-static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] __initconst_or_module = {
+static const struct rtnl_msg_handler ip6mr_rtnl_msg_handlers[] = {
 	{.owner = THIS_MODULE, .protocol = RTNL_FAMILY_IP6MR,
 	 .msgtype = RTM_GETROUTE,
 	 .doit = ip6mr_rtm_getroute, .dumpit = ip6mr_rtm_dumproute},
-- 
2.39.5


