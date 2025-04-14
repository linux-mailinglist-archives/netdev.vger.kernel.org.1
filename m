Return-Path: <netdev+bounces-182325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0312FA88801
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A2B3B45E7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761202820DF;
	Mon, 14 Apr 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JFy6snVt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iiXRp5v"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776B2820B3
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646893; cv=none; b=hqAStpDmqIocAd9YUE6Y75rjmWz5lGhjkY9lWsAUqhwXhh3mIPK9N+eKjLJ1ZY9MtLAA9uVqdTNagPVj2ubRmlJx17MaJGcCxcrkNlA7/gNGBHZATS/yZVtwU9sNvSNga+CawLjVtqvpM2+7cE0Hv1ulLufXi3KpYFowwZ7B/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646893; c=relaxed/simple;
	bh=Xx/yYygoTYA10M6sf8WwKcPFVfmSXE6pqJcUYR/JImQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFUYooZS4vj5p2pcwUN8Lresq7AaPXDsRNXr80/keBMD5apQyB5eH7EhqHeXTbyZx9QNhlPZi61YCQQZmYTHSURVn/L9QTWQ/BEd7W23ppRlgKZ4xW+LX/DPYHLlMGmsOpa6c+gEx/z2T1BX5tdhdW36wzQzNBW1/5A4K2k4N4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JFy6snVt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iiXRp5v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHvS2pUGSJWzu/0mdfRvr9/twWc5vPT55NCkFQrdrCU=;
	b=JFy6snVtcLKXA9+MVas7LQvth7P1MrNr4CnY8uQ0u7YENbX7IeAtsHDYXW3g6MvJ1kRXhb
	6oWs3cyMTvixExsAcr8bpsoemde7KOLhsUBuJX7YQ9z3lvaRKED0v9gpHUFGQtIVQYqyWQ
	P0bCYlEYfb6NN+JzPRYidcKATEjsZ0j/nzRlBtfDSS4rwSNd/4Xnx18ovSBz2wLOGUm//r
	8KLC8QKcOFGLgH0ush87CSqGeptoDtV/zPiN6PoFdDz++O1QeKs+kYZDH3wSIcBswoagRj
	Z3/5SlhB6eXgoLQ5jVKQNgRKxZtQCCX5JeJfJkSPKk6mpFO4hBSGagoKGtDB1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHvS2pUGSJWzu/0mdfRvr9/twWc5vPT55NCkFQrdrCU=;
	b=0iiXRp5vHe0XBWY2L6uPAKKSSRtbe9SIr19quUvSByJXWKOJfJxmK5IrGWlEH6o2ofRPiQ
	dTt7BSoFazoP6mDA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v2 04/18] ipv6: sr: Use nested-BH locking for hmac_storage
Date: Mon, 14 Apr 2025 18:07:40 +0200
Message-ID: <20250414160754.503321-5-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hmac_storage is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Add a local_lock_t to the data structure and use
local_lock_nested_bh() for locking. This change adds only lockdep
coverage and does not alter the functional behaviour for !PREEMPT_RT.

Cc: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/ipv6/seg6_hmac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index bbf5b84a70fca..f78ecb6ad8383 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -40,7 +40,14 @@
 #include <net/seg6_hmac.h>
 #include <linux/random.h>
=20
-static DEFINE_PER_CPU(char [SEG6_HMAC_RING_SIZE], hmac_ring);
+struct hmac_storage {
+	local_lock_t bh_lock;
+	char hmac_ring[SEG6_HMAC_RING_SIZE];
+};
+
+static DEFINE_PER_CPU(struct hmac_storage, hmac_storage) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 static int seg6_hmac_cmpfn(struct rhashtable_compare_arg *arg, const void =
*obj)
 {
@@ -187,7 +194,8 @@ int seg6_hmac_compute(struct seg6_hmac_info *hinfo, str=
uct ipv6_sr_hdr *hdr,
 	 */
=20
 	local_bh_disable();
-	ring =3D this_cpu_ptr(hmac_ring);
+	local_lock_nested_bh(&hmac_storage.bh_lock);
+	ring =3D this_cpu_ptr(hmac_storage.hmac_ring);
 	off =3D ring;
=20
 	/* source address */
@@ -212,6 +220,7 @@ int seg6_hmac_compute(struct seg6_hmac_info *hinfo, str=
uct ipv6_sr_hdr *hdr,
=20
 	dgsize =3D __do_hmac(hinfo, ring, plen, tmp_out,
 			   SEG6_HMAC_MAX_DIGESTSIZE);
+	local_unlock_nested_bh(&hmac_storage.bh_lock);
 	local_bh_enable();
=20
 	if (dgsize < 0)
--=20
2.49.0


