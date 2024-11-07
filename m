Return-Path: <netdev+bounces-142777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC39C054F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0290B23CF3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918820FA8A;
	Thu,  7 Nov 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cv3/oU0S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9020F5B5
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981278; cv=none; b=G/jH2EHgWxa12azSotGtENJp8rX3y74LRkVC4vm5UD+XAJTRxjyzM7zSzJ28kmuQ7Tg8qsM6VB7ShuVN+yBltu4dIl0LjejwpWQssQbhaBe3+HsUqoaVYEU1H+cL8aMPAhx0XPdbZZvS2JsLIxdWvZ52qJ3VtmCEp3qP8Gbfe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981278; c=relaxed/simple;
	bh=HdeIDuv4jFXFSrQqwZ79KZSdAahWsNswhCFGLCV6WQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h5fSbn7I0lnd4KfhKTbe1jR2K1jG6qxEIn3/MAHjNGwTbI43mnEuHw2QqOo5rPowps/ryto3XzjVRnUwstApkX6vpIaRxG84Yy8vfcoqZbbKYMYgsb7qz+G+FtH5ERQZ0EoMIyqPE/UwUebj4XbrdVWzH9dLGb7+fpciR640c6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cv3/oU0S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730981275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nLD0+YoqTN79AP/P1lf+vP+NfxxGZjptwbxxH0++QQc=;
	b=Cv3/oU0Sk7sFXGyk0Zv1RbCToFSsaYIS/9635+s5CPRjxO5rzZrAHBJv9gB89uvPOzS8o5
	LmLSuvrhO/xAkNNHuMhHM4bZkwdH65xgKryEjN5cD/CPXZ9KHEg1qxtDe2hC2lbS/XAX1L
	uUK0/LvHe8n0bIzOd5M40hr/kEg+124=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-5wLPvszJN6KhqDeFhpzYQg-1; Thu,
 07 Nov 2024 07:07:54 -0500
X-MC-Unique: 5wLPvszJN6KhqDeFhpzYQg-1
X-Mimecast-MFC-AGG-ID: 5wLPvszJN6KhqDeFhpzYQg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DFF219560A6;
	Thu,  7 Nov 2024 12:07:53 +0000 (UTC)
Received: from mheiblap.localdomain.com (unknown [10.47.238.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF8351956054;
	Thu,  7 Nov 2024 12:07:51 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: netdev@vger.kernel.org,
	irusskikh@marvell.com
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net] net: atlantic: use irq_update_affinity_hint()
Date: Thu,  7 Nov 2024 14:07:39 +0200
Message-Id: <20241107120739.415743-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

irq_set_affinity_hint() is deprecated, Use irq_update_affinity_hint()
instead. This removes the side-effect of actually applying the affinity.

The driver does not really need to worry about spreading its IRQs across
CPUs. The core code already takes care of that. when the driver applies the
affinities by itself, it breaks the users' expectations:

1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
   order to prevent IRQs from being moved to certain CPUs that run a
   real-time workload.

2. atlantic device reopening will resets the affinity
   in aq_ndev_open().

3. atlantic has no idea about irqbalance's config, so it may move an IRQ to
   a banned CPU. The real-time workload suffers unacceptable latency.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 43c71f6b314f..08630ee94251 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -162,8 +162,8 @@ int aq_pci_func_alloc_irq(struct aq_nic_s *self, unsigned int i,
 		self->msix_entry_mask |= (1 << i);
 
 		if (pdev->msix_enabled && affinity_mask)
-			irq_set_affinity_hint(pci_irq_vector(pdev, i),
-					      affinity_mask);
+			irq_update_affinity_hint(pci_irq_vector(pdev, i),
+						 affinity_mask);
 	}
 
 	return err;
@@ -187,7 +187,7 @@ void aq_pci_func_free_irqs(struct aq_nic_s *self)
 			continue;
 
 		if (pdev->msix_enabled)
-			irq_set_affinity_hint(pci_irq_vector(pdev, i), NULL);
+			irq_update_affinity_hint(pci_irq_vector(pdev, i), NULL);
 		free_irq(pci_irq_vector(pdev, i), irq_data);
 		self->msix_entry_mask &= ~(1U << i);
 	}
-- 
2.34.3


