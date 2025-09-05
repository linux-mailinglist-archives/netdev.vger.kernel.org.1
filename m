Return-Path: <netdev+bounces-220420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A3B45F78
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7808583A7D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F8E31328E;
	Fri,  5 Sep 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMmoNNPC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033A313273
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091505; cv=none; b=DyiwCfQfmO9rog4vKmqs55Ou7sMepe8712Sfv7RtxZCvDczCKFB09KUPYB2a+8bHu4LAVODVPeQ9Tmz7m4w6j9BH/C64HzFuY7wYMPoqkX6qbKgMmULZchBxUayriqWE0zKY/0i22LrnXSUhx4DDHzqG9NXhti6/LiSu1lq8aeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091505; c=relaxed/simple;
	bh=0seVV96znrinIbntWL51agGa7YjaX0cB90UUgjKJdzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGIY/aQZr+kO3fpIeI8LZ7Ivf3czE97Y8feshu3m//8xWhHbZxW14MmkrbpgVI6xkrUTNyh+LZfxWgQ6xv4UtBTwCtIaaQy42AEVpiquezAs1/Jfijgp41vmjrlSOPe1poc/BWkYcjdSTzK790Dlm8Xp6QQc3HUUVOW4x0F4Q7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMmoNNPC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e9bdc2582e1so3845457276.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091503; x=1757696303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=buZNOSpH1QU9Fa/08cFuPQ+XbBuAmNZDbGi6Jt4B+9M=;
        b=JMmoNNPCG/LHpcOv+lydukE3QP5600smq+GkUC9I3g+Mu2JmV48jgqTIGSOO2MQO6Q
         NN7V57Gd+t2w34S8495Ib9tEjq+6L3GAnalffCXhfZvN9AB6gFLOnIkpjzVWB5q94aOD
         V3Si8n7e6C8zjMj+tcXE7gwSkHJrgwPSSK4HtKNUSqnDut70PeclUoCXpM7FEjiT6csI
         ZWXK2lTCQ0n2+pWyqNyvTncRZXyEq4pbU2+v/KqTG/wecXn72p4IT+w6hOGC4JN8xE+8
         R7CKCn60BnKmtA+djbAjPfI5dirW08tNC95jbQwTexh60ZAU7r+A10eJ2ns6hWGRuUqr
         4QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091503; x=1757696303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buZNOSpH1QU9Fa/08cFuPQ+XbBuAmNZDbGi6Jt4B+9M=;
        b=NJ2fvVbpUAkU4iwNGWyFWKAWcN8y7x4tGZHkcr71XK9ylHsDshFD2KJJKVwCmx3YFO
         8EAhrs8ZzapyLt0CdefI6HL5aBshMsGonvYWGBcDUNjfqpie5Hb/0ZUEBexXNYyYtNyY
         6hmhR/3SoJWnC9GuU0rJpxx3/aqfZjc3jEFDrynvqvY7/eUGRMsnRJW5EL4B9ynJAINw
         g5Jk/M22pZlPxSMadSlgL03hUydcdFhuiowtEWgLo6JNtvAuSfHrLBJJ94SICFaqaPOP
         D27EujnhvwkoP7jey03yiOodvHHgGTNV+hr+cEAzKLTtc4tCODTvnvIRyOIGAt8zAEXt
         ucwg==
X-Forwarded-Encrypted: i=1; AJvYcCW6ossnw3xd1Xsu/6CfpURTu1sV8W0PicVParEmjpBSdwX3K1EGZ+ZYHVfbxrDZLlT9brKdumo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2cEKnCgspoWyLMHlNUEgbkEB9wPWT2Z/NXVhJPQF0M2x1UPf
	EZ1Ybbubx0ggxTRX4kNpThNbZ+BWPa0cxzwG0ReEfs839426fD4/8giPgnvELFGWvrsCR6Dc3qk
	I5jb/DLL6nh6MwQ==
X-Google-Smtp-Source: AGHT+IF5YtUzli/JG8eada342oKm8+sv7Lw020jzQ3el7kJqvs83H8cmuVSpP7r2ump/11BLFGvhD7sSe0rf6A==
X-Received: from ybiv44.prod.google.com ([2002:a25:abaf:0:b0:e96:dd0e:6347])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:6208:b0:e95:1945:8672 with SMTP id 3f1490d57ef6-e98a575c589mr24917349276.10.1757091502761;
 Fri, 05 Sep 2025 09:58:22 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:09 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/9] mptcp: snmp: do not use SNMP_MIB_SENTINEL anymore
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Use ARRAY_SIZE(), so that we know the limit at compile time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
---
 net/mptcp/mib.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index cf879c188ca2..6003e47c770a 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -85,7 +85,6 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("DssFallback", MPTCP_MIB_DSSFALLBACK),
 	SNMP_MIB_ITEM("SimultConnectFallback", MPTCP_MIB_SIMULTCONNFALLBACK),
 	SNMP_MIB_ITEM("FallbackFailed", MPTCP_MIB_FALLBACKFAILED),
-	SNMP_MIB_SENTINEL
 };
 
 /* mptcp_mib_alloc - allocate percpu mib counters
@@ -108,22 +107,23 @@ bool mptcp_mib_alloc(struct net *net)
 
 void mptcp_seq_show(struct seq_file *seq)
 {
-	unsigned long sum[ARRAY_SIZE(mptcp_snmp_list) - 1];
+	unsigned long sum[ARRAY_SIZE(mptcp_snmp_list)];
+	const int cnt = ARRAY_SIZE(mptcp_snmp_list);
 	struct net *net = seq->private;
 	int i;
 
 	seq_puts(seq, "MPTcpExt:");
-	for (i = 0; mptcp_snmp_list[i].name; i++)
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, " %s", mptcp_snmp_list[i].name);
 
 	seq_puts(seq, "\nMPTcpExt:");
 
 	memset(sum, 0, sizeof(sum));
 	if (net->mib.mptcp_statistics)
-		snmp_get_cpu_field_batch(sum, mptcp_snmp_list,
-					 net->mib.mptcp_statistics);
+		snmp_get_cpu_field_batch_cnt(sum, mptcp_snmp_list, cnt,
+					     net->mib.mptcp_statistics);
 
-	for (i = 0; mptcp_snmp_list[i].name; i++)
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, " %lu", sum[i]);
 
 	seq_putc(seq, '\n');
-- 
2.51.0.355.g5224444f11-goog


