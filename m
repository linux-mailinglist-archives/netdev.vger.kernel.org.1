Return-Path: <netdev+bounces-261547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LsvH5SdoGlVlAQAu9opvQ
	(envelope-from <netdev+bounces-261547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:23:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BCF1AE498
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D2193060CC2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A954D44CF3A;
	Thu, 26 Feb 2026 19:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yxI2e8U3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B2426D20
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133322; cv=none; b=Rt9qJZPhfHGvLgw/TLk9y3M5f6ZBQjfA8uemM0qX1y8srmEOMdplktN4+edCl2eJK9dU+PsTVFk1n5LqKXhFgmS/UbmN1oAFtlux59shhHdYpw1W43odHSY1JhOSDYotwcV6r3LjBfyeLdyMBFHh7vRblxZ6U8/YEPVNzD+qdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133322; c=relaxed/simple;
	bh=0WaVqEgcJlDY02tN0zXYGgU0sjaZ14hTVaCR4FdDCXE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dwN7BBEhXVAhxXWrMifAK87o3p9F3cUVAl3FgHTuPG+2tCPXBMEqRkHxPYfZXnP2lHmZT+KfMuh4+8XBxGRPlqWvwOM37vtzFz5VQ4e8ErwyDDpo0Ki+j58urQ7Rt8O72w82ezS9dhqLYacXTfwMA2jo9TxupoG3WpMHVg90iKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yxI2e8U3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2adca7aba8bso10204045ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772133317; x=1772738117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kvTHTqe9ndDnP2daAlPvuqmWQOnnNZG2WdCPppQRAU=;
        b=yxI2e8U3xWNzgmrfKemysD86hvlPghx7l0zahDpMCoYBgrEVgHOwVBadk1aZPhw9fQ
         f18L9fNaoRgjHpTyPytVD3YH0JMb0c6Xb2sQ5LH8oPqK7yOfu9tGiEEtQNEGtDRmgWh6
         wG0hdmhS4tDfDGqPlGXnDpNv3PkR5Mq16+OndWDB6bV5r1srGfU9nSmO8uumU27+54vx
         N/OfxHQw9ViG58pTfPbMSIqAUO5AwR3T8HV6F8JOezRSrzwup6f89ZrFouUJHa8I2uKc
         fQJxXPU11k/J+zRVp9AeoTDE1W6wfdYhLuOcIUAwLzBiUKogp9fEBuhKE7Pt4hdS+UkY
         Svcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772133317; x=1772738117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kvTHTqe9ndDnP2daAlPvuqmWQOnnNZG2WdCPppQRAU=;
        b=mKJQDPuSsHg5wM9F2tfuL5m/sXlvIhjSrQwx8fQIL2v5KkPUly7i7uCac5nA3oa3UB
         qnH/QSodo7wP36W3H8RYFJUGSg8KWD2qb/pC8wenL1EfwQLFDQI9OIQgZ7m2KOJnrNSf
         eaUZSVrRARvidUevt7iHf7eQWjPooA6BNhkCmed/ppCDnEfwBC8PM1NDOa1YbDOdNSdC
         VSFUFqE9CmIYiiT6X4lAZjrE5aJLYLNxG1c0MqcwTfHx8mZKxZHIo/gdpT7iHoJKoKp8
         7aSiZGJdkOHdYjDZLMCjqIjMLrGP8/Ax8B9g/f1Rfk6CeNjmHuQCWzpTKu3Qsb4A6hsr
         PzDA==
X-Forwarded-Encrypted: i=1; AJvYcCVIqqDse5bcWt6wLgvtTQSEu5fI5die09wB+9uAHXzAu4lmu8Gw80EfPDL4Ln54jTY/TVnLMT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTN1orxCWGUJlyektuRAX87+fuFTTglMFh9O4Z5cXj8+oQyCHY
	sWtUabcFUoLoPIEfeWYZvmGHDzz6wgO/wHJFuM0FdxhsvENh5skIMAEevJWyFrfh8TlfVjBSJAJ
	CO3vBOQ==
X-Received: from plgz12.prod.google.com ([2002:a17:903:18c:b0:298:465f:129])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2283:b0:2aa:f07f:a776
 with SMTP id d9443c01a7336-2ae2e4b5727mr86095ad.43.1772133317292; Thu, 26 Feb
 2026 11:15:17 -0800 (PST)
Date: Thu, 26 Feb 2026 19:14:14 +0000
In-Reply-To: <69a07c1b.050a0220.16c224.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <69a07c1b.050a0220.16c224.0006.GAE@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260226191515.2953716-1-kuniyu@google.com>
Subject: Re: [syzbot ci] Re: ipmr: No RTNL for RTNL_FAMILY_IPMR rtnetlink.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: syzbot+ci7bfbcdccdcddd61f@syzkaller.appspotmail.com
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,gmail.com,vger.kernel.org,redhat.com,lists.linux.dev,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-261547-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci7bfbcdccdcddd61f];
	NEURAL_HAM(-0.00)[-0.958];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzbot.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 08BCF1AE498
