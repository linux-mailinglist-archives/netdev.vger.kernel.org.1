Return-Path: <netdev+bounces-92641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6278B82EF
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB761F23AEC
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8381C0DF3;
	Tue, 30 Apr 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="35t2m31k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4421BF6F1
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518884; cv=none; b=TxuiJPmYaSYxKfNxTB9RJAOQQmdFmkmW4HPjH2X+xHEduHEI6WGylIzmnSX8SHXRH6MCsVbhKpJcbGpZSrKF4PwY71N1CY4g0AcjFSrhR0hpzJxj0iojo1tDVOBrR1Fy9HRMR8I9GbC4AsZiD4IajalDj0U2Ia6hIeLesmGo7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518884; c=relaxed/simple;
	bh=q/x8uhyZ94hlLMU9upc5dvBwc1c1qlWMRkNRfbt16WY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fUSsFtQE1nt1/hlG4xCezsTCWcH+R12mfePYVki7fLPAxAOQoBQm99LIjdJDwS9xWHeVLXphWkYxfr7Chzk1p9RsyrKeOuLGu5iewg4+qnf/rhzt9M5KXt1g+sc1oL1uFYhkFS5Fwx4VfQRt0pGfBALTUQOV9v/ISGv5RTFNTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=35t2m31k; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be325413eso4448777b3.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518882; x=1715123682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPcGdWtYIxokvDL0AKkLOB+K3RyNfXxAC6Aj1nMvXi0=;
        b=35t2m31kbZ4Ho8odwy2woHWunIz2RxlPgOgWFRvRYJdSCOXQa2jxcsmp1EWwmmZr9M
         xTFHVZAE7/YFWQrU0ECHIS941KY8SYOcgnIVTeQzpEX/optwBgr3zRfcuCPhwMYVo1CV
         D0nQy40bzjvNWqte7aPsAaFl1ZtiVgpSC7arDqbDiSWIAcB+k9CvpuL/yHTRzFYy1ZOp
         KolpyMbo6XrVEKM1A0VaJQfN2ZUttWS3AmO+tEYNJfLgfqGjl8T6iJsw7AnmD01a9Z2k
         OiQdoIKy6uQaRsbs+wE+igarlYwPpBcf/1U0wcmpDakP2tlixwBOwOpXVMLJxG+WG+hX
         nAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518882; x=1715123682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPcGdWtYIxokvDL0AKkLOB+K3RyNfXxAC6Aj1nMvXi0=;
        b=MJ88WGEME5wxFj8tiIVdNv0VJ1u4OfVS9bSa9m5a8gL3lMN0GRBIKrOaZ5QtyqypV4
         xdczqumXm0PQmNLeW9+aG4NORzl5y5XK+Dy1zZuK78ypkQR5X4etr7RT4tzZlepSU+5s
         yL6ZsS2sucAI+NkJ1c1Gcme0RlHAsxvIRWKnW6BRtHHHBD51MKr8wYGHwuGtOre2whSf
         qoaql3SA7l05fKA4ak659N+HPDBdTkguiqNCa6YsXYQM8QBMJr2+W2RecRV3R76b2hZS
         LKHc3oZaUd/4rAvRfL/cqALzQCHU6/NSQwqOGi726l84aUmuXlAYRaV4a2HYrC3qhHIE
         JO8g==
X-Gm-Message-State: AOJu0YxuixFk2uHAt/aDXLvQw3kws1Rc5aDvXLEDFItsi+p1NxYk+6Ia
	CRI9TyhHqxYJ5tz9f67j/ApzxZ8QkJgRvGhSJD1gZN5XSsAQyUgxINYjapvH2pNL9w64kczkHXb
	XVPuoc7R1pNTiXC2g41kY2IxnG0yAJSmcSZcON4Oq4nNrkPvUaWsg8+Yievt09FOxCaAdIaUwts
	GvPMTPIdNfY7N0tbJvOW5qSlovCP6x2qgL59a8s5HapF8=
X-Google-Smtp-Source: AGHT+IGOYw9lWR8r9mRAMIvzGVfw8JHbSFX+TxGChD6spEfwPVWuGRycQxe/qVeloyNZvRpBzOakaPCNqzAXWg==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:d609:0:b0:61a:f3ea:3994 with SMTP id
 y9-20020a0dd609000000b0061af3ea3994mr882152ywd.3.1714518882112; Tue, 30 Apr
 2024 16:14:42 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:14 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-6-shailend@google.com>
Subject: [PATCH net-next 05/10] gve: Make gve_turnup work for nonempty queues
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

gVNIC has a requirement that all queues have to be quiesced before any
queue is operated on (created or destroyed). To enable the
implementation of future ndo hooks that work on a single queue, we need
to evolve gve_turnup to account for queues already having some
unprocessed descriptors in the ring.

Say rxq 4 is being stopped and started via the queue api. Due to gve's
requirement of quiescence, queues 0 through 3 are not processing their
rings while queue 4 is being toggled. Once they are made live, these
queues need to be poked to cause them to check their rings for
descriptors that were written during their brief period of quiescence.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 469a914c71d6..ef902b72b9a9 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1979,6 +1979,13 @@ static void gve_turnup(struct gve_priv *priv)
 			gve_set_itr_coalesce_usecs_dqo(priv, block,
 						       priv->tx_coalesce_usecs);
 		}
+
+		/* Any descs written by the NIC before this barrier will be
+		 * handled by the one-off napi schedule below. Whereas any
+		 * descs after the barrier will generate interrupts.
+		 */
+		mb();
+		napi_schedule(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
@@ -1994,6 +2001,13 @@ static void gve_turnup(struct gve_priv *priv)
 			gve_set_itr_coalesce_usecs_dqo(priv, block,
 						       priv->rx_coalesce_usecs);
 		}
+
+		/* Any descs written by the NIC before this barrier will be
+		 * handled by the one-off napi schedule below. Whereas any
+		 * descs after the barrier will generate interrupts.
+		 */
+		mb();
+		napi_schedule(&block->napi);
 	}
 
 	gve_set_napi_enabled(priv);
-- 
2.45.0.rc0.197.gbae5840b3b-goog


