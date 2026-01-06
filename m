Return-Path: <netdev+bounces-247334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE1CF79F5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF11306F8D6
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41973093AC;
	Tue,  6 Jan 2026 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGhsONEx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BF2E7166
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692946; cv=none; b=LJwrWJSL9AJSPRni0dn71aHZeZGNbT2N6q9WLTGIyIP9W5R1B8YQ9TlF8K+CV5ClrciePFW/DWNDXTjUkcfk6grIPjPrO9fjURFAM2cLjPFK1SlNem7dybXkZMe3xDnPDZ2VPKUilJAhUKinh48BFrsEGud9yz68rMvS5vjY0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692946; c=relaxed/simple;
	bh=93sInUW9zEA86TJ92/hM/OPNM3sAV6MsWLI7AyWVdm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V63CC6mikVYOJ9EFO8P1k8soDLok6+es7xKEdpcubROMF3XRJGh05KPNlSJiWtzbaSi2A2Re1ysTYu2kXz+cvUA/qmIJq0h6J/lYyRwZsmI2GAX7SbSlZ+p9/KuaYw1sLoee1swEh4zdj7Ob1sznIdaRcquKMYPDJL1HWgS0vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGhsONEx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47798f4059fso1113915e9.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 01:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767692943; x=1768297743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdSCrn+/q0mZzBSTq1BS80pekWEZnQx2RMu8OndDeLE=;
        b=bGhsONExMOpFHhfHnDMLcWiwayhtQNSdJy4aiS0mU0IdC2lwyz4oLSeALwwYqQD6/v
         2byTyN6a0YyQ+6LhNRzi0XA82d2qVgUf5gPlVXjC4oQu6WzRqDZ6mD2+PKMbFm7p8fRb
         U+qbnjJB7Dc/W9uAbHukmnzp1sWDlrHyeug9PMUDQEsPhHXPoLKTwfVscZmH6PlEaMaV
         ayp8O3P//GMPSjWjjTCaaPJG0whykLwnLit0pXd3Fbct6WHjWAndXnFyA6wSyCxRF0vQ
         f+iEbphTz6Ofarb4+3UPImOENEl1F5PnlRjlJX3iJI5zv5Zw/DJn0MZlSkUtnbqes0GX
         +D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767692943; x=1768297743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdSCrn+/q0mZzBSTq1BS80pekWEZnQx2RMu8OndDeLE=;
        b=A33oPitwE9ldOJ/rKcMundNUYLFy2Z2TDuhzCVJWYflA9GsmNv995WoQELXRArmcj0
         36/Z32XHYqq2JBuzuxn1fI6ewzEqzTOuS/vMw6CCFoj4rY3JG1PTcOZIEhBQf3zKphy5
         wemTP7AB67j7rZcvPNb8yp4Q0rneg3JIr9KZk3FdMfhMQG92R3umkB+K8BI2gnVyT/Ph
         BWBmaYq7MGKt6PfTek+eJN9nylRiyFN8KChBc4Bu7S9aGQVCS87CmP6ALR3JOFLRLHvs
         bwajuH1S7YLFNm1wS1BYOl/WDJZltpBp0jAbqyEqrP64BH5PJISysHmuQbbG4/AZ/D5e
         gTqw==
X-Forwarded-Encrypted: i=1; AJvYcCU8m9FuBzOaIeGMlJxS5a6GuWek9CJTm0vExNLCO6Wor3ceLmkYKFlKtqi0A7V0sC2BsISgrzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29UnEY/C+ek+1FY2qQlSGjHaQbVwgFY2limGa+0fXOELs51Ed
	MzHYfjBVmTyMCN6IKXeg4HG/YCsIJextFom+G0VWRiD4XUBopYeLNpTj
X-Gm-Gg: AY/fxX7FyTPQmFVnzofRJPYRcZr24ZqOV6t54+Rio/kInw5oTpM4M35ZGsy2bkkHFyt
	4/eismPGK51cfGXWaftaM3VG+qWKPmwZBD/U5ecOZPZWvPrK6ZdggNoVURbLFoW/fDOcFihMIK2
	R2ubMhHZlhWIGtU2j0+BoBWr0lJ7QoVNQPrYRWgA/X+0Fw79XQ3SBfhAsgZdbLbyN/NoWktUv1H
	Md4/AnsBPC55tEyQpZrlRoDgZlOv969XbgM2z6ivAEzdLkCPj5paKlQ7sZHiHNmDxmiziky3XZr
	Za5FidHzWbYKymK3BDBvD9e88r+TYT/dv8ILa1oHKAHoxcW/0W87d5xspxuyni4OhQnrbNu3kGQ
	20tdcuZ5UVcDjWDGnkoFyJcpUTd40TWopsSOldvlHPPMi4oRELoqVv3tH0UJ4epGpall1/Eh6j/
	y+WANFPm45z4qxUm7f3AmySIJNecOO09c4NOYPosF9P0KZNxmqgA+96g2QJewxqvQ66rIugT+ZO
	o8qhic=
X-Google-Smtp-Source: AGHT+IEx2UdQuxi7Q30O0PMFfygpPYTxnIeUBD5iNPkUORydOgAHKzsNi0xUzYgshQ1Av83QPmgZtw==
X-Received: by 2002:a05:6000:2883:b0:429:d084:d210 with SMTP id ffacd0b85a97d-432bc97d535mr2100593f8f.0.1767692943323;
        Tue, 06 Jan 2026 01:49:03 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm3330081f8f.29.2026.01.06.01.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:49:03 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Steffen Klassert <klassert@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: 3com: 3c59x: fix possible null dereference in vortex_probe1()
Date: Tue,  6 Jan 2026 10:47:21 +0100
Message-ID: <20260106094731.25819-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pdev can be null and free_ring: can be called in 1297 with a null
pdev.

Fixes: 55c82617c3e8 ("3c59x: convert to generic DMA API")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/3com/3c59x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/3com/3c59x.c b/drivers/net/ethernet/3com/3c59x.c
index 8c9cc97efd4e..4fe4efdb3737 100644
--- a/drivers/net/ethernet/3com/3c59x.c
+++ b/drivers/net/ethernet/3com/3c59x.c
@@ -1473,7 +1473,7 @@ static int vortex_probe1(struct device *gendev, void __iomem *ioaddr, int irq,
 		return 0;
 
 free_ring:
-	dma_free_coherent(&pdev->dev,
+	dma_free_coherent(gendev,
 		sizeof(struct boom_rx_desc) * RX_RING_SIZE +
 		sizeof(struct boom_tx_desc) * TX_RING_SIZE,
 		vp->rx_ring, vp->rx_ring_dma);
-- 
2.43.0


