Return-Path: <netdev+bounces-200104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1CBAE3322
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 02:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741B416B937
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 00:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A1145323;
	Mon, 23 Jun 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfY68fQJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685EE555;
	Mon, 23 Jun 2025 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750638670; cv=none; b=EqituaHUwExIQmC2i1w01X8dKzox3KY/9SPxU5LT2gyev0SXIcS3nrhB7c9wP+/3tjErNXYwAJhceumkEzEp6zoE4qqiSpCfN2BhUz24d1rT658I1VJxVRvc5VtUDlO4SRMoO2B+WftMQ0uffnkLLIvV5cc+uGHy5FiK9MuiJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750638670; c=relaxed/simple;
	bh=MPRNEeeXHuI3gjyT14JRFPyjJQDWqxmEottnPMANd+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5iojFlf0tnz2NQIHJvzc383s3diVeEPo7LWzky2LqfuUjy+nh7zpxT1ufVAis4ZkF//PM64zPoipZwkRlmzMRN3MjZXAVXnJUdeloREP/6eOZLfFxKnq0sCXdyXgppE7cjd6a3jGcHQtHb4oR+0C9lpPUQJ2B+rwdAW50hLVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfY68fQJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23633a6ac50so49258955ad.2;
        Sun, 22 Jun 2025 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750638668; x=1751243468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3DJOTF+zABOGXS6R+n2iHwCpUm4ATi4UcMKKDrEt9s=;
        b=DfY68fQJm2GvVnVSj3mq8+UAw7edAE66VtsQliD0oFeDBCUJv6JQlud56tHV7s3VGo
         sYYSsw25VVX4ycZiwCjmc7KYwXdnZpuZ+CDkv+VhTQNzR1uShmI1vSfHmZHahnvmNWF2
         6v6gCeIsQxeRsF/OK0B8tYp2dAOoxesKYV1PsNXcQsPL2BVs0ZpZ/NA6vbsa8co6Pjdx
         xW+LlmXcptcf/m638ts+y7tvs0zZqrVlf4GGF4XeHdOiYf22r+aar8Aj6dzTvjplJn28
         0xnf3Bhysf5dW8rHGPgXADq0INnLgG3ihsN4VXP3F6EfkDoQ2L4ONsyXxnpe5mSXKoBx
         WGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750638668; x=1751243468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3DJOTF+zABOGXS6R+n2iHwCpUm4ATi4UcMKKDrEt9s=;
        b=dJI5uJLnH89geJwVlCEIUG+mmqnEQ8/PhQJdeeOIdC5hBQjECq6Qflk9q5fHv/Kq2s
         3j0rxKYkSLLsbAmxG+MLCZLOPe4ap7z2gj9efy9uYKBxaqxkEnU4yQIsLxeLxBDZpD+n
         ofx4x1NTdG7RCGv46UzcYMHWfp/TG6tnRz/ey4HR1D6g3VbZkj2Q5h2zVIeWcshYC4Jo
         ZZgDIZ/1B646PjyxYz1n2fHvKUuN4PiM9Iy5QQOeOXjhkZcLcxTgJXSIP8jN39jzgq/V
         eDhlsa3Fk3FYUKojB27fDSguhBJGJ12hNTp8TZUjEha+T+ICNLSuf4ITovga6IU2gGlI
         z86g==
X-Forwarded-Encrypted: i=1; AJvYcCWEYKQXu65yTQmUbPFViKCfjAqpSQ9tPf05l8dl77FDgOshLNSoj2bDpb+QKTN5jgO7RD0U3c86vRGO+yma@vger.kernel.org, AJvYcCWgQ4l0Ph96RSiAGzUHHC3UHhGZeedhtQVhpSVdBw2v1WaBE9qP7JzPu4BVFDz56DKKgGm+tHLGT4jl@vger.kernel.org
X-Gm-Message-State: AOJu0YxOl7qqfEnq/hWSIHjqLzin+sjQ6ya5Te9bBt5YG3CYMzBHEWHO
	fMQ/i75w1YEDbyqym930fWS/QSdcI2MlmVEPhttwsMPbMi0ia0s79eAcNp6NGr41
X-Gm-Gg: ASbGncvZcvCwZ8ESrBacOkd7BmAJa4chZU+hFBkBOzgFhu9w+Zq/SM3MKSQ5SZlATUc
	/h0UXukwq3LpdjXDnLKhkwTOisBiT3xsOfoNYThm+sdZaPFi6OJDDwvMVE5ic7C495XMlpvIub+
	WCJIMTOEQTA42vmIBnZ7zGR8ATVbLE+n5LY377OmsvEwRFweymBTqSBipErtV3zN2rEt+GLqE/M
	ow57qaqOSM4VS3azUGvwOlxt/f0Z4A0ztoM3C8HUDyOLvcKFFBwnXrn8dmas4ykvTvA+WluweDp
	FvriUl/N/cs9/u0mXJMyXoHBi4rX/BIY7xdjZlJiKb89/rEv7CfdBz5bTFVxvQ==
X-Google-Smtp-Source: AGHT+IEPurWQUxaEWPyN4+mm9MSHoAtR/TSkQSrkdqynb1L9lfATLd6vGy5CZaBedpCYL0fvbN+EeQ==
X-Received: by 2002:a17:903:2305:b0:233:ab04:27a with SMTP id d9443c01a7336-237d9a746b0mr174827965ad.53.1750638667818;
        Sun, 22 Jun 2025 17:31:07 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d86101e0sm68637875ad.96.2025.06.22.17.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 17:31:07 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v2 3/4] riscv: dts: sophgo: Add mdio multiplexer device for cv18xx
Date: Mon, 23 Jun 2025 08:30:45 +0800
Message-ID: <20250623003049.574821-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623003049.574821-1-inochiama@gmail.com>
References: <20250623003049.574821-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT device node of mdio multiplexer device for cv18xx SoC.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index 7eecc67f896e..01deb27a95b6 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -31,6 +31,33 @@ rst: reset-controller@3003000 {
 			#reset-cells = <1>;
 		};
 
+		mdio: mdio@3009800 {
+			compatible = "mdio-mux-mmioreg", "mdio-mux";
+			reg = <0x3009800 0x4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mdio-parent-bus = <&gmac0_mdio>;
+			mux-mask = <0x80>;
+			status = "disabled";
+
+			internal_mdio: mdio@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+
+				internal_ephy: phy@0 {
+					compatible = "ethernet-phy-ieee802.3-c22";
+					reg = <0>;
+				};
+			};
+
+			external_mdio: mdio@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x80>;
+			};
+		};
+
 		gpio0: gpio@3020000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3020000 0x1000>;
-- 
2.50.0


