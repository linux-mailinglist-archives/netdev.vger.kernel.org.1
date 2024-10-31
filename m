Return-Path: <netdev+bounces-140700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57AD9B7ADA
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74DB1C21C37
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC9319E7F9;
	Thu, 31 Oct 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DejadJwt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1B1E495;
	Thu, 31 Oct 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378350; cv=none; b=UkILdPZeN8WlXkjfOGis0O7+uK7nCM3u+SaLE5QTxl3NmJwp9l6jZbUASdjluQTgRcCHo1lxTMPoGVCYjA/Sb7gwVPDYXNT8UfSmHerOrg41JAUi1ZvRmmS73kbdWhLx4TO9ssn/fmE5hNNUk7aTXtkOIdXdyYon+faOOCTOV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378350; c=relaxed/simple;
	bh=xPbOsAgpFplYVCCw32ulDCcKYLSLi4YhGMc48hPu7TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yrb2gDA2k/6FdzWHq1xaC3FBR3gGTu03lmvZEits+mFjXnztXkrZDY5MriD6kOHHzQbDCrpvtpcr8lNoLkCUiPLmz4+vMAavn5wTVd1wv8sPDeuwWRhh9rfeBAyloD49kxB/YmVz8aJKtWSXUqVwFJ1UPLPiQU1+oHsTv4YTRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DejadJwt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-720c2db824eso291233b3a.0;
        Thu, 31 Oct 2024 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378347; x=1730983147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr5byz9uGWQ6qTVVNyRJz2fcSvGGfWOU5qQmAfQjTs0=;
        b=DejadJwtaIZrIXinKPJKLhr4omg1/iY+gZM978l/orq6niW0aJ6TI5Ri8y1mVlg7D0
         7ZqSCOfjs/nLhw3L7h6W2PfD9PMOTCvJSLNpqM542Nb5EjKWqkokM/GSQS1PjNoOgHEF
         eJjy5IbP5Q59XfoXcFUsFwvNZqOeDFkXp4NCBz5EAh3NJqJV6zX+5OonzM8fO82xaaBn
         58Iqmk5Klke8LwoY02Q8kdsOr8LOvr8bNYeizv6loXlSJ91w+LGubBsI6N9ASLcFZ1DM
         rxxCP8luUc3ATeOseRoVLooobehM9R3vCRPnOv1mVxuDlyTVf+utIgKERJUVw2nDqz5Q
         f5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378347; x=1730983147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gr5byz9uGWQ6qTVVNyRJz2fcSvGGfWOU5qQmAfQjTs0=;
        b=jLFBVD1ims8GUz++4aDSnAYCalaqgkceQoCwCCCisP6F/oUkv+mG4rkaOMxVSQypnj
         +Ky8ibX1sIRMXdaQhw/UxuW/exK3CCm0kkJuHLoKPSQMMoIwVVEayicGlFezCZvmYRtB
         lZk86CSOMj89fzVUQ9g7bjO8TF7hwgRO/qzy5Pv1G3uxoi5iig+Jh0jV1A9bs5T3SVbY
         6j5eX6vyRKdvcBMyZVTrsDXxYeQtiNCGxg+3kMxt2ZsmgIfSCV7z9kcmE//B7jKfHNWo
         k/HPqYO4z3vAodC7geJVZg5ERGKa/V3pSfcPZQ8lFi3z58OrDuv5VR7VCkxzhc7NfYhP
         mwpg==
X-Forwarded-Encrypted: i=1; AJvYcCVVWbO6IDGl5aY68+JYIhkYPIb913iRUC61Qe0tBAhTUBNQNTYJ6Rf7l1F/3Bhc+NE4dlBoQc01Co9HEGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mE23UwBD6mX1DrlhvTNE2quDBgnORsM65VQuQrOEieAe9D8J
	1BbblFKKVKlgAmGt2vh6A2xkC+VPNtBRCmZo+NvN45bv04lVOT/O6d08ew==
X-Google-Smtp-Source: AGHT+IFrvqh3fZqXzS4zBEWib3+Sale7tzbI8D4zdSrUqBXu2tE+RWOF0X7aeH5toWPKujtUAdjN9w==
X-Received: by 2002:a05:6a00:2384:b0:71e:68ae:aaed with SMTP id d2e1a72fcca58-72062f81e6dmr24955795b3a.1.1730378347148;
        Thu, 31 Oct 2024 05:39:07 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc20f50esm1075931b3a.94.2024.10.31.05.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:39:06 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v7 6/8] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Thu, 31 Oct 2024 20:38:00 +0800
Message-Id: <de8a31fe931152b569c4addb22bd9359c7eafddd.1730376866.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730376866.git.0x1207@gmail.com>
References: <cover.1730376866.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Synopsys XGMAC Databook defines MAC_RxQ_Ctrl1 register:
RQ: Frame Preemption Residue Queue

XGMAC_FPRQ is more readable and more consistent with GMAC4.

Signed-off-by: Furong Xu <0x1207@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index efd47db05dbc..a04a79003692 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -84,7 +84,7 @@
 #define XGMAC_MCBCQEN			BIT(15)
 #define XGMAC_MCBCQ			GENMASK(11, 8)
 #define XGMAC_MCBCQ_SHIFT		8
-#define XGMAC_RQ			GENMASK(7, 4)
+#define XGMAC_FPRQ			GENMASK(7, 4)
 #define XGMAC_UPQ			GENMASK(3, 0)
 #define XGMAC_UPQ_SHIFT			0
 #define XGMAC_RXQ_CTRL2			0x000000a8
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index f07972e47737..b833ccf3e455 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -364,7 +364,7 @@ const struct stmmac_fpe_reg dwxgmac3_fpe_reg = {
 	.mac_fpe_reg = XGMAC_MAC_FPE_CTRL_STS,
 	.mtl_fpe_reg = XGMAC_MTL_FPE_CTRL_STS,
 	.rxq_ctrl1_reg = XGMAC_RXQ_CTRL1,
-	.fprq_mask = XGMAC_RQ,
+	.fprq_mask = XGMAC_FPRQ,
 	.int_en_reg = XGMAC_INT_EN,
 	.int_en_bit = XGMAC_FPEIE,
 };
-- 
2.34.1


