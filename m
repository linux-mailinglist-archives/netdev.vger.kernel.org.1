Return-Path: <netdev+bounces-301810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qI7AEKZ9PGq/oggAu9opvQ
	(envelope-from <netdev+bounces-301810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:00:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F24A6C20CC
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=tHudH2uU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301810-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2BD0304544D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B7B36729A;
	Thu, 25 Jun 2026 01:00:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02283612F8
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 01:00:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349213; cv=none; b=kkhfjoYJ6cjc2lvfUVoEQpTZCUxuwsA0x/h09YgcOoWnchJgMNencpbQRKr6rvQ1781BUXMMHZ1cqbfemtjuYoj4yKOOVqolsmIDDsjBS+r3N1kvmdhPs9t72kQT+SGHDIE0/y1caZSMBIW4c1gyovCKxc2C/Zo8IT+GN0i5T1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349213; c=relaxed/simple;
	bh=7ttSot8uvmbmDr25iVgapfOaLEdfFBfLqnBp0maLbAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Os4+TfbGnR2OqO5GgUDFhOC1OHv+xlcq3pR9+DVUtlJs/n5U1SflAbbQCB8Umll3ekVbOidGq1+yIO24jU9GkMn6b2H9q0/SIB1s1tF7Qclg1WpqGuw1DFkPfDEMzMgtaJ6VGXVMduIkpwCIxWnA5mYkF3F5fkVxaZ9GGh0vIUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=tHudH2uU; arc=none smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c8b49639fbaso1122314a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782349210; x=1782954010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VkxKh8nTClgJ/GNm28h2Td42bPvA3cruY4e1e4dfTZQ=;
        b=tHudH2uUFaqqpB8oiVfFEQ7K5ojiwKOXNCJr54C1FXQ/xs5VJzoCuqs2vtxnL/y2J+
         PvFLm/AhbpD0roggq70qDk5nc1AoTK5NfVATfGxzketQAAxcCS8+MBcEho2BR7LBx2Lb
         yTdCtE1qrbL6yqRA+qKzs29ROB1r2DKX+iLETsZMsJKxcUu3CBGzPSCEq0y4LXqjhHYt
         8UERmYBYW5OdnshDLRzoTVBMnetYIYQOVWFXTY79Gwp4VYlR661jA3adoGgdMs7/T7L7
         FiKI48j12RzFcp6sILu1qK8Twrt9jhQboCyVB68ydYD0J0iBShJMOjKObYu+wXRbIEs1
         TJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782349210; x=1782954010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkxKh8nTClgJ/GNm28h2Td42bPvA3cruY4e1e4dfTZQ=;
        b=dUYseqZDZwVimAIChTIFrS85rvzeU+N3MY93i8OsJEVYX0ieo2Mdrs0kyHscvwBU1p
         DRz41X1WtJGkGDWGGUW+9hgxYbUmav/6x6tH9B1MkE1WT8QiSsxRWbn+7xGZECWqd4t5
         21ZpBiuni8lzhuaZIffyu7hyLgIFW4eFWbWOjoRtRQZvH+SfX3o20uLattRQUMSfUjbl
         7xoANismux4MG7RsSQ4nKxGijLU25zyOexhWTfKJS3aft1WSlicfBAzeSqfF6yyERZUL
         Fk9RL2IN5zWEQPapwhYq6AzolD/5+UbTQ95vj1KA92GM4Mze8nL+W6QHGKJ6qc1qGEbw
         4CyA==
X-Forwarded-Encrypted: i=1; AFNElJ/OCPU0E8hXfGRTQjh1p1n9bVqICR9FON173bXyzfqMNlvNMOYA6SYUcIhLVXPLT82QvvV0cAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLjRFVQbkeQAvO2dCdIa9h2RdMnVfr10zPNQeJLuMQdIkMrdP
	C5x1Idgr3I8bxchhBDaXPcM+pi/L8KlTjWTnx5AlNlVmiXC0TRCw+e2w4bftyYkp8Q==
X-Gm-Gg: AfdE7cnwO3uJUcnZRaWtBxqMGgtjmBOUEdDjoQC1bb+lJu8DW7mh8gSvmtNt6x5DJWB
	QzF2yqYzHR9Uk13TIpSZ7r/fJ0m2Bmcevq6NQPHhDZ4pJ+J5wBshcQeEJdrqvoaroJPksnGYsAO
	6rE339z1Vy64LaqN/PFrvFjd+MWRC4ahOymvjRXf5dq3+rtSEDzVjhc89W1i7HZ5ElhtT4RFFWh
	p1RSwr2glRHEwsn+8R2lmYyVmIuy8zfPNKOLgDFxMFLMm8tAuvFOsES9mYgavPrkBsfv7rwJFt/
	Uuinyam0Z2whRiQYW4JnBVYvfMSnjviMrBr8Irc7kjGxGR07J59P7CvjsLjuyS/K6dExivqNPcK
	7suvxcthQrP6LwzdQ2e+3H2y0UHSPYVPdtDhWd+PMQm3xfGHBQBdLuZinrgVZvQ2cC2G1w9/h
X-Received: by 2002:a05:6a20:72a8:b0:3b4:8b89:9fac with SMTP id adf61e73a8af0-3bd4ae35d18mr422542637.23.1782349209864;
        Wed, 24 Jun 2026 18:00:09 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec8f:cfa:df4a:3751:5684:c96f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0a90sm656279a12.15.2026.06.24.18.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 18:00:09 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org
Cc: kees@kernel.org,
	horms@kernel.org,
	Weiming Shi <bestswngs@gmail.com>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH nf] netfilter: ipset: fix race between dump and ip_set_list resize
