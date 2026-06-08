Return-Path: <netdev+bounces-296631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lgBDOI/zJmpdogIAu9opvQ
	(envelope-from <netdev+bounces-296631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:53:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B17A658F2E
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:53:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openvpn.net header.s=google header.b=IJyHuCQj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296631-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296631-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=openvpn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5071934B7B2B
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58C23C8C65;
	Mon,  8 Jun 2026 15:08:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C34332FA2E
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:07:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931280; cv=none; b=KMwNZ6M+sbLdz6liCeXRmI2P9aNuUxWslTy4CFrhMf3VTr/k08HdoCCtlldWuvVfE/cMOLJ1W0iNLEFQwoqaCYwjJFJ9OY4jFhNFWvj29iHHpzdLokRzKMh6boMSrhJD3edZ587wbqkBvmiSi37N012C8CxwZWgyQ9NR7cXCEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931280; c=relaxed/simple;
	bh=xmfoKUNR8so5IaktR9IqC45idfyPgZdeFtFlKzOF5zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzRpQkr6i62YQn8zbNNojj7WLXySSPeFeTN9sIHs8oSq0SYcn4sL8OqISxZsmQCYRlz6ERkAmhk7TYKGCSK29Jo34zcL4s72gbbmtK5xiSzVGscEqwUi9xGiICKi5yIyVrqnruqg1FAOWE2eMU3mUUy5U7pgf02dsHk5tlstqWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IJyHuCQj; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b12270b3so26754595e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1780931278; x=1781536078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDzbekQ+Dqd1pdxBTtdax0VXtGGOz7Q6ZLK3fDZEuRI=;
        b=IJyHuCQjSau8fTkd17vxDbEknSt0kF3IQRSDZ3kyN4lbenewiWJmEmChJ8vNReHChj
         DZ5funCwgBleymKsvCnsvNGFI7GbAkeU66RSYRlhgWWTVYHe0ra4CIs2MnMdGfwmFGoH
         5fdhoJsk72LR9K0xNlhlbQm4ggqzPKnWjYdn/ikGTMu3RCn6Zv74Bg+amdnB4HOQGPrb
         r7/N1MwaJGYuHafnOeWNYtKWEdySBKVovHaQEcwZCD5bXKaXhlYYRypvCbVA0zGtpCVx
         hMr0GhH6mtg+6rzY/YTzCXXsSxl3er0+i8kOZyXgl7Ow8bHzh/bTdA7vPESfKXOj3G1R
         /H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931278; x=1781536078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDzbekQ+Dqd1pdxBTtdax0VXtGGOz7Q6ZLK3fDZEuRI=;
        b=WDB2R6NISU1i6+fCmHHc3rW1iYcQ02YhEhNsWs7Mm2sMp9yqZsXRTUaAJhtBr/Kfsa
         ah2ArJ39quLOVRtVX3a1YG2PmuKmZ4NAOzctHst8OgLtVGRCrMuHuO8q69rNCLeqVmXV
         etqqgi2hYcKXOWXMJMKm+hoicEJWSMziKDMjhImG51lMyZqUX6iq4IDDkOJQOd9TCkxB
         Bd+8ZGU/64q4ZELQKgNakDj1ZHVfNTnynVp7F0wCCp0zvUBgjK9Ez2vkPKJ5/oE6lwR3
         IGCAIvkcUxT6Y1rfBwr5Zw50Mnfb3xdQjx4D4e7GsBcao0xI8p6WUfW+ovHjYeNaDK0U
         tkGQ==
X-Gm-Message-State: AOJu0Yz0eKoaUQ5WC0zfvyncwTogo5KgT9WxQlu4KMh2h7r198bAABeF
	k2PBvdYmGOq8nLHwgmYFiUUZZqJZvMyyZ4BiyKp8jbz90eyUtjnGfnvcTH2heoOp/XK+uCNDX2J
	9chDfI/gEbZECgKpuZoSVabTdomXDCl+96CeUMt+94BmkQ6MSf6S8A/jKds29S+vYKK0=
X-Gm-Gg: Acq92OE/eGpK74/SNCc94kk1UZpIX2WlTqgryNWEAITwKgO0CxdXJP0T1361OwWsRzk
	J5ZsASoeAJpJljkcleMj098Yfq/nPo0DR/+UopqLaXvhd2q66zlXJHp79h1xh5pYZtpRkgDR2vH
	QO6/zyuFeJXkP8kygKxxGAitT/Hp9BRWZS27UR58NqIP2UPUtyqLmC8DfKGLVEh2wRDo75k0VDF
	vtLE2sWg3q8NTk8erTvv30Tzsid4glDXxGJbDAOSDJKUTxPgky1VNHEz/htitBokkzc95H4vS9N
	8fGiHN08pPaD++rraWH48rxoFZlBUoaDFrBNqIrLgr3xm0To2wK9auE7vvvIzGBsCOqjP1Sr/KX
	b7tM5M+lL1Br3p79ZXc9M/b51GbEYL9Q24h/cMw5N9r51KiPtARJ/GsL9ecftDl+hX4UgUsx8Zw
	Dbk1+tiRa0+AK0NC3HpqnXMegFjfN/kFddrAVYrlfANBLoaCBJmcfA4OatTZWHzwY5bz3k
X-Received: by 2002:a05:600c:3515:b0:490:b5d0:598e with SMTP id 5b1f17b1804b1-490c2604783mr249096285e9.21.1780931277859;
        Mon, 08 Jun 2026 08:07:57 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:7e36:aaf2:5280:7b3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39def5sm390659705e9.5.2026.06.08.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:07:57 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Shuvam Pandey <shuvampandey1@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Ralf Lici <ralf@mandelbit.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/6] ovpn: hold peer before scheduling keepalive work
Date: Mon,  8 Jun 2026 17:07:34 +0200
Message-ID: <20260608150741.3320919-4-antonio@openvpn.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608150741.3320919-1-antonio@openvpn.net>
References: <20260608150741.3320919-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,mandelbit.com,kernel.org,redhat.com,lunn.ch,davemloft.net,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296631-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:shuvampandey1@gmail.com,m:sd@queasysnail.net,m:ralf@mandelbit.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,queasysnail.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B17A658F2E

From: Shuvam Pandey <shuvampandey1@gmail.com>

ovpn_peer_keepalive_send() passes its peer reference to
ovpn_xmit_special(), which ultimately drops it. The keepalive scheduler
currently queues the work first and takes the reference only after
schedule_work() reports that the work was queued.

Once schedule_work() queues the item, another CPU may run the worker
before the caller gets to ovpn_peer_hold(). In that case the worker can
consume a reference that was not acquired for it, corrupting the peer
lifetime accounting.

Take the peer reference before queueing the work and drop it again when
the work was already pending.

Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/ovpn/peer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 1844d97154ce..2b6096d8b1cc 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -1284,8 +1284,10 @@ static time64_t ovpn_peer_keepalive_work_single(struct ovpn_peer *peer,
 		netdev_dbg(peer->ovpn->dev,
 			   "sending keepalive to peer %u\n",
 			   peer->id);
-		if (schedule_work(&peer->keepalive_work))
-			ovpn_peer_hold(peer);
+		if (WARN_ON(!ovpn_peer_hold(peer)))
+			return 0;
+		if (!schedule_work(&peer->keepalive_work))
+			ovpn_peer_put(peer);
 	}
 
 	if (next_run1 < next_run2)
-- 
2.53.0


