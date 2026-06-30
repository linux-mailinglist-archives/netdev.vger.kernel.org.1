Return-Path: <netdev+bounces-303223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4pf1AsvPQ2oBjAoAu9opvQ
	(envelope-from <netdev+bounces-303223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7DC6E54F6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=R78WvwtA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303223-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303223-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3447A319CC34
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614C1423A9B;
	Tue, 30 Jun 2026 14:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B342316D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828396; cv=none; b=GudHHShHqGQsH7CFDd4F/ycU3jlDMkR5RoKsIXpvKKcgNhoVxOsr7tnNSoLvdGP3k4hacTzyG6ByY/Ofdz5bOleQQm7xJQ2jAjQ5TtLfMPWwqKVS/hm1yX8Cy1yeJhkvrPten6ibLrNTms18hy4yPoO3nYibZm360I0/txYZGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828396; c=relaxed/simple;
	bh=AGYnK8Y229cy2pULgFBWan1ATTD5fF6JHa5iBdp/dZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsgaT8YYWKQr7ZUJalaUMYAo0FOOWRSj0rxIydH+ZegrEExXMfhEAj2q+Qwyq1cTPhRSYNaLT0heMWe3vjFrAjQqAsB4URP2d+cpCIcM/9PoNtkK56uwuhIa4mE5S0E/x8EPAm0kSde6ATI5ORO4k758DtwZOt7JmRHdxGsHzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=R78WvwtA; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OE7kaThEXzmWHJ+vL8/Sll0PpMgBMOG7wZO9WyyOoi0=;
	b=R78WvwtAhpCvWYI04JrJvK9a/3wQdA/xlEyEfxVDslavU/7H2wCDgFVkAN2AheZ/uanrQX
	yzHgTGr+/LMKDIHBZI1ZRNweenkZhHy82D7KPke+hT4q1a0fT/UG+Z0K0Jxy1kijgBHj0X
	6MY4uWrCw7/s+C3zh4OKtDUrJ6+9qijtkyZHVvrTHkU4KoL6FVrbsoCIN+m0Fuu+st6bCL
	OlxrmNImdhkq4JL4sm+IOP/C20iTAFlNZTrIiXBbMIvCFc9hwDkx4bYMs+E+95YxnSwUz6
	3Igq4U5uT84QUFCdpQuQuvXDWJJLah6WEDDbKBeM0H2DNeA4EYdlvnmpoE7aGw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 11/15] batman-adv: tp_meter: simplify unordered ack calculation
Date: Tue, 30 Jun 2026 16:06:19 +0200
Message-ID: <20260630140623.88431-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303223-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E7DC6E54F6

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_ack_unordered() goes through the list of unacked sequence
numbers and checks for now closed gaps, it is first calculating a delta of
the sequence numbers which could be acked. Just to revert this calculation
in the next steps to the sequence number which would be ackable.

Skip the delta step and directly work with the sequence numbers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c2eea7dbc4883..b7fee6e55f032 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1493,10 +1493,10 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 		if (batadv_seq_before(tp_vars->last_recv, un->seqno))
 			break;
 
-		to_ack = un->seqno + un->len - tp_vars->last_recv;
+		to_ack = un->seqno + un->len;
 
-		if (batadv_seq_before(tp_vars->last_recv, un->seqno + un->len))
-			tp_vars->last_recv += to_ack;
+		if (batadv_seq_before(tp_vars->last_recv, to_ack))
+			tp_vars->last_recv = to_ack;
 
 		list_del(&un->list);
 		kfree(un);
-- 
2.47.3


