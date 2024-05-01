Return-Path: <netdev+bounces-92855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654698B9255
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941AB1C20D7B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F4168B09;
	Wed,  1 May 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22QBXuT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EDF168B1A
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605966; cv=none; b=dyDg5+0tEu3205OqYzgCrmKc0FBl5UVRebes/IOBYdEcBpiOSSFsMEP4B9kEhLbd3ensayl9nzz+3mdV61oMvkPCJAw88ITOb5vITdgrix6AXH8PR15r/srArg3uMClD/rd3sHnmhxSIkxZ22dmtGUDg2IHcxU8gkspiTnUCahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605966; c=relaxed/simple;
	bh=eIqn1LVUwugkpeRlzua2n5lFrHJQor+qYee1aB04brY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mFi952Y/bGpZFRWpZNV0Yz8x+Sy8zSJT2cwAg+LTFIxYvdFeeqZ1wpeN1cQTynhzRef3/nw/qF1MHyBWPmZUEEGeEulBLqVaPGTFLvBVFMk05AKW4pgDL2pXK61reQwd4rfQBgPwCOTSqBYu4rn6eerknZxzV/GsbhIY2oUEigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22QBXuT7; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so17099960276.2
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605964; x=1715210764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4HEYwsHS+rl8A8xVeENYauPKI62gnoZdac5LeFbE4=;
        b=22QBXuT7Q8h74TJgW1xXzuGXTVdgzKCFE2Ez6du1r758VVsYglJC5B3sHlG3SNN70C
         okxBiXdiB19v6KSlxHnbxSgEgEpf6P6ESud8EuDLgH2fbx+QzVpFeDs1ILtpmZaQ383U
         aKIGXEskBe/UiZV23DpmfRyuOLIqMQEQrK5KfdZpUd/n87TUflfIGsRGh8E2yHEe5vTx
         1Zq13YxRH7bzRRcgcdMRCQptIkm4ylQoxibk+IGBIc7tL9OAcxo8Rm7oJm5HKaCeNOK8
         Fkgr6J+qtiRMXG+vdeh2rB4mU7WqaVi4lCrif398EH/CAYYhSofhucH85ORvxjrJlaoD
         gl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605964; x=1715210764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4HEYwsHS+rl8A8xVeENYauPKI62gnoZdac5LeFbE4=;
        b=HfNHzu43N29SbOwp80kl6rxBtBvl+lBiRddJpbd5yrG+KlSL5duNL/V/i+O5eibFUR
         61NHKvBg7E4tE1dgyGuZdWOltZjvecx4u1KQ6cGslo7q2mmdbyy9x63nO76jS6ToRh4P
         FElpwZjKgY1XLULhNCI5X36QpNun159MxK+UQ55KqamiXfrWR4VUYtaVG9StBuqqK5dg
         gjOfApWnzepRHq73jndjlwcWimB/WLUA5uzczxa6bp3e4ZXAOrNfDbXCmV7NzLUQY0Ne
         XZcZ6bSpQgA1lP9ez6HggPTDiSRvk7QT02l6F5hxRkzE+56mBPG1FKbCwIWivUBsCx3O
         ysHQ==
X-Gm-Message-State: AOJu0YxkKfktoBauw1XlEjY0Gw+gRujmPIcwfZpe66M23EIdg594KO8G
	75RtWhrgy4a7PyBiT7qFypF4UbgsrrOiig1UpeeaE4Kg0MO5fHWp14/714PAX/g9KtI0KIyd8cl
	2wf1wP5mIiBPScLegkY7jCGZ5ggirD5kIw2IjJ5YOWooXkFOoV/S03AGj+llk5FON2Di74hUQWY
	lx9CA/DQlGmguiyQHzFdsfD4tg4c4PkGnkTn1ViXXSXD8=
X-Google-Smtp-Source: AGHT+IEIVqyRAB8Dn97W+pngBZnoBZdBoIYE7C5UKVOkLrFaRTk5Vm1G5xdb3tTVYR+rAwiVZnHW8ExzbSdsnA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:1505:b0:dc6:fec4:1c26 with SMTP
 id q5-20020a056902150500b00dc6fec41c26mr88185ybu.1.1714605963770; Wed, 01 May
 2024 16:26:03 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:43 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-5-shailend@google.com>
Subject: [PATCH net-next v2 04/10] gve: Make gve_turn(up|down) ignore stopped queues
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently the queues are either all live or all dead, toggling from one
state to the other via the ndo open and stop hooks. The future addition
of single-queue ndo hooks changes this, and thus gve_turnup and
gve_turndown should evolve to account for a state where some queues are
live and some aren't.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 61039e3dd2bb..469a914c71d6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1937,12 +1937,16 @@ static void gve_turndown(struct gve_priv *priv)
 		int ntfy_idx = gve_tx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_tx_was_added_to_block(priv, idx))
+			continue;
 		napi_disable(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_rx_was_added_to_block(priv, idx))
+			continue;
 		napi_disable(&block->napi);
 	}
 
@@ -1965,6 +1969,9 @@ static void gve_turnup(struct gve_priv *priv)
 		int ntfy_idx = gve_tx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_tx_was_added_to_block(priv, idx))
+			continue;
+
 		napi_enable(&block->napi);
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
@@ -1977,6 +1984,9 @@ static void gve_turnup(struct gve_priv *priv)
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_rx_was_added_to_block(priv, idx))
+			continue;
+
 		napi_enable(&block->napi);
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
-- 
2.45.0.rc0.197.gbae5840b3b-goog


