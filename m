Return-Path: <netdev+bounces-306228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j0aRAKqfT2rzlAIAu9opvQ
	(envelope-from <netdev+bounces-306228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:18:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABCA7317BD
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:18:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=l9Q8teU+;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306228-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306228-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC0030D3C67
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C84275AF5;
	Thu,  9 Jul 2026 13:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E5273D8F
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:12:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602773; cv=none; b=duYhMBip7S71iDULCIsoyy4SEPnFitDmvzEUIHra7g2m/u/oIdafb3uYhE9p1MoEFtsppGWZJCM0RXfy/3DtMekld5J3r3AZ3bSLzBO2+bHjwLiDPQp15zyFfD5P0vDcBlNiqLbnq+5IPt11dPMXeRbMbHKORDv0pNfBnZwTO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602773; c=relaxed/simple;
	bh=eXV85UOU1zgi6P7JVWPpQKScckIM/nj9u0XFq3b/aw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ix4fFq/AFmMrYzmpFLWeMt7C6KhFPSR7NdYBggdJYat9Bd6czdqkamqwHiToxkZgFl8/06pHTtOkfM1OkR0Ss0Zcf0mWFio5/69fnHLW16nShZc9F6bTmR4+lMTU1BFzHkA+oR2/ILAdbXhT1Gu3Xv6bzX+g9zbJ+QUmBoKchNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=l9Q8teU+; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4629051c9d1so1043784f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783602770; x=1784207570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+okqiPy692T/LbXtU2xfepsNS8cELhNO3bJ/OMjed78=;
        b=l9Q8teU+3ECZbFPdCVmRdNVCRddRzcmdJsUavDS6pylE+0jI6TAUd28Ugd5B8uh4e7
         XlpZe+oauY+WqhhnWHe/3Hv/AHUSVYyyVazzBaA2E5V9LZLdirBcK4xIrDtPavAJPJer
         19mf/2S42of0sq9AcsD0YfPVseRBFp+Lx8ijoFbr+9P74h96dmW8EHZPJ447/s9lHo2e
         zkBeSs4qybOIuhDZSus1bYzRz+0eVd+fYFD/LpUgZnaoHZ2oDCTEvbDbq5oKvMAapESy
         AkHJs4CBZZMqHRqL3d7fKDMKUzzs09JPrK/e9Ln9i6lRoDYvb0BnsM5MKfZRsI4B6SZf
         oKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602770; x=1784207570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+okqiPy692T/LbXtU2xfepsNS8cELhNO3bJ/OMjed78=;
        b=HSSfbjQmykiC+NAOXFvJqwnMDFqSqFTUtBAgm7Hm+BhMQiMYDUCwxMx0ljZieTXHv3
         itd06hXmnXBtzU+xkR/UKnx6dpt9Yq0ZQZd5DbNsDYh5IKHSIZa2HvQ0A7ahaGRYuhZX
         sapXbkXbTC+JXAw6z1Ei4Qc9VL8KU08uZC7PhX0R0zTxWktjxhUmWdJNylVmFcjVm7yW
         ffu1NMmN3WqyGWGR7bA5iwe4FF3HlUCxh7eW8gVxOQdbjwyF0zyGnIRCDyuxN8t5YC66
         YpQ+Lq5/5nRzCM5rF21RfSTUkEPINrw1rG4f1hZnP0xYnXUEFrf1syTZC7q6HYdKPs9K
         30GA==
X-Forwarded-Encrypted: i=1; AHgh+RrtBcMNZt+uT5AysL5xTmCHJqyc/giydFpWMQJ01EcVxSVEOjE9oH8ezlc3n9GlizoBfKV7OBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9/qWr6RfWFSValcFubXNw8LBN1x/4ISUC8Jon/TvPaw3VKKU
	UlB2ywignl9YoG+JMTYMKolua78F+sKnpOqCAKLQZkjxnOoMmWwsOiWRu7pmok6yAISn
X-Gm-Gg: AfdE7cln9OVLesR19ku/UY2L4Lkqjakc/Q4qSnxe3v7e7gZKJ/moLiIp0xDfm53SECa
	imFPnBEZdLvI9iRKzznT3VovVZdV44kW3hDW9PFBmzKrItaSxEK96Og2850dp8z4lDFrc0euJzZ
	8i7IebPtj7WuhNYIou2nwrEQ5sU1Nq/7JU/CmzsdkWClPWi4g+or/+zCJLE1W08R6ohrhZ0rxsy
	vmpFRpfJcrrllI3jyWA8En4+xnXRBOBYiEfgP0uarr8dvRfa13A+rRUq5KUglr3nFB3T2XUjMuN
	qosRH220xrq4vMT9//bRLmX7vIOkqX9BWB6h4V5aC4Cxq5XLTu38guYiUa5myPN16/v6ZuOqpY0
	exXLGSk8RWXmIAhEs167bOD1X14A4xvWc5weRbC9XkMsk+myZGDomXjFV7mHw8jypmdMC43GMLL
	XWTekEP6hw9rbXwE4DC5P5rcn9ltAeKakeNxi98jVeuYeyHKUYYxMzYQuye08FqKt+v9uKDopLv
	R5Ce330nNxqDvXinOMFiRfKhPTkcI112tY=
X-Received: by 2002:a05:6000:430e:b0:476:d13f:bb74 with SMTP id ffacd0b85a97d-47df07ae2e6mr7871263f8f.15.1783602769947;
        Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ad21sm50243405f8f.20.2026.07.09.06.12.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Jul 2026 06:12:49 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	phoebe.buckheister@itwm.fraunhofer.de,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net] mac802154: llsec: reject frames shorter than the authentication tag
