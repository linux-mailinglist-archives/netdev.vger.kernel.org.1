Return-Path: <netdev+bounces-140092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5AA9B536C
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708AD281E9F
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D312020ADFB;
	Tue, 29 Oct 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7I9we7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2220A5FF;
	Tue, 29 Oct 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233451; cv=none; b=fombhxUzSbWEL6NzZ1vssX8MGbL3H7XwV1omFkzh3Fddvn1NWdDJyfFB/O35+O8gSMNAW0fp5KX8jcjJY/gnW7QCtKe1UwEqkBzi7t/yGIMu91ApbxdknBQi4qzo7d2yAPw1jMw85b6UDQcxDThFifenjgWkiyjpZMYIrwHiw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233451; c=relaxed/simple;
	bh=Ek3f9IntqkTVZaMM5+9uMLvwBlmFC1g5tii851ibiMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9rJ2U+iQXLj12YflLKi5mrY/S1EUkaAGBfVUSUEFVebncmeF/qLqjbd8BCTT6aU+/7RDfYgpzKHEiuM62ftW5hlNmZYSdSxvnPZD4QxypfiWWMfG9kkK4oQGvYNaSMDfS2rvcRGpjcDdUMJ5zIbaQ8GswDiXNDxMQzOoAVEQco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7I9we7b; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315855ec58so7085595e9.2;
        Tue, 29 Oct 2024 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233448; x=1730838248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxrWAGvbebnl7bShJIljz1Nm6dGXiAY6T1E3WWpWzg0=;
        b=F7I9we7bndigOrVU8gsUnYMPSmkB6XYbdlajrNvnVPu1XZT6RfO/H7xn/KqYUeHEwU
         G7e3YcAuN/qlsQP3GL8vF/IZpcc7s3XCX/GAFCq4ImVgtjgjBKpQrvBnIJO2qQqKQptM
         XdHYNjcaz/waEQwafu2pOrRrgz8gCBijbX/niElCAC3rf+2NweZtPaXo99EIGaLba5wL
         sS/TY4vghAKkkVcMJi2XOKtuxyAVX0hs0qVWvt070Pu05Z9Ec3K/XUOPkK8DtKgEAe8r
         nB+AraqN3xXeqpdZkoJY3BMuNWj1EW7SkFLubVBGWI5CpyHKEo3LcQgRzkJ/HZ9TosKO
         wicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233448; x=1730838248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxrWAGvbebnl7bShJIljz1Nm6dGXiAY6T1E3WWpWzg0=;
        b=OR+4czxV4BhOCUnNZOmVFGaFIhuOHq/J2sNC9+7DErqhcCG+Js/+cUQmOoWHYK8qdx
         gusKrp4OtRDJgc+dDumT6mOLExdifTb4FC5WC4Dbz1kJOg7GOA84bq4//2evEam64q5l
         23i9+7bKaYXVGYZQr33fI4Ir5Uki5ArEGGNwxX3VLIgIHlGJqXMHTJcn9UX02cIeUYAb
         J0a1PbCSXeHtxmoMIaH6+zUMifQyfCRGC5hPSet/MNYpwvoF7Qh8KShSVgBc8oNLZwBm
         Ti5wZ0iyUQzUfsBm7ezgjkkZhMmWyjpvVA8uxK+SkNVf83xz3gafAPsBM2i/chjJxd+o
         IfCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQStaj2kwsM1A6+BGupXag4uaaxY92rke98i4Faw4cxwpoi33MaHYOpcXC75o6eVIyoDkC4Eib@vger.kernel.org, AJvYcCVPF3LPihtIBdcsbrWeHx7FQu9uIEDr1xq8O+XTj9udCOTBWVv4CUPam23lqzcRf3fQWt1afpakLlOj@vger.kernel.org, AJvYcCWeIMBSil+i+XmMQh2fGlQzAeygbyHKy/JBEieXGRCd9HujQSVqnB/xQw91i1sDVgbsOePh0LU8Wj4G/Mjk@vger.kernel.org
X-Gm-Message-State: AOJu0YxuPObXRIPpzWi0Ehahvfh7RPA9CUQlMqJndQiLKH591TK0Enp+
	9YRpxVV0l83ScKOmGTRCGFnyuTVXWTw7BfryDk4IbQ3tLkds4WDc
X-Google-Smtp-Source: AGHT+IFe4HEmiUudtU71Iu+vsYyyet/UvGGn2kWZSX/+5WG2rLBnApro20Grx6Z5bXjcP0EijIUzig==
X-Received: by 2002:a05:600c:5494:b0:431:4a7e:a121 with SMTP id 5b1f17b1804b1-4319ad4ee8emr46759745e9.9.1730233447776;
        Tue, 29 Oct 2024 13:24:07 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:07 -0700 (PDT)
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
Subject: [PATCH v4 09/23] ARM: dts: socfpga: add ranges property to sram
Date: Tue, 29 Oct 2024 20:23:35 +0000
Message-Id: <20241029202349.69442-10-l.rubusch@gmail.com>
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

Add 'ranges' to the SRAM node as it is a required property by the
dtschema.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 5f4bed187..6a2ecc7ed 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -691,6 +691,7 @@ ocram: sram@ffe00000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0xffe00000 0x40000>;
+			ranges;
 		};
 
 		eccmgr: eccmgr {
-- 
2.25.1


