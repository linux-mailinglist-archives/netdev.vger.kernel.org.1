Return-Path: <netdev+bounces-140264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A1E9B5B57
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 06:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CA682853F2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01641DDC26;
	Wed, 30 Oct 2024 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifpRUp7D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC931D0F7D;
	Wed, 30 Oct 2024 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730266626; cv=none; b=OwdA5nZelRL/GisECJ0U+KnFRQJJ4eFJ3LLCemV7hL7eb+xdFOVNSl1F9vlpmN9AtAoeCXHcH9YpmyaamPpx3btKR6VqiGfbFiU1nXZHkSSC17y44dNeljaLXoRYH6AwvbfyF4GiqHwSDsHadFasHl9PrLYYJoKBSd3ivCzrcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730266626; c=relaxed/simple;
	bh=qQ/R5XZ96PZZ0LdoqsjZLtD263/K3P4BW3QoRJ0dHSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieNKf2dSpsNifwpAgdfuRrGuyuRJ3fnZq9Z0v5JjfKg99rpJgCvYf+MawxTZhHUJM4MR5wBT1eMfrqIkfFcxzxKGMnjT9aWlS63Q9zxrS5ME4OJydN1677nDtuIOeEs7pDYPfEK4suKY4eF5JKHcCR+WjQwO1qreJBcDICdz3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifpRUp7D; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4d1633df9so21783605ab.2;
        Tue, 29 Oct 2024 22:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730266623; x=1730871423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFXbwqz75x0dcmhtSdDEARZ9DfDgZuyYgYubYl4uDMY=;
        b=ifpRUp7D5gGjOtUJ5wjQkmvDmSapvhVD2vvhJncchsQPRT5YIyJxV8dQG5oQiMqmTS
         5lioa+W3obsvNILSzXhW2Q9jm4VwTUIBogm4Pba/6vsg9TGsoPPWrkTXUTqN0eOvKK/I
         yjc+biUU+hEZcSjcIHQvR8Y8Hg542sEeLx8i+9ZoG5lytHsTDq9r19/GHg4C/cdr5zqQ
         WFHwVBowqC0ZfnT1CLrckdcfReBH2iUNlTewARVgR5nbpS3pDrbFrHfODySjlX312xR3
         GUhR95fynIWYkrSaNPnp9NvBd54OWTkwKN/JqQk2vsL6k2mWMssz5ZKyoqNlkdPwIrzQ
         jqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730266623; x=1730871423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFXbwqz75x0dcmhtSdDEARZ9DfDgZuyYgYubYl4uDMY=;
        b=H5KShRvC+7tO7TUAGuivguPLPcBRWZ7mV+OFLG+IBC0jvPVddAF6zas0c/OLTkNZ7H
         7n9mOpm1Rxm8W67cS/0NFDkEC/IzwS90GN+57cHyxwviYX56DKTLQS/iwXG1BiR5Z90p
         yEsD4ep1shDlBK1hJlqycjacbvnrdKNp5S/4qtFH9CdP3O1rT9sM1BGciGQL6lIfWqp+
         BmfSzibYvTMq14Olkj8o5lCvoZfM7s+MJREndjyb3cf3hvSnKA3Tg7TuMxZzCvNpXhdc
         rwR+uMQwbKhCEpy3KQQ06V/DXWdiQFo1WmLH/cQ6kyLni8175f+dluGDRs6tGihiHDLS
         g5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW7/uwor8NZcU3UYZnSmikQlVoaFUGg9GUgVyVRlc1aUQYsJYylFwDcNx0DYp56zsuBZyvy9xenSX7haFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOj0MLYARxKaZeJLTm36YYIgsO+GOL27lHXTBMkWtn4lIYADhY
	kCjsHiFH7zcDrMQk5bH3LnttTC/PA9iZFi8VA+X5esIlY3NOv/tIiw2LLQ==
X-Google-Smtp-Source: AGHT+IGlk7MCTYOqLt8nKHysJ7yCgLJD39sJP78kc8zMKZandqcgyCERDYvDZvq5YlTQ37RKXLzqJA==
X-Received: by 2002:a05:6e02:1a25:b0:3a3:f86f:2d0f with SMTP id e9e14a558f8ab-3a4ed27a9a1mr143587155ab.3.1730266623427;
        Tue, 29 Oct 2024 22:37:03 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7edc8661098sm8516595a12.8.2024.10.29.22.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 22:37:03 -0700 (PDT)
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
Subject: [PATCH net-next v6 4/6] net: stmmac: xgmac: Rename XGMAC_RQ to XGMAC_FPRQ
Date: Wed, 30 Oct 2024 13:36:13 +0800
Message-Id: <b3e99ec1e53bdeddaca3d018f8217aac0986287e.1730263957.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730263957.git.0x1207@gmail.com>
References: <cover.1730263957.git.0x1207@gmail.com>
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
index ee86658f77b4..46a4809d5094 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -356,7 +356,7 @@ const struct stmmac_fpe_reg dwxgmac3_fpe_reg = {
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


