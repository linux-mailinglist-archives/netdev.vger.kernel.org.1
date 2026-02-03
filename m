Return-Path: <netdev+bounces-256045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGzhA1FGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:50:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F932D3243
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB1EE3037461
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5810158535;
	Tue,  3 Feb 2026 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="KNR0bNBd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF6F21018A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079764; cv=none; b=bXp7/RCNggcaSkZh8yi2lLmeW8koikbz9QEbspYmr1QmP9Im7gXbfWdR2eGmArmYHjfzYefprXj59Hht7oJzm3gl1CwUIOSa4bp+l+87ZRCWuBH3FGXvTCfKLtGK+TSDqgrIHpctdJ0iFyDH0wXOwWx+BVqMuhWkXQJVuq7aa9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079764; c=relaxed/simple;
	bh=LictKtN9GG7sLvfSfk6Dgz3SIASGPr96BkR9IPFbEf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5th9VfohszQRl61YWsZrcO57spxbaRqq8E5z20g/jf/jgrJ9nxuXLbB4tBq7cWEHv0l4Woz4OL1zokSH5L3jtdTipY2uUOyc02YdOG+AQ9jotFAimSirayCNU8quxOkdewdkjzsg17HicSz34Dhyt1xkfXA6vKoibKxkpDZkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=KNR0bNBd; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b6b0500e06so7544807eec.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079762; x=1770684562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO9dtIfPX0OEQWN30wfDayGk9KZ9pgkzLunRDKexayE=;
        b=KNR0bNBdD6wc8nc43QngjdhLlG3vaHkgMJ4d2XyQX0ZIM/Ucl22NtyHxyeenfWv7xb
         /+FoAOj7yu1Bs3vAS+br3xXsnup2bwoxZB4FRdorMJkvL2+ONtzwgdTQ04Fc3deu4CN+
         z3fCmzQ2b+ucMrnlf5eZzRIBj2tgq8+r4cDfQ/CD9dhy8+YyTeSVRBKhSULFBPqS/DLr
         TMBpBJB/ccxhMm6caffxB9L3lMtakUXSfMX23m0ghSvUrXH9qSa0Rdn2ptzxeXjsAxow
         u+mgnsOmVFo/pp02K8GDFUPGA0gyR85yYHo3Rk5JFXw8HAJl96uiT8iTksFWtNu85EL8
         PM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079762; x=1770684562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VO9dtIfPX0OEQWN30wfDayGk9KZ9pgkzLunRDKexayE=;
        b=Ds7ijXg1NKJ1X49rxfsn0mlziT8rn+g0AwmDwzGfi/Z/DS/OzO0V1q1DJHlVPlCX/T
         u9kouUi7xCqd48PY8/wr55foJqRjs/kHH9pWublfGLqMjhQp8gO0kLud1Fo4bcGujSIs
         SOKoamRkqMEAmXV/78wjkROKfGs0tLvGoBP+oE8UgMMy5igwTFx5JTlQzOEUw0ob8+BD
         oUSJNfDXq2FIyOw7EpJK+2S6ydhZTdhELCazHMwDs7wDArYIMxXjEhngRK++EjPEefBV
         wzKqy1sWA+ZAaQhdVA5ajpWS/pUkJKFTHcDrfNsTA88jg0il0OZEFvusp9kwYb+JamGW
         9gjQ==
X-Forwarded-Encrypted: i=1; AJvYcCViPaMex2MBWdmR0Qda2iNOj3VifBaP+mm+T8DXYXnJTYTYf6/rkW6GnvwMONpiz1Kdl4kbS3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdV0bPBTTgDf0ZgpSRZPImYM45E4uIJ5S4kcf/oOKcV6U6yzU
	8OoKgCGiz4wVU54bLnLKVrYCQiJAYeJO8J5QJdK9NoEpsIaLXGaPv3lZndNwjCwYVg==
X-Gm-Gg: AZuq6aJMV+yAlLXvhyq+hTG3C+EOnXsgWIiCz7U7ZUOM5TjmNzmu2KbJzUlHYXqG+h1
	q7pa6YZD+vF66dEdDDqjvQM1jheujB7s2xCxFbA8ODQWtA2qFvYtzo/jMsGNU5jT1dZ1u52GPv2
	Ux6aYa+eKbjL3b09aoVWxlFgo0p2+NXwJwCP+2AGPKBDKmEg2fX2dEo1t/b3bDsVOsrgyeFzJOj
	WIWC/XgTtw1hQ98ib1kNahT9PlJqqbko3a4+B/rfO3rnzBmMXHmG9TfOXU/eh4j0ApJ8Dl6E+RA
	R5KVXw0g/exy7tVSr2rG40QgsRT9sOuFkmVuMrMzlTQryrUP1uHGxLdRc5NXJdkALFEmLbYOIF2
	+gADFYJAwWZNFzXw+0oAIuQsQyqNce+H1Mm+cI0/XUJl5ewhuPPK24Zs850Bk8ZTx25cktth+Pk
	HmoDxX0TEbvbfziosNmeZe5Cs/1D1/l4CnJXqCU0/QKSzgRyKkW6SFwnJe
X-Received: by 2002:a05:7301:5f8c:b0:2ae:5db9:f32c with SMTP id 5a478bee46e88-2b7c88d96d3mr5439465eec.26.1770079762437;
        Mon, 02 Feb 2026 16:49:22 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:22 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v6 03/10] ipv6: Add case for IPV6_TLV_TNL_ENCAP_LIMIT in EH TLV switch
Date: Mon,  2 Feb 2026 16:48:46 -0800
Message-ID: <20260203004853.94438-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TAGGED_FROM(0.00)[bounces-256045-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F932D3243
X-Rspamd-Action: no action

IPV6_TLV_TNL_ENCAP_LIMIT is a recognized Destination option that is
processed in ip_tunnel.c. Add a case for it in the switch in
ip6_parse_tlv so that it is recognized as a known option.

Also remove the unlikely around the check for max_count < 0 since the
default limits for HBH and Destination options can be less than zero.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv6/exthdrs.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index f7f7bcf9395a..85f1b65d4c98 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -122,7 +122,7 @@ static bool ip6_parse_tlv(bool hopbyhop,
 	int tlv_count = 0;
 	int padlen = 0;
 
-	if (unlikely(max_count < 0)) {
+	if (max_count < 0) {
 		disallow_unknowns = true;
 		max_count = -max_count;
 	}
@@ -202,6 +202,16 @@ static bool ip6_parse_tlv(bool hopbyhop,
 					if (!ipv6_dest_hao(skb, off))
 						return false;
 					break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6_TUNNEL)
+				case IPV6_TLV_TNL_ENCAP_LIMIT:
+					/* The tunnel encapsulation option.
+					 * This is handled in ip6_tunnel.c so
+					 * we don't need to do anything here
+					 * except to accept it as a recognized
+					 * option
+					 */
+					break;
 #endif
 				default:
 					if (!ip6_tlvopt_unknown(skb, off,
-- 
2.43.0


