Return-Path: <netdev+bounces-299839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ewmOMMhEMWr9fgUAu9opvQ
	(envelope-from <netdev+bounces-299839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D568F759
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:42:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M7uyUq+C;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299839-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299839-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A93A3001857
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2A361DCB;
	Tue, 16 Jun 2026 12:42:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C4F360EEA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:42:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613744; cv=none; b=TMXMCBZV5ZqyX9m1bJsbcU80a6ZBOUzuWOBAERX7/yLWr8YPmqqKXVovVIsBCF7Tn6HlJXrbafRa7oLAucpx7DK0peGGrvxVYIUexw3ncsfBgXiXxadlTP+cae4A1ikjDhoZKoVIoniYVVFOstOtbA1bObWHW18ezvtAyvvgQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613744; c=relaxed/simple;
	bh=hH0oRwMftoRPG/+KR7O9epoqDsjpP0ySNJo81UC5ZNA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cdshqnhpZgndhuWSCKS9DMvsw3Ia+x2dEKWTFxH4eGCbE1bdQFWZYkbJO702lS7d5hOAJEMt0eVaDs5DS3ok81KjBS2P379AcWuC9mvlH+InFGnyqfmO5PHR5C+9+bxwco5bR9+QNe27VgQtXEM5+EYVB8AVQj+QASPg8fBdHYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7uyUq+C; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf2247e38eso40939945ad.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613742; x=1782218542; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6uM0ObpaAPGFXgDRAB4wX+6R8VKBvIYPs4Db/iskdHQ=;
        b=M7uyUq+CriAUmO+EipGnPNO7Au3Z+lBVb/BNZ//QztzHN3dsutEraIYIZPSnIWLShp
         fc5TswMzEOaIl4EoLLs5UtGcEh1sELCMUJXzy0ZTvmI+rj9mpw/WPlgk/SQKYWVPzjVT
         nwl0tCBBLcGv1f6VPzyQRgzwHWCLHBnI1tUMCD/WPHme4AssZWNNGCentj2co7cY+Xd9
         JO/sK5qY2rSJmnzeejB1rFfCwuoa/ppiKwxyl9MQ4oTX9ov5ciMDrU3KmCn6gUtLV3Tb
         p3f1hi53apNdKdm2pBujiAretawJuExUC456fDOLm2pZ2xYyXCIkWKTPDFfthu8RAzu8
         zJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613742; x=1782218542;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uM0ObpaAPGFXgDRAB4wX+6R8VKBvIYPs4Db/iskdHQ=;
        b=rTN5xymkvrZPFU0Ps8xHglSeUO5+9LiEbX3M7Yjh+DcJQIJZSiPBfzoyUrgiUxexY6
         hoSKg00CuXrjRKF6PsMTmILDOdLSwjI3ziXBJwNP0XYnBi9pz9PAPw+X5KmHagL1J0bM
         Vcu+Z074204eEIS32bUn3p2LnVCfSaZWVBG0U+xbO6uHZKVXcB1d3vicpSkk2kwp5ngQ
         wSqyqXgwAgDVBAWw8uVH7NYJLXVJWMIWa+mZhUE3ldDwvLepuYjNTJ41LbjgxTzIrUO1
         zvlVxm8PEh9WUV3fNr2QgPuPNYLNyIO/XusLlxNhB4o4hJN8ku1ttJuXhF8gLyBpJ+tg
         56aA==
X-Gm-Message-State: AOJu0YyOE6iX9G2EeoYVOBt/y6/h6eJzcBtuOUZUAzbDc7TD7tB8ejZ/
	WnpmSzIMagX/oEoLnl6HgVC9NveZDPnQefFYqJ5rAhdCcuNcPY8kuw0pWQRyCOwwUcAsnQ==
X-Gm-Gg: Acq92OEWKSHxZcGwIRUlDwZ7XxugYABrADbEBdaFjpFxgLueUrHva+tmrp2H9HUcF6s
	LsoBk/97jpxVbb8impUNUT0B67iDglk6BvrEZTCHEO3WOxEXF1GjLGt5TxOFwH3kqudMHmhH5dh
	nPPzp7SkSQ6WvdFJD+cBkQuY0epL+nPVzdBp3ErTjKySSoljaCWorXLtrzQHbmmPXiURpsYq4ei
	KECBo1Ua15a/NqAKXOGIgqhRJemPNvqe7tR0o+/lz67/UO9hwp2bG0Jwm9JvTUesUdUj2Ujo9FP
	Q55tawS4kpfWk23nwzBT2q7KgdSYgncdbIFp/OapuHIRJjN1OabFnKPYwmwoXOvWykkBC48Y0hc
	AQHepfblm2+GfjBAsMWf+zw4xGiupHiQl1LFS82lcx0aIzPLddLrGQB1p/5hNZT9gs7t2KfXPiK
	pN12pdCDD5ZNjsnZDa
X-Received: by 2002:a17:902:c944:b0:2c6:9448:363a with SMTP id d9443c01a7336-2c69a1731b3mr37365455ad.20.1781613742538;
        Tue, 16 Jun 2026 05:42:22 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb50e5sm135274665ad.35.2026.06.16.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:42:22 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net v3] net: airoha: Fix skb->priority underflow in airoha_dev_select_queue()
Date: Sun, 14 Jun 2026 07:30:54 +0800
Message-ID: <178161373805.2167512.2544164327472822616@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[61];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299839-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,dama.to:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C48D568F759

In airoha_dev_select_queue(), the expression:

  queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;

implicitly converts to unsigned arithmetic: when skb->priority is 0
(the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
and UINT_MAX % 8 = 7, routing default best-effort packets to the
highest-priority QoS queue. This causes QoS inversion where the
majority of traffic on a PON gateway starves actual high-priority
flows (VoIP, gaming, etc.).

Fix by guarding the subtraction: when priority is 0, map to queue 0
(lowest priority), otherwise apply the original (priority - 1) % 8
mapping.

Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Reviewed-by: Joe Damato <joe@dama.to>
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..d476ef83c3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1933,7 +1933,7 @@ static u16 airoha_dev_select_queue(struct net_device *dev, struct sk_buff *skb,
 	 */
 	channel = netdev_uses_dsa(dev) ? skb_get_queue_mapping(skb) : port->id;
 	channel = channel % AIROHA_NUM_QOS_CHANNELS;
-	queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES; /* QoS queue */
+	queue = skb->priority ? (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES : 0;
 	queue = channel * AIROHA_NUM_QOS_QUEUES + queue;
 
 	return queue < dev->num_tx_queues ? queue : 0;
-- 
2.51.0



