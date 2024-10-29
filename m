Return-Path: <netdev+bounces-140091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D249B5368
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921991F21BF6
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1610220ADCB;
	Tue, 29 Oct 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlhBr3BN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E2220A5D7;
	Tue, 29 Oct 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233449; cv=none; b=BtgAfK6L6UiYMafjB0dsrsvVZMu7DGdmdhkgixnJ9sTb9aC28o+bR+XRNzPcM8G/25jtKz5Wh23JCujEQFO3mVty1//L0HZnEe1hpgXZJzLkvzV8RGOS6F0WI6VTBmpOT+QDECVBwVXiWknsbRFm+eCsCqV4n5XrhXhfilDAW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233449; c=relaxed/simple;
	bh=y6S/vFniqdK8FnY4Owxt462kYlq+HMo/27OIQpdXFyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rb7Fkcwo42ul2DZ2hwzrrcOskePkHFnKtY8pL+PVb2sOQINjhGLY8wGYMyfoEiRxE5LG7+AilEm0eGvtnoHKnCAscZGJOcEtOVg4SJWUym/5gLyi3GIK7GXqyy64wLjj+FVU+I9UnP3cZkIeFWIdEf9Nqh42/gPeQocprG/SVsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlhBr3BN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315b957ae8so6260395e9.1;
        Tue, 29 Oct 2024 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233446; x=1730838246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbnDXxocaCyheHFI8hTECOWKPKoXgfCmEGz3dctI1es=;
        b=KlhBr3BNIIEa6JN7gHPI+luJ08sLt/T0LUeCXefeMqqmCXyEfETDzc1tAZbS265ogL
         xoLU9eg2U9EZtUOOK607Ce3BjZxyodffAg7/XNJ5tc7H3galxf9sR2XYXM1kJ4dk0yvs
         wkEbyTcJg2q7pDzHtC5rjCdPj6uh2Nmzidqxp60mziqg9aEHB5Acj1BD0gXKa/bhY+kb
         Pm/u7dccaZCBipsX6b7HArqbHiKnucRM3K6PgViXk1qJ7/ifvFDBgWGdihLoQ4a/aFyj
         TaYhQIxkEb3Sf7A+aJyouJsu4+t2WwL1eXlqVr/z8/2gLDu7e8u3M2KeGmUMY2NOPM1Y
         kcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233446; x=1730838246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbnDXxocaCyheHFI8hTECOWKPKoXgfCmEGz3dctI1es=;
        b=UaRNMLV2U1jzFNUkjbFz+EpN6+LL+AKF0wR5nppPFjt8Xxi7pjw2cyuPp/DxZy00Ik
         li8zvr8LDRUkNvtmrMgfZrQvwp6g/+fIZtsuLWGR+Zat5wznzIewlYa/NFK2SccAQb+o
         GCdLubnhIRvMI/QY1s17dPh4SMhLgLl5yJtwJeh8nBicNQjzb32eCOUJ1CWF36j40dd4
         aorZhv7AP/FAGwXpAI1EsPG8h2mNMQeTYr5LCIypQEPz9Xd+k5OfRQEA9mDKu4M/KQVb
         dr2FN+0Y7JN55G87KIGHsCUw8eDcaiRoPrR+VHAAVUlpdoeFtu/uLY+HcNDd6sqeJHGd
         oWOg==
X-Forwarded-Encrypted: i=1; AJvYcCUQINACtSZTAzEiTDpsxOqPpVpzqvrLzgqnveBWFufcALxVx69DDj6NvP1wdYvH7vTfmsJPTATw4Lc+SwNa@vger.kernel.org, AJvYcCVlJpjWFJA22Sz+B8pLaQD9lT18ODXo7C/ud755UghM4TxrgMBVj3AfmK+fMJ8d7nkePeHuMBC5zotp@vger.kernel.org, AJvYcCWZ/v2tkjEMklPecmieGtawr8bvqoa3rpnwZ7FlmMxTh9ysP8QDlVt3lgkmDV3NpQvFaN5700RE@vger.kernel.org
X-Gm-Message-State: AOJu0YxZm7YxND14OiO1I1GI6Y/x3cZJWvLlsb1XTJxwrXMkJAHK+rtW
	M/Cgbi/aNK8QfHa+cWs9PiY4kz7Evm4oAgivGJmgjQUWqTtSDDIy
X-Google-Smtp-Source: AGHT+IETpjLLRg+7eXu2VyfPEE1vigfdrCP6sTkEwWApr6Df5/fyHL5jVC/64h7dxa0Nz1OLwcuYIA==
X-Received: by 2002:a05:600c:511b:b0:431:558c:d9e9 with SMTP id 5b1f17b1804b1-4319ad24126mr50500115e9.5.1730233446109;
        Tue, 29 Oct 2024 13:24:06 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:05 -0700 (PDT)
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
Subject: [PATCH v4 08/23] ARM: dts: socfpga: add clock-frequency property
Date: Tue, 29 Oct 2024 20:23:34 +0000
Message-Id: <20241029202349.69442-9-l.rubusch@gmail.com>
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

Add 'clock-frequency' is a required property by dtschema. Initialization
is open, similar to agilex devices.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 65d04339f..5f4bed187 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -99,21 +99,25 @@ clocks {
 					cb_intosc_hs_div2_clk: cb_intosc_hs_div2_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					cb_intosc_ls_clk: cb_intosc_ls_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					f2s_free_clk: f2s_free_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					osc1: osc1 {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					main_pll: main_pll@40 {
-- 
2.25.1


