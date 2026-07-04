Return-Path: <netdev+bounces-304717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ROGFHHs/SWp4zgAAu9opvQ
	(envelope-from <netdev+bounces-304717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 19:14:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF87C7080AB
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 19:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Jqkj9LAV;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304717-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304717-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EE9F3005AD7
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7095F35E1A5;
	Sat,  4 Jul 2026 17:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E355433E7F
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 17:14:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783185272; cv=none; b=d294LrXeKVWIK4GvmzhXNlPmIxIxGk1lER33EK2D7CIzUasqb3Q+4K0uncURKOYyaPQjBU+lMTNCikxljyRrYRgeFiJMFFkon3Xyi9LHB2e/TkEj4aDKBhqZakzn3wzd/9MM3pOG0hrmgEkMOWULnHTf3GnTXAKPDU4Emjo+S+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783185272; c=relaxed/simple;
	bh=7uyRPvzkXYfs2wmtaHMDG+n85HN/ZOLukoEk4n9DqyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ecPxE0I5ZF2HYYD9IFYMnJF8vv7CPcI2RAmsM1ZGIo4+0q3i4f0jzsfn/597q8kHldkzLHZG93LePSjID1qQphHoH38ospPT3uATG5dJcQUCAcqPkM8WipKLyH3yWurWgiQ7qPf77FmRjyz72NOlIHK0RZ0GOXUs34dQtegiu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqkj9LAV; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9b42be8feso16005565ad.2
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783185270; x=1783790070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmrMGneNXYFXj/2nN+KzQAgQlOxhvv+qqZjYjmSo2X4=;
        b=Jqkj9LAVOrNovQ3dXVETqcNxFMeImz3XGUpDl5pAPkfsUB/rVa0FeJUl2c8pOpeV/Q
         20TsBv8Gbj2HBXsAgcrp+2gGSyEVEHpA8NymzzVsr1SQ4Hr3i1H2Bv0DZK5rozNXgsLn
         8bo+4yQF+IuRiCLet4j05GWMWbnYH/kZO8VjWy1yx9LImWnzgIrwJVusgSYiJh2EE6Wr
         yVU93uX5qmDJg1xLydFzfaVoidPKt1v8XcZ9xmUb65Fuqyth1WvQvBw+aMc3grzqo2XC
         /FbcnWidxP8dxp/f+cA8jOLM/HWsh3TAGR154wAkzBh666YAHMpXZJLLd345+YewJ9H6
         GWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783185270; x=1783790070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmrMGneNXYFXj/2nN+KzQAgQlOxhvv+qqZjYjmSo2X4=;
        b=Bprm404ru0+aQKocgKrkJN7P194jfWUk+cy+I75JQVsISVhAGpGGEMgLSe3cQnP/44
         4lkvAELIjoO8vRX/K+WzfA66y3gQJSQ2hH8Bd5gYdQLFT7xg9FMn6fXHNV+BRA8DUnBS
         NWCQdl42wLuAeVuGAIdMQXhnboxM9t3idgXesu9pTq7wvO2IKXdjDAB8ZSvUNRY9fiK8
         3PM8x5XZ2JnWNIAct6zDP0Uf+V4/K5JXaGztD7BazRW5nhRrbXN4aos/PdwDnaFxC04S
         OFwfV8ytzOIUEDtkLU3wF0LuhNpZnMyMkUVLdzvTeIPe0j+VTZduoIUzXeiX/eYKCzSV
         hGVg==
X-Gm-Message-State: AOJu0Yzk2t1nMFYe5z3gOi0Fr6BkGV9DPRQUQ8kY5BbfotcEN2OTitnz
	lUQpE0TNiN9f4AEH9ndpFIBn0HxKD/1yH47v38nKZ4o2aa1rpAjjRPeUaQIASj3USUc=
X-Gm-Gg: AfdE7cljMm97/48+5CNLLExD8I8d6LVEHUH10MiFUgG7SdRwMDonCxrDjwXKlTYVbHr
	9tuKyabBQRxUca9Q9TvtteRt4+rigVJzBREp8b0TYGGPz/dKswc/C5/XLptHULIe6sIzQSE/EOU
	LcxcVcyUjpKExqsEXMiVqU79NIEX/NPuQUNVbRtBwYty724pDbuOzQtm151NobcUoPzmA54LVIN
	PoVICuAbKyXhqOnyxqnd7pXyBVO5fCTJxWvzH9k6wg4FmMy59C48LjHQTUjC8bLXLPzKl3F0evi
	3DUYOlxpD0lQw/c1zRun3pfHkxPLcJ8zOfp9rn8q8alramhkojC+L9YTL6UlP/8vnwLyYXp8MoM
	Fbqtz61guSn8RM7pqajF1WOnV1HTMSRefL9qrIopQF0NeOJ5UmxxmymzMjyqtaTMLkyrH2T8DW3
	4BTrb0THJG4nWdRXa7HSbiJiKTQfMdJzxYdQ/tEpsMISkS1rJF0geIlFPJDQ==
X-Received: by 2002:a17:903:b8f:b0:2c9:cf41:adf9 with SMTP id d9443c01a7336-2cbb9f0eb2amr39212645ad.47.1783185270387;
        Sat, 04 Jul 2026 10:14:30 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b446a766asm35140615c88.7.2026.07.04.10.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 10:14:29 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] ipv4: fib: free fib_alias with kfree_rcu() on insert error path
Date: Sat,  4 Jul 2026 10:14:21 -0700
Message-ID: <20260704171421.1786806-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,redhat.com,davemloft.net,asu.edu,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304717-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF87C7080AB

fib_table_insert() publishes new_fa into the leaf's fa_list with
fib_insert_alias() before calling the fib entry notifiers. When a
notifier fails, the error path removes new_fa with fib_remove_alias()
(hlist_del_rcu) and frees it right away with kmem_cache_free().

fib_table_lookup() walks that list under rcu_read_lock() only, so a
concurrent lookup that already reached new_fa keeps reading it after the
free:

 BUG: KASAN: slab-use-after-free in fib_table_lookup (net/ipv4/fib_trie.c:1601)
 Read of size 1 at addr ffff88810676d4eb by task exploit/297
 Call Trace:
  fib_table_lookup (net/ipv4/fib_trie.c:1601)
  ip_route_output_key_hash_rcu (net/ipv4/route.c:2814)
  ip_route_output_key_hash (net/ipv4/route.c:2705)
  __ip4_datagram_connect (net/ipv4/datagram.c:49)
  udp_connect (net/ipv4/udp.c:2144)
  __sys_connect (net/socket.c:2167)
  __x64_sys_connect (net/socket.c:2173)
  do_syscall_64
  entry_SYSCALL_64_after_hwframe
 which belongs to the cache ip_fib_alias of size 56

Triggering the error path needs CAP_NET_ADMIN and a registered fib
notifier that can reject a route; a netdevsim device whose IPv4 FIB
resource is exhausted is enough.

Free new_fa with alias_free_mem_rcu(), as fib_table_delete() already
does for a fib_alias removed from the trie.

Fixes: a6c76c17df02 ("ipv4: Notify route after insertion to the routing table")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/ipv4/fib_trie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 1308213791f1..2dc87e2156d3 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1385,7 +1385,7 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 out_remove_new_fa:
 	fib_remove_alias(t, tp, l, new_fa);
 out_free_new_fa:
-	kmem_cache_free(fn_alias_kmem, new_fa);
+	alias_free_mem_rcu(new_fa);
 out:
 	fib_release_info(fi);
 err:
-- 
2.43.0


