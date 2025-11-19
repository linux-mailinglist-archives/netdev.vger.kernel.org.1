Return-Path: <netdev+bounces-240192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11821C71519
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 61CB52D4E4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F732BF38;
	Wed, 19 Nov 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="VRJDXSOs"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F97329E76
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 22:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592163; cv=none; b=s4Rtps2XfnepA03qLzmrR+5CNTWwFrC+Yhq7I7npxH6QwvTf7Qcx2lOF1gaOHMRYGcu59Z8ATBmy37QqcStlOXiLuD7iZdjR9YnBcYe5+/AG+9jBYRu5xQg7QWcOhEQaaNbuOOjHZ4hUf6qi5QD/trLiDdRv7VWD21PHNyyQz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592163; c=relaxed/simple;
	bh=jdsdnQfEeKhULD5LDqMlrha91I1CSQoU+7lDJH7uZ2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfhZsqRYip9A3u/NsRpXNhH+a0ZalKgtqvvV8rhzqmzBqU+It/7TmWaH9aMoDjQciDvhWK+mtLwUZ/lqGjZV2ejyD2nCyy5b9T2VNW1WLkeyuWfKrZKyTgddlkQLbUWtlmT5ILWKyiD8NWWhPmeosHDeTduGw4ow8aXLEB4wIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=VRJDXSOs; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsj-006yoH-V0; Wed, 19 Nov 2025 23:42:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=7JhqI3glyw6HOLsTlPkKP1J1UeeD/y9Xa20+m5h05cg=; b=VRJDXSOsQBIkifujQR+BqUZfjh
	LmSs6duSgOrYsPpRuXEIfjXer5MWRtQxgc5O4jGe+sOY6Pny84w8HKxjn/hSiR+CxIseyLeot1XUB
	HBGJwL22Rh9lF5Fjaf9ntGhAlPLaHahZ8D700puGP80PVsIenOz+6Bg0ACnzsipHAnS67IW+2Bpfu
	bQrFKhdJ0PQBvuewryQr++oOcgPZvu+psqsvBxTQ+mSbzgV+4mHehqNEjVffjdbpEczL9oWsxWTjc
	CUC3+6+HVVDw/9JqnQsUga1PYmxMjDKmkySiKrhTef7xZofgOuhhQK5ScVsGK83U864Te2YqRcmn9
	uV+fNu1w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsj-0007zu-MV; Wed, 19 Nov 2025 23:42:33 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsX-00Fos6-8W; Wed, 19 Nov 2025 23:42:21 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 07/44] net/core/flow_dissector: Fix cap of __skb_flow_dissect() return value.
Date: Wed, 19 Nov 2025 22:41:03 +0000
Message-Id: <20251119224140.8616-8-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

There are some dodgy clamp_t(u16, ...) and min_t(u16, ...).

__skb_flow_dissect() tries to cap its return value with:
	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
however this casts skb->len to u16 before the comparison.
While both nboff and hlen are 'small', skb->len could be 0x10001 which
gets converted to 1 by the cast.
This gives an invalid (small) value for thoff for valid packets.

bpf_flow_dissect() used clamp_t(u16, ...) to set both flow_keys->nhoff
and flow_keys->thoff.
While I think these can't lose significant bits the casts are unnecessary
plain clamp(...) works fine.

Fixes: d0c081b49137c ("flow_dissector: properly cap thoff field")
Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/core/flow_dissector.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 1b61bb25ba0e..e362160bb73d 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1023,9 +1023,8 @@ u32 bpf_flow_dissect(struct bpf_prog *prog, struct bpf_flow_dissector *ctx,
 
 	result = bpf_prog_run_pin_on_cpu(prog, ctx);
 
-	flow_keys->nhoff = clamp_t(u16, flow_keys->nhoff, nhoff, hlen);
-	flow_keys->thoff = clamp_t(u16, flow_keys->thoff,
-				   flow_keys->nhoff, hlen);
+	flow_keys->nhoff = clamp(flow_keys->nhoff, nhoff, hlen);
+	flow_keys->thoff = clamp(flow_keys->thoff, flow_keys->nhoff, hlen);
 
 	return result;
 }
@@ -1687,7 +1686,7 @@ bool __skb_flow_dissect(const struct net *net,
 	ret = true;
 
 out:
-	key_control->thoff = min_t(u16, nhoff, skb ? skb->len : hlen);
+	key_control->thoff = umin(nhoff, skb ? skb->len : hlen);
 	key_basic->n_proto = proto;
 	key_basic->ip_proto = ip_proto;
 
-- 
2.39.5


