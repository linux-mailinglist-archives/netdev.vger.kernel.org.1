Return-Path: <netdev+bounces-305227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nPd0IaMdTGolggEAu9opvQ
	(envelope-from <netdev+bounces-305227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:26:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3E9715B52
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 23:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=CLCF81mc;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305227-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305227-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C25A30379B1
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B91E47D940;
	Mon,  6 Jul 2026 21:26:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D93430CD3
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 21:26:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373170; cv=none; b=hVKsYdodlm0SaXOeBj4f2fqTBbwW/qwk8cBghYFQVbU0FZdLZtym4AH2zr5UjJzI+XySPrIw7FybwYn9CX2N0kwDBy95d24otY2GU4a6riNteEmwx8b6BBPbbT91lJ2tJIPs3vQcnFA+6iwv8crNKxGSSphcRIFChefFs7RFfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373170; c=relaxed/simple;
	bh=Bs3BqDfwVT32fxCzGLIASSLmPsP2xEpS+XdhYE+ExzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvl0T5wBs6Fnc8uJ8g214mmC9ViULt5bRVMzyhWQhMKTcuZOKH4XiYluH7IRLj4YQKGxmXSDtkyBPCibm9Uk8kHNOn7QFD8dndtVcq5DeuKYBGQNkJFZFrgjY9GjCyVti4tevClUvPYgem+VKwZ0MLJL2hb5E+QnIJozS/CMLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CLCF81mc; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cace7da66eso32710605ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 14:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783373167; x=1783977967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tWhlUUX4fbebZqU7q8r9h76HiQyUnyQMMOJxI7aP7F8=;
        b=CLCF81mcLqC6PK9Zumhw1blj4Ea/zdHcSmM0X4ogdjWwzqGSUnTma24b2tYrtsP2rp
         jy8P8Vqk7Wa9RwBeBFKt58MnwiOdLqHp8nIxSr1e6tUanJExPWqY5TbBN6z3RjyNTDUk
         6CSWys0gajf1W9xogX6FY6RjgJR8NwVrALJHOGHFg9mbZWTEvQ6U8TqzhAHnHLsSRI8N
         zUP4cx3qGcQ9dWgkrzrTeDvr7WwGHrFGRsi0GpihtK9fkBOR7hJ8cmm3txrEfmtHTHGM
         8PwKXDa1x0C5zS4LN/fQTP0qQz1tDOZityNQHw/w8t0S0l5pmc7tDXmjHiSdbluW2UO2
         PPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373167; x=1783977967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWhlUUX4fbebZqU7q8r9h76HiQyUnyQMMOJxI7aP7F8=;
        b=A0hJ2TEBWUnRV/4QPPfKN+IOJ+RKXuAwF6GpHNMdHAGWh8dO1Xtz/8cGtaMHSK7+7+
         dBTThk+GY8ngg4FLDF3ASnBE7O5I9gunVJtOrz5igwNwte4JnnoyzaezH7ut4m1/vFCM
         qQFqFW/PHjPR5/JV87ZS4eWWZXw7SPOjVCAlen8UGLlzOoeVv/hiUkQsQhPtgDdEBtSw
         vsB6SNrYvc5t7FbMrKImeBQBt96TS8L+87T+nNU/N0RGW/hrw21jyA3nm6ZoSJVTBdgW
         CrcD5WgGZlMSgUk6q5FNj6L7e0L/E6kvK/hqBWiko0pkTTog9Q8TC0Y7lSI34DKm275Q
         BatQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCeDXZiOm083lCHgcoBvCT6raiyoYDtwTswG9rc5+rKvRlVM/x9R1JUeVA2Fx2dZt1H/4EnVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwcVJvKhY4ebwvLzFycuq8hNwsYlIvJn/KcRnM9PRmdib3zBF
	a3ljTvGAVNnQnDTe7HIrDEupZaCh3XJM/ws7B6oYV/Cxn9V74pg6zjJ4h+R3+c8wxQ==
X-Gm-Gg: AfdE7ckSdrxSAMDoDS3wiHw5ZpEUFlga7F+/+xwPtV+bWTgpKn4Is3E6ZkNhNTXH5BK
	MGZ4bGoQv7MNcootR2TVmJK4rx2amSVlHL1mbmIdB1u/GeQX/FccwkJdl7b8Haaa3j8k7M1aSNj
	3oLtqFL+FKJgDo70Go5kRBWpW2iX+nSORcymdk8U3pM/nbXktMsNkCfFiUfjdSifc0vkABUtXGm
	5gVcZKyaBlWC4xVC8yw5oPX+riY0redVbn1c00HyjmkDZYs9m2pWfY/MIXFQuXsRuuHP3wq+alo
	73ogte64ZYn+x2k+L7FKr9uU5dKm7jcHwBhuVC1+5WgCk3M+F1AeCOFjDhGVW6kmyBT/o38WVrg
	QJ7laFkzEPFNztSrPwvziHR4ErLSKDECzTYPgHMGJt6tbJMH0C1ZHyyi8y0J1qS4NvDJrrWosUA
	z8h4CvXGWcvkZ0we+rx/GzSKJhF77V
X-Received: by 2002:a17:903:17c5:b0:2bd:5ab:af95 with SMTP id d9443c01a7336-2ccbdf40961mr25196295ad.0.1783373167019;
        Mon, 06 Jul 2026 14:26:07 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6594f6a9sm583356c88.5.2026.07.06.14.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:26:06 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Karlsson <thomas.karlsson@paneda.se>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound broadcast backlog
Date: Mon,  6 Jul 2026 21:25:56 +0000
Message-ID: <20260706212556.3199234-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-305227-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:thomas.karlsson@paneda.se,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F3E9715B52

The netlink policy for IFLA_MACVLAN_BC_QUEUE_LEN accepts any u32, and the
value becomes port->bc_queue_len_used, the only cap on how many skbs
macvlan_broadcast_enqueue() may queue on port->bc_queue. An unprivileged
user owning a user+net namespace (CAP_NET_ADMIN is checked only against
the target netns) can set it to 0xffffffff, so the backlog check never
trips and every broadcast frame is skb_clone()'d with GFP_ATOMIC and
queued. When RX softirq outpaces the bc_work drain (e.g. many ALLMULTI
macvlans under a broadcast flood), the queue grows unbounded and
OOMs/panics the host.

Bound the value with NLA_POLICY_MAX() at 4096, 4x the default of 1000.
This keeps headroom above the default while capping the backlog; values
above the cap are now rejected with -ERANGE at netlink parse time.

  Out of memory: Killed process 141 (su) UID:0
  Kernel panic - not syncing: System is deadlocked on memory
  Call Trace:
   vpanic (kernel/panic.c:650)
   panic (kernel/panic.c:787)
   out_of_memory (mm/oom_kill.c:1166)
   __alloc_frozen_pages_noprof (mm/page_alloc.c:4914)
   alloc_pages_mpol (mm/mempolicy.c:2490)
   folio_alloc_noprof (mm/mempolicy.c:2591)
   filemap_fault (mm/filemap.c:3565)

Fixes: d4bff72c8401 ("macvlan: Support for high multicast packet rate")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/macvlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index c40fa331836b..d4cede6393b0 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -37,6 +37,7 @@
 #define MACVLAN_HASH_BITS	8
 #define MACVLAN_HASH_SIZE	(1<<MACVLAN_HASH_BITS)
 #define MACVLAN_DEFAULT_BC_QUEUE_LEN	1000
+#define MACVLAN_MAX_BC_QUEUE_LEN	4096
 
 #define MACVLAN_F_PASSTHRU	1
 #define MACVLAN_F_ADDRCHANGE	2
@@ -1755,7 +1756,7 @@ static const struct nla_policy macvlan_policy[IFLA_MACVLAN_MAX + 1] = {
 	[IFLA_MACVLAN_MACADDR] = { .type = NLA_BINARY, .len = MAX_ADDR_LEN },
 	[IFLA_MACVLAN_MACADDR_DATA] = { .type = NLA_NESTED },
 	[IFLA_MACVLAN_MACADDR_COUNT] = { .type = NLA_U32 },
-	[IFLA_MACVLAN_BC_QUEUE_LEN] = { .type = NLA_U32 },
+	[IFLA_MACVLAN_BC_QUEUE_LEN] = NLA_POLICY_MAX(NLA_U32, MACVLAN_MAX_BC_QUEUE_LEN),
 	[IFLA_MACVLAN_BC_QUEUE_LEN_USED] = { .type = NLA_REJECT },
 	[IFLA_MACVLAN_BC_CUTOFF] = { .type = NLA_S32 },
 };
-- 
2.43.0


