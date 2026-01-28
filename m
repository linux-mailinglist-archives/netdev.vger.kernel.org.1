Return-Path: <netdev+bounces-254475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE49JkGFemnx7AEAu9opvQ
	(envelope-from <netdev+bounces-254475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:53:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25323A945D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A98530530CF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F633065D;
	Wed, 28 Jan 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgMgVKRg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E709533BBC3
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637139; cv=none; b=WbGdk4jpcMTyqObqR+VATpk5WJ3rY4w9/HEJLJ9ioGksUjaXGJvegf3+pyXhZYaiRfGmFQKAhYA58tm+vma8wITrkSo3CM1/Xec+ZLFsI2lWMarHPXN03xzi3WRp8SQYxoifg3IQft/y1Hk0fHFhtAE9p3IDY1/7HoDgk0KSYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637139; c=relaxed/simple;
	bh=0t0dl3v9CeZspqERK8OCxRJsZj/7BPyDqzX+ailEm5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd8pAuXDuqTCwxyCAUeJ14bKrhIx7jitWGZth5fDBizGGx7HZHL9N6lufwCEuDKi2e5ZbpvBTFEU9yeqbDgsty8TxOPQFe2voCxFbH06NVQpwcyPmaFKRiTMDi3mg4phJYmv8EjXlkY3s1DkdN/jKgihanemKs7zw3oLus9Pbj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgMgVKRg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f102b013fso2562295ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769637137; x=1770241937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpCifLiPOJS30ldSXwTRHj3fHBDp1Tvh3VJtIU/qW+o=;
        b=HgMgVKRg/uobXisMNwVvZ/2CZHeAGS05BpCAalSW3gyNa6eBSBkY50hX8nY1KcIS31
         9GHWpj1AmG8nSv1vMvSkOyJ7082V8TrE6CTRPzRBqTRfz3NDzQU+jHs0hS4J0DM06GLl
         KnUNetnS8p1qaIEtOSBfhQVULuinE2QP/RnqmGke8ivIhDNfluTpxsZe4ASsVhKpequD
         V3Yma48iBtJHJaf3wdbqd+AuZvmMD4P5b0fjoawJN8fqE8/OHOLdtVA055ZVRUnEN244
         2zfoFptmSze3UlGYj3mYOODqpv6SRJYYyUZaGdPrtc0dprswmqx0cPRho7qjjO4z6kHg
         yqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769637137; x=1770241937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vpCifLiPOJS30ldSXwTRHj3fHBDp1Tvh3VJtIU/qW+o=;
        b=d7kUWKCNUgBgclR3J/Cb0tBveUA13DM6iSYzje/jKxx1AJ345SYO0Y4ttoflUk0sfl
         VLZ71dtirhplOqQe1JVZJvXp/shMAzvpt7pMhk/HmzbF/uqpfV0sA63uXlW/caXZUmEL
         cHO4s1cK0cATuDyEZNynm1H6/vlg1R4pBct7SgB/oZnKrqRc8BG8CjlOzuJ4qgCO4jDR
         jAMeQc4QbbNn+qeVpNL4FfgxwUzhNGwsIdleWHY58hmRqgaCfKNAId7PPpJO6impjeAf
         BBrC5mVUBu30CdkCiLWlTJH/OLctAa4NRYmiAnHA5dSMG+6GTOVR1MRHMiztpfH6iR/K
         SxUQ==
X-Gm-Message-State: AOJu0YzRUjVBVdaj9mNHJzBisSOT5Kl9gWCCW14L0qvsr/apoxgbEsy9
	e1TqnDhERQ7VfaH8jB5Hin1p1bOFcDAXvm87WhMlle+K44b+IkCS0HGlBnbdtU19
X-Gm-Gg: AZuq6aJqHCslq9lHJkxwfWNHUc4msF62cbdBcZXMy4OJMAYfGKrzwdOqmMgjGXZz9c2
	FrHaKH/1Sk8Gusi/eLYBGOxo0dAFRVniiMOHZY/cO14A33kVpYFIqfnNPTvjC+UkwsTP1dZhtu2
	yoazEKwts64/k6Hpl15ywiubzpnCod7sJ8WiOZ8Vb+ZpU9eddInPXT8iVXYYSWU8VjyiVYaxhEd
	RYGq8l6jgjQSaxvsRHMC74BCSHf9lh/DEWQDZ0dxU9im1TH1AKoJ1VI4Rk8Io4I3Hf4w243xyI2
	O284uCNlpbCwWByreqMgzeSCMteABJeF8NFQnyHJ2aqBC1I7KMsa92XgPvSdrP2E76W3Yeq8tRH
	1Dp7uCxP5tGzmWOE1ol6qhUXXA6OA0s46EjM4Us/E+8+I858wMhBFH626qkr0fIPc0vR9ld/1i2
	hkkLFYhLG+M/S1SNlaqNbvM119AcqKYeiKdY4=
X-Received: by 2002:a17:902:ef52:b0:2a7:d7b8:7672 with SMTP id d9443c01a7336-2a870d4d015mr63211595ad.4.1769637137074;
        Wed, 28 Jan 2026 13:52:17 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2a09:bac1:7680:d30::4:384])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4317sm31576155ad.85.2026.01.28.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 13:52:16 -0800 (PST)
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
Subject: [PATCH net-next v5 1/4] net: dsa: tag_yt921x: fix priority support
Date: Thu, 29 Jan 2026 05:51:53 +0800
Message-ID: <20260128215202.2244266-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128215202.2244266-1-mmyangfl@gmail.com>
References: <20260128215202.2244266-1-mmyangfl@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254475-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25323A945D
X-Rspamd-Action: no action

Packet priority is part of the rx tag. It defaults to 0, but adding DCB
support to the switch driver will break the tag driver by setting it to
non-zero.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/dsa/tag_yt921x.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
index 6bbfd42dc5df..b93715a057c7 100644
--- a/net/dsa/tag_yt921x.c
+++ b/net/dsa/tag_yt921x.c
@@ -17,7 +17,8 @@
  *   2: Rx Port
  *     15b: Rx Port Valid
  *     14b-11b: Rx Port
- *     10b-0b: Cmd?
+ *     10b-8b: Priority
+ *     7b-0b: Cmd
  *   2: Tx Port(s)
  *     15b: Tx Port(s) Valid
  *     10b-0b: Tx Port(s) Mask
@@ -33,7 +34,8 @@
 
 #define YT921X_TAG_PORT_EN		BIT(15)
 #define YT921X_TAG_RX_PORT_M		GENMASK(14, 11)
-#define YT921X_TAG_RX_CMD_M		GENMASK(10, 0)
+#define YT921X_TAG_RX_PRIO_M		GENMASK(10, 8)
+#define YT921X_TAG_RX_CMD_M		GENMASK(7, 0)
 #define  YT921X_TAG_RX_CMD(x)			FIELD_PREP(YT921X_TAG_RX_CMD_M, (x))
 #define  YT921X_TAG_RX_CMD_FORWARDED		0x80
 #define  YT921X_TAG_RX_CMD_UNK_UCAST		0xb2
@@ -98,6 +100,8 @@ yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
 		return NULL;
 	}
 
+	skb->priority = FIELD_GET(YT921X_TAG_RX_PRIO_M, rx);
+
 	cmd = FIELD_GET(YT921X_TAG_RX_CMD_M, rx);
 	switch (cmd) {
 	case YT921X_TAG_RX_CMD_FORWARDED:
-- 
2.51.0


