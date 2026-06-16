Return-Path: <netdev+bounces-299929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iOQ0DamLMWoHmQUAu9opvQ
	(envelope-from <netdev+bounces-299929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:45:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1703693711
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:45:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=A4rQfwjo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299929-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299929-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 633EC3210BBC
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1346947A0CD;
	Tue, 16 Jun 2026 17:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E423A9627
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 17:38:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631529; cv=none; b=svcJhbexhCnQDuufd7C0QeBSgxtlQEjj0w9NbyB6lTrH4b3dGwLRyvHLKfqxBZRjso9LxSv/KsBJzIi51xd2iFlcbdqxdy4tLUY4tSFn1ODIVpS/0LW636OjvhhaqUNbYwncMO0l3rgnPrs//ZRy8BCRzK9WfRpx9sYO9QYyBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631529; c=relaxed/simple;
	bh=KU086ZV87RJsDDdROV3/g4cXoRGVzMGND86NCTP0dbM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h9B2qgCqATph50A/FBIZcRnX0oajy7wPpa6lettB7w5UumqO6Wjhq2QtkZSzHDTzYdZeboMAHP2fOrgeoxGBrhhLMRtHwUYnr60gKZZ1YnAkKaCCvccSiVzrKCXW6Jk7IE0avj1qDSttwbpP20Syif00q8gOQ/K3h3+tqY18r1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4rQfwjo; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37c5b9d42efso57887a91.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781631527; x=1782236327; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0CAxTxP49ad2IHfcJCxB/2dsfQiiRHbXlpQIkr0ZpA=;
        b=A4rQfwjoOTcXOq0WvATz6MX4Km6+hvyk2CIEDwtja3az2jsBHYernLitoEa7ICRCnA
         X+SwkQg7p2EqF4+g7d4qk1fSoa7/WXKUeu6J5IJLNCovuqV+NcOSbO+KKRYar9o9VOH6
         t9SvcT48WISr9oeWvBqn6UgIzGlfhkGTBQ/XgWx56nLwXTQozEyIqNrVhE2vPGgxFd0I
         qelU5ZBQoREdBMHRtw5RUBkgetMMo5oC5vR6hYM2emn0YWahr7MoMSrET6poYSlDWp/4
         d5H2FwSMwGpjIn8V4AqtTFrrGZSUsY0O7wekSVObjVO5ue9zTRvGfZpNfAfHXz6WQtjF
         ub7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631527; x=1782236327;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0CAxTxP49ad2IHfcJCxB/2dsfQiiRHbXlpQIkr0ZpA=;
        b=qZdboNsieCi3v9F2i3GjXBD+yK8yVOZTSMntubBH4V9GIhJuHjd+ZKheG5f8EqIzIu
         K68z71g7CJrUW9AxmA7pmmHalHR3aTHQSsH0N9b+86sWD/ANbQ+DTEjMk3LHS2O+F/H4
         +SUApqkJtjdCyTWSOofKAIxIJtald+wkqadHOlVOkOGxIbHaa/IxeoweKA6AzEirZ9Uh
         n/oKfhdSG0xHAI7v8UsjuU2uX5YOk7EMtY3ucOjekkiJhvM4u6Os/L28f6E/6ofusj8H
         66rQdj2t1nyF6LBYe9ZEpM/QXFT5medLNI4FPuzU5qFwlnbXkyc/zDcqo3n85anGoycA
         62Ag==
X-Forwarded-Encrypted: i=1; AFNElJ98/wb+qsFW+QnOUFvY0gnse/uW0eVJzCuxugW8DhSWbO8syANtN1jU/Sc9NU9G3ah6ohhb0Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiDx+2WEL8JuXorhoYHjCQhwxk3FFPosAGeZoLsmPv1ui5zwT
	NbSZ8kzy+RI55NdBjqmd63YKpMFEOI6oo168uztgafoJQfiC/Qfrl+xL
X-Gm-Gg: Acq92OGxCN3mGYLUh9cBfR3qwjrLWwlwAhSSGU+KZAOXFuJ8gL4RyyH5UVFGZByH4YX
	lzAm+Tv8NADqswkaDOUtdn+5a5eX8KaUXPIt0KC0gF/CVAb04YfZUCneEC418LXvfN+hQngNRmF
	WnqWxhDUFCrl+GsBTFhhlLwj6z5PMpj85jdUihMz8sBj89N/glk9fosn0DJNtKVNv+jIhLUcjMs
	mLR0Z+LY3ES9GyMs0sVyKdM/Nfu4vnpEkS7kjoQpG/vHZCGZVdTMTZuT6+6v78gmvOxrmKqO25z
	HfaLgYQzCJ5VuJUEvthTFfWmLXZdzTO91OgWCyIvldNVS6zSVyQBeK3SnG9ibkvQCrgst+Rqa5k
	qwHj0nlf6c9wp/8CAukcXYHYjRCWI5T7sTtf4nYKOi/7ppo5/3gNXSY/LBcaS47euRpcouHz+PX
	JGSkCEYu5rSo0l3Q6xzbJXRMCfQk29HUfn8KQluc6XcIkrofOu
X-Received: by 2002:a17:90b:4a51:b0:369:1dbb:4732 with SMTP id 98e67ed59e1d1-37c8c660d75mr542268a91.0.1781631526784;
        Tue, 16 Jun 2026 10:38:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ca980sm3681648a91.6.2026.06.16.10.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:38:46 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH net] net: thunderbolt: Fix frags[] overflow by bounding frame_count
