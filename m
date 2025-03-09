Return-Path: <netdev+bounces-173295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C890BA584FB
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDAB188E27D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6B41DE4E9;
	Sun,  9 Mar 2025 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I9hW2KTZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vz7B/sD"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A741CAA82
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531630; cv=none; b=mD/YYACzGbkcg3/yk34/l96ryEA2EtG63kxYGM6WawB4GHG63Ku6REg8qxj5b6mpalLXf/fuQh83q+X3ma+4YScTET/QZLctMjdojeC3DaPCr7Lg5yywFKD5UQXaiMjKPRnyU0dbgu6ytjrwz01rjoMlKXh/2jUbOnD9RuI1MEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531630; c=relaxed/simple;
	bh=/qTuvMsiGHwd9gCTQBC8ABHVbMwwgTrNAOpRgQxKN90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g//zmA3Q9Xg7Q+UeYdPHptWaN20v+XprPRFPKcrb3bwMauZM84h/OvOCWIE3chG3fPOKZNOhrL14rWNANPsDgS2YFQggMeciR2tzKRv7uCwwuDJgQBTexeQW6Btk4TDIfrwxilmO3L8TkoGmdRKk4agGmz1yv4q8tdztAotabp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I9hW2KTZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vz7B/sD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOc8ckePFkeGQ2pTacs+RO3NUlJTfEwyNKi2sXX6y00=;
	b=I9hW2KTZahPJvaKqfOP+gS5xHaJWJDQpU7EkyO+GLTqEwP362oY+VYiAk+zEEm8tt43Tmh
	0C4Izow5Qa1Bp3jIdpp8e5kszSN+UMZwzr/6Ojy9Q7PfNHTOMnETpEmssqkcKegY3xJp36
	LgAKrop8B000e+29+KeVHv7Bk16kVRLguTJrV2mL1EpeDfPDqhw0oFJjP5DVNRAIvaQWun
	QBCNIWxk/nsnOBrLddLPSmqX4FZq/73qrrJf/OYsbcvEAL3Q3Hggu3N5DzHm9DREKKzxaw
	CW8nVsn7xunIRBUT0/1ytlMNWitfOUhY9BlJYkNvuws0kzFTViolfHwPIi1g0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOc8ckePFkeGQ2pTacs+RO3NUlJTfEwyNKi2sXX6y00=;
	b=1vz7B/sDO/5CSNE/gs1QaVcL5j29npMS7b8NUaQH6XPnGovRlsH7qilkyI8jmoamDTIIef
	KQE1O51mCW9Wk6BQ==
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
Subject: [PATCH net-next 04/18] ipv6: sr: Use nested-BH locking for hmac_storage.
Date: Sun,  9 Mar 2025 15:46:39 +0100
Message-ID: <20250309144653.825351-5-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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
2.47.2


