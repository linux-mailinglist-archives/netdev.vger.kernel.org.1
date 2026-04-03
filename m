Return-Path: <netdev+bounces-274871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKl1N/pCz2k3ugYAu9opvQ
	(envelope-from <netdev+bounces-274871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 29465390E7E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 06:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7D24301AAB1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 04:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED62D0603;
	Fri,  3 Apr 2026 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6kAJo54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4B20A5F3
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775190763; cv=none; b=NVLbM0J1BO3am9RnDAbDkT7d78cr/cW9fIiDCqVfO1U38scmD6P8X7LcgxMJ1LXBxopEfyK8ccGbcPG7cYQToPVhWKgygtA6Huvjg4mexaNZMOcd57JcCXeW4QHqDyxCiSDTwEB9hkZt8pc7hSgsybFGVQb7YSnwDhRlXj7D8CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775190763; c=relaxed/simple;
	bh=5YVX3ivlCSAhBCAVuCWzWfR+2p/zlWJ3n2GK84DvKGk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8dzcdkhy+cCR13Im6xPb3+Nz/+MAadvdWHcTlpyD9FYXEEqxSIMcdokv3wb5UqOOhfeBIRMbg4WhEBKBmZFSz1lhGdJiJL5rmN0xIU0HAA06tviWL9W47nlkaX1rh/cRkncIazU1tcZwZ4O/Y0sepa3Z85Wb/OwKG6tkIJ9/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z6kAJo54; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b781542c1so31308251cf.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 21:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775190761; x=1775795561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEhlwyFqFTE3rGV5lsJ+IiUGMkxDGZa6L73MyOBa0RY=;
        b=Z6kAJo54jFllQBEolVTyq3NmvThu8W4d4paRJTeiC6WEzIZdMtoSBE71gVod34+x3Y
         bKzpIZTzIshQ46A8KdHE+czWpnDs7JZFCCqC3UvolRvKk10TIG1qnP0cxTdpeAwv//kK
         sRq7o+XkS7EqemgDeFUx9vrd0Gqjx7WXVdSkenn0PZQTf8MHNDhx+Nmc8ssylcd2xu8T
         i3G2EeV45MZZ9ii2bupgqQwftspyz8HAObqaDVchiJYvnEOKsbs3PffsotN2UaayfzfG
         CrM6+0viDGdfcKScMBWEwH7wJzDHe5PPJP7jR/ZliIvKAVz874GILp7KGHD1UWjjxlT2
         Evvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775190761; x=1775795561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEhlwyFqFTE3rGV5lsJ+IiUGMkxDGZa6L73MyOBa0RY=;
        b=kYSS/FrDqndjVGAqoDpKma2y9UPzWJ0HcRl341kjFZBwY8mqwdV5MjF8CaI/YME8jS
         c1NLcCerObpxYfHEH/E+8WrMFjHld2TnvHTGF2ZEewo2r87FcT1AqfzHDZYtZiCvIE8F
         qb63vCSCmVjQiKH3qc/aI4zNoR2tsM/+y966QIrwAJNbzqbFVDnS1nyPnHkBwPVvw7WK
         Q9mNNR7EMnbhz1biVxw8/gyifYGXt+m8HCO/S5N7BpzfsjAaflKEsFHaw8leOrT8VVWn
         2+v2qNUO+ehIcCCSXh+zct8Ylj1L8nuuuYLpoG/zkM03hhh7ACTQ9XKeeTNQ4vdLyayE
         Sxjw==
X-Forwarded-Encrypted: i=1; AJvYcCVf/Qy5o2mUPTabfg2ceZDgW59PMjgbZiPSUtVzvA1Tz+rIrGQFhS+rFjHq5lvF5xdrdKk0F/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmGwQE+n4Pe5jELFEi0VkwlWxW41SCxweY+4t+2lavHUCP3Fvj
	CmODxDKZWKwlwBSdckm/WmdSVTDGYUElokMpFM4bP3+ralpt4yLYBfK7bCj2xW9Jn/9OttZyYfD
	lSe0/8SsrSuLIuw==
X-Received: from qtoz25.prod.google.com ([2002:ac8:7119:0:b0:509:ce6:7b71])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7fca:0:b0:509:1f95:f3b6 with SMTP id d75a77b69052e-50d625120afmr26420441cf.2.1775190760547;
 Thu, 02 Apr 2026 21:32:40 -0700 (PDT)
Date: Fri,  3 Apr 2026 04:32:29 +0000
In-Reply-To: <20260403043237.3909226-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403043237.3909226-2-edumazet@google.com>
Subject: [PATCH net-next 1/9] net: tso: add tso_features_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29465390E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

net/core/tso.c users expecting headers size is smaller
than TSO_HEADER_SIZE must fallback to GSO when headers
are too big.

Provide tso_features_check() for drivers .ndo_features_check().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tso.h | 11 +++++++++++
 net/core/tso.c    | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/tso.h b/include/net/tso.h
index e7e157ae0526c8d655aca67a8a49191ec870746b..9be7cb6553975a2a82e0987214fee6883bf74404 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -28,4 +28,15 @@ void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
 void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int size);
 int tso_start(struct sk_buff *skb, struct tso_t *tso);
 
+static inline int tso_compute_hdr_len(const struct sk_buff *skb)
+{
+	int tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
+	int hdr_len = skb_transport_offset(skb) + tlen;
+
+	return hdr_len;
+}
+
+netdev_features_t tso_features_check(struct sk_buff *skb,
+				     struct net_device *dev,
+				     netdev_features_t features);
 #endif	/* _TSO_H */
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e9842f3de7bb3e34599d8ff4e4fd4..81e2cc66d0dd29eeb647232e04032b1412382a6f 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -87,3 +87,15 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
 	return hdr_len;
 }
 EXPORT_SYMBOL(tso_start);
+
+netdev_features_t tso_features_check(struct sk_buff *skb,
+				     struct net_device *dev,
+				     netdev_features_t features)
+{
+	if (skb_is_gso(skb)) {
+		if (tso_compute_hdr_len(skb) > TSO_HEADER_SIZE)
+			features &= ~NETIF_F_GSO_MASK;
+	}
+	return features;
+}
+EXPORT_SYMBOL(tso_features_check);
-- 
2.53.0.1213.gd9a14994de-goog


