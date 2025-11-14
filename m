Return-Path: <netdev+bounces-238779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96683C5F540
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 230EF4E53E1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09F34D3A7;
	Fri, 14 Nov 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpOAjiZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D834CFB4
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154751; cv=none; b=JbWaDlKH1XDheLMjSogm/tu9ID+Ou9y+ejjeJN60aOHuJizSkxArwBMG9564t47Z3HOC12ngWbLDLgIzCcvOeEOByUZBQXW8qWe7kgw14YKk+j152GgG/iy67v/lViLmPw3IEd6+L/DOooET3vlNIQO1H4ecHz9SDkrGMqLngYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154751; c=relaxed/simple;
	bh=7GRJ/PW+ZjlS5rbC6oxTHSZTvFvMwaOAeCHQcMlMJBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hXHAMGBZd0pmXbFVAfocGEpLcz/zcPM3sWWen+PA8Nfmxf/XJb6n5QeeFx6xDABGjguvYR9UfE57sT4fdO0aRBAGikoKAvbN3tvMwQy3AzbEEjMrD341BlH0TUA/WFUpQnOrWwJTkPZrxHP76ll91n4wazOPsPNzAiLEhuIIT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpOAjiZU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295915934bfso36258315ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154749; x=1763759549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOJK9SLutt+EQ44/gH840hpx3Hfd04ffDRZ9ZBYAKSk=;
        b=XpOAjiZUWDC1ddcQzvuMJVUh+hQURnMXSQIlBL+XTJlRIaP/wL+2LxQ7uA8OSNCpPb
         r+owBvGITtTP1+ROtMdrGyvsMaK6e79vgjJuOGvB62FobpJ8UMLTv09ofgsqficPObgX
         3ZA9wAvZ63NDwVKcvrdgFQw7TF0uXIZ7Fim6FXrqL4ptDsP4JGXWc+3Xd3xjKDQDdNMy
         7CKmYAQEF0yBggaFvgwSXryg2eBQZ9trMIww17biBkGU934ltfl4i+IEgW/iRPOvCFD/
         O30LgeRpDh6Tu7csgTYSRsDa8+VBuKt0yRhtdFmEP1I5mgRz00khuXWkCZjZVLsupnEq
         sAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154749; x=1763759549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOJK9SLutt+EQ44/gH840hpx3Hfd04ffDRZ9ZBYAKSk=;
        b=nJJINxUYpZmjmz7dWxVGkMmtNsHXeNa7lTX9xcTwYMDETqLpNHrezeEvxeKU35ogds
         vuEr4BcbiUNO6Z7TAqeabUid/34PbQPnnLz6Z6qc+0U0hAVJbbGWhd8zfRexrCLC4quF
         iROlN03wp8hq6Kz6WvI6ZWvDopYYbIEJqIRKJC4GoGBzB70rvvsAqdfAsIT9TyAJ/Owr
         CXV5lb3UdbMZ9bCbW0v+RQkfF4fSS3SnPl0LDT9aRzJiX4k/Cx/dRgcR2oZ4+8kEMVh3
         DAd1boeF7v4+SmQE6+Pebv8qvcbieR7pHcH90J/42+shhEAF1pv+Ej2PqnwS9nXhytn6
         G+eA==
X-Gm-Message-State: AOJu0Yy5uyvkpuiAddMRXa0Cf1dy2NyEmu+kBhqWdc+mbiP4t5wX4og6
	LcXaU61JOjAqehxSbJqtGj0gFNJsxo7cdf/OljjXEWoooE8AvXUo3U2HkYX3Nv63AzlehMgtDQ0
	ixHz6N9/HkCRtarb8NH/G9hPoYS3Ji0dakuAP/OArGBgDmyiWqumdsQDHRebD8O1iD98tXOYVjW
	+qioNAyLh3ovH6i0S6XL9qe5FPKkWY8S7metOtoFlBA8Xq/jM=
X-Google-Smtp-Source: AGHT+IFf3b5Wf2YCfgkcxyT3Kw1rGGftpj95wXeEiTy69JDVmj4KrlWGzwkN/sJtEE5hwtMzu+MXWWjiREPT0A==
X-Received: from plhz15.prod.google.com ([2002:a17:902:d9cf:b0:298:3e35:3e78])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ef06:b0:298:595d:3d3a with SMTP id d9443c01a7336-2986a7566edmr43023395ad.50.1763154748557;
 Fri, 14 Nov 2025 13:12:28 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:46 -0800
