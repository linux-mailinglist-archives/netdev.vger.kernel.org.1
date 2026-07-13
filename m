Return-Path: <netdev+bounces-307268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4rv+Gfo/VWpUmAAAu9opvQ
	(envelope-from <netdev+bounces-307268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:43:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAB074ED7C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:43:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=opSmBt1X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307268-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307268-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD8431017C8
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B235A93C;
	Mon, 13 Jul 2026 19:40:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2F35838A
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 19:40:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971620; cv=none; b=EQiGqxZNYum0S4O2gszVV2lA8QRZ4mH7EKu5FYrMBEiIFTgk94FnXUFCKP93AI4E01K1sOkaLGGwyCc9pkgPho3b6RKU/NeUzRtyyw/aV3X1TzHZ56TawUS9ZQruqUGyDZkKFu/LFgTRikohwXfaUTQP2ep1F2DKzkJh+KTUxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971620; c=relaxed/simple;
	bh=cBBAAXVfz2OnPP835VfCEgjtcsAJ50plKAqlklYzeK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyTVPOnDXv20qhNVBaLvNv60C++acsgGOTXTdOKcqR1Y2yg6sTv2oowT6Zc+iB2TJIIAC4ZsDRXgazscIfpr/NkfA5YA//PjLC4kdN2UMGYWWiiBos2WXPNRASFy2qMe0M/9b3Zek664WNBUsb6Y3TveSplnZlRZwBouYFx9Ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=opSmBt1X; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493f431e317so2504695e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783971616; x=1784576416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7xWVihr3+KHFM8BLDbVBGdvZbVrj2tho5cLk2/xNCU=;
        b=opSmBt1Xu67tnrgXx4jSRAZ8V/f84TSLZnBd+blsRbLHN7Ou9g3lDzDCj5TZUvX9l1
         6ljneaAw+WN/RJ+VvBzT4JJNAB59PhzqXhF5jP/O7ZZBSi7jZr82DdwZWEdoNQxOSkzD
         FROF1/tRenpwUClBPQmXlhNRT1WblHAkw7tPz95LjqshEykIkktGuhlVJcxKvt7vTppb
         IHZeoVD/DVLeSdQoLdWsOc7vh+R59UelE3+veBuvL70ozgNC3C5jQKkZuHzhyVqYVqmC
         H7ItH46lNAThPG0+3yhK7QYHEwPAnZAA/ONf58lG4ETGD03pkkZvy2yT/7E5pEmDvaYw
         W4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971616; x=1784576416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W7xWVihr3+KHFM8BLDbVBGdvZbVrj2tho5cLk2/xNCU=;
        b=DEWtIc0QwipxvG9jh3nKklKepoiw3ewUTPpMlGNd/le/nT4JB4OUCAJ7arRwaoJLwj
         Hv1/jYf69FMyFrs9npIBxanmdMLHPPWw2lzziujJl9WSDiK5KPPg4zpp71QzYrwExOw2
         bqapp3sqcHSGNiLt77GqT1pR6dLgEk25IQiuqaAzJbwJgPgOph7/YWl9CTAKUjiQcT0B
         qqUEib0m2/USrBD2RrBw+wXYWy5l9PQorWJAdxzXc67NDCYlptbIWWN9hLyojMN6zLYK
         u+Qbg3ztsrnYKXtE1G8AL0zAJ2aPjXtFus7CEpIAKG4UJvnYS7fRF1VKCK8X2tqOrrex
         bnDA==
X-Gm-Message-State: AOJu0YwMU3tKJ5Z0K9Miwx/IKEBWbXfiF/q+dJbCaQVBbOOKUJ84Oa17
	76ClcOc/5F9N5j4Rr7cC4+jtA6oxbDWJ7Yy5j+gQBot6VAWzIM/yfdLKqqbE5BS93QLRc7hq7Sb
	fVDZ63fRc
X-Gm-Gg: AfdE7cnlTNZO78rBimsQHl0mu1FzjFBq4fnMvWzDjNT+Z5QDw6GB1zHvyJL77jkw1a1
	zUjSUOW8Q2Bmg6d4rpF5pHbUQBsgP1dT2+Wu2CGF8v7tDbGLRJLxB+uYsU1pwDVx3r4BOIYvHrr
	E31YwCo+5hAd6hbr5LOhzVZHtyTOXKWM4F1Yo7PK3A4B3mR+Ws9MaCed1o1U5YNTQEzj817zX9w
	U7YM33KRU3zfUzDIKMtS6D8ghAr3eLfRKJTXxvVDWCHKqc1TMCwz3QboMsUD52LWxjT5TP6QrrF
	fQLcBx1zVQ6P28lyowtJOlJ0DGKKXQYdhxKcJAWfNnE4cfyaD2QtxnTox1G1ah6MlK973QL1mfA
	xddveOQjleiw+hOCeMO+fZAUqqf0YAnuenO0aylXl+DZmdKBjM940khOKJapDAlmn6KbNGyOFLM
	px1fMOCuzW/U2FMrPpdRlsPK5axrFcCTuCL3wvrjeF8w3ae0dwMB4/x6OQuy9hQdhIIwzHZz8Mw
	bcb3Qhok+iiO8bTrgikQdUEK4uOmMUrzKY=
X-Received: by 2002:a05:6000:24c2:b0:477:6da:1b83 with SMTP id ffacd0b85a97d-47f2dcc8ab8mr11941321f8f.24.1783971616139;
        Mon, 13 Jul 2026 12:40:16 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c4320sm1648928f8f.32.2026.07.13.12.40.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 12:40:15 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Nick Child <nnac123@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	stable@vger.kernel.org
Subject: [PATCH net 1/3] net: dsa: tag_ocelot_8021q: don't read an unset MAC header on transmit
Date: Mon, 13 Jul 2026 21:40:08 +0200
Message-ID: <20260713194010.54642-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713194010.54642-1-doruk@0sec.ai>
References: <20260713194010.54642-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307268-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:andrew+netdev@lunn.ch,m:f.fainelli@gmail.com,m:woojung.huh@microchip.com,m:nnac123@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:sd@queasysnail.net,m:arun.ramadoss@microchip.com,m:UNGLinuxDriver@microchip.com,m:mpe@ellerman.id.au,m:doruk@0sec.ai,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:ffainelli@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,microchip.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEAB074ED7C

ocelot_xmit() reads the Ethernet header via eth_hdr(skb) to test the
destination address against the link-local range.

On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
reaches ndo_start_xmit() with the MAC header unset, so eth_hdr(skb)
resolves to skb->head + (u16)~0 and the read is out of bounds.

On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), as
done for the same class by
commit f5089008f90c ("macsec: don't read an unset MAC header in macsec_encrypt()")
and commit 96cc4b69581d ("macvlan: do not assume mac_header is set in macvlan_broadcast()").

Fixes: 43ba33b4f143 ("net: dsa: tag_ocelot_8021q: fix inability to inject STP BPDUs into BLOCKING ports")
Cc: stable@vger.kernel.org
Found by 0sec automated security-research tooling (https://0sec.ai).
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/dsa/tag_ocelot_8021q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_ocelot_8021q.c b/net/dsa/tag_ocelot_8021q.c
index f50f1cd83f16..4514026897d1 100644
--- a/net/dsa/tag_ocelot_8021q.c
+++ b/net/dsa/tag_ocelot_8021q.c
@@ -71,7 +71,7 @@ static struct sk_buff *ocelot_xmit(struct sk_buff *skb,
 	u16 queue_mapping = skb_get_queue_mapping(skb);
 	u8 pcp = netdev_txq_to_tc(netdev, queue_mapping);
 	u16 tx_vid = dsa_tag_8021q_standalone_vid(dp);
-	struct ethhdr *hdr = eth_hdr(skb);
+	struct ethhdr *hdr = skb_eth_hdr(skb);
 
 	if (ocelot_ptp_rew_op(skb) || is_link_local_ether_addr(hdr->h_dest))
 		return ocelot_defer_xmit(dp, skb);
-- 
2.43.0


