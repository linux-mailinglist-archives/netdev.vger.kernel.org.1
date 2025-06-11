Return-Path: <netdev+bounces-196442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF61AD4DCB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43EA189FBCB
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15CA234973;
	Wed, 11 Jun 2025 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC055Krx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DADD1EBA09;
	Wed, 11 Jun 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629030; cv=none; b=gxKKGmDsgmozjpqok/LKc9ECYJzEeCZ2EklcL754/LtbdfF7R6FSwyO3dpDrkmbRjLxDieKF496PGyybJLVCpubkcWNUGFaW86i4zE9XKx8vBu6JdVVR7MOTC+4yaV09riAbzgecvQlOtiBC1zFUSB6cj5VHZ2eKf3NTu56zuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629030; c=relaxed/simple;
	bh=6ajor1B5tTDHU56MZ9Ugg0LYtwl5SvHnXqqwV6bNozc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i94nOMIY0kPB6UTmP50FNDK19nDbHaLsZ5u/0VhEQcqLG+b+fQTypPL42hg0R5eSAeV+nF7FWp9dAJNcqxt/X9C9e9Yml2gyCefAlGD7RB2Vsq7TyxxrgPBO3I8ifTeZGKHp09fUkCY9ltUEGSm1xQ44J3nlc4dKlvjFqiScHdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BC055Krx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a4bb155edeso78577371cf.2;
        Wed, 11 Jun 2025 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629028; x=1750233828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lO0oOIhU9gTDAHfzv4bngGzr8nk9uJvKVCCgCMFOJ7s=;
        b=BC055KrxvJ2HWdx7D5clYcBLesSmMMTQkHWxClGwE6aESkUsl8ji5DP4UJPAayFNBz
         5TosPuk8BmC79AUBj7ATu2XJd/wrM+Wc/mLE832ZhHKmGUEnFKLtiU+ihoOo3yFHeLqZ
         Qj4m8jh1VUSHt7cqKcZDRyhup+0yqeFZTIP4z74KttWMxe/LIBkCDsqS+Nvoe/ZQjWbv
         2pu43mkhLIKM6bl6hnoysyh6mMMmwhXHF5Ja+rtSjQTnX/b6IjaGqKzqid2WkM90ujpW
         v/GzL0MLjG2KTlTH4rR4X1Ic9nGB/ZbVk4aGC/XLz5SPMFXMGZ3CRsbl1hYmELibp1sH
         mpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629028; x=1750233828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO0oOIhU9gTDAHfzv4bngGzr8nk9uJvKVCCgCMFOJ7s=;
        b=Abzggy6JiU3v9IZxEahXKNxuOB2t1P4NtRVdQrlpAHDvNLOopYg6GmBDV2tqJHjBbM
         l8KuUgy5NF7agohuNaT7cMdgOveMDh7/4S8iqEnnZNVvN0evtkVWk2Mw/jeUI4aDaq8N
         h0QGiGa7WqVWVLbIT8QULASKNvkjNNBDCAQsnfgl8TIjQg3qO5v+M6AfdMtqS3wc4crd
         q04H1JPmHOCbM973hQbt1d4/A4NoGJXwe7lmS9wXgEDbm+NHmL89JGN0bchngG9ms4tT
         7gbeTjJff3jnI5KDhmfAEYHDtDxYXxtSBm58RZ4SMqQlZ/I0gv8bI2OZbF+rwRBEgi1d
         N31Q==
X-Forwarded-Encrypted: i=1; AJvYcCVg1hJOdCMnLzGFQYshiEtfPdVlnxdEv8B3ZJ1gcVQLpDlPGwL/F60B+nowu7TnB/kbUVeqwuZ0awngN3R6@vger.kernel.org, AJvYcCVynYHUhmJClX+cur7ZWVuG8mzQGFM+v9eiT0EaxOQu5vrcD/O6+0Nr8WdpKK/okSV6bnqpgQMJ61go@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPnK4wOOf5CB47LSzz1j/3o5Y3XJl360fp2/q0ETGuZnFY0GA
	yQWmYgJEj1pticwi+/4Fk4a/wC2Kxwc1IWVL3UKao+JULD6ZuBOiEs1M
X-Gm-Gg: ASbGncu0giDpbGdY4YvCqNPCaj19yQWdjtTEsydITclSxOrsPtPKyWfKJrOPmwpNP04
	ligg9hWrGzdPimYM9oyJxufUxGo0D8l/uCRPvYdC/QyK2kEV5UxZQrtXaPS/N71btABQyrNSRxq
	HXt7DFFJYsr0sXoUsbqgvy9tim7c4FrKD/iV+Pra9IG194PpcIINWFc+vLRKr9TTI5v9/iRyMgY
	988ZyoRIoS5msv5uD4edWO3JNZ/MsRXtOqUBJIXX/k1VURcURoMwaZw7MMwAIbNLWf9TU7x+6Jz
	MR9wdNNMW4nA0O1GCUbvrYvdOuoCAyCqPumUoQ==
X-Google-Smtp-Source: AGHT+IG+DVPIIzWnmuIfybYPUVY9Wm0WTbrG5rT0kebswDgegdaXVZwVdvA8Qy8soVcQDTBv9EOxqA==
X-Received: by 2002:a05:622a:4249:b0:4a5:a96d:6068 with SMTP id d75a77b69052e-4a713c5871dmr47918471cf.37.1749629027868;
        Wed, 11 Jun 2025 01:03:47 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a61116ae58sm85983721cf.17.2025.06.11.01.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:03:47 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next 0/2] riscv: dts: sophgo: Add mdio multiplexer for cv18xx
Date: Wed, 11 Jun 2025 16:01:58 +0800
Message-ID: <20250611080228.1166090-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add mdio multiplexer support for CV18XX series SoC.

Inochi Amaoto (2):
  dt-bindings: net: Add Sophgo CV1800 MDIO multiplexer
  net: mdio-mux: Add MDIO mux driver for Sophgo CV1800 SoCs

 .../bindings/net/sophgo,cv1800b-mdio-mux.yaml |  47 +++++++
 drivers/net/mdio/Kconfig                      |  10 ++
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-mux-cv1800b.c           | 119 ++++++++++++++++++
 4 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-mdio-mux.yaml
 create mode 100644 drivers/net/mdio/mdio-mux-cv1800b.c

--
2.49.0


