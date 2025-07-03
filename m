Return-Path: <netdev+bounces-203601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18227AF67DE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF1E1C44F7C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1998223DE1;
	Thu,  3 Jul 2025 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMRDxbW+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408122259F;
	Thu,  3 Jul 2025 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508991; cv=none; b=WEBg9VthpsnHdsTs2mxI8s4KtX2/FVqJ+AmMmglVVHs/l2sMBVW8mnahHGqxWp7t/y1Cmx10vvzacJGOUeiUlqtJ8a3U2cJwf1VktoUoJ3ZqAqNRLVTIwHU+c3hfjTQe5x6FT2KLE4NFb1ZAilp2YRvCmfHH3jPjj5kbqtuHT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508991; c=relaxed/simple;
	bh=Hq80mkzOm4sDH1lo61LQlZ+WhvZpGs/2+0D69YVEncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlYIyvMr9B8W4u6okIW5mG/+AprTpqlH3lZTmcO3owvtCjd2Zzl9EEv9SLmIGuDrhPvtPJ77YXY04Yuoair8XOC0l6Ks2/C+9se2ofUpJvs1zslO3JOPbwfvR+0Lc7byWyEXDdMf/qC3LNxERqlq6f3tHbpwGPjSPOWV/fLauoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMRDxbW+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso4603942b3a.2;
        Wed, 02 Jul 2025 19:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751508990; x=1752113790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnJ5HyRFTLzSb90lPZ0kytxtuJ4Ps5kIpRokWvdn6qw=;
        b=HMRDxbW+jRSK4Rc94HqLJ9B+Qc2uebm2XEMDqXJeeXzR29Br1Uw7Hs6mTBw6+IB423
         GQstWm1//qNGxz+E317xo78ku5eAFOqk1JjtZnnp0OeKfl46lx/U0K/ceYHabxIaWNew
         J6Mw/srTQFPdZZZdiOMriyTVHekipIh+tM0piXd45aJQgbJtmAmaDMKfGQM3wfm1tS69
         maB7f/8RC7S78xi3qVyXgrtKqNRCW58BCRUQs1bEhli+7xi0ANHzeqRXwkMI7MtsQPY9
         vE2og1nv/BNxrrU7UOB7+r1lr80gqfMYvV0WqZx97pU2zb7QWIXWfL8xTtPIuRI8HxZn
         mfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508990; x=1752113790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnJ5HyRFTLzSb90lPZ0kytxtuJ4Ps5kIpRokWvdn6qw=;
        b=hXQ2DziQekmDnHu5vGhAaLeiBYiWDrQMjgE6rOULAtg48ARfQilLnJ+8DnG2dmIHC+
         BowIzXMANa44hhGe/BycBNW390UK/8v2U+CCA6jtHMZd388y1dEDWeefESt8GmBLV8cU
         OuNP4GDgkNdmgMqjoR1fnwq8RpYWeUlbmZT3uJoR8JW78y3/2UdRKKJSotIfIY0ixgPn
         3nR9KK41tpOGwuyO/IYbUCRnTBH9jC+qRikTS5b63cTIDtu6ZBL2g8sEwNYyLZseInlH
         k/zBeCZ/bxbCaHUw0bKxmvVuxsXMxZoeLdwkHYEBel2t+n6DApv7WAw8hoDPCzc3nu25
         hgyA==
X-Forwarded-Encrypted: i=1; AJvYcCU0YvUBAvt4P8QKKlc+5Fjd932qsAku31Ht+ynBhR86fZ4/irVSrkPVIieETkjbvo9OLtJraEDtz+3vl4o=@vger.kernel.org, AJvYcCWRE0vagEKMhZFbDUsSdxkg1RwiA/c47uBa3TfdU/8+g+zmYUF2soHd2xR3rirYE0WXB3MPeF+N@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRGYBaojdSr+9caOe+UPx6YU7beFAPfja7e3X+6VgB5l/AK3Q
	2Lcs3h2bcXWcuAAzTfRp0In+gF96d/uPCcFpnVY9bPThhMzAlRpNv+hR
X-Gm-Gg: ASbGncuQUPmkzV1tR/v6gmAClS4CnIY5lPrdz8KLieL5PjcIXimUD8uA9Kj8pdFbYdU
	L+OqSPWwfMNZaOXqR7JjBIkS+oZdKXL05cUYPBW0u8teysKKxNU2scb2LgRwqJQ5M5TiGn/JT0O
	gLGg+z95xRY38TtQtplFTka+GgBIvyZtUESaTm4crFgI0kJxIWUzmAM6VmEUos5k+CfVkSNreRq
	bM4fT387eJ806NLLUZN8Uw5Fz4egvAa9USj5i+OqUvvCn6L/It1uMukXokqeLvLUeiSDwkq8uEu
	DazFb8+HQJMlos4RrrUlw2LkW0IdO2ef+0gqB5M+NYddCG/IZJKcBg7ppnWbagZgpYiAnNAR
X-Google-Smtp-Source: AGHT+IEpMsMQUhVEgvoZKgFsN3ulChI2nMRJELvAlPxYIYdKpwZvdxW8bpYzVJB4RTLdgFWxGCsHMQ==
X-Received: by 2002:aa7:88cf:0:b0:749:1d18:2c74 with SMTP id d2e1a72fcca58-74b50dfa0c2mr6495116b3a.10.1751508989779;
        Wed, 02 Jul 2025 19:16:29 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af54099ecsm15228303b3a.11.2025.07.02.19.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:16:29 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Ze Huang <huangze@whut.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 3/3] riscv: dts: sophgo: Enable ethernet device for Huashan Pi
Date: Thu,  3 Jul 2025 10:15:58 +0800
Message-ID: <20250703021600.125550-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703021600.125550-1-inochiama@gmail.com>
References: <20250703021600.125550-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ethernet controller and mdio multiplexer device on Huashan Pi.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 26b57e15adc1..4a5835fa9e96 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -55,6 +55,14 @@ &emmc {
 	non-removable;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+};
+
 &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
-- 
2.50.0


