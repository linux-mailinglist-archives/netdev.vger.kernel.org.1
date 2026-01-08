Return-Path: <netdev+bounces-248172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB04D047F6
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24767300FEE7
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474122DB7B0;
	Thu,  8 Jan 2026 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loIgkrCC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2611F0E25
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890613; cv=none; b=sMHLLdQiFK7DM9L07HnOFB9V2Ep3LY0Jixf9Aqcx1fX8ybLmPoojmQFZrppC88iU9LAlBRBtNn7zJBb1tbmXBL3gRGm9KqrIFvkqMPmWtfGgTjLYGoCIzRNx4Wgr7DuO2x80DYA3/oU07RLUayv1xBXEMZ8a7Fr2Rs9k+pfaTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890613; c=relaxed/simple;
	bh=xQACEz7s6jNsl7Ho1erfv2YqZYDG7xydPJ65zVcRSrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+kiG96sbg3DqJt4RXkDhU0F1pJsrnirYbHLdP0K8Cgv56KFTQe5Cd4vGJtXyjdCfPJOy9fWnEOHUqsLJiUVf67L9DhJYYdzL/nAMX/Erbd6AOwVELbfry2Lc6rN2HloW9Q/2cc37RcdRV5f1n57v+KSzPglaFvNDLhll+vad/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loIgkrCC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b6d5bd575so2609217e87.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767890609; x=1768495409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JdAeBL88xoS7UgCWkb4s+7iYieB6s8NwPA6lyDMFM6g=;
        b=loIgkrCCHM4cplJSOxW06yHVMAVUVmHBv/KVeehTXs4MKHhSzHyrEbMit4wUuXD3MJ
         U+QBy+4sFLo4m8YUtj8gFIObI0hRCMxgE0xnfZTR27enRq2D7ODub2eSkjjOUV+4Du55
         R3SAGTs6VpiqATKjQ6vbx25M6m2hruVgwSRVPgC2Mmoo1LKSoDAAtcg62ACPN4KnqvMM
         M+eKkY+oaBrNBgB1h5UrEQQi95FKfmnhZPYED/mCb6jqhEFe2CqnfmCRXsTe7eZ4Bjf3
         30tchWOzzRCOzTcI9/Dll7zZoWaNgnidIgZrVIf8D1W2qde1sQ64Ohx8bTzb1Ejk9P1a
         BbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767890609; x=1768495409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdAeBL88xoS7UgCWkb4s+7iYieB6s8NwPA6lyDMFM6g=;
        b=Rx7pEi2gRJ3/LlIdBkBohKr5H6SgghsdDtP7n9jPMQFkbZ6yIl+z1O0BeNm2KC5ynJ
         SCH9jVjBFZPfU7pWk9e7iJoaediubDVqs9to2vzrroiQxiBLgVqGdsU2Q+VDTPTqtCEg
         elIdE+X0KtmukdHM2wz6817KVRyXuc+CihsmnwXKDv8K5gpTGnHT876B0TH0HnV3JU2D
         vwHMtAXhz9+v6zjwR5hhT+yC/yJ2VI83yG8eSXsspOfLT0UrP9lg8dAMv1T2/RPzvXCa
         xKzLNTyDkObBvaRxYyoafKaggFVyhEQulKS3HZKqzdl35Q6tqkZWLPX6ZHLif9JE2/LB
         WziA==
X-Gm-Message-State: AOJu0YyFMWQjj0bKIXxOXjXKiFA2tYFZGbkwYWn/YgKgQmTA+WVPXrxL
	t16J+29VmeXC83dUdP2vtZIPwDpVKimgnOpzPwuWMRIEN+swc3oQGCM=
X-Gm-Gg: AY/fxX7OUIDxjnJc5qPANOw0soJI/tDRavG6lydWLXRjRV4ZTvKTgr68fRoyqBjSpHx
	CqtnrPz7VLd1Ebe4mdf1Q9YzVGFc9v8owEJk1yPYnm/iMu2YeTz5hjH6m/6y8STF0Nu2ZbQAv6p
	aKelEzF6bzAFU8s+RBaOsE9YrVpfi75dI8QIyqekgECPSHlj+XVSvyG1YsEdEpQ05SEibzfKQmK
	k0r/Zz94XvGdYlZlz2bNxT2l71C3+FjHc/9Dv1jdBRHLf9L0BRUyITR8DQeWquDYuEifvUme2Cz
	a+LkEX8OUnKYw0pEC/s1uBfoXUUnVFMmDdDKQgRO9K0Xz2aZAX7ClUroElGQLite08qg0PSMjKt
	OjlovNylGmlHv/JPHiRLBIkzarUeVl3dBh6GtRyNuavfOPepsBR0hTy/2eRmqe+H8mva7MzRPiP
	QlCHH4aKrzP1QJ
X-Google-Smtp-Source: AGHT+IFjvtk15WSd3WCRk/DAvZL8axgifBdzNQmKitYRNxaQKrvtp3LD/hQAfVAGOKVG8WSIPTTbEw==
X-Received: by 2002:a05:6512:15a4:b0:59b:7942:227a with SMTP id 2adb3069b0e04-59b79422343mr714210e87.24.1767890608259;
        Thu, 08 Jan 2026 08:43:28 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.43.86.16])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b792cf330sm470942e87.102.2026.01.08.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:43:27 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: vburru@marvell.com
Cc: netdev@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ rollback
Date: Fri,  9 Jan 2026 00:42:57 +0800
Message-ID: <20260108164256.1749-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

octep_vf_request_irqs() requests MSI-X queue IRQs with dev_id set to
ioq_vector. If request_irq() fails part-way, the rollback loop calls
free_irq() with dev_id set to 'oct', which does not match the original
dev_id and may leave the irqaction registered.

This can keep IRQ handlers alive while ioq_vector is later freed during
unwind/teardown, leading to a use-after-free or crash when an interrupt
fires.

Fix the error path to free IRQs with the same ioq_vector dev_id used
during request_irq().

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 420c3f4cf741..1d9760b4b8f4 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -218,7 +218,7 @@ static int octep_vf_request_irqs(struct octep_vf_device *oct)
 ioq_irq_err:
 	while (i) {
 		--i;
-		free_irq(oct->msix_entries[i].vector, oct);
+		free_irq(oct->msix_entries[i].vector, oct->ioq_vector[i]);
 	}
 	return -1;
 }
-- 
2.34.1


