Return-Path: <netdev+bounces-230837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F3DBF0559
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41084E21F7
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356952F5A10;
	Mon, 20 Oct 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3wT9zAQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4BB2F546D
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954172; cv=none; b=hyrBCR89RPF1BaCBrnVHkgbSCdSIFWe23Fb9WLp7AOsSsQKKEIoPSNdc0BXjm6BuGlOvFubeeKwzNFBEfX4HdbQcH6a4X49isjUDXFtR9KEAhdieE3nyBsyQz2kZmcNhnDCcIVpGGvSUhMBTQRz/sR+4j9ID9v2KWFxKaEX5H88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954172; c=relaxed/simple;
	bh=PXseH4AXPA1u06jp3KYScqETJ9W5u1LbZmUsWPspIFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5VBJWZci+zMUlJfyAvGBTPGGIGPo+37SHnMN19ZcV70sNvEJNCxQweCS7dkynUUPAScODlxFtoazF1LXB9TMq0N2zidTeZOt0P/UPos8iNi7ADIBEYK/7imGIG6Sp9dGIZfRWy1eGmuAFm2fn3MLLlno1sB22jC3D5bjrm54hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3wT9zAQ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781206cce18so4198159b3a.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954169; x=1761558969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWcuoCKPdDJm2TuKaUOD3wYJ8UpWoogH56aNLChKmO0=;
        b=S3wT9zAQMi+TAUyMRr45kSakshbo0S2nqiXYEkUtq1KjmT6WXk8XUnrHqVWlRUs/Uj
         +BHJgwQ/S1+vEWbR5u8vtk3G8DgNghYEGGILbWUDC9TQMubqG+1RDQi3WZ/bZc0S7PCb
         8yPqztyHAqox7xIo/khHwqso6gW1/+jASXVgOUUUGj4aLZrn0/YOEL/cPnSp2vgNHQc1
         q53xYqsCICTMkA3VRfPhXkXQF7cXBjYVsnj3NIawaUQWPgb7QpnPoPg+4LxPlmkfGymW
         9J6NVGTNPqY8xb8avkOU3a408lMV2lof5twtPuEXJaAJ7MpPuHmgnkuXwsdFyBYoqC2p
         ZxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954169; x=1761558969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWcuoCKPdDJm2TuKaUOD3wYJ8UpWoogH56aNLChKmO0=;
        b=uAkuasNZWFU0Qqr2GRB/2AGMWHJqZcg3XWB2yBGY3ysK+/s9kPqnCxJm5fZkj0rTLH
         cwHboGalIjIdreP28xoS9axLLrZYIIWjzqYuEy1gGIqEeffCxHu7FAiQAQF7DwQJc87f
         EI0wSRUWEo/iX+ltLRnWoCb+t/aFax9ydiDWOIeYpejXxH3HSUjidk6k2SjfrPTfewxh
         GIDZIpx8aurVPEBGzQHZ2UITOlXHuU+yNj/B75RQtss+DtSN8H+uq1KNP7dASokiaNF0
         +nFEux8O3eivybSmwmAhlUpqagkw2OoAFkW57MfwbJwca8pXhRFnyVsP3Rt5/c2CccBS
         c/0w==
X-Gm-Message-State: AOJu0YwnpRmY2LcVAuOfBDsQiNPsPMOUjcYoIKs+v3wYp5diDR54rffK
	ZqcSQ+HKHUZGX0Dvemi24jqImoGf3C4Y+SYSyecmDrGMqMtkYueEa/Zb
X-Gm-Gg: ASbGncs3IS0LRc5ieFc5QCiDzPxBFpuJjzAepILTZ3Hhj2fWvGYgRX1vwfL8ntfKJPU
	gv/MEbRbEoECTb2+IUfrxrpKfJ+DW+IzZnw3LO3iLhF5dNFTsiQWNSjpDer1EeK/srVtKHjEhXn
	dMoanADMc6YbmgdvUUs883BmXgjWY1rA3j69FZHmQm27YcDLjUqbuJY6KI/YK5nrhgnE0E4poxz
	wwCMuEygI/K5Md6ZrB/JKXZrkiw67wA0XWR/IfRD9BJxOug2lPDJDj6zDj4M1dU8vgynXSbKkDO
	cwW0OlzzqeiwjHb4HHg0dEz7Qf4QJIhNWl0YlYrlR5PN5F+omC/koRk3vvpwxlPqF75/FJSlccQ
	oQpY/MAi/02VndjsSyUMjQtbHM0jzP9UYIZ1CivkXjjaBWzBhFrDei+DbFa/l+Dd3FZNPWqATbb
	E=
X-Google-Smtp-Source: AGHT+IGIQ+fpkFQuGh96PYvhkgcTsp4EgXDaVgp46X6ZalhlUpsQFY6hZLjZrBA81Ys4H3/NGCVNzA==
X-Received: by 2002:a05:6a21:3382:b0:2ca:f345:5673 with SMTP id adf61e73a8af0-334a7a4b585mr15454180637.27.1760954169223;
        Mon, 20 Oct 2025 02:56:09 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f254esm7819782b3a.45.2025.10.20.02.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:56:08 -0700 (PDT)
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
Date: Mon, 20 Oct 2025 17:54:57 +0800
Message-ID: <20251020095500.1330057-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020095500.1330057-1-inochiama@gmail.com>
References: <20251020095500.1330057-1-inochiama@gmail.com>
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
2.51.1.dirty


