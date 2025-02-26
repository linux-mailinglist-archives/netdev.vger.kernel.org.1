Return-Path: <netdev+bounces-169986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D440A46B1C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3612A16EBC1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A2F244EA1;
	Wed, 26 Feb 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rsvAAeBj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C221ABA9
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598353; cv=none; b=Wd0HiTyiwn2Rwz3WmbOd67vViYwd46poSMlNXrs8aDIFqwtdZwOa4Exq4Yfh1EeR+RsWiMJitb1tQ1Kbj2iS4XXG3DmLg5HtY/yKfTboYGTxGnH9zNDe+CLikXQ0SoCJyKLu9K9NFY32euFZkPYa7GZg7D9QU+rPHPsrqFPkknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598353; c=relaxed/simple;
	bh=bMBsBRjw/lRUtGuUMc71/I/S/lp0ZTwauL7I5alfvFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHDAerf5gAIfIQe2dtRj6DnV099MnqnG0jSiulgd4AQaYkFS4NzA6veE3phBAh8kR3EOH3K6uxCFJl0u8zftGgVBNuXtKX21JSjB5yK4guk8VsFdLgtKzzrnBs85olLRaxwjL+yEvdF+bUUf0DETsDj6lZ5dB/Xg1HncC9UVYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rsvAAeBj; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598349; x=1772134349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RdhpugZ0ovpSSzgmTLWYFM6J4IE8hkBH8r6QF5K7iSw=;
  b=rsvAAeBjBG31eZOc9zSv/oAMFN/8wIU4MpwaEUPtH/eIGGYdwwE9vKxt
   Qr3hvDoZnAys66PSCqMd2/QZtdENGWGk7gNGUlNyhcz00F7QDePloDiV4
   LvSWU/wGRGMKih9qW1w9mpwBRV6kA2wkyv3wlYl6umy8OGfTQ9wAbwvDc
   I=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="475576113"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:31:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:18015]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.97:2525] with esmtp (Farcaster)
 id 7f691583-ec7b-4917-9905-2b6c92de0b8e; Wed, 26 Feb 2025 19:31:20 +0000 (UTC)
X-Farcaster-Flow-ID: 7f691583-ec7b-4917-9905-2b6c92de0b8e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:31:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:31:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 12/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Wed, 26 Feb 2025 11:25:56 -0800
Message-ID: <20250226192556.21633-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250226192556.21633-1-kuniyu@amazon.com>
References: <20250226192556.21633-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We converted fib_info hash tables to per-netns one and now ready to
convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.

Let's hold rtnl_net_lock() in inet_rtm_newroute() and inet_rtm_delroute().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fib_frontend.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index a6372d934e45..6de77415b5b3 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -884,20 +884,24 @@ static int inet_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	rtnl_net_lock(net);
+
 	if (cfg.fc_nh_id && !nexthop_find_by_id(net, cfg.fc_nh_id)) {
 		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
 		err = -EINVAL;
-		goto errout;
+		goto unlock;
 	}
 
 	tb = fib_get_table(net, cfg.fc_table);
 	if (!tb) {
 		NL_SET_ERR_MSG(extack, "FIB table does not exist");
 		err = -ESRCH;
-		goto errout;
+		goto unlock;
 	}
 
 	err = fib_table_delete(net, tb, &cfg, extack);
+unlock:
+	rtnl_net_unlock(net);
 errout:
 	return err;
 }
@@ -914,15 +918,20 @@ static int inet_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	rtnl_net_lock(net);
+
 	tb = fib_new_table(net, cfg.fc_table);
 	if (!tb) {
 		err = -ENOBUFS;
-		goto errout;
+		goto unlock;
 	}
 
 	err = fib_table_insert(net, tb, &cfg, extack);
 	if (!err && cfg.fc_type == RTN_LOCAL)
 		net->ipv4.fib_has_custom_local_routes = true;
+
+unlock:
+	rtnl_net_unlock(net);
 errout:
 	return err;
 }
@@ -1683,9 +1692,9 @@ static struct pernet_operations fib_net_ops = {
 
 static const struct rtnl_msg_handler fib_rtnl_msg_handlers[] __initconst = {
 	{.protocol = PF_INET, .msgtype = RTM_NEWROUTE,
-	 .doit = inet_rtm_newroute},
+	 .doit = inet_rtm_newroute, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_DELROUTE,
-	 .doit = inet_rtm_delroute},
+	 .doit = inet_rtm_delroute, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_GETROUTE, .dumpit = inet_dump_fib,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 };
-- 
2.39.5 (Apple Git-154)


