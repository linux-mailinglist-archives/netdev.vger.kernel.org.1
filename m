Return-Path: <netdev+bounces-130542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48898ABF2
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A7528286F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849819FA90;
	Mon, 30 Sep 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc36TKCe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5307419B5B8;
	Mon, 30 Sep 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720315; cv=none; b=jbK7sWi26AyHcc3XQ7E522g5HVw18MxPHuIofEwwqBWc+fF1A0k+hSlzUctT+e8ROwH0juAUViQ7b5vfELU166/JSkujOGC3aJgGGXw2pXTqybs+G9HKL2V+E+Xblg+KztEPUDjV0N2Uk7FPKZlaYJ3aREqelGlBoWbRWwRWg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720315; c=relaxed/simple;
	bh=GwHU+XsAiYxMZdaaMiGMyEwVRRgDrPlyJrnPNW0Klsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyVd3a86/tY+vNro1aB70vY+xayUioRGMHJoUHhkeK45c8ya7NupoESr+mHNPt98bYf94K0rBKfH3C6yzTsxuFi2Aw2wZmOKtU02UUEVTGjgcZzycWMKss27OfqXzudjbI4DbVlpHV1xesAYrPim/0B1iHywwFWRyyZz4bS3ig8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc36TKCe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b49ee353cso30028995ad.2;
        Mon, 30 Sep 2024 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720313; x=1728325113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DAUKH2ZXJLhuZ+tX0oV+9biDNj8096e3CTTAZ5iFsE=;
        b=mc36TKCetb60aPzMfqD6cAx9CLEI/OpMjofxRA6OaP5R43O5jRh0Un0ctLbvcILyai
         yKxNO7g0bQImQe9pM1T0HM/PtvyeM/Gur+yDR2ThvEvF2QKwRoPKekKtT0iSqWJ6hIjc
         sPyVJRE/EoBqdswP7y1veqGgxGKXOiTXucaJQDadcZnda1mC3EyaY4LdVTQ8GYhQbhyX
         oMkPpxzetwV356zab+DDLFI8f7m55Tfo2Auy6h8HLfQ613vhojSct8xUKHgqkoVEuqCO
         jGV0ljD9INd8ClfimTOkhGXc21DvkaEqVSd9rUVs/knm9nUSo7rjVtx4bWLvxN2ppGIR
         AqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720313; x=1728325113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DAUKH2ZXJLhuZ+tX0oV+9biDNj8096e3CTTAZ5iFsE=;
        b=ggABeLHLXSrPBIjx2KC5OsBjaNFOxgq9eqhdkkrV6jm63iX7fznVDLoAvgQZjCPD0Q
         sPfHCY2gCektqU2Vv87vbmQN7fKf0cNCXmvbDylQRby2Kla7fuJxxeryFtAonx/UEaH3
         1LRAZlWsNwzfMDna+BX70h9ibQGZUiPXuLzO+0Cja3MMV6zVfgzUDoha+a/76MPMZ6Aq
         5ovWVQUC4oIlaD+ad8rGgrznB/jZNQb53mcfsi2xpp/BZh7sKjZaUNtraKITalK0bYmq
         +QM/W/W63eIQm0iCN5LQac6mJsEX/1zo6SReRipyWz/Sv+P3RkX/EmOu3hgfSkbSXNo4
         mD8g==
X-Forwarded-Encrypted: i=1; AJvYcCXBGDfKt7yTxaWKwDvlsMpePNqymeqCg+AKy9cEKKoDYJoM105x3TyIaZqzfGzjcfPGkfIUZ/hcmUCYQoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5k4c8tRYdRUVCxl7Y2lFIvOXUEN8PYtDvVa5ddFJZ+dw9g4lw
	18iVk/R8YYps9OugfkuKuT6OH296FT32grEcxYddYxMuWKVGpjuu/0wMKqhp
X-Google-Smtp-Source: AGHT+IHRyoXm2w1i4wRSyxqf/mX3BHtcGkAhICsB2tppE65ITKEBjN6tq6zcq3o93oysyKUAWKBQXQ==
X-Received: by 2002:a17:903:1c7:b0:206:bdb7:7637 with SMTP id d9443c01a7336-20b37b9b923mr228502125ad.48.1727720313367;
        Mon, 30 Sep 2024 11:18:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37db029csm57444365ad.106.2024.09.30.11.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:18:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 5/5] net: ag71xx: move assignment into main loop
Date: Mon, 30 Sep 2024 11:18:23 -0700
Message-ID: <20240930181823.288892-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930181823.288892-1-rosenp@gmail.com>
References: <20240930181823.288892-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Effectively what's going on here is there's a main loop and an identical
one below with a single assignment. Simpler to move it up.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 067a012a5799..3d4c3d8698e2 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1646,6 +1646,7 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 
 		skb->dev = ndev;
 		skb->ip_summed = CHECKSUM_NONE;
+		skb->protocol = eth_type_trans(skb, ndev);
 		list_add_tail(&skb->list, &rx_list);
 
 next:
@@ -1657,8 +1658,6 @@ static int ag71xx_rx_packets(struct ag71xx *ag, int limit)
 
 	ag71xx_ring_rx_refill(ag);
 
-	list_for_each_entry(skb, &rx_list, list)
-		skb->protocol = eth_type_trans(skb, ndev);
 	netif_receive_skb_list(&rx_list);
 
 	netif_dbg(ag, rx_status, ndev, "rx finish, curr=%u, dirty=%u, done=%d\n",
-- 
2.46.2


