Return-Path: <netdev+bounces-282675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC9EC4H/8mkvwgEAu9opvQ
	(envelope-from <netdev+bounces-282675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:06:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA449E63A
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2AA63015D0B
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3273396B7F;
	Thu, 30 Apr 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="erR5acDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72163396593
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532775; cv=none; b=iODduSAl/tPDv6J7O78/8vMoZ0el5QoVSM6t6DOEyLzddt42guZQk2mue9riSiB+DIFt6SSMGJRDFMeBtJDNO7AKaCSZ5pM4iwF54ce0pExxIVHtwJBvifmpWCmNV1UchCcfdzrBROMu/7VpDlre/4TOxPlNQOiewCQ3mghpTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532775; c=relaxed/simple;
	bh=MlWBYtPRt6aJZyTinMGdRY0mwjEGCsSDIfB+4snf3iM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y7tr359sr2RaBNvPdvY0pO1ABFMk+eeeZcmIGVJ4J2vV5FfUKnzHXN9ic4CdfxI8w0T2PIcYtS4brC6HaT7b3gea1PcrKRjot0XKwp9Hueg36lXXvte3aeBYskwYO+bHMQm6nr/M58pl7ZOavP5fqYo1Afhd1j9EgHAYzBRXlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=erR5acDQ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50fba8d8c40so12219691cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 00:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777532773; x=1778137573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ZrJASGNRErK/O4ZE+4RJN+zI0UpB/rpLurWI28Q2Bc=;
        b=erR5acDQu8dfZMqVoKRyRXSc/HeR91n6vC8vbV19U+Xy7pU91XvpUV2KaZ+/pWDTLh
         xmWKxOJxTz1DI4cO4SLd9vV5rflug2jJ4noiETIWXjt4aMs0ay4tBAmPEoAmf/CHorhK
         mwInrGqzG0KD9rBp684rAktWBWMh7kpk9P14iLonskE8Ttsu9JK09qKagG0+mHt8thDq
         GLTnXAdjhws7nIzmJMLUJv3uKWPmoDYo/xgH7lIGY6MWkJWTGA2u91a3deO3+VrnXuWL
         Gg7QAyCv0pmkBohOFiy96hIFoYiX1kU6CPRX2LmWldBQVihBt5sT/YbO4cJgsMDzUK+o
         UJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777532773; x=1778137573;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZrJASGNRErK/O4ZE+4RJN+zI0UpB/rpLurWI28Q2Bc=;
        b=jYPUa/v3GYFMQL5LMPSGGKMDb2UlVyZYsV0x49nwIe3ZLepB8WJmsieWT3OhmxfDro
         rM+WKETWpGXsIUKPR/KW1EiDX9z3i84Gztv/yomjsvgCrzLxpq/oI9HlFcMrwfIjSy8J
         9JBKxZgWTpg3FiRtm/bsU3JmVdFVs1nz+DBoBHcR52azzNgFpV/LA4XoRPXmOn3JSN16
         +lnBpEDqhDku0ZQg8wBLVfeH+gfxB17UeEKADqNuoWFJusqx5cxZM/GJXh5f2IC2iKuH
         0itpmRhb5PZOxJh1CDAvyp5sIwSWk6s1WpCNXAvfx8gDPKXTakr/fkIUQeOUDv8KGiUQ
         mvBQ==
X-Forwarded-Encrypted: i=1; AFNElJ/q01dwjVlNS7TZDFQ6DkdMGxBKsoMdrduXt3Tc4gFw56syIDw02gyuQmcShdVSukBqLbOse68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpDIvSeu1svoCZbQeXzivkYPY4jVqFhTMtWNBf0OkhQURj6ROl
	tITRmsO+/YiF/bUWPBtHbMPTKCa9kRrPVAhQskdvpmTGSfDJgPf422U5qYsn9vRuV7OsxusmSM0
	R0PlBc1JhnV3jLg==
X-Received: from qtpr16.prod.google.com ([2002:ac8:67d0:0:b0:50f:9c36:1323])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a0c:0:b0:50d:d1ea:65dd with SMTP id d75a77b69052e-5102ab5ce91mr25442661cf.14.1777532773093;
 Thu, 30 Apr 2026 00:06:13 -0700 (PDT)
Date: Thu, 30 Apr 2026 07:06:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430070611.4004529-1-edumazet@google.com>
Subject: [PATCH net] ipmr: prevent info-leak in pmr_cache_report()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yiming Qian <yimingqian591@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7BAA449E63A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282675-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Yiming Qian reported:

<quote>
 ipmr_cache_report()` allocates a report skb with `alloc_skb(128,
 GFP_ATOMIC)` and appends a `struct igmphdr` using `skb_put()`. In the
 non-`IGMPMSG_WHOLEPKT` path it initializes only:

 - `igmp->type`
 - `igmp->code`

 but does not initialize:

 - `igmp->csum`
 - `igmp->group`

 Later, `igmpmsg_netlink_event()` copies the bytes after `sizeof(struct
 igmpmsg)` into the `IPMRA_CREPORT_PKT` netlink attribute and emits
 `RTM_NEWCACHEREPORT` on `RTNLGRP_IPV4_MROUTE_R`.

 As a result, 6 bytes of stale heap data from the skb head are
 disclosed to userspace.
</quote>

Let's use skb_put_zero() instead of skb_put() to fix this bug.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ipmr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 2058ca860294b01385063555d0354b7a9a736118..05fb6eefe0beb3c45c7ec485692460b84cb332c4 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1112,11 +1112,12 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg->im_vif_hi = vifi >> 8;
 		ipv4_pktinfo_prepare(mroute_sk, pkt, false);
 		memcpy(skb->cb, pkt->cb, sizeof(skb->cb));
-		/* Add our header */
-		igmp = skb_put(skb, sizeof(struct igmphdr));
+		/* Add our header.
+		 * Note that code, csum and group fields are cleared.
+		 */
+		igmp = skb_put_zero(skb, sizeof(struct igmphdr));
 		igmp->type = assert;
 		msg->im_msgtype = assert;
-		igmp->code = 0;
 		ip_hdr(skb)->tot_len = htons(skb->len);	/* Fix the length */
 		skb->transport_header = skb->network_header;
 	}
-- 
2.54.0.545.g6539524ca2-goog


