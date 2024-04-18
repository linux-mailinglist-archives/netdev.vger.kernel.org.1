Return-Path: <netdev+bounces-89399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374E88AA394
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83FEB29AD3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D363199EA7;
	Thu, 18 Apr 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+Ibvbp4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B01184105
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469942; cv=none; b=eI5gRSedATb+mf4NIM1XwSaOfiRosKfy/KAJh+L+sLWNs8Rec1ZbUT2MkP/+zI9Bm3NO7/fkMTc+ctpj/nTM/UPgDpmDtZHKJkSNBqQrgOrmiQdkZPOwkkK4AoRFzgrU2o4syiWulIeDSRXxkg0upPJzoYuKO+Wio861vI8v/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469942; c=relaxed/simple;
	bh=xICIZheVqhAUi0wzN0qIadCMswo7huAdA5CoSJ6L8HI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=po5TgNFucO5IeWj62HW3xKiZRhvPvcVTpEXTooO5RITRgde+px0t2D7qFTdTMiBIpyQlH47Chebkhw52i0oQ6nAAirYPRYj4zFkJBoPfr2lXAUvd8IwDeYnOeIECj006kvn1JT2NdPEMeSNYj/L0DCqRamU9cW3EZZVL7HF0qgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+Ibvbp4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61892d91207so22814987b3.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469940; x=1714074740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiKjM1W5A/xCRI9EhygNuZ2ckww6/WdQJTgN8XyXsLw=;
        b=b+Ibvbp40tmiek3bA/kHadG43yxoKStH4saagkzDFON3w3nwfI1GV/Kgay359CZgIu
         Y3Vmkqxfu/AngslFUWij6DXbkJ6NWboK8lmXnbW4gQEFdTK0XnfaTtrESvluEBC51xmL
         usCozOVjf54S4kvt+vcZ7UoAvdZfEQw++p2sNzVw+kI/R0Y8P6uf4cpr2j8pruLcz/WA
         zGczT6DshOXXgH2LNzhw2fxAXZjP40QsvQa4CeRgzP8GoSKLm0oX7zCYIJJHRZPQ4pxX
         74j4b28iTLZ3E1iQ3ZADrxhKFLiiMbaWtk2oKOziyLjW7T2jVxKvL2Rp19GiwgSd36mX
         Hs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469940; x=1714074740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiKjM1W5A/xCRI9EhygNuZ2ckww6/WdQJTgN8XyXsLw=;
        b=dHWL6olc031ssXV6O0YbzamwXA95MMFu+9G6+uWTHjxuKNOQP1UZb6p5bqqLKuQ15N
         0+lHOqdn2RgXRqCXMIoVsne0kk60l/VFPvkJHz4XezjDawHZpZzasjKt23Ltf6wAmu+h
         nxqdzwLUOwie4ujUtY/LCdVfRYtPKciuJpgbspaC54rMha6fuO4kMN6kH7MAP6JtCwzW
         MHgDL0bbzIx6WfSuqedr+74dP9ngFYx9kAOhRtndrT4BszIjrFSfReoA2qpmurLcsWF5
         X25b4DND4ZCoKpYvFusLdKsgFOZIhTW9uS0GfCykneB9JoUNvqz80me75xAlTO5KYi0a
         3uhA==
X-Gm-Message-State: AOJu0YzpkjUp6Hcpt43LbMyF4kQMMRKp+6xnAXAb3Vhs/wm8faGgUXX5
	rQy7fYhF/klqxuBt7F7fbYs3qLKF07E+H8Tj+KuGTlrp9W2UsFr+cfP5csbHyeSfa+tSKkv9Z4K
	QoicBKnhLsm7KrLbk4M5ggPZlVUpXczFde7Yed058i2YdONJ6kenutmBD8JuvtVulLQWEAq80SE
	SAcFoxZuoeaMfDKQClQ9521CAW8a3ZtUgwgeMmXAuXaoA=
X-Google-Smtp-Source: AGHT+IFenVdYIBSfR40UZoYTgQ2dq8ytqg/m610Suv9naVUlIplsK4yVquQClt7mTMaKKjpV5K0+B9+Xr0ngtA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a0d:d047:0:b0:61a:e319:b0 with SMTP id
 s68-20020a0dd047000000b0061ae31900b0mr770416ywd.1.1713469940316; Thu, 18 Apr
 2024 12:52:20 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:52 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-3-shailend@google.com>
Subject: [RFC PATCH net-next 2/9] gve: Make the RX free queue funcs idempotent
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Although this is not fixing any existing double free bug, making these
functions idempotent allows for a simpler implementation of future ndo
hooks that act on a single queue.

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 29 ++++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index cd727e55ae0f..fde7503940f7 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -30,6 +30,9 @@ static void gve_rx_unfill_pages(struct gve_priv *priv,
 	u32 slots = rx->mask + 1;
 	int i;
 
+	if (!rx->data.page_info)
+		return;
+
 	if (rx->data.raw_addressing) {
 		for (i = 0; i < slots; i++)
 			gve_rx_free_buffer(&priv->pdev->dev, &rx->data.page_info[i],
@@ -70,20 +73,26 @@ static void gve_rx_free_ring_gqi(struct gve_priv *priv, struct gve_rx_ring *rx,
 	int idx = rx->q_num;
 	size_t bytes;
 
-	bytes = sizeof(struct gve_rx_desc) * cfg->ring_size;
-	dma_free_coherent(dev, bytes, rx->desc.desc_ring, rx->desc.bus);
-	rx->desc.desc_ring = NULL;
+	if (rx->desc.desc_ring) {
+		bytes = sizeof(struct gve_rx_desc) * cfg->ring_size;
+		dma_free_coherent(dev, bytes, rx->desc.desc_ring, rx->desc.bus);
+		rx->desc.desc_ring = NULL;
+	}
 
-	dma_free_coherent(dev, sizeof(*rx->q_resources),
-			  rx->q_resources, rx->q_resources_bus);
-	rx->q_resources = NULL;
+	if (rx->q_resources) {
+		dma_free_coherent(dev, sizeof(*rx->q_resources),
+				  rx->q_resources, rx->q_resources_bus);
+		rx->q_resources = NULL;
+	}
 
 	gve_rx_unfill_pages(priv, rx, cfg);
 
-	bytes = sizeof(*rx->data.data_ring) * slots;
-	dma_free_coherent(dev, bytes, rx->data.data_ring,
-			  rx->data.data_bus);
-	rx->data.data_ring = NULL;
+	if (rx->data.data_ring) {
+		bytes = sizeof(*rx->data.data_ring) * slots;
+		dma_free_coherent(dev, bytes, rx->data.data_ring,
+				  rx->data.data_bus);
+		rx->data.data_ring = NULL;
+	}
 
 	kvfree(rx->qpl_copy_pool);
 	rx->qpl_copy_pool = NULL;
-- 
2.44.0.769.g3c40516874-goog


