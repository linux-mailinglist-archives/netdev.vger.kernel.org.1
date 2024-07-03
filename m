Return-Path: <netdev+bounces-109046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E74926AB6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0399A1C23297
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6601946AA;
	Wed,  3 Jul 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAlbfuH/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F31849CD;
	Wed,  3 Jul 2024 21:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043211; cv=none; b=TJcdwexi9To9wC/HOW3Tiy+ruCGcumpWNZIxgvb1tkHv4iZ9TCNPNthnogy3r0/5ONWcQr3UB9GPzqeuElIN9wONGmtqdUPAxN+MvlIhQqaSG5LJKnCgpTbtYsTYVr6BPnl4fZyTCZ5PN2lC7X2Ytrq/4pkw1vhKqJBvZnd/0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043211; c=relaxed/simple;
	bh=1oDjGHCO2layNYkfZA2bIwWBOWSIfVnG6v2XJ1ap/v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzR/Ho8PUlw/EocKJwpJflUw4vAg041qQKYccLxLn5F+r0H34Zn7QG1BDaPihFUbkuf8S5tV6O3I/ubZssrKjEdXBZzzV22axABw05AbovxCPor5q1odbEZx1XBjoCXF85y8o8JX9ERizt8o+yxAtqoJgw2JJ2THKcWxKFNj63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAlbfuH/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36796a9b636so2885f8f.2;
        Wed, 03 Jul 2024 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043209; x=1720648009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvfR2umXKVAqP0RbGK82JzC52vHO5MvpD+H+v3NMVEI=;
        b=JAlbfuH/2e4GI2CcqRc+wl97Lc0mR+rZqk6iouWauTnBSQ46sIZue/6WQxBwhIvuTP
         /c7LBFvdN1dCL03vBJ7FtW7i2H7dasaSZmPE9EmzKlTrdRJ1MCWCgrErjTfnahqm4kte
         DKIWwV9b0Tv7IfcAswxzHcKF9y5Y8NoK6D1+PVLsXaDr/ZSDvG2A/MaNaMHIx0puOJ38
         qBdKvf+cdODJCMxcek/a8P//tJCjEPisqCjRuWpNiaFCoGcO6845XvzP0RrwWSzZ5FUg
         SnJ1DurhF0QT3gXszCCHuEH4hmhV5L7d6Vb3F5LPR0AlBL6gPb/+SnEmPXUFyFyRFTUa
         hF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043209; x=1720648009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvfR2umXKVAqP0RbGK82JzC52vHO5MvpD+H+v3NMVEI=;
        b=mxDSyCzGm1Agv+pInCNJE1SwUaBacqEO85pfXZr2ZgcAGJVUTem3T+6HCz5Z6cZWy2
         Ar03TcmXhB3kfYx1udOAASWbRq6SloksSM+hRbNzkDm/1djSRQx9GfseiBElNiqldqq/
         VgnpY/O38vCk2I4uN05AHoR3pxmvyTTNNgcXQqjTXKrJhwRYIto8sA5Yt2Y5cj1gN1KP
         STvx+K3mzp305zIJ4Ls0dDoKeEJB7anKXcUF6lxCBQXsSYL0LGeYqr1mvhO18HymWCrp
         9j9uMItw4IyPYN+EjCTVf2eIKYrUHSsJ/AxPBTcQ0iX+m3LFeRh0q9puSO5yLOjLS77I
         vmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPe95XhylkKeyB+V6gTNoBTql5gb903EhAvPwHYFKmDOx2MXsNao4x/zRNE8GA/VJhG8aMWveW9y3p9A6h9KPhsNhwDXEGkcfQgB4W
X-Gm-Message-State: AOJu0YxGV8NxXehZrMZhQg5BkfclMxvz7OZrh0sV6Tu5pYo8YpK7hyU1
	Rw/lWA6GmWgN1tQMqRh3jKg+RAfXD1few6xSBsD4i0BRbjrJGu2v
X-Google-Smtp-Source: AGHT+IGIhyYX8lWJWtnryx9cjf0owhsC2zuHNtl81Jk9QXtS+KkskbAOwZG1RSOn+f5IY3f5YuvCfQ==
X-Received: by 2002:adf:e30b:0:b0:367:9b22:28cb with SMTP id ffacd0b85a97d-3679b222c93mr288976f8f.59.1720043208626;
        Wed, 03 Jul 2024 14:46:48 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fbe89cdsm3628068f8f.61.2024.07.03.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:46:48 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:46:33 +0200
Subject: [PATCH 1/4] net: dsa: qca8k: constify struct regmap_config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-net-const-regmap-v1-1-ff4aeceda02c@gmail.com>
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
In-Reply-To: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720043205; l=841;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=1oDjGHCO2layNYkfZA2bIwWBOWSIfVnG6v2XJ1ap/v0=;
 b=QUTdZ9XycnJwmRiVIIdLVzN8qOQ59L3EE8J0BXA4v+vnU4PB1792E0twt+/8/JURDZNGdWfBM
 KhJ3BAhazRXDdvaxS+FPZeIPuSKqYO83xB6dwRC7ewJm5lUuhpb3Mht
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`qca8k_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index b3c27cf538e8..f8d8c70642c4 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -565,7 +565,7 @@ qca8k_regmap_update_bits(void *ctx, uint32_t reg, uint32_t mask, uint32_t write_
 	return qca8k_regmap_update_bits_mii(priv, reg, mask, write_val);
 }
 
-static struct regmap_config qca8k_regmap_config = {
+static const struct regmap_config qca8k_regmap_config = {
 	.reg_bits = 16,
 	.val_bits = 32,
 	.reg_stride = 4,

-- 
2.40.1


