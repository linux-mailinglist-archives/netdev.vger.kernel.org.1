Return-Path: <netdev+bounces-121315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEB595CAFE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756851C20AFC
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A49518892E;
	Fri, 23 Aug 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3RyMnNl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16ED188937;
	Fri, 23 Aug 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410264; cv=none; b=Dcdac7lsTNd0oGjh/pjwDgRH0I/hUmZ8V6blorv5Ox0J+lZR9y/wCgWpW+1ATkkHy1PuNYGJELdJgQFhLkyB4q02pBIXoiOlU/4D/G9e2XYGlHkyn+EISBmRVbzBykypQ7yHATXkUfGusR71zmXsFA8ljeVnTGikMU+pTj+Qb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410264; c=relaxed/simple;
	bh=gN4woi2dgmwQQADxniF+M68WuburuJmvA+hfdZ/Z6us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRG6ceh6ndNhxd4PvrdYxpbYGdbjQW5hUsuE6P0kl/TrI8y2/OiNU4VFn2MYQxHdzKerDq6vH0MrpduV1EQR+3rYCCKMeUILMWHMcSs/JXyMxFTBok5jt4xuTLfa8xxNATSUC5idAIoRBLEk6jRAk7RyBz+xoweVYg0toG9idqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3RyMnNl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3eda6603cso1409992a91.3;
        Fri, 23 Aug 2024 03:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724410262; x=1725015062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiEKr3Im0ZGEfo9i68gRMgx3Qhz/6RSfaQwwnzsVeF0=;
        b=k3RyMnNleEQvF2FqJ+LGnp358u/1zHRVkZ5T/vXtgIqd7H8y1KxPk12ciMgKn8rdh9
         b4cpLy8LrOyfJsnvS4RNs12wmheQbkuFLtgwNDqfgnpZ2dv87z7OXHSItpSIqQBNok1F
         6DU/2FIvGvAbpnmfVLOu8XBXKTjh1Ryf9PmmJieOdRkod5emLwv+y4NdjURtuWMeKcB4
         Fq/C/4xkyy7soCVwgCCB9Hd+jd2V8chHSnsRIHRnFL6D3t9gYtOQPqikEheBvMDIzLcZ
         Pt1MRZYhvPBijMcBkugzdpoA+mA735jHRsrefAlP8G0r0x3IOloExOqZjD+5WWhxSK8B
         YHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410262; x=1725015062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiEKr3Im0ZGEfo9i68gRMgx3Qhz/6RSfaQwwnzsVeF0=;
        b=k2exDjXJ0DvhIQIOiYxpF2XvMHMSPLBQloyRafO5tDUt5zcvs3600OIqmm0Aj8UKKl
         CicbKmihHioBAaumvtHqxUrq9fisILPKH3uw+iiMLqDzaEw//jrtOyeRcB+GZNpj3FNp
         ULQdlKTwgl1sHxZIhPnbENS7QIdFwBYw2ULxxWPqtkkMsLT1sQCpQ57bSpBS2fTg/oD+
         nA+poIpYic/9iQQz/ybP0audc3Zv4hcUITEU1ZqBsqdVl7g+k29Q0hTpHOTgVPCpj2S4
         BsVtP4mp98fc0kFOoYP6BM+exzF5s0XaycVHOdazkDuuLAFlHoSTToD5Mkf0fLAqjvtO
         uaiw==
X-Forwarded-Encrypted: i=1; AJvYcCU3cRVUo9+b1S1VlfYj8bhUVm19G4N9QTa9WG0PFsD368RolPsox2JAkX/8KeL1PVGwqIDP/Gyv+e+8OmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZ4PUyLypz+EqN4CDiZBgN6WmXhqKR+1pwXOxUQnqVQxnAQ0Z
	Z+bLDf+k3Bm3SXSMYcmzeKggf919enMiT/h5PLZRhWAV63r7Tije
X-Google-Smtp-Source: AGHT+IFlcZxDDc8zTi3Ls4lOUz/9fcP+qE+s4ousiGEEgEdTZ3V9E6rQ5lfcHKW6Y+CTb5xFPC2YOA==
X-Received: by 2002:a17:90a:55ca:b0:2d3:c3e5:b51a with SMTP id 98e67ed59e1d1-2d646bbc075mr1719026a91.9.1724410261707;
        Fri, 23 Aug 2024 03:51:01 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5eb8d235esm6074344a91.6.2024.08.23.03.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 03:51:01 -0700 (PDT)
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
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v6 7/7] net: stmmac: silence FPE kernel logs
Date: Fri, 23 Aug 2024 18:50:14 +0800
Message-Id: <74b2ab45a3a93a7cf85ce563a8d64fe44e782c80.1724409007.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724409007.git.0x1207@gmail.com>
References: <cover.1724409007.git.0x1207@gmail.com>
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
index 96667e81eebd..39021e2868d9 100644
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


