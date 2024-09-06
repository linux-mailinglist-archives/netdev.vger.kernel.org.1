Return-Path: <netdev+bounces-125782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7689396E8E3
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E20E1F232B2
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 04:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F2B145B11;
	Fri,  6 Sep 2024 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwW5jKD/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A61459E0;
	Fri,  6 Sep 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598641; cv=none; b=UIHY9vH3lUIc0SWnMdcZL001Mecqfx97P5Fuiobzm/Z04H5c0vQgliPyi9C4ZN0WzuB1k0/MKhXZdhwQSxQ8mm9MbpgrQ0/3K53Pi/xfNPZBYgfzAhXWc5faIzeKkvNXgyNQEW2CrJ6yw93WaEgDMO3qz/05/HvOBSXvEQIza/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598641; c=relaxed/simple;
	bh=WW54gdwLUbR2vRtO4ItV9tgMkKvU53P2EOjp+KhAuI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAwy/h4N7FdUX3AaPvctwtt7zqeuDm5nIkcm14tVVCxvR60kDctk8h3+S2sAFYwIr9JDltvhfnbR2Xv4WgZi7+AX15kBtAYmTzK5gD0VR1pZJ0wH2LkzDN38rehcSLRJ9q3W5UlYLD96EcuB3EZDyRRl+AmPpKbhf9h7BylZpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwW5jKD/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5df9c34c890so1044624eaf.1;
        Thu, 05 Sep 2024 21:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725598639; x=1726203439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRhWJrEYy3VMtGEOiJyga7bTazzfIqhRdV1t7XTzZag=;
        b=CwW5jKD/2xNIPy0cQIXp73rN5QRre1/3in72KQ/ELCr8AGhqooA93qQ+qWLmrpUzXI
         SIxqcbvzdGY1PN5jn9ZPagkAUcCoBoizicYf66CVFrf/PVlddZlIQIKSPYDYvAIaCocs
         IE/VtOiawTs5pE1vcgBLGitM1YprKHdrEFvCW9L2IzY5km3csJ+lW2t1T16Sz5vn1HWk
         AcChkYZ9/bN92XifavIU/kGvlVAx9Lfo09n6MlVJP+PpLVr2GiBK2v1Y4KaQbrkoQYSe
         oiQno8BM3IMLTODjUtT53Aic+280Jw+FtqO0+jUvAZNB83ogDQkdfWQWCRSgYCdnjQbn
         hZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725598639; x=1726203439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRhWJrEYy3VMtGEOiJyga7bTazzfIqhRdV1t7XTzZag=;
        b=pdT+QlMG9Y6ufO7CVbGO35sgmpn+M3dzkc68usxw9Fazzi+6lDa9V5f35/SgQf14I6
         sJ+TZirUJu+1UjtcrTdEBvsYtJCxYhp6QetjnoWzyGHAxWEY7IpiqDPye8Evu8PWrcBW
         Pgs4dFpz3kggJCHKEZA7xUX37CAZ9/AvFsCDvYTTfx0zOhpp73CYQoatZxf+2BV8ruPZ
         w5LdgcDftkVmBjl7yhBZYCQbGAUd1BkPulnbNznEHf1qy0nxEM8VFe7EmO/svqyIny4D
         xTLGRJi4ZY2e77SQu59T2MnfDslUjlAnxFKvS9yxPF0zPVn3eHIiLMxjQjbk4s725Rdl
         8cvA==
X-Forwarded-Encrypted: i=1; AJvYcCWI0gbWM4xBgFAL6ygCu9qCXRyJIsY0Qdu/ZJ9WZ0nQyQEJju+p9SM1VFTLu4zQ7lJGwMZctun6DbrZXR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3siMjUgjuIUrFymQKGNNbSaLpuca/uK6t3UdAaSYg/3TS9ENj
	Q2/hi2JBSL8WP248PRV/iexT74Y3xO8vGvTtjQmeUHI1sjVJF4us
X-Google-Smtp-Source: AGHT+IFCUKUTtjgKr3GIy0Uy986g8UvKVqkWYYM5qB832p7WPOQoTiQsAlcR/uJnyiSROeb2fH9mEA==
X-Received: by 2002:a05:6358:5498:b0:1b5:eda9:963f with SMTP id e5c5f4694b2df-1b603ccaed3mr2990635155d.29.1725598638878;
        Thu, 05 Sep 2024 21:57:18 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1704002b3a.182.2024.09.05.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:57:18 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH net-next v9 7/7] net: stmmac: silence FPE kernel logs
Date: Fri,  6 Sep 2024 12:56:02 +0800
Message-Id: <5d4fabe80145cb6779bf8ccc3f0624c61e9666be.1725597121.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725597121.git.0x1207@gmail.com>
References: <cover.1725597121.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool --show-mm can get real-time state of FPE.
fpe_irq_status logs should keep quiet.

tc-taprio can always query driver state, delete unbalanced logs.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c    | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index ab96fc055f48..08add508db84 100644
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 05ffff00a524..832998bc020b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1067,8 +1067,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (ret)
 		goto disable;
 
-	netdev_info(priv->dev, "configured EST\n");
-
 	return 0;
 
 disable:
@@ -1087,8 +1085,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
 
-	netdev_info(priv->dev, "disabled FPE\n");
-
 	return ret;
 }
 
-- 
2.34.1


