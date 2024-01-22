Return-Path: <netdev+bounces-64771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB1837156
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26591C29D48
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36474D5A8;
	Mon, 22 Jan 2024 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2OW9Za0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768664E1DE
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948036; cv=none; b=Oeq/xovEFe7n0KLx3NazQsqaBlxCsKzJiipAwD2QgoZrKPxJ3nzJv1cPiF9BQur4VLxdtZBAloi1gpkNR4zHV8tJ9fQjVMnUPvIj7L+cu7BbeHpgiUq//YQFCmDKQwCxHECDE/F1sE6Jyp9RSQ0CT6JEKmeeMm6Zqf1TXDQwQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948036; c=relaxed/simple;
	bh=M1+1uKzWhDca9C6MmnPnkLaJCwhh4mjDOdU+1Skk1mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=edCC1kC1o+cSDR9sYfV0C8vE736IB64lsMNw2lZRMbYM3Z8I3j1M+vOw1xoM/H1ErG6n7mCMGhwfI8RG0VmdyaI264SZVoJrKobe25Ye/Bck/vV2kcyI2IJvzx3DTl/n9l1gQn3tkJyldhleQrTAEKZbuCj1xyb5XxhrS9gNdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2OW9Za0Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc253fee264so4846452276.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705948034; x=1706552834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7tQsEE8sJMlY7lyUitaaY8KsBTbZCqMTqV6aFNSoUU=;
        b=2OW9Za0QZwK7w/fnnknTSZF8SMV35ivmUpLbGsRSnTpvOicu1idY5Bjr0tflTqVGdG
         p7PjCQiOzKhpwdiydsNJuGMG1uYlmVRNOBcM0LbC89ruUmxyDlBFHa+20JFZ5/90106m
         PReTJintwjcY1DXk8kyBvhSLq+ZT8URjkJAPpUzLvmc1XbDhcy+6CowR92808YyQ4jS7
         /iXZ6WPa7/bCiEbp27CFNLvofPhsD7ScDAWi9PiR4ft19k1nzATFvnU/mIVJc7kRG919
         UA4UORhzaPzx2lx+JRuggYx7eFXC7c9nHyzoZSREChToYDyrPBNJOZqM44f5KFoWqfLK
         WhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705948034; x=1706552834;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7tQsEE8sJMlY7lyUitaaY8KsBTbZCqMTqV6aFNSoUU=;
        b=qQ0cVHa8LHziArq5XHTIBQlktkJe9/7VlL6hwTC656DuHF9HRztOhDowXeb0n1Vz5M
         e1SGrAMVI62I1UOyEq4bg3+yaz5/cfH2XAsRokHP9jQbisP6/DFENiOozlO5VtDkeRr8
         PHwJwKlNylmI4/MwgobfJHZMTAk20reuKNpIGVVZaOXHCNBl/RYKgWk3dZcxemuECbUT
         iWhUuO8RuVI+Rlk1UWxo4dgjzv9Tqw6njPWm6+RxS0QOMLWa0po8RUVKB2FjzGCEhxU2
         nG/tshOdfB9pkJaOLU2Qq8MlqptZHvbfbGFA3AWpaWrEnXmBQUxZ9Jg0sEjxDL1XeV18
         TVTw==
X-Gm-Message-State: AOJu0YyLDLLDEE2TiLzcJCgZjBuHXkEHHd8ls44PNnj+IBpOdX3pkayK
	T7vf+npn210XkgkHbYukMwvkSunhociresgF1n3FEiTrRNMbBH/cskKfwxLZFnvCLbUrk/Y/ABi
	oFEz4xlS2CwL6bLcJ9h1qpj/PVR1Rb70ICiM5L5kzuyHnKwzkZhI1Cy5YF4Hn3yYwiVD9jTYc4D
	NjYHBAZGe2espkz2Jot6bth7XhXq2djOgKKez+OxN9gX4=
X-Google-Smtp-Source: AGHT+IH9WyYqqggKussWEWLVCJgnuv90qtF6K0KYsZuOgGe9703zlhpy0m0mP3qCahx1ZYsxW5HDBfO0QEbz1g==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:b1d:b0:dc2:1dd0:c517 with SMTP
 id ch29-20020a0569020b1d00b00dc21dd0c517mr2340540ybb.7.1705948034453; Mon, 22
 Jan 2024 10:27:14 -0800 (PST)
Date: Mon, 22 Jan 2024 18:26:27 +0000
In-Reply-To: <20240122182632.1102721-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122182632.1102721-1-shailend@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122182632.1102721-2-shailend@google.com>
Subject: [PATCH net-next 1/6] gve: Define config structs for queue allocation
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, Jeroen de Borst <jeroendb@google.com>
Content-Type: text/plain; charset="UTF-8"

Queue allocation functions currently can only allocate into priv and
free memory in priv. These new structs would be passed into the queue
functions in a subsequent change to make them capable of returning newly
allocated resources and not just writing them into priv. They also make
it possible to allocate resources for queues with a different config
than that of the currently active queues.

Signed-off-by: Shailend Chand <shailend@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jeroen de Borst <jeroendb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b80349154604..00e7f8b06d89 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -622,6 +622,55 @@ struct gve_ptype_lut {
 	struct gve_ptype ptypes[GVE_NUM_PTYPES];
 };
 
+/* Parameters for allocating queue page lists */
+struct gve_qpls_alloc_cfg {
+	struct gve_qpl_config *qpl_cfg;
+	struct gve_queue_config *tx_cfg;
+	struct gve_queue_config *rx_cfg;
+
+	u16 num_xdp_queues;
+	bool raw_addressing;
+	bool is_gqi;
+
+	/* Allocated resources are returned here */
+	struct gve_queue_page_list *qpls;
+};
+
+/* Parameters for allocating resources for tx queues */
+struct gve_tx_alloc_rings_cfg {
+	struct gve_queue_config *qcfg;
+
+	/* qpls and qpl_cfg must already be allocated */
+	struct gve_queue_page_list *qpls;
+	struct gve_qpl_config *qpl_cfg;
+
+	u16 ring_size;
+	u16 start_idx;
+	u16 num_rings;
+	bool raw_addressing;
+
+	/* Allocated resources are returned here */
+	struct gve_tx_ring *tx;
+};
+
+/* Parameters for allocating resources for rx queues */
+struct gve_rx_alloc_rings_cfg {
+	/* tx config is also needed to determine QPL ids */
+	struct gve_queue_config *qcfg;
+	struct gve_queue_config *qcfg_tx;
+
+	/* qpls and qpl_cfg must already be allocated */
+	struct gve_queue_page_list *qpls;
+	struct gve_qpl_config *qpl_cfg;
+
+	u16 ring_size;
+	bool raw_addressing;
+	bool enable_header_split;
+
+	/* Allocated resources are returned here */
+	struct gve_rx_ring *rx;
+};
+
 /* GVE_QUEUE_FORMAT_UNSPECIFIED must be zero since 0 is the default value
  * when the entire configure_device_resources command is zeroed out and the
  * queue_format is not specified.
-- 
2.43.0.429.g432eaa2c6b-goog


