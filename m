Return-Path: <netdev+bounces-134876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BF099B6F1
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 22:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657DD28296A
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58748199936;
	Sat, 12 Oct 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEI5FE09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9718C325
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765331; cv=none; b=DPcSUQjTjpjaJh7gjxvYdzizcxj9aCS2IOzLfrRUAnCkcBtjUStRculhUMcHYQkdEE1Xj29LJ5qx3QNrCQLLPz9gtpjoTf7JaBZXPcYdYUphATrm6a6oeJJEWtAHJzcUH2+yxLl8knW1jVpcje6ceYOAcfW/G2NPaoSd9/AAOdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765331; c=relaxed/simple;
	bh=VRKULwpPbp0Cv94+pXHf87SbaWqT8Zbhw+Pl8htPJbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NhgucpKRlOtOt4NCNf0jAJrtdefojNaPExT7iYE9HB5sxnKB/rGqWAkF7KrqQyi3FirIkPLd7ka7QpNBfa5LBtXq4WrDyeFg2NYf0UchJAuDvz7zewg5EfUbYF7ah32M7FJV/g7Az5pXdi4zuQkms3MvacnomxmHrUeIgWh/mz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UEI5FE09; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so5866233a12.0
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728765328; x=1729370128; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9BNyB46AHTIhhiaPND1rZDxSWDvflwaPYk83T4GY7k=;
        b=UEI5FE09E2F/wLUpVci9QQDvBvK8FFbtC9yPBYkCRCZWPvf4JOHJVtDo0wQbo0BRrQ
         NJSreTTDlRRlgJBMbAYXuh6NutpNj2gdbl2MNJD2fnt0VOJ6ITLgj2wmZTsVatu2hlD+
         MsLViEd7D5G3JNmhC3qN7tgbCpfPgFChirL9mS0pIPj+vTmgMy42QyNaMTVrp/y7Si9o
         D5nGsZZsCzVMFdABXDjS0fpT2NYeBzoPhN02UYaLDQPbDjzgM8pKY6g7flu8L/7sWTGZ
         k7VwL5FRwFA0Xe25MvAEBD3pr6N5bwkrDJkGSB+mNUwbxYmSk090qPVHB27+xYvP6VkE
         narQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728765328; x=1729370128;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9BNyB46AHTIhhiaPND1rZDxSWDvflwaPYk83T4GY7k=;
        b=GrEXlfoaCojmrxtxBdISmfGfe5/L0RPStJksW2UKsUMhgYyEk/q9y8QRzcS7QYTiZf
         Az+p8gjrqiWf1FXK7F88PvziMUz5GSsQ0Cw4XvcP0dOpQzDxk7sBKVXFnBFomwonv1sk
         dM06oTdFqIEJ5/OY3wQNxGop1bY4tzT4201YbLGx8XhqiOCDHO3F9YyzxNMfThV9I/zF
         Geq1fJBZT2pxN5ZImiZnImsFhGAAedEr/nhCEi7esxVVMt427PUPnNvPfLYkiH2Y5f9A
         q8EYN4G3jEpobKCVKaVhMZqKuylrtTEp/3/jjrU4ygqLdFG17wE9PNN2nQJwoOMO4G4B
         2vGA==
X-Forwarded-Encrypted: i=1; AJvYcCVgCpokIJomNnTe11SMQe2bnMjGc0hGsOASH/vtSHm7Jr0zSmgu7eMfTo9PExm5PDCOmpLD9lA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyxvwW46bgdAAWdvkxHQrgSD5wl+Q6oZ+6j6ZAAm4ujPkC0a9o
	9MHEI2S6LRqKBLtHiDPGrcdqG1O7Wzj92Yu5gnxPAulr7idJWr9LCS48DVgfYJR/yiueXhZWmC0
	u
X-Google-Smtp-Source: AGHT+IEDKnALI1x3lBgN0NVYiBrTVdiIc4xFRNjHNsIBxwp7CVJelv46PTux9TosylYEe5zqWrQ8wQ==
X-Received: by 2002:a05:6402:270a:b0:5c8:8b0e:8658 with SMTP id 4fb4d7f45d1cf-5c933577d5amr10097110a12.14.1728765327673;
        Sat, 12 Oct 2024 13:35:27 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372940c1sm3164335a12.82.2024.10.12.13.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:35:27 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] net: phy: mdio-bcm-unimac: Add BCM6846 variant
Date: Sat, 12 Oct 2024 22:35:21 +0200
Message-Id: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIndCmcC/x3MQQqAIBBA0avIrBMcEYmuEi1Sp5qFGgoRiHdPW
 r7F/w0qFaYKi2hQ6OHKOQ3gJMBfezpJchgGrbRBhVo6H+1srIyBs0S0DnUwFBBhJHehg99/t26
 9f4CUbl9eAAAA
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

As pointed out by Florian:
https://lore.kernel.org/linux-devicetree/b542b2e8-115c-4234-a464-e73aa6bece5c@broadcom.com/

The BCM6846 has a few extra registers and cannot reuse the
compatible string from other variants of the Unimac
MDIO block: we need to be able to tell them apart.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      dt-bindings: net: brcm,unimac-mdio: Add bcm6846-mdio
      net: phy: mdio-bcm-unimac: Add BCM6846 support

 Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml | 1 +
 drivers/net/mdio/mdio-bcm-unimac.c                          | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241012-bcm6846-mdio-116b12d4ed11

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


