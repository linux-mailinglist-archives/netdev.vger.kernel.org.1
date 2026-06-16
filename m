Return-Path: <netdev+bounces-299848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9rXSH3NNMWpNgQUAu9opvQ
	(envelope-from <netdev+bounces-299848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D411968FDA8
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:19:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=LiN0zueT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299848-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299848-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FB5D3028F23
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED726286405;
	Tue, 16 Jun 2026 13:19:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732ED315D21
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 13:19:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615984; cv=none; b=FrHp17cRRxTAgblKwo/k8A43ZfnYFox+rcniAoB72WFLCdKDNiV3gapw0J8jZNvPXeANmMmJVDdjmlrKrPPPeecFelhqwdKe5skm0xt+F522YAmVzCqnv6hKqYV489Br1pc/X751hamCRXX5CsmOy9ZWll8IfO5cxYJ7UvfFtrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615984; c=relaxed/simple;
	bh=AhKOFstzmwRxmO+erMePpCNXjN1gNPFj6YHwzy7Y3L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBj08mHpefmEc7AiYLu6fI3w9sJQklPv2/FuEAtFdkxy8sHjCxrPV5m1eQV2dys9FqY0qWDxLz06CQy5R4PUvvxk6k/q6vbCy1q6hQgjaWsC+E5w02UTJwoU2MLTw1UYztbTNrX4oPIw8+ynO813bMBhfbRW0Eq9oy3KJbHtHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LiN0zueT; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so38283405e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781615982; x=1782220782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJJvLQcsXRqIV9bKinu30GBt9W6FiGqkHOghRxLofTY=;
        b=LiN0zueTap4Veuv4+EJpH6HcLW311xLCRR35/13WpattskW9YoausFMO5Cu0hO8jDF
         3sGB9Y4n1OdidGceesV0Tdk7F6QOXVMTxqoyaowwJHDYSIlibtT4cXpePd1O19uc04Hq
         gsbSerTq7oZNi4d073gwRfsKbB4h0HSmptuChzyw1qUYFL+uMavbT6aWv5rfmNk8pkSr
         84khEpj0ROqRdJHtLrALglTBEU+jNkwXHHsizsFbpXpRqU/sesXHi2bocPiHmofi0zwc
         gojucWIx/wjOpaQdjOB//mXxcnDlxnwYFr0k8i941nzw46HtnKjoPhrEUSHpH0x2p/0q
         ILqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615982; x=1782220782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJJvLQcsXRqIV9bKinu30GBt9W6FiGqkHOghRxLofTY=;
        b=C5wbaFtRcEF7V84DSrtt+rBWBVebINRBbJVTr0AYz5u1QFNJ1tgZova59O+W8Ekvfg
         Z2KHqyJX7ZEXWE/siBJsIbPuAJ6mM2UJ8rHADmg+RKKHh9Qf3Wu5hmVD8tAtHqoF7f9p
         ksjni33xnJ/U4PNSHS8SdR2Kno6J23T9BLya99P4+Qstgj7ueHadhrcAR+MHHf7hRyu3
         o/cGkGqT3pZsAIaCI/aprJr7ZuH+FzK1qfaUfT4YfAKVIopLDC6di4Y4Wj3IUSUB9R50
         3Y8LnYPrws+WBZZuhxJhNL9bIbmkmwOdd8MCsAN7Jx1K7DLY+aHIJM3l8VLT6lQHznQB
         JLmg==
X-Gm-Message-State: AOJu0YzS3jr6TEWfPVA8GZx1zHHeo+B5VLk5eLAG/Xmj0fCRv26CAMDE
	H6gWY2GEAtZU2ibGA9jXUmFJLc9BSaj4N8K6oy9JgXwzuZy1KmQnbsm6pEGz6NQMeW0L8a899wF
	tt0C1BZY=
X-Gm-Gg: Acq92OEkSjkuFw6hJKZOuarzDse2VraRkfdHxj39SeiakK7XA0t13aXfZ37u6bOPprv
	/jP+MTXipvt1FYxrYnJ4YC6qNdmEcIStm6lHvsdV7BIgoeq1puob7CDNZ7SJ1gu0ZcAcPkPSZuo
	Psy6e52u7tXamjAmVP5Bew9amiv5cmbtKvj/iK0raF9yOAu3c/IaIFdoJopS44oJPKgv0h+3Myg
	kiNS1VHIhv39fFFLAe5GpnaJ3tUbO0HvLMOeOAXcyPmDzu1hXPZgFkIOw+TEJM5Qk6GxqBg0hvv
	NdPXxaIAmGeZLDA9A/lf75LXrmmd6GeqSKFVXGr7cP8Xv0BgvqQDqdqaGl8V9a24/Z8Q0hnU0F3
	l4iTsajwgoQ76tMpNcumlmykN9EsPGNO1lI1ZlO9DMxE8YWaZD9TpVBj9UQ/OZsG0Flk3w+WyD1
	MdU8BJyNOMG1VcNMqd7931
X-Received: by 2002:a05:600c:6812:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-4922ffb7525mr56959135e9.26.1781615981714;
        Tue, 16 Jun 2026 06:19:41 -0700 (PDT)
Received: from localhost ([195.94.146.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa96f0esm83714245e9.12.2026.06.16.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:19:41 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: netdev@vger.kernel.org,
	Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Cc: Lukasz Raczylo <lukasz@raczylo.com>,
	Steffen Jaeckel <sjaeckel@suse.de>
Subject: [PATCH v2] net: macb: add TX stall timeout callback to recover from lost TSTART write
Date: Tue, 16 Jun 2026 15:23:03 +0200
Message-ID: <468f480454a314303bac6a54780b153f689f2267.1781598350.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299848-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:theo.lebrun@bootlin.com,m:andrea.porta@suse.com,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rpi-kernel@lists.infradead.org,m:nb@tipi-net.de,m:lukasz@raczylo.com,m:sjaeckel@suse.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,raczylo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D411968FDA8

From: Lukasz Raczylo <lukasz@raczylo.com>

The MACB found in the Raspberry Pi RP1 suffers from sporadic stalls on
the TX queue.
While the exact root cause is not yet fully understood, it is likely
related to a hardware issue where a TSTART write to the NCR register
is missed, preventing the transmission from being kicked off.

Implement a timeout callback to handle TX queue stalls, triggering the
existing restart mechanism to recover.

Link: https://lore.kernel.org/all/20260514215459.36109-1-lukasz@raczylo.com/
Fixes: dc110d1b23564 ("net: cadence: macb: Add support for Raspberry Pi RP1 ethernet controller")
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
Co-developed-by: Steffen Jaeckel <sjaeckel@suse.de>
Signed-off-by: Steffen Jaeckel <sjaeckel@suse.de>
Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---

CHANGES IN v2:

- dropped the rate-limited log message
- avoid incrementing tx_error as this is per packet

---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa21244e83..fd282a1700fb9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4522,6 +4522,13 @@ static int macb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	}
 }
 
+static void macb_tx_timeout(struct net_device *dev, unsigned int q)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	macb_tx_restart(&bp->queues[q]);
+}
+
 static const struct net_device_ops macb_netdev_ops = {
 	.ndo_open		= macb_open,
 	.ndo_stop		= macb_close,
@@ -4540,6 +4547,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_tx_timeout		= macb_tx_timeout,
 };
 
 /* Configure peripheral capabilities according to device tree
-- 
2.35.3


