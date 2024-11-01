Return-Path: <netdev+bounces-141029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77D9B921B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DD21C21978
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62BD1AA78F;
	Fri,  1 Nov 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNNujloJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2D1A0AFE;
	Fri,  1 Nov 2024 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467943; cv=none; b=TxhJmiMbUmSv8ouLQGMqZtUe98HYwAXG5xrf9KZG7+2FPeFrqT7DRqGKI78oK0LBTr/9pcIGX6lNLkRfJyvqJh9fWKcRksFZDtlTdZQgRaAqr68AmYLz05ZOkcWBmlgGArCBEs2DPU7YsECocSjG0IJfaiLdr4r3HJgZNya+vEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467943; c=relaxed/simple;
	bh=QZVrU0Xh2E9xinIzvVWWn3lNiphnVytKAtEoI1MF/gY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pm7NLtRKVa+IUaho5WWwE3uL2iPe6GZ5wYjWPlZv89DvopRiKcy4r3hNRgw+kJw4Vugshf3kCDQxOy5qiwF+8IOqVy7yzHG5UiTb4xzNDy1Q9BhxMaxXn3TUE5Qmgi20JKea4yYJsehcAlPMY6IacxVhg2ri0cNDFBBVNaeq8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNNujloJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1542259b3a.1;
        Fri, 01 Nov 2024 06:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730467941; x=1731072741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wphCThRlK5730NbXh9Ab0RkkuVRzjiZcFhR/+OwDyt0=;
        b=aNNujloJEXQPHIDJFUuRyTQui8ZVUod4/id6wfdnnRRcw1/S+X9EEqcgLaImxE9Vog
         UscivzgYeJp1M0gc64B8hza5Gf4qUm4RkXUYnxO6JDrcBWvjtxlBSG5TYepxDu7optu+
         PIOha3vFrnHUf9ycEVdY/93gFkc97pH4hYC8fL1XZ7iDCGcjGxGGUjjV1yDh8Nom4+5r
         xj4kvrRdBx+ER+/rKvzxNjggAkwV04NAzxoCiHciF3KTmXudTb5s3x1+df1Ihg2Ggj5t
         a6JNkHd934+mnI0+i/MPyqY4Q3CxOXo1KV6oMmisR/VWVWinS3ZlO/oUEKw/dSDRS8iY
         oSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467941; x=1731072741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wphCThRlK5730NbXh9Ab0RkkuVRzjiZcFhR/+OwDyt0=;
        b=jNdjYRBPcHHOr8BB57j7GuAWSUtDGDj71WOjzGqDaMh2tUz2ooM0yDXAZzUssVwSYR
         ewEgPWGQvhhRSEgtsd6YCzbRy03WzcqnB7HVE/MuqEweSGTag/WZS2Nu2bDusFS3PeoH
         Z7MHNwoVUcqy3q7EtyWXQ57tbVKvAZqDbFjZeClzS/JYTt8henfAGQ2KWacHNlcN4f8G
         OD9JBWOtCR50XwFCDxi3WROxvHblhmDe5UH23/datfKTo2Vbwak6V+l/wHbWeDMwXLmD
         XD3KXVjDvn2RWqjp9Ri/cKt6+FP0yB5fDhIG6b4ezrrPsfKYgsc05RA+Do42/gNxvevq
         6bEw==
X-Forwarded-Encrypted: i=1; AJvYcCUozhppJudLgVJTyzWWUqyawjGFUngrA/emwR2p8D1/zXpsUCH0gWlC9C7VUmrPJs8Brebp/uflEYGKSvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmyit9t1Dn28u0r9fTi9Xx9MMmizkjSCQZnf9qCaoagGIYw3+D
	ttnws6QELF8WXoE91vbeDfelVhsR8WEx9UUr3Hi0GPKaNgBYkfjRYz0DCA==
X-Google-Smtp-Source: AGHT+IEwkwocJqJz+kaOZcvq+ymOZftMTIobWIrePUj2ag6n4idToR7gk3ClbrJoOWA/v/BFlkpmRg==
X-Received: by 2002:a05:6a00:887:b0:71e:72b5:3094 with SMTP id d2e1a72fcca58-7206305a115mr32325469b3a.28.1730467940877;
        Fri, 01 Nov 2024 06:32:20 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee452ac4ffsm2425552a12.25.2024.11.01.06.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:32:20 -0700 (PDT)
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
Subject: [PATCH net-next v8 5/8] net: stmmac: Get the TC number of net_device by netdev_get_num_tc()
Date: Fri,  1 Nov 2024 21:31:32 +0800
Message-Id: <6298463f4655a76faf94e4273a4205c13ca17c77.1730449003.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730449003.git.0x1207@gmail.com>
References: <cover.1730449003.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_get_num_tc() is the right method, we should not access
net_device.num_tc directly.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index affb68604b96..ab717c9bba41 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -304,7 +304,7 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 {
 	u32 val, offset, count, queue_weight, preemptible_txqs = 0;
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	u32 num_tc = ndev->num_tc;
+	int num_tc = netdev_get_num_tc(ndev);
 
 	if (!pclass)
 		goto update_mapping;
-- 
2.34.1


