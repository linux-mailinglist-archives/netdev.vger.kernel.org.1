Return-Path: <netdev+bounces-202717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE7AEEC06
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9210F1889F80
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0D81DE89A;
	Tue,  1 Jul 2025 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loZpcox7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F018BC3D;
	Tue,  1 Jul 2025 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332684; cv=none; b=KkSLLgHfVvKtfAIBCDRZuz8YM7NeAivMig2pGrEMhRpwoIL98pj97efhGDm83VJ75vPzgB7R6HoJmajmpFHUKvsmg7JlBS2ESw/h95tcQ5F9ulu75r2nhA9NXxJgR5YqQM5D9P7+BqUaCK4Vkfgg45ppfQ4F6tDhDgwncZEypX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332684; c=relaxed/simple;
	bh=Hq80mkzOm4sDH1lo61LQlZ+WhvZpGs/2+0D69YVEncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVyLMcBeklQR3D+98Ju+gTCYBm942F/q4dLDd2uLktoAFrhcQVkPIM7IyMvdes9o8eVCRJVmQSBGs7H9i0tofDxjjWRsJq9kQCQ6aWzUQyOQPvoP2xMyNRLBK0B5IXCmJrCerzg9Nulq3j37C/CotwWDtcvjyDLePPSNAiPnyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loZpcox7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso3825219a91.2;
        Mon, 30 Jun 2025 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751332682; x=1751937482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnJ5HyRFTLzSb90lPZ0kytxtuJ4Ps5kIpRokWvdn6qw=;
        b=loZpcox7zZF8V01jem7sg+1u9PxizqmSzxsdPHqBKLiQl5LrZZRLnSwnUN2GbJ3qdz
         hJmKvsb0vMFdWXC9JQYzfu5zyGF947wlR93z/7LmFEztUV9iGDx6OYSnlcx8lFXqevyk
         ecJv+b32h3CWy81p3vQcNEC4beDhGdjkOxa1R/+6MZPDDAFAT+vX/c/cOQAMfbfq0rri
         YtPq2WCHdc1e1VgeI1lRTa4Pcwdk5LsiGa/uTDJmTLxpDIZCxCbbZQNut0qTxnViFnfk
         ukY8i5bfHJkxY99s3kvtT5KYydOFUllDqZe7+zV87dj8tFozvMly4riDdat4QVivtpun
         ADnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751332682; x=1751937482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnJ5HyRFTLzSb90lPZ0kytxtuJ4Ps5kIpRokWvdn6qw=;
        b=Rwb22Z1v+7oJyFmV5cow30W9H9jKiuTuUSP6nEZS5d7rCmmqdFFVjJydnwbRiUqxZ9
         Pj+hoLCg0HmQ+qyMd4m0oKTJUmYHaeKw4TTRX6qFsp+IpSP+A/XPn6MlYCKjbu+z+UVQ
         GtJPzPs6bI/3TftOfJ+cq7UiR3IMmIg6wgszo2ECsxSVukweEwChW4C+7T/YiuHuFMRX
         2LqrNUldZQxHV2rMuXh7uGsO0tka6zuNW42h8xcMnTzaVZKGAPLYMPDOEwU63Fm1yMs1
         BOevdVblgxKPBnsRTDZ++Q4guii0sE+ruMoObNsIA+SHf2iMHlf+pbe34zmRwy4hOI/P
         Bc8w==
X-Forwarded-Encrypted: i=1; AJvYcCUvhTcQFG+ArgGy/nelgs2Xd4gpQnNIazdxEWa3kgC4AmK2nDBsJ0oDEVTRrzgSoZQNnBMPY7wZlVe3EbYL@vger.kernel.org, AJvYcCWgTv0NVkDOcLKPB1GAg9ip9idIDTV9JctmXmMUzqysG1YeGepoLuqvBhHhkxivjivDvgOJckq9/F3e@vger.kernel.org
X-Gm-Message-State: AOJu0YxgefVYeslUeYOsFR0Y+mAC+UCPfF7+vEFoqSDXm2zNF5JczGaB
	CHPd8g9xZ8w0KagIsIHJbRpu91TvijjYouTwGbEHPzwCNuHYq9pg3n/K1ivO+7EiqzE=
X-Gm-Gg: ASbGncvMF6iG2k/cs8u7NlQRzpFsa7zTLZsywB6zsFicI36H/FzMjTJI6xJAjckoBHf
	S6Sfp20MVXRx7QwJEoNI8+pyxzMlRIk2xfWy/mURjkPbyDmkQMtRC6FRxF6Kok2i1wYo+eGcqSS
	3AnouXQuBj/Gs8cvlIRt+5x+XzbZyM/boojpnKJs7TqMLHZA409e1W4vw3D3W16TvZ1MR+3rH4b
	7ejcqyrrSFxryIsub2oO5V0wIc9HWrV/DBgOuHuiXeMRIM4HqXE6VS4uzL7oImV/c20hbY8TmD0
	TkNAkZl20Qsaxv6T/JCPZNLM7dg171v709KnkrLwILV6KO1bdUqvAySA44bggpxWnxCdsUVs
X-Google-Smtp-Source: AGHT+IHrvnGB8UpVmo+G36End1O2GSAjnGffQVOqmnvZs9oxeWkVGDRfXR2LbK24Xq3v+GU2Rm3BrA==
X-Received: by 2002:a17:90b:528a:b0:311:d3a5:572a with SMTP id 98e67ed59e1d1-318c9225e52mr21546386a91.8.1751332682255;
        Mon, 30 Jun 2025 18:18:02 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f54417f7sm15446402a91.45.2025.06.30.18.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 18:18:02 -0700 (PDT)
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
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC v4 4/4] riscv: dts: sophgo: Enable ethernet device for Huashan Pi
Date: Tue,  1 Jul 2025 09:17:29 +0800
Message-ID: <20250701011730.136002-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701011730.136002-1-inochiama@gmail.com>
References: <20250701011730.136002-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable ethernet controller and mdio multiplexer device on Huashan Pi.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 26b57e15adc1..4a5835fa9e96 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -55,6 +55,14 @@ &emmc {
 	non-removable;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+};
+
 &sdhci0 {
 	status = "okay";
 	bus-width = <4>;
-- 
2.50.0


