Return-Path: <netdev+bounces-140084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E49B5351
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AB4284660
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E6A207A0B;
	Tue, 29 Oct 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7TtF6Vb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A82076B8;
	Tue, 29 Oct 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233437; cv=none; b=NdehTwf5yYrb506Zq74y2BTD2OyM4F0zpfbvY/f8oujxqYkTVGC12DbMGHpSzhAqqqzksU7pf4qEPd8tEDAJrrEKsKtGnLZ3zi1CJZk5NQ+b8pr59dWQIYAO/ef4x2AMgma8eUOr7CCPVpNLwqsmY5l8xlbNlz9iBeM8Ji7GTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233437; c=relaxed/simple;
	bh=Ex8CaFl67w1VtC2hc/lcNDnGnJtDLlBtJT/wSUiYmBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcnQfnYh+8gVpg23rI1rDlOgD5xVZAQJj1yXNG+dj9DGWK0EtBV4Go/hymGWztsaTDU19Gt7Y0OgmHm5BdrGeBWjrkW1L+XTcnA1bFehrw4MS03TrKZcSpqCzLSmPXrgXnYHK+klfaVhSGTbcTLIQ0dHwJfsbgRmMG6DXiEuAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7TtF6Vb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d432f9f5aso548946f8f.3;
        Tue, 29 Oct 2024 13:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233433; x=1730838233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rm8BK0uAln/RMAZHBbXqzd3kfEXu0sK1tEB93lCjSg=;
        b=B7TtF6VbowCm7IMvyyODT599u+QoCemEcp07EgOiFnQ13/zSIARhSm5UDeUlHmjFPy
         fQWghu+75HiUEpzutMbGOcbWdnx49n1IY0hWGy5NpdXLp9L/c97Vcuib3D6JJYzS5gJw
         3LNinv3xh3t9DGdpVaozikJR2+wdf1kZQffavspAcezY3m/HDU69ys/79WlHy+FSUwxH
         d6qdZ8YaSwS7UcwRw+c0UlgaLx/75Cygdb0+3G9HRW+mqs8Tn2rh0oPGXieqtzDyYaCN
         NO/FRSjG29fe8PzexZvjmPJe+fOeQENrdL/kHxXfhWP5PkmKvvk0Lziclwe0e33P/47P
         i3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233433; x=1730838233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rm8BK0uAln/RMAZHBbXqzd3kfEXu0sK1tEB93lCjSg=;
        b=OcZ9WN35SMBsY37k953e2P7x71di0Viu+B13qyWJ22rP1BZBITCyNZz87Oso/5rRvi
         Dv0k+7o03Jg4KZolmbFhfalOBcoh9SBtA7QY0fMSbz6rBEsr5YUzP78DeR769PXtHvLH
         Q/N6pDTGiRId6q1BrKxpGxt+p/7DprV7Z7i8Q2xxHpfn+SxQ+D76fUwnw6dgDo+6pcPk
         0rmqfc4gDDrwcUO8LJ/p6JPt+i7aImocZqpx5s4nnUKYyp2dGifsuReRiq0tUVIr2pTv
         iY+C8hI6i7ER4gDaSJV7MG8SvHkTUjjxwe1bdhqO/rX5CKB3C+T2FlvFX4F75IwsUqaS
         hChw==
X-Forwarded-Encrypted: i=1; AJvYcCUFsj72bo1jCtFtsLtkoIoLrfY5hGBJAkxgZUmJPVu60fL+FLCGZdNdzoWmYcUVZuSTImRtKTM4r1qX@vger.kernel.org, AJvYcCV0Z9fK48W6MdjFTMEzMJjNC5CQS+qKkqDE25l2ntuW0Wvy0FLWF1NAP0p0U8qq8AFdIpZp7x/lM+BWUn0Q@vger.kernel.org, AJvYcCVIvi5xnljy6VoDywpHjYmHYZVTeUOb1Nl6dHhAvKb5iH3alExiCI5ggFyfr0TzpJcF3gpleOYb@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxNHHJZjAxF7Yp5lGA1E03czNFxGHTPOaug5DqDAiI4mHfCXT
	FH/jEgZtCuHn4cGlhCuecjraZdlnVLDbT6SQGaBdREUbq3bFNp6C
X-Google-Smtp-Source: AGHT+IFAOSYhcWWlGhxWeEteuXlA5hTA/tp8gk7Qdph168pUN4cvZcDVaf+e059elXUz5M5LLZtYDg==
X-Received: by 2002:a5d:588a:0:b0:37d:4aa2:5ce8 with SMTP id ffacd0b85a97d-38061206f90mr4581741f8f.5.1730233433082;
        Tue, 29 Oct 2024 13:23:53 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:23:52 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/23] ARM: dts: socfpga: fix typo
Date: Tue, 29 Oct 2024 20:23:27 +0000
Message-Id: <20241029202349.69442-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029202349.69442-1-l.rubusch@gmail.com>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A semicolon was fallen off the wall.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 6b6e77596..7113fe5b5 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -169,8 +169,7 @@ main_gpio_db_clk: main_gpio_db_clk@74 {
 
 						main_sdmmc_clk: main_sdmmc_clk@78 {
 							#clock-cells = <0>;
-							compatible = "altr,socfpga-a10-perip-clk"
-;
+							compatible = "altr,socfpga-a10-perip-clk";
 							clocks = <&main_pll>;
 							reg = <0x78>;
 						};
-- 
2.25.1


