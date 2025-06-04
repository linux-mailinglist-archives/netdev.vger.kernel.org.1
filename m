Return-Path: <netdev+bounces-195146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582D1ACE5B3
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 22:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623FA3A96F4
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DF1940A1;
	Wed,  4 Jun 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQftJ4EJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF76F2F2
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749068389; cv=none; b=Wrf8zj++KP3dPQbTXKFGZf89FeK30VBqmGyFd3Xy287ZiN0OkqaWyPxti0BIdLGV3wwvNUnnMlp1GqqetfghpFEjrfP24CUywh5wr1oJnj1bXKC6k0pNskSEbMGqOnw6+ys8uFwZV3VWXrfDxQhFZPRPWE7TRaZrwEkFrb/32PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749068389; c=relaxed/simple;
	bh=tAtxHC7qZ7jeSHnLePLhJjlc91XZnhHCHLoD7E41dog=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MEzw8fHYasEb1MY9z1tLzgOH6/usgjxjqK1LNzIFgG9+31YDUmXBmEaAHCZeCc27A2ka3pwQsmlEdGEh9Scx2+AXOGOF9c7IGiflNYo4CZ5Y9K6ebj+B6BifBBEPOLNdcuDaheHhkiuiDewY5us2NTgw5Sdiu5sC7/mBJQejYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQftJ4EJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747d29e90b4so212712b3a.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 13:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749068387; x=1749673187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P60/9rRjl/n0+ugli5ZClLozb1vi4680ihN8tmN7rvc=;
        b=NQftJ4EJXW8gN0pBerUozWf0IY8cQz5R82SDidbzZ6oNaVd7dETyoutiatgX69YJgx
         fxUVmdGQvqpFhq0CkhXSSJap3sQD3TDpC1oQqU7jcV/Tj8luS3KLyEZ71MgxPVFaT0Ir
         0R1ZUOc7SmP/9l8gDkP9KK7z2/ygwmJ+LK9UYgenZwzYsHdT031Um+LDgLd/huuAWgXK
         UiXy2AmrKFkuRBH/czEKzNo05+iSSiAbL7CufWQRoEeQ+5b6NSA59QK9Kzs5DP5m7919
         HMsVVkcbAwvPfgvub0r4/wmCUXV1qdr08MEfYbCcHwNsNH74lNVJUczero4T3kkPBXYY
         iOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749068387; x=1749673187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P60/9rRjl/n0+ugli5ZClLozb1vi4680ihN8tmN7rvc=;
        b=EQU6O4p2qP1l5fVDEeGV2RyU+UT4oDFJrFeH4EuNZIEl0BAlDcke0YfQm21kD6t90s
         IecxyJPLG1EtmMmcMIeJDhFGD45mMD2da3QiIdKAYvzs5+sNIR3nNsvS2zkjf9hxFPEZ
         B5u88aD0nGbAw+9trpfACsZw92JbHrwlgb8q2ubcucfRVqDiD1Qni8VQFdmhI3I7vtCW
         35plp/zMGArl2LP1ZtKPucqPReXzIy0eFMVxqZN9MRGF/CdrTSTHX5hxqFcSUI9N+RL6
         +vjwnSS2+086xB0bXHxzM0a2XK/IndAzJndJR5/a9UvqneYGT2lzQA1v1VmSHiAN7wct
         c+kA==
X-Gm-Message-State: AOJu0YwSY7QRB5VZqMiSj5AFmdr/a9hy6rbKmPZn1b8C4jAIuED5po5p
	3EERNQWPMLghHz68iaZY3fvoiWc4qPG9QOxPehCRabYn817g4JI+DnrSc8aJCLF2DAUDYh6RMmL
	zcYq+KquUcn2X4hJeULUOBFj/5FaKOuEKpYJ25REREN+u7QirTE68aQT8H35CD3gCX7fNMZl10d
	OXW+YnLvopOnQ4QTeDfbyNb7NdfIwtEFIVJQ8VnNk0bo8cSHA+e72syPkOTIGBYjk=
X-Google-Smtp-Source: AGHT+IGwdJMuQrwY53X+i859MrqAreWMi6S6yxe7x3iwv7BiRCwF47VgcwDIpRVNYc5qyOGVVzWpTKTh2aB7BOoHMA==
X-Received: from pfwp30.prod.google.com ([2002:a05:6a00:26de:b0:746:22b3:4c0d])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c85:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-7480b42473cmr5159660b3a.15.1749068386754;
 Wed, 04 Jun 2025 13:19:46 -0700 (PDT)
Date: Wed,  4 Jun 2025 20:19:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1266.g31b7d2e469-goog
Message-ID: <20250604201938.1409219-1-hramamurthy@google.com>
Subject: [PATCH net] gve: Fix stuck TX queue for DQ queue format
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, pkaligineedi@google.com, 
	joshwash@google.com, thostet@google.com, jfraker@google.com, 
	awogbemila@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Praveen Kaligineedi <pkaligineedi@google.com>

gve_tx_timeout was calculating missed completions in a way that is only
relevant in the GQ queue format. Additionally, it was attempting to
disable device interrupts, which is not needed in either GQ or DQ queue
formats.

As a result, TX timeouts with the DQ queue format likely would have
triggered early resets without kicking the queue at all.

This patch drops the check for pending work altogether and always kicks
the queue after validating the queue has not seen a TX timeout too
recently.

Fixes: 87a7f321bb6a ("gve: Recover from queue stall due to missed IRQ")
Co-developed-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index c3791cf..0c6328b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1921,7 +1921,6 @@ static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	struct gve_notify_block *block;
 	struct gve_tx_ring *tx = NULL;
 	struct gve_priv *priv;
-	u32 last_nic_done;
 	u32 current_time;
 	u32 ntfy_idx;
 
@@ -1941,17 +1940,10 @@ static void gve_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	if (tx->last_kick_msec + MIN_TX_TIMEOUT_GAP > current_time)
 		goto reset;
 
-	/* Check to see if there are missed completions, which will allow us to
-	 * kick the queue.
-	 */
-	last_nic_done = gve_tx_load_event_counter(priv, tx);
-	if (last_nic_done - tx->done) {
-		netdev_info(dev, "Kicking queue %d", txqueue);
-		iowrite32be(GVE_IRQ_MASK, gve_irq_doorbell(priv, block));
-		napi_schedule(&block->napi);
-		tx->last_kick_msec = current_time;
-		goto out;
-	} // Else reset.
+	netdev_info(dev, "Kicking queue %d", txqueue);
+	napi_schedule(&block->napi);
+	tx->last_kick_msec = current_time;
+	goto out;
 
 reset:
 	gve_schedule_reset(priv);
-- 
2.49.0.805.g082f7c87e0-goog


