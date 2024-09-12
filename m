Return-Path: <netdev+bounces-127651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFC2975F5F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F462288DEB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9910126BF3;
	Thu, 12 Sep 2024 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="B/lJoPWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707986126
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109812; cv=none; b=crfsypdcuTC6uumoqJfIy9iUgnukVd0b90iAAWmjh7eiK2Ws6pwUP5nBwhOiDZ3jObJV1D0sbAXQfNrWhceReShyA7ar6UrpI7nflNdHJEpsaqkZpkrXiVkqVWdfJ6DXVqWkWBpyPSHqQXsKP3smNf/T9t8BIZmN6owCMXXaXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109812; c=relaxed/simple;
	bh=xm7LbTv/MUcZzmyc0Yj1Cl/PvgH0OuuIJwbz1W9+4+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6KgkE0T2lEK+mrBxoJE74vAbB/EW30ErCIyV8uetknid3Yu/koYdzSGiZHz7eKWa8bppdrD/U+WN3YCihqOCUNa3XbP0HQaFHhFSyrFLUx4RDTPlZk1wZtfhiLrTJXGHpj4xusOK535CxDr+5g1Imdrkr0qvNnfBwgFLxM0My8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=B/lJoPWE; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726109768;
	bh=Q+f7Y6NaDNcklTT7is2kRztTuiX4oAl/H2qYe+la9kk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=B/lJoPWEIcqng/uR0kLhoS0Bk2g4B4gQU0lkkS65+otJUHi6XLIDjBrnY8C9ghwcE
	 NwD6VGKdhqtRMyIvy1em0K7rK0LUFjnj9SeI54AHOWg6ZmgdAQYdjf+3QikK5rOmMJ
	 pFyQdji79e6l5l5E+QVFe3ZlHcSjItbkpj+LClNE=
X-QQ-mid: bizesmtp81t1726109752tgd9zc2a
X-QQ-Originating-IP: FwNYInude3/6pcUIZW5jorMw7+H52eujKyRqd6Fcx+8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:55:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4074563589889725486
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com,
	conor.dooley@microchip.com,
	wangyuli@uniontech.com,
	xingyu.wu@starfivetech.com,
	walker.chen@starfivetech.com,
	robh@kernel.org,
	hal.feng@starfivetech.com
Cc: kernel@esmil.dk,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6 v2 2/4] riscv: dts: starfive: pinfunc: Fix the pins name of I2STX1
Date: Thu, 12 Sep 2024 10:55:06 +0800
Message-ID: <3D0F65E42817C96F+20240912025539.1928223-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240912025539.1928223-1-wangyuli@uniontech.com>
References: <20240912025539.1928223-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Xingyu Wu <xingyu.wu@starfivetech.com>

[ Upstream commit 4e1abae5688aae9dd8345dbd4ea92a4b9adf340d ]

These pins are actually I2STX1 clock input, not I2STX0,
so their names should be changed.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
index fb0139b56723..256de17f5261 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
+++ b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
@@ -240,8 +240,8 @@
 #define GPI_SYS_MCLK_EXT			30
 #define GPI_SYS_I2SRX_BCLK			31
 #define GPI_SYS_I2SRX_LRCK			32
-#define GPI_SYS_I2STX0_BCLK			33
-#define GPI_SYS_I2STX0_LRCK			34
+#define GPI_SYS_I2STX1_BCLK			33
+#define GPI_SYS_I2STX1_LRCK			34
 #define GPI_SYS_TDM_CLK				35
 #define GPI_SYS_TDM_RXD				36
 #define GPI_SYS_TDM_SYNC			37
-- 
2.43.4


