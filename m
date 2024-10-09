Return-Path: <netdev+bounces-133860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 980BE9974CD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C952C1C220D3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F981A704B;
	Wed,  9 Oct 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWc2ukM7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F8381C4
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498120; cv=none; b=mfe+vBtBtN0/qYwMIQHBDALBnNWPxhnodomjWvKCDmyHA9FKtUBPqnGT5Cb5iFbJSkul/TD6i5Zxa9+aYX6I1RSy2RnlzesEqPYHEkYwwDEBXh36s/l39cSj+PkmnGCCEnhAY5ye1NdEGqXwEB8ZlLl2zd2f7hREuw6Kw9RJRMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498120; c=relaxed/simple;
	bh=Wzi6909bV+ins5nx9GS/3svfICDAPk1DZjX3E7zbJ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qm8+5bj5JTBux/3wQFGEk9sTYgJaZG54Luo5T9YsaJqugVl30vK1NxOU3HMV5VtRhOM5SZU1ff0Okmp5QZecgxsAHfMKIdlhd0s7KbF0TF/YZXkMijg1jYjcmY1ohLrCCK1shGkIby+J4pUARO93KAhodxVhGjjVVAIXgBTmj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWc2ukM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D562AC4CEC3;
	Wed,  9 Oct 2024 18:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728498120;
	bh=Wzi6909bV+ins5nx9GS/3svfICDAPk1DZjX3E7zbJ3g=;
	h=From:To:Cc:Subject:Date:From;
	b=NWc2ukM7mZxNkZzAbYi3jiXUj90OZ/5jZaI8PmiD+cdgFmO3fMYCqe0j5zjtWCwVz
	 suaLfgDwODzQXvYXoDXv+OWxVz4e+fmh3ccopXrTzsuAzE+stPX5uSsQFvs62SQ76p
	 lcpWTBCKadW7sVxLoq0+U4kqJzBuHjWS1g6BSKU8nudb5SaF3ghRrPo8R7TAJDRO2f
	 mCJDIv3qe1gJvdxTy0SmG3okttQngLtBH/KHbOSYiJ1bTKAxJdUD7dWAdXYvc7OSqJ
	 G2aE6GOuRhhQQo2crOKHLdxdo1FOE26uPf6aGK/E3nbiAFFjRQvE8ZvAl6mZzxwxNz
	 0lhowRaAW1qjA==
From: Jakub Kicinski <kuba@kernel.org>
To: stephen@networkplumber.org
Cc: dsahern@gmail.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iproute2] ip: netconf: fix overzealous error checking
Date: Wed,  9 Oct 2024 11:21:54 -0700
Message-ID: <20241009182154.1784675-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtnetlink.sh kernel test started reporting errors after
iproute2 update. The error checking introduced by commit
under fixes is incorrect. rtnl_listen() always returns
an error, because the only way to break the loop is to
return an error from the handler, it seems.

Switch this code to using normal rtnl_talk(), instead of
the rtnl_listen() abuse. As far as I can tell the use of
rtnl_listen() was to make get and dump use common handling
but that's no longer the case, anyway.

Before:
  $ ip -6 netconf show dev lo
  inet6 lo forwarding off mc_forwarding off proxy_neigh off ignore_routes_with_linkdown off
  $ echo $?
  2

After:
  $ ./ip/ip -6 netconf show dev lo
inet6 lo forwarding off mc_forwarding off proxy_neigh off ignore_routes_with_linkdown off
  $ echo $?
  0

Fixes: 00e8a64dac3b ("ip: detect errors in netconf monitor mode")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
We're also missing opening a JSON object here, but I'll send
that fix separately, to -next?
---
 ip/ipnetconf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ip/ipnetconf.c b/ip/ipnetconf.c
index 77147eb69097..cf27e7e30a5a 100644
--- a/ip/ipnetconf.c
+++ b/ip/ipnetconf.c
@@ -187,16 +187,16 @@ static int do_show(int argc, char **argv)
 	ll_init_map(&rth);
 
 	if (filter.ifindex && filter.family != AF_UNSPEC) {
+		struct nlmsghdr *answer;
+
 		req.ncm.ncm_family = filter.family;
 		addattr_l(&req.n, sizeof(req), NETCONFA_IFINDEX,
 			  &filter.ifindex, sizeof(filter.ifindex));
 
-		if (rtnl_send(&rth, &req.n, req.n.nlmsg_len) < 0) {
-			perror("Can not send request");
-			exit(1);
-		}
-		if (rtnl_listen(&rth, print_netconf, stdout) < 0)
+		if (rtnl_talk(&rth, &req.n, &answer) < 0)
 			exit(2);
+
+		print_netconf2(answer, stdout);
 	} else {
 		rth.flags = RTNL_HANDLE_F_SUPPRESS_NLERR;
 dump:
-- 
2.46.2


