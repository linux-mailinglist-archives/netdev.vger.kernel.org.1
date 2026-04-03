Return-Path: <netdev+bounces-275267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDryHTJI0Glu5gYAu9opvQ
	(envelope-from <netdev+bounces-275267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:07:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97D398EC8
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 01:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 821A5300A32F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 23:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B15738AC6E;
	Fri,  3 Apr 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfGPaQVy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EF0282F1D
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257645; cv=none; b=DgHYcR2Xuqx1BE6IlDfRHPB17kFzuzw32tjPD4Bz2S0Zn8vQNq9KXInQ1oWTlrGHrep1C7otUgse/7Bu5D48LrR27wvPrEl8uJBmmobc1U0X4rSc2PMNXJqt0F+G6PIquaAOIHO+dwGCioqm4sr9UX9eTAmF+KWt5x3NjvgtRcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257645; c=relaxed/simple;
	bh=w9Up1fKB2GEY6om9s47lJMNvXz+5zEdTXVEOI5jkmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/Sr/rg+LzmvH3wUYueWMf8SNyc8EBA4FTlXkOjt/qmT9a+3+h7EmgEM0/ABc+Tag0FxjwRFLbMXYgwfIIe+BMGBzpmOtTGjlK/8hqOywsywCuCqf6HHmOOD0bOodaNtK7NHlbOh/m1J3SkIvdFeDVj31zZ8GU7EVVFOCOM2DVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfGPaQVy; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso10473775e9.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 16:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775257640; x=1775862440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFVf762eS5hmMghaQTstY0t0CTwtXlUiAW2YdJ/qH4Y=;
        b=ZfGPaQVybBqvtxFRuGhx0wL3V+XXpMaDYShiLea2wwphqYqyvtYv3vqNQm3fEfdkZb
         KOl8kRP9eygkTVf/S569F46JSShw2Fa5hJgDuhx6u+75ysad3Mc/dyWqFXx57vxfJ2CS
         DT+/Gu5fqrnz6DgMg9657yf7Fh1QmLbAR8fIXWfd4lHn/xaWFeIbP0AkGK9M3YPyUA+J
         CLrv28QJYV0d4V1mYg2renK3Luy9Yn2GHZbQ9sC+MLr63VN07AB2eot3mH0vjflBT26B
         vMLCHitl7t5shed6jmX7dELGBqgVXi6XxoOCDOplqyw2xSSinl9eJG2+hyNmajrGe8BT
         xgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257640; x=1775862440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFVf762eS5hmMghaQTstY0t0CTwtXlUiAW2YdJ/qH4Y=;
        b=pPXP6ivMJQFLV7HMW07yTXozpN9PdRAkPUTGJBjgyJFAkYPAOg/+QNBrEnLQr3mxyF
         KMTvcBsXrKy0E4kyddL+DStyEFD8N+nHs+PvLYRejCkqI4gF4ULgojueUy6yswkz+CN+
         hybeX2OXhlzKXLRyDyx2/XVmM9FbshqSyvAELhcT4eARVIL6x1aemD2vE+EIUkv5Gnqe
         /KvwcoWL0Bs0R2gUS2WaoWHMPjl0xV/2g9gZ4lE1mNeJHizmLTIbX9eIPMi8F4PcxFbZ
         dhO/ZzNuyvQ7jT4pWdy5jRq0WCLYvc84ilZ7B8XXkrpKKVbsSp69wVJXIAlHMoiu/UZF
         a1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZo05wCyEdKBG2zJAvFGlYMjEFu5L7kgonCnefd1FbQ5iROFOVnESh+x3pCROGJbJmJyQW97c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn/v/06vsPyfmYNnXkYQL9G2B8IjmYJdQsKDQkrbhhCqqhqgcY
	eCWIBvSCoSFHFY+4PSFksAD2v2wQ0jH7LLsTEACmKtwq76ByEftrHyVy
X-Gm-Gg: AeBDievATvWLhqpd0WkZ10ol3Sf7p2cRx7Qhp0CckJYmICICx6D5JrurPC5Ts/I2GDa
	0/FnvVbFGH4O0jF3dVxrM7/g0UVKVtF89q5lFFU+u61OyRDfp8OjaXS37toUaB2mgEN1sSPSuD5
	l7sf1q2Q/WfaQt5B/weaxL0Dqz5POPk2xUt/4HHf9q9IhD4F7r4IYrcU+jOP4aCvYayewCFj5qb
	g71KuxeI4wFA0aUAeu1EGaaIuyB5xXtT9wcZLPuUjO12GJn/9mVG6FcipGfL9o1tQ8UUDANa4De
	+VmSLd0a3Qa4giHTtXN6PZku4E6LAaWzisUzCpAiGAj/GNiZGTPLnEBAW8PgEK+OYwTE684nxYM
	tjTYg9fkyGMMkAlZGuDmEBnvGpA3WaTPfn8c5r2Hs1bHEx3B9EY0woFgtwnokbAi1xdPmOe7QQ5
	bZ36dUYcoehddMopXgO562A9x17fW4BPkpLIPquuXBNpjZElmo2IgYn4/sQ9zrF8alixfntYmkq
	kausFIwqmGy
X-Received: by 2002:a05:6000:2c0a:b0:43d:14cb:8470 with SMTP id ffacd0b85a97d-43d2930630dmr7189067f8f.46.1775257640395;
        Fri, 03 Apr 2026 16:07:20 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c60a2sm18830924f8f.10.2026.04.03.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:07:19 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2 1/3] net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
Date: Sat,  4 Apr 2026 00:07:12 +0100
Message-ID: <20260403230714.10667-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275267-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A97D398EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

page_pool_create() can return an ERR_PTR on failure. The return value
is used unconditionally in the loop that follows, passing the error
pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
which dereferences it, causing a kernel oops.

Add an IS_ERR check after page_pool_create() to return early on failure.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 7b6369e43451..34bbcae2f068 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -92,6 +92,9 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 
 	rx->page_pool = page_pool_create(&pp_params);
 
+	if (unlikely(IS_ERR(rx->page_pool)))
+		return PTR_ERR(rx->page_pool);
+
 	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
 		struct lan966x_port *port;
 
-- 
2.53.0


