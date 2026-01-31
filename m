Return-Path: <netdev+bounces-255322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OGgAvhmfWknSAIAu9opvQ
	(envelope-from <netdev+bounces-255322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:20:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EEC0429
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 03:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB408304B4F9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891833066F;
	Sat, 31 Jan 2026 02:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU+82ULc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD730F808
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 02:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769825955; cv=none; b=I6QEmUhIcKK9d3ORRIBo3fJAwja2dc2H1PzRTklAiaYo39yXXteu1+oQbIBl7VhIv1fJaae6mLPO9SDK+o16Gd8/CARpe5ygNCr6Ck2dKZNkN24kBsfWEndVBdTx2z/sgvdFbGieDqPAezaxCqLxZUxs7oWE2AInDC9jXzCw5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769825955; c=relaxed/simple;
	bh=weypf9fnJ2Qr538zMjCgLUq0YO0hY7tVVy+hNPngXU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2aa/xTXpxvGVBkMNU6AGRhdQaDBMaWil2gaT82lvpjrbyA1LBLmJeP7amqZdvqEkNvgbL44PPqTlQLEgo3eqBVmdJZITQ4c4JwTklbN7GAPNe5RgsDApd6aYdOOvfZxrCzhk4ILZRMR1iaYSqWxULk+S4sGFGc9Emgl6/n8tcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU+82ULc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a7d98c1879so17059015ad.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769825953; x=1770430753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX9NGtQjvL+utqKEIIzvFMcAbIwZFqtQGtspyA4XdaA=;
        b=YU+82ULcFEBxrNkYeb6WlHyw4XaLn8LT3kGUGoqwmMVHQnDIri/4yHetuOL7avUz6o
         UXdRDqOuZhcUN7gVYCBvKjDaFwkzN7/fnv8KlW0tOu9M33JrzK4EOWiBTA88hF5Fy4Dc
         Ui03OlNoKj80HlXYipfaF/Dazp9g0cbQ/bCb4HWHHuLROnMV0kbaXfemIxXL1f8JGZ5a
         LzVcLkmOVAhTXbS6DfYo+F4VmxYy5o72D/rcT8rFOjt0eZ8knRkclXmp8FgHrDK6cnRM
         5ncHKU2tEJdb9hhcdjTBMyYYADcu6Rum7j1w/Lm400dH6zTPJI60nJNyaJUV1gshVBuI
         929g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769825953; x=1770430753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TX9NGtQjvL+utqKEIIzvFMcAbIwZFqtQGtspyA4XdaA=;
        b=hZeIJRpWCfx8rPdnCty41OUBxVw25JiF9sCgKDWXbSdH3I1JaJtOV/QVOJrqMsjvxc
         HixK6pi2ho7sEfPKYfp+/DO/THpELw3HVlWG2Qb9KbsCrPIsuMLKIIIuutJ0GBpLNGTf
         0lCWlyH49fseADbJAoKVR9AbAdP3cuFfhNHCsyLsK3THOFuZ1Cy2S09qAWDHlJSq5JSP
         atqTJOzoU8BAfwKWDjNjEWj6Ix8ddMnQZgEQtGxz/kwl3sCpazYKmUZDQZdghYdT4t8Y
         G+XpmTV8RtIdmWi8Ax4Po8rl57gnd/J4toJRqL6n5NNcwF4olGHhlqfAAFCZkoWp+yva
         EapA==
X-Gm-Message-State: AOJu0Yzgmav1u9FpKiitPoy3oXqc81lWSeP3oZyO2Qv55jKaot3U320+
	bstJCQTaUIppiOZN/cGKzkk9R+v7din2GgNfF7MVQqXlPp5p4/9oF814D7Aztg==
X-Gm-Gg: AZuq6aKRI0cf1nDsh9JZmRSpjGvxWo39xdjBCTA0ZJT+v3Kk6RNdJYPLsUZEuIQvCy/
	C4izLEOzBezIIdpIWkwRLtnBaX+bUq40e5EZyBBHMt23YuhWWy4OcXqrmLmJ+GEsDLEfTw5Z5y1
	NOLmi5L4uGOpGHax+/cQeYIsWYxZ41K3evh7QjYmfqquunF7nj/arXSbBht3NhRNaQnjTVKcTba
	402EalqltYzwVBgDV5kGggZaHZ/lD/tt+WKsdCvBQoYSE7RJ0rcoAZCuDl55DTFF2W2wNHlZN6k
	sKd6JGZ/LhF6iauEmHT8y/klQvKgWQ/WZOqjxYpdLjWB/atqOwZrrTcYHgHSblUcAdLKm//y9sp
	40tkg8NIlvokdKL+zlFtEbB1sIQ7h3PsmK4HxyBv3BIks3Q5aCt9gvrdP4rThRw8ZFmnSSmxu+s
	3XCr3SaFISm5vy9lTX9lLqjFsGs8cIlvKmniA=
X-Received: by 2002:a17:903:f06:b0:2a0:b438:fc15 with SMTP id d9443c01a7336-2a8d959c4b1mr39869785ad.11.1769825953099;
        Fri, 30 Jan 2026 18:19:13 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eeebcsm83427365ad.10.2026.01.30.18.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:19:12 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 2/5] net: dsa: tag_yt921x: add priority support
Date: Sat, 31 Jan 2026 10:18:48 +0800
Message-ID: <20260131021854.3405036-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260131021854.3405036-1-mmyangfl@gmail.com>
References: <20260131021854.3405036-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255322-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 558EEC0429
X-Rspamd-Action: no action

Required by DCB/QoS support of the switch driver, since the rx packets
will have non-zero priorities.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 098863d491ff..aefef8c770e3 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -69,7 +69,9 @@ yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
 	tag[0] = htons(ETH_P_YT921X);
 	/* VLAN tag unrelated when TX */
 	tag[1] = 0;
-	tag[2] = 0;
+	ctrl = YT921X_TAG_CODE(YT921X_TAG_CODE_FORWARD) | YT921X_TAG_CODE_EN |
+	       YT921X_TAG_PRIO(skb->priority);
+	tag[2] = htons(ctrl);
 	ctrl = YT921X_TAG_TX_PORTS(dsa_xmit_port_mask(skb, netdev)) |
 	       YT921X_TAG_PORT_EN;
 	tag[3] = htons(ctrl);
@@ -112,6 +114,8 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		return NULL;
 	}
 
+	skb->priority = FIELD_GET(YT921X_TAG_PRIO_M, rx);
+
 	if (!(rx & YT921X_TAG_CODE_EN)) {
 		dev_warn_ratelimited(&netdev->dev,
 				     "Tag code not enabled in rx packet\n");
-- 
2.51.0


