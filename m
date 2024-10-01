Return-Path: <netdev+bounces-131048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E198C719
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89A52854D0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125D1CF29F;
	Tue,  1 Oct 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mStwiViK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348271CEEA6;
	Tue,  1 Oct 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816334; cv=none; b=lAs+Mq5j2FrA9FKqTLOXWy4utoGbvM40oVozlF2PIYXJHul3QqTCJHfwwIJ4qnQW2TkAQ58Cpr8jPtMAvPZlKDNkvD1JK5ntsK7SQQ5XyNuA1KdBqf+K3FAbwmDKjtpfauOTKUB6Ds3WOLuU50ZdSmUWTuiDqZDKSce36ZbpI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816334; c=relaxed/simple;
	bh=kk6BZgx6e1aK6qkYUJ4gDXK7X1PwsJgqDQzdqq529+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRsWvpws01FMuKmqApFhuu4tHpUfB4q9I3ELau6QUWybOJH+PWzthWCxgpR4raoiMzmocjBYPbswHNP3rsXHVxKR2W9OiI6IoE6xPJ9gzuOxPhhWdQtPxU4YHTBaj8GznXMrcNR4WBbI2ayFpw4aRzwO7pa4reJgfH412OYQ5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mStwiViK; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso5008910a12.1;
        Tue, 01 Oct 2024 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816332; x=1728421132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=mStwiViK4NgVRIvRn0MCTkpY/hlfrU6Bq0MVi6t+Eic7ZPxsy17r4FQtOH20WuyK4B
         InMiJQ7XfRs8D7JsZnqR/5hvZ4+3WobiQbmUBaYHBhZaQhLC7SpmqcefLAWUMG+SG+LE
         QGfuopDCg+cddGS6cTruEHeeddu5ekRdK2EX/ZAH+lgk9ER4Mj/WS0K/f+Grb++DEDDv
         jCz5/4VVKfHm59aI9ucQq/nLSWefDXPQgjAcBKTxRigbjRtq26pjTbAgQoFn3nrY6ZNr
         elrHTMOv5K0jyWcCql4Fl4LwY6dVzr4WrIHUKSD2i15k2/f5yK36ip0bAjUtP2PHvZfg
         Q2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816332; x=1728421132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTdchS1usQhL1WtM0gjI76UYTIDbC6vW1SK3n+i286A=;
        b=tZ8uabg2+IfD7HqeS4FvBscM1FBPD/qINNbUl0xggMMw3xfQCIUVNTIU84uQkatW7v
         bcgL6NIyEuNK3o5WsUMdyvfl2tu93CfHqTLHtS8iaT7UvTw+KHVklU04h6+EZKVBOwlX
         lJEFe5JeTedRLThoOZw6I5fXxxcUj8GwAUEJ4s+dRnrtLjcMGLeKrw/bNH8Y4SuvPHeH
         8CCcJ9cnaNqJRH+1ByUzZD8wuGt5t5cCifGN5JFPY2Axk0ei2WQLrq/87kXqSBYYoYTW
         SrSspfglJao2Va64sGoaGj2xR5IRBjILnA3egcowYdxJmUBzvTnO8O9GDe7X9brhfV/U
         jC/w==
X-Forwarded-Encrypted: i=1; AJvYcCW0/O9ahxFwkmFRP9CK+0FrsFCYoqdhyml1hXkd7boIlqEX5jar9nBIFj+LS5By1mvtaH73u7i1SceEmAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR4pv0RVZD9iN7u8sY20SjF4E9BkZ3OO+4HVg6BZdV/7la7usy
	he2c8XwwQzwImSH36kZ8EidBDfF1yxO7sxHdlwdtZJae0QFJ0I8ErTxPvUsQ
X-Google-Smtp-Source: AGHT+IFt99AVWEMVsaluLCwiowNU97XyBm5lyHuDwidt8U1ogI3RBbW/yAvgKBrDKJh3++UVAxhGPQ==
X-Received: by 2002:a05:6a20:d494:b0:1d2:eaca:34d4 with SMTP id adf61e73a8af0-1d5db1a35acmr1533558637.4.1727816332467;
        Tue, 01 Oct 2024 13:58:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 04/18] net: ibm: emac: use devm_platform_ioremap_resource
Date: Tue,  1 Oct 2024 13:58:30 -0700
Message-ID: <20241001205844.306821-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to have a struct resource. Gets rid of the TODO.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 97ae0b7ccb0d..205ba7aa02d4 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3050,12 +3050,10 @@ static int emac_probe(struct platform_device *ofdev)
 
 	ndev->irq = dev->emac_irq;
 
-	/* Map EMAC regs */
-	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
-	if (!dev->emacp) {
+	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->emacp)) {
 		dev_err(&ofdev->dev, "can't map device registers");
-		err = -ENOMEM;
+		err = PTR_ERR(dev->emacp);
 		goto err_gone;
 	}
 
-- 
2.46.2