X-Rspamd-Action: no action

From: syzbot ci <syzbot+ci7bfbcdccdcddd61f@syzkaller.appspotmail.com>
Date: Thu, 26 Feb 2026 09:00:11 -0800
> syzbot ci has tested the following series
> 
> [v1] ipmr: No RTNL for RTNL_FAMILY_IPMR rtnetlink.
> https://lore.kernel.org/all/20260226023637.1335854-1-kuniyu@google.com
> * [PATCH v1 net-next 01/15] selftest: net: Add basic functionality tests for ipmr.
> * [PATCH v1 net-next 02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
> * [PATCH v1 net-next 03/15] ipmr: Convert ipmr_rtm_dumplink() to RCU.
> * [PATCH v1 net-next 04/15] ipmr: Use MAXVIFS in mroute_msgsize().
> * [PATCH v1 net-next 05/15] ipmr: Convert ipmr_rtm_getroute() to RCU.
> * [PATCH v1 net-next 06/15] ipmr: Convert ipmr_rtm_dumproute() to RCU.
> * [PATCH v1 net-next 07/15] ipmr: Move unregister_netdevice_many() out of mroute_clean_tables().
> * [PATCH v1 net-next 08/15] ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
> * [PATCH v1 net-next 09/15] ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
> * [PATCH v1 net-next 10/15] ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
> * [PATCH v1 net-next 11/15] ipmr: Call fib_rules_unregister() without RTNL.
> * [PATCH v1 net-next 12/15] ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq} under CONFIG_IP_MROUTE.
> * [PATCH v1 net-next 13/15] ipmr/ip6mr: Convert net->ipv[46].ipmr_seq to atomic_t.
> * [PATCH v1 net-next 14/15] ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
> * [PATCH v1 net-next 15/15] ipmr: Don't hold RTNL for ipmr_rtm_route().
> 
> and found the following issue:
> WARNING in ipmr_free_table
> 
> Full report is available here:
> https://ci.syzbot.org/series/d7068eba-72b1-4110-aeb0-d4528e03fd24
> 
> ***
> 
> WARNING in ipmr_free_table
> 
> tree:      net-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
> base:      c7f5c6fb0f2b1a44490a36582a251f0a304d6b0c
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/0afa280b-14ff-4aec-8a20-7f8507025dd8/config
> C repro:   https://ci.syzbot.org/findings/e38687c7-5a8b-4c68-909c-a0ffdd17a674/c_repro
> syz repro: https://ci.syzbot.org/findings/e38687c7-5a8b-4c68-909c-a0ffdd17a674/syz_repro
> 
> ------------[ cut here ]------------
> !net_initialized(net) && !list_empty(dev_kill_list)
> WARNING: net/ipv4/ipmr.c:450 at ipmr_free_table+0x150/0x180 net/ipv4/ipmr.c:450, CPU#1: syz.1.18/6004

I forgot dev_kill_list could have some devices collected
from _other_ ->rtnl_exit() _after_ successful ipmr init.

My assumption in patch 10 is still correct, and I'll squash
this in v2.

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 4e645a87dc6c..89e151121cea 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -437,17 +437,19 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
 static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_list)
 {
 	struct net *net = read_pnet(&mrt->net);
+	LIST_HEAD(ipmr_dev_kill_list);
 
 	WARN_ON_ONCE(!mr_can_free_table(net));
 
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
 			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
-			    dev_kill_list);
+			    &ipmr_dev_kill_list);
 	rhltable_destroy(&mrt->mfc_hash);
 	kfree(mrt);
 
-	WARN_ON_ONCE(!net_initialized(net) && !list_empty(dev_kill_list));
+	WARN_ON_ONCE(!net_initialized(net) && !list_empty(&ipmr_dev_kill_list));
+	list_splice(&ipmr_dev_kill_list, dev_kill_list);
 }
 
 /* Service routines creating virtual interfaces: DVMRP tunnels and PIMREG */

