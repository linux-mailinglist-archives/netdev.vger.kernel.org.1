Return-Path: <netdev+bounces-200105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8EAE3325
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 02:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9491890BC4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 00:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EB21C6B4;
	Mon, 23 Jun 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK2+IksE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE917A2E2;
	Mon, 23 Jun 2025 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750638674; cv=none; b=kQmlMwlq/XzIJY04cEa8FyFe6/VPK/hZVP9asu53CEHhZoRBrQVoQwt4ltnn298JrLsz/Xm5rRMyCvm2cP5bRU8zx68bJB1Gc3872TPP/jDyEbB/EeIljucXpuRxR+1QOaqj3AXg00qEpalq9NquMlAh1uOSvO7KBTamaCrS34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750638674; c=relaxed/simple;
	bh=5ZNqzbA26kOPxapIA2PSAAMFwzrTK2BShlFnMI2cNR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iN9RfTreoINyi4EHidu2P6+quXgRhbxrKolRYmH2nAd+CcDyBDvPFwXSwoCn2CoZ36kMzrYcX9GBZ148jWXdP/UsexLyFyShV4U0jTAHHqg+mtxewcZa4l3z+AkcyGC4V1GwxNKfN/lg+1RFfKVXnkj5V//SyXMmg06kpf/iXTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK2+IksE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso2694117b3a.3;
        Sun, 22 Jun 2025 17:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750638671; x=1751243471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q1kf9zD36m1QpyUUwIQ0WQq+s6bZAcLbbdo0D4u+Fw=;
        b=VK2+IksEbXMfSAlS9t/ygm8JnEzYyOeO3ag15XKgkqm0k+hCEK3eEszXR0uMM5h0yo
         Yoq7r0szl1MXAaEpXSnDTXTGcTZ9w2yetBKPHxM9DAYpG1AOvNV+dS4GoItJrey8eOfz
         RppxGkSrbbPr075m87POr6eZnv/Y9Qx0bfbXMc5RMjyiQatwKKn7NVWf2s4mzR/MH0m8
         n1sa8nc/Q+CzMXJ6Vs1HTWJVZOIt25uJ47xd5HYXHsWhPRDSQIueLt5Do2AMJWBv6dia
         I7UwyFsBjujDwD8ruraEiWYqmxka9pBJSTjb+DdueB/V7GXvZHTQXg7IFynxJvj8Kwfd
         nwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750638671; x=1751243471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q1kf9zD36m1QpyUUwIQ0WQq+s6bZAcLbbdo0D4u+Fw=;
        b=Pgjvbi/ItzAvkdWk/EGscWTne04Jc4r3AKjWP65zzuvMoDUQDPt8Jtu0jiOxs/axcO
         D3wfRLk0Prp5Q4hO9VvwLAle5QBLL0z7MjSYvbDAUqNnytR6NoqSqgMjq5GHiJbzz1ZM
         tjBI9h3hQPpAH48hRyGhGRp7iVqts8ejilV4M0JHwMBxl/9wJoEyYfNBXAAAsCgfUiyb
         hYnVl79XXvsLrVWP/Rip1nNRgQX+YTeDHrk3t8cIOyFXRwDwZyNUIVxfH4fXspZtYCeT
         6Iqazq0LAZr1zObQdLZzXwGAqP21IAZ6l0ddhoXYnYqn2NgLO0mTVfzOhXpI5w4469lO
         lBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzTrxhCLB0mwTE55unDwClP8uEu93naELmPZcSpHQogYK3ZMYuV9IxyA2ZmWc1Tz+YaqywybYUjxMv@vger.kernel.org, AJvYcCXRZ6G8cLozYh2iyRmhmjhfB2KudyR2XAiiXLctYtmseI55gXeWrdj3hKviliBf/oqoxllIxLJqIBt+XY7v@vger.kernel.org
X-Gm-Message-State: AOJu0YyZX2egsAXHHPApThjCFRPP5gEhKYnMoS6fx6kdHrixN/SYOWyY
	IlZbto3xgRAdzrqaeL/HLQ9qCHWgoUMSlI29ns7Y/0/ByViw2R4BR99k
X-Gm-Gg: ASbGncu7SwTRpUH+J5lqCgP9qdSLOLdgxEqRTI/jWko/K9bmPBBHypduTsWbL2pumVR
	9MtVlDD9Aul5ab5Go+KAB9HV0V6BM8GgkB/rxL05QJ1gVj03nJbQZUc0dem9Y6Z4Lt9EwDHmMzO
	g92/hByjxiEFDk1hcXriPxvMi0dUnsTF+tWKH7E1Y8GT6sPYFLb3XqCILtSHnnEsflnKOBOc+Ux
	Kvl1qWXaav6+gWzUFexKk1roOhHnccXcWJAZZVIzzeg1aJytG1j2Ikib0L/gqwvLLsG/ES+zFyO
	RT1qm01/vhs3UOCTFoGXdFuM6ik7Dja9NCvUQbVl/m7b4q/AqoDJw8oIzeiI7Q==
X-Google-Smtp-Source: AGHT+IE7SWkZKqmzCTcflynbcCf+Hta3Lb9CcCnLa9th5SlsVN06IHYW3V9tm1bawfDuAzKPJuJUoQ==
X-Received: by 2002:a05:6a20:258a:b0:21a:bfb6:1c74 with SMTP id adf61e73a8af0-22026fa6a92mr17872987637.34.1750638670941;
        Sun, 22 Jun 2025 17:31:10 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7490a66a763sm7193835b3a.141.2025.06.22.17.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 17:31:10 -0700 (PDT)
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
Subject: [PATCH net-next RFC v2 4/4] riscv: dts: sophgo: Add ethernet configuration for Huashan Pi
Date: Mon, 23 Jun 2025 08:30:46 +0800
Message-ID: <20250623003049.574821-5-inochiama@gmail.com>
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

Add configuration for ethernet controller on Huashan Pi.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
index 26b57e15adc1..86f76159c304 100644
--- a/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
+++ b/arch/riscv/boot/dts/sophgo/cv1812h-huashan-pi.dts
@@ -55,6 +55,16 @@ &emmc {
 	non-removable;
 };
 
+&gmac0 {
+	status = "okay";
+	phy-handle = <&internal_ephy>;
+	phy-mode = "internal";
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


