Return-Path: <netdev+bounces-146009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CE9D1A9B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B881F22949
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94721E909F;
	Mon, 18 Nov 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYOyYA6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297141E8840;
	Mon, 18 Nov 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965243; cv=none; b=ZH6sCO9QNtrPi86VtX9lSZUsXsbshzz0Zy2up5WR2xF6aoYVM4fuPGsrt1rHHeUIueMhhGLTCorkOKk/J5BikBtfvqVbGPHs0nhafrWjjeg0YNWrEvgMrEdtHt7rpXWGPsID0uL1S/lQXQ5p3yry6IbuQP/aruj+FTzUVPsun2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965243; c=relaxed/simple;
	bh=Hg2YJCbKPvRfVlyXe4AKKc1T/lU4ZsS8zwKr1Q4Wu+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilDyn/q1pRlyAZ9lFQT/zCHLG6eqseV19wg9hT8TQ3qbvkltWVJorUPNGrj7zVnY0qfF9du46Fmi97Z0kn3B8cj8omc7pbxnSZE9xj84fDEEZBTLXgxUwdPt02CcbjHi88M6LNY35zmEcn00yEWkqQVMafWsq68r+akWiB9E0x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYOyYA6c; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-212008b0d6eso17445095ad.3;
        Mon, 18 Nov 2024 13:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965241; x=1732570041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnM6r/uVITTRqw7KKlw64GThaVylgqvEAeVcWJSdEdE=;
        b=IYOyYA6cwqtcagrF1C/d/+nEAzSPfxxn7pEIiISrlKXUq6+CNplmXIsf0djd0kuSIM
         yMw0mgWLjM1W3xQFQ/5jbPLUFwzJCyFoc5O0gCuQ8fUh3CpNfwTxPhO+UoC0svRzcMw8
         o5A71bgGQt9uqn7GaXOOkGi88kXIlIEJe+0j/r9deqz283/S5qMhidELtj2qJ03qDXmM
         xcfnnG7NGh7SC6vm+mn+bngxVPwrT+OZ+cy4CoDIiCRbS+GEBP8lQK4fXMV9FXJpoeDK
         /meIuFVl2ZxsvkPZWEQ7xvE4vVPdgXO78WwZFIVzICOhCb0mjLLyfnArnzsFM1v9TOIJ
         K4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965241; x=1732570041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnM6r/uVITTRqw7KKlw64GThaVylgqvEAeVcWJSdEdE=;
        b=FqUNbwOKusYOBaFEucc7onoMxDH+3pC8nKBKoKsydLIGH5aDP7ou/69YxeOt2alKU6
         xvjsN5UdbY7kQg7NzdW5eZ6Ju85CRcJSEu9zee97feaB0LYMISueOJ7B14J81NQL/JhJ
         GP/QQGigWm0xQGr8pJ9WRyOVcHVa0b6kmF7pTM2eeTk6JKmPv28G9+j96pTIUySQkTqb
         KolrnpMNt1VhqfCeE/3jDeuqSaITSr3ysRfFbd20f63eYX+/yIoRMT3MAiUY7e8e0IxN
         H/KrRQtQ2K31q3LBPBhpOUeUU3fgiViHt+602SctWIptneOI72b1FBEA0wfTdi4/lLKh
         K20g==
X-Forwarded-Encrypted: i=1; AJvYcCVuMRvLTcyOFdxbSEjrz+fJNSvTwmSl8EI8zYvUUnsy2LqLbwGrEHxg7oJtSkP9pXZxf6znJbrvxIt3l5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTd6FaqFMzhGsCIR3q4P1/Gy7U//gyOxqjq5Z7y+yh/MwyfYk6
	f6Ku0N2sU8AA2M37aCAv6Z6OuN6Vb9VWYOQz1SM7oZ9x6ZmZb+XbKNO/U7bl
X-Google-Smtp-Source: AGHT+IEwlKoO352VLH1G3bBhpD+GpkKZq3uHSUz2Sop/YQYmOKQ1JaIurcZWd27f1U+xqmQ0jSr2bw==
X-Received: by 2002:a17:903:191:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-211d0ebef76mr213177955ad.35.1731965241142;
        Mon, 18 Nov 2024 13:27:21 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e4c48490sm50681455ad.38.2024.11.18.13.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:27:20 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	maxime.chevallier@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 3/6] net: gianfar: assign ofdev to priv struct
Date: Mon, 18 Nov 2024 13:27:12 -0800
Message-ID: <20241118212715.10808-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212715.10808-1-rosenp@gmail.com>
References: <20241118212715.10808-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is done in probe but not of_init. This will be used for further
devm conversions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 9ff756130ba8..4b023beaa0b1 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -687,6 +687,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	priv = netdev_priv(dev);
 	priv->ndev = dev;
+	priv->ofdev = ofdev;
+	priv->dev = &ofdev->dev;
 
 	priv->mode = mode;
 
-- 
2.47.0


