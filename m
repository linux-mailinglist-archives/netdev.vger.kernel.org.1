Return-Path: <netdev+bounces-199234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C197BADF82F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB864A2FB6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEDD21D5B8;
	Wed, 18 Jun 2025 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xiYls1HI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1FB21CC64
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280180; cv=none; b=QpoVKZizb13wCKlMozhYwsS1llV1DqvATf1QhQuz8xzGoot0H5StQE/ZiLaLm0KI787a936hUXk/G+PvHvxEh7UwTirucZmPAWGbRfPS8znJ+pQ4tvZisur94J/OW8nNpSiJpNtxySH0I8lUnkeuZ4nILD3ccarZia09gspiZe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280180; c=relaxed/simple;
	bh=Y7TYJoo+PqfWWYDcqEA8qnLm+FStCItkUlgkiWQQpyo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CWbY19p010/Tf2eKb8orIhE3iuXWPjv/zFx7dxROLPN2KdOdanGXyYHJLQyv8QCYrpCFEqnUpCEho1caQtjUyqkozCEDlUyhUBQ+9+8rYHSsv0KAHZhSeRzinWPg+uAaW/FpS7WUkBvHk0QE9MDJlD+JhzRtLdGphWETbjjZovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xiYls1HI; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74834bc5d37so111839b3a.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 13:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750280178; x=1750884978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nqNfXinKiAcfUjzfMzeZv8PmgH35W5nRu9Qiwo39lQ=;
        b=xiYls1HIGu33jfsKw7P7ZeeV6sB51u0IDSHY7oZnn4dPT2kLvpnC8M/L/1TV/oyDSg
         OHGWZ9nblkPYqv4RAZKJE+QYVhqn73Hyq/4hQFwsRrNAmZJNT4Z6/m8m1un4rQqJmsVC
         DvOYL5i9HK1LTmk0nye+MkOlrbOsVigmcWKv9EONO3kE1H5Ki8x31y6bnGkNMKp/w56x
         dJhMWRHaLGyQVSyhg3tF8DcDe1PsNJi3v5WOqxzDT2ZBvN8jaY/PxsEHMnVAD+fdF25O
         YYlTb9u4q02hoRmcFPg5dnA82/avlxR/++Tik2kyqRimrSW16goheHyGubfkOxr4Im9y
         QbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750280178; x=1750884978;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nqNfXinKiAcfUjzfMzeZv8PmgH35W5nRu9Qiwo39lQ=;
        b=a1IId8GEmTmoRsOo0PGSc4ai7vAdNJofZAOgRsT02UN6buPfPpsbuQlRMyT4LP2ar6
         ieEzFL1BBdlvQhhvfSudiOB0qwhDyNFtlanOiW1yRPGLVyQLL4brs12Mac37+LhcsbeJ
         +sMXDhUd5hAHn9FS2i/j7VIWWJC9zHRjSTHZmq62zkA3W4Fbrq3eBM5svVQ+eZ+qUBYA
         qRBRQHzW3C09uDaXiNbK8zvbbNt/XwS9nQpDpkaFkj8XhLqkkgMfbvce+jmNbXi5mSem
         bu49kAqw7MHnXB/+QjtTLZb5l9QTJIbnF6lB5wr3WCc4DDCwOzNsMlabXtVrdo7/DDhu
         HE8g==
X-Gm-Message-State: AOJu0YwtwSonGh+PSan5lxZMjlz62ltARyVwHe5NaWJRiOnSO2RQeGAE
	EcwHdmZi8W7WDYC/Ztli5/xPvPE2AMF20/SXo93AZB4NJU48QkDMFXicp9yNZd8Ve+7sXDmtMJq
	oIoW2lwL2b9QhaUc7k39uWdVqjwL307oaNjaS/9DDYAFNz1v855VjYao79Nl9Li+vsdsgFeD4Om
	1HeruUWd/S1XupVcDTlQ1zyGEFt8NJ6+rtaRpqF8qAPr2NHsowOvdzbEH/+NTUYjw=
X-Google-Smtp-Source: AGHT+IGwt1EXS28Cr28WyQkNs/jZ1HQZD9gTvDXgPsRQD7GAMFhXHVkEeKdEkaToyx+A6dh8M93uXUt1cxPfkyWiYw==
X-Received: from pfbjo20.prod.google.com ([2002:a05:6a00:9094:b0:747:bd3b:4b63])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:39a0:b0:742:b3a6:db16 with SMTP id d2e1a72fcca58-7489cfe28famr27612874b3a.20.1750280178421;
 Wed, 18 Jun 2025 13:56:18 -0700 (PDT)
Date: Wed, 18 Jun 2025 20:56:11 +0000
In-Reply-To: <20250618205613.1432007-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618205613.1432007-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250618205613.1432007-2-hramamurthy@google.com>
Subject: [PATCH net-next 1/3] gve: rename gve_xdp_xmit to gve_xdp_xmit_gqi
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	ziweixiao@google.com, pkaligineedi@google.com, joshwash@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

In preparation for XDP DQ support, the gve_xdp_xmit callback needs to
be generalized for all queue formats. This patch renames the GQ-specific
function to gve_xdp_xmit_gqi, and introduces a new gve_xdp_xmit callback
which branches on queue format.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  4 ++--
 drivers/net/ethernet/google/gve/gve_main.c | 10 ++++++++++
 drivers/net/ethernet/google/gve/gve_tx.c   |  4 ++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 4469442d4940..de1fc23c44f9 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1178,8 +1178,8 @@ void gve_free_queue_page_list(struct gve_priv *priv,
 			      u32 id);
 /* tx handling */
 netdev_tx_t gve_tx(struct sk_buff *skb, struct net_device *dev);
-int gve_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
-		 u32 flags);
+int gve_xdp_xmit_gqi(struct net_device *dev, int n, struct xdp_frame **frames,
+		     u32 flags);
 int gve_xdp_xmit_one(struct gve_priv *priv, struct gve_tx_ring *tx,
 		     void *data, int len, void *frame_p);
 void gve_xdp_tx_flush(struct gve_priv *priv, u32 xdp_qid);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 28e4795f5f40..eff970124dba 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1516,6 +1516,16 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 	return err;
 }
 
+static int gve_xdp_xmit(struct net_device *dev, int n,
+			struct xdp_frame **frames, u32 flags)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+
+	if (gve_is_gqi(priv))
+		return gve_xdp_xmit_gqi(dev, n, frames, flags);
+	return -EOPNOTSUPP;
+}
+
 static int gve_xsk_pool_enable(struct net_device *dev,
 			       struct xsk_buff_pool *pool,
 			       u16 qid)
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 1b40bf0c811a..c6ff0968929d 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -823,8 +823,8 @@ static int gve_tx_fill_xdp(struct gve_priv *priv, struct gve_tx_ring *tx,
 	return ndescs;
 }
 
-int gve_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
-		 u32 flags)
+int gve_xdp_xmit_gqi(struct net_device *dev, int n, struct xdp_frame **frames,
+		     u32 flags)
 {
 	struct gve_priv *priv = netdev_priv(dev);
 	struct gve_tx_ring *tx;
-- 
2.50.0.rc2.761.g2dc52ea45b-goog


