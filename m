Return-Path: <netdev+bounces-200519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54AAE5D06
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 08:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CB0165ACF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634E323C51F;
	Tue, 24 Jun 2025 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj//vGz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FF20EB;
	Tue, 24 Jun 2025 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747429; cv=none; b=ZOTpNDNw5ABVdkhrFlqeP7TZL8c9pC9U1DZ+N+a2GD9KdEqMqG11Iux/MkmAtaz8fJp7/qXu46ATzMifnqSidd+XrIVYQ+Xb/dnOSagHmpsd8/Yo5dly+79VcHXNNnBV3Ejl69jJtcMJRhFyjYQa8+s8HUA/DtTinjjB4wTgIXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747429; c=relaxed/simple;
	bh=L4GYJ7WnogCyoWwbzC3vlkUvWMe6NIeODnHCROyYz7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3VFs1Pn9/kpO4raSy6FwQu+SJJ3/SrxHp5UHVjyMGctbARtIYZHw8sTy91ob/9t9PoTWk8ZAicyBSJU+K70yKNVRV+3BSuRVSxVrvvLHB9NdThSLr6+dmVD38cx3sOt3/jW2SirSj2IVf2OwuQ/T9A6/M52lF2hnsfyGzOpZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj//vGz2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a524caf77eso746973f8f.3;
        Mon, 23 Jun 2025 23:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750747426; x=1751352226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnGWam5zbxGBmywUHWKfJKZG4T2bJIUw+axMFwWdT4k=;
        b=hj//vGz2FWszeYomeCGf15FazUYdx6y+3TDnkudZK75nGHNVykhB/Qe0zaSvhn1oWh
         yHLQrtPMu8wrQM6Hzk+AwXslmzzJrEOZ6dI+TSiCZgGNY25CVXin7az+sIZ5PrYcxwoO
         iTY736ocruMhWGx5O6XjksdaFguRbxjXK4LBDoTjlGgDqvE/1G3DS+dxcez56vrDVUdd
         ADH3ynn5F/wbr1eMDJBGcrHAWfIvml3KO9u1MbhDUKxlSny2lDL1Z/H2dFIBoou95E0Z
         /UJq4ACrqiHRf6x+bSiE94GmoJM3oapQqb2rDf+MsAvcXVrxG4Nr0wbIWuRUQl+1j+v+
         +V4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750747426; x=1751352226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnGWam5zbxGBmywUHWKfJKZG4T2bJIUw+axMFwWdT4k=;
        b=ZKQbCbqy8gRn8XzJaI/v+IfLu0cEBL1o8E7zn7b0XXu9BMOD1kPK6Xe+wOkZzPKUPB
         LP36bRBmfUaY1coeBQwxyLaPj3d+rOF8qmOE4/03Mb4ihg7dsJjnDFrRb1M6rX5fQFIF
         iVq2fVJaV6W1Rf3c8w2pRk+Ar+uKnep/hqjwG9L10fjPoeE3PnMc0jFqgtlXPwf9D4xv
         ot39DkYSUyXoUi2uGkgoY8zy26R9MudJb8LGhLytr9anMp5cOaCpM8FtlGMBrkL38afi
         Oermgj61B6B1BqmRTAx06PnRN/OHmf/InxiyZ9Wrv/NtDoAjo8Pxx06UqSBl+ude9SSd
         sm9w==
X-Forwarded-Encrypted: i=1; AJvYcCVzFCs1yID6DJ3yvEA4nGVERUlfM7USioFaZ+GgyMFbDXYF8+/Q6LWLry1qn2geBvtlVYP3wyF3@vger.kernel.org, AJvYcCWFpLNJUFCOVvTKcA4NzDdh9TGW94Av29KJdv5DxCTf2QavggWW+rjb/sRvXgQGp9d6ogXiY3ujnvsWG00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGyB/+tYWvZa55L4X5MiUBKW3aJeLZjpRMAuri7KGtYmHTHHE4
	QyjITfsA7ectFOk5vGND7dilIzw1u/7p6JIqHoz5Hc3AaC6HeEsqD0D/
X-Gm-Gg: ASbGnct8JwMQoXjgdvv8bTPuZLlG1y5ZscfYee0lnpaRA42JsoMebSu4r7VtZhkm2MT
	ndRM3MnuEDPJ5qF6w1MgKVVHDtZhfpYc2pxqyZSqK4BNadUhMcR0o4YU/sUPtT5VPM63//e7tq5
	up2xkSGmsOHS399CNwZPOPq0xD9LsMc5pjg5a2MxdxJrzUL/8rg68xmQBNLOoaCr4Q+JUXQwT4i
	NjXzACWNpLHD1BA4rIvjQZVJ6+QUMjlLLAOSbXOfb64Her6SlPGQR+wFP9JYsuh6VJYbJ1xjulH
	4fDKT5O5sYp1BbUixt7J6W8S7vdHCfwOewffIxdEY2HINC7AYcSfYwgC69qjuYajs7Ac16ihAne
	k5OT4wqLetrpeQY4=
X-Google-Smtp-Source: AGHT+IEQeaNWL+nIfWE8o877o+qJuDgoiHjgEWsSgWkZ36OOPK0iUTjGa9hQ8DIx/XGHHPG6/YNJww==
X-Received: by 2002:a05:6000:40c9:b0:3a4:eeeb:7e70 with SMTP id ffacd0b85a97d-3a6d12dfaf2mr4410338f8f.4.1750747425810;
        Mon, 23 Jun 2025 23:43:45 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:8406:1ce9:dc85:fb19])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a6e8114795sm1110767f8f.92.2025.06.23.23.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 23:43:45 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net (moderated list:ATM),
	netdev@vger.kernel.org (open list:ATM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] atm: idt77252: Add missing `dma_map_error()`
Date: Tue, 24 Jun 2025 08:41:47 +0200
Message-ID: <20250624064148.12815-3-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/atm/idt77252.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 1206ab764ba9..f2e91b7d79f0 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
 
 	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
 						 skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
+		return -ENOMEM;
 
 	error = -EINVAL;
 
@@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 		paddr = dma_map_single(&card->pcidev->dev, skb->data,
 				       skb_end_pointer(skb) - skb->data,
 				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(&card->pcidev->dev, paddr))
+			goto outpoolrm;
 		IDT77252_PRV_PADDR(skb) = paddr;
 
 		if (push_rx_skb(card, skb, queue)) {
@@ -1871,6 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
 			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
 
+outpoolrm:
 	handle = IDT77252_PRV_POOL(skb);
 	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
 
-- 
2.43.0


