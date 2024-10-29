Return-Path: <netdev+bounces-140088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4ED9B535F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4DF1C22AA7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776E2209691;
	Tue, 29 Oct 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG3pUDXP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B420898F;
	Tue, 29 Oct 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233444; cv=none; b=UkFiHRI5AyA6dndGqcWjTjFcyl7EKy+VUmfqLM1PESNK1VMdJoQv0KyFkrHURoqkw4vlv8+e5hziXc7uPdedZoRGfU5mHqSj9iKTTlSm/RXBYzTRk5GnjtQqI6340SIOAyh8pUm71gyp95ZdCi0bzvURh80LF7biOfVYkVI1phE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233444; c=relaxed/simple;
	bh=V2yl4lNntEuPEV0X2MVL+IE3GiZVw/y9HCOf0Pz1aTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eM98PS3BmnfKwT4FTlCsHfvmrB96/zNEdao437uRzgBRl5bAkjsqPRulU+bnHn2ZuuBNCnOiGC1EUopb+8zLPJSlq+3P1sQ/0RKF8eTBQ1jejgBIHu/a74nBuFrJikk8xZaDzWC73uH1aRy/fJYOH5wv2PlpranTg6FaJEWHY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QG3pUDXP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ece998fe6so796751f8f.1;
        Tue, 29 Oct 2024 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233441; x=1730838241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wwdH5E3n/FKvtFIFoeUG2vP8wssuIiUjkTOLgVYvdE=;
        b=QG3pUDXP5tmd5bkx2Yjc99kODr3/214DJ0HnutDmcSuihBB+jSYrAAsvCVqSeMEVqP
         LzHjQmbE4CYOBWDXc5RXm74HqrfDtp22tO5kai/vaKq/RmNFyfV8WyNGW+kIHGh1Q2TD
         4kMBJJrNyhVyxEJ8tGFz4NISoFp5ceCYJ7lgPjd3niFbmALVRwGnHIZztoapVNjBj6++
         RHe+QUJAod5R01kBNnQB8ajirUnfpfW75bNrw8LqeUFoqCqHjsxWeDl0Ox0Xo6j0a/9M
         6fCsgpKdSCVNKY+IiRN917018NFuNcuGRfhg2pPTb4QwH9KGXctfgRYr+xoVU3O9R/Tw
         /HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233441; x=1730838241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wwdH5E3n/FKvtFIFoeUG2vP8wssuIiUjkTOLgVYvdE=;
        b=S6Fh9OubaR+nuDONpACeURrmrgLzNAZi4XCLeYJp8ecimsyeheVdvfrTSOhtim5DWc
         dcnewDbVPa87Xet/qi7KQBgzVoKCrd8yGfYNI2jFTmZMA/8kf0xwwJ1Oto5bYU15x+FP
         OwuAbYlV60BLnnff7M7ysjUMyKTqamVLpNSgLmeKYHqN3C3XZO2C8gATm7096nhM4Ohg
         pUCPOtx5LuBjjUnGWD/FzEpzy5vr2bymEfau1q8tCrqdOZWakPI+9SA7iyx+3suq2CwX
         9ey+IqHVcUvsjZ6L5dFbQxY+ArsGK2wyGaip4T/OtXLuJEAdtsgstlS78lVXKy+QeH0Y
         NlDA==
X-Forwarded-Encrypted: i=1; AJvYcCVOBR1n1xe+eC+y3bQAR92W6wLUc+Sg572f0EH/m6aGC11mu5h2l0abl7VRADy05wnv7lDYk32iabh4w9Ww@vger.kernel.org, AJvYcCVRw3GnC153LAndcBtDebMlse1GU19fjpFUGHcyagOGKyxZwkaP/EJtk8YVm6/KdbslOl6ub26/tJox@vger.kernel.org, AJvYcCXwxgXxBTeeL44S/jddNLHBDTfxEX//0Lq5C30NEIMor9atgDWXzAMTFgL0GErcxaL+gwuLrXqB@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzOlWs3wC3Q9R2XvHMbVkCUdVMIbG8s/pG2NSs6lATNqUiguQ
	pK1BHe08PlTNlITmR//jkNvGR2BfMzEYuWCFW6XzB1wavo5B1+2t
X-Google-Smtp-Source: AGHT+IH2AADFwOVOQ1R4+gybUTrdQi/LWShRjvH9Hp6FgJFs5PPv8cF+35BhJDVAUQg7FgD0Y6O57w==
X-Received: by 2002:a05:6000:1fab:b0:37d:47a4:ec2b with SMTP id ffacd0b85a97d-3806121a2b6mr4483656f8f.11.1730233440576;
        Tue, 29 Oct 2024 13:24:00 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:00 -0700 (PDT)
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
Subject: [PATCH v4 05/23] ARM: dts: socfpga: add label to clock manager
Date: Tue, 29 Oct 2024 20:23:31 +0000
Message-Id: <20241029202349.69442-6-l.rubusch@gmail.com>
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

Devicetree setup expects a clock manager label to be around. In
preparation of upcoming changes to allow for compatibility.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 90e4ea61d..7f7ac0dc1 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -88,7 +88,7 @@ fpga-region {
 			fpga-mgr = <&fpga_mgr>;
 		};
 
-		clkmgr@ffd04000 {
+		clkmgr: clkmgr@ffd04000 {
 				compatible = "altr,clk-mgr";
 				reg = <0xffd04000 0x1000>;
 
-- 
2.25.1


