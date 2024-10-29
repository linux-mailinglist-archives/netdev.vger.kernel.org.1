Return-Path: <netdev+bounces-140089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A19B5362
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F7B1F2365A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625A209F45;
	Tue, 29 Oct 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTm/yf8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114D20967F;
	Tue, 29 Oct 2024 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233446; cv=none; b=dKUzrmV4QTnNjwEdqRowBBTljiulOkCIX9bti4ehbMn4+Tt5qoNyA/JrOKg7690KeIsmfeDY4Yz5/m5BOs/BHIqoslLx65FqSq3OlHq6/+eZv5Qs1K+X0iHW4s96mWoIcu/8ObMZvclY8WhtlULjFTR3HYqoIsFscZd/OTRDFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233446; c=relaxed/simple;
	bh=OtMc8F1P0PTrSTV9GAwD2G3wO6F1jpiSdyrg5IQ28zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avImlMkGqbC14+/IubSWNKJniD3P5RBTQaRsgpr+cPcXca8w3ryiWu8yxzG+RwJxwY6HSKqOXAseoQwAHar0Smmd04UL0BOd2OW1G0arCPeniNSsORYXvnPw0H6c+4w5SKEOxGO3PlV4Z5h5tNQMGqyM1bc74a30XZ1LEDJHcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTm/yf8f; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4dbb4a89so618747f8f.3;
        Tue, 29 Oct 2024 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233442; x=1730838242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zykG5xT9htU2beqODKL0ma8uO47wG8f6mRcFvD55rTU=;
        b=KTm/yf8fEuNcLlRj1twUuWPqJloGq6njXSGx+ZpxbW9mbtcExJvxeZHMlf5+guLb5l
         9SddzHVRnj0bfhQZ4D9uJPxCrdasTrgjCJkNCPVFM033K8Ow2ljkYtCXRRQBkhlw2+i7
         nCi1d/4J/8bFGjkgXhwhrPEG2wJ9s/3vZI+gr/oxtcf1xGmQp+Etf02UhE6i2ex8Beba
         7hY44O4XHaRxOhZml4tOrB8dLTTNrQ6tccB2XGm6of75WwJxmQzUJtX5CVE1rcvDL3LD
         S2Cbmjqdjt4IeAxcdqJaCj4WrQtm5bdyYJmqyREdUFJ0uF/D2xjldzcWsjLSUnrkVtq+
         0Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233442; x=1730838242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zykG5xT9htU2beqODKL0ma8uO47wG8f6mRcFvD55rTU=;
        b=Th7eX+qigy7d64VtIdvrL9IBxbfPnzbvN3AY6FtKhrtjTEclbuf0s+NZ/9ZPQRGf4P
         2rCFUGbvOHxuSWqo2bTo9q1dp7EHFMyvRtdURgP03dZYsj7rm1PI500x8/7HcTsPC8ct
         IkhnTWOD9hUzBHLBbeiJztJlaFmDGZhQhht0U4vNmTXdFcvQtARaRpPcyFnLNf09nF0D
         BCUcF1FG9oU/45jnsYWYFvvRsTyAlDa2cuNihx7HYm1COw0+idhMnTCjNYk+SI8vShLA
         HNC9JwuVm3F19La0X6qVG2QXLw3uMbrfMh8l1azUqJoMuydP7MweuON6Ss8uC6vlGCex
         sHkg==
X-Forwarded-Encrypted: i=1; AJvYcCU9csY04wpK4PlsKNJtqbWboX0PW83RrAgiD4GCf6lOAj2xrSVU7RzSnmHr3ozDBwKm/AQ/vGzyCR3Nf2F2@vger.kernel.org, AJvYcCV1JpANa9fHweE5CNTxzJTbQQukFhqkilgaJEusX028rWpqHSYuk+O8qv6jlArbA15AOkcIYUCE@vger.kernel.org, AJvYcCWVzCDhZbTWTAXLxk2cXzTowx/PBVZHuXALMYntsbp0qlKffeCi74c0cZO0rYp6sLtdjtIyFvBS3qSR@vger.kernel.org
X-Gm-Message-State: AOJu0YzdkEdKULHQiIYmt1XQeA0HQOG4bngS7ClDv2AtJeRofGnpjInc
	m14hP+iP0el6GctiEiZPt3HvWppkx+RhUHm6d9VTpd34jDxe06i8
X-Google-Smtp-Source: AGHT+IHmAsezJTQ6HDzRiPuCCGE+RMKKJV1S7Rnrkqh2NL2lY4iIeUnDKBM6QOnU1gla9isevRSz4g==
X-Received: by 2002:a05:600c:3542:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-4319ad08603mr47418785e9.4.1730233442025;
        Tue, 29 Oct 2024 13:24:02 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:01 -0700 (PDT)
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
Subject: [PATCH v4 06/23] ARM: dts: socfpga: add missing cells properties
Date: Tue, 29 Oct 2024 20:23:32 +0000
Message-Id: <20241029202349.69442-7-l.rubusch@gmail.com>
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

Binding requires size-cells and address-cells to be around for the SRAM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 7f7ac0dc1..4b19fad1e 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -684,6 +684,8 @@ nand: nand-controller@ffb90000 {
 
 		ocram: sram@ffe00000 {
 			compatible = "mmio-sram";
+			#address-cells = <1>;
+			#size-cells = <1>;
 			reg = <0xffe00000 0x40000>;
 		};
 
-- 
2.25.1


