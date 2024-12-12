Return-Path: <netdev+bounces-151276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A559EDDDD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F9B282C26
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 03:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B0913FD72;
	Thu, 12 Dec 2024 03:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b="L8IMwkqN"
X-Original-To: netdev@vger.kernel.org
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEBB14387B;
	Thu, 12 Dec 2024 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.51.146.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733973188; cv=none; b=mojbC0uceWx7dfj++wZKWJu8khQrUmRXBXh5U0C1YewytiHnhtG4WH3lkXPf+qOU+AQv3hFEXmzV7rfctb3lgvRZO2f+zWmjIi/ndKO7Ysje2QLP45jTQX7J0ye/HefNLvuqUot+bu2Pznib3hbxl+Vz5OvjZbc/AnHg0akb6uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733973188; c=relaxed/simple;
	bh=rKbsxGB3AFxIQm5RPyK7MJFL+KHlfLn3sdTudJwPrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrCJPoEQj8jOL2LJt75XDenTOV8Em0cm5IKLONm9ZZl4fTkpR7mCplkoYDe9Fill+Dzhx5HRqyTFxOCjIohyRwR8M3PeKyNjpg+NZi/AeB3vQwxNb0LBDmVc0AELn9zF8DK97Ge6unQ27S5Dn2LlFdN/a6wgqAi9NdgTE3UNltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one; spf=pass smtp.mailfrom=brun.one; dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b=L8IMwkqN; arc=none smtp.client-ip=212.51.146.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brun.one
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
	s=s1; h=MIME-Version:Message-ID:Date:Subject:Cc:To:From:In-Reply-To:
	References:From:To:Subject:Date:Message-ID:Reply-To;
	bh=2PrfMK9ue+KBe11eTA9nTUKl/IRBkVyrnaOSt1abAZU=; b=L8IMwkqNTWOKdPqZPhr4WmegPH
	Cmvvw1e7zOtGRSemcRKiS0I0z5TwlMqLCrSYW2vD+UVPK4OqtqAQu+6syhVATHiVsQ1Z14K6zzquH
	l6u8Xp6+cOEtBJiBnc4zsic/t+UnmWiaOVbItBFzl48JLpBU5d8zxmsw/zTSUa1zIeZpAPXQKXgj6
	8X+OwYnQll3O8gaxYm84PsTVm+DfvJ9ES/3J1qlPW1wfFN7hzbnx5tCjIJW5BZsMQyC+hwakqWU3Q
	YpLqqzuWsqWqtQgqE5nfgEo/DZ4qSmBOPsJ7ZNxVoEf2y9pNF0qOLFZ2u4t8wUfeWCFdAmJRlpM3+
	E1tSqG/A==;
Received: from [212.51.153.89] (helo=localhost.localdomain)
	by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <lorenz@dolansoft.org>)
	id 1tLZ7V-00000001RTO-2Vep;
	Thu, 12 Dec 2024 02:40:05 +0000
From: Lorenz Brun <lorenz@brun.one>
To: Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manuel Ullmann <labre@posteo.de>
Cc: Lorenz Brun <lorenz@brun.one>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: atlantic: keep rings across suspend/resume
Date: Thu, 12 Dec 2024 03:39:24 +0100
Message-ID: <20241212023946.3979643-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org

The rings are order-6 allocations which tend to fail on suspend due to
fragmentation. As memory is kept during suspend/resume, we don't need to
reallocate them.

This does not touch the PTP rings which, if enabled, still reallocate.
Fixing these is harder as the whole structure is reinitialized.

Fixes: cbe6c3a8f8f4 ("net: atlantic: invert deep par in pm functions, preventing null derefs")
Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 drivers/net/ethernet/aquantia/atlantic/aq_main.c     |  4 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c      |  7 ++++---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h      |  2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c |  4 ++--
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c      | 10 ++++++++++
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
index c1d1673c5749..cd3709ba7229 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
@@ -84,7 +84,7 @@ int aq_ndev_open(struct net_device *ndev)
 
 err_exit:
 	if (err < 0)
-		aq_nic_deinit(aq_nic, true);
+		aq_nic_deinit(aq_nic, true, false);
 
 	return err;
 }
