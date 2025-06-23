Return-Path: <netdev+bounces-200265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565DFAE404F
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875863A0718
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82DF23D297;
	Mon, 23 Jun 2025 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM9Mlw9n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05822257B;
	Mon, 23 Jun 2025 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750681609; cv=none; b=C8cO8VOSipmJnO/J+BMns756ncXdLBqq2R0FE+DS1VIbZTj7K4Dl3Anth6/b78HwHEtlBCTUqvtxV1SwxiK0rZDhjrDzK9+kfy4Vp0VwIRWKG8dA+jZ46xcXK+cgKxsMnsMO5ebJjot9RduuuHutf4ynS7GLTUGDGXhVw6agT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750681609; c=relaxed/simple;
	bh=lCMqvQXJ0zXftmACn8xdaAx2uVjeggSEzNAyfh4rhGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7mkdIuEeItEfx4WRgANHJyvgSZxIVfbnIA9AxnqRgzJgMJRCVTaJ23ZK4E6uVxuEqmes/eQomweVg1whcMSG1K/oN3j7Kef3Ya85ilIn2z8eT8UbkQzqOJxeZhEjlcgAB+TUXRGU0mADu9PKgQ9SZpeXzsske6fZi/zuFPAv7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM9Mlw9n; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45360a81885so1299465e9.2;
        Mon, 23 Jun 2025 05:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750681606; x=1751286406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NR9/FTeBZfjAoPJtsHg0ijiEDXN1eDhcREGD/8jefDQ=;
        b=WM9Mlw9niaZBjA7OkJpA1TQ8WV9omDM5VwrVe3eKQZoxbfMjoWb57ePFVZsWt7Lf3g
         GnOaqQe0UNTcf3Q8PS2+l6WypA5+90QNLHj5jI7xsQH159gYeB3ACazEvJblOT0B+9j0
         QA/WgvQUdlLEgG7AsXdm0r3Sj65NQ7ezCyCIEi2ESnz0+WtZLtOTm4NRaZOfwR1Hjvj5
         /KfX7CECVWNTj0vr7u7+EhebzZNdEpaRVavP7wPqDzwbvygeDfXJTmG/Oa5qi+mUKSK4
         vz59llbL7JU3BbLbygPJS1fA19QnYIx+j/FYDFmxszFk0bGM73y8hzW2Xd+i+htCx1Kq
         Ca0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750681606; x=1751286406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NR9/FTeBZfjAoPJtsHg0ijiEDXN1eDhcREGD/8jefDQ=;
        b=U11pN2q2I1AKpDtWRt/UHgnj/LnoHAbn7+saJVLjfEskniSe1rDqX6RMrAnA14fHTB
         gu/03E2sy6mtGD+1IjAOewiTJK/zK6g0CzSrDd6mXSeCh/Hik/HJMHTzOqGv2g3firrD
         JoM+//rzXECXRGWzVc0QO0j67NrfjJYC/zPxm3LHT1W9070WT9lgzvMe46atrA/MCL8z
         sxdzBTVAcsMalAppvfDkADG6Ilp8ScrSIn6gZftvEAVHXnU7xzGfzOuce120KwFfvz+B
         Le7F97GshtKFaaUQ1FgWcGMuXNVBTN6G5Htt4wBiEo1Fo76qeixxZUMnWhSA/rRPQb+/
         LP+A==
X-Forwarded-Encrypted: i=1; AJvYcCUmmLnVz5gj3p3TmhLihHDDHNfLfs1U/rSH4NwBJPTLdcM+SOkUuhzWbjBoYQqNEPgVKC3HHYwDIc7Aq84=@vger.kernel.org, AJvYcCUyvIXsc9/02Fwn0aDv1SC6ncLFbtKSMxoYVUL7QOp3aRNrvJU45wKQj/tZ63lm8KO70zuEl0MF@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHRvzql/pfl9gF7L7fwWtRz7JrRwFPrSFsvV0azYx56y2scnz
	veetadwSXBbvYbwaJnP4HV0Th5xndIVrdka1HheWQH4+MU2oZEP58HtL
X-Gm-Gg: ASbGnct3PrnhEHs2rMJQMj54MP85LLL7ifjJJTglZUDa0xzsZeS0mnxXDcwsWwkRg1p
	wdEIdmuy5fxSMf9+KNDCBnZyadEGggEhcWl/qvi9ex57pGJ/pWhdPYD8Og+C5DT/eehFy0bIGzt
	PP4psaRGCCfHYa/Rb27Je+6WH2KSw5VbWQ1xMppCwDPf0BndrP6R9T/x0TW0MGALeDwb0VMPj1Y
	l0RDr7cVnJ5D07SljbIQhFua8aUkUJatJ6ndLy/efIzEsDz0V3MUcECt0NlxuNv7/DIj0rthcWI
	i4kcYuyNJm73KiblITMZjTGYNqTp3dX+/FJy1o0sqXFZk9YI0i0ihEk80zADnMB1BdpEBkqkChj
	TJTa5AGyoveWs5w==
X-Google-Smtp-Source: AGHT+IEX9C3+931olKDRW+62b8ghcD3np6als1gSZSaeHy7Q5y3LmKGhDxKSJlnDSctSs7kgDpTk7A==
X-Received: by 2002:a05:600c:1c8f:b0:442:fff5:5185 with SMTP id 5b1f17b1804b1-453659c40b8mr45620765e9.6.1750681606204;
        Mon, 23 Jun 2025 05:26:46 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:e50:cae5:aec0:9574])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453647071f4sm109848205e9.34.2025.06.23.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 05:26:45 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Santosh Rastapur <santosh@chelsio.com>,
	Arjun Vynipadath <arjun@chelsio.com>,
	Michael Werner <werner@chelsio.com>,
	Ganesh GR <ganeshgr@chelsio.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ethernet: cxgb4: Fix dma_unmap_sg() nents value
Date: Mon, 23 Jun 2025 14:25:55 +0200
Message-ID: <20250623122557.116906-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 8b4e6b3ca2ed ("cxgb4: Add HMA support")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 51395c96b2e9..73bb1f413761 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3998,7 +3998,7 @@ static void adap_free_hma_mem(struct adapter *adapter)
 
 	if (adapter->hma.flags & HMA_DMA_MAPPED_FLAG) {
 		dma_unmap_sg(adapter->pdev_dev, adapter->hma.sgt->sgl,
-			     adapter->hma.sgt->nents, DMA_BIDIRECTIONAL);
+			     adapter->hma.sgt->orig_nents, DMA_BIDIRECTIONAL);
 		adapter->hma.flags &= ~HMA_DMA_MAPPED_FLAG;
 	}
 
-- 
2.43.0


