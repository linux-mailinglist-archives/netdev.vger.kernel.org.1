Return-Path: <netdev+bounces-211295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A2B17ABE
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 03:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D017F8FF
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A7D20326;
	Fri,  1 Aug 2025 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHiKpQAD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD112AE72
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 01:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754010818; cv=none; b=IoQOSeFHnSMNBC11sboMtZjFgHvvr6yd4KPwcz0vPVHlv9r/25Y5Ia6hLplyXx5KaHpvyopKQmfSH30CBylMqTGkhwRruoQnY4UeqSuDppmunzrzzHUqOW20uj7XlE0ZCaecufym7CsqknQ8wboDd10ekyOYTGQsIzmu5aXg8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754010818; c=relaxed/simple;
	bh=/yLrHNvm1jTrBrL7S2rwdjFKsDUDz6OpMinUDjvN0ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnGKn5tLSmYh5MficigxI6xajTjcxMK9NzWl+r5O2iZ7ajzkL5xc8jOYsRuZb28652I86Ne0lfqbGDtaiST0kN994p3N91DoHI3YmDW4c2ChHKv6f+5wYVZ38AekIdjUX37VSkiUxqm74YMTZ6/ihs36sfkmkNi/8FQgcCgd04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHiKpQAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA28C4CEEF;
	Fri,  1 Aug 2025 01:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754010817;
	bh=/yLrHNvm1jTrBrL7S2rwdjFKsDUDz6OpMinUDjvN0ZM=;
	h=From:To:Cc:Subject:Date:From;
	b=XHiKpQADMia2nM2Yn5PWIka9Dzm3IMDuHL6GVmOWm/oDZmGUTyyOXc1Vd8DDPO7f5
	 7NfH/I2/Ua3r+/+XJEjzckf8cJq11jg+ViSA/J8Frd9nzgc36T+fOB2VRf9gCCgSAy
	 iw9sfplphX1kPKtjhvrlQd8wtZFrL0ch1nLSjrZtVAKn14SsDpnwXuaT7Jchpt2SrU
	 /RdlYwYDtcY0LiqjK5MCAPJWuCJy7ugZw9HpnfDXabJhRKQCHsaG3zgpA9oFOm4sUs
	 Fw1ysKdsGSEeyAB/8dtO+QISSQxmNnjs3UpFJSfZLyMLTWpD/5MVIR2tEHD4z1Wn5G
	 W5fACTLdVbgSw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	almasrymina@google.com,
	asml.silence@gmail.com,
	sdf@fomichev.me,
	dw@davidwei.uk,
	kaiyuanz@google.com
Subject: [PATCH net] net: devmem: fix DMA direction on unmapping
Date: Thu, 31 Jul 2025 18:13:35 -0700
Message-ID: <20250801011335.2267515-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like we always unmap the DMA_BUF with DMA_FROM_DEVICE direction.
While at it unexport __net_devmem_dmabuf_binding_free(), it's internal.

Found by code inspection.

Fixes: bd61848900bf ("net: devmem: Implement TX path")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Compile tested only. I could be missing something here.

CC: almasrymina@google.com
CC: asml.silence@gmail.com
CC: sdf@fomichev.me
CC: dw@davidwei.uk
CC: kaiyuanz@google.com
---
 net/core/devmem.h | 7 +++----
 net/core/devmem.c | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/core/devmem.h b/net/core/devmem.h
index 0a3b28ba5c13..41cd6e1c9141 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -56,6 +56,9 @@ struct net_devmem_dmabuf_binding {
 	 */
 	u32 id;
 
+	/* DMA direction, FROM_DEVICE for Rx binding, TO_DEVICE for Tx. */
+	enum dma_data_direction direction;
+
 	/* Array of net_iov pointers for this binding, sorted by virtual
 	 * address. This array is convenient to map the virtual addresses to
 	 * net_iovs in the TX path.
@@ -165,10 +168,6 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 {
 }
 
-static inline void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
-{
-}
-
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
 		       enum dma_data_direction direction,
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b3a62ca0df65..24c591ab38ae 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -70,14 +70,13 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
 		gen_pool_destroy(binding->chunk_pool);
 
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
-					  DMA_FROM_DEVICE);
+					  binding->direction);
 	dma_buf_detach(binding->dmabuf, binding->attachment);
 	dma_buf_put(binding->dmabuf);
 	xa_destroy(&binding->bound_rxqs);
 	kvfree(binding->tx_vec);
 	kfree(binding);
 }
-EXPORT_SYMBOL(__net_devmem_dmabuf_binding_free);
 
 struct net_iov *
 net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
@@ -208,6 +207,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	mutex_init(&binding->lock);
 
 	binding->dmabuf = dmabuf;
+	binding->direction = direction;
 
 	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
 	if (IS_ERR(binding->attachment)) {
@@ -312,7 +312,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	kvfree(binding->tx_vec);
 err_unmap:
 	dma_buf_unmap_attachment_unlocked(binding->attachment, binding->sgt,
-					  DMA_FROM_DEVICE);
+					  direction);
 err_detach:
 	dma_buf_detach(dmabuf, binding->attachment);
 err_free_binding:
-- 
2.50.1


