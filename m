Return-Path: <netdev+bounces-140087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2739B535A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3A01C22B0A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4319A2A2;
	Tue, 29 Oct 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ991Ifd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3BF208969;
	Tue, 29 Oct 2024 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233443; cv=none; b=l+YhaFslqnBKiQX2HciPiLWmbPexGFp1xuZxZ337sG2mKMFjhG0flp6FjCM1iOVF/Y7XOAuiIjTkGPjPIKS3zm9tPh5m7CN0PewBYFAiOambGYeFu8LUH+c9uWEeB5ISlZopmTxcO8Denx0T6Wz9QWCkA5pg53HUVhBoK2FJ2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233443; c=relaxed/simple;
	bh=6Qat5CV6Gvn1Mg9L2SWD8nbWS8IHMjd9Ue15KWtpNH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQ2ke1/7lK+kiL3xWVZjHOHRhM2zlV+0uycEmBCW+kwo/R+p53K7R3asIoP8QqMcd1ClCSEPA/KMb/0D5oQdHOcha962k0WZ8BP9wtEd96sdtCGRuzTpAQ6psgO4n5h+IkDdrq4q0kTO42+pQwLUBOQw/BMeZyshUiJnsciealY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ991Ifd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43160c5bad8so6248825e9.3;
        Tue, 29 Oct 2024 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233439; x=1730838239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQnRaKE3CWs3EWJZg8TyJXymOuu8Xu8+zwME5vygCHY=;
        b=dJ991IfdcwyORGHeolZVH67IR+qjaph6EB9VakaOFNAGsK3pRCsXnne+loDIiZzKZW
         ui98eUBVQHzzYS5LHRMV4ouyH+6Decwf3BVnaawF1kRN/vwj14Jt3T1Y0oB3DggCq38H
         n2kwvA5We+Q3LGhu11Qb1Sve1G5tXRSWvsEJsQF4d6DybYCiNrMT4n6jInLOwkk8py4k
         GBE5wmmbkDPjuH4vztVirc3vHiUpyP6Gv9k4cI13mbHaYtilPuF32Av0nT8sVFu6pl5r
         AlXRmiCEOIjfVXKwQHV+oBKc8AQ+tHZyz9Gg6+pi4Rjzi9JttgiSPen69q4kyVKlIZqn
         Xy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233439; x=1730838239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQnRaKE3CWs3EWJZg8TyJXymOuu8Xu8+zwME5vygCHY=;
        b=Y9n1G7yczltt8wphhUysHsBKP4LKbAnXkFDRiQsUEQB1UgPnsT/Q2oLDh0Eo5hkfCu
         +0iqBO87UWKBRkRDPxipwpc4pvF9uGVPhOAWxqCX+MeKyiRXI/09t9JN6ePNVN/LVAwM
         KkTAx0LO8GIy8tZLyfw32whbxlpriStIkGTWiuS63mUI5qIztRORy5cJ9XdrtcX0WI/r
         U5iSWwaNTdHSQKl1z2FONRDGH8bG3h7ug9kLqYJCpPpZQPwB489eNZ7gJsRuwX2TUiM/
         pMH1tvRW08CJ8fraYwR5PF6ABeR+Aps7JsIGw/SHP/UaT0ic/DvSOJLRO4rTU8t6mwil
         BBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5u/e6QoZ0fcx3T6ESm85agfb3J4czMDeGsWvIHzf+YpeeTp+xDgHaNy9lJrlWnC1P5SbUW74EtJGsY1OS@vger.kernel.org, AJvYcCUivY/RlLhgIiUs1/d8077AHFrrTk/Sv+LXFZp39qyhYNmjJXGNTwidw7I2bAWC8nrKEbDWsSdX@vger.kernel.org, AJvYcCVPGAm+qTG/12LeZ9t0CDXpzwD7qZMCSz35+DwZGI9KwqDsy3x3PgAKmb/jZ+WOnaABHchkCr/oChxw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7z6tPk+wuMGUsTQ03L9kNYZYZE1bBf88Zy2f9UtnJAmdSUz+a
	V3I3O2R+fNL4ejOksakJPbOF5T/Ia6QHNszbK5JU02LWKTop5wvy
X-Google-Smtp-Source: AGHT+IFiCWzYB+aEmSCBowk9yZWznrjM4cZYnTvHKYnqO8xrzv6uwlDNRcSX/uRWMq3BlsdvGSQiQA==
X-Received: by 2002:a05:600c:19c7:b0:431:5632:448d with SMTP id 5b1f17b1804b1-4319ad76115mr50108665e9.9.1730233439113;
        Tue, 29 Oct 2024 13:23:59 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:23:58 -0700 (PDT)
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
Subject: [PATCH v4 04/23] ARM: dts: socfpga: align fpga-region name
Date: Tue, 29 Oct 2024 20:23:30 +0000
Message-Id: <20241029202349.69442-5-l.rubusch@gmail.com>
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

Binding and setup expects to match fpga-region instead of old naming.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index 01cc5280f..1562669b3 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -87,7 +87,7 @@ pdma: dma-controller@ffe01000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			compatible = "fpga-region";
 			fpga-mgr = <&fpgamgr0>;
 
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index aa0e960a3..90e4ea61d 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -80,7 +80,7 @@ pdma: dma-controller@ffda1000 {
 			};
 		};
 
-		base_fpga_region {
+		fpga-region {
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
 
-- 
2.25.1


