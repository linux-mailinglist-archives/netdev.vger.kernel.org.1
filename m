Return-Path: <netdev+bounces-109907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3992A3C5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858651F21693
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB1913AD26;
	Mon,  8 Jul 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xkFUWA+2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579B13A3FF
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445906; cv=none; b=DINWoDdxAOvkY2PJ6YsYPUE4r9wad1J/KB4gVbRuygMvYYh2h7GGhsL6c0HuCNs5q/1j+ibuvH36DHrdOafSSmIBWEyZJlobSiA1ipcCctC6sJ6BfEnNE0fZSjBWQB0vwO9c03OQuWMABsL4T4uouPCS3oMvEqXW6flAuSTX2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445906; c=relaxed/simple;
	bh=XU8ZtLgh1lqKUTI0MtljEtnVkzOL6K0IB3NU2kRNSxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gRGAEeJeM7WzJStwzx7Jia7zctjqK+4yLCUGTwqamtPAD2chJhEYJYqFjCazpezJtOCJBD1FvK5oVN5MUN6hw9hOJeV4bETaC29PScOrPrW9wXE8v3Sz6+yQ714Mf+l4WdT+buPdHyPMZ6k+FboHCkCn6IAOc+udRbuDhHQcuzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xkFUWA+2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-426602e8050so12717075e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720445902; x=1721050702; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BsuGX3u3rWy1C8KTtU1aNRXR2bHezvQFPzr4nSM0O4=;
        b=xkFUWA+2tTw6/i5AQreuOtXrhGrGlV7vvvsYykBbU5eyOQ4m22x72H7hHWapD1fpD/
         NmDKxG16D1U8p4MiTUVCS2OxlNUeAI+AHXF1tDGd0GuvrlFZ0hUp2qDVm930yL+R9cZX
         zBAm8rYRHO3Zf7tgXbZ0rCEDC+vxZ/ASqf2y8rTY/PwI7sbRIWT632JPZu8CQzctFB/d
         1jA0+A6rSYMn1lkOROHAOF+LKZ8GG96KTxuU1sefF7CRf8xDhPLwTh5nvbf+HrmaqChH
         aFZa74vbcTqi8lw18giD4Y39uI17ZIOGCIf8TNhbO+IYM7H0fckltKTut27bImZS0fr6
         u0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445902; x=1721050702;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BsuGX3u3rWy1C8KTtU1aNRXR2bHezvQFPzr4nSM0O4=;
        b=QlWDK9nBVWVamCCctDdvdaPLbGglMyqFiNpFBJyLRl8bNbUNGtrrpmCFzvaxz2oPeQ
         W84ZOcxDxamH2A3gNIsdUKOQv7rbJIU0AM7YyPy9U/En1U4fLwvUBIoEUHkRUg6F/VFl
         Fmo17pWYExyXCatnPtWlkbiKV2G6LbMgrJuF2Fae2ls1KRly1TdVTb8Dk8pPh26WTe7v
         Z3w0mq6GsJZ6FwUv58mzjoVHwgYR/sU9vPIxCGW/ijqtoKJ1rZRyK1Q48EvhP4oZYd0N
         NxsexEAl8xpx3okLPxOzrYjxcxXj0zgUzX3QcLbuA0EJh+q/YTiB6o0nWAGTDLNi9Msi
         8RFA==
X-Gm-Message-State: AOJu0YzY0OQDHrHkvj9GNNSHYlLNPJsIDvD+iHyj1DLhI3x/MkgNbxKD
	My7z37AY6g4+EPdopGnNlwa+xa5EmBGCkxafLb6eKb25+u4PAl/Rwba9Z2jZR1w=
X-Google-Smtp-Source: AGHT+IEbJBIpRJInWOa350nSgt6YYWtV2FQcwenALVFObKnn+rdulYtlFs9Jlg1oEi1Fta3gcs8IBg==
X-Received: by 2002:a05:600c:4fc5:b0:426:67dd:e9e9 with SMTP id 5b1f17b1804b1-42667ddeca7mr24450055e9.3.1720445902020;
        Mon, 08 Jul 2024 06:38:22 -0700 (PDT)
Received: from [127.0.1.1] (2a01cb09d029b5a2628cea6c7082b40d.ipv6.abo.wanadoo.fr. [2a01:cb09:d029:b5a2:628c:ea6c:7082:b40d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2b4976sm166375335e9.48.2024.07.08.06.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:38:21 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Mon, 08 Jul 2024 15:38:20 +0200
Subject: [PATCH] net: ti: icssg-prueth: add missing deps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-net-deps-v1-1-835915199d88@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMvri2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwML3bzUEt2U1IJi3VRTQ5NEw1TTJENDIyWg8oKi1LTMCrBR0bG1tQD
 N//fLWgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720445901; l=892;
 i=glaroque@baylibre.com; s=20240708; h=from:subject:message-id;
 bh=XU8ZtLgh1lqKUTI0MtljEtnVkzOL6K0IB3NU2kRNSxs=;
 b=kaVjxTCcUxIPbFkLgCHN8Pc2uBfTMH/ewC3K+r3Eix4nI/en/n6xleX6vw6BVROLjJkttLROJ
 Bl5DowVc6utD+5FiFUHnljR/ughzXWWtf6gXVshznMewLl8Tk8jxtij
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=xmoWMxCw4Oles0YCggjXh0FCCnECZvaDU0PaXVPxm/Y=

Add missing dependency on NET_SWITCHDEV.

Fixes: 5905de14c2a5 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index f160a3b71499..0d5a862cd78a 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -188,6 +188,7 @@ config TI_ICSSG_PRUETH
 	select TI_ICSS_IEP
 	select TI_K3_CPPI_DESC_POOL
 	depends on PRU_REMOTEPROC
+	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help

---
base-commit: 5483cbfd863f01126c08703898a9e71d991a9bfe
change-id: 20240708-net-deps-e514a1e5b112

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