Date: Wed, 24 Jun 2026 18:00:06 -0700
Message-ID: <20260625010006.1448558-1-xmei5@asu.edu>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301810-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,netfilter.org,vger.kernel.org,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:kees@kernel.org,m:horms@kernel.org,m:bestswngs@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F24A6C20CC

The release path of ip_set_dump_do() and ip_set_dump_done() read
inst->ip_set_list via ip_set_ref_netlink(), a plain rcu_dereference_raw()
of the array pointer. These run from netlink_recvmsg() without the nfnl
mutex and without an RCU read-side critical section.

A concurrent ip_set_create() can grow the array: it publishes the new
array, calls synchronize_net() and then kvfree()s the old one. Since the
dump paths read the array outside any RCU reader, synchronize_net() does
not wait for them and the old array can be freed while they still index
into it, causing a use-after-free.

The dumped set itself stays pinned via set->ref_netlink, so only the
array load needs protecting. Take rcu_read_lock() around it, matching
ip_set_get_byname() and __ip_set_put_byindex().

  BUG: KASAN: slab-use-after-free in ip_set_dump_do (net/netfilter/ipset/ip_set_core.c:1697)
  Read of size 8 at addr ffff88800b5c4018 by task exploit/150
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   ip_set_dump_do (net/netfilter/ipset/ip_set_core.c:1697)
   netlink_dump (net/netlink/af_netlink.c:2325)
   netlink_recvmsg (net/netlink/af_netlink.c:1976)
   sock_recvmsg (net/socket.c:1159)
   __sys_recvfrom (net/socket.c:2315)
   ...
  Oops: general protection fault, probably for non-canonical address ... KASAN NOPTI
  KASAN: maybe wild-memory-access in range [0x02d6...d0-0x02d6...d7]
  RIP: 0010:ip_set_dump_do (net/netfilter/ipset/ip_set_core.c:1698)
  Kernel panic - not syncing: Fatal exception

Fixes: 8a02bdd50b2e ("netfilter: ipset: Fix calling ip_set() macro at dumping")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/netfilter/ipset/ip_set_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index a531b654b8d9..6cfad152d7d1 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -1480,7 +1480,11 @@ ip_set_dump_done(struct netlink_callback *cb)
 		struct ip_set_net *inst =
 			(struct ip_set_net *)cb->args[IPSET_CB_NET];
 		ip_set_id_t index = (ip_set_id_t)cb->args[IPSET_CB_INDEX];
-		struct ip_set *set = ip_set_ref_netlink(inst, index);
+		struct ip_set *set;
+
+		rcu_read_lock();
+		set = ip_set_ref_netlink(inst, index);
+		rcu_read_unlock();
 
 		if (set->variant->uref)
 			set->variant->uref(set, cb, false);
@@ -1686,7 +1690,9 @@ ip_set_dump_do(struct sk_buff *skb, struct netlink_callback *cb)
 release_refcount:
 	/* If there was an error or set is done, release set */
 	if (ret || !cb->args[IPSET_CB_ARG0]) {
+		rcu_read_lock();
 		set = ip_set_ref_netlink(inst, index);
+		rcu_read_unlock();
 		if (set->variant->uref)
 			set->variant->uref(set, cb, false);
 		pr_debug("release set %s\n", set->name);
-- 
2.43.0


