Return-Path: <netdev+bounces-306794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4fAkBIILUmoRLgMAu9opvQ
	(envelope-from <netdev+bounces-306794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0208A741096
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:23:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zi0+QbBt;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306794-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306794-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F30C43007B17
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C400388E4B;
	Sat, 11 Jul 2026 09:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E0386422
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:23:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761786; cv=none; b=sg4NQDXpGivCqzLGWuFbmoCg/9wuWYQ6KQKleQU8KGPGwiq28CkySoOERWG+d7cg/j0mzhUXFJ1Gv61i6Q4ol5fusXkWDBk9cVH62O+dcHyN55988JdvQydYgwGFLx8c2Kex8EZS0Wi0jKIwDMxCq3Qib3EyKUf4oh3/x+j5nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761786; c=relaxed/simple;
	bh=w5gP4i8nA4yRX2rouKTaGTuvg441hZXElpGa9JUERWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMXYy3gYUetBC8CMwIB1BbGVEY5EgsoDirp+zvj1kvUNEyhhlRqRMW3qhp7RM0xD62y+Sw2KxFMVuCZjSP0aiDX89FV4RMlIVc8An+GndOBralZlmNKhAW6S9JBVgM+xQMqd/k4CUHeqcONwOCZcLFCmlttVcNbB0et61bNAKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi0+QbBt; arc=none smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15ee037bc0so247476466b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761783; x=1784366583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BtP7rhvmzwHbUusKt6iPMmMpBZakgxbufeBSajlZBtg=;
        b=Zi0+QbBtXYchHZJdQ/S2J2Dc+TPZ5fvy8N049QocBs1g3LSH3IlpgkikIrryNbh3HT
         UIyaPI5vj7B0adz9dHTyZxhkuhFsj+4v2On3dNzo/eAQIwXcmIxy1mRi3/wIjkNyaI8x
         cDYyUYixu6TeFY4GHRdWUd1us7SfsN01w5Va4Oi5LI6kpWnKIhFiBebDucy31hvy9aRi
         /CRGsp6demg26Vk/1qLAKdmef2FaktIf5G1NACHg8mkbsBn9tR7W32ImJ53ItLhJuUo5
         usbnMA8XJERpAGAxSD+aqA4lxO6RiLmfL4ncepG3gTFeTa8eTDJ3ba4OXeCgK+DrcByx
         DUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761783; x=1784366583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BtP7rhvmzwHbUusKt6iPMmMpBZakgxbufeBSajlZBtg=;
        b=jgBM2/2klUpdWovsOIFcUY7Z15t6S5saPeLFBGnx+LBgrGz3sICTcqCkhV3NVv/QYI
         7PBmILtPQUNEquH9WHoRAq4MGiCnlpPaL4Vp5pPBcyp4ZJ7BSfmfwS6EN7/6cWruuINu
         CZu0XHlzP3MYHb514NrzuH78u05RQDrquwH3DWQHjmbp/avVV7dKfcPTGR2JDYCI5+Fh
         SWN9q+ffgZrsIHWhOsSyt1/5cZqbzOBZ3QclNQYpG9p8VSPnqkyIz8304GF9YMx40Oyz
         tcTDaHPjRCkxVXlfPoRYbbsp8wlX6QsvEZ/g8zrIc2kUVj5+moPU97LU9TXHn3IkEhox
         ONpg==
X-Forwarded-Encrypted: i=1; AHgh+RpjMKesjGKV2/1HSCbgWdQU/L8U61f0G2HJw4uCeFqMgUGZhvu6tsOAbyDocEq/WQ8GqFku3zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8LI3Y95xWCOsxw9Mk7HMS/3AesOpjPwE7vuGFwU1Ldfyn/Pu
	5nL+zoHL03hVzO3FKttvoyJpO6RsacjluYdKK99v8lu1MPh7SDb2WK8h
X-Gm-Gg: AfdE7cna3VjlR+TH93Llf3O7EMVxyKUrUWMtxzPsTdjIwENFMBU9eykVfL2aY4Dj9eg
	7ANNI+cLAh0aZPcNz4ByacFaZwPTypNRhw0CcDBwZAEWj369c/97wDuwKSsCS6ufynvhKiYpXFb
	fevBIhfXxrTlOnIRiIxgve2bAkbzsdGBNQYDu9bTWzmz5EUwaPDYr3piguRrYgyd5BzPJM9bGdN
	AM2kH7i6dSUwqS1GQN3Jmj/p7YiID7juNcY0L3rSV7j/rXRqIi3PW3XLqS9uTGZCCFEb30Q0Py5
	Hzu6jQNHbTAfE4GyHEgCN2NiElYzyhuP0lHjDV6nVk8qtOihvROS+q8mpMQP9hITcC05vmQpwb7
	HYRJ2DA3GKtME6Tdb1EHZTn1qEpnTNZv7m4jtfCwN3CAWAEjt3ipa9cVZ5Qp0pCjJWaJFHamvGL
	1Rpluhblpml4lECxzLdBLvfxxorG0gjhUwawbbzINcO+Bt47ebCc759yzSshjQKa1mf/VnhnkPT
	uw4gEBe0iRTE8Bpo+RWUYburqhC73T/wxr91DZKt8CGDes=
X-Received: by 2002:a17:906:f5a1:b0:c16:1579:762b with SMTP id a640c23a62f3a-c161f3b54ecmr79745966b.52.1783761783384;
        Sat, 11 Jul 2026 02:23:03 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d3859f69sm517493566b.27.2026.07.11.02.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:23:02 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 8/9] io_uring/zcrx: steal niov refs
Date: Sat, 11 Jul 2026 10:22:18 +0100
Message-ID: <421a7de8c5ddffd3461e416998f6fb034ffb0282.1783619193.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783619193.git.asml.silence@gmail.com>
References: <cover.1783619193.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306794-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0208A741096

In zcrx_release_skbs(), we reference all niovs of an skb and then
immediately put them down. Optimise it by stealing the frags.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 3d5d5c9fd9a5..23669471a8f0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1317,11 +1317,22 @@ static void zcrx_release_skbs(struct io_zcrx_ifq *ifq)
 {
 	while (1) {
 		struct sk_buff *skb = __ptr_ring_consume(&ifq->skb_ring);
+		struct skb_shared_info *shi;
+		unsigned i;
 
 		if (!skb)
 			break;
 
-		zcrx_user_ref_frags(ifq, skb, 0, -1U);
+		shi = skb_shinfo(skb);
+		for (i = 0; i < shi->nr_frags; i++) {
+			const skb_frag_t *frag = &shi->frags[i];
+			struct net_iov *niov = netmem_to_net_iov(frag->netmem);
+
+			/* Take niov references the skb holds */
+			io_zcrx_get_niov_uref(niov);
+		}
+		shi->nr_frags = 0;
+
 		if (skb->fclone != SKB_FCLONE_UNAVAILABLE)
 			__kfree_skb(skb);
 		else
-- 
2.54.0


