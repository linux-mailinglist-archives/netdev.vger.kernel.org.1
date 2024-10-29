Return-Path: <netdev+bounces-140085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C59B5355
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D548A1F23E4F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74940208217;
	Tue, 29 Oct 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6cWlj20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55565207A17;
	Tue, 29 Oct 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233439; cv=none; b=fVW7YGH2G6CAUyr+HgeAjGZcK9sFjTJ27RLklU9RxjazmcgCMDp48hrS6RmnSouYq6kh5gRqTn+r//9IyK/sTcAlqfv/BFTNe57GWcMFebjMZ4O32V9A46CuprKn3JwiXNo/Fq70Dvgg9Nr7rbTSKcWWcYMBrL8zQ/cqY2+z07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233439; c=relaxed/simple;
	bh=McMTyWzS0Bg4WFWkM4x5Eq6n8AM1vXInQ676orlwBs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g3fPMvowlTrbjM+U+N455w1fAI8kK9LDRgt2m3Euw3AXkF6ze9ro2HTB1J5ZlH0PoV6fYLgce4bqN04YMVQRFtZgpGZAib7XyFz5q//Udf6LVRr0xZdYAAzclvhEcjta2qC+JOfDPKvbm/pG2DhywyRM7Cy206qS1Ofm1Uas1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6cWlj20; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d450de14fso529999f8f.2;
        Tue, 29 Oct 2024 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233436; x=1730838236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7BTF2QgV5p9nNttdJyKFEUTkRzHJB1L1AnxAUE0mKw=;
        b=P6cWlj207WRhWakbZfsj4LyvtYTT4yeMOF2J+ZYMZSCsq3Ff0Lm9zCpwMYUFxZYE7P
         0iHbf/l/zu9DjIimuFUZWvipkQIP4mCcZDwHhPxwZkoTbMOKdVj4Gtftoz5t2+PIWMom
         g6XoEUEemzd6DIl6rXcA3X69MKQeUzX34Pm/YPkOHZxjL5lK2+rcaHp/dMb4gNS2sgNB
         CgvDo7hEIyvEWxo3LhOsCOf8RYjsH2TJ160kZM1wv08DYoa7VCdu6xkwv5lGrW26tBRe
         vSKIk4Na16Ul49Png0p7ZXvdvSGr8omkrbzCN3DQ+c9Im1aylUZ3E0OEj+8qDx+wQ481
         TF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233436; x=1730838236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7BTF2QgV5p9nNttdJyKFEUTkRzHJB1L1AnxAUE0mKw=;
        b=UKmjE6B2y8jWMdtycSPcjGqB2TGaYRseUG22sK0FhUY0FdqGg/Tms5dV/Cxjd/1ZkC
         gF0Fq1tLRbQgyF9ugD2vLSKUmpaInq/kJ14tKRC6d8ihNMyhlcpiWaePH3kyjzTM9b90
         2pEOglbSH9j0lHqFY7G/gphQxdepL9vdhA9zQsUdPFCsjpjJrr7qGIpc45Cgig1/X2cx
         V70woASzvR+Mcqnau8w8wyvpveQQy7SIwsx5A8nPC7Qcd3FrveL8ucmUJ9lorAQFNIJQ
         EzZ5hth7jMo5Ww8aC7R+i8tzWEYpmCbrwztsVc3AIC9V/3RK6fYeP2BXmdojGqKgltk0
         y5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5R1E0ef5ydGQ7NvNZXt0JclcEVSNja8tNXSUZqtgderuMPLp1sdsUMzvQmndDhCaf1etvv0lYNd9u+HGo@vger.kernel.org, AJvYcCXIw9rGE7FMDLS+VVanrdacyQRaTYfqFkNli4qCiR6XlKGR5QZFdj4HDUxxn2CcywDtaFx8WPRyOAhy@vger.kernel.org, AJvYcCXJ+LRk9In+EdaVUu+C1RMfdCRlZ3cep1tTKenttX51LjmxF1kgxXy8nonRh4/01Z2YUKGKpfVn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XbTP1b/DTUAZhhfrhCNYQPnB68iocsaAPGKh4/uQgcU6ZC+6
	MK6KViAqPnbe/DWaRsBxIjsNWp8FwhlSc7d2hzwDl73ssldVl3o+
X-Google-Smtp-Source: AGHT+IGD+/RLlUFQ9JfrHmh8ZbfUuGjxW0QoMqGnWizIoxkZXn06IHyKtDzC4H57odNMJ3rODgdWcg==
X-Received: by 2002:a05:6000:186b:b0:378:955f:d244 with SMTP id ffacd0b85a97d-380612bdf5dmr4232846f8f.14.1730233435443;
        Tue, 29 Oct 2024 13:23:55 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:23:54 -0700 (PDT)
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
Subject: [PATCH v4 02/23] ARM: dts: socfpga: align bus name with bindings
Date: Tue, 29 Oct 2024 20:23:28 +0000
Message-Id: <20241029202349.69442-3-l.rubusch@gmail.com>
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

Binding expects the bus node name to match bus and not amba.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index 35be14150..c7ba1e4c7 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -62,7 +62,7 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
-		amba {
+		bus {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 7113fe5b5..7abb8a0c5 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -54,7 +54,7 @@ soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
-		amba {
+		bus {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1


