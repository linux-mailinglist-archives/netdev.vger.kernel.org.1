Return-Path: <netdev+bounces-275461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGJxJqdc0mkDXAcAu9opvQ
	(envelope-from <netdev+bounces-275461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 14:59:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53939E75B
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 14:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3964A3003615
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C27A33F5AC;
	Sun,  5 Apr 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eBVYId89";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fOUBVYS3"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730741A285;
	Sun,  5 Apr 2026 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775393951; cv=none; b=jNHhdyw6Q/gEQHc0xj9ClNtXpuE8vpLrez13IPKBwUy2bi28dwnqGfZ6uuMYm2HEq2ivV6r1AfaK1bJzdO5OKrFnUHVfg64eKpbvaE7A8Wj4NqimLkIsqc2dN+U21ai7BbWKdM0aeReTWcegVQd7MvMtrnLFshm7uatoC0lAyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775393951; c=relaxed/simple;
	bh=z5YtPAg8XuhKtTpTkGpA/ZcjkZXvjP1W36Qt/4mb4j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQwT1oZOOq5Xur0T4fNkVwRX8kgTXxdJVtBbdCoil44TOr/H0YXjnCBfniwlfnIzAwHfzOGaF9mzDcGQyqUgvZero82brFibnp5J8wGaHf6QtOZxjDpprVu9WmqeV2SO3FKRUDELzt+wANocPGug4hdyMNdMd2LEnkk+kBeKiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eBVYId89; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fOUBVYS3; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fpXb85VM2z9ysl;
	Sun,  5 Apr 2026 14:59:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775393940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4R/n7ZQ/NmN+wQpB0vnCOAyagNlgla6JkWniE2SC9E=;
	b=eBVYId89CzGEmfVIpLzuEfmYgwJHTBCyHlzqlgBQwc166S5x3Q/dwHFR/0NryLN9EnBKNx
	DIyOQRG4TVVBUbpx5dUtrswPATnRbSw56r0vsWsY5Lvl18UrDdvPeIkmrilZmHbQuHEKid
	CotNVEcel5WuM6QluTxJYb2AGtaZ40XxjG5CDdlQAxd8Ptb7DNbbAo/t1sIDdGMLypUB91
	1NVNS0NgfiWZw4T6zfxUvxKNOsHyeCrNvFXMbBWtZw2kEgkN1266kDn9cjgZzd4P4jdgpV
	ftUXrreAdpzcJa+tvjQOH2191/IivgKpCAry28C9W2gP4x/NjPcWRE5m1KE3xA==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775393938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4R/n7ZQ/NmN+wQpB0vnCOAyagNlgla6JkWniE2SC9E=;
	b=fOUBVYS3xL7KIcm1t+4LoGOigr2BfUwWd+dqET7D2ODOWLAQy0qeualSsjDGN4ziPbo3tM
	rhNdMgMySYQQyFKiMrx/fs7+eNhzkhqWxeX3EN4uwhetju3TQvw1WFA1WVFpC/XJhhBT5a
	vkAPlK2o64smJ7PiYUg4HM7WchcTfaAwdijzm43u+FAYvclMFRSAEFXXtC9so1naM3C6/W
	KT4s57XpkVpU+s1EALA13QVaK/zWoBZrpQCwYLT9YL5thBrI/tTmqYzPZ0qdKzdDYqiT2q
	umfYJ4+P5rf5q0v3TCHnKaIcJuWw9VRmbjIUzC5ZwxreGk6WupwKh0/xuzvZ5g==
To: davem@davemloft.net,
	kuba@kernel.org
Cc: edumazet@google.com,
	horms@kernel.org,
	pabeni@redhat.com,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH net v2] net: rose: stop timers before freeing neighbour in rose_neigh_put
Date: Sun,  5 Apr 2026 20:58:30 +0800
Message-ID: <20260405125830.89251-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260403204459.124812-1-mashiro.chen@mailbox.org>
References: <20260403204459.124812-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hcaqyrpieznhp65icxbjdkq5qg8a94k4
X-MBO-RS-ID: 553ccaf378a87f060dc
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275461-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,abd2b69348e2d9b107a1];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 3D53939E75B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_neigh_put() frees the rose_neigh object when the reference count
reaches zero, but does not stop the t0timer and ftimer beforehand.
If a timer has been scheduled and fires after the object is freed,
the callback will access already-freed memory, leading to a
use-after-free.

For example, this can happen when rose_timer_expiry() in ROSE_STATE_2
calls rose_neigh_put() dropping the last reference while the
neighbour's t0timer is still pending:

  rose_timer_expiry() (ROSE_STATE_2)
    rose_neigh_put(rose->neighbour)   --> refcount drops to 0, kfree
  ...
  rose_t0timer_expiry()               --> UAF: accesses freed neigh

Fix this by calling timer_delete_sync() for both t0timer and ftimer
in rose_neigh_put() before freeing the object. This ensures any
pending or running timer callback completes before the memory is
released.

This is safe because rose_neigh_put() is never called from the
neigh's own timer callbacks (t0timer_expiry / ftimer_expiry), so
timer_delete_sync() cannot deadlock.

The UAF can be triggered through the following sequence:

1. rose_add_node() creates a rose_neigh with refcount=2
   (initial neigh_list reference plus one held by the new node entry)
2. A socket connects via rose_get_neigh(), rose_neigh_hold() raises
   refcount to 3; rose_transmit_link() arms t0timer on the neigh
3. The routing entry is deleted: rose_del_node() drops the node
   reference (3->2), calls rose_remove_neigh() which stops both
   timers, then drops the neigh_list reference (2->1); the socket
   now holds the only reference with t0timer stopped
4. T1 expires in ROSE_STATE_1: rose_timer_expiry() sends
   CLEAR_REQUEST via rose_transmit_link(), which sees
   neigh->restarted=0 and !rose_t0timer_running, and re-arms
   t0timer on the neigh (refcount still 1)
5. T3 expires in ROSE_STATE_2: rose_timer_expiry() calls
   rose_neigh_put(), refcount drops to 0, kfree(neigh)
6. t0timer fires, rose_t0timer_expiry() accesses freed neigh -> UAF

Fixes: d860d1faa6b2 ("net: rose: convert 'use' field to refcount_t")
Reported-by: syzbot+abd2b69348e2d9b107a1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=abd2b69348e2d9b107a1
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 include/net/rose.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/rose.h b/include/net/rose.h
index 2b5491bbf39ab..c69024e865456 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -160,6 +160,8 @@ static inline void rose_neigh_hold(struct rose_neigh *rose_neigh)
 static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
 {
 	if (refcount_dec_and_test(&rose_neigh->use)) {
+		timer_delete_sync(&rose_neigh->t0timer);
+		timer_delete_sync(&rose_neigh->ftimer);
 		if (rose_neigh->ax25)
 			ax25_cb_put(rose_neigh->ax25);
 		kfree(rose_neigh->digipeat);
-- 
2.53.0


