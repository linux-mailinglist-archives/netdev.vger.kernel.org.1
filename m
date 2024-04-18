Return-Path: <netdev+bounces-89402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8888AA39C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9028B29E19
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87801A0AF9;
	Thu, 18 Apr 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FTbPYVUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A01A0AEB
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469947; cv=none; b=Hf3IBOPk7ujlX9T+x9dwnH+X9yPZfYzkewDz2wkAspIq1S5mRCDSQN2HWWRenyA3lOWM5pQHyCrOXVgZHF9mqFbJmETeF+254HCsIZ1hPYwRxsi9nj+ZmJWLWk0dHNyyoDJnRt7IMWfLvwD3pnFKPW1VEGmWYZAPi+BsAxm4SG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469947; c=relaxed/simple;
	bh=vcdxpDcy+rA+HdslsUiAM9FmYkLK/OW1ILVoyBWrIqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dpEWdHSOvX8jbC5LZnfp0I89iisdURdozCYGyg2trcuTCWx878pqCgHIAOOPAndmT6Lb0mTrE/oTnvigEBBvM/wv/w+iOlxNj2kc8ObisrrarOjBkEHROYtN6lhirydUmNg0PBv3I/U3CwFQbamWGf9jTx46AOOPHH3/c/z8uCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FTbPYVUp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b2abd30fdso13233457b3.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713469945; x=1714074745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqPXJb1E2MyKZ2ZcTaUJUh/zFV0A+KSo3FwUOlz8CyU=;
        b=FTbPYVUpGGVExJlarbEu+ZY1kiFgizzkJF95X+pLY6V3f/2QmbD0MrRS50Ti+x+flt
         ICQKKUQuS79sLXmX/VzM8PHpk3+ZDLb/yHE6RvnHZMoYItGsHvqffwe4NEBnzAM4GEeK
         hu2QdVPH9VoWrWTnEKQG+bMQJf//DwEbusb5dFQuDcr0hO49lYWkt1V0oPWKtdrGxOPZ
         sLjwdqx2+eOaGIU1xhhlD24CYaQFVMFiEJlsdC/Ty+8z1HxmmyVuhuH2th9TZoMkP6cu
         NogeiIr38do1LSehCQRqz1544+Hzwx48ZfYnccvRBY8fAnMcO2woErAZ5Gxu/TSTssy0
         Czhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469945; x=1714074745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqPXJb1E2MyKZ2ZcTaUJUh/zFV0A+KSo3FwUOlz8CyU=;
        b=ah4H+0uunlihZe1hGALt39w17DKa7UvRtbvFBazkiExsi1AM4wqexhBP+oXhrN+YsC
         +kWrsfDR8kwT6QzVaHKnxkXdfJKscDmuDz/rauv07jr3yThgY+xD0nEMjgY3GIDkJo2X
         1ifno36VKk/oAlN30/GwdskEthRgMGOXPEKDR6Xh4BLkgEv/Vh65Ufri9KyBUlRJUD76
         4fZkfAvNCVhvQ7KfOmesiqU00BAJE+e1sXvLTQkhmbYWOkWUWqwAmeKY8yRsRB6xHsB7
         r7qFlFNQKDLVsa48t3AJ9dcA4oRFLKKuhiHGiOx9J2TM0NPqNSRzDxggwj8Ss8dXMqU+
         LC6g==
X-Gm-Message-State: AOJu0Yy2Gj9fu+4ZC3pNpzD2v/nC82kdgwK2lByfjG35u1CqY0hsX/Ig
	B3Cw0Z1TQI61FUbY3CmId/M4/prvcbhJK+3P7KtXKkdk7L3ZIwqDmJUqC2FyrrDtE01riNCgMet
	258E1mUc32ZpfGtF1SRlfTBPK/jZNgUZqlITedWECum0ETn7oS3U6jGQH8KFKdZC5gG4YUzMQQ3
	2iC+WbydLvINzw2qfOGxgrae9Oojjqc/K1f5OduC6799Q=
X-Google-Smtp-Source: AGHT+IH5j/9OaG5VzuQyc9exHCE1jkz3GpN7vC2u70iQk6yEeLumEvr106Yj9rP2DUPk3Z7fRw1tsZMxb4jJKg==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a81:848e:0:b0:61b:982:4da0 with SMTP id
 u136-20020a81848e000000b0061b09824da0mr2609ywf.0.1713469945272; Thu, 18 Apr
 2024 12:52:25 -0700 (PDT)
Date: Thu, 18 Apr 2024 19:51:55 +0000
In-Reply-To: <20240418195159.3461151-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418195159.3461151-1-shailend@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418195159.3461151-6-shailend@google.com>
Subject: [RFC PATCH net-next 5/9] gve: Make gve_turnup work for nonempty queues
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
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

Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8e875b598e78..4ab90d3eb1cb 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2007,6 +2007,13 @@ static void gve_turnup(struct gve_priv *priv)
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
@@ -2022,6 +2029,13 @@ static void gve_turnup(struct gve_priv *priv)
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
2.44.0.769.g3c40516874-goog


