Return-Path: <netdev+bounces-234672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03551C25E6A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A236C34FE80
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9C2E7F1D;
	Fri, 31 Oct 2025 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEGNGhA5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782302E8B74
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761925947; cv=none; b=YNTArVEao+z16hNaHifSa9XbsJfWDd8Eqn+2grgaNQBYkBFvqs1YcnNUVgKfUWFWmI+ZSD4DPD4X+ofpnb4QrB1iDCBg1kDnmD0SxgzGmLrll8rCE3N3K9OEpGaMDbF0Nz44mKDa/f/JSwGON+SSVKFbahzbbEamsFGTg7pmCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761925947; c=relaxed/simple;
	bh=DTqeQPUFGhxWmvFq1yJ9JBIJPtT4dJ29vTrGDBXzgAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cv8REaLn74zC5kM8Um4Mz1Aye0guRvL5WAOyf2gbQudKSH9Acf4j3d7PNPk2sdhYTSQIAgDmp/oIq0N3SrTwYAqcFLlsjQ9HNmmFN9qtu43AWEF3uz2Kezi8B/y09IFgHVjHJTP8dcFiDmKcKDQMQbW/PaCMGIBNIBLR24PeN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEGNGhA5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761925944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z5xCiEdgSHZTgTrYV1z431hwVbhyx7WNnCaxg9jd68o=;
	b=jEGNGhA5YVxEb1rYIZPt8OCNQ4PrvdwqgkHeTPUNaYPJUVxFMgSsUKMQCEIKGivyJQSN0J
	hYqbg63TTbgJ8ddHzkrWwBD8Blmfifl8vxc98lyZzgy1mmNW5onIFypgAMFr5n9ap2/CAT
	gWvPb3H6j8Z0nJB2hTTlD58jdsjkTHE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-JCoHdGroOvm_D0Uqh781bQ-1; Fri, 31 Oct 2025 11:52:22 -0400
X-MC-Unique: JCoHdGroOvm_D0Uqh781bQ-1
X-Mimecast-MFC-AGG-ID: JCoHdGroOvm_D0Uqh781bQ_1761925941
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-475dc22db7eso20631835e9.2
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 08:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761925941; x=1762530741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5xCiEdgSHZTgTrYV1z431hwVbhyx7WNnCaxg9jd68o=;
        b=LoWGeJFNFWlJDpfvNyfBPMGcERz9/WUaDDG02MnnnVOF+ONpwc1fVOmlUTuu9pNewB
         2cfPZQrSGLb58QgJQzIdTDkp55dBV+S8yhqf0KIM9/9US8fig8OZS1sqTtNhGhTywunE
         ckvdzEozGwg6hkWbviYNVFbRS5G+iqGs8FPLwEYsGzJu/IYtWvX9qju6z+9ypmyZH2Wo
         v/Hcvuek1bg1eDNpRD+EwI/yFASmNrIxPL1ra0xiJQJ/NXoXnjF4TFIhf2rBusHmmkML
         OHwqoP6DhHuud0rDptjD0LagZFsssfjxBOBHHY+y0jaSAyH3y8sMa8ym+v2Z+DpIzr/a
         1CIQ==
X-Gm-Message-State: AOJu0Yw6RE+kavsWEe6AN7AeFTkrQ5y/mWpg3QemnDbVQZfHCMI+xSLR
	0M4ohQJEMsPNMMhuhQ/0447W67e+c84Nj7mn4IhBi8nmRrZRD8RPwRjSwirYfzI12s/VpRe9Th1
	BvsnxDH9wYBbmzeof6ax2n+EnQ+WTgMfBFTOaLLMOrlaP/W5q45rIFoZoF9Nmj7xqIJmR0Jz+2T
	njWvq7KCwAlT2NWNKwuZMZ4ZhoeqDPThoNGDYEug==
X-Gm-Gg: ASbGncsm42JLFWv+YvH7SHAle1feSJx2zs3d9Sr6GhoC/ry6a+IL/z9mW7fAvUkLdRO
	6o03KwIsACm0hbhk8x2xC1rudLANwjpw3k0BHZZy7eHGCNbLGV+F7QwnZ2x+h7i71fqoqLymo+2
	ruBrGl3Oh/X1l3ggW2VuQg2TaiVkaMYlDyZSAhqLLlU9BdcXqALs189K33bJNSygVcfV7X4XGNo
	TRx2QN8rysfvwPwrUxbFXeTLuK01jm6nwfro/JhTFUvajTxgqiCHoI5+j7k1es/nZdYzN8cmtTL
	QN6M+H43gvgF2RIA+OFWmwUFeju3RwlTLSqNlRMmUwp/qP1pQdaZlt51sWlfjUWZuRQXgsBDyoH
	tuYSeh7fOtqICYIWqjSmc4Xc9VLN5+kx7yeE98Zsg
X-Received: by 2002:a05:600c:8185:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-477308a690dmr41197535e9.35.1761925941259;
        Fri, 31 Oct 2025 08:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEanoHG78+nXQjyWOPkdXL+HXisIrVcrowR8akvkSnQDPibiUfR6s70OaaMqWF0WroV++HEkA==
X-Received: by 2002:a05:600c:8185:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-477308a690dmr41197215e9.35.1761925940777;
        Fri, 31 Oct 2025 08:52:20 -0700 (PDT)
Received: from fedora.redhat.com (bzq-79-177-147-123.red.bezeqint.net. [79.177.147.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2ff79bsm4100635e9.6.2025.10.31.08.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 08:52:20 -0700 (PDT)
From: mheib@redhat.com
To: netdev@vger.kernel.org
Cc: brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net 1/2] net: ionic: add dma_wmb() before ringing TX doorbell
Date: Fri, 31 Oct 2025 17:52:02 +0200
Message-ID: <20251031155203.203031-1-mheib@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The TX path currently writes descriptors and then immediately writes to
the MMIO doorbell register to notify the NIC.  On weakly ordered
architectures, descriptor writes may still be pending in CPU or DMA
write buffers when the doorbell is issued, leading to the device
fetching stale or incomplete descriptors.

Add a dma_wmb() in ionic_txq_post() to ensure all descriptor writes are
visible to the device before the doorbell MMIO write.

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index d10b58ebf603..2e571d0a0d8a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -29,6 +29,10 @@ static void ionic_tx_clean(struct ionic_queue *q,
 
 static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell)
 {
+	/* Ensure TX descriptor writes reach memory before NIC reads them.
+	 * Prevents device from fetching stale descriptors.
+	 */
+	dma_wmb();
 	ionic_q_post(q, ring_dbell);
 }
 
-- 
2.50.1


