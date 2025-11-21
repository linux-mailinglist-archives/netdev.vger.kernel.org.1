Return-Path: <netdev+bounces-240752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F848C7908A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 13:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9900C34F68E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781E329B78F;
	Fri, 21 Nov 2025 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="x2cYE6XQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF9E3F9D2
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763728830; cv=none; b=dLThQv/CH5N0+EvKuGVlhHNSMjd0Jl91oAb02wdW/iszCxOGamZuQDHrzeJlVyxUzFqeI9MzkVdMKgnQQrqr4yEGMhnfRSWEXuISiz4RGl111ywygrEEHQRVggcIKpulV7gogwaLlsyGyxC3TRj7FbCU7ewIdJwfNb/7OrJNOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763728830; c=relaxed/simple;
	bh=i1uLnkPoUTtEHrBR04I3kIB5zXvut6plTeBjMylTCGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XrxhFnWcwDmp7ew26DzeLjInlI0egA19pUoNy/Bc0JvkO/4nostQZ8lZQnhYGG3CBnokYYwL2BcgBSx9nRC6GsUcgOLtsXyrzOpSqxAfZCMPXYXR6mqN5UmGZ3JNDzKtgdsHplQrlM4LFDMKrnwwosE+uBju2GAPegxAfDFPPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=x2cYE6XQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-594270ec7f9so1797637e87.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 04:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1763728826; x=1764333626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfIoi2KVtR38VRU95RoQGuHMuLX6n2b65hkTOwR37sc=;
        b=x2cYE6XQ2Js3crNlmrQcfHQhaFJqjSM5HyJr7RDfrzkhY42WoeX/G7BS8be96t6KUz
         o5Sk74bndhK2eUmvdveLfD/1n73RN++AnjMuRVRbqAjaDchqgL4qZUh8f1EJB+jnRXvZ
         LzEopM6Pplu4dlxmHD6QUshLAyTN9xlpXMsq8aQi33+6QsiYA7R9hh37ixTJ4DB1WW85
         1D8q6EfxuvLpwl7fV0L2qjIQhBYPr10TRq7LSNqWel8zMbK2DvDKaoyH6kdgHC95JKqv
         S8oMKD4wfxLeBG3B4ZPdA2LJHx+PYDV6hFUSW9cYI4GxoDfwQkiyljmRRy78gYbAYL2C
         Yt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763728826; x=1764333626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfIoi2KVtR38VRU95RoQGuHMuLX6n2b65hkTOwR37sc=;
        b=X5klgv0W9ZvDEfKfI2DN75aKt5YqgG8QV3fJvvMumnnbWjBO65z/OrvP2bs+JIO5oR
         Jcx46zxYWMo6hjevsGm5S8PHXqqBz+/QXY/055xgqC8LwbphksB9mMatYISnSwZHUWDk
         cFs4NE+EA7Ea6AYFQrhzBFAcWGwIAnD3jY3WXI4jJR0RCBjmP4b0JBB5xpQGYPi5K/Co
         Si1s+CvXJDBmCApJ1ZkaWqLcbUG1+s1/a2I0RIonKT91NVqJcmMCpHkksx2C3BcdSg4O
         cGaiFBIj8zvkRcIV93iYDh5IIXjmDb/pOymE8eZXPEp4aQKXe2POAa+yRmfMrq/VJ40z
         HkMg==
X-Gm-Message-State: AOJu0Yyn8vBOw7n3ghiO5xP8/Vd9+kmyKnrOW7b1zpgQKo2hl65J64KZ
	dstc2H0ieo1blLJ4zYKzbRG5j/XcGtIum8Rre+vNGc1ou2+kJrMa096sRaI86kJEobWZIoXK0y3
	oS1IzkUO4
X-Gm-Gg: ASbGncvF0dNzOPLIeA3jZQIh5SGuIzVaEvOX3tc/TPSqfZX3EaX83CLI13m2Rf1c9cT
	JfE9hIvwEUzO0sFnkbJGxtIRSwdjbs3CZUbj1Bfa5IO4lTN5kvJbBgqVtx2oUOZ1g8hDDIKeA0l
	uPoPp255e4actYpZO1hC+dabIWMGDB4qK0vZYbu7mSCq/kol2cBHYmsmBetowDrPIiu8pt+gHCt
	k13vsEo/lppTZsmUSbD4I68ehPrO/bsdKmqmeq6kMolZ5ySH6o/Qx5sLpR+3+8mMrzreca2SRd/
	AAJHppuDh8T/LhX01IZBSVwOuZ4FIyjaHL7fhiPNzB1vhDzVq0uqZmnQDOMQv1NYw5VRbfLEj7C
	day6CGoT5hLse86+sHdAjdPHzAKwa6E97VgHIIK/E+VWilybJShszk911tpyAdn6pwv9a59wHbZ
	UgEkofabV+hzTqpDZsV2E2IeYOtDrFrxs=
X-Google-Smtp-Source: AGHT+IF6lE2yXh9bGuoNGn0o9vw7vX/0I/I9l0aEn8b1dNuEntqH9d2DUXsB7cktNkydjuXjqL6alA==
X-Received: by 2002:a05:6512:308c:b0:595:8198:51ce with SMTP id 2adb3069b0e04-596a3ea005cmr805227e87.15.1763728825812;
        Fri, 21 Nov 2025 04:40:25 -0800 (PST)
Received: from belltron.int.bell-sw.com ([5.8.39.110])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db8b4fdsm1590603e87.40.2025.11.21.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:40:25 -0800 (PST)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: netdev@vger.kernel.org
Cc: Byungho An <bh74.an@samsung.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Girish K S <ks.giri@samsung.com>,
	Siva Reddy <siva.kallam@samsung.com>,
	Vipul Pandya <vipul.pandya@samsung.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH net] net: sxgbe: fix potential NULL dereference in sxgbe_rx()
Date: Fri, 21 Nov 2025 12:38:34 +0000
Message-Id: <20251121123834.97748-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when skb is null, the driver prints an error and then
dereferences skb on the next line.

To fix this, let's add a 'break' after the error message to switch
to sxgbe_rx_refill(), which is similar to the approach taken by the
other drivers in this particular case, e.g. calxeda with xgmac_rx().

Found during a code review.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 75bad561b352..849c5a6c2af1 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -1521,8 +1521,10 @@ static int sxgbe_rx(struct sxgbe_priv_data *priv, int limit)
 
 		skb = priv->rxq[qnum]->rx_skbuff[entry];
 
-		if (unlikely(!skb))
+		if (unlikely(!skb)) {
 			netdev_err(priv->dev, "rx descriptor is not consistent\n");
+			break;
+		}
 
 		prefetch(skb->data - NET_IP_ALIGN);
 		priv->rxq[qnum]->rx_skbuff[entry] = NULL;
-- 
2.25.1


