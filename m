Return-Path: <netdev+bounces-305242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIc0Ck86TGrbhwEAu9opvQ
	(envelope-from <netdev+bounces-305242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D27164E4
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:29:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=E4VO0ivV;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305242-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305242-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71D183032801
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01C3F888C;
	Mon,  6 Jul 2026 23:28:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554D3F5BFF
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 23:28:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380535; cv=none; b=UV1VahincPfzn34jZAIILBc/hpnb+PBGCElG6mjuFYUARm0oR3JNjfwGxb58tGlI75QCMPf88/nZXac5XF4HizCfdOYOLzdFFwDmIsrixiveavpLJjsu1Sr/4HvxonE67J7WfNeEO9UXl8jlmPpL9ZdqIF9v27VoWh+qIl2j/vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380535; c=relaxed/simple;
	bh=6aus5nLmpNBQKmu9bkJJrV4DCuNQ/m6YN4CCOKkCwJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UVC3gJGs2jfV7Ewn/nKHAgwuTXrhs8D/SUcTVV5TEBm0r20sHy1zSrLGSePMxBQo5R3JVe4JMmmMh2JbjXfN1WNp2aNBDcRZwhRFyxz5fAejoru4QwMRd7sbufb+/W1bq6fBuZVdue4qLeijJKZ7MIhCfucoLUkY3lFAllLLpr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=E4VO0ivV; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc6ae3e7f1so14273395ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783380533; x=1783985333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gS8hUczw2Rk4FlAnWtfGIWRRQn/NJRGeEyFfNW6rUoY=;
        b=E4VO0ivVx1Yu38a4cyH/8D0ETEtsnfpmrmdkVYT5avmT9SJBb8rszTHjKcAOahOaTR
         Yt4txnNbfIG4GaLOf07PP+yrPUG4bgqPR68ZH9WIjmsAGzYJwo8hfndv7V1k3hl1FUOR
         y7iZWmq472CWW3cDl0RuR8O35r1ZsZ79F8OsRv2ytOVuOpT6jWWj8iDqjFTwk2/inxK6
         xQQQctjyc6SJCuM38ZpOcsd1zAiPrdblMq7otlj/bjEfeWxKq+moGvNhLEDgLHtkhllU
         14QAQhHYZs4vqMvpd2KGZrgSaxJQCxXkKgT4Pxj6SMuYRWjGLmKHyRTzjhMryxhzJ+po
         SOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783380533; x=1783985333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gS8hUczw2Rk4FlAnWtfGIWRRQn/NJRGeEyFfNW6rUoY=;
        b=rhuEURM2uHDfL1IRIXDzIXVk3k1yrkIxSONQHpLzOlXu+t8aZqIqOaMVKka+3jWSoG
         h2K4Dn9jCI6UVG24AiXZoQwB3ft/CWarAgCPIgd3xwzkgIH17NB8wusuKfXmWd3Z2vfP
         ebXEcEjK/kQufk5frvHrmKsyXhRJXKTgq2LuR+fCtzNPgGJufyeGBmtY6B4zd5CTk9a2
         Vyado1zMWgdGXoHkHREpxHnrVK1Oi3NaIP33493UJcLFbV3GHneWdRIMB3CiHrzT+/7C
         fSbCjv0GmO6gqoSiK9nMbjhDaC19I/IUJTNBIYoqmmN+Ka01gh1VOEIJgqRT0iEAX+G7
         S16w==
X-Forwarded-Encrypted: i=1; AHgh+RriKbxgziYOT2em57T5wLr6KVMMgeF263qY4ZFfAWFvnMJETA36mTUDOCb2K45a3HjP5GvyP9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslovfMxiJgx6GyK9beHctBv+ooZf4CNQeOgMZfkLv5+hHBHZm
	WtLc0XoOY4Zf7e+IcstBECCqd8zoBsCeKCUrtXmUJcy8V/dXPoCeOgHQBkuYRKF2tg==
X-Gm-Gg: AfdE7ck+hYPP69HIsyz2wjfXNIbsbYDjdZiCzUUHpLbb5L0ycyqzdo3sPUpqSnZewZK
	24LIP/7TAq9W+QK1VtUZTlwChi1A6snO5b7j30/HBCf+5a1/ikeXYfLvfpUVVmeWZO4CkkcYoeG
	Qzx6nKaxqrbccspz+SRVCIbBaH4vgf27XLDUZnCU0UtkbCo7oHAUPj/bSgvtIGPMZ6yv2xWIkMp
	x8E6wxZ4/zAOkLZPSxxYjqzQO7JUwAg+eFag9sTGTdV0oXB49Pb2xKOtZCopAW+bT8tZpN3hr6l
	LF9xnmrj+mEzZpzb/9M5ZSjbFrKxRFrkX+n80KJLOPslChfeMEWZ6dx3P3Dsr/zktRp04T1Y3fd
	2QCLgqAGarwCRRs7r2aHjYthhXAsWIEGn6O7CUIDLYuKBsACzy93J8NeWZ4PqUekJ1GrjtTIlan
	xJQxSUo64OoEB8bl6Lyw==
X-Received: by 2002:a05:6a21:7104:b0:3bf:7ab7:98a4 with SMTP id adf61e73a8af0-3c08edbbbafmr3058208637.27.1783380533372;
        Mon, 06 Jul 2026 16:28:53 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56d64sm1228725eec.17.2026.07.06.16.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 16:28:53 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()
Date: Mon,  6 Jul 2026 23:28:50 +0000
Message-ID: <20260706232850.3333016-1-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 735D27164E4

br_ip6_fragment() gets prevhdr, a pointer into the skb head, from
ip6_find_1stfragopt(), then calls skb_checksum_help().  For a cloned skb
skb_checksum_help() reallocates the head via pskb_expand_head(), leaving
prevhdr dangling.  It is later dereferenced in ip6_frag_next(), causing a
use-after-free write.

Re-find prevhdr after skb_checksum_help() so it points into the current
head.

  BUG: KASAN: slab-use-after-free in ip6_frag_next (net/ipv6/ip6_output.c:857)
  Write of size 1 at addr ffff888013ff5016 by task exploit/141
  Call Trace:
   ...
   kasan_report (mm/kasan/report.c:595)
   ip6_frag_next (net/ipv6/ip6_output.c:857)
   br_ip6_fragment (net/ipv6/netfilter.c:212)
   nf_ct_bridge_post (net/bridge/netfilter/nf_conntrack_bridge.c:407)
   nf_hook_slow (net/netfilter/core.c:619)
   br_forward_finish (net/bridge/br_forward.c:66)
   __br_forward (net/bridge/br_forward.c:115)
   maybe_deliver (net/bridge/br_forward.c:191)
   br_flood (net/bridge/br_forward.c:245)
   br_handle_frame_finish (net/bridge/br_input.c:229)
   br_handle_frame (net/bridge/br_input.c:442)
   ...
   packet_sendmsg (net/packet/af_packet.c:3114)
   ...
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv6/netfilter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 6d80f85e55fa..547879da9532 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -147,6 +147,10 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	    (err = skb_checksum_help(skb)))
 		goto blackhole;
 
+	err = ip6_find_1stfragopt(skb, &prevhdr);
+	if (err < 0)
+		goto blackhole;
+
 	hroom = LL_RESERVED_SPACE(skb->dev);
 	if (skb_has_frag_list(skb)) {
 		unsigned int first_len = skb_pagelen(skb);
-- 
2.43.0


