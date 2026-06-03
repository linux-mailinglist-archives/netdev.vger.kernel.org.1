Return-Path: <netdev+bounces-294616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c8iXOB/ZH2ocrAAAu9opvQ
	(envelope-from <netdev+bounces-294616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:34:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE55635425
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=f6v8iz4m;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294616-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D72B31AD96C
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105D3FD971;
	Wed,  3 Jun 2026 07:25:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8343A0EB8
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471540; cv=none; b=PLdQykHGEpHUOuWA1ajBptw3WkuKM8Vhj+qoIyrNt79b7Lgbde6elHnyJwnnB/6q6bvqV4s3ZL8K7sb7TFM6UpwutgLbkp4x3OQ1P+yaAuKIzd6xUBAw4340z7cAepjatdhtMfuL+wE3WU+6QxYchorFCx7NZ1tuh7lp3ZT5C0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471540; c=relaxed/simple;
	bh=xm9P73WajZ/NeBDnI6OiK22FDHgIsr/xaxZR9fcp97w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odIE2DVMg4e9qGBu4RSbzr3nwEDJt9xjxiXm3Oxb5vfz4WPb3kVX0C3i1mb10erDfGpzTwTMsAyL7ZaLLAm+B4il7u7Sw2BFnsLC3Q1mJfisISKeV/5qHZyadbANsOrwqQomx+tMa3nVSdSVhjhP+ho7LA4CFmvYlMana0Xm8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=f6v8iz4m; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e+83fEsbAL69oKWYxDFj7s2qHg00oHFkNjwBFZNJ2Lc=;
	b=f6v8iz4mYK/t+dIlg5vlY9pW/piwxb51qHhTAc2ZgNTJCjJdWZZDMSUdGt8kbo3JdTHlFJ
	zEf73MUKltr1UzogMmGVRSVw/sYY8f07ICZF0qGqo58N68qA/bCZ4I7KcZAbR5r3aJKLYS
	W2AGAf5siXF3gHO7BbM2GMg03z/W4x3qCquSR+jzjWEHAn+z7FGe5lCKbXibn7lLOy7P4Y
	hm8NEnm+ip+Mo2MlPRIRw54UyekhPCO41utbgtVfmpb4uFwZPV2VRc37dnom8QQ4sMUomF
	32aZdr3Col04mLuTRVfBS53B5nn1r3cAYa5GwS4ppVVFu76OKiE29jUocQZOSQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 03/15] batman-adv: tp_meter: initialize dec_cwnd explicitly
Date: Wed,  3 Jun 2026 09:25:14 +0200
Message-ID: <20260603072527.174487-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294616-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AE55635425

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_update_cwnd() is called, dec_cwnd is increased. But dec_cwnd
is only initialixed (to 0) when a duplicate Ack was received or when cwnd
is below the ss_threshold.

Just initialize the cwnd during the initialization to avoid any potential
access of uninitialized data.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 8d7308327a9bf..beabc264a4f16 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1055,6 +1055,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	 * mesh_interface, hence its MTU
 	 */
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->dec_cwnd = 0;
+
 	/* at the beginning initialise the SS threshold to the biggest possible
 	 * window size, hence the AWND size
 	 */
-- 
2.47.3


