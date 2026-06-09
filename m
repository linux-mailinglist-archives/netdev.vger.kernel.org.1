Return-Path: <netdev+bounces-296898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RuAzGiCTJ2o8zAIAu9opvQ
	(envelope-from <netdev+bounces-296898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B932A65C2D1
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:14:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=DJEV4apZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296898-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296898-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65AA9302EEDD
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F61367B87;
	Tue,  9 Jun 2026 04:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11E31E82A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 04:13:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978435; cv=none; b=OfyRFhsU+JylDhPDxeTzBBgLPoHob/srcJlas/NIeNHfR3xvPzD3Ck8HSsCHFIjOmTzrA5iiBzi4ktjNVe4DJRISXnF37uMYkGd88WpzrtuLeM7VoY/W7ZAI23VkaOJUsBC9YgH6O/4aSO0JxVOKFcmT0Mbax1RKccWqtbvY/k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978435; c=relaxed/simple;
	bh=OHmHVaNN8of74k4zeAW1gsmPbgJG2miCbc1s7/EQ7vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnQDApDpnDKqOJxN9skw2IJlD2dKQyjarO1/gl7tu/fKfk0stO3QM8RUk0oUYpqrr1BTqpzFGelhPqn9HwL8j+WtORvphwdMDdFr02wRRjd3GFCV8d64FhTVXXB/cR577kSuSVUw0QtytX7vyZeIEkk28hAGzHfFf9hNQNI+4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=DJEV4apZ; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2d8b95bso35703705ad.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 21:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780978434; x=1781583234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzxRGsc4ra98JUtynrlPbvStl7uBaKRYnsd3dQnGSwg=;
        b=DJEV4apZuYCW0mz9MO4FLrFZepCGc+OKDjv42/PhPKkltN8t2MIqmd5nd88tH1ts+y
         ridCrwCrkNxOyjQpzjNqA9XjwVdE126gO1watHbOLpml/t8B6aM8dK5LDJmVmTm289P7
         lwOS0tid1sJFWcM9J9ebTepReBCbVvYbrtFt7oUXyZFbY7OuE24LwZD5vNoTae7puLyK
         PN6dqNZl4VkrApDW/Fs6zlLFoaSzb8tZn7yyVWmJv1L8NWoTvh2njzqtH1k/G3ndKpK/
         gS4IT6Jj0n43P0SMPLz2Y3ZG4xorp7kKTqVfpXVa4QwU5I2b5EwPUeuMvi3HJHczqxmp
         Bw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780978434; x=1781583234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CzxRGsc4ra98JUtynrlPbvStl7uBaKRYnsd3dQnGSwg=;
        b=lrJHWnftLZNREu6lrIBPaaYYoL8MlYrwGeKZ+8WJMqhP+P1YxhMO/B+FsqDK/3Uyze
         aUmXDIRrVt251lvuR2I6wCrjZJPdqr11DWzL8L2hIps2dKp3YQNgEVJNROLRfyi1Mmkf
         yN/DSQZv5YbAg0SQQ2oCI5sve+oSr6XMY7TMxKFfDD8WH56Sv7ADSwTdvBge9iN5Ekie
         J1jnDQqeSY12lonA5RrY9cChAnJyOLmAPhhojResBULIsTDmY+BfooTsxQSSND7/Xjt4
         D/RGw+UJcoywegAw2TroBgXfIjk4G7hXrRCrpbvSLsSvl67O23wRmcSwjj6gY0mZL9hK
         6GRg==
X-Gm-Message-State: AOJu0YwD7LN1tzVVxHI1P2znMWjhEygRB0QDEbSeBex7dM5yXJ17NSZR
	vX5P17jNr/0O27R2ky1bm06mKrCulbRfWtXzcJbI3YpgYIQY7GKYVHzYAPq8W0XXviNbt+YLbev
	YkZscgHmQ
X-Gm-Gg: Acq92OHlUz0dVno7fBk/MS0bPwP5pvVNVx/mvP9avPHSG+xh1QYKRustXEalwe85UoR
	iMTYmGcOyHw6cO6dbp6XZMqg0wObLd6kGFv8GQOxPkUgHpWLYB6J65Mkxk+Xyzvo58FNYhmPtpd
	8Y9Ms/Pavsv7eBLCDz89GxBpV04iY22x+CQGnUuDZt2wGVSg8lvl2+HyaUCHveIwZJv/WurtDwt
	nlGJZ3LuMXSm6Rgm7zvMEuEDicDZd9WalUiUFBq7szbwhZVPzh5ftf7MGz7rukw/0QwxCOTnPU+
	ZsI2K6xGUmBwRdfCZUTywwuFxj3X5Qq6ZGX+Hgd12+hJNA6XGz0fu8vn23PKrZKtXhGr/fZCAka
	MaqqigNLgjYx/sKCYZ7dSKOgs2vijerIipf+Ip3NUuyamJjX2t9ekwkjkfIS/tBWfAlW/hAo09e
	q0AmqsJD4p4hiEIno=
X-Received: by 2002:a17:903:1aef:b0:2c2:7e17:39f6 with SMTP id d9443c01a7336-2c27e173ecfmr73528125ad.36.1780978434147;
        Mon, 08 Jun 2026 21:13:54 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm197126035ad.20.2026.06.08.21.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:13:53 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Weiming Shi <bestswngs@gmail.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 2/2] geneve: validate inner network offset in geneve_gro_complete()
Date: Mon,  8 Jun 2026 21:13:33 -0700
Message-ID: <20260609041334.2506153-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609041334.2506153-1-xmei5@asu.edu>
References: <20260609041334.2506153-1-xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,lunn.ch,davemloft.net,gmail.com,openai.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296898-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:bestswngs@gmail.com,m:kylebot@openai.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:dkim,asu.edu:email,asu.edu:mid,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B932A65C2D1

Even with both paths gated on gs->gro_hint, geneve_gro_complete()
re-derives the inner dispatch type and length from the packet and the
current gs->gro_hint, independently of geneve_gro_receive(). The two can
disagree if gs->gro_hint flips under a concurrent geneve_quiesce()/
geneve_unquiesce() (sk_user_data is NULL across a synchronize_net()), or if
the re-read option bytes differ from the ones receive parsed.

geneve_gro_receive() already records the inner network header position in
NAPI_GRO_CB()->inner_network_offset. Have geneve_gro_complete() check the
offset it is about to dispatch at against that value, adding ETH_HLEN in
the ETH_P_TEB case where eth_gro_complete() steps over the inner MAC
header, and bail out on mismatch instead of trusting the re-derivation.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Assisted-by: Claude:claude-opus-4-8
Tested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Add patch for race condition found by Sashiko

 drivers/net/geneve.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index d0dc5d6c46df..028740e97740 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -956,6 +956,19 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	type = gh->proto_type;
 	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
 
+	/* Bail out if our inner network offset disagrees with gro_receive().
+	 * ETH_P_TEB adds ETH_HLEN for the inner MAC header.
+	 */
+	if (skb->encapsulation) {
+		unsigned int inner_nh = nhoff + gh_len;
+
+		if (type == htons(ETH_P_TEB))
+			inner_nh += ETH_HLEN;
+
+		if (unlikely(inner_nh != NAPI_GRO_CB(skb)->inner_network_offset))
+			return -EINVAL;
+	}
+
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
 		return eth_gro_complete(skb, nhoff + gh_len);
-- 
2.43.0


