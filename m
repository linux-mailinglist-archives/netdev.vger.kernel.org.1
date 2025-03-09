Return-Path: <netdev+bounces-173292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1214A584F8
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619FF188E229
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B131DE3BB;
	Sun,  9 Mar 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVPXvQsB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qmlc4QlZ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F421392
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531630; cv=none; b=u0o4ImZjTC7p/ibxxMep1Jhy9QVEngB80KESaG+r+Og8U+yPEsIRqYIx0iYTN4zelO7xVI2jdd4DZOOXuKPPg0OkYh0y/ykDJHGUvyL6kFEiF5+bwb8icDjfc7N/hweBmqHieFpoBWLIk1rGXOPNNuDMsdWjotLTeNYiZCintaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531630; c=relaxed/simple;
	bh=aG+c2reD8sdY8z/puXdPKUl0pVr8sNcRx8J8OZfd5wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3pRuMAjthw2bbSj9oDdbKowxYt7p8mGnxLVHu51kwHY1WZyBr5UEzf1AkqWW/WgiEho4x97FjJvZKFrnElshB1k2uV3H+o4+G9s/mIUexsRgV+b+lTGGycbxuPLggkCyXRE/0x89aN7qkqRK+8VXR522oigVR3FMpzFbQE3XUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVPXvQsB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qmlc4QlZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMns56qvdsQqeNL12yWaFOWFInHuKZiBqGjNYelkvdg=;
	b=qVPXvQsBYhVbCPfw43+YqThrA7gpQbh1oB2OsJlFL6wpoVveJbMuaV6pPW761jv9sv5Fn7
	SaGpS4ZlYearuP1bYv1z3SejpV6cpTxCmpAxeKxm0PBlF0f4mvP3byH9valf9NoBvN3zI+
	qDNOOHwbBw4M0Vwq9ClcWXCKUjaXLMECFHhb016fNpOKXereWm6uJcKflHLSX93A0C4JrV
	kzxVA2A0Y4B0ZvQMs8t4h4rz4HLsKsyG7Uupp1ZItkO5ReIbPrahfrPSOSprTDIAao8TN7
	isnCAQATE41llr74795t/yAraG7zJqb169tyHp0es+Vzel4RcSgIHMMq+Bqn7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KMns56qvdsQqeNL12yWaFOWFInHuKZiBqGjNYelkvdg=;
	b=Qmlc4QlZfz21SCxxylHOIBThaobCQf5I5e56SCF5fN/drz+XzDIfUZn6kNMKamwDAtj0t3
	SkmA35Hni0OBGEAQ==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH net-next 01/18] net: page_pool: Don't recycle into cache on PREEMPT_RT.
Date: Sun,  9 Mar 2025 15:46:36 +0100
Message-ID: <20250309144653.825351-2-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With preemptible softirq and no per-CPU locking in local_bh_disable() on
PREEMPT_RT the consumer can be preempted while a skb is returned.

Avoid the race by disabling the recycle into the cache on PREEMPT_RT.

Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/page_pool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index f5e908c9e7ad8..1d669d4382729 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -800,6 +800,10 @@ static bool page_pool_napi_local(const struct page_poo=
l *pool)
 	const struct napi_struct *napi;
 	u32 cpuid;
=20
+	/* On PREEMPT_RT the softirq can be preempted by the consumer */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return false;
+
 	if (unlikely(!in_softirq()))
 		return false;
=20
--=20
2.47.2


