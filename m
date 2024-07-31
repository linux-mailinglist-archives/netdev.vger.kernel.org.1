Return-Path: <netdev+bounces-114512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C2942C4A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC60281C13
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779A81AD3FD;
	Wed, 31 Jul 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNJRSQIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD91AD413;
	Wed, 31 Jul 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422680; cv=none; b=RRD5VdIl1c5thPO7bNMc9g8OuQKNl0OIh6/Y4Fohpgq4N+GlcpxFkOB9Iw2FpwKgyEqQ23+VRTP4EoKtqzcXDHd2txIA9U4WKd++/+19VtXaATscpCoy7avOY/vPdVObchVYobY92LxWcGhPZrLkGexjqy+HCpql/oce3AZXsbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422680; c=relaxed/simple;
	bh=DCREtrJVG7yWVGe5DWmw9oaJV0MdvmZNjnV9p+LXy/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=up2K/tHX5bSBFb8zAiBUyWwmI9YMEzATVa9VKkUM5VrWG8AuY7ut61Yu9v8Jyp4B+RnujDFdg8RHDtpndV7O5RsNDRguU0eePXRitAJSi5mFz2b5zxLDy6HKwxbe7EjOs8hfdz3MscLh9y6Ll3JqAqv3Hy8iZ3QiEX04pn33aVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNJRSQIp; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260f1664fdfso3078928fac.1;
        Wed, 31 Jul 2024 03:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422678; x=1723027478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fu1ouNnrG9bF+uAnA7GwZya1Ys3715c6hhI6EtcZ2RA=;
        b=RNJRSQIp7K+XF7C7OuNDXnV6TI0O1/8yAm8dfb0wqm8lkczj/SXibT9RjxF3VZ5aMs
         ds4IUMSW/xfdZ7MlpbPJ0545J8qzz1HvgxyswrQQBa+VrNUNRu7LSprYSO6JppswWeMr
         B8pymbZcpBJYbdQ+8v/1mv6opRSMv5wb52O8QKpXMmpVlYVoHF081GsyKKWQpspR2QWV
         +V/A/4Jus1KeYpO+XppBt6oi1N99aDS8yqBwfBNmQwtCfQxsbcHbCfFFYkP7imojnTq4
         efBRjpDq1y8BTZcQ1Msthebr6L1LJchjO1Ojt5uwnN/hR4FsThGCuvNqjopOFuHDZ2IF
         3Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422678; x=1723027478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu1ouNnrG9bF+uAnA7GwZya1Ys3715c6hhI6EtcZ2RA=;
        b=YbqB8AsfJolHEo+m40GX/kps+PsjoOKrmZckPqAUtNfd4+gttxowVis6zjzfC9i5Mv
         pUe9aAfqHoR+NiPTAjDuS++haZ65CIIUjH/qRNLaxBMDx+xrfWPO0fQ5Y+n5kllCf/cn
         MsTGySxkQ/vbw+wZid8kl+oCVNowrCfYj1QLeu/xeINOMYBUMBdF7QQKze9mH+TPnAS7
         uW08qYhKiZsgHWy6fjZTgElmvCHvQyY01JjAX3HU2sivk0fdt3OUDRwV/mQTEGWX/n6G
         RY8tqaQY37p1Kc8Mp1/q65weZg9IirDD31W+1n3l519vKaBRevDbIrt/sXLhmsUQtNaq
         j4LA==
X-Forwarded-Encrypted: i=1; AJvYcCUchPB3Z9tnp7FZDOjnNasiBErkEJRP6nuWr+V/4CmLh07SSvH6aAyn7hw2nSiK5aFbkOABkC7bJoXr28TeKOz/913BD7kYygHLRuTX
X-Gm-Message-State: AOJu0YwV8McGnxU2Q/33v+spLU3EKLyFEsFxG++kVR2RQMvfbF+mouuw
	GmEucdwFIcA4pQ2/GhOO+Etr0gRk1s+MunVYsXAs7mP5rzkUQ2Qh
X-Google-Smtp-Source: AGHT+IEvFA1K3zu3i0XikbrUbT49e6jRM+kXTRxXXH210S3QRwo16GCTK94T7ErsdT4YoniWaIZ6jg==
X-Received: by 2002:a05:6870:e244:b0:25e:7a9:b603 with SMTP id 586e51a60fabf-267d4ccf5a4mr14061153fac.5.1722422677818;
        Wed, 31 Jul 2024 03:44:37 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f816da59sm8791375a12.29.2024.07.31.03.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:44:37 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
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
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 5/5] net: stmmac: silence FPE kernel logs
Date: Wed, 31 Jul 2024 18:43:16 +0800
Message-Id: <370d89a46a15856856c601e1c8036cbb4bc7bb4e.1722421644.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722421644.git.0x1207@gmail.com>
References: <cover.1722421644.git.0x1207@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c      | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 068859284691..3abacd863fe4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -605,22 +605,22 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fba44bd1990a..5531c26cba34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7392,19 +7392,19 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
 		if (*lo_state == FPE_STATE_ENTERING_ON &&
 		    *lp_state == FPE_STATE_ENTERING_ON) {
 
-			netdev_info(priv->dev, "configured FPE\n");
+			netdev_dbg(priv->dev, "configured FPE\n");
 
 			*lo_state = FPE_STATE_ON;
 			*lp_state = FPE_STATE_ON;
-			netdev_info(priv->dev, "!!! BOTH FPE stations ON\n");
+			netdev_dbg(priv->dev, "!!! BOTH FPE stations ON\n");
 			break;
 		}
 
 		if ((*lo_state == FPE_STATE_CAPABLE ||
 		     *lo_state == FPE_STATE_ENTERING_ON) &&
 		     *lp_state != FPE_STATE_ON) {
-			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
-				    *lo_state, *lp_state);
+			netdev_dbg(priv->dev, SEND_VERIFY_MPAKCET_FMT,
+				   *lo_state, *lp_state);
 			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
 						fpe_cfg,
 						MPACKET_VERIFY);
-- 
2.34.1


