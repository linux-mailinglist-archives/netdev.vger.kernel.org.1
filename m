Return-Path: <netdev+bounces-300466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x/RQIKEHNGo3LgYAu9opvQ
	(envelope-from <netdev+bounces-300466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:58:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D953D6A1121
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:58:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=ESNZzhlj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300466-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E338D3026753
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F83E6399;
	Thu, 18 Jun 2026 14:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D63F44F9
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 14:55:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794554; cv=none; b=DhvXuPQjEqUrEO+2NWG2Dq54rBIGfG88k0agB0RH+4CgqLX8cTeG+8o0IQSXMDw4gY6VLmNNkvT/gLdag9hWrRQL0WO8bqbtqzgQJ7qe5m8P4Q6jE6UZeG4a02800S3F+U5YOnczBWfK5BBQsIl3MO2/vlBe2zjMOtvK3UcPowY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794554; c=relaxed/simple;
	bh=u9jzJTCuSR4v5CZ3TCwHDA26j82Y/8H6b8z/ylkoAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DutJo0wI3Pp6Oj2s8iP72AqGd6WslYySRygR5zrz+3s75ivgg0XK59mm1mBJ4icKl4//b4SLvDL+e53xouq+FjwFfuAGutmfs3dz9Ut5RhP2FCwVtGSHLdQiZBDDQN68ANeYt7ovsiyN1GWriNVElGhKjYJg7U3ThbLWv6rnl/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ESNZzhlj; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eeba68948so810919f8f.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781794548; x=1782399348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4SVpdsBcLaIGz1nZfhK4QzCtZCeVsaw2otrcfNi0wE=;
        b=ESNZzhlj1X+3hi2Sj2hUHQBcWaaCIbyzREOpg/zsU9thxqKT62MtmEOcAdm2TTX5zC
         Unw8SjULsAUMCb8mx7ZgAte1oltPiSphMWi+mAX6r101t8EGmtbgZG+RydHL1yENydtw
         pc1+VFw0NFy1EfaTo1Jb4foHW6VWWFnKyFxJnexVtDrQklDDTBuUDdZpEVPOOBkKZbkz
         o0Bwuo9uMhADW3tr47+Q7f4rfuU2d4b8WwqqVK+4l9X7oLiKKa7Obiq7iH4nYRToxSoe
         sqk1m9CzOTkpt777rU0yAFV42Mt7D7hdZcESE09raodXqtJeNWkDSq8yU0VuXPD2mJMt
         ungA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781794548; x=1782399348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4SVpdsBcLaIGz1nZfhK4QzCtZCeVsaw2otrcfNi0wE=;
        b=jTRjAJeQ86nP3EdYsSabGH9W8tgGZtfczs5S+WPgDVhD4gPTQDKBTWvBtlz2A1gdQ9
         20ivY2vKc0MSsmK6TUUVSFlt5U642nz+lrfJUKPpYFMCQzDh4JSYBSNCyKQyNY2YXbYF
         pC1BpV+aswss8IDP1IUmLd0H7oz1J6hKljX21XCENkwSh4zkRboY1tT8/IPjwf5xQNa6
         ixlCuyVYj8y2yLyHjslFMiI2P9a2yfAf+srcC+tw26dDdWBWOPk66Kx0+hOe1Qt12bzr
         MP2E6cy4Y2ZG4Yrg8Csn1R36FiFvbNGLDa8YXlg5WPcPEeU6/n/uNAI6ymEBjEeYlyZq
         nmRw==
X-Forwarded-Encrypted: i=1; AFNElJ9BEU7OVdzXSJdcM5u+57VSvPqpviiGhwriJ0xmI0VtzDpn1oF5Frn9ohYxxg7Re9r15w3WXAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGQrRh9ydyD8uCJci6oYBXeCAgkKWyLBSFGTOjLSfwxNYImqf/
	qNr0Adq0sTKF8d/IbpHG+4i4FzJAlKSFgkie1rHlNxt0aiuM8mneWARp+5BCxdPYrljb
X-Gm-Gg: AfdE7ckVhv1BdiNh6Y9f7DpnrTwkZWDUU/J3cBp3+OQw+84ndXuEtqUPyMaGfojj6V7
	bVkocIpwCO4/FYFhu76Uu/WAOgoXCBymCm0D9e6kJqhiIekfsoL9zbB/zhs1l8X0V6XgPeZBDxM
	LT5LioILmaNa/qi9BgRpOq2xMIinEa+xMUY1FSknTLHRAxvd6mDgnPrFhuq9Z9LgAhWM8tIGHYh
	dm8B1m43Sgfi8a8e7SXm5N3j7XiQmSUB+ckGAsV5AAYmZUpNXVlVu21SDGTVOxyqddv1vZOY4CC
	cKYcARzixAGYVNulUnT4qapumLHRCK55vbZjOPJTXuP8i2GDRSCNLC8CEayh6DywYViRq6ws4CN
	u1OAsShNGgCdz+CdIqbQrQPFiPGyLrapKValnapJOQEme9DyYqpMOhm2QVCJVJxCmxHjW/NLeTq
	W/pnFSJupHr9IappFoNxZYSJt4orX66c5yGeJybx44N/j8al1qRdsBkqkb5gJuPmI/uVHSmL3MS
	RvdO8s45BtU9woKlUzneyEKZLzCfbylNQk=
X-Received: by 2002:adf:ef8d:0:b0:460:1f32:628d with SMTP id ffacd0b85a97d-4623683a4bdmr10901952f8f.11.1781794548276;
        Thu, 18 Jun 2026 07:55:48 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm63857002f8f.3.2026.06.18.07.55.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jun 2026 07:55:47 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: borisp@nvidia.com,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v3] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Thu, 18 Jun 2026 16:55:45 +0200
