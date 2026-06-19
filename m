Return-Path: <netdev+bounces-300645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eAwJBP71NGpdlQYAu9opvQ
	(envelope-from <netdev+bounces-300645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1726A4775
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:55:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R5cGiEvQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300645-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300645-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7ACAC3025A70
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986E314D26;
	Fri, 19 Jun 2026 07:55:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B21FA859
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:55:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855738; cv=none; b=KEYMRb7D5VQfxAYikltTI3UJRqsIUIz0aBsUUHhRXI3WTLRmI30Z6nQyUBaPK5X7H7Hq7qAlmiaTP/3ZzrDK/5R9qgQLUlgBokEuCzrGiVc5xD9a23nU00DKBbKYzytlICnKmThUA6sZXApEN4LAXXpROoi69V3yxuzMsoexfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855738; c=relaxed/simple;
	bh=ITp5V4Wi5dZpM8U50GSdomX6kb1P/6r7ktj5hRsniiU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NiG5IATU/733pkdT4bKO3TsXuihsIljbLiBEkgHg0yUdYaQ1Ho6yqq28O2ytQrb0cUh0Gf55jxP4OvEASMP8C35n+/01oeq3IwW63FnwDf52zvH9MaLUl3Z68bUOKUOGz02AIHpYpWxyY6qXp8kIa5vHWxC+wKOEaRJbDEEf0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5cGiEvQ; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c6a97e1d1bso13447835ad.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781855736; x=1782460536; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+x0Q9vKRabtFjaGXApa4amcI6ZA0EEYg48FTUvCHSCM=;
        b=R5cGiEvQXMpjnk2+nBtyOvQ6ay5CzK+pdEgWJ/+rOA8KsWHEdkiNFPmoB3xhyTcBEd
         HCxhiFWkHpCKOouk2v+kgKlRBQ3/twoaWgaXO5P7OzDUaj1FpcGPW519NhZ1GLrs7lTk
         vrDOZSEbZmb/a2Fp5YwqYFE1CBPDJTbCduTr0Op15jGHaqjRHiGW9lzpcykYBVYurvT0
         FqOpYjGPhi6B+CgmyQNB+IzBT/gD4I3QNeh/NXSn4KZtpH/T+IVxw3ihAQ4DohaCFxKA
         xR9Y1MHv6GfYGAtcHnAHgcerTEn80EocNJe0tTvh8/dptTpKzqSFs8f6pEfbCEdT/L/D
         t6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781855736; x=1782460536;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x0Q9vKRabtFjaGXApa4amcI6ZA0EEYg48FTUvCHSCM=;
        b=NfWV7H2hGAyF6Aqa3DbqkJQUROOkpoaPh6EUgM9D3qsfLetOJw8CgvXqWTeXCB8Lx4
         3abcrs1e+2sjEYL3CyptaBVg+1CnMK64uuE/BYF32U/syxNuj9P7ByH58fDheVSGirlf
         6VXHDCh9le9G2eQrPJodkyxjWn7dSBRz7yRtZ+dKYAgx1jGSX3AeSiwKNqX/hTQQhYlT
         xKzkZtxRsXvLgdolZSkgIQ+gqRJnoSEu6PWLpI4ZcjV40X/jAIAvj4akSKEwS75i+lMo
         tPt/PrYXU2n/ZvtPBhYWNLbScnd5JebVnYfDRCUTIHttEivgoo059gFYbuj+UKdFmLQP
         Z/Kw==
X-Gm-Message-State: AOJu0YzpDX7GeSFxF65xQD7oI6MKHtBzQwhTpIyzgjJMB/cz0kj9IfnO
	IsX1U+FhdIB08FxcEvlq+FjNeKR2jaQCsE3qR8ori4N8dvWRmbVv9cCXv/9AIeB4LnA=
X-Gm-Gg: AfdE7clsfOpJbgzV9Xj22jYmNOhmz/TfFIbORSRW4f5NuO/kZ47710KFPDCf9xy5VKC
	NEMMTRtFmptC8Nryh+lVDH7iTOMk9aRCfRxK6aTiZWSlqjiF1CheUyOlo7/k3Yp5/HorcZNA4Nq
	9aUP9ZjA1bvQia5jeToYmx5nOnA4xuICnc3iDwOLRXx5B0BkkvVy4MvKROqH8j2KZfWQvCiIK+y
	66k3GuDMIA2xwdx0xmYKqvXTg8y7LeXPbPpWQGO6aJ+mCC39RLVjPkPC/hUeKvUlL8EZUPbeKqE
	0zbE8XfrIiKgoWJ9xbU1ioPXnjOCtCT4CEiedys6unGsIBqhUfeJo1d8u/InD6dVgtmYkDXpjx9
	NFEwX3Os2+pbWPWpQ3ukDjQ4CaDMMuObH9xefbSDq+RvPZO2Vg3aQ5PTbIpo0ONs+I6xedgD7xh
	mElksOdmlNJKtaNU7G
X-Received: by 2002:a17:902:cf06:b0:2c0:e5ee:f56c with SMTP id d9443c01a7336-2c718fe25a3mr28777415ad.20.1781855736340;
        Fri, 19 Jun 2026 00:55:36 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7209bc296sm15297755ad.49.2026.06.19.00.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:55:36 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net v4] net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
Date: Fri, 19 Jun 2026 15:50:16 +0800
Message-ID: <178185573207.2378135.3729126358670287878@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.39 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_BAD_CTE_7BIT(1.05)[unknown,utf8];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-300645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dama.to:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D1726A4775

In airoha_dev_select_queue(), the expression:

  queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;

implicitly converts to unsigned arithmetic: when skb->priority is 0
(the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
and UINT_MAX % 8 = 7, routing default best-effort packets to the
highest-priority QoS queue. This causes QoS inversion where the
majority of traffic on a PON gateway starves actual high-priority
flows (VoIP, gaming, etc.).

The "- 1" offset was a leftover from the ETS offload implementation
that has since been removed. The correct mapping is a direct modulo:

  queue = skb->priority % AIROHA_NUM_QOS_QUEUES;

This maps priority 0 → queue 0 (lowest), priority 7 → queue 7
(highest), with higher priorities wrapping around. This is the
standard Linux sk_prio → HW queue mapping used by other drivers.

Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Wayen Yan <win847@gmail.com>
---
Changes in v4:
- Remove the "- 1" offset entirely as suggested by Lorenzo and Jakub.
  The offset was an ETS offload leftover; the correct mapping is a
  direct modulo of skb->priority to AIROHA_NUM_QOS_QUEUES, matching
  the standard Linux sk_prio → HW queue convention. (v3 used a
  ternary guard which addressed the underflow but kept the unneeded
  offset.)

Link: https://lore.kernel.org/netdev/20260617164448.31e189bc@kernel.org/
Link: https://lore.kernel.org/netdev/ajPCgH7E_ke6Fdur@lore-desk/

 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d0c0c0ec8a..9ec3f22754 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1928,7 +1928,7 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
 	 */
 	channel = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
 	channel = channel % AIROHA_NUM_QOS_CHANNELS;
-	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
+	queue = skb->priority % AIROHA_NUM_QOS_QUEUES;
 	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;

 	return queue < dev->num_tx_queues ? queue : 0;
--
2.51.0


