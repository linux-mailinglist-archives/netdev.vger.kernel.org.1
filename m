Return-Path: <netdev+bounces-304730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ish2DDZ1SWry1wAAu9opvQ
	(envelope-from <netdev+bounces-304730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 23:03:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA4708747
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 23:03:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=JBdBfezm;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304730-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304730-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59897301600C
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA862EEE86;
	Sat,  4 Jul 2026 21:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0065256C61
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 21:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783199025; cv=none; b=hAleWBue3BS2InZEHUE/CU8ZaaPA0UPp7jjR0Ivw9E2yJ/h05wwQzUlfZkZP94NTnbAINNylv3DwGY8Jfy4YFSFg7ADm5wUHiwK5HTfaySvpYm9r1pkg187F1sWoJ5ZsQocUI3hDspdB/XgcfZdq8JBBVAI7agU0xDnsHGQo40o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783199025; c=relaxed/simple;
	bh=Zq+aEiBYOn6XG89RkoyTuyqhoJBIJx1CBVugjtgu9EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/tn5B7VdZ679ZlxlEmx77iuGWSfsxTJzqmU2adtSMznYAXiXzcHG2drz+uMeiX+pbJQaPg1keTdkTIkjIxxpMPJU7lJtEy4GA7bb+YHXb8i6vLHRNS74GdKbTNAAgPjdM6nelrQMdxEUsrFqSNZPNPoq2FUOO8t7MAPq0bUtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=JBdBfezm; arc=none smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9d265355so1253117a91.2
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783199023; x=1783803823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gv2DdE+Lssq/TmAkJXz6GkLZXUdIb0D28gXFqfx1VEA=;
        b=JBdBfezmQxSO84TBoNRK3ccurPCdf3s1bO5fcz97aqTeITobBP+U6RpIvRQEICOnfL
         I3MIPwZYb4Wn1uwXYS2inlc2whkOq+LKdE4LlvNSc2eZPBrbeaNm5j7YDBo3yFPI98sb
         8cwbBkOR1DDTeKSrs2I7bJta2nq1Z8ui8tYddX8FYtPI3VF8FoyfJd3H2B1sq++97XmE
         O2GlT4IkhmV9t5qPnFNfmgtvLQCn2ewukoOw4e89gTUsmQbZ/8dR59YbyGO/YQR/abKV
         vURjqInHAdi2e+HHqON41YHYIgck7AxP82LlqvX8AlW4KJdcLHYquZT8zVV7B6C3vOpm
         UsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783199023; x=1783803823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gv2DdE+Lssq/TmAkJXz6GkLZXUdIb0D28gXFqfx1VEA=;
        b=iHd6nt/TwKJpbQG8PrMhsUYL1qfaKIEPBlsRivw4jYg02yR4mvUkRdKO/pq0x9YYeW
         jG8w/7KHGPwU6mAPE0oCm+wIWvACU3TKvLYaLXvu3317A87PPi+WO2TN9wBc2Q+W8Fyr
         A4OGrTth5YI7Ao02V5ASXn64Ppmcn8tBuo6ck/Pke/AyI1Y7+skgZzoL8AQWT1QqFp0j
         8iikivWXNI7+dYqUvjkeF4ZjuiMHOaWfDdPZgTig0bxOmfll46OGJRnmSk+zdTY9+Ne9
         VwYkec98nDCD8CcEtwigAbuKa+fCje2fyRuBPNATAbogPzVgUc930khmVgX4tchCQDkv
         ixPw==
X-Forwarded-Encrypted: i=1; AHgh+RpLMb6BqXbk5f9GXKjUUQL5l1L3kyyWTjjqZsyz2ACghVzHNeKgJ+99WzqWsGf6RrAOXLUBjwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGdW/hPvZYtFYqx/Rwi1MIXy8J+WRI8xtrN0tqW0mDhkzoetb
	8QDQLJCgassxbCSjSTo62n8sNx/Pw0KZn9D04SbFr/28G6u6xwRHYH4BBg0EVTIrTA==
X-Gm-Gg: AfdE7ckG/InDTWP+GyAdMh/CZDkmBrr5JoJ9Z8IhN2BI12cDSdMYrpOQ/S3aG6bU/AM
	/JtgNP09GqpgeAEWHWP9KJ779p+rY0b0REfFMZr+i1XPZFIdd8qm0P5xLq/RmsJNB7OMdJy5kV3
	MAd8i+p2kvc/KSFcjd2Y6WYuNn9GA+v8mf3vWLZ/0ONxcQ+d0fTMckVLgwaHd1U9LA1v54xumly
	yBEp7bd7GkRHKm7VoJdOSBpEKVlbCOIKNw7PslRwePnr64FyaE9V7L62FL6CdvV0XfrD3ubK2Uv
	KHcj/xnmSbgXyL7db80+xARTLvFeJ1ArbjGe79xTgEHcbG2ntcFQTqY5qXSh59mgCdMdv/X4oF6
	MCJpPG0HkC0/1ov0E1lQxtHIWboNNk751pqFSSqW+tlZCOqDTgzF2uWnPExyM1KTyd55I3jVn9g
	==
X-Received: by 2002:a17:90a:d00b:b0:381:28e0:6259 with SMTP id 98e67ed59e1d1-382808ae0aamr4093833a91.9.1783199023182;
        Sat, 04 Jul 2026 14:03:43 -0700 (PDT)
Received: from p1.. ([2607:fb90:ec0d:16c8:c948:ea89:4ac4:979c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3812baf131esm1735745a91.0.2026.07.04.14.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 14:03:42 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: nakam@linux-ipv6.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH ipsec] xfrm6: fix out-of-bounds write in xfrm6_input_addr() when secpath is full
Date: Sat,  4 Jul 2026 14:03:32 -0700
Message-ID: <20260704210333.668216-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304730-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-ipv6.org,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:nakam@linux-ipv6.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ECA4708747

The depth check in xfrm6_input_addr() is off by one:

  if (1 + sp->len == XFRM_MAX_DEPTH)
          goto drop;
  ...
  sp->xvec[sp->len++] = x;

xfrm_input() can leave sp->len == XFRM_MAX_DEPTH, and the transport-mode
receive path re-enters IPv6 input via xfrm_trans_reinject() with that
secpath preserved. If the inner packet carries a destination-options HAO
option or a type-2 routing header, xfrm6_input_addr() is called with
sp->len == XFRM_MAX_DEPTH; the check (1 + 6 == 6) is false, so
sp->xvec[sp->len++] writes one slot past the 6-element xvec[]. The write
stays within the sec_path allocation (invisible to KASAN); UBSAN_BOUNDS
flags it and panics under panic_on_warn.

Use "sp->len >= XFRM_MAX_DEPTH", matching xfrm_input(). This also
restores one chain level the old check rejected at sp->len == 5.

  UBSAN: array-index-out-of-bounds in net/ipv6/xfrm6_input.c:309:10
  index 6 is out of range for type 'xfrm_state *[6]'

Fixes: 9473e1f631de ("[XFRM] MIPv6: Fix to input RO state correctly.")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 net/ipv6/xfrm6_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 89d0443b5307..07edef258984 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -247,7 +247,7 @@ int xfrm6_input_addr(struct sk_buff *skb, xfrm_address_t *daddr,
 		goto drop;
 	}
 
-	if (1 + sp->len == XFRM_MAX_DEPTH) {
+	if (sp->len >= XFRM_MAX_DEPTH) {
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
 		goto drop;
 	}
-- 
2.43.0


