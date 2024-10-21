Return-Path: <netdev+bounces-137427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C99A63F0
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5097F1C21F16
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78491EF925;
	Mon, 21 Oct 2024 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyZ/zI/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053831EF0BD;
	Mon, 21 Oct 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507009; cv=none; b=Ewj1ubZWBOaFD9DA9S9sKhlBZMvohR6X0xbGbjd0hAQdrrtLyDgcOTlB6s40m/S7L1J9qI/Kb9o/2NZusEnBDeS2ZiXQiQSSerHbamcWjPcp+mPyivQpWuRCWuaBRPuEMPe2cfmTThTO96FnbH9Rpvc/7YfgqIgUEI6uAp5tpaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507009; c=relaxed/simple;
	bh=7cBYiwiUKiiQ768DaSB+W9Lzw7c8XLHhwRx684F+EQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8jXwnjjKDFYhej+6goc+hpLF2OpGZSIIbilAnsevXxstNMO9UOttrytewFLTEoUQBuzBtXPKUWXBASOtrQU4qW8aHFWJM2mwBI5YVb9mWGiFgkQDV48SLB9FtU1wY1W88qzbnZsfi+R8r4n882q/Bd7WCPfB6jC+LpaFvg6WtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyZ/zI/v; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso3037506b3a.2;
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507007; x=1730111807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3w+t/hy92F7//9WIWnn/8qnkcbEZ1S9KDEWZUEAsd8=;
        b=dyZ/zI/vJeWVun/u1BZS9KaXp1ijqWLQQeDYdxsfufoq457ETYM9Psf9O4D5QL2stn
         GzE+cbUk3p47aw23Mj+ev242ZwW2XKRtDh3ga0pbEqjtqRl9iC8JhLs8kn74Rm8gM+Ao
         lnPPZh3rWwBxnLuCyv8HZbCTVTFGVVuFUlxSqXBZzjk8vZYv0NqBOVRdEzPa0EEDxAec
         4ROnxB/tirU/XEmLo03rc1xM2bjRA3zB6OFjmici+s2vkBoYhUvdSwdgqekGKrCV2n7I
         ZGtnws834jqWdpTLxNWBwK6vgb217sMMZ0CBX16Do9FAcATaLu/iX90xHah7sj3we08T
         DHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507007; x=1730111807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3w+t/hy92F7//9WIWnn/8qnkcbEZ1S9KDEWZUEAsd8=;
        b=EcarXu2CyskwtN9o6IA6+ADDEreaJOgIy9IQFBwM/wipaa9seIPIO6JSxFzzOfxfwV
         IrE0HiQPw/zRWapssWrntICnE0rDM+JIRa+cCzFoUKjp+HtPYVQj2pZria7/oqlzm2e8
         0C3fm1SsdbY8MKJm6N8dMT6uTFwzYQtWslv61JqC+Ck6DqicptQmsx+26u65tyhd/yKK
         DdHSvL+ItwmmXZeFXih1ENCYluKtjcJc6gBZrkcfzVLeOc+AdWH+9rT5tP/Zc7I1bzg3
         YVEN/ik/K2sGruf8j/+7gZkwWQIKiscrtNHcykPsQDVpSM9jmH9D5uNg0gjUcloG204f
         PJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVDi4R18mnioTwkjOd0ciJZCX1QREB3RqhsCPRis7vFiiZrsyQNVRYstU3YPiQl3MJ5Zsv8bJ9Oucto@vger.kernel.org, AJvYcCXPVG1X+aCcTBzc9dlAsym8RmlI6k3kVocyTmlgfCMbJxmAs8PsBWZ0zhRT0Cw1dNy/LKGRefwZ7YbxGbTg@vger.kernel.org, AJvYcCXxcrQHdHJh7EcaaZhUWc5QHdNF0NWMTUDGOvcoHAwKf980ut4RXp/syyW4FQY6OFR7+/rYjUiG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvcw+h3kcmTZpno68uqlPc497f/Ljl8XgDzGg28eqrt3uoU4RH
	T3O9kZcvlnP8eFjeN5dHY2dnPi+lUGudEv8pp1eGAAvhkBrZq0jE
X-Google-Smtp-Source: AGHT+IElGNzKYcyHQUiYzNuX8VzKK9Yqlu7dfkHxfLYn3GyJigsTd7wxPDUfyzl4ltkknkIdKtCRXQ==
X-Received: by 2002:a05:6a21:710a:b0:1d9:1aa0:10b6 with SMTP id adf61e73a8af0-1d92c4baa97mr14744680637.3.1729507007228;
        Mon, 21 Oct 2024 03:36:47 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad3677efsm3354501a91.17.2024.10.21.03.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:36:46 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 0/4] riscv: sophgo: Add ethernet support for SG2044
Date: Mon, 21 Oct 2024 18:36:13 +0800
Message-ID: <20241021103617.653386-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethernet controller of SG2044 is Synopsys DesignWare IP with
custom clock. Add glue layer for it.

Inochi Amaoto (4):
  dt-bindings: net: snps,dwmac: Add dwmac-5.30a version
  dt-bindings: net: Add support for Sophgo SG2044 dwmac
  net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
  net: stmmac: Add glue layer for Sophgo SG2044 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 ++
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 132 ++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c |   3 +-
 6 files changed, 295 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c

--
2.47.0


