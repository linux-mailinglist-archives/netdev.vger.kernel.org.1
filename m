Return-Path: <netdev+bounces-92856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860CD8B9256
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F3528270A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367A3168B11;
	Wed,  1 May 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWj7l1lN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275B16C43E
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605968; cv=none; b=sC9fagjXP/PHpXYIKv2tmBk7NcmSvYN3mjGs3MBUKZr+foOerx8dKM+zDfTxFifb2DCgAd+aBhm7r14hjlVcKuV4lt5cLJH3rQQbG/nCcVDGNG/iDKv0gDTKsgn9vcRfoxpJVC6oy3DNvMxj4fYL+0EqWHCVAztBoqy+1lM6xDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605968; c=relaxed/simple;
	bh=q/x8uhyZ94hlLMU9upc5dvBwc1c1qlWMRkNRfbt16WY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=deF66WsZy2dULemoVxp8i4wAcmYIW59xxGA/Kav2cKn2FPz/xoZtCTn6/Z+tyHJZfrtOPYCzR0DZOfXSwh3R9ympypJeZAJ2I0LUVuuj2X02etGkWgqLk7Huf87rC0+UJMxALq9OBf5IHKbWNma6g4Naq5gaAhmxq3QhSQJ6jEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWj7l1lN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8bff2b792so7220407a12.1
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714605966; x=1715210766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sPcGdWtYIxokvDL0AKkLOB+K3RyNfXxAC6Aj1nMvXi0=;
        b=CWj7l1lNy36Dqfh0YYE746K0Zb+azIHk7tcDq7IVZ0lemNK4Ql24Ouzjto4aPy8C1z
         AbMsaBvGmqqTOhg4MOeVJtrkMOgTzJ5okPzyBxUUc+56nLg//luIf27BnBlzBvRbU9EH
         kcYA1UR7/L8hIvAN7hLohbdIZ0hPGbJMZgsa+qLI7+EE9XEXIM26VaOebREfU8JJfLgw
         1IsuNw0Bd0kumBgFlYe7224UmJuHZBNgqFGurtw6ic6XFFgN6bXoNS2abWKnYZAB3nxg
         Ks4vUsJLLahMUvtbpTpomodg9qaiT3j9RxFNikQx7DLRjLjFw3Gd6b8E1pMtXj5WXWho
         XZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714605966; x=1715210766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPcGdWtYIxokvDL0AKkLOB+K3RyNfXxAC6Aj1nMvXi0=;
        b=TkuUlDQ0HkvK099IueUu8IF5k1LDxNPmWJsOdyEUF7drb3gDqBknsZ4tx1yUNx1UCn
         EAONMQg7EoXbjEMewyNrSUrBcXTrrQFI13Q3HdzMHFjd9fNxKqY76MCznk+S4wmVccv1
         R4nTSvemfDDjXyO5A79VX66Q1PIFIjdILK2R4yDUYfAg8dj7RWWEsqcEuVo/TYkjeXXd
         GflYtvoJwYk6LAzZZR7mTtYfJBFXNDR1CMKXhAkIyvLfMEiAoZGRJo9BfyXztEtVhY3x
         eGmrivD9KF3JMYHRH8UWPFUunA7gVgjHoDeH2nr1KiFL0CsaCqIawP7grjuhSMkehuv5
         P4rw==
X-Gm-Message-State: AOJu0YxTJB+UHtqyBMP/eMELH6AFdm1g6D7omc6lYevuQ9EGLW6iB+fB
	Iec3P6GEvPRFfUGosTjM3b3Bmedd/iCjcMSpwplo1OZKn6pVa8itl+cMYFu5fJk8oLpuPpzDbSh
	kE5XXO76Y4WPcWdm0l1Nj3FKtvf2w7Dahhenj7lq8jxLg4UNgHmS/jPRBhgs3m9M0AP6sYXIuOy
	aFEMXxJTMDTbzmmnSYezQRqYNOdjAXuwyVf8Ul+tuwjbs=
X-Google-Smtp-Source: AGHT+IHUJneyciiVPxFP9nWxMxeLBv/zNPYp6B6xaDJf8LQj+34buBH6t3o48Kht5lHsUMasrsc83zTNUw8nEQ==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6a02:696:b0:5db:edca:d171 with SMTP
 id ca22-20020a056a02069600b005dbedcad171mr34264pgb.6.1714605965553; Wed, 01
 May 2024 16:26:05 -0700 (PDT)
Date: Wed,  1 May 2024 23:25:44 +0000
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501232549.1327174-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240501232549.1327174-6-shailend@google.com>
Subject: [PATCH net-next v2 05/10] gve: Make gve_turnup work for nonempty queues
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, rushilg@google.com, 
	willemb@google.com, ziweixiao@google.com, 
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


