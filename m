Return-Path: <netdev+bounces-307443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PesrAkwmVmph0AAAu9opvQ
	(envelope-from <netdev+bounces-307443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AED754446
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 14:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=svBsPqnv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307443-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D3D31DF1FF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4DA38C2DB;
	Tue, 14 Jul 2026 11:49:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180C4381EA8
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:49:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029750; cv=none; b=NYFNozldtfxCrqnFj9pFNdhTRlbYzI7K6t1znbX9J/ebmhiJdhblfJjsRywN0WEW9m0hY4UVVSrN6TxG7tUFahXBhYqr5NJMEpRSzWDWtTbzQ9qic2IsST7h8zU/JW2PVvMMkjzgMDwwnYwRcuhiVIsVxRuksYp7LTyzeoE5AoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029750; c=relaxed/simple;
	bh=ZGYvGbRP+oXuIcup1YsFuHoUmTi9k6xwxTD9TCdJ5qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUIokS1gwWOlghKeKASoehrtRmoFeBwFAnPwnN5oP7p/xo+yqfJb3ZqoQXvxXVJGwT3XNxF2YHxrWQtOTWqx9fCoScUmgTM34N2y2AEmu3uayS9/JCNz8AUUZ29DhrqTt9ESw6y/Yg8eRU/l0KEFd9YmxN4R08rpPo+MxLCmodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svBsPqnv; arc=none smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e6c4a867cso56248485a.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029748; x=1784634548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JUpepjd+suSCp2cPlkh7EA3gKkiN6bvfQtDVC0IsC0=;
        b=svBsPqnvkfvOh7NfF2v/W2O1G/xVRiQ1CYms/5QQcPbKrP86JXGBzWXil0GWK76PlT
         iccXMG8hC5ux0WGtLTTq/WYtEjSXbW+RpKgXq4S2EkrIDfLayt8/q+CFdCWxc3ZteKYS
         Qdos3iQqkJDuwoXnCh4iKL8qW171KTCTvJjOJxxfb+EytwDbR5fEsF1THk0HOSOO/0C3
         ZNtTV5EPnc6IWSdHr4sTqOu9PEBvbyP/VNDk8lDmAIbgyuPtz1ShP8DbrTNDLRGykPn2
         MBQ23o24jGX/SpuCG26KYnEmMY1rMtseq2A0CCWGf37ry6ssuWf9sng86RBaES8PlhZ8
         LOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029748; x=1784634548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JUpepjd+suSCp2cPlkh7EA3gKkiN6bvfQtDVC0IsC0=;
        b=ZsUYxtFq8jBeiVD5Zr7sxgj400Wk+/n8wu1/0dZyR8cZyNAaxkupIKdPGKUNo5qE0P
         bZJceSPTDU/XzNKkWqpD0R/PoEQzh7ZL94HOKbgJRxdQtheYsTJNmyzjOFn/cpObTuYU
         uGza6WkzKlFVbPD5Zc8n/n3mfhdAR5QLZNoIG8XsLbhVF6CttZ2HD6Nhw+9IX2PCr4Xq
         4cw3+mLwfYGw2LH5au60d67IHzuy+63MYHnCsjr99xo3D3JyA7tmGsbh/9kChGrQ6Czw
         se0I1A8rE6L1p1cwmrFhTpKoWC3PvchfRO/v2kFZlSmUZzdDrGr8h4umHAZBGzEqgmpT
         cPVA==
X-Forwarded-Encrypted: i=1; AHgh+RqSCCX0uWxiZZUVFTx7CmSjg8JYMPTdU1pfNhQIJFBhliI54CbrQ6dJPGEi81I+VIBqArkatC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmc5IFPem0Rqz4cLp8gvh1ek5fYxKmobqposvPkAM5K1Ayxz8
	4C7IhMTSD1dDsoSByOyF4D6qq7PgewkNtRohtRXAoxZkpCE1Su5goPrd
X-Gm-Gg: AfdE7cnMCP3tbJ0ky8IhZF0znH2+SOl+Pxq+Lo7cAbwYQCcDt0ZYDyQITsg6Ibjun1x
	p4helxMdOtQDNn7FSBjpGe8EcfhEmGEevVOesJKFt7FDdeWTESJfXz8WSQ53OlDeUO7/IQ12sdM
	tGUds7bL5UPTTfp81ZgSPK/PhYIPv2ejhJ1JzpL50c1MxjPG4YEr8O/I3zBg3KlRtr/qv644/Xa
	bjrEfVzAyDdHi9tAWc93oIKVOrISQQ8YrWTOVYjQAv8CcgLOMoT5MWhnMGXdWTNcUF89rKOBpof
	wfFBLYR1z6u1PT4xYk1V+a8kTmLKkOzfHhCJzta3nYcszmO3wTERf8Vpct+fqD72tVI9MW33Y+U
	I1qhsY0yhvDElM1QH5FoKa2bFVN42ugPQUmTlKB9kik3W5v8B/1vYzXZmvFgrX/FAO8FoPZut1R
	r7M0qMc9myIDhw0yySf4CL3WXJ0X/SzZJuLQJ7PAPbrr/SLIfENIeV7z4FDaIM865q22WGf2Y6d
	iLtUwPUBg==
X-Received: by 2002:a05:620a:258c:b0:92e:54b1:2881 with SMTP id af79cd13be357-92ef2bb787bmr1289546185a.16.1784029747886;
        Tue, 14 Jul 2026 04:49:07 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5baaab7sm1500521585a.19.2026.07.14.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:49:07 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tom Herbert <tom@herbertland.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] ila: reload IPv6 header after pskb_may_pull in checksum adjust
