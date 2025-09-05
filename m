Return-Path: <netdev+bounces-220418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C4B45F76
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B501CC3C23
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB831326A;
	Fri,  5 Sep 2025 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PM2pU1gi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1F313260
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091502; cv=none; b=PcF5o+IBeQ9Rn4unyLvv7AP6gMeD6yStZ4xDBaJ/EWBzypC50WzNRgtZJl63ijZAvtS67inm/k1UMuGUCs/v822pt9akATN4S+untuVpMeuhZwjuHvK2efogY5ykqLDfz21B71E5AkD4/ZeM+rw/onewVSZXDQX+lNG7mqUzTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091502; c=relaxed/simple;
	bh=WcOtDfqjgLMgyzbAlPitUdi+VoTE1qvKEQ1+mAsWPBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NvoYBH2wFlRD28efnrMZjLfFscwn67VJQxF6GuW3CJPOxB+eG9i1Meh2zqGDz5yhz86ZVKOhpS5IR1NQcbp2PrHz2vsVuxr7Iy4cts03lqmnZfPgZbCarhQM2ygRjPykgMco+Nvinw3Fd69bje2J0/devK/Wurmq81LJ/yf1msU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PM2pU1gi; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7fc5584a2e5so743306085a.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091500; x=1757696300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjgMTPOv3G0Hg9kpVM7NeBoY11lmZOlrzddlnkWUWmI=;
        b=PM2pU1giPFMsFhSHhVEUtoCVmkTBQMH00NI3++nILzCofkPrPhn1TCVz+JEpKutCc0
         tNeJBjJsxht1PBG9tq9iC9nJMmm/HwnxmmwzdJeBnwCqLLG8T2lmgYdtCJczfP6wmyiq
         hXCo0QTUasCfniSoZrfkMWUPDFc5HXWxF0DFDHGUWnwQRAv41V7CeQhkz3behW6TOqzO
         8mruNkp42aMt9IvyVtuLt1y/sazDV+CJ6NI5waTFO2JYoI3aMfH+TM90PLQ2nJDdvOJ3
         0ftNHZi5IlWuxvzN7oIJ+yIkamhnyXvoLkC4zA9V0xEp0az5OxJCEl1VJStDWln1VHQ2
         Cf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091500; x=1757696300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjgMTPOv3G0Hg9kpVM7NeBoY11lmZOlrzddlnkWUWmI=;
        b=dmz8E43I1/EGdZUcnz9k/51BK5Uc5adJ6TSoq/dz8jR4LNUPrj2jAHcipOE9QGyiYT
         u+gGoP7jh0v3sIU6S5JL/xsrskN3c9sTdRUoOQ2EbPkiBpNYIyVeSQTY4o7sVFrB1du1
         iguBE6SDXoRpfMcz0mJni683ibing4a6SMZrqRqcrXs5BpTcVowpMdw/0TUXHS/bTN8p
         ouL6yWkJlKIrMPFJUz7eOXXgOUKHRk5YBa/JDK85gpGuCoxd0bd1JyrYGiUL6Oh5p0l2
         77ZjMQaQ0Qg60eCp1X+LrNhtXubYe4m7zlGjmJtuJxP+zff8mr31jT6eigTYo3DvFWCZ
         k7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUclS04lUrQzjeh73k2voj4y5+gIqIXlIZpfJs/cWmrV/qUelHgmfM7uyY2LSrNnX76Yg3oUWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSo/fMNij6CrIz5ZptUIRc8ow7Ana9fGuQrHGl80/lmhqgUx/2
	f8+eTaXt2AVEeBByr5j0Y2fflQTVeM7F/NgfDZPbjVSNqgO0eceBwxSJm3juGQ5fC4uq6zwNRYM
	7CKpWtdxUcAdStw==
X-Google-Smtp-Source: AGHT+IFHiZobotAVGyHSw+9HV7SVVBzO8gLS8QaS0OGe3f3LLZwZ2DFGrmEa3uyUdYIF4CfhgRzqZapGIZL43g==
X-Received: from qkpa26.prod.google.com ([2002:a05:620a:439a:b0:802:be88:2d95])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:40d1:b0:7fb:95d6:17d0 with SMTP id af79cd13be357-80f644ffff8mr750398485a.10.1757091499948;
 Fri, 05 Sep 2025 09:58:19 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:07 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/9] ipv6: snmp: do not track per idev ICMP6_MIB_RATELIMITHOST
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Blamed commit added a critical false sharing on a single
atomic_long_t under DOS, like receiving UDP packets
to closed ports.

Per netns ICMP6_MIB_RATELIMITHOST tracking uses per-cpu
storage and is enough, we do not need per-device and slow tracking.

Fixes: d0941130c9351 ("icmp: Add counters for rate limits")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: Abhishek Rawal <rawal.abhishek92@gmail.com>
---
 net/ipv6/icmp.c | 3 +--
 net/ipv6/proc.c | 6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 95cdd4cacb00..56c974cf75d1 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -230,8 +230,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	}
 	rcu_read_unlock();
 	if (!res)
-		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
-				  ICMP6_MIB_RATELIMITHOST);
+		__ICMP6_INC_STATS(net, NULL, ICMP6_MIB_RATELIMITHOST);
 	else
 		icmp_global_consume(net);
 	dst_release(dst);
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index 92ed04729c2f..73296f38c252 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -94,6 +94,7 @@ static const struct snmp_mib snmp6_icmp6_list[] = {
 	SNMP_MIB_ITEM("Icmp6OutMsgs", ICMP6_MIB_OUTMSGS),
 	SNMP_MIB_ITEM("Icmp6OutErrors", ICMP6_MIB_OUTERRORS),
 	SNMP_MIB_ITEM("Icmp6InCsumErrors", ICMP6_MIB_CSUMERRORS),
+/* ICMP6_MIB_RATELIMITHOST needs to be last, see snmp6_dev_seq_show(). */
 	SNMP_MIB_ITEM("Icmp6OutRateLimitHost", ICMP6_MIB_RATELIMITHOST),
 };
 
@@ -242,8 +243,11 @@ static int snmp6_dev_seq_show(struct seq_file *seq, void *v)
 			      snmp6_ipstats_list,
 			      ARRAY_SIZE(snmp6_ipstats_list),
 			      offsetof(struct ipstats_mib, syncp));
+
+	/* Per idev icmp stats do not have ICMP6_MIB_RATELIMITHOST */
 	snmp6_seq_show_item(seq, NULL, idev->stats.icmpv6dev->mibs,
-			    snmp6_icmp6_list, ARRAY_SIZE(snmp6_icmp6_list));
+			    snmp6_icmp6_list, ARRAY_SIZE(snmp6_icmp6_list) - 1);
+
 	snmp6_seq_show_icmpv6msg(seq, idev->stats.icmpv6msgdev->mibs);
 	return 0;
 }
-- 
2.51.0.355.g5224444f11-goog


