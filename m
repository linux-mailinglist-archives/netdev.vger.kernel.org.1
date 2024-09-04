Return-Path: <netdev+bounces-124940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EA996B67B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EEF1C2104F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB71CF5FE;
	Wed,  4 Sep 2024 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ+T6DYC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A9D1CF5F8;
	Wed,  4 Sep 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441772; cv=none; b=d5QNaRP6aqDXXjzdGEmihNpK40xApEflfEcQA0i12BHLkX6kFmaegHJXi6xSiDDePx2W1XOs2GxJw52ZpelF1lSZjPHyon4la1eEF1pQG//L+mRltOMXZn/3wEDyWb6WuTXfSUHQ6TLWVcnvFWeuF/uzp3OzM7mP45YxJ+vvkPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441772; c=relaxed/simple;
	bh=wzc4ld7gfwP0sNljOlYfHo2JBW0cRg6nsrFSCx5vCdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n1XjRhJbOE++zzW0+DYVCZ7CzoqCWvsYZKwjYGNSD4l6M/nxhiOoFAljXrttNH2E71WJZPCCVeU25WbwhUeqdhqrKZIQCvf9uiMZdD+cp2SSlJS6fj1LXi3Cj6cLKTXDBK5gPWcpFL/SfumfeOaGIUw15lTqMMlYa1Fo7uJim/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ+T6DYC; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-26fde6117cfso325177fac.1;
        Wed, 04 Sep 2024 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725441770; x=1726046570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/8+A9ugkeSdUO4d9xUElrWU5gNJWxJ7CSf83sCLP+g=;
        b=gZ+T6DYCLm0Ei+vh94aMBLg3ODbLTD/mvjyL4S4lbUbHAkabKgn76ArRtNsh5Zfl91
         cQN0U72cjapJDz/VS1A9hMBGXx1W7hL2qxDYZgttdI2oy1x+rFmXeqYRhIugtAc66Lj3
         r2i98DR2eDxnDcrJwHnV8JloNptE/X3TBgy37yCyOLceq58vjObJXIbcVIWREYzDQs6q
         jDFe+2O8RGbScp6HUbhUCc2SgnvRCspEQQRcEiCqEOcYzK8tft9pkqsmBqns+hE+kiXr
         aQNGg0J3RWT676cASSSnOkiYFJSTzGtafLCMh3+MVwS8uBeqjGpOTKohDwgJnPGVf3OC
         3idA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441770; x=1726046570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/8+A9ugkeSdUO4d9xUElrWU5gNJWxJ7CSf83sCLP+g=;
        b=fwGKwvnflDrGhi3yAaKSVcK79lB8TTMzaKmbVDTsO/YCCMZhcq4dGu6qWORyxNPIuk
         E38u+y+tw3I5C4MIH7icI24SQYxJanuyHRdZdm/ccaUlx+LeEwVCec+zNVVu0kojSnft
         EZZ1dmt5advSC4atqJM0PeZdHKMyfLR3fIk1cLVAUtTaPwXUa4+QqqoTpLlb3ct4qhNV
         0GealEzMpYaKW0TPPAil2K9Mwb5YB762/7AgFA3On1yBxrAeplLq6uWZe2YJ8GiVWQh2
         7QV3hZDVQhYWQjuCnVXgFMd2LiYRk8x/XVEm+zDLBZAswoMhvjhzu4u6rLhmuIPx+y8e
         Uafw==
X-Forwarded-Encrypted: i=1; AJvYcCXZUlZdBUp+x0XV9C6q5BV/3XMoIgmydtpdqyeHX1VSBuQzdAJOagRDfkeTSNTwl55ThXi1YjotzMf0ch8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5c7OdlSIGPElj9lk2zUvKBpIYkNEgtrwnzjVJ6fleaYZb+1P
	IODuPMxya5o+1DlHUW6M6VO/Amf6oovGvsMshJSwQ35jZPnMMWU1
X-Google-Smtp-Source: AGHT+IHe8i/RMFB93f80fa0xNtf7015I9vsbV2fcKKV9lX2mHFQQLj0Q4XSX8GgljC2ApjpzJdbVjw==
X-Received: by 2002:a05:6871:8c15:b0:277:db7f:cfb2 with SMTP id 586e51a60fabf-277db7fd4camr9154084fac.14.1725441769759;
        Wed, 04 Sep 2024 02:22:49 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7177859968csm1232048b3a.146.2024.09.04.02.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:22:49 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	linux@armlinux.org.uk,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v7 7/7] net: stmmac: silence FPE kernel logs
Date: Wed,  4 Sep 2024 17:21:22 +0800
Message-Id: <3cc959e1ab2e6cc7a4b39d22e34c38df70f01125.1725441317.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725441317.git.0x1207@gmail.com>
References: <cover.1725441317.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool --show-mm can get real-time state of FPE.
Those kernel logs should keep quiet.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index dd9583968962..580c02eaded3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -620,22 +620,22 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 
 	if (value & TRSP) {
 		status |= FPE_EVENT_TRSP;
-		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
 	}
 
 	if (value & TVER) {
 		status |= FPE_EVENT_TVER;
-		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
 	}
 
 	if (value & RRSP) {
 		status |= FPE_EVENT_RRSP;
-		netdev_info(dev, "FPE: Respond mPacket is received\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
 	}
 
 	if (value & RVER) {
 		status |= FPE_EVENT_RVER;
-		netdev_info(dev, "FPE: Verify mPacket is received\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
 	}
 
 	return status;
-- 
2.34.1