Date: Tue, 14 Jul 2026 07:49:03 -0400
Message-ID: <20260714114903.3763420-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:atenart@kernel.org,m:horms@kernel.org,m:tom@herbertland.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56AED754446

ila_csum_adjust_transport() caches ip6h = ipv6_hdr(skb) before calling
pskb_may_pull(). On a non-linear skb whose transport header sits in a page
fragment, pskb_may_pull() can call __pskb_pull_tail() / pskb_expand_head()
and free the old skb head, leaving ip6h dangling; the following
get_csum_diff(ip6h, p) then reads freed memory. ila_update_ipv6_locator()
uses ip6h (and the iaddr derived from it) again after the csum-adjust
call and additionally writes the new locator through that pointer.

Impact: a remote IPv6 packet routed through a configured ILA
csum-adjust-transport route or receive-side mapping triggers a
slab-use-after-free in ila_update_ipv6_locator() (KASAN). The route or
mapping requires CAP_NET_ADMIN to configure, but trigger packets are
unauthenticated once it exists.

Reload ip6h after each pskb_may_pull() in ila_csum_adjust_transport()
before the csum-diff read. In ila_update_ipv6_locator() only the
ILA_CSUM_ADJUST_TRANSPORT case pulls the skb, so reload ip6h and iaddr in
that case alone before the destination-address write; the neutral-map
modes never pull and keep their cached pointers.

Fixes: 33f11d16142b ("ila: Create net/ipv6/ila directory")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: In ila_update_ipv6_locator() reload ip6h/iaddr only in the
    ILA_CSUM_ADJUST_TRANSPORT case instead of unconditionally, per
    Antoine Tenart's review; the neutral-map modes never pull the skb,
    so their cached pointers remain valid.
v1: https://lore.kernel.org/netdev/20260711150648.2915106-1-michael.bommarito@gmail.com/

Evidence: a KUnit case on UML+KASAN drives ila_update_ipv6_locator()
with a non-linear skb whose transport header sits in a fragment, so the
pskb_may_pull() in ila_csum_adjust_transport() reallocates the head.
Stock: BUG: KASAN: slab-use-after-free in ila_update_ipv6_locator, Read of
size 4 (the stale ip6h/iaddr). Patched: both the valid-linear control and
the fragmented case pass, KASAN-clean. Built clean, no new warnings.


 net/ipv6/ila/ila_common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index e71571455c8a0..b78179bfc4c72 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -85,6 +85,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct tcphdr *th = (struct tcphdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
 							diff, true, true);
@@ -96,6 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 					(skb_network_header(skb) + nhoff);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
+				ip6h = ipv6_hdr(skb);
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
 								diff, true, true);
@@ -110,6 +112,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct icmp6hdr *ih = (struct icmp6hdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
 							diff, true, true);
@@ -127,6 +130,15 @@ void ila_update_ipv6_locator(struct sk_buff *skb, struct ila_params *p,
 	switch (p->csum_mode) {
 	case ILA_CSUM_ADJUST_TRANSPORT:
 		ila_csum_adjust_transport(skb, p);
+		/*
+		 * ila_csum_adjust_transport() calls pskb_may_pull(), which can
+		 * reallocate the skb head and leave ip6h (and the iaddr derived
+		 * from it) dangling; reload both before the write below.  The
+		 * other csum modes do not pull, so their cached pointers stay
+		 * valid.
+		 */
+		ip6h = ipv6_hdr(skb);
+		iaddr = ila_a2i(&ip6h->daddr);
 		break;
 	case ILA_CSUM_NEUTRAL_MAP:
 		if (sir2ila) {
-- 
2.53.0