Date: Thu,  9 Jul 2026 15:12:46 +0200
Message-ID: <20260709131246.44517-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306228-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:phoebe.buckheister@itwm.fraunhofer.de,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:doruk@0sec.ai,m:alexaring@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,datenfreihafen.org,bootlin.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,0sec.ai:from_mime,0sec.ai:email,0sec.ai:mid,0sec.ai:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ABCA7317BD

llsec_do_decrypt_auth() computes the associated-data length for the
AEAD request as

	assoclen += datalen - authlen;

where datalen is the number of bytes after the MAC header and authlen
(4, 8 or 16) is the length of the authentication tag. Nothing verifies
that the frame actually carries at least authlen payload bytes. A
secured frame whose payload is shorter than the tag makes
datalen - authlen negative; assoclen is then passed to
aead_request_set_ad() as an unsigned value close to 4 GiB, so
crypto_aead_decrypt() walks far off the end of the scatterlist that
only spans the real frame.

The frame is fully attacker-controlled and reaches this path from any
IEEE 802.15.4 peer in radio range. Reject frames whose payload is
shorter than the authentication tag before the subtraction.

Dynamically reproduced on a KASAN kernel as a general-protection-fault
in the AEAD scatterwalk, and the fix confirmed.

Fixes: 4c14a2fb5d14 ("mac802154: add llsec decryption method")
Cc: stable@vger.kernel.org
Reported-by: Doruk Tan Ozturk <doruk@0sec.ai>
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 net/mac802154/llsec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
index 5e7cc11fab3a..364a1ac1d771 100644
--- a/net/mac802154/llsec.c
+++ b/net/mac802154/llsec.c
@@ -893,6 +893,11 @@ llsec_do_decrypt_auth(struct sk_buff *skb, const struct mac802154_llsec *sec,
 
 	sg_init_one(&sg, skb_mac_header(skb), assoclen + datalen);
 
+	if (datalen < authlen) {
+		kfree_sensitive(req);
+		return -EBADMSG;
+	}
+
 	if (!(hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC)) {
 		assoclen += datalen - authlen;
 		datalen = authlen;
-- 
2.43.0