Message-ID: <20260618145545.53035-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,0sec.ai:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D953D6A1121

When an offloaded MACsec RX SC is deleted, macsec_del_rxsc_ctx() released
the per-SC metadata_dst with metadata_dst_free(), which calls kfree()
unconditionally and ignores the dst reference count. The RX datapath in
mlx5e_macsec_offload_handle_rx_skb() looks up the SC under rcu_read_lock()
via xa_load() and, while still holding only the RCU read lock, takes a
reference with dst_hold() and attaches the dst to the skb with
skb_dst_set().

A reader that has already obtained the rx_sc pointer can therefore race
with the delete path:

  CPU0 (del_rxsc)			CPU1 (rx datapath)
  --------------			------------------
					rcu_read_lock();
					rx_sc = xa_load(...)->rx_sc;
  xa_erase(...);
  metadata_dst_free(rx_sc->md_dst);	/* kfree(), ignores refcount */
					dst_hold(&rx_sc->md_dst->dst); /* UAF */
					skb_dst_set(skb, &rx_sc->md_dst->dst);

metadata_dst_free() frees the object even though the datapath still holds
(or is about to take) a reference, so the subsequent dst_hold() /
skb_dst_set() and the later skb free operate on freed memory.

Fix the owner side by dropping the reference with dst_release() instead of
freeing unconditionally. dst_release() only schedules the RCU-deferred
dst_destroy() once the reference count reaches zero, so a concurrent reader
that still holds a reference keeps the object alive.

Dropping the owner reference is not sufficient on its own: once the owner
reference is the last one, dst_release() drops the count to zero and the
destroy is merely RCU-deferred. A racing reader that runs plain dst_hold()
on that already-dead dst gets rcuref_get() == false but dst_hold() only
WARNs and attaches the dying dst to the skb anyway; the later skb free then
calls dst_release() on an object whose destroy is already scheduled, again
a use-after-free.

Convert the RX datapath to dst_hold_safe(), which returns false (without
warning) when the dst is already dead, and only attach it to the skb when a
reference was successfully taken. When the SC is being deleted the in-flight
packet simply proceeds without the offload metadata_dst: skb_metadata_dst()
returns NULL, the MACsec core sees !is_macsec_md_dst and skips this secy
(rx_uses_md_dst path), which is the correct behaviour for a packet whose SC
is going away.

While reworking the datapath lookup, also guard the two NULL dereferences
on the same path that an automated review (forwarded by Simon Horman)
flagged: xa_load() can return NULL when the fs_id has just been erased, and
mlx5e_macsec_add_rxsc() publishes sc_xarray_element via xa_alloc() before
rx_sc->md_dst is allocated, so a packet carrying a freshly recycled fs_id
can observe a non-NULL rx_sc whose md_dst is still NULL. Check both before
dereferencing.

Note: macsec_del_rxsc_ctx() also kfree()s rx_sc->sc_xarray_element without
an RCU grace period while the same datapath reads it under rcu_read_lock();
that is a separate pre-existing issue and is left to a follow-up patch.

Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3:
 - Also guard the RX-datapath NULL dereferences flagged by the automated
   review: NULL-check the xa_load() result and rx_sc->md_dst before use.
 - Note the unrelated non-RCU kfree(sc_xarray_element) in the delete path
   as a separate follow-up rather than folding it in here.
v2:
 - Convert the RX datapath dst_hold() to dst_hold_safe() so a reader racing
   the SC delete cannot attach a dst whose last reference was just dropped
   (per the automated review forwarded by Simon Horman).
v1: https://lore.kernel.org/netdev/20260615140534.52691-1-doruk@0sec.ai/

 .../net/ethernet/mellanox/mlx5/core/en_accel/macsec.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a05..fb2c64d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -829,7 +829,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	 */
 	list_del_rcu(&rx_sc->rx_sc_list_element);
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
-	metadata_dst_free(rx_sc->md_dst);
+	dst_release(&rx_sc->md_dst->dst);
 	kfree(rx_sc->sc_xarray_element);
 	kfree_rcu_mightsleep(rx_sc);
 }
@@ -1695,10 +1695,10 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 
 	rcu_read_lock();
 	sc_xarray_element = xa_load(&macsec->sc_xarray, fs_id);
-	rx_sc = sc_xarray_element->rx_sc;
-	if (rx_sc) {
-		dst_hold(&rx_sc->md_dst->dst);
-		skb_dst_set(skb, &rx_sc->md_dst->dst);
+	rx_sc = sc_xarray_element ? sc_xarray_element->rx_sc : NULL;
+	if (rx_sc && rx_sc->md_dst) {
+		if (dst_hold_safe(&rx_sc->md_dst->dst))
+			skb_dst_set(skb, &rx_sc->md_dst->dst);
 	}
 
 	rcu_read_unlock();
-- 
2.53.0


