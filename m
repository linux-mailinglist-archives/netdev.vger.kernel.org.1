Return-Path: <netdev+bounces-296557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lw8kDa+/JmofcQIAu9opvQ
	(envelope-from <netdev+bounces-296557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:12:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD246567A6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:12:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nFvV6B8a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296557-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296557-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BD9E3000FEE
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA37322B72;
	Mon,  8 Jun 2026 13:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9847E321F5F
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:10:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924227; cv=none; b=QV7OKc/Cyf/3fmvqaHqvz4OePPM3EQ0rtoHOkJZMQ4WKwUnvO/c8U+KD6nD2W/yavc6BG594VqFGdDgHaPY4DazhneyWgWH4ZIW+Lz+hh7U84ETsX3KE75ma16Lp2OGB3WJDqkTq7dWhjtGjhuNYEc+2qP/taOg5RxzgsYKq4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924227; c=relaxed/simple;
	bh=akmL8HOgA+GPy8jHLWmgPO3FBnfcn1EMn4Ene8VpUpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXElmxc8zUIJNkm4k7svcd/McAWwIuJSu7x5SxwZ9BerpOuZf//TsLHGgWpeQazz4hQN+qN+h+Yf+u1ATojpjSzmEoR2TIQmCfkmILG2wnna+OOVwmfayg2+hl1LqxjviSYy2MnfjZb+4WY66oejPWwWpHPI/RNL65njhsu0hAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFvV6B8a; arc=none smtp.client-ip=209.85.128.65
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-490b8adf813so4459685e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924224; x=1781529024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/3xQpyIAVNRH13teE4x3QsjrE5WxhXVq4MWgMURLZo=;
        b=nFvV6B8aL1+S3yJiSK7IenpT1VTokd1/ydrgQ1Es15VXfBT0/zuK/VdqDC+NmAKrUD
         t9LoBt2XMDI5qZ7UK7gpTwrYoY0mqKiypz2AxyM6KmD8+zsIg84oFLG6wD2VPeiIIe7Z
         WDqTLH/mpOg81VgQKcAtCSFa2Wr11tLIwLys0rH3gl+76FfS0yW5U0MifxRwf3gGTwir
         HLDRkJXW7+yXftp4OKtlId9aJSFE4XNDBCsEZRKnyG+323SBjHJLRlvBz0UbwJJMK4j9
         e6cx/VXmVzx9vuABR4PSLnMLbrmUdpfl+TLNNw0mpelPv62b5WOdTScI0Ab1oUsm0nKo
         I8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924224; x=1781529024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/3xQpyIAVNRH13teE4x3QsjrE5WxhXVq4MWgMURLZo=;
        b=drTs09LRyMTbxlavabT2KGrr5v225bo1QCQ5d2t4DJr/jzhj0PZ8WNdel8AGSCIrCL
         A/tr38egiaTaTNQJFdnbOtTsBrKMYr67TUzWBOvn/7+Z2/USlTPxjr7+JlCjgbZZA5RO
         eaJAA/0t/JJ9zUy8JjxnIySFFkJqyl4GRiUrjVa3ZJdyuQgBfpAVUroTfx8DzEW7m4Fq
         k5Ad1nFyXGhbLimnp2ToXYT1L5Z4qP6kEi0Mr0wf/py4Qrhqk/tSsTQZB0fCm1R5dOX9
         umoOILA68C4Z7q0VMQ/Png8FXfY8FgxIIFcZSHg5kUiKxIKM0vPptMSzz5cEJy7jxmX3
         QcUw==
X-Gm-Message-State: AOJu0YzJ68hF/70GqhiGbrpNtrmF1Fct2rORQDHxSL0EHE6FyYRI9zYU
	CRlJ8OnE+4Sb/DIL5+Uy38KgElz9y6ZC1+0Rqj1pJ05iQaVurWKxFRUB0mS8vb2j
X-Gm-Gg: Acq92OEtDb1A/iX1weCalZp5ixfAC5NCFsgzFjIyzub6arRAxfUZMyOpJ3WUY54/Ugg
	lGW+aNE8LiY964aweH9MA0RlLKOWvWqpVoEPq/+T3EM0UqAj1qN2ROpZ22zU71xsS58x72hEobQ
	SBHpawXIMZZKlvrObWcWxAc8mfwDRfigRtJ/kXKbGaoxhwTxup6qfS7jdHDp6hZJ59VrznLO2ai
	zHOAc4pj92mC/Ng98ovWYej4/57xgbmb0pSoL8Pkj/dUN/zcRv59mfeiPxTxaLnPgJChhK/SXRu
	Cqj+JCW63pU9SuXU2h5yw7la7BfgXNJZabnCnbIYjWrnWZXpoE0XlP/w7jVYFw+IamTsj9JB4rJ
	jpGdFXuRYaFUTWu6aPgmmZug6tqMnpznMvWm/b3KevcmYRBrJBI3teShzxP0FyB6ooSjUuKWX33
	xxKY97mU/qfzmPymJL3RDY7OfFrsSGT4E=
X-Received: by 2002:a05:600c:8b0c:b0:490:6e0f:29f4 with SMTP id 5b1f17b1804b1-490c260d263mr101533845e9.3.1780924223695;
        Mon, 08 Jun 2026 06:10:23 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:10:23 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 07/10] veth: raise the max MTU above 65535
Date: Mon,  8 Jun 2026 15:07:52 +0200
Message-ID: <20260608130755.5626-8-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296557-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABD246567A6

This patch raises the maximum allowed MTU above 65535 to allow IPv6
jumbograms to pass through veth pairs. Raising the MTU above 65535 can
significantly improve throughput between connected namespaces. This is
particularly useful for docker containers, which are connected to the host
through veth pairs. This also serves as a way to test jumbogram handling in
the kernel.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 drivers/net/veth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0cfb19b760dd..e34ffbc1d651 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1425,9 +1425,11 @@ static int veth_close(struct net_device *dev)
 	return 0;
 }
 
+#define MAX_MTU IP6_MAX_JUMBOGRAM_MTU
+
 static int is_valid_veth_mtu(int mtu)
 {
-	return mtu >= ETH_MIN_MTU && mtu <= ETH_MAX_MTU;
+	return mtu >= ETH_MIN_MTU && mtu <= MAX_MTU;
 }
 
 static int veth_alloc_queues(struct net_device *dev)
@@ -1628,7 +1630,7 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 
 			if (peer) {
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
-				peer->max_mtu = ETH_MAX_MTU;
+				peer->max_mtu = MAX_MTU;
 			}
 		}
 		bpf_prog_put(old_prog);
@@ -1754,7 +1756,7 @@ static void veth_setup(struct net_device *dev)
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
-	dev->max_mtu = ETH_MAX_MTU;
+	dev->max_mtu = MAX_MTU;
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.47.3