@@ -95,7 +95,7 @@ int aq_ndev_close(struct net_device *ndev)
 	int err = 0;
 
 	err = aq_nic_stop(aq_nic);
-	aq_nic_deinit(aq_nic, true);
+	aq_nic_deinit(aq_nic, true, false);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index fe0e3e2a8117..a6324ae88acf 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1422,7 +1422,7 @@ void aq_nic_set_power(struct aq_nic_s *self)
 		}
 }
 
-void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
+void aq_nic_deinit(struct aq_nic_s *self, bool link_down, bool keep_rings)
 {
 	struct aq_vec_s *aq_vec = NULL;
 	unsigned int i = 0U;
@@ -1433,7 +1433,8 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
 	for (i = 0U; i < self->aq_vecs; i++) {
 		aq_vec = self->aq_vec[i];
 		aq_vec_deinit(aq_vec);
-		aq_vec_ring_free(aq_vec);
+		if (!keep_rings)
+			aq_vec_ring_free(aq_vec);
 	}
 
 	aq_ptp_unregister(self);
@@ -1499,7 +1500,7 @@ void aq_nic_shutdown(struct aq_nic_s *self)
 		if (err < 0)
 			goto err_exit;
 	}
-	aq_nic_deinit(self, !self->aq_hw->aq_nic_cfg->wol);
+	aq_nic_deinit(self, !self->aq_hw->aq_nic_cfg->wol, false);
 	aq_nic_set_power(self);
 
 err_exit:
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
index ad33f8586532..f0543a5cc087 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
@@ -189,7 +189,7 @@ int aq_nic_get_regs(struct aq_nic_s *self, struct ethtool_regs *regs, void *p);
 int aq_nic_get_regs_count(struct aq_nic_s *self);
 u64 *aq_nic_get_stats(struct aq_nic_s *self, u64 *data);
 int aq_nic_stop(struct aq_nic_s *self);
-void aq_nic_deinit(struct aq_nic_s *self, bool link_down);
+void aq_nic_deinit(struct aq_nic_s *self, bool link_down, bool keep_rings);
 void aq_nic_set_power(struct aq_nic_s *self);
 void aq_nic_free_hot_resources(struct aq_nic_s *self);
 void aq_nic_free_vectors(struct aq_nic_s *self);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 43c71f6b314f..1015eab5ee50 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -390,7 +390,7 @@ static int aq_suspend_common(struct device *dev)
 	if (netif_running(nic->ndev))
 		aq_nic_stop(nic);
 
-	aq_nic_deinit(nic, !nic->aq_hw->aq_nic_cfg->wol);
+	aq_nic_deinit(nic, !nic->aq_hw->aq_nic_cfg->wol, true);
 	aq_nic_set_power(nic);
 
 	rtnl_unlock();
@@ -426,7 +426,7 @@ static int atl_resume_common(struct device *dev)
 
 err_exit:
 	if (ret < 0)
-		aq_nic_deinit(nic, true);
+		aq_nic_deinit(nic, true, false);
 
 	rtnl_unlock();
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 9769ab4f9bef..3b51d6ee0812 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -132,6 +132,16 @@ int aq_vec_ring_alloc(struct aq_vec_s *self, struct aq_nic_s *aq_nic,
 	unsigned int i = 0U;
 	int err = 0;
 
+	if (self && self->tx_rings == aq_nic_cfg->tcs && self->rx_rings == aq_nic_cfg->tcs) {
+		/* Correct rings already allocated, nothing to do here */
+		return 0;
+	} else if (self && (self->tx_rings > 0 || self->rx_rings > 0)) {
+		/* Allocated rings are different, free rings and reallocate */
+		pr_notice("%s: cannot reuse rings, have %d, need %d, reallocating", __func__,
+			  self->tx_rings, aq_nic_cfg->tcs);
+		aq_vec_ring_free(self);
+	}
+
 	for (i = 0; i < aq_nic_cfg->tcs; ++i) {
 		const unsigned int idx_ring = AQ_NIC_CFG_TCVEC2RING(aq_nic_cfg,
 								    i, idx);
-- 
2.44.1


