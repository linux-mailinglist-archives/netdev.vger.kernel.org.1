Return-Path: <netdev+bounces-296139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b5EtIV1yJGrS6gEAu9opvQ
	(envelope-from <netdev+bounces-296139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:17:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072CA64E1CA
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 21:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Ln+/B2qm";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296139-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296139-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F9963059304
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A03B9D98;
	Sat,  6 Jun 2026 19:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C823B9928
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 19:14:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780773280; cv=none; b=Kf78G/49j8ErseUYDJ64HdMe2tu3O/1NDGfAzvlGpzhKNeXMaQM4/nXa1tIKSc266E1DU0O+exPcIkr0OeWBjdG1E6MdB6Xv1liWCR/rydjSn2dMUo33wGkECSMUGqARJPYnLlv3ZBfXdr5MMIS02f7cnzIwam5JBWQJ5cVQCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780773280; c=relaxed/simple;
	bh=Sszw50rv7Mg6jDvOqu2SCztJ2ULaCV1KTY4lCVzTXto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETBwOWgg7lDxCG5eN6juM3SQwvoEcLEqtz9g0ePmCwd4HLqwJBY3LKMzuczm5hrc6NFn4+E23xXlifRiPVVxbOPmOE2KhgqRaLK7buVcN0OEpuY/MuNqa1yHmRDN9NkP64qoVGgA7juLTlEoOFdxQ0zbMam+t4RusAkM3x2gaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln+/B2qm; arc=none smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9157ec935c5so504953185a.2
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780773276; x=1781378076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfUjtqhjGzKf7MdV0m9WZYbk692GT90GzFkKCPUMcRg=;
        b=Ln+/B2qmTQNq07p/Nbck6PrbFlk5Mimj5UxqFI1z2Wme+rbPGSO3OuogDgNs4fq0AU
         QU6kAvLbxBhzfBi5o+9kVrSGLWahwkNhyNSe2NIKZpwtELN6doR2GuZTq2ZmxWu/XX3n
         374WPn3kXE150Px0iXSqlGMmlUUzcbKGiWCvPvYXaw+rzRCE+5Xz6o72H6o2isaGzEy4
         D1Qb+plShmmUgom9ou8ynJNgWKdHg47iyMQFHgXyJerMCdKTCrwxbySdKnk8gk7Bdckc
         di3bwwHysXW0JrBiK5d6HmDZgadYfuBEQLXEtdi8c7rl74YHudKy7rEo2DYXiCgelpo5
         TjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780773276; x=1781378076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfUjtqhjGzKf7MdV0m9WZYbk692GT90GzFkKCPUMcRg=;
        b=UgmLR/eMiKx1c+IcF6EMJu5rEESklRyEVqPkpfKjIhhSnuoL/I+hoiZ5MhYBWiZFAI
         MvBq9nt5uWpBSgfBYNFnb9Lp4Q0ib4HznqJoj7UAxT1AynQpE+bF+8IX3PyROd5HWVQe
         B4/SD2f1miCpMla8yEZZKiT14NDGLYm13MSFxn1Bxgu24zHzLu/cmqG8o9jto0rfS3M5
         Vl0GG5bbrWzAnaoQeYKd9SopSicYqeY5LqfRfTo34+ds/eWumoE/PYGHo00L/72Mfuhw
         TLz3UY/nEtorfGhk7cQ6vLgPVsPHXSRMF+KeaHKrcH2YNSFkMs9u0wTTiMr8V8JsuBUG
         d1Uw==
X-Forwarded-Encrypted: i=1; AFNElJ9Qac073/0MFoeMmW8/T5Vbxq/+qLBKNW7+RBjnr9cblieax9GeYl2gA3Nn2Un1eMb9T5KURWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DkG2MZxqKBrQdLQ8TW9EgwIbWKKKC6h3x4XWjwtzJDQBhdPP
	OjCU1Huta/u77JnWGOoFljqBIUESnml/hvk5lb2+XmbLtU6nVr8pSTh0
X-Gm-Gg: Acq92OFHPB7b/uin+AdtzySqsIbCnfxWEZIPLx4mPYmDMtqcSBL6RnLL6jNL+tBNYCU
	32pGSdZxG+fjF8jCkPOd79/yoa0aEKUyaypZHgXhIqUOE0k7L88OL1Jq6E4hBJUl6Nx50dBnmbI
	HKh5Yrjx//xckq2cdhzFelxtHeOF6AvdMWL7yu3GZCzrwf5fTsGCs3DIQm0KtUV++mbTjaFQ/4T
	4zhOklvTA4GtnEUKsoZOYbsGWThbnRCLmwDJC62mtwyoOZbtxAZrU+iP/20+VMIcP4/e35FDDRu
	ntTxFSrgmMvi7/mNrSiW39usWcIEeFRywwdAzIqEoRpTAWYzafa80o8nlcEDCq9PrfsiRrTSyF1
	qNP1ufBZ5prc7hmzNZlg1KwdEIJ/XBK01ACeWrVzFf67HaIKKUMmdEhl4kB+ztocSPFMy5eNoSJ
	pPv9c/rHXAmUxowJeJ+jdk/ewDZYS8uOyDNib2nk/ZwNqbwwmoUmWKxU0oC6ydluWbToZjHrn37
	8hOjAv9Dr7H4kv1OmRxuPJJKDWlsdo=
X-Received: by 2002:a05:620a:448e:b0:913:7bc8:79ac with SMTP id af79cd13be357-915a9cc4880mr1489857085a.26.1780773276142;
        Sat, 06 Jun 2026 12:14:36 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00a4f4sm1311699285a.3.2026.06.06.12.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:14:35 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/4] tipc: reject inverted service ranges from peer bindings
