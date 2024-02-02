Return-Path: <netdev+bounces-68586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B96847505
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23AC1C268FA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF45148309;
	Fri,  2 Feb 2024 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="43QDcZ6h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="75dU4AmR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4079148301
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891877; cv=none; b=qJWIYktWrtGXTueb9LfDxtVJfCEutdAX22ZjrvlrKtRjH2C5xlHa2PGX/q6IO/wnQRLaY5E6QHQC89utCy70DhDM8bWl3TGL0UVdSlp06/vuVzJPk1TgPd//O9dQLhwZbAWiO2zeOu1HIDHPFHAIOLUADGrooNbBkhqWUJ6G4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891877; c=relaxed/simple;
	bh=N05NUrIYjFLYb6XHQ7uovpKQSzs1fP/DER78u3ljFOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkqrhDIKZZbI4ZNslPUo3fkvUfqPQd8j0lOyX059jKTNzM9dTw938272y2Jt0WJ/rbA0GEwpwgA2mlrNwDlwdw8dy3vv0PnYwdG6k110mG1zNM7D8ydnHy91GBPGMDXTafvUipJC7MHi74klPuu6ljD+6MwO9qpnM63KnYXWpSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=43QDcZ6h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=75dU4AmR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706891873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KcI3GHqIiRGs47AaDKXJPMl+ynECWYblpb+AoM/wlJ8=;
	b=43QDcZ6hTmFT/FbFEpmW8f9ggwFCc822NZbPdUwS6qfrsYtCL2AHz0fnptNmawwBPEme+J
	7rocZZcEf9mzCXZix+ysLqCwv43L2H66r5ItrPwjqKcxQxks5LfmZhv+HicZ2ilpHkm+62
	qQM3KkI5aCBiNoCKWNFdng7VClUr1SHsXJjgoO9byMAUBGU05Q0k2E8QYDoOQN7rjGb49t
	azHiaEcs2EE9JxpEeZk3ZHJCbXP5cRI2k9t9UORIUktu7vg/yYsdIMfwd7v7AeredjEkJO
	D2VaM6zNuabSkPbBENZKVEdvQzom+XYLklrkDBp3SRVIc46WV6/B+qNsXjfFfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706891873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KcI3GHqIiRGs47AaDKXJPMl+ynECWYblpb+AoM/wlJ8=;
	b=75dU4AmRG/IakKCfgdyM02u8msd3wT3H3bicOlssnmy32DZGBunx9efSnnRbVnXm+1M1qE
	fy2EyXfY9bIBZgBA==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next] net: dst: Make dst_destroy() static and return void.
Date: Fri,  2 Feb 2024 17:37:46 +0100
Message-ID: <20240202163746.2489150-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 52df157f17e56 ("xfrm: take refcnt of dst when creating
struct xfrm_dst bundle") dst_destroy() returns only NULL and no caller
cares about the return value.
There are no in in-tree users of dst_destroy() outside of the file.

Make dst_destroy() static and return void.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/net/dst.h | 1 -
 net/core/dst.c    | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index f5dfc8fb7b379..0aa331bd2fdb7 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -390,7 +390,6 @@ void *dst_alloc(struct dst_ops *ops, struct net_device =
*dev,
 void dst_init(struct dst_entry *dst, struct dst_ops *ops,
 	      struct net_device *dev, int initial_obsolete,
 	      unsigned short flags);
-struct dst_entry *dst_destroy(struct dst_entry *dst);
 void dst_dev_put(struct dst_entry *dst);
=20
 static inline void dst_confirm(struct dst_entry *dst)
diff --git a/net/core/dst.c b/net/core/dst.c
index 6838d3212c374..95f533844f17f 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -96,7 +96,7 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *d=
ev,
 }
 EXPORT_SYMBOL(dst_alloc);
=20
-struct dst_entry *dst_destroy(struct dst_entry * dst)
+static void dst_destroy(struct dst_entry *dst)
 {
 	struct dst_entry *child =3D NULL;
=20
@@ -126,15 +126,13 @@ struct dst_entry *dst_destroy(struct dst_entry * dst)
 	dst =3D child;
 	if (dst)
 		dst_release_immediate(dst);
-	return NULL;
 }
-EXPORT_SYMBOL(dst_destroy);
=20
 static void dst_destroy_rcu(struct rcu_head *head)
 {
 	struct dst_entry *dst =3D container_of(head, struct dst_entry, rcu_head);
=20
-	dst =3D dst_destroy(dst);
+	dst_destroy(dst);
 }
=20
 /* Operations to mark dst as DEAD and clean up the net device referenced
--=20
2.43.0


