Return-Path: <netdev+bounces-305939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MAQ1B1GTTmrwPgIAu9opvQ
	(envelope-from <netdev+bounces-305939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:13:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6417E729704
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:13:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=VD+NNV33;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305939-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305939-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D4E3014960
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC923BBFCA;
	Wed,  8 Jul 2026 18:12:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D743B95F8
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:12:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534328; cv=none; b=BIeblJB47t2O1G/7EOAMZiyzkLHeFoxyXb4f/FSjIjTECMu3yC8fPk/smImnM4/Fr1KdPgHyKYIWlekSfu+lyC05kgcBliT2NexVR2mF6cR8Zrt0xzjCAy6GPhL01yosY1210pHHwx1tWQkn3a0ccECPiADENehTzXWiECd/X5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534328; c=relaxed/simple;
	bh=l8GFelL0rMozLzXKhSXMvAK+Hz6wk24SoDq74J3vLDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6GCZM9OZVHUot5fdXtvky7Wk3UWDodyo0euBDdpbkmCFTStdA2J8bjjl0mOtUFx74fDwSm4YzJ9tHdpKp5r56YigDauT/8w3H8331si5fJg5XdunISt79pFa3taymHkj956xTjVhCJ8Ef2sPSQBNRTgDK6DiSbqpC8yOemYnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=VD+NNV33; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso913830a91.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783534325; x=1784139125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0BR+SF/CxmhPdAIZMWxo2CbL+bjRHrbqDrG5ybWBgFU=;
        b=VD+NNV333+ei9F/wIwOZ098hJ5gmuDxdOhlEiQALpevUZ3bAMUAi5Dd9RevhLGFHlX
         N7unnAsINveskg1JFr2m5ZTbdGN8IUrRHxAZy4DL2x4aBwSCy3thSrAo44C6GfKt7AFj
         eLUS4yzK9rqOqDuIrWKk1+o2LQxFasmLTETvI2Y8z1cCehonnPmU13HYx6+zgz3omcrK
         kIgpTwTriCcx87F4ubwph0MXAPtAvxpSSd3WFVu2d1YwY8BD83omfu3qKhNZz3+mwtmT
         TKcH0ChVLZByeRQLe4q92ifSR26E4nO5eWLIGSOorAmzbrrXt+xDHWaLdW+whl5FWn/w
         zCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534325; x=1784139125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BR+SF/CxmhPdAIZMWxo2CbL+bjRHrbqDrG5ybWBgFU=;
        b=R+u5hatnJKwpSbfRRJ3K5eB8uXYrkcrPxpqpbmdBzgk3lxOBa90XxByLRKQAGqqPa9
         BOYno67qqqDlHa5F9OWOX9c9xQXHhCOX4QUXZ2gkiznqIP7u7pSCM4Xvnbpeq6PuAuQk
         p7xFMZzbeTgHEOh1K0Ziu7NCRkd++ZZWvyaIAml3X49l+j8wuxnduJJmXVXNelTUg/z6
         pyuSuobLDY8uiTL2ci3p3PH0MYAZRHgMxK1GAo4Wy71YUK/Aa4r7yiLDCE0npiRGSngZ
         A6X0UWkxgzKxqZFEWe+qHcWgNyqCwbcitkZIsNR5o4RmTaFq3rEdHoXYt5B6dGJZP+g3
         UCtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFgLkY7H4B7tQrR0n+P3b9rlufuVJCPuUERqQIrDutp1bCrLJvewZ3EUWDEVbKsks5AKS3M10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiztOOTJBLLSl4PiZSjXOaYG8rRgdXte0z0TPtVM4EtZ7/nJNA
	OO+P/qxgfKUC/DBAHLtmxXgJHXgv5Z1Eq3C0VR00WWkN+WvrfqQufEgC3q6XyhZqXQ==
X-Gm-Gg: AfdE7cnjkdYftXFLBYXUTburyZ/kSOIX5oDcAmXs9ZhrWHBm6hq3ai/4uQAUKoDUcaQ
	l65sfZGuym57SUDhGdWh9nvxUYSFm3UlqrMnTqc60v7EMz/+JRycNFNQ+ZLrsZrmTDm8EwJDKEe
	AvzTXxOiM6fr7FuNun4qu/8yAspq/KGsyIg01BrjBPR8dhOeVadi0L0RU0A9R824Z8Uw0LOmlgc
	xXEV9ENAjaDicn7KyLkcyHtBtEG8NlJU48HG36XFLBvXhGkCqQswNQxdW3pQZueG6X3OJB/IKf6
	uTAE2+kRZ5Bld7IZ3ceS7gXa2XsU5p/1jyRzOLApqvxB6aeMrDfENGlpHXJ8AegnbiAVqG+lVTS
	FGnOpjW+G7M1Lc22HkH+OAPutDGh8K6QBxLQUCb2ePApo31Nw91rx2zqdCdKNikkaO/aSjd+p6M
	zctuzznlspe3g1QYFk3A==
X-Received: by 2002:a17:90a:c106:b0:380:9d0d:7ade with SMTP id 98e67ed59e1d1-3893d33d9d4mr3982591a91.0.1783534324758;
        Wed, 08 Jul 2026 11:12:04 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a56848sm23336464eec.16.2026.07.08.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:12:04 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
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
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH net v2] netfilter: bridge: fix stale prevhdr pointer in br_ip6_fragment()
Date: Wed,  8 Jul 2026 18:11:50 +0000
Message-ID: <20260708181150.3944015-1-xmei5@asu.edu>
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
	TAGGED_FROM(0.00)[bounces-305939-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6417E729704

br_ip6_fragment() gets prevhdr, a pointer into the skb head, from
ip6_find_1stfragopt(), then calls skb_checksum_help().  For a cloned skb
skb_checksum_help() reallocates the head via pskb_expand_head(), leaving
prevhdr dangling.  It is later dereferenced in ip6_frag_next(), causing a
use-after-free write.

Save prevhdr's offset before skb_checksum_help() and recompute it after,
like commit ef0efcd3bd3f ("ipv6: Fix dangling pointer when ipv6
fragment").

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
Cc: stable@vger.kernel.org
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/ipv6/netfilter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 6d80f85e55fa..a7025ec87035 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -120,7 +120,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	ktime_t tstamp = skb->tstamp;
 	struct ip6_frag_state state;
 	u8 *prevhdr, nexthdr = 0;
-	unsigned int mtu, hlen;
+	unsigned int mtu, hlen, nexthdr_offset;
 	int hroom, err = 0;
 	__be32 frag_id;
 
@@ -129,6 +129,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		goto blackhole;
 	hlen = err;
 	nexthdr = *prevhdr;
+	nexthdr_offset = prevhdr - skb_network_header(skb);
 
 	mtu = skb->dev->mtu;
 	if (frag_max_size > mtu ||
@@ -147,6 +148,7 @@ int br_ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	    (err = skb_checksum_help(skb)))
 		goto blackhole;
 
+	prevhdr = skb_network_header(skb) + nexthdr_offset;
 	hroom = LL_RESERVED_SPACE(skb->dev);
 	if (skb_has_frag_list(skb)) {
 		unsigned int first_len = skb_pagelen(skb);
-- 
2.43.0