In-Reply-To: <20251114211146.292068-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114211146.292068-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-5-joshwash@google.com>
Subject: [PATCH net-next 4/4] gve: Add Rx HWTS metadata to AF_XDP ZC mode
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, Kevin Yang <yyd@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

By overlaying the struct gve_xdp_buff on top of the struct xdp_buff_xsk
that AF_XDP utilizes, the driver records the 32 bit timestamp via the
completion descriptor and the cached 64 bit NIC timestamp via gve_priv.

The driver's implementation of xmo_rx_timestamp extends the timestamp to
the full and up to date 64 bit timestamp and returns it to the user.

gve_rx_xsk_dqo is modified to accept a pointer to the completion
descriptor and no longer takes a buf_len explicitly as it can be pulled
out of the descriptor.

With this patch gve now supports bpf_xdp_metadata_rx_timestamp.

Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c   |  7 +++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 16 ++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 2b41a42fb516..a5a2b18d309b 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2348,6 +2348,10 @@ static void gve_set_netdev_xdp_features(struct gve_priv *priv)
 	xdp_set_features_flag_locked(priv->dev, xdp_features);
 }
 
+static const struct xdp_metadata_ops gve_xdp_metadata_ops = {
+	.xmo_rx_timestamp	= gve_xdp_rx_timestamp,
+};
+
 static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 {
 	int num_ntfy;
@@ -2443,6 +2447,9 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 	}
 
 	gve_set_netdev_xdp_features(priv);
+	if (!gve_is_gqi(priv))
+		priv->dev->xdp_metadata_ops = &gve_xdp_metadata_ops;
+
 	err = gve_setup_device_resources(priv);
 	if (err)
 		goto err_free_xsk_bitmap;
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index f20d1b1d06e6..f1bd8f5d5732 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -240,6 +240,11 @@ int gve_rx_alloc_ring_dqo(struct gve_priv *priv,
 		rx->rx_headroom = 0;
 	}
 
+	/* struct gve_xdp_buff is overlaid on struct xdp_buff_xsk and utilizes
+	 * the 24 byte field cb to store gve specific data.
+	 */
+	XSK_CHECK_PRIV_TYPE(struct gve_xdp_buff);
+
 	rx->dqo.num_buf_states = cfg->raw_addressing ? buffer_queue_slots :
 		gve_get_rx_pages_per_qpl_dqo(cfg->ring_size);
 	rx->dqo.buf_states = kvcalloc_node(rx->dqo.num_buf_states,
@@ -701,16 +706,23 @@ static void gve_xdp_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
 }
 
 static int gve_rx_xsk_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
-			  struct gve_rx_buf_state_dqo *buf_state, int buf_len,
+			  const struct gve_rx_compl_desc_dqo *compl_desc,
+			  struct gve_rx_buf_state_dqo *buf_state,
 			  struct bpf_prog *xprog)
 {
 	struct xdp_buff *xdp = buf_state->xsk_buff;
+	int buf_len = compl_desc->packet_len;
 	struct gve_priv *priv = rx->gve;
+	struct gve_xdp_buff *gve_xdp;
 	int xdp_act;
 
 	xdp->data_end = xdp->data + buf_len;
 	xsk_buff_dma_sync_for_cpu(xdp);
 
+	gve_xdp = (void *)xdp;
+	gve_xdp->gve = priv;
+	gve_xdp->compl_desc = compl_desc;
+
 	if (xprog) {
 		xdp_act = bpf_prog_run_xdp(xprog, xdp);
 		buf_len = xdp->data_end - xdp->data;
@@ -800,7 +812,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 
 	xprog = READ_ONCE(priv->xdp_prog);
 	if (buf_state->xsk_buff)
-		return gve_rx_xsk_dqo(napi, rx, buf_state, buf_len, xprog);
+		return gve_rx_xsk_dqo(napi, rx, compl_desc, buf_state, xprog);
 
 	/* Page might have not been used for awhile and was likely last written
 	 * by a different thread.
-- 
2.51.2.1041.gc1ab5b90ca-goog


