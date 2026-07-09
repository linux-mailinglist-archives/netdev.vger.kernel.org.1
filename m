Return-Path: <netdev+bounces-306380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MZsjHusPUGoWswIAu9opvQ
	(envelope-from <netdev+bounces-306380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:17:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6163735C97
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:17:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=E5paYggi;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306380-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306380-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB98730056FE
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2820324BD03;
	Thu,  9 Jul 2026 21:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A94499BC
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 21:16:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631816; cv=none; b=SNGuVPYtV/rSSb02LCHNkEnfTeMNIXNnX8HIIvjL0qvMArpFiTIgCYXiYgwZ54rTK3LixvdWNiu0/8N1AITyKBN9lxOFaNmSuKdkgYZEUQt10Zf7h6A62EbRzf67gWrVaV00aVuNHNn6PL1HB31iaTgd7uJ+UW+AuGaCeyL8K4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631816; c=relaxed/simple;
	bh=ITcmAR28D9x34xMJ7fApPn3navDVPamhMlArvMDcrbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siPLmm2AXLvIGZNQ5KEDsNxcq1z3tRnfj6BPuf7VmZ8mUwBqJVAIlJ/HCZoXsTUxepR11/Qle0GVOMC92xXzSCw8tziZHf/QjpsRmhBMN1rLO4y0vmda/Gud09/Jx8AS9wDjd2Cga2DPbeUs0j4YN1r9Qed/DPJbeBQqh5tBYAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5paYggi; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacd69a9c0so1935665ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783631814; x=1784236614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ATdWzpNsuy4ncMH5UuKhJxOCqAncc07e1jE8JqU6+0=;
        b=E5paYggi13IOV8UZSJwC9wlbxCF5oRMu66nczQsowGzYvx8gDD+XvuTsY92aexQJZl
         0A9ILk6TBq1cXc8RZ0NHKZU8lnWup2tJFXn+65V6qeWA28XGj+nWLhl3xkUaqWawqIDn
         xU1inahYpw9wuy5trKa+gqsYf0eKg5IJcdkeOa0Chmodj7IbbYpTtyWIlX44a12sX3un
         4bEwzB/SD/wdRXpNoSvqHTV3OpIai3dYJ1atwQUWODILuw+fZkvpAZpKSOtkTeGSEQ7w
         zSgwE2Ao3DUtKrRbl1eHgw2k0O4uQrMODuj1hIznemV2tsIBsyet1GivZL+B9his3Pk0
         gK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631814; x=1784236614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ATdWzpNsuy4ncMH5UuKhJxOCqAncc07e1jE8JqU6+0=;
        b=hazEzShlMz411vyeqZJE+Um4AHHZIXxKod38na/NKZIWMft4iOltThAQkIaEXRhP1Z
         hUL0Ym4pZ8F4d7RYq9wsZNxEkng+WghJGdYC0gBe7IotEG81TpyJzisVi6gehgYQa5An
         ibSOuPlURhItvSnzaAxkXW7r9I3JlScB2k0iyDJbC7Jkm9orSfPH72gC8P/K98iN1ZZE
         lfOv9awbfGuqFKQRW2iqSimmJh9I3fO0Fsp6lE+5Zk0XjfBm+XZ+iVDBunbXD8xLfoLe
         r+sqK1EBY0D13U0Ruih9ptUXKeN1JTiI5Vdh2xQr5txXdjv8aF/F1KJO0+K7cs64wcCT
         uCAg==
X-Gm-Message-State: AOJu0YyjrV51GSUXe5bE+Setmb8XkDqGMq2xYxwUc7482RqLBbyz6mey
	qatGoDa02dm30UDYuLncuTVZSHipFWKDHgRurSYw+cm/WIVzidJYXMrL
X-Gm-Gg: AfdE7cmnXWo9Vh2CjRqZos0xj9xDdATeWGLEhdllcRMUjQYqeJ89pzEwTOBdAZeDRyf
	Tu5rXUEWThVtldtCmniTYei4748FV66veStGPY8DWPuWcc20BuC1UaHaq+q1/eXwvozUWuvIiJb
	u1JlQLAAv/ULqqzaiXNWADuZkKV28KpJcjcb/nBgu1rd35x2kYBEPFPvXAd/IYZq7t3oExLhIMh
	yDz5ZR4+BAYAqjjZpRcIz9ry5Vypn7rTFsh0cbk/ACIpOvGQjdMCnn1CFpZgMMY/AwkVOPfp4Pn
	ycQPW3V81OIvl5tS4QbaSMgKAGIGAfKZAvfZDDA2D5yH6daDEJos/x4fO9vQ5fLmwH0/iAM5AAB
	7k/P+5kVXhAV2+Aa89my1dBePzh6oP0QnnTAUjttRSbHTRF3XQlaFTDROnwA9q9nWB4NIdiBwpB
	QNyQr3ODZdlURT569Wb+5XdKPcn4mdzw==
X-Received: by 2002:a17:903:234f:b0:2cc:f4d4:29a6 with SMTP id d9443c01a7336-2ccf4d46bfbmr69326175ad.23.1783631814146;
        Thu, 09 Jul 2026 14:16:54 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.148.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb7e9sm51768155ad.10.2026.07.09.14.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:16:53 -0700 (PDT)
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
Subject: [PATCH net v4] tipc: fix u16 MTU truncation in media and bearer MTU validation
Date: Thu,  9 Jul 2026 17:16:49 -0400
Message-ID: <20260709211649.15623-1-blbllhy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:tung.quang.nguyen@est.tech,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:blbllhy@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,linux.dev,est.tech,microsoft.com,linux.microsoft.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306380-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6163735C97

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
v4: Add .min check value
v3: Use nla_policy check to limit MTU max value as suggested by Vadim
v2: Solved format issue
Link: https://lore.kernel.org/all/CAB8m9WgETt0AjmFwE=F-CKjGXsK6_WDv0=kbYRcC8-noo+amnA@mail.gmail.com

 net/tipc/netlink.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 8336a9664703..811438c44542 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -113,12 +113,17 @@ const struct nla_policy tipc_nl_node_policy[TIPC_NLA_NODE_MAX + 1] = {
 };
 
 /* Properties valid for media, bearer and link */
+static const struct netlink_range_validation tipc_nl_mtu_range = {
+	.min = TIPC_MIN_BEARER_MTU,
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


