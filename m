Return-Path: <netdev+bounces-187056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0394AA4B95
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AE7B7A9B0B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F86E25CC60;
	Wed, 30 Apr 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EToKSLAp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VZLOgCU6"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F125A33A
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017294; cv=none; b=Vb8wHsHDyFeK3GK65C5J81mGbvahVufI9IC6++qnRdl/v4QHJgwll/pmWHqkHxQse0UJIOqQiU2LhPTiz7FV5TfbobCLJpTLKX4iqzTyQtJVEF8inUc7Z/Lb+Oho+eS4ow5g7G24XlYJdshrx9C9OGY11q4EjyMVvO8+f2bQYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017294; c=relaxed/simple;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ot6WkCsn+kN8fUDbRuBL1oanq9HiK7S9+3X5yEflFLbfqoTk7L+kjw2Zd3zFgIIaYxj/voWpBLvA5tE0oXygi8kJZBnimZjRgOkTTJju1a/pEXSPPmzyQ+qzeUbPVbR0VpSazbvT6Hy9iJA4gUgn/TZHFn7NhgMKHFJ8IAr0W7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EToKSLAp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VZLOgCU6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746017290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	b=EToKSLApwcUZmPK8vlXtlzYuBYBqOnqy+6xysHxfEpUU0VXtilNWcbgMU2r1UR0utGHpDa
	hE+2fxKkMmPT1J7TfCimuKE4P8Qsl7Peu2/B1alt23VpoDgdnBOJ92IL07giaC+6wqi7g5
	vPnGJ2Mm44U6AmfykYKYAT9kdQULiAZ/TKXnEQFA/WuYbu3FfoOQ0cKj2S32M9vBKrLVWG
	SUu7GmonYfYcb77wRlsTSfyPAq7KJ5KujF0PxyV3Il4fM36ivxZbanCJP+1u/0e6PnEe4v
	bC60nhBLSWW6r9OY3H26wS8xSJFOCPjddZMsBd7HplD/jIlsEPsATo9EzeDvvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746017290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	b=VZLOgCU6DQZZsRuNOa+sOwEmUK/AuqmNn/NwjrHDCt+cD3Tg48l0yCcDQUxiwQ0ykK6zZ8
	QwmxSuMrpLmmAaDw==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v3 03/18] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
Date: Wed, 30 Apr 2025 14:47:43 +0200
Message-ID: <20250430124758.1159480-4-bigeasy@linutronix.de>
In-Reply-To: <20250430124758.1159480-1-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The statistics are incremented with raw_cpu_inc() assuming it always
happens with bottom half disabled. Without per-CPU locking in
local_bh_disable() on PREEMPT_RT this is no longer true.

Use this_cpu_inc() on PREEMPT_RT for the increment to not worry about
preemption.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/ipv4/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 753704f75b2c6..5d7c7efea66cc 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -189,7 +189,11 @@ const __u8 ip_tos2prio[16] =3D {
 EXPORT_SYMBOL(ip_tos2prio);
=20
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+#ifndef CONFIG_PREEMPT_RT
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
+#else
+#define RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field)
+#endif
=20
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
--=20
2.49.0


