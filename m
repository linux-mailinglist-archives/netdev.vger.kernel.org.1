Return-Path: <netdev+bounces-166506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5615A36327
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87AF7A6927
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936B267B05;
	Fri, 14 Feb 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/ncjjOi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866D326770B;
	Fri, 14 Feb 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550749; cv=none; b=DFrH4SlsgC/LBCd97sbhW6mt2wBqWycSYpUadbMr7wNGXmsjOxCG9yD1bQVRF/XR3ZKY8utxOQiunb0Zte7pBkd2aWkE45+7eSNr2nQKISgrvPFMN4IBXTorLrsuO+I7JfymXv8+u5kzy2vw8Yp+0oo6WaHy871pakBM099BrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550749; c=relaxed/simple;
	bh=7/7IAQ8It8HjxbMXXqfT720xHoVrK4sp6wlUQESQIWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQcuYnYbaCX1eGg3y6WkLwgLc/YRuFj6loB5zyr356Amy7Bn8YEbM/b5OOVTadA7ScaSrycv69Qu7wAf8lwBUEilP5bYHlQ8OLeA6QxSgM/ue0cbGcq5wx/HluLNuH99qXA7asfcLkdozDkgDJRsLH3AJVnON+YS6EM7gYjg8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/ncjjOi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso396029966b.1;
        Fri, 14 Feb 2025 08:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739550746; x=1740155546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqPz/UbwDhbLwLkq4mv8GWuHGR7t4Vk/RSI60d9yM68=;
        b=c/ncjjOize8CnPKKxrMMcUmOvJAQ+TEtytZxxUb0NBQhXtnBMOGuEYaq7bbT2+MQbp
         IXeC/uDfNU9KKroPxmK6kyrOj0UVmbDlGKmTnhTtrbGjKIhdImGq/QT68Xx5tHUyYB4q
         Vkmv6GLj12DnSwzN4+096xt2YNURpvyqRn3ARJVdoSB11u7HqNniy80IEbHHxObGzK8d
         x/bqlo0yyoGF0MEqIfzuP6dn7zFIa4MVwtqlwMytEhlAhc9tKcge1RD0eQFXPHKWJPEC
         PBUJkMB2jlv5LiL9UEPXlqkbYCV6ejAwd0K8LWZ3XOhAg7E6k7DX8lgHFovhXKEIV+FG
         9Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739550746; x=1740155546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqPz/UbwDhbLwLkq4mv8GWuHGR7t4Vk/RSI60d9yM68=;
        b=Ygl6MStWVpRR6hvPRbrhuC+BcHOPH+nf2wytvjgHy4ipbSzmrMhtlHQdt7vt+uLVWk
         sH5MzcRTZSpO18zQfj9emd6ZkxcrBSNjN/skdqK1wYgX1Pum29S7OhUBLIrEfSxgNNR8
         EBNcEeoSs9WrrnbBJW/Zc9fbaAqaHUBYxI6B64uZT3i4nRkh5AJjKsBawBsc7gPDeeCL
         /mevScautJ5HAJjRClNyAykz0FtbXMSMC+kS6CVVruwUAvOaRktp/BFvo/OiuTK4A95N
         KmJetlW8BRGFFHAMyjWINiJQjtaBQ+4hj9dVduyeLX3f34rbIu5X6RckCeH7PcHKXHiy
         u9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1JwGDm736W2D+Agjl+LoUCMmIF714I9lh2XB/E/smWgE/BPRrUJqz5mI5bjeBVNJx8GRHth7i0052beU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZPIQvwwMpWbYfMXZRQMgGJPrlzgmrFI2kc6eK8FfDqEP6vBS+
	SCNTHbym/dprMkgph47AXs6f+TY9SWxjNdvY3dormn+Seq0HOQJL
X-Gm-Gg: ASbGnctbgGqgG8tVKrpv+LW8LalVOFECG4S6K3F/iLVABNdK4oRxv9iUMlBMl1SOOwP
	NhJ7hls16+Hw+MXkxkpMmfgoO+GRhLwlXI49G3lp1pFdewFB9vqdYL7q/pyJuFLNQgsiQPrPhyP
	Wf8q5FwybbZVjC0hd0IjdLdc6K1ce859j5vNzmtvylYwMI1fvNd45a+nYiTe0Oa00amu1RUz+rI
	KW2fUe7ijyO1lH3aTUqOOH5jsb2f0q/rCQbU87s1PyYsdKXA54p7tIKq2yfXD5FeMiqcMtucnCy
	wziqoHBF/Qbz2ppNAXA=
X-Google-Smtp-Source: AGHT+IEd84/eqbdOzQRr76ekjrCyFk0NBRioAdlk53fcsJN7nezmxrYB1vyFVjbkEXjCGk5VSpVoDQ==
X-Received: by 2002:a17:907:da5:b0:ab7:6a57:1778 with SMTP id a640c23a62f3a-ab7f31abd38mr1211491966b.0.1739550745402;
        Fri, 14 Feb 2025 08:32:25 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:653:f300:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5323202dsm370716266b.6.2025.02.14.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:32:24 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Fri, 14 Feb 2025 17:32:04 +0100
Subject: [PATCH net-next 2/3] net: phy: marvell-88q2xxx: order includes
 alphabetically
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-marvell-88q2xxx-cleanup-v1-2-71d67c20f308@gmail.com>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
In-Reply-To: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

Order includes alphabetically.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 6e95de080bc65e8e8543d4effb9846fdd823a9d4..7b0913968bb404df1d271b040e698a4c8c391705 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -7,10 +7,10 @@
  * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
  */
 #include <linux/ethtool_netlink.h>
+#include <linux/hwmon.h>
 #include <linux/marvell_phy.h>
 #include <linux/of.h>
 #include <linux/phy.h>
-#include <linux/hwmon.h>
 
 #define PHY_ID_88Q2220_REVB0				(MARVELL_PHY_ID_88Q2220 | 0x1)
 #define PHY_ID_88Q2220_REVB1				(MARVELL_PHY_ID_88Q2220 | 0x2)

-- 
2.39.5


