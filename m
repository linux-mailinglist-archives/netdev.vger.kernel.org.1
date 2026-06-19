Return-Path: <netdev+bounces-300646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9X4MMQ72NGpjlQYAu9opvQ
	(envelope-from <netdev+bounces-300646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:55:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEC6A4779
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:55:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dcb01x2s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300646-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300646-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDC4E300AEC5
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF131D72E;
	Fri, 19 Jun 2026 07:55:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135E1FA859
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:55:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855748; cv=none; b=pEBVS0sJLw/jbfTzCQovfJHVufFBVR3W1DY1r4/oJijgBfI3YdyYwrYc7PeffPCnmz5N5D/trUNipk1Lp05MRT/9PjNx60Rh8Q/lzU0TEDcL53iwui4UkdDT3/wrZPDxahV2IroVua516voc3unrG8gi1fPYsWAZz9BuipKmyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855748; c=relaxed/simple;
	bh=gQUr/rkEarrMSnvgduZt2Cb1BkgNLCpooiBPpcm1k48=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QHUpLkfK3RLLrcnOZXyQ1tisVhPbkJWbFvvrM3odrnShptr0NlQiTMzGX9PtMxUWYuYJFFRzFPcC3DaMbG0YrHdXqN8k0VZV7j9whNAfq+aADkjZZbLChpaaIj/Ap4EakenM7HN3psNhToO6Gisjc9gkJec5sWTKF3BpFkrAvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcb01x2s; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c69921bd15so9173405ad.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781855747; x=1782460547; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ZZlyfradZl+5Bcnl/kI9msiyohlupRsBccnKU6QuBU=;
        b=dcb01x2s6KffqLH5tcfe9sBqC2MzwAyaCXLDk+A4FQanETlpHYYMtdomRPDsuwDmDy
         EB5kIOxf0WtsUX32cGIKp/gnpVIsAHXhNPmRm9P9SxCGrAQSweywR4Ks9vWLZUfgJqGR
         mEFTTN/yAyU/uw9Jhn3nmUuvO3XazWJy2qJlQHCme6SCXYqLw1OD0oPdRTwsguzRH7f7
         BjYhIXwY0tlQAryQGS0gWDD0sDkcL6V+5KXd2uMfB7yyptNioPwXXv3Ovk4tP5tPm0+5
         4L3iqcMuqqSqzyGtcmmNl16Y6SQjjCBHmqlJkxjA+iHIDodOFSL/sHk9Z3otAJemtOVX
         G9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781855747; x=1782460547;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZZlyfradZl+5Bcnl/kI9msiyohlupRsBccnKU6QuBU=;
        b=azbBL7SxEC6ucHAYcHTLYVitV6fidS9C1FFfWh2nLmViVbrhPvHJn/+SVjo1du957Z
         pA3idU+Z2q9rdysHLrdx/rp1VsHwpl/veRvf6LmXTopySXNVdgyw04EqqqJeBZGWBCDl
         eDkeyHBtiizM8yUdi7jUgunLLCao/KFW6vZngBUgWzFJ6EDPYhfedpKYCJRLGFZMrqCc
         mj/EqgTn6up4xxMgjf/bp4eiQbTOAxSQjHuzC8Nd3/d3ps8D+CgCbVZqFvnPFQWR2Q0a
         ycX7y8u9yZvYh6I7rhiqYsYber9z8gjqEU5pMDqxVl+aJoSI4ZqO5NMdCndjOYKXLrbo
         hmcg==
X-Gm-Message-State: AOJu0Yzrp3Gy9yYWF9/QF7/cV8d7TErgDf2ampsvKM11mqzlJHgtWK7m
	gihcBVJARhJD3Nj8TVRo7cqd5TqIYmv2yhpQtzSOASsRnD1EcFwxqi9GgprMLI7yc8o=
X-Gm-Gg: AfdE7cnCN0G3KA0F89AY/uzCpp7KD9Vkt5e0WWKX3fXAtOMijI5aOD4P95OSw1pXn7X
	M1iFc11X5mhqzmP/TDgytMeI5/VDEnW5N2N/LSpnv5SWbX20kreUv334CjqYz8GpRO7mrsZrCoV
	XXJZ28pUl3tvaUhua4zhgul2CzEYzx16rP8lf7qDcCkrmwIVn77kqeAShRyJjLp51ZKWkGq0Tr+
	vsR9VCnJu5jCkq2Nxh5OBcpDOIDEZ1yUVtyWtyWdq8aDh2eO6p1M8wDUJ/XKdKMYoE5bjDMlMjR
	vBz8GgFzFhkHu2vqdwngF6QHdICSwOuG6Oykxp4fNZaiW1x1bR94XGGYCjWszXUR+bPFVyMffS2
	PY+k0/K6mAF3UaYE2/lxeaoWJ0lJS+SfaTa0hlgriu3ZxIYgx6QKFPRcKP7GQ95c9GziO4mOM/U
	R8hvJQDI1BdRfsNqn4
X-Received: by 2002:a17:903:1ae4:b0:2c1:ed61:36ab with SMTP id d9443c01a7336-2c718fe57ffmr29966425ad.19.1781855746746;
        Fri, 19 Jun 2026 00:55:46 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c720a1968bsm14892245ad.72.2026.06.19.00.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:55:46 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net v2] net: airoha: Fix TX scheduler queue mask loop upper bound
Date: Fri, 19 Jun 2026 15:52:03 +0800
Message-ID: <178185574223.2378148.13454900445528174929@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-300646-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EDEC6A4779

In airoha_qdma_set_chan_tx_sched(), the loop clearing queue mask was
using AIROHA_NUM_TX_RING (32) instead of AIROHA_NUM_QOS_QUEUES (8).

Each channel has 8 queues, and TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i)
computes BIT(i + (channel * 8)). With i ranging 0..31, this causes:
- channel 0: clears bit 0..31 (all 4 channels) instead of 0..7
- channel 1: clears bit 8..31 (channels 1-3) instead of 8..15
- channel 2: clears bit 16..31 (channels 2-3) instead of 16..23
- channel 3: clears bit 24..31 (channel 3 only) - correct by accident

While BIT(32+) on arm64 produces 64-bit values truncated to 0 in u32
mask parameter, the loop still incorrectly clears queues within the
same channel beyond queue 7.

Even though this is functionally harmless (the register resets to 0
and is only ever cleared, never set — so clearing extra bits is a
no-op), the loop bound is semantically wrong and should be fixed for
correctness and clarity.

Fix by using AIROHA_NUM_QOS_QUEUES (8) as the loop upper bound.

Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Wayen Yan <win847@gmail.com>
---
Changes in v2:
- Add Lorenzo's Acked-by tag.
- Clarify in commit message that this is semantically wrong but
  functionally harmless (register resets to 0, only cleared), as
  Lorenzo pointed out in review.
- Rebase on current net tree.

Link: https://lore.kernel.org/netdev/ajJIWMs4dVbfkHZ5@lore-desk/
Link: https://lore.kernel.org/netdev/CAL_ptrs6J3Ryw_4mVTq5VgzkB4RreF5S0huHyLvd9YwWr1m6jAA@mail.gmail.com/

 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d0c0c0ec8a..ca77747b44 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2212,7 +2212,7 @@ static int airoha_qdma_set_chan_tx_sched(struct net_device *dev,
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	int i;
 
-	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
+	for (i = 0; i < AIROHA_NUM_QOS_QUEUES; i++)
 		airoha_qdma_clear(port->qdma, REG_QUEUE_CLOSE_CFG(channel),
 				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
 
-- 
2.51.0


