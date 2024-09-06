Return-Path: <netdev+bounces-125942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E262A96F553
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D001C22C06
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2151CEAB1;
	Fri,  6 Sep 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yttnLelu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="muuUQMFI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A472149DFA
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629302; cv=none; b=LvCq8cNS7TTuGtLcLTD0O2dbZmYKSiByWSzQUNYZbyga2+3+tGb0DOqm9dEWzxBQtLgsVfJ2mJ8Zt2iPn0CGEVGdR5e/rn7DOv07xwOuxEB72mkyH/ImIXBvWiSaNptFAa3+c4Ew3k4vIcWT3iEm2LKn10qBF6HQEUBm0DOZwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629302; c=relaxed/simple;
	bh=tlSWkP3JObsugJ7X0KX05ciJXPsBmF04Z0v6sO71wOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRlqhGlb0KlJlaP+IPV3w4vl/AlORaHpPmJ2gParytAICGppibbXb5i8t/1cVa6UYBNIWurTvKwkNpQVJtTz3fvD1l7487dncO+F25XqkZMJyg5ug10iwd5fOLsSdnKCuwRdXM4lC9wEOIe0uCf81WfO6F3iphhsaQzmJuFaO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yttnLelu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=muuUQMFI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725629298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kq59Ak2lU7EiFPKG5Ol3fBoGjJcPKW2O0bvfsts5sqc=;
	b=yttnLeluGk+CBubeFKqFzrFyZhYRh9CXQCTwdOq0VpPqBUz3kvAufDds4Lr71gWe0Ir+4d
	psvZAlTIXyqPbp9UJ62NT1yiSUdvrQlBp8bp2SVJELHAseiRA/+EzNXB4Jgf1oqlN5HEte
	5Q2gG+rQAfWsphdaB08MByyIjg7xlWtm8ShBDvALs5Ewxt+jjZiWhRv4Q6NZZ2/t0/H8Ih
	q9aYA+oRfh1V7fhtvN/FKIrsAAu+ZAEahxEJCzHhZOjS2yRORO64PtD9E9feS0YAjYuIcs
	DZP9GQvrIsQDn6LYn00UTYGNeOGBVq64ScdrBASDo14IV8+EfvtZweByR5HP7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725629298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kq59Ak2lU7EiFPKG5Ol3fBoGjJcPKW2O0bvfsts5sqc=;
	b=muuUQMFI4ix8JJWu4rEyUdd+7w3Mi12ywqF+Gq034e+sRVomAJLVEHEWGXdpDZR2nphlkj
	uACFHVHEnlkZyNDg==
To: netdev@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 2/2] net: hsr: Remove interlink_sequence_nr.
Date: Fri,  6 Sep 2024 15:25:32 +0200
Message-ID: <20240906132816.657485-3-bigeasy@linutronix.de>
In-Reply-To: <20240906132816.657485-1-bigeasy@linutronix.de>
References: <20240906132816.657485-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Eric Dumazet <edumazet@google.com>

Remove interlink_sequence_nr which is unused.

[ bigeasy: split out from Eric's patch ].

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/hsr/hsr_device.c | 1 -
 net/hsr/hsr_main.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index a06e790042e2e..10393836992df 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -625,7 +625,6 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct=
 net_device *slave[2],
 	/* Overflow soon to find bugs easier: */
 	hsr->sequence_nr =3D HSR_SEQNR_START;
 	hsr->sup_sequence_nr =3D HSR_SUP_SEQNR_START;
-	hsr->interlink_sequence_nr =3D HSR_SEQNR_START;
=20
 	timer_setup(&hsr->announce_timer, hsr_announce, 0);
 	timer_setup(&hsr->prune_timer, hsr_prune_nodes, 0);
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index ab1f8d35d9dcf..fcfeb79bb0401 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -203,7 +203,6 @@ struct hsr_priv {
 	struct timer_list	prune_proxy_timer;
 	int announce_count;
 	u16 sequence_nr;
-	u16 interlink_sequence_nr; /* Interlink port seq_nr */
 	u16 sup_sequence_nr;	/* For HSRv1 separate seq_nr for supervision */
 	enum hsr_version prot_version;	/* Indicate if HSRv0, HSRv1 or PRPv1 */
 	spinlock_t seqnr_lock;	/* locking for sequence_nr */
--=20
2.45.2


