Return-Path: <netdev+bounces-189693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE14AB339D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C410860D07
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3BC2676D5;
	Mon, 12 May 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIsGH0qz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="670viFAy"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFD266EE4
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042067; cv=none; b=CLDrYnhwdu64DhNfdNDuZKBZLhKppaiwCsKqmhH1afNwtjUoNwzbmAl0jW3gE8QiE/pqYf4Ftl7qRbIjEFIA2PLkFyznGbjBnqyvS6A+s+ka/VkEr1SzEGnyNxa1RNH0YlX6AO1oW6g44j2bKni3Rq26IqADJb474Th9bKcnthg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042067; c=relaxed/simple;
	bh=ikhY+bHEuuPq+Wi377sZpWwI70FH5caxkwylptiayXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItJyZ4F2N8pCZ3p6aUm+49yjv5H5NmlN2ABL6MH8NoB1PHSkHNlhCjg568Nkl4dCLTlxTXejC21crbNntLlbOHfod054qEFHJ9xD4LMmECMvbVW6dyE+ln2KjsJu7huxl/KtbX6C8alI0bYbV7Fznr3lGEbfcOUqRWusOYzx3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MIsGH0qz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=670viFAy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaElcyYJlHDajUNT3LTdSQakOyifkztF7WLYup3LZE4=;
	b=MIsGH0qzVbg3km3XR2VFVazMlc4FU7ou4pfJ2vDU8v4aYtT3BeMPAq91oNdUDcF8PGJjWS
	PzblJ9Pft5Vn3k5Evcj6Ne0/ezrpZHGzILAyRfkeoD/buaR69Zu+hYUaXNJgbmW4qEH0MU
	YEhPYY0fYYEUsC9PPQV+2+WbB2omEHO5shA6hSs104iQHQFrTNGP0r+bpXCLR/278TmP6W
	EzZyZP193ak7Ry6807x4hZsG8UHwJrKM8V383PXG27Vxfc7G8P4OHgn6ZabZHp4ay7buaJ
	zcMdWTADSLFWeAlJOllqvamP+GnAucdzrGkgdOZygv/5IFJi3Nmq9Ujf+3aBbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaElcyYJlHDajUNT3LTdSQakOyifkztF7WLYup3LZE4=;
	b=670viFAy43dRTDrMrK+kmNl0gsOZi1hptdpFyys0aN1NG68IhjGNKPF251p0GnfM5HeEYE
	aTGgR+uWZZtc48AA==
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
Subject: [PATCH net-next v4 04/15] ipv6: sr: Use nested-BH locking for hmac_storage
Date: Mon, 12 May 2025 11:27:25 +0200
Message-ID: <20250512092736.229935-5-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
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
2.49.0


