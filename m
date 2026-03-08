Return-Path: <netdev+bounces-265245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q3QaK9ggrWmaygEAu9opvQ
	(envelope-from <netdev+bounces-265245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 08:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD1622EE0A
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 08:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B3BA3006177
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 07:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9ED2EE608;
	Sun,  8 Mar 2026 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr/s5HZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5A2D7BF
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 07:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953814; cv=none; b=RedwB6QDxNglZdc3blzLu3ak2hWq+aEVauc/lsCghHuyt007hG/PnKXbFAHH3s9GglIlpN7JRhTJOBxbKi+bqw2tyZvYSRDR0YnLR1K9ER8cJxjNUdBv8NsolJ93nXTzWDWohMx1Xi2jx4+izfC2zyoyaA6ljpNg18v+GyI3VME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953814; c=relaxed/simple;
	bh=0ds3TvVp9Y0y3g1MolUjIlnDaEg4EeYjjW9KPAhlBQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoEEEdlDx/hDl3f5yjUc3bNyclYJ8Y8zywc7K5HvE/KukoR6K4lkw/a8qnNnjkQb+NRIrwgxms9DuSM9HYDfCrJ3uJwPgdFeK4zIcweA8vHCe5hieV0tKxWUq/FLbvNwyMLoPZF0qiajBq+KzmReBSP6F51yx6AET3VA64WEsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mr/s5HZQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae4988e039so48567255ad.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 23:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772953812; x=1773558612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvG+tAEOxjAJfsrmxdX9V5/bQEDskvpKd6MJkmnCi6U=;
        b=mr/s5HZQI8pC4SK2PYYM/Sr3A+rZCjv78UQtkwInJiDp7i6BqYJXW3OOOQG9Vkwnz9
         AOIsrUVOdVk9IkNGA1ZTjgP/omsbHew52vHrYpcvRj88ckCODnsFFoPmdxlKE/ceoBpg
         W7uWZQ2bboxis2tRJ3ufYnE3FGbU+rELqFEecefoLZNRqAcK9TTrrRj5bUUuiLcU91Ey
         SYcSHIDkspr2E23gSzVYCszZuke0W44PjgRSgI70IfUUzTxFQquDCE5EydSpzPEI+p1I
         uJYsX5aYuYWeOmqStx1+NwTdf33g1jIleQ2lAdjuwxbxPMboryNBb3OYxoimHAKtUVT8
         DF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772953812; x=1773558612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvG+tAEOxjAJfsrmxdX9V5/bQEDskvpKd6MJkmnCi6U=;
        b=KmENDAbHmrNnCtVXY+FhMCOaVeSD9qLyogrubkEwfyBg+aOz128dkMdl/3obnmrVcl
         5qStNjcKmvltj9Fc7sblxQ31/gbaJfFFVd6TH/QDFQAzQ42YbRYs7FxIdvVsoJDxyMCY
         N/YOw+iax8+lOlWcK7RO+xKV+ZvL/CaIln9TxVG3AA1Sej8pQG/wWq8xGO994iDEiZdD
         qX/XeJuUtmYSVEap0hrYooBYmdWc26HOyr1pphjMdBbNSM6KhhVn4RdOkdEBvITpnOrP
         BZL9rPVohPOHxhrMSoIcRf14esceh1AYF6ymbKCkYcJS7A4QOnzLWIxgowJ4rrx98v20
         hirw==
X-Forwarded-Encrypted: i=1; AJvYcCVlxZKYaDBIss8Dl03gdMfXFRzNCJ5z8x4H00iSZUU+pAndCm0hmOWqB3TeXWdn4HF3X0WDdUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQiWhFhNU8Q3M+YQUTMtejSPksrcAkum3ieCSzUOnCrz0egPC
	uuxsCldT7E+NvBkEUiB9MkeZwhTdByHAtBhO/9pgdAjCXvGeXh+la6Ik
X-Gm-Gg: ATEYQzwvdJ45auytOVewxEXH3ednGhn3yOsd3PMMBxQ66K0PH1WNiXWzlIPath15iUN
	yHx8sFkEz5kRr/9pjdXOZxsl+2UmnfCFVap7xWI9I4/Xh626d1/5NiONnXfy5rbLUjAKWN7WjuA
	3M3VM1HlqdIA9NJvnPuYkHGW8+Ut1sl9DPdZ7TH/ypLYV7i4AMxhsILjw5ZBSLLZKhgzO5GTBYW
	WtaUrDkzcHRjf1jL//Ta53C6KOHCBklwPe5buWa7FS7QiSfRcPMc6ABRaQAceWGVTvlaPTW5Lzf
	K/5gbRXjnLtDOnZtIKspk5ql07JO4cHntJdEtRyY7RcvHvIHSHvsoHm0oQpanbvgCvcLWnnBR43
	gnBrIFLDyZ79xRJL8JQSKSKcst1MhEfF++kDJSXb+tYVX3Ag9jIvGJ6ztrnESo/Fu/4lGeLoKOP
	JmcYgLb5KoZiQCIv2wdZzk195xy2T7xmrPyA2y0OFVtNSyAwIdegvfKbgErTc=
X-Received: by 2002:a17:902:d48d:b0:2ae:7f85:33d1 with SMTP id d9443c01a7336-2ae8286dc43mr72245585ad.0.1772953812451;
        Sat, 07 Mar 2026 23:10:12 -0800 (PST)
Received: from localhost.localdomain ([2409:8929:1733:8137:18a2:98d0:7c4b:4d56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e97924sm73472115ad.27.2026.03.07.23.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Mar 2026 23:10:12 -0800 (PST)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Sun,  8 Mar 2026 15:09:16 +0800
Message-ID: <20260308070925.58939-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DD1622EE0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265245-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

The current implementation of rps_record_sock_flow() updates the flow
table every time a socket is processed on a different CPU. In high-load
scenarios, especially with Accelerated RFS (ARFS), this triggers
frequent flow steering updates via ndo_rx_flow_steer.

For drivers like mlx5 that implement hardware flow steering, these
constant updates lead to significant contention on internal driver locks
(e.g., arfs_lock). This contention often becomes a performance
bottleneck that outweighs the steering benefits.

This patch introduces a cache-aware update strategy: the flow record is
only updated if the flow migrates across Last Level Cache (LLC)
boundaries. This minimizes expensive hardware reconfigurations while
preserving cache locality for the application.

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
 include/net/rps.h | 17 +--------------
 net/core/dev.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..2cd8698a79d5 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -55,22 +55,7 @@ struct rps_sock_flow_table {
 
 #define RPS_NO_CPU 0xffff
 
-static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
-{
-	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
-	u32 val = hash & ~net_hotdata.rps_cpu_mask;
-	struct rps_sock_flow_table *table;
-
-	/* We only give a hint, preemption can change CPU under us */
-	val |= raw_smp_processor_id();
-
-	table = rps_tag_to_table(tag_ptr);
-	/* The following WRITE_ONCE() is paired with the READ_ONCE()
-	 * here, and another one in get_rps_cpu().
-	 */
-	if (READ_ONCE(table[index].ent) != val)
-		WRITE_ONCE(table[index].ent, val);
-}
+void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash);
 
 static inline void _sock_rps_record_flow_hash(__u32 hash)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 203dc36aaed5..770cfb6fe06b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5175,6 +5175,60 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	return cpu;
 }
 
+/**
+ * rps_record_cond - Determine if RPS flow table should be updated
+ * @old_val: Previous flow record value
+ * @new_val: Target flow record value
+ *
+ * Returns true if the record needs an update.
+ */
+static inline bool rps_record_cond(u32 old_val, u32 new_val)
+{
+	u32 old_cpu = old_val & ~net_hotdata.rps_cpu_mask;
+	u32 new_cpu = new_val & ~net_hotdata.rps_cpu_mask;
+
+	if (old_val == new_val)
+		return false;
+
+	/* Force update if the recorded CPU is invalid or has gone offline */
+	if (old_cpu >= nr_cpu_ids || !cpu_active(old_cpu))
+		return true;
+
+	/*
+	 * Force an update if the current task is no longer permitted
+	 * to run on the old_cpu.
+	 */
+	if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
+		return true;
+
+	/*
+	 * If CPUs do not share a cache, allow the update to prevent
+	 * expensive remote memory accesses and cache misses.
+	 */
+	if (!cpus_share_cache(old_cpu, new_cpu))
+		return true;
+
+	return false;
+}
+
+void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
+{
+	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
+	u32 val = hash & ~net_hotdata.rps_cpu_mask;
+	struct rps_sock_flow_table *table;
+
+	/* We only give a hint, preemption can change CPU under us */
+	val |= raw_smp_processor_id();
+
+	table = rps_tag_to_table(tag_ptr);
+	/* The following WRITE_ONCE() is paired with the READ_ONCE()
+	 * here, and another one in get_rps_cpu().
+	 */
+	if (rps_record_cond(READ_ONCE(table[index].ent), val))
+		WRITE_ONCE(table[index].ent, val);
+}
+EXPORT_SYMBOL(rps_record_sock_flow);
+
 #ifdef CONFIG_RFS_ACCEL
 
 /**
-- 
2.47.3