Date: Wed, 17 Jun 2026 01:38:41 +0800
Message-ID: <178163152194.2486768.14724194232649760778@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com,lunn.ch,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mika.westerberg@linux.intel.com,m:YehezkelShB@gmail.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,maoyixie.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1703693711

tbnet_poll() assembles a multi-frame ThunderboltIP packet into one skb. The
first frame goes into the skb linear area and every further frame is added as
a page fragment.

	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
			page, hdr_size, frame_size,
			TBNET_RX_PAGE_SIZE - hdr_size);

A packet of frame_count frames therefore ends up with frame_count - 1
fragments. tbnet_check_frame() only bounds the peer supplied frame_count to
TBNET_RING_SIZE / 4 (64), which is far above MAX_SKB_FRAGS (17 by default). A
peer that sends a packet of 19 or more small frames pushes nr_frags past
MAX_SKB_FRAGS, so skb_add_rx_frag() writes past skb_shinfo()->frags[] and
corrupts memory after the shared info.

Tighten the start of packet bound to MAX_SKB_FRAGS + 1 so a packet can never
produce more fragments than frags[] can hold. This matches the recent skb
frags overflow fixes in other receive paths, for example f0813bcd2d9d ("net:
wwan: t7xx: fix potential skb->frags overflow in RX path") and 600dc40554dc
("net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()").

Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
Mika preferred the bound in tbnet_check_frame() over the nr_frags <
MAX_SKB_FRAGS guard in tbnet_poll() that I first floated on the list, so this
rejects the oversized packet up front. Reproduced under KASAN with a harness
that mirrors the per-frame skb_add_rx_frag() loop.

 drivers/net/thunderbolt/main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 7aae5d915a1e..ac016890646c 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -787,8 +787,12 @@ static bool tbnet_check_frame(struct tbnet *net, const struct tbnet_frame *tf,
 		return true;
 	}
 
-	/* Start of packet, validate the frame header */
-	if (frame_count == 0 || frame_count > TBNET_RING_SIZE / 4) {
+	/* Start of packet, validate the frame header. tbnet_poll() puts the
+	 * first frame in the skb linear area and every further frame in a page
+	 * fragment, so a packet may not span more than MAX_SKB_FRAGS + 1 frames
+	 * without overflowing skb_shinfo()->frags[].
+	 */
+	if (frame_count == 0 || frame_count > MAX_SKB_FRAGS + 1) {
 		net->stats.rx_length_errors++;
 		return false;
 	}
-- 
2.34.1


