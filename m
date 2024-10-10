Return-Path: <netdev+bounces-134391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21569991FA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639B01F27EB5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE4A198E75;
	Thu, 10 Oct 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N1oSg4xs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175919EED0
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587622; cv=none; b=Hphf1RTB1h2cRL7s+WDKZZGiDk2bjUXafOXLYNBuzAJasjBnnNJVx7/xEPsR0k6wfg4vNEuGIrFBkw8pPftL/po/hnzCEgcoBn/MtDO/2DfAOMPnYzCXUGr0wt3NBp5QW0wHio02dgldk3E3YJh0EJBBWupxeozCXHUtrzp//pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587622; c=relaxed/simple;
	bh=1sJdwh2XSLuvHkMKoIxn8zDVzZx0YztW8wQadxtNjuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fnFqbqMbF65hRywIuCyvd2b29CaO6cGN6jr95FC1zQ/m7SUJuAUXpr9lDGQsNDSC5qpXDSIxDCV+fb0zXIcYn19mZbYCuI+2L3hBxcWWy29TSTO5cQhHoqETysyviNCo2eqdlJKyf3X5umYTrAT04CIh0R8BQ7PYbf2vTdtYrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N1oSg4xs; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-45ee18f05dfso11071631cf.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728587617; x=1729192417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0PP1jDCr/uWxN78cwN+HX1P0bGIuuVIPa9EhP2W1pU=;
        b=N1oSg4xsJKPoxYbWjp2uiaLSOnymAt8BLvzPdMg2nZxAHm/gGSSVJB6e+06uyO7fSY
         USoBbG8a4X1aucKdQL1x66qDguB7fhm4Cwx/AKTys24bIACNBCkQ8NFYG7Be/prOijvH
         VVZdA5rHZGzRy/Pe0LZr+FS9GHmlSLEJK1aGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587617; x=1729192417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0PP1jDCr/uWxN78cwN+HX1P0bGIuuVIPa9EhP2W1pU=;
        b=oRbqKrdUblnQe0NFD2j2Gg/PhukrQAWsllHgruZC2x6Z7X6lndLut55Y/CzLRTUHM9
         WYWg7ZBelgZjseKgadgjsxJB1xwSOb7cD/GS60cEWiB+GZ9L89D/JIkMFJyRaVBIQmFq
         N6QWSJSDZuS63wk1Fgow/0xoPULD1VytWFuwfnPKeGwKRwboGcBFhsExobNWc5BHl9F3
         mFBkhd6p2EsjBZLtY7JR8OfKKrvKNY8DPCmklmPZ4u5mYPHahmjKHkyuHvZDL28KQb9Y
         eTMxpiKVrxSnZ9cRxcwV0C+Jtn1wEcGmGb4BJfnsFEALATVVUDLKxn7uLxOubJJHkI+h
         z0Rw==
X-Gm-Message-State: AOJu0YwGaFDJTe+DkzeDsirapdBo900RyIKqsg4i0bqVDmKNinTQ5sry
	hmVktmwd3G+qpnijM5NFC1kY/9lClcUiNZsiSKCxU3FW5+CWvRIYgR7Q7LHKjjGL7ncMTxom7BB
	igtst6Y3+jFJ9tfPbfKRL9rsxpMnMgAPim0A+/BtjHgHirAb0+w6+VXwzWUm0tpfynRlitSXIm/
	F7WeoUXP7v2seQryr3DPpvfZYR3FJ9M3J8nSCRiLZ3gMDn
X-Google-Smtp-Source: AGHT+IGFQXOL947T9722tgfV0lTQ2x6mlCn0PSWPXpWnUpPZt6oSB5FtpUltqT56k1lW9g53dvsjWw==
X-Received: by 2002:a05:622a:2615:b0:458:2405:3b76 with SMTP id d75a77b69052e-4604a5232b0mr8670161cf.11.1728587616644;
        Thu, 10 Oct 2024 12:13:36 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460427db7d6sm8211511cf.33.2024.10.10.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 12:13:36 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	bcm-kernel-feedback-list@broadcom.com,
	florian.fainelli@broadcom.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net-next] net: broadcom: remove select MII from brcmstb Ethernet drivers
Date: Thu, 10 Oct 2024 12:13:32 -0700
Message-Id: <20241010191332.1074642-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MII driver isn't used by brcmstb Ethernet drivers. Remove it
from the BCMASP, GENET, and SYSTEMPORT drivers.

Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 75ca3ddda1f5..eeec8bf17cf4 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -72,7 +72,6 @@ config BCMGENET
 	tristate "Broadcom GENET internal MAC support"
 	depends on HAS_IOMEM
 	depends on PTP_1588_CLOCK_OPTIONAL || !ARCH_BCM2835
-	select MII
 	select PHYLIB
 	select FIXED_PHY
 	select BCM7XXX_PHY
@@ -195,7 +194,6 @@ config SYSTEMPORT
 	tristate "Broadcom SYSTEMPORT internal MAC support"
 	depends on HAS_IOMEM
 	depends on NET_DSA || !NET_DSA
-	select MII
 	select PHYLIB
 	select FIXED_PHY
 	select DIMLIB
@@ -260,7 +258,6 @@ config BCMASP
 	depends on ARCH_BRCMSTB || COMPILE_TEST
 	default ARCH_BRCMSTB
 	depends on OF
-	select MII
 	select PHYLIB
 	select MDIO_BCM_UNIMAC
 	help
-- 
2.34.1


