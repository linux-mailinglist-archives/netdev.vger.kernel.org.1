Return-Path: <netdev+bounces-173293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09CA584F9
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2784188E37F
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A971DE3D7;
	Sun,  9 Mar 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2TJafLr1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rx8HUo75"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7521C861A
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531630; cv=none; b=u+wh3KkPNk7avHUKJxN6p0wAKa2jVQ8Vu6Rt+ztAKSF1WRTV1ngHyEazpM/UPvLP4nMkbEb3vjWIqRfGprZ5k18qfWhkW9n6CaYa4/onPy7HBqtH9mIz3MMtsdloYVTy34qjIpvldtu3kS6njz0XNJ1s11+eEasa3EWHP9hTt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531630; c=relaxed/simple;
	bh=c9CkQw/wu/SWAWAVKyHzuBm/EguwmXvc1IDJ89jAOtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CePQp5ciaU6/M4mdO04BdAEm4LiVgL2dq4ickBUND4YRXzhNvyYxDtLc9FqdXMYkfrF+AwDJe6lhZFOKjlDZ64ZYR4+b6l3q+BWQ+Cj7zhKYEWPaCKANOoysPZjIMd1SiwCpIC5Fb3I9joVbDO5BlDFoVRApmRmDhqbW5a0FoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2TJafLr1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rx8HUo75; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9CkQw/wu/SWAWAVKyHzuBm/EguwmXvc1IDJ89jAOtg=;
	b=2TJafLr1zHDPv8eGHv8z9PF+WYT68+OCDoIgNUBpJEGxGOZlRQ5RkEtiHWpfEfyB12lyBl
	tyVeoGeT7hnd0nQYHGLkVRVmDfxs6gtRvo45Iy9koAMTdtzJ9S0t8zivVcowkYktIaDway
	2fs0rIaT3DvOQcUhuWF32KSjfed1p6MuflpWZONOkH+UT0uf/ch+BHXOBuD7JOme/EmUFn
	XyXinDAAhD+mIYeGFrzT4p98cusu2fNF9wknJGExNcwzeYG+4nweWEn42GEsHu3/99dEwx
	9bYuTH2MKxkRqCjyqNNVTiFXBTzVmMyktr9rPNtnh8ahnBkc8Rm9QqG8I5la7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9CkQw/wu/SWAWAVKyHzuBm/EguwmXvc1IDJ89jAOtg=;
	b=Rx8HUo753GVEEroBZ4z2FZI0KjVXAfo2ay3j5ofzLTZKXdWG9LF3YCGQjJlmbSHcoKyCvg
	yCFUHP0rJBMdDmBw==
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
Subject: [PATCH net-next 03/18] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT.
Date: Sun,  9 Mar 2025 15:46:38 +0100
Message-ID: <20250309144653.825351-4-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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
2.47.2


