Return-Path: <netdev+bounces-140090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255D39B5366
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B671F23FA7
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E720A5D4;
	Tue, 29 Oct 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uaa34itJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC696209F35;
	Tue, 29 Oct 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233447; cv=none; b=kH8INhWBdkRQyZWJ3X0O0Gr62zNBClwj7qStyBUhdBfNZWjs5DL9c+m4BsCg9IpwLb/yonAK8jPWiNxoiy6V2kd4Ng2dMw9q4e/ROcZnMWaNwywluJXNNH0IhGhOCI18zJNgRvrqqDGrBNIUbDDakGFtS1tqEGyw1pvKctaw3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233447; c=relaxed/simple;
	bh=1KzJp/fai6aB837Tp2XCYOTjK4FVSS8lCtpXFfw4Wj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYZOHOAoeNZhaRWTTfOSKNU4dKRXeqiOwhhVECD++SJVCvGhiqjW92bbq2mX9/yLTeyRDm5ru0RoAMt6S8kRdJAxALV3HWvQTdnhsTajmjM+keC/QV5ukPSI23xpyLQCz5k/1TnlZRGWyLvSdQ4EOjiHQEG1/tTK2U6919XLXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uaa34itJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d432f9f5aso549002f8f.3;
        Tue, 29 Oct 2024 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233444; x=1730838244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syqLQEEuQIy2cda968KqPmvPAkdMXpl9TyM7P/fgr+8=;
        b=Uaa34itJ3roPdHxdOvgqwlkZeILUH/XfeRPvKbWIs8Guz65xsP5cZsdgAyLVn7W7Qv
         eYtXyft4RML2Vwwi/qW9jBTb/o3ModgkIqkOvdrVnlAYhYUmtFRtwQRldYZKm9JGFSaA
         V1CiRyjre1cmpfoEGoUAsVQjj5l9ciSSenIKsKczMcMdN425PX31AYIfq1uT4rAW7SWX
         Lc+8kLSUFSnEHIGvi0KE98YjFnb5bqPx+3J1dDfS5cJm67BcH7ix2bQT2MeuBTBU6H1r
         rZxNRtQqAavNgC8ys5POpXmIHdc9tPn3M1SUoSiLbfj0l5uWVqe4N1v06aSn+HbgMnXm
         tb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233444; x=1730838244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syqLQEEuQIy2cda968KqPmvPAkdMXpl9TyM7P/fgr+8=;
        b=Dx43qhrC3/lb89DMr3pE1VJD61+81uwLkWQg2A/mWB3NhVbvtreUPcQSHn/TAi4cmR
         X8/0Uy2biWMDAVaMYHNVF6MME5hOBZbQxmaKnC986vxDE+LfqROuJuY19YcIMOxnF0Ua
         W81XxFIP3PB2qkb+G/hS6yfolwPkgQwCqy/X4FpUyrr8EtYmFEmqoFcBz5C70LT4gfR7
         LJjWd+l2HTcceMELvX1JAAF9LdeDTrjB+jshyq8XosNtokPJwcdpGLZ6fnDUWeFvDiPG
         JUxhYmdkb8zSkvHivrqJQQYwxhw8TiikviZ76sbr1c6YhREWi48H3vrtIYcpwE8TQWJm
         1YmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGOeyoNtjMvjUa3jacQHmq2TWfHsrMBKBaFdn9dI24lLIR8re94sAjN157q44bDYz07gmuPD0GD7AG@vger.kernel.org, AJvYcCUaW4lpqufPZiErGbpXtVE+ubJZRi9I0LePK2MZZJG4zMO3cKI5T19GHY9y5ieWm9Rs5yKORKPLHfsv9lOc@vger.kernel.org, AJvYcCX45872ng4qunEg9qN+ThPYf64YaLnvXvN+7bcEBBuhUXR1xtrS2o4HIWX0tETYqeLrg+QoyCEK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrn4MSHOhV+eS+LbZ5T69ztzTz3VYJgHtaAlacYZZfjCe0kgPY
	6P3sDuRC3vae8Ej+l4TzNs8VspD8q2vHeBr66zrP1w/IXUy9IrM5
X-Google-Smtp-Source: AGHT+IHGVFfyqJqlmqeKRFFKcmhj1OyaAu/znhSmRzQJTc6ZYgh+32XL3bPFTzuO8uUces3IhKZcmQ==
X-Received: by 2002:a05:6000:1446:b0:37d:54d0:1f15 with SMTP id ffacd0b85a97d-38061231c59mr4689734f8f.7.1730233443892;
        Tue, 29 Oct 2024 13:24:03 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:03 -0700 (PDT)
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
Subject: [PATCH v4 07/23] ARM: dts: socfpga: fix missing ranges
Date: Tue, 29 Oct 2024 20:23:33 +0000
Message-Id: <20241029202349.69442-8-l.rubusch@gmail.com>
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

Add reanges, since by dtschema 'ranges' is a required property here.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 4b19fad1e..65d04339f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -81,10 +81,10 @@ pdma: dma-controller@ffda1000 {
 		};
 
 		fpga-region {
+			compatible = "fpga-region";
 			#address-cells = <0x1>;
 			#size-cells = <0x1>;
-
-			compatible = "fpga-region";
+			ranges;
 			fpga-mgr = <&fpga_mgr>;
 		};
 
-- 
2.25.1


