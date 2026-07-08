Return-Path: <netdev+bounces-305936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GgOuLLqQTmo4PgIAu9opvQ
	(envelope-from <netdev+bounces-305936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:02:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA0C729658
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:02:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="M2/G98UO";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305936-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305936-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0FBC3008D01
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C5352C4E;
	Wed,  8 Jul 2026 18:02:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324D26738C
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:02:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533739; cv=none; b=Vvak9cBaIViYXgvD5riKnbhUI06doLbx/HxtHe48k3XvgNh/aJJExuDoboH8hCsIFXF/Edt4ZJPF1jmypde3/28/BllH/M4HgvCxxqG7UnUxN/S1QtN2wrMkIFRAKPnDr/vh/KtJNGX85lwlg1bo795dF/EitNE+XMj9hASI0bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533739; c=relaxed/simple;
	bh=HB7D49pgEoqmzyTNVZbsildpmELrQbgXCca8WIaVsz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nr1gyrkUu4Y45XqjbB7UDNLiqggHmXnzrtIcsV4zbvly4a6+15oHiAN7JEKmhFNXsuiPsOhzFaNUf5yVQl38lal9wqLteFJS2z+D0H0udvf4a1BlvP2MKx9hgE3wJ4+MHXmEd/cduieIqG1Y7eg8s+02bsGBMTq3AGIWuUlEBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2/G98UO; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso10920015ad.2
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783533737; x=1784138537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QyP0yz3whZxHUBr9KeKTxs+Udw0ktHFokyB2Fg5F2IQ=;
        b=M2/G98UO9+JZHioMzLonbI/H0abucOJMzPyNlAXBb/35Q1BDaZlJ36nT40a7oPL+Bv
         pzvZ+Q22AiwWNc1/fJq3zz6rxpFfzOtj0t8dYGaKWcFalCb+/JvC+ezNUsyzltS3QN5u
         t4y4zBSXR8arZuJUolxo2+MqxRErfuaGfrSXJfVA9UiVIkknnL/mfVKuCkeK/8TTY3l9
         5Hsoc5yWfMY1gHtotwoaPVSbuOWbEwU9hdHSgLrJ7tJEIzfmFC1GDtrYyiKKd53rhBoE
         RglCMHST+WGlET5dhtApER3rTWMmXFNtQc471uK4iuy7ElJEt1Le6QPaBC2LMvM6lhsh
         7SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783533737; x=1784138537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QyP0yz3whZxHUBr9KeKTxs+Udw0ktHFokyB2Fg5F2IQ=;
        b=Er4AZuQtX7LmMOSRHj+gxflnKlwIOgHGf/lQasywBE5+5Lj11SmQKAtuoDJtmOFL/A
         CGxf5SaRuiec4aCrqMu1ozq7wKGLgcb2rJ9eTvpGY13M1yd9rySt3/EZ0YNbjgRPbUkD
         UXU9iSm+/RbOY9tyc0nDZ4Bf6u+Zk/tybK8ZHart/RUEq9E/gTFgTZPJBGnrVepgDm+W
         SEzsG296tdur1KLOkHNWSrtFc77WzloZQ1dJArRCXmjLBltHvyHYsRC6ixTiqHG5NU0P
         44kHTKrayeRruKEiPM/iOKYjaVHqNpmzk8cUDv/p440pwIGIMqewCjwuMb11XZ+t79ez
         Id+g==
X-Gm-Message-State: AOJu0YzitZ8DZOlkkDSUeUmFaDwNdqxVQO1nES+Ux95mw3xwJ2MbLv6J
	RFQQ/lG1mwDRTtikcsK2+8o3nuu9BzBt7bm+BEeh6loLPkgbR4pl25UF
X-Gm-Gg: AfdE7cn00siRM7X+NUGdedt6FxYEchr3iu2rugCXWSJsUJlXwLRI4VQ4+mGtS22+mvg
	JY0B8ToLcWj34ZTdWx0ptX/BTSqNxRz+GUYwEgsuW5oef4SHE1yoSHOd4OXA1Ye582MTv6LI4Xe
	LsZ0PYoxyrKFzn+r8QZNFnbq+ebweXC1OmM/xMD45Y/m1RUOIpbgfxmA6B4R2FZHbfmvncLg/Vj
	1ranDqFxtVwKMZGNlG81uvRokwSFYMWhmKp9VJqoCDSNRsOLoL8hTZMy6fz4aB+Na3abZxrzD+l
	SkM055EHERKg0oS1goBBna4qNzzjNlZ1GJ71Eag0rLxObcLvd8iZ3qL/fheHRTVZePGPMyBkoqJ
	tMM49e8ODm/ICs+aUTloognv/uyR/n/6q/vGS5VhuHSpYIRx4Vt9H9lzHBOeFqEJ6Q2JYl0KQct
	xc5zV/qdNYA79pWxbBnoeiJgz+U6O2lQ==
X-Received: by 2002:a17:902:f60b:b0:2c9:97a7:f540 with SMTP id d9443c01a7336-2ccea433949mr38216405ad.38.1783533737107;
        Wed, 08 Jul 2026 11:02:17 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.149.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e29asm31352535ad.52.2026.07.08.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:02:16 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	tung.quang.nguyen@est.tech,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v3] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Wed,  8 Jul 2026 14:02:12 -0400
