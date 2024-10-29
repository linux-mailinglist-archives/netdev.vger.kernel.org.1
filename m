Return-Path: <netdev+bounces-140093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D04D9B536F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51AB42837C3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCCD20B208;
	Tue, 29 Oct 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2Qq838J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618420ADEA;
	Tue, 29 Oct 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233453; cv=none; b=uenXZlmRpEaT78/sRjAVX+UaeTfB3LVE3LZLxnK20MBOJhSdelpx1FfM4uXwfaBT7Yrlv3u1Zq+RnXfMlHG1BxqvYVBPqlZz7ZEfpG3u0QvFEpnBq1slZP+04uvUWPtdhyf5Hf1bAEZO/gvuFFPHnGmg0wgUjH8MfJXLvZXVQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233453; c=relaxed/simple;
	bh=GRIprTk55YoxyAtAqBSmeVlFwn+FJRp9HdXHznTSR8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhH5HUM8Y0EX5Pv+8SYKO3JYfo7CUZ7xE9xnabYV7GRLRqIguw7thDGh9WMPL8z1ObJ0oVTOy+KE30CPOJiq2aR1xDRtNGS3qjowhJSlSQp/j9kctqSB2KULyAGjY5PGT4llbiMD1/Y1ZvvS2QwHnq6CvztaXbVoKeYSdI5mBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2Qq838J; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d450de14fso530055f8f.2;
        Tue, 29 Oct 2024 13:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233449; x=1730838249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vySvn0PrZ5KmWWRcUjB0f7ffbO3G5ojONpptbAIcwaU=;
        b=b2Qq838JE0H88FpiqeV3bkkHVchB1tQ+CoprqhVliecg0yqZRnrUr+0OmIrrYU0IMC
         zWScm1oM0SPgT+MBff0d+9zctiLoEBSCCC73adxqJuss3BLaPRGyx3bVL1p4nsB/7cir
         0XlaCPZNRtcwPQcx+uWsNbx5Vvvyx0CJYhlAUrsdWUnrZWO9ZvCczUbCuKaY8EtjMYXs
         zvmNqCFojRmEXvxnTxUrB3sttoNM/1tGvh6WHOc/FbaGHwpsSkCxxGDJYSYq/bgDEPjp
         na+8VHi38ddndSbLJ8R3oor6PjfBY+3syrWoed4iyxMLdZDTLQ7ooHcyNd/BBaPd/rQu
         oSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233449; x=1730838249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vySvn0PrZ5KmWWRcUjB0f7ffbO3G5ojONpptbAIcwaU=;
        b=cO7+M3uNyLX+Wvf1qwHaSMskcsBSqZxN4vLJSSvMrDzN/fiL0j+2SV9ynqAF+/qkS9
         PjrFHTThxyK2jfbngbDBnyM3eV/3bGAk5+zFb+LLJYwxX6SCpRAJ5euMMS8qRjYiBCPQ
         MFTtm8ftxborzlm8qYbHXRDb4wWf8mmcdVdEQySOthHuxDdAMMNgCVGCUjo6bSM104vO
         o7/u0s1NyM9WlI8xLcdrSgbAOuXpz7aQG5KbdDkw4/tj9kmxk2T75qXyg1znJUScJLJB
         7+hfanI6nDAsxo/5yXxhqPWq37ae1c7QLRM4rxg1Rz1dtq6u0/VAiO5L6286DR5uENZj
         O7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUGuO+bXduKIKQ/SFEqi9m9gGwfjCkkrF4ylhaQyhTzkce3SkclDQTk6hI8ER32nkRffutefnok@vger.kernel.org, AJvYcCWKrFrlEhWIJ26lMc9CTSdr9dmID5GOhm15Bvr4yIFyyefcxXf7W5Tju/ElWYVKOM9AVDFinOB6dneizK8P@vger.kernel.org, AJvYcCXvlOaUi9T7KwxCL/sDHgV3sINf4vcISv3qfSihqXz9XJDxTkDktcuSxMjsho/fLKi8z7gx8AG2958e@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+rcv8Mzc7/T6QxXU3a0mdpgwIpe/cA1nt0ndyqqqRMob4qDN
	EaVuuS25xLfMjISsdZy8bdXyNigr34Maw5Ls5xHlS85gxWEMgI4q
X-Google-Smtp-Source: AGHT+IFSpTV0Tj7I6mQHfK9STG9/cLahfdy+XF2noCCt0RfKclZZKLKsVyDf7dEs0S7eg2BUhcBLuA==
X-Received: by 2002:a05:600c:45cf:b0:42c:aeee:d8ee with SMTP id 5b1f17b1804b1-4319ad4adc4mr46799135e9.8.1730233449432;
        Tue, 29 Oct 2024 13:24:09 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:09 -0700 (PDT)
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
Subject: [PATCH v4 10/23] ARM: dts: socfpga: remove arria10 reset-names
Date: Tue, 29 Oct 2024 20:23:36 +0000
Message-Id: <20241029202349.69442-11-l.rubusch@gmail.com>
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

Remove the reset-names since the binding does not mention them, and they
seem not to be used in arria10 (similarily to agilex).

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 6a2ecc7ed..005c57843 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -818,7 +818,6 @@ timer0: timer0@ffc02700 {
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
 			resets = <&rst SPTIMER0_RESET>;
-			reset-names = "timer";
 		};
 
 		timer1: timer1@ffc02800 {
@@ -828,7 +827,6 @@ timer1: timer1@ffc02800 {
 			clocks = <&l4_sp_clk>;
 			clock-names = "timer";
 			resets = <&rst SPTIMER1_RESET>;
-			reset-names = "timer";
 		};
 
 		timer2: timer2@ffd00000 {
@@ -838,7 +836,6 @@ timer2: timer2@ffd00000 {
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
 			resets = <&rst L4SYSTIMER0_RESET>;
-			reset-names = "timer";
 		};
 
 		timer3: timer3@ffd00100 {
@@ -848,7 +845,6 @@ timer3: timer3@ffd00100 {
 			clocks = <&l4_sys_free_clk>;
 			clock-names = "timer";
 			resets = <&rst L4SYSTIMER1_RESET>;
-			reset-names = "timer";
 		};
 
 		uart0: serial@ffc02000 {
-- 
2.25.1


