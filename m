Return-Path: <netdev+bounces-307351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i3vAAA24VWrTrwAAu9opvQ
	(envelope-from <netdev+bounces-307351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A38C750C77
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 06:16:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hWTfgGQD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307351-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307351-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9CC93035F31
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A44F261388;
	Tue, 14 Jul 2026 04:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2426CE11
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 04:15:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002550; cv=none; b=WQWzr/ImfkBo4pGwmaF55BPxQqUl9ODNDyybgumEhx3LVvdHUu3q+Vi31UoXxVUAT3vt6FGgKOqMViGC943QQ34+ygXLtEMl691xCdPmbwao+41WaLJmjayBYUcU9+GSzoExA+6IfvdpeJ1o7lbBhDVvwv0nax0Wo+Nkw2ZOlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002550; c=relaxed/simple;
	bh=afWvLS/cYXFxAHMXBcJzv64tOj8yN68WbzwctXYShxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCcTdlU+AVePJEE0rKehUjAjvXPBS08xTUuVFFlvJyesspfvCT0Rw2ltfNZtBVV+jqId4SPEU30SfH3ye0F3vDyD+24Kho9oqNqc2tguLWQwdGvMIouqm6usgiZ7uBoIbRn+eQp58MxrQKHvpJFEP6HlG0FvNim0Czy3oysH8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWTfgGQD; arc=none smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81eaf3709b4so12539277b3.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784002544; x=1784607344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ESYEMWGchpciIMXe2q22eOlRAskbyQ0zJX6joLipNeE=;
        b=hWTfgGQD/M69mkpStt7U3nn8xG2Ofemt5RXsFp3VKNtFTWDEP1DL4ng14Q/3hj2bSK
         FvVdApuJdwAZ8wNP6dnBAvZrTn+s2ItlkLvlSUTpM1gRtF7Gd586x3Z2KC6SpaiVBpKm
         XGDTF8Mriu8f8OxcwjmCw3tvaZNaMjR6xGIz/a9xbmS7LfsEpiAs0XK+j02YPTBKghZ1
         h03qvFG+R5zpv2YnhDQn98BUI1HOoQ2S0xhZUg/PCPnfvon9xfC0Jr1u0yZUCClA0s8r
         0O6hzO/gHIkKsfyhn+8+vSCIK5zZEycF0o6Gs7o7++/EIow7DqXxJbPsyrtmjwMidWRr
         MTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002544; x=1784607344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESYEMWGchpciIMXe2q22eOlRAskbyQ0zJX6joLipNeE=;
        b=JpmGA/c+FACqQ2lU4++dN8a5swKtyUZuBF8/Og0Ie0bag6l8edm+z1lh4A6n1Hi8jv
         r04FD3GbzehCOyxxYP0pZGixTmUHPjK1M1EIhX+ieqrd10jV4faJI8XpfCexDcpbOXog
         V/ilsRUepK84t+cImXgTXoZtuUTl58VNCgVy/wJ8f0QB8QxRp/9u51xYuuhQOmiIidL9
         nY9YMK5eEoeGUD7NI8rmsBlQ+wMuM52MTUpgnQTfM+DTMoMNmO4A3VL5KMEhMd4YZTJ6
         cRK7fDEatmKUB/mHEw2I35x48a+pcfEtQUK/GpgkPa4eGr6NLQUbShB7tS2eJZUfyaMr
         8wtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr++y91I3gdEK2ghN7HenmD83xkOYrPr6kmckbXRdnMC9MdS13xGPkt1DKWjaybYnhctM/DtjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9lqHZ68nOwQQrT6GovWqQ0AM/0VcPGG5nkYVumiT9yVCq07i
	+2UrevAJX+Fh15XQryYe19DbrGaYVQe/HKJkHsk5Wr2UQIKRuYgJaUOo
X-Gm-Gg: AfdE7cmtmiTMTuE4tqjZVOtmostEtZ7PPImVaC2J4r62c+wHRBGuf6awwX5KXPWTVDq
	9VfOysucTsfumSkXguQsDTh9+R24Az4qSGgNGqBxqlzSFhrW/J7NB9K+HiTucAzJSyLgBEeEK+U
	Wilcft8Nt7EDGO6E+ESikNoANRq0OC0IOsQ1pJJRYmQ4sy1sH+N3Q7HbkBipBFgAJPzLOyg7Aj4
	xOQvtuqHc6/P+D10rfF+ihlyxwRFd7oAUbfOlHhOisYi4sqVBIq/qB5htB78XvGom5CwOimYm+I
	01nLMahVhA94XbJy/Y2P9BlNiy/6c/9IuEFVSddv2VFTDydBqxoOBH31QTj5xfCz37205Cs6I6Q
	Id8MhucGtreZ8upj0uMti/tPiyBa0P/bMJU496X1uIthK4JR4SAWVFOvLlSLNfmIS+wCYQ+Q4E2
	8C7iKnQlDTIudvk1HbyGee93nHaDfEJQ==
X-Received: by 2002:a05:690c:6908:b0:80c:76fd:f732 with SMTP id 00721157ae682-81ebfda5ec5mr5483077b3.26.1784002543913;
        Mon, 13 Jul 2026 21:15:43 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c22441csm132955717b3.43.2026.07.13.21.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:15:43 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	tung.quang.nguyen@est.tech,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v5] tipc: fix u16 MTU truncation in media and bearer MTU  validation
Date: Tue, 14 Jul 2026 00:15:41 -0400
Message-ID: <20260714041541.307702-1-blbllhy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:tung.quang.nguyen@est.tech,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:blbllhy@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,lists.sourceforge.net,linux.dev,est.tech,microsoft.com,linux.microsoft.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307351-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A38C750C77

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
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v5: Drop .min from range struct (min check already in handler)
v4: Add .min check value
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