Date: Sat,  6 Jun 2026 15:14:13 -0400
Message-ID: <6691aa72214b0741477b479ffe5eb2b272664da3.1780766454.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766454.git.michael.bommarito@gmail.com>
References: <cover.1780766454.git.michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296139-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 072CA64E1CA

tipc_update_nametbl() inserts a binding advertised by a peer node using
the lower and upper service-range bounds taken directly from the wire,
without checking that lower <= upper. The local bind path validates the
ordering (tipc_uaddr_valid()), but the name-distribution path does not.

A binding with lower > upper is inserted at the far end of the
service-range rbtree (keyed on lower) where no lookup or withdrawal can
ever match it (service_range_foreach_match() requires sr->lower <= end).
The publication, its service_range node and the augmented rbtree entry
are then leaked for the lifetime of the namespace, and there is no
per-peer cap equivalent to TIPC_MAX_PUBL on locally created bindings.

Reject inverted ranges in the network path as well. A peer node can
otherwise leak unbounded binding-table memory by sending PUBLICATION
items with lower > upper.

Fixes: 37922ea4a310 ("tipc: permit overlapping service ranges in name table")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Reorder the new u32 declarations in reverse-Xmas-tree order.

 net/tipc/name_distr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 190b49c5cbc3e..da8a5eb6e63f1 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -282,10 +282,19 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	struct publication *p = NULL;
 	struct tipc_socket_addr sk;
 	struct tipc_uaddr ua;
+	u32 lower = ntohl(i->lower);
+	u32 upper = ntohl(i->upper);
 	u32 key = ntohl(i->key);
 
+	/* A peer-advertised binding with lower > upper can never be matched
+	 * or withdrawn and would leak the publication; the local bind path
+	 * rejects such ranges, so reject ranges learned from the network too.
+	 */
+	if (lower > upper)
+		return false;
+
 	tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
-		   ntohl(i->type), ntohl(i->lower), ntohl(i->upper));
+		   ntohl(i->type), lower, upper);
 	sk.ref = ntohl(i->port);
 	sk.node = node;
 
-- 
2.53.0

