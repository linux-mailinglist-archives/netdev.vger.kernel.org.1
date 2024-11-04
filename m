Return-Path: <netdev+bounces-141670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7389BBF2C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2AEB21710
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A53F1F80BC;
	Mon,  4 Nov 2024 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKHiv3g8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35F1F76CD;
	Mon,  4 Nov 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754097; cv=none; b=gRmKETQTyDTy3OlREOl/s0suLngE/ApEyhvGtHuIwna8r2ePtJSVoBkT66uiTD11kmde+dDXwmuGqKIQb2L+r8U7GtlF82ZH8cAWt3iO8LJEwwJZZP2AgM2SUBzBRA7Bm7t3aYPcT6dHbBCZONbZdol+WRGZluiOMVN6bU4atAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754097; c=relaxed/simple;
	bh=nI32LhZou+0S1DtBINellaUeGTTNXZIygb/ooRu11aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obDZnaxkWemva0aP5MhZatamWcVatOUJPgzwrlANzbQu/iucCvf3AZNUUMKhsGKmFkZFMYQWzLHuu7WU1KOGhIhv5SF4rXhscNhn3LBOqbYY3AglYcmnlJNl11fuNLKwJSu2JMonjxFd2NOQoH3znQbGiF0GJYptjohKsXJEFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKHiv3g8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e625b00bcso4237214b3a.3;
        Mon, 04 Nov 2024 13:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730754095; x=1731358895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pXKZHXAtSZq9rE1V/pmNjGOdaYBnGBtC8hqbRoKbqU=;
        b=aKHiv3g8aiEInq1sNOtDaZfxwj7hNzrFqi4ayE/d2Hsmkn+VHqbuC7hUkw9Ba2bfCr
         j6kD38spMUbdOWHgMKfJAnhQKzbDKjnEmyNPYMB/0a/x1tQdcwQC2egQvLhFUnHL6bMr
         UW7xD1wqjt+M01vjcfPtVyS9nF09XKVsvsES6rByf3PwB2fJPYysAmbf52nIk4xQwrRB
         /tLUMBCYgn/qsqbweIHLs7Id3/6zq2ELW1lVGm9XadyEz3zys1yG1ZVkFWkTld9pcl7e
         zVyIG7M8DyMBZ38985K1wJR7BIZu9ll4CAl00v6ZEZXSL/DqDnZ81ltkvew+N1GYN9kx
         UReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754095; x=1731358895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pXKZHXAtSZq9rE1V/pmNjGOdaYBnGBtC8hqbRoKbqU=;
        b=KhCzGiAXpEqvDbKfbUi2xTIHci8pMERlK9xuB1G5TH7ee43wRmNoAX8v5snCa/p2p5
         +5dBTcLlvf/0EWDg+EE5k4kjLatz96oJuZItEiDveqUdTaC8LYR33cPPYO7gXDjirD6c
         g5NPp3APPmsNP4Ycd8PrNEAttLi6V7hCqWX9KIcCBgAPfE4Kdof5BWrFz1c9SG62NCCB
         SfgfLcE/wDtq+6P5dZVtf33Z+699Wk8C5BE0mQskhLRQT3z0VdMIRG6Zx8uKC35Bb4Vr
         RoPNQ9seYzNz52y5e7n4Vm3Robck/OS0wKqMn2dtoiz5MIHksKBoHjrmN7xchy2+y3Cd
         zn+w==
X-Forwarded-Encrypted: i=1; AJvYcCX6n3OMFSz1wVVaBjp/RQO5bfd5QkeKTCWdcbIUMu9PrTxyf69b2r1moG3M6wT9aGputPEl8EN0F76MfSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYW+3Fm97u1rMXnMO9yIKDQKUjvbHRxRuYzlgaFhtMx+9M5yCh
	4oe+2YHHLn1Amji/MgCSRjPgsACImYnSHYwcXU7kEIqfSwyaHZ2gOsCT20lM
X-Google-Smtp-Source: AGHT+IGVOiJFQcleE+NLyWRmjQbIlc5so8HKh80FTo3HLnTFS4d9spw/T8UmVR69HQs88bShBPOJpQ==
X-Received: by 2002:a05:6a00:2302:b0:71e:6c65:e7c4 with SMTP id d2e1a72fcca58-720b9de1608mr21369867b3a.26.1730754094875;
        Mon, 04 Nov 2024 13:01:34 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm8307755b3a.12.2024.11.04.13.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:01:34 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	maxime.chevallier@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/4] net: ucc_geth: use devm for register_netdev
Date: Mon,  4 Nov 2024 13:01:26 -0800
Message-ID: <20241104210127.307420-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104210127.307420-1-rosenp@gmail.com>
References: <20241104210127.307420-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids having to unregister manually.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 00b868a47fd2..88a9e7db687c 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3727,7 +3727,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	/* Carrier starts down, phylib will bring it up */
 	netif_carrier_off(dev);
 
-	err = register_netdev(dev);
+	err = devm_register_netdev(&ofdev->dev, dev);
 	if (err) {
 		if (netif_msg_probe(ugeth))
 			pr_err("%s: Cannot register net device, aborting\n",
@@ -3758,7 +3758,6 @@ static void ucc_geth_remove(struct platform_device* ofdev)
 	struct ucc_geth_private *ugeth = netdev_priv(dev);
 	struct device_node *np = ofdev->dev.of_node;
 
-	unregister_netdev(dev);
 	ucc_geth_memclean(ugeth);
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
-- 
2.47.0


