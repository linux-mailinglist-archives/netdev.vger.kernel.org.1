Return-Path: <netdev+bounces-59142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563828197C5
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 05:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F71F26342
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 04:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28233BE5B;
	Wed, 20 Dec 2023 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUfruYbu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA997C13C
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ba10647a19so4230971b6e.3
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 20:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703046415; x=1703651215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkQPjZQ33Ljgmtvt2fEErV/4qrSCqWyMlDz/GEXX2eY=;
        b=PUfruYbuANBTci5/JYpQglGC6GJTAWOzo3Zntg/puRqyIaYCF3rK474W5ulsMd9yNG
         YQVxJijpEUflXLYj4DikK2An62q5DoXhgt2IOwN0VSglCyMqqY625d09o4o14TQawfMD
         PYEMMgP33UCNUp+abPvfmWVMaN+KUsatNUVOwnesfIeqCIH3j98W1Ekp0lTcIy37S0K9
         jlnobS5elba55UO4aDvFXUcbo3kjwzHLBkbogGfHNe7CUv8qSo4242/je4ixW2cHp58D
         048EM284zxphV8que1uyNBbIBjXcmIW80blWyVBXPgxRU2yfHjiDl+W5BGmi7G99YOWQ
         gPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703046415; x=1703651215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkQPjZQ33Ljgmtvt2fEErV/4qrSCqWyMlDz/GEXX2eY=;
        b=hMPnvgR4APMehw5tXqEF8vhkahXA4IlSqctHvKp220jlpsolZ/XlhbgSajaT79KnI2
         MISCqT2bzKYyDwYpM5sC4T45vTP2vwRGSyMPFcN4q0id30etb+tv+06cqH1bTNvJxosW
         9aAGathzT58HilkBCaElao3AdLVSzFTIxN2EM/YA5KjlS8n4ZxmfZmVjiDbr4TrFNTgY
         16Fq+bMgwzPe2v+POFUUkgM2TG6X+bEMlOTrV/xOmQ/DLziU7hWdCHPkpccSLIi8+o1+
         wxxXAQ0COSZgivSss1P8qvpPc7R0gN34w6v88nqt2QU7uF//iGh2PqDDhDhy91mmdigm
         DyEg==
X-Gm-Message-State: AOJu0YzJmt6idKUz8XyvEEXlDS/nug1TEkbCWaOCZ8DjE+hZb6sDctVE
	ggcDatiModVcGPMaql1Z1hmF8x8wm0uL5+7r
X-Google-Smtp-Source: AGHT+IFldfjxD9t+LYZ+kkmCI9Rjpg8fZwUyI22JHkO9BKLF3Ha7a/c44FQvm56Lmy/zspbllMznRg==
X-Received: by 2002:a05:6808:3995:b0:3b9:ee89:5427 with SMTP id gq21-20020a056808399500b003b9ee895427mr28787471oib.22.1703046414992;
        Tue, 19 Dec 2023 20:26:54 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id ei3-20020a056a0080c300b006d46af912a7sm6325554pfb.23.2023.12.19.20.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 20:26:54 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v2 1/7] net: dsa: realtek: drop cleanup from realtek_ops
Date: Wed, 20 Dec 2023 01:24:24 -0300
Message-ID: <20231220042632.26825-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220042632.26825-1-luizluca@gmail.com>
References: <20231220042632.26825-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It was never used and never referenced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..e9ee778665b2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -91,7 +91,6 @@ struct realtek_ops {
 	int	(*detect)(struct realtek_priv *priv);
 	int	(*reset_chip)(struct realtek_priv *priv);
 	int	(*setup)(struct realtek_priv *priv);
-	void	(*cleanup)(struct realtek_priv *priv);
 	int	(*get_mib_counter)(struct realtek_priv *priv,
 				   int port,
 				   struct rtl8366_mib_counter *mib,
-- 
2.43.0


