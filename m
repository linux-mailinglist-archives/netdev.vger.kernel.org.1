Return-Path: <netdev+bounces-140086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FC29B5358
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EE31C2297D
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8558E208974;
	Tue, 29 Oct 2024 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJHmtmB1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DD208211;
	Tue, 29 Oct 2024 20:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233441; cv=none; b=IS++K/Bba/v+8Hj1jXdXmRe3lDEhKi3eNT7TN4qsXXWb5IGeP5zakD9rx/LgV7YaoBHBOhxQCiHNsf/mGW2Tm2vfdwrydv0SmmGFRXJvRqnslnFUHLjKHiYByOosYOHx5Io8rrwirbRuvGPLabPQUB6cLuCnckAaDkbYeydOiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233441; c=relaxed/simple;
	bh=zUAJFmmnkJAWnOviaASwhwRRUPKQVvu8A4WKyBwFSeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQr5wlrmaKp0bxMyOufXFwnhQdqBlyRgVsfWjn9O9S/VJDDbYZdJ2SkKcrDwjeQXxRjM8U2WN5BaTw6dhRlCXL+apprJhBbAAbPmKS/I60dg4oElNATo065oy/YBNgVk3B4D9W7E1yRZW+6dmNrCofB3cSsERXXDVTkdc09V1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJHmtmB1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315855ec58so7085535e9.2;
        Tue, 29 Oct 2024 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233438; x=1730838238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk9braQhcUfjQhD1zhHgydTWlqcLCgBL7v99PtqcEgk=;
        b=QJHmtmB1yvNxDAbZt+rRkNDYoJq385lVRFG8HKDVuzMay2Y1pNRjYRsHSD5mdeOzXp
         UqHLwNtn5YUqpGU3SAjliw5DoWg0T0TdtSrb7vkxY4gXLtx00Zsi0Qx8RhIJriHxYIFl
         zb9DXC8zKZOj1gjYdCHC1oDKmKOlJYgowLYzilr17amDPxbYcORv7p+HI3C/aDnjgfri
         FiyiuMRpq9DY3pGqdx3p9wEO9EY0BxVEzEDUd3Xemn/uj8/zLRl2d59gcN/eaKFKlARA
         c/fM+NeGmHcrY+coeWb1ynUbaQVrzcOb3ig6MqShBvhRCqBrgvBFF8snTMIPejEolhmS
         oCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233438; x=1730838238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk9braQhcUfjQhD1zhHgydTWlqcLCgBL7v99PtqcEgk=;
        b=KWbAKZReqfcHN3Q+HFibvwF1s0CYNpnSbXMP+CxJBLjWOAA+JeaiulxTJ92J+zVMI/
         lQStB+qeOiz3IVlqskNn7+Y3mpKkeyPOzki3bp/vcHhkwmnEGHzoPN0pjclx6tcs16Ku
         hYR92/NGt3v/oNCzmgascCPmDDPc3EV0quiRTwz2HOVbXxEwNRW8DL3EtbA6vSsEGkF2
         TN09bMHIrvs/pjmyew+3o4OFYPbmV1xyUFLxwKB0uVuBauzEKIg0UdRGeJoslymInUVV
         l64xCrjrPC2uEoT6wrXgYTElXOkwx899Zghba7ax8WACFLGQNcocmo3GutUfhLq+P04Q
         ZcUw==
X-Forwarded-Encrypted: i=1; AJvYcCU0snbQ35cNW4t1M0onje1DbCvccLHppE93UqehfXTwQs7cCzUxbc9FjPqfGKWTLKOtylRStChX@vger.kernel.org, AJvYcCUR/tv33W0sKki+WFAIre9vNY+OkChX3WwP5bvmDVMAN1one0OXRMJXTswJMs2zO1xIBGhrCtpM7JryJkFm@vger.kernel.org, AJvYcCWZCacjiGqm2yBXTYVKCdeNr/CdiHR5IOTqoje8nSW/TsgcST6xsw8JRjEP1+U8GlHlxnF8H/DIOsSl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1vM2SxO1zAuY8eNj71E/6GK/mcmguR5qexJQhYMY8QORtjJnb
	1S76N+h3cUxPT9MdIL/Q9BrbUoD+RcQ1zR9kPXVsIQmTZJ3Ko2SE
X-Google-Smtp-Source: AGHT+IHXKDESh6R0R2pH+YTSOSGmekompPP5kRB3raByIC6HZykFMvR8z13eRdBzBJ15DbPxCjmrrQ==
X-Received: by 2002:a05:600c:1390:b0:431:4e33:98ae with SMTP id 5b1f17b1804b1-4319ad14ca6mr47168295e9.5.1730233437588;
        Tue, 29 Oct 2024 13:23:57 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:23:56 -0700 (PDT)
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
Subject: [PATCH v4 03/23] ARM: dts: socfpga: align dma name with binding
Date: Tue, 29 Oct 2024 20:23:29 +0000
Message-Id: <20241029202349.69442-4-l.rubusch@gmail.com>
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

Binding expects the node name to match with dma-controller.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga.dtsi         | 2 +-
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
index c7ba1e4c7..01cc5280f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga.dtsi
@@ -68,7 +68,7 @@ bus {
 			#size-cells = <1>;
 			ranges;
 
-			pdma: pdma@ffe01000 {
+			pdma: dma-controller@ffe01000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffe01000 0x1000>;
 				interrupts = <0 104 4>,
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 7abb8a0c5..aa0e960a3 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -60,7 +60,7 @@ bus {
 			#size-cells = <1>;
 			ranges;
 
-			pdma: pdma@ffda1000 {
+			pdma: dma-controller@ffda1000 {
 				compatible = "arm,pl330", "arm,primecell";
 				reg = <0xffda1000 0x1000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.25.1


