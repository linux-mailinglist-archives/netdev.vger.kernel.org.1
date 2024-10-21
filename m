Return-Path: <netdev+bounces-137428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D719A63F5
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE0B1C21F1D
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E751F4722;
	Mon, 21 Oct 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS0SMo4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDE1EF937;
	Mon, 21 Oct 2024 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507011; cv=none; b=TUVHzAAjsxZb10rvf9WVXmNuP7KetlrwMe0VmZSAqwNXi/BLoh0CHB+tugHH0/TgetPjBOU6eP6rhth7hla68X3uX26vfm8XNj6++vT5wGe6O2d9FAYQtH0xpK7mO18K2MyqZnUQq1C6cSHAdrOp/iKDIP3qt9vsAAOneZbMsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507011; c=relaxed/simple;
	bh=vMFMrXzztda6HoheqmQ7CEavZSRuUMIpXDfn/S5dXa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVlhtlxrqiq2TbVy9Kct5ToyX0TBsrN8AGm9Chay/dI7MXaJG8lZxg2TNEFFPYvUdXMLVRnOLC3EZqXx0IWVusUPqY4JnvSXr0iI78kBnelPmXAfngRSGY1x+m7hWIST2oC8lerELNr/C9e+9ilV7hVw0EqzSl0ocvEeEiZETKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS0SMo4w; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea80863f12so1803390a12.1;
        Mon, 21 Oct 2024 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507009; x=1730111809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgTXpRaa0CS94DWebND0XpyXT65bwzGX/MVLfeTayUc=;
        b=dS0SMo4wNGOIfZc1clpTfCidzm+7iUtAuMYOXGd920LAE43Adkar6q+EEHJV9SCcHn
         e1T2NvmZ4TU4xdulxEmVaHQvNKo9tF3lM8BVjpM+V8iLQxgnLx9CLULL2qqGb6YyjPl0
         J+XsqTU78yDJR/hof+uUMYTNpyVW2Vtl7wj3Y2k8Dm1FXcc8RkigNf5QN2QS8tgErYsj
         M2k5VWqGqpdRsVOS/Z7zTeTTJMAB4ndaPfdyUVk9D+btsit4q7qzpERTuUIohBCvorfB
         Y31MqdcGtUWVgzNEpeNhJGBF2hWW+YaZ3XDN/D+Yc2JUiuUaRoPolwS+0nw/k/ekWSA4
         c++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507009; x=1730111809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgTXpRaa0CS94DWebND0XpyXT65bwzGX/MVLfeTayUc=;
        b=VD827vaeNMhcse2MY/1ypm+cxVpgRGdI5s/nRFkHnRMXJavgD5BGRlv2/K2AqZyTCn
         jzF36OrCDPdZt1IDbjqF2iDwnQZGdYLDwioB35Mx+x8BwQNC1mMpeU9jboZVWZd0Ff4E
         dmE14aeu4V0a8+Bp8Ew0EOL+uhCiikthWXXQLJwuf/rDJPm5BkZFQfAKgCmHmG2Y6R/7
         533bYjmKovskWIYMH0nXU8vBjVz6d8cDxE7mS8ZX3gK4taKtxz/3r6R6bS8e9Gxaj+Wx
         0zaLtkR7HzLf+VAgo8v82ksT0FhSrXOIDVNq4KxO0TUJQ0/JwBVvy5hYSwP0eT7cSyR1
         3jMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgR9mC3wHGJ0BYs4vhs8bV56xlgq5TSc3tfPK8GaipXP3ltv6yaE5lSUIPH0MGmZ8mGaBPqRMR@vger.kernel.org, AJvYcCWHlayhuG3L9qCjcms8u25sc5Vp4oPixZaBf8LYSDjnrZnwmXtezpC8Rj2v4Bi42NfKPgtpbFb1j397@vger.kernel.org, AJvYcCXdijEgzpUcfzQ6BMu5fPHucVVS/r609Q7Pc5Esaegrr713oK1JvPOMvuzgSzYtAyGCZ7e+W+txohWPhXvw@vger.kernel.org
X-Gm-Message-State: AOJu0YzKR6CyZQDOEL7nv91z8uufVCFkhOdNxfBPZp2+ArbEQ214W1oa
	d3MU3GUAXZt8l5Xji4GwGtXdqfJmYXXsqY0+Mu17eYis9Oou0n+N
X-Google-Smtp-Source: AGHT+IHcfOB8KvzIPdr/4gmQUpcTvuERKiXFCsr6Yz6aTePpzQBGy3C9mW284sw41jWu8/yv/Ub+BA==
X-Received: by 2002:a05:6300:44:b0:1d8:a759:525c with SMTP id adf61e73a8af0-1d92c572670mr15063786637.39.1729507009210;
        Mon, 21 Oct 2024 03:36:49 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee63a1sm23044785ad.18.2024.10.21.03.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:36:48 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: net: snps,dwmac: Add dwmac-5.30a version
Date: Mon, 21 Oct 2024 18:36:14 +0800
Message-ID: <20241021103617.653386-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021103617.653386-1-inochiama@gmail.com>
References: <20241021103617.653386-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for dwmac-5.30a IP.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4e2ba1bf788c..3c4007cb65f8 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -31,6 +31,7 @@ select:
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
+          - snps,dwmac-5.30a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -95,6 +96,7 @@ properties:
         - snps,dwmac-4.20a
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
+        - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
@@ -627,6 +629,7 @@ allOf:
                 - snps,dwmac-4.20a
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
+                - snps,dwmac-5.30a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
-- 
2.47.0