Message-ID: <20260708180212.2898-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:tung.quang.nguyen@est.tech,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:blbllhy@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,linux.dev,est.tech,microsoft.com,linux.microsoft.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305936-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAA0C729658

Both TIPC_NL_MEDIA_SET and TIPC_NL_BEARER_SET accept user-supplied
MTU values but only enforce a minimum bound, not a maximum. When a user
sets the MTU to a value exceeding U16_MAX (65535), it passes validation
but is silently truncated when assigned to u16 fields l->mtu and
l->advertised_mtu in tipc_link_create(). Values like 65536 (0x10000)
truncate to 0, causing a division by zero in tipc_link_set_queue_limits()
which computes TIPC_MAX_PUBL / (l->mtu / ITEM_SIZE). Other overflowing
values (e.g. 65537-131071) produce small incorrect MTU values, resulting
in link malfunction behaviors.

Crash stack (triggered as unprivileged user via user namespace):

  tipc_link_set_queue_limits  net/tipc/link.c:2531
  tipc_link_create            net/tipc/link.c:520
  tipc_node_check_dest        net/tipc/node.c:1279
  tipc_disc_rcv               net/tipc/discover.c:252
  tipc_rcv                    net/tipc/node.c:2129
  tipc_udp_recv               net/tipc/udp_media.c:392

Two independent paths lack the upper bound check:
1. tipc_udp_mtu_bad() -- called from __tipc_nl_media_set() (MEDIA_SET)
2. inline check in __tipc_nl_bearer_set() at bearer.c:1160 (BEARER_SET)

Fix both by rejecting MTU values above U16_MAX.

Fixes: 901271e0403a ("tipc: implement configuration of UDP media MTU")
Reported-by: AutonomousCodeSecurity@microsoft.com
Closes: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v3: Use nla_policy check to limit MTU max value as suggested by Vadim
v2: Solved format issue
Link: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com

 net/tipc/netlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 8336a9664703..1307dd1a9613 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -113,12 +113,16 @@ const struct nla_policy tipc_nl_node_policy[TIPC_NLA_NODE_MAX + 1] = {
 };
 
 /* Properties valid for media, bearer and link */
+static const struct netlink_range_validation tipc_nl_mtu_range = {
+	.max = U16_MAX,
+};
+
 const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 	[TIPC_NLA_PROP_UNSPEC]		= { .type = NLA_UNSPEC },
 	[TIPC_NLA_PROP_PRIO]		= { .type = NLA_U32 },
 	[TIPC_NLA_PROP_TOL]		= { .type = NLA_U32 },
 	[TIPC_NLA_PROP_WIN]		= { .type = NLA_U32 },
-	[TIPC_NLA_PROP_MTU]		= { .type = NLA_U32 },
+	[TIPC_NLA_PROP_MTU]		= NLA_POLICY_FULL_RANGE(NLA_U32, &tipc_nl_mtu_range),
 	[TIPC_NLA_PROP_BROADCAST]	= { .type = NLA_U32 },
 	[TIPC_NLA_PROP_BROADCAST_RATIO]	= { .type = NLA_U32 }
 };
-- 
2.53.0


