Return-Path: <netdev+bounces-294964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ucH5K1G1IGr+6wAAu9opvQ
	(envelope-from <netdev+bounces-294964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:14:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC563BCE4
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:14:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M4MX7qJR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294964-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0D5C30F33D5
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFD54DC542;
	Wed,  3 Jun 2026 23:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9422DB795
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 23:08:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780528092; cv=none; b=NRJH28uoOGkDvXEG0b5FBpD6xuUkpcrpwc+knmvsNlhSNCkBfjnqQlm3oagduL5pK8a3rWsuu1ZJqzW54CqzMHIsbyzpOZskQHAX4/6bGPM4VzUGihyttA1YpojJbpEd1TwKcJ5QDvJje+Ap13dOxH6S4dzMwk6TlEuAHa+Mnmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780528092; c=relaxed/simple;
	bh=DZJR7JiHnIxr/d/xhHstClpwxcMYObV5dZ1CAJ/DFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2hrllWA/Gb9IT6QarcT/MyDkbRbD93Nfe2OMRZQ9VGfOPNXrS/lBCFsU47IsNh5lf6McJtyaOJ1DDcKekkbNwZjpxTMqtvsATlzCWQdOiYIcrWj5fLWizB95WoWRN9TAGzlngEUmvyBMo0DgH5UqTuanYCQdr0axdNcPyEZCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4MX7qJR; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so28386a12.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780528090; x=1781132890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ad37qvFp+RqpJv8WaZQLl/jkZ9QxP+cypLV1t8jzXk0=;
        b=M4MX7qJR9IVN40VKxVhg0Uh9Y5DKEKKedwBURz5qAgr88uRq+fRKpGf1rXbMQ4uhdh
         kJ9ls4VwnRYb6k0qsK5ZLZLCJO4jTDHtYd2PWIqUok8CjwcjV8cUmpsh6J5Pht4QuVuu
         CN8kGHP3pWPN035OvWmbMPqGzJwMArKf1LU0pFL45Td5x1iGm5xRgSpYd0UYLiswbW8x
         twW8x3XuLEiLyanb8o3S6KNhxb2FfwNnsi8AjWwSZ5EH4KIOOrCA9BcUpXC0aLO1Ei8C
         WNltwo9KO4rfk93aPPKvsOmGTkJkD2982+XMAEUmQFGqSeZSkiNDdTPEB0nW2Ssd/Uiw
         W8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780528090; x=1781132890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad37qvFp+RqpJv8WaZQLl/jkZ9QxP+cypLV1t8jzXk0=;
        b=Re6wQ1re8KhL3OgVbwphqwww60rL2LMrbeZyQBNvuKpy90jdYGPjsCXOSd4vZsZV5Z
         A3D/q4Csg5eCnXoGmFk5ho4n0sZ+MXz0ayzOOqwR1aiiYAOG/iUIIzxsfVI89dCyhjoP
         PIp4WEZAeaKP11Ogx81+GEUlxkahoD5+10EIR9PIh6qT9M5o3hpEEcIIFp2EhQoqDq1L
         VcCZ/iSsdIeUj6I1b6TCuVYAY4Y713ViWelq6QOQ7q9bx4csB7HYGleDgCcLowwr8Ctm
         1Cj9JToZabKnbrj1FSV4tH9FgKqLIQf5ZZYqeRZYyU7sM6OCPgX24SSHV9E7j0MoeFkW
         cAPA==
X-Gm-Message-State: AOJu0Yxn1YO7i2hbET5X+Mp3hGxAwhrKXTc+oAubJxqMvyfnIY8ZZp+i
	JuDkma5AlGFu2Gz4uDoAKUXu4/53yeEGpdOq87QECDjoKjI9hB6yH9aQUHqafizl
X-Gm-Gg: Acq92OGU1iG7PqNCXIlqmTcHIjGxTgh0wlI89a11lnYtKojDkSU6odGOrq8EHKID8N/
	laAf4COZejxpITBINWU6XfaEHGuc2PuyzXsjvaEvR91TK/r99uejyJRy7qtBKX1A/mrCvIXFjOd
	oNROn79ke2YIGIvrvC8zu4uNXgl16DWECZKZxE1TDID5pkJTIMjRw2koYPeZMIMjZBM04dsTusl
	sp/m+LKcDdll8Ejjb5Kl3cMENgwASeSq49VfR+rKBRVoM19wP1PzrLD+eQhBQBmI+AJsvfd2S96
	Z8Lf11hr08s3SP6u68XH4l9dacsyhmbZpoJ4Z9Gcog1jOKVNgxZknxsPFO1fzyfb5cVkcWFHTns
	oBKYODTjp34TmShgmizWkx61L+SDDHQE8+TiAbjPMm3ObXp2UI1xKKla8WB/GGCQKCqXOa5hEI+
	8gr+qOsKkhnbgyYsnXUFKVEEvzj1xLdRZpJcCbOh2HRBdSqDGLCvbzftuuOZ/LdpPY3Rxpou4mO
	ZaTbZYXICcxGduDxmUrXvi2/r6RaiZOovK1kJmfguO/UVxUxJIHr8dy
X-Received: by 2002:a05:6a00:2294:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-84284e8a1a1mr4925396b3a.17.1780528090349;
        Wed, 03 Jun 2026 16:08:10 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm4791910b3a.49.2026.06.03.16.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 16:08:09 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jeff Garzik <jeff@garzik.org>,
	Roland Dreier <rdreier@cisco.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: ibm: emac: Clear MAL descriptors without memset
Date: Wed,  3 Jun 2026 16:07:53 -0700
Message-ID: <20260603230754.5535-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jeff@garzik.org,m:rdreier@cisco.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294964-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AEC563BCE4

Clear MAL descriptor rings with explicit field stores instead of
memset().  The descriptor rings are carved from MAL coherent DMA memory,
which may be mapped uncached on 32-bit powerpc.  The optimized memset()
path can use dcbz there and trigger an alignment warning.

Use WRITE_ONCE() for each field to prevent the compiler from merging
the stores back into a memset() call.

The skb tracking arrays remain ordinary CPU memory and still use memset().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: Use WRITE_ONCE
 drivers/net/ethernet/ibm/emac/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index d2194b406c9e..b7568d96aa47 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1162,6 +1162,17 @@ static void emac_clean_rx_ring(struct emac_instance *dev)
 	}
 }

+static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		WRITE_ONCE(desc[i].ctrl, 0);
+		WRITE_ONCE(desc[i].data_len, 0);
+		WRITE_ONCE(desc[i].data_ptr, 0);
+	}
+}
+
 static int
 __emac_prepare_rx_skb(struct sk_buff *skb, struct emac_instance *dev, int slot)
 {
@@ -3089,8 +3100,8 @@ static int emac_probe(struct platform_device *ofdev)
 	DBG(dev, "rx_desc %p" NL, dev->rx_desc);

 	/* Clean rings */
-	memset(dev->tx_desc, 0, NUM_TX_BUFF * sizeof(struct mal_descriptor));
-	memset(dev->rx_desc, 0, NUM_RX_BUFF * sizeof(struct mal_descriptor));
+	emac_clear_mal_desc(dev->tx_desc, NUM_TX_BUFF);
+	emac_clear_mal_desc(dev->rx_desc, NUM_RX_BUFF);
 	memset(dev->tx_skb, 0, NUM_TX_BUFF * sizeof(struct sk_buff *));
 	memset(dev->rx_skb, 0, NUM_RX_BUFF * sizeof(struct sk_buff *));

--
2.54.0


