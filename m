Return-Path: <netdev+bounces-232318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B41CAC040E6
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB1144ED88A
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789121322F;
	Fri, 24 Oct 2025 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxpcqEH8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F231F4192
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270942; cv=none; b=aT/P09yasl278pqR4NzmdquqPJvBOLlzdtdha4qwBiEwn175k7oAWqmjVlzctziHgk2nBlqNhaBeI7Vt41lezwio/iHcYbW7WT+PfPsnK60BEABYlvKiofkQ576nAzciI2oFQunw/1XQuG9zVI+KBP4Dxgwrg2LQOxwJWoL8/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270942; c=relaxed/simple;
	bh=jQBHQfAFYy2LZ9zgMurywoJJdSmMMdqANp1sUZ4+wtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAAz/U47KNUkSw28wmrkqZU4WDUs5XrEzKFLgOXWQZ1nQakMeHawaj5tFaMNoVrLpHciGDhb/lqSunyB0Hb8p0EsVq6TVgeMcNq+Y5dqUrsAsR6rpi2bPobgON1OfUqxAcEkxoOOOrWojZDGP6QNRbz7Q66juOIIgcV1B6T6yxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxpcqEH8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso997200a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270940; x=1761875740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnPNWSYL8/32Ip+DCAgHjLLC5ALgmJeNiRp9bOMc41g=;
        b=DxpcqEH8TmgWUBCpOGPytGtT9ECv9xuFP9wPmYkOn2mRPhbARQ0l0tR7YVMns8MIRq
         jc3NMVeB6skBqHK4l7R/Hd3bVQeABbwGJauaBFfB5TsZcyyqsL1kyKHLTtoB+y5I5Qza
         oTpC9Msab2D6nN6d1TqaESCgrGa3os8D/dPd4bgFnFJ1vzYcMtXV0ux7Cd1srL2+XB2Z
         gxNaLSfANhS8ktw/kf9UJwFw+jpJ6IQGwzuQT3Dv1xfW4Iqa8rJh59s3z1sEZ+slcjAF
         XazTgPiAhhsAGWW75Iug8MxAjcXtkT/Zv/zIfdg6jVMWMKwGFveF2iUPm6yI2lTuzkWz
         oLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270940; x=1761875740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnPNWSYL8/32Ip+DCAgHjLLC5ALgmJeNiRp9bOMc41g=;
        b=RlqbaHTEv/8k8hFdKCirQLw1nqPBvsxRSWbPJn62lAPXpsaReE5wLsX6HjoKHBt70N
         hdaObI0Vm+3qDL7Yho/DhQmbliiys7rQwzgveYy53dkXidB1OnD2/BmJRfukmQwQucLc
         6X0M6Ym+lojLXu+zYxURBxL3VeNQ4TSrE26QM/20gJi/nA0kLdDuAJj0KB314Wn87/jN
         9Jmz3YKC7dPTdrYhnNoXth8gSy/cNaWTY4O2m6ejabuUqqAQpD9cNkyeiO6PqQhoKBEo
         0yRjYTMd5M8PnkD6RNZXoTm2Nk56BFRLQnfUdiDV/J/bneWhiqcPxN085BRKromVnSJw
         W4NQ==
X-Gm-Message-State: AOJu0YxVjwev7d8TN1n1ZnktNV8e4nJBqmeq/4U/yBczbqS63J6a3kmR
	pjvdgvHPMeIqCrB3KYGA40y42sx2ss+wgtmHalEJPtfP2enhrW56qlFe
X-Gm-Gg: ASbGncuUCRG3Czlu98iLJNL5ks6XEDVfZfsKx/65R5nyLZYxuPpVo6UiAfXIp3yviVI
	U4dnQSS4lbfKpE6V8uiX0RP/YW0nuPH+HS4cIoOH2yqnxvQhg/TarkEfyIrsrFWDXJfs5bBB4dZ
	hCY3dAoJjYSVhUoUFRnVw0Azwxp9vGdbw6V9gGzr32GeOYUEZSBvpRV8Ttgf2lA26ZLxVL6kY4W
	MNSJ2rk2jBByNGYzG3lTCNTGfYadSGlXzmjMUYvvxCqpMEn8RWUIndBBFgdyBgVov846NO9RYzO
	jLQVj/BCrUgLNWbEmKZzKzwkIzqXVEicreVPn2GAIE2reTukumhqkYtBYJ1lC0lk472RudJGQ4W
	9S1BYuEklKeRQU5RClRjV4TX3Ico78SzkQfTf0R9cLVICYISpH0fao459PHOl36HxGYpMQx06BM
	w=
X-Google-Smtp-Source: AGHT+IEvrwCV3AqeaXcBCGHkmVsO9zDXt6O5hUjk/JLZSn4FLKu2VrTulSCz8MIwR6RtZ00/qylMQw==
X-Received: by 2002:a17:902:cec7:b0:290:afe9:76ef with SMTP id d9443c01a7336-290caf8505bmr346295515ad.40.1761270939983;
        Thu, 23 Oct 2025 18:55:39 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddeb51asm37483385ad.32.2025.10.23.18.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:39 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Fri, 24 Oct 2025 09:55:22 +0800
Message-ID: <20251024015524.291013-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024015524.291013-1-inochiama@gmail.com>
References: <20251024015524.291013-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the ethernet controller of SG2044 and SG2042 only supports
RGMII phy. Add phy-mode property to restrict the value.

Also, since SG2042 has internal rx delay in its mac, make
only "rgmii-txid" and "rgmii-id" valid for phy-mode.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../bindings/net/sophgo,sg2044-dwmac.yaml       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
index ce21979a2d9a..0f1523dc0e36 100644
--- a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -52,6 +52,13 @@ properties:
   interrupt-names:
     maxItems: 1
 
+  phy-mode:
+    enum:
+      - rgmii
+      - rgmii-rxid
+      - rgmii-txid
+      - rgmii-id
+
   resets:
     maxItems: 1
 
@@ -70,6 +77,16 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: sophgo,sg2042-dwmac
+    then:
+      phy-mode:
+        enum:
+          - rgmii-txid
+          - rgmii-id
 
 unevaluatedProperties: false
 
-- 
2.51.1


