Return-Path: <netdev+bounces-281436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JR1GAqh72kcDgEAu9opvQ
	(envelope-from <netdev+bounces-281436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:46:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A1F477E1D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 19:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADAB0300AEEC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D43DA7EC;
	Mon, 27 Apr 2026 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJMFnIhX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A338B146
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311974; cv=none; b=DhNtxVYVSah/h2EvCAAZ4/n/aExy1PEv8UftzMTaQmIXMKrxqfCW6pb5Itz8EshTuZF9ZI4cXbAcjwYz0TDUW4wAyXUJ2ppeFMEhcJXWc7QFgGKoHCdzgRen1ofmM/Qnl7ocA1sxwOVEtT80NiexSPpKFSVgXPfUFyKv8YyGfAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311974; c=relaxed/simple;
	bh=7Y3TJuZg/L0ifkW1rtLCRvc0YmCGJffnw+RQpsp3yYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFIkrIlaYbobV14zldXdo+ycI39pUuEme9S65+IJNx+Vkj9O3vvAhJYMRixRIqrjnWaYAJnh4b7+c8g9ZtdC614URbIuPoNyI0qSRZOjy+JueXTKn8BKj3vB0ovx5CVQo3R5oHgvs5Cg9K3yMQiE5Q8kYBH7/m1ccxsfdnMNoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJMFnIhX; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7b248750279so102254717b3.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777311972; x=1777916772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6R1SX8mfYaQyk9uLV5N24I5+ak1Z8uoCYi8CcuK4+lU=;
        b=VJMFnIhXiTOjIVT6nicSPDuyVDEySseMh+P2MLkXN9wT+bc3usz+ws8G5JDZw55iwN
         HLBJ0oPz6XefpoD4GFpnT65lT8nzYw+zVtkHxhWAgJIG+x1aZayU2Knp7tBgAXyvDS7S
         q1f7SKC+RoOHsGp9aPfJrWYWqdkr4It1lm5y8zcOFqO05y3aHDrROxnTiBlVtt/7DJgf
         uWi+ydkjMc3uS29RUnLDW2vwV5/tk47U7RqRfjRB3QxQNC0uVX+w3vmcSs/pPQq6Eafx
         DrY+5WL6Um+VZ0T//1sD09fAsjoHuBcOTLFwfZl6QeugyWTK9bFViEuidHMlY7LGVV7x
         Lpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311972; x=1777916772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6R1SX8mfYaQyk9uLV5N24I5+ak1Z8uoCYi8CcuK4+lU=;
        b=pGLghwd1RxGY/HYXIKIVCxqH97eZwuGEhYj4D/F/CBlnJyyb63Ea9X/WNgJzQTp34U
         63jChsetfhX+5ZEyHajQa+JBZ8kolZjQiO/CgVgXo0xG3X2dNaWBHO4qgFkrUgOqjXTF
         nXIKhXZcr8TnRmb62lalKPWaDTwFBzUx+g0rnjZm4Tpj/cx1sf6G53vwKKKTo3+CBF2v
         m0hVJVkwmqu0lORsYwJSJn/sqt+ckvOeH9XdBdYpolf9vZjPPgDmDNnlvBET1nqqFQgq
         gcte7OxM6FrR2Fa/Czxk4ETQzr2a9zJzVrd51gBlF1mH70IwrbSYz2fL5UFmiZ0lZP9X
         4/UA==
X-Gm-Message-State: AOJu0YyqvI/r4LklaSWRRg7+//xuJigIZCcWMZzFLv8ra8uxEiG7I0we
	HZAgzMYwonJHgvkvf5Bo6swlmVF2Up8yPA58mpMCDRND5NvUQVLiNhgjvkO2shFr9Tw/BK6D
X-Gm-Gg: AeBDiesSFFb8rES9/gVcOsioT4j767FWu6kNhBLR7sayMuGlUxOHdt2W5rpudeoweOO
	AGk1tI75PKAkRhPznVXBBQwbs8tuS1kgDKJL3hT4de5YLlW0TCplYRONVoe8vtv9tdUvBTUG1Hx
	yqxkGgZkTKnbRO3LeKB9Y+BdREa+YsRnF8avsZb7CKLNsLL5JRC4vsPS5ScLYrqfSy3L2BcpZF5
	ITrhvpD0uD4dG6vKSdzwj3vUnkh9DxKsVqORvuMUf+GALSSx+G0osg1m9+YGZ3mGbUUnEG7nTkW
	Ud9ATFSTl2o48qcJZJwdmrLiHuHOmRncO1a7JKlBkKSSGUxtd6wfLc/qQarxw1QWN3qHsO4V+pL
	08bkXe1F8e3Rzwz+HfiXrInzieVQtO16aGFJP6a5Jpq4RkV6MgRjG0eeDIQbnMYvmd7jH34W6gw
	lVA0aNEU8m2rxWmgkc5GJcI+YvMcmUHR1CIMZhmDjw5QXZDFPaH35SAieWGaIeGozPEtts/wv/D
	vA=
X-Received: by 2002:a05:690c:e3e4:b0:79f:7972:f89a with SMTP id 00721157ae682-7bceddb893amr2762777b3.28.1777311971711;
        Mon, 27 Apr 2026 10:46:11 -0700 (PDT)
Received: from localhost ([2600:1700:3420:b5d0::45])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf04bf362sm80467b3.8.2026.04.27.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:46:11 -0700 (PDT)
From: kernelcoredev <sonionwhat@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kernelcoredev <sonionwhat@gmail.com>
Subject: [PATCH] net: nixge: fix skb leak and missing bail on DMA mapping error
Date: Mon, 27 Apr 2026 13:46:07 -0400
Message-ID: <20260427174608.8201-1-sonionwhat@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0A1F477E1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281436-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sonionwhat@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When dma_mapping_error() fires during RX buffer refill in nixge_recv(),
the skb allocated by netdev_alloc_skb_ip_align() is never freed, and
execution continues writing a corrupt physical address into the hardware
descriptor ring.

Fix by freeing the skb with dev_kfree_skb() and returning early.

This was tested via code inspection, as I do not have access to the
hardware. If dma_mapping_error() occurs, the current code continues
execution, which can leak the skb and program an invalid DMA address
into the descriptor ring. This patch ensures proper cleanup and early
return on error.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")

Signed-off-by: Bentley Blacketer <sonionwhat@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99..b64e2f355 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -645,8 +645,9 @@ static int nixge_recv(struct net_device *ndev, int budget)
 					  NIXGE_MAX_JUMBO_FRAME_SIZE,
 					  DMA_FROM_DEVICE);
 		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
-			/* FIXME: bail out and clean up */
-			netdev_err(ndev, "Failed to map ...\n");
+			netdev_err(ndev, "Failed to map RX buffer\n");
+			dev_kfree_skb(new_skb);
+			return packets;
 		}
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
-- 
2.54.0


