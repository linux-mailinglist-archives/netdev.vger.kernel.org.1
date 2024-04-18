Return-Path: <netdev+bounces-89401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371B38AA388
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A881F243F8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497071A0AEA;
	Thu, 18 Apr 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uhMMZcqR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3854184105
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469946; cv=none; b=lL5VE1YZX3ED05f4jffN2fxevYghwLVKN/1Z1V/rCZIDB0k4RxrHvtRUk8WjElzj26j+aRqVwUsVskpGJgAbW2Uiun7cXqUQBU2sIaOOHD/je1hAJLu2PkZME9tzM9wT3nPJ4a9SnCK2w22AQNloWKwa2hlIuJ7yvWiog+9ETi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469946; c=relaxed/simple;
	bh=fX+x8CrQsaBzLXqnTt3mG8Sbp1Qax3P66jmbBafpuM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EPashxvYgOGWHvAWxTcsm94NG+Fk1WeYW8ueXRhTJEO4njoKXfWwc3lK8by211Lb2Ehvch3HyNWfadipvGoubN3/CcD6Ai8u3o0RiLflJK5zC6jp3odJ6IeqHq6FbhJH/FbsFNbg9rJksClarzEeurygxCTtHrx5e1foilbsFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uhMMZcqR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61afb46bad8so17035557b3.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469944; x=1714074744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Owi9kSuMMe75HjRaXTVXfYrGrA3im1Ib/iYQuTJVLqY=;
        b=uhMMZcqRJONxOoq5HViyhvpBUAiIu3xnHctulxzgT9pEeZiSpeEn3pRsZFny21zLxY
         wmMBR/9spGnvQYH35QX2dEq5hCA9cV+7BIl8WRkPB83p/mZJft9GjjeAwPRyjqRa9bQC
         4l989NZ8prk/8SubXjk7kWSOcv5nxQDxtsX2O1RWGdiXERKO7Jn7LQMue5kqq+9FMW6W
         aiqd3Cdv8CBzd7Xm8VJxRs+apLUbJJK9aN3ZU1o4pReRxtp2nT29BmVc9zZMzyBv9zEz
         upiyBZSrMeYbW2pcvQCuMSV0Kqaj9eUOADFSMwbOxyTv/G9h+EZZ6IDoX4wMaCH53MgP
         O6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469944; x=1714074744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Owi9kSuMMe75HjRaXTVXfYrGrA3im1Ib/iYQuTJVLqY=;
        b=PLNzqySshvTaJ66uaNtOqpupOo6CiYSQ92p4hIyR6+V09oLKSsFOX1f3/zR/u/uIBN
         /ZG8Xl7VACshX6Y6+zsakRVQ3u5eFl8QsIsR3YbAe/f9FIPNyWizW9k35oOb+2VQyg3v
         xOhFqHDFaT6Z5q9GfmU+S/5jvsfDpgBJw8kfFakvExVrhdX9NRG7z86tT28y1x3XH2lq
         og38nSyacu6TtOtv2QHO0RA5lnR3eW6ci0zVaVUoe34v5o2c/W59zxrR++UNSCYoabIv
         W6IIieLRGWk+498YR+VQn9kteb+e3hB1X7SSqiJw1tJ57usuavsi6wh1AeR5ka86Cp3p
         mNhA==
X-Gm-Message-State: AOJu0Yxtq4ogjCKiH2C0zNQINKmjGZqBGZsdozyYhNy38WZYB70Xv8Bg
	lZLTsmvUBncNHyKuJLhOfVHgQzYh4J8Nnbk/0ddhc2uN0zEFLeSXrAb239DkQ38rqHxwPCgYIib
	MGZxYU2sIw4qC/dzS/8nWUlhguEUBVqqsV8OR6E3FYaNO49mZ4oEdaW+fH/5LcmwMEfhPCuxlcI
	RpTb4ghQPOREbvLVCjd9hW0LuzxtXZvT5vj3mc691LVXw=
X-Google-Smtp-Source: AGHT+IFPA9omB2ptB2ZmoHxWp7InAamOvgkLbxg+VwA0SU0N2M4S/7AUERYZGj4zWDmB6LkibeF8hkbNQG1byg==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a81:6e57:0:b0:61a:d420:3b57 with SMTP id
 j84-20020a816e57000000b0061ad4203b57mr50620ywc.0.1713469943766; Thu, 18 Apr
 2024 12:52:23 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:54 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-5-shailend@google.com>
Subject: [RFC PATCH net-next 4/9] gve: Make gve_turn(up|down) ignore stopped queues
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently the queues are either all live or all dead, toggling from one
state to the other via the ndo open and stop hooks. The future addition
of single-queue ndo hooks changes this, and thus gve_turnup and
gve_turndown should evolve to account for a state where some queues are
live and some aren't.

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index a515e5af843c..8e875b598e78 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1965,12 +1965,16 @@ static void gve_turndown(struct gve_priv *priv)
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
 
@@ -1993,6 +1997,9 @@ static void gve_turnup(struct gve_priv *priv)
 		int ntfy_idx = gve_tx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_tx_was_added_to_block(priv, idx))
+			continue;
+
 		napi_enable(&block->napi);
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
@@ -2005,6 +2012,9 @@ static void gve_turnup(struct gve_priv *priv)
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_rx_was_added_to_block(priv, idx))
+			continue;
+
 		napi_enable(&block->napi);
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
-- 
2.44.0.769.g3c40516874-goog


