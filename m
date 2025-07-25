Return-Path: <netdev+bounces-210051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3196BB11F63
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 15:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97044E5823
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2419D89B;
	Fri, 25 Jul 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCWzyzLY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D749475;
	Fri, 25 Jul 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450454; cv=none; b=dC3KyKUAUvS9ZtImudZOX/aaexlIgTO6yEe+ndrCS/kp2fAgYAaQ2tJpkfezSBfNwERcGG/DpX4+gboXyi8RnE8+DqZW/dTTVn0f6QoPv068yAW+4mYc8+5lh+PZ3Eccn065xLfx0GD75UKmjM7RM0up9iNAOF4tOfKon/hHOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450454; c=relaxed/simple;
	bh=npbPwPwPnAlRn5kq54i/SmQHlTeHdREVdeflDeKYFu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqh+q0pgmrlCfkZ8w0J+Ja9OA4lHauZD9C/1CBlaXY0LqoS6zC/CHd2+IyybK3dCy0pnU0BL2Sxb1m6twDZyExj1vqyn0Owp6EqOrrTTc8OCvslIkUaFQp7Hl/aP0JOCuihTu5yKBmuDoykDq1DVZLuTqQLUMbOsCVUInGWISsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCWzyzLY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45617a1bcdcso1231585e9.1;
        Fri, 25 Jul 2025 06:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753450451; x=1754055251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4fkWohIN9Tymim1ViegWsddn2WdurixVR25PkINhrM=;
        b=LCWzyzLYYz77m/5KDatuye0+Bd2dVH/aE8sfgkKW/4msMGFVZL4YPvcpoftUmgsS7q
         xUA0GxJFUn6r0rC97PyVdIyUr4SZVvgfFKxJSMFG5SKxwpHuLRk/34BNqxip5CkfFa17
         2312HAD48CT3n5uhj2v0aA8LPXkqnvpDQL9ZcKkLywMr5N11W94glJD3lpk/fKL5gAzf
         +dh0nB39y9AilAF5rCF/336jaHZgGu/o/b0KuNmvd4+Xc6KxPYYYaNTHx+FP2NJLmEU2
         CDCzY54TO8ucji71OeUO1BC/EP/9r20sQchDJoZRF2qILQvsPNm2gSviHoGezTwwlIHD
         YEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753450451; x=1754055251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4fkWohIN9Tymim1ViegWsddn2WdurixVR25PkINhrM=;
        b=wiE2Yjy/Ev8RavLyhkptp+zkzrDeL+uagLviqreMvDfFufW64UpRAUipRAkDeslWyC
         Qfs5VbaQmHZR+epT7F0wDo2bgHUtblzvkEvYT9eJijwfrsSJ8M2T5TWTO8zS8ULq1An6
         7xstSecCwzDmuEkV4kutK/lfD+5sTs4ouhZXv/21QqNXE7bNnPEMGU5sQbqeS7vdWGIs
         X0VtgXh8gD2a1lbPN2znn3/F+8W3x5dRIqRV6iB/cFfCzt3hKLbOeBet3GrEpqyWwRpe
         kKXnAoSsiK537VdQFyuTrUCeWepz+16WR74CXdveVTGD7hZONq6aBCrB2ZUAMI9rLjEk
         uRTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWavzYtK1xc4za+fEn+O3ox77jTBqqRpD0sna7PE5r2vAWsvU2r2vgF+rgsvK/QRMdJ/TVA+PjHuMrfak=@vger.kernel.org, AJvYcCVb6Nu1Cxf+synBczKldLMtZ0tcF7Lb4Ko9TbDps5MIJco5NhQ4m0DJeMr0bPGyd35aIEhVHkU2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9troMaihTxRl0g/CN8TA3qaJSEznbnXk19yJIAm/TajREcSeI
	QDn6MwLPGzVTPiiuhR6nGYQc3lnHmmNsk5FsMohmb5t8dm35zUGX3DaA
X-Gm-Gg: ASbGncuhaYMnzdy7K7T1CoFZhDCsbOIXkaa9iMLgNigtNZVLzsmHYvjbpSo36FWSDbQ
	Gu0brng6kQxJDenDRa/ylw/rc/TIKYT57x5hqlZGoS1LYVbTIpfftM91nZc4LVj9AZjtm9lAYu3
	KUJwa3U4hM2s8nOwJXsNlTpHzugTLGPrUm1JJbJKFWo1AO/cI7/DWDVG5lO0+XQX7VdO9TiCxbB
	sggMCeiv7R+tcFx7nBAgKclR9vPTyNd1wt97/zKoHa+gxAG0jAgSi67dHxqEIOSW46ZN9Y1oR2F
	YgQ37b/FV91DGLa2zvSg289L9j3A35ZdzUuX+4oJNOHMGNVSZoAca9Zofcx5Szh6zEtDEWOlVzU
	bl2/9HXxnfflzxWiZQ0EhHMH/XdJHrM0C15fkWGYLWSjnkQ==
X-Google-Smtp-Source: AGHT+IGr/2sDO56DQrdwx9I1xVo2cv39WgMClyR+5CETmj47IFNUseUrArHv2aYOr68iQ28812AK6A==
X-Received: by 2002:a05:600c:5253:b0:456:1823:f10 with SMTP id 5b1f17b1804b1-45876676a3dmr7502385e9.8.1753450450476;
        Fri, 25 Jul 2025 06:34:10 -0700 (PDT)
Received: from thomas-precision3591.. ([2a0d:e487:311f:7f4c:22d8:dfe:2923:8b81])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4587054f22esm56287005e9.9.2025.07.25.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:34:10 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: nixge: Add missing check after DMA map
Date: Fri, 25 Jul 2025 15:33:04 +0200
Message-ID: <20250725133311.143814-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99dd7..027e53023007 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -334,6 +334,10 @@ static int nixge_hw_dma_bd_init(struct net_device *ndev)
 		phys = dma_map_single(ndev->dev.parent, skb->data,
 				      NIXGE_MAX_JUMBO_FRAME_SIZE,
 				      DMA_FROM_DEVICE);
+		if (dma_mapping_error(ndev->dev.parent, phys)) {
+			dev_kfree_skb_any(skb);
+			goto out;
+		}
 
 		nixge_hw_dma_bd_set_phys(&priv->rx_bd_v[i], phys);
 
@@ -645,8 +649,8 @@ static int nixge_recv(struct net_device *ndev, int budget)
 					  NIXGE_MAX_JUMBO_FRAME_SIZE,
 					  DMA_FROM_DEVICE);
 		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
-			/* FIXME: bail out and clean up */
-			netdev_err(ndev, "Failed to map ...\n");
+			dev_kfree_skb_any(new_skb);
+			return packets;
 		}
 		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
 		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
-- 
2.43.0


