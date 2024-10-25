Return-Path: <netdev+bounces-138912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 349FD9AF67C
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1249B215A4
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442A313212A;
	Fri, 25 Oct 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntXaLEDv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63673433CE;
	Fri, 25 Oct 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818634; cv=none; b=eV+MrStA3yQFHdZzBOqsLiJlVVgVnK5T+Lj3F4aiH7/gK21AaIpC42fO9ofhIn4lxQcBtgYtvQmJBKvpsMjg4ONo/3Zlt3IzfoDfumZoqPCjjv2VL4FF8OqX43bypD4T5+rMhGller8BDGm2JZCEjN/cpm0FYt/+Bt472KUOeD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818634; c=relaxed/simple;
	bh=f6Dima2Y36bgxCR9/TC5mO1Yg4VTmiBOuZ2X/k0C2Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdSnXp7ik8AaE9VzEUzxRqzcsO8//W4PwVyH6501mj6iNR6HGvnMD88TIdidNWFnAu8b9tIJaZrBPHyMt/8CwdU3z0GoDNvjFA1YjNjS0VbdVS3gZ49zRlK1Yy8J1xwP20Mgn61TaQLtkElgd5M22RAoLFFt9BPyg12YKSBUyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntXaLEDv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso12340815ad.2;
        Thu, 24 Oct 2024 18:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729818632; x=1730423432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObJWQqbamWQLgW3lRvM1Wb6QskCzdsvaBlS+OW3U2H4=;
        b=ntXaLEDvtSYowqDd6yKTsbLN70uQc8eZQwTavenx/uyP030v+k3yrN3WGkjSC+HelA
         UU8SlPZ8Wh6HA49EOlkgQX2cP1Nbkd3KSNNPKk8AUI/OLtFePgcCE9V4unKtQFUCo0QA
         gMjIllvIyKiMt6Z61c0W8RNyvPdHHE51WjjK1INbqUuPIy1NGkq4EpbmFuDFcEs59f20
         FK7xRXFkK9YyY+Be2ca/ZcVA3w9YEDQ+PjcMyGv4Vxwp7RuLqM4AJArKC1UavnBstrMQ
         Jfad0K0gbAE++qcXDToodoOeZilCBTq9SS3XkEuqIgLgQdPG8fzEw1/JgJZnsAaqU+2k
         R0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729818632; x=1730423432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObJWQqbamWQLgW3lRvM1Wb6QskCzdsvaBlS+OW3U2H4=;
        b=i9bdH5Jsy5bIN0UjdOIYEsNTIw9DPUYioItgEmcW/VmUCVjzbDCl/Z48r/A079AU5P
         UeyY6MJdb6n4k5zP/3hnA5psRB+lWrt5BohM5z8kfIapwiemVHl9ekMIuDR8nCKSd6LD
         vSqJw523QXd2eJc3Xf71azGfeYD+HlOKxjS+RKQaNa1tlBXsf9YJE5kgkDI8ZFpb20Pt
         4wHxmkYNBjeHgUs6fpvIbfTbxaRFC7PhV9wFiFz9mR6yJSY6IhHKIrQjeVwgAPW5+PEv
         NZnC44fPLURdCUMJdavdkbB//yQkOBu09HdPfx+4v85OvHkBi2mJ7RlPjq+PJbK/6adc
         JZBg==
X-Forwarded-Encrypted: i=1; AJvYcCVMM04Mv6pbwOVYZuZ58m194G5Zp6S8k8/fYrD9TCLwiOZNkJKPuKFAk36n/taXl6WcGkzKYp/UYQB+@vger.kernel.org, AJvYcCXT2fc3Qn8e22XK/Z47Ag3gz5uCwt+mFPuD5OuYXCMkhNxW601LDNQlJSXhH16qrRlVzWZy2Qms@vger.kernel.org, AJvYcCXphs+yXDjO0mHK1dyPbeLzRSaqHpINpUiJ8vgVRfnRl8LpD70zsABnSmgSq3kHyilzS2M+yCq8nelJa3mw@vger.kernel.org
X-Gm-Message-State: AOJu0YxiomhWZcT5gb3AJzDo5JJAIb0ZT5IR7NUiG3toCou4CjJTjp9l
	EJdUzp7lVTTq+Jf7lHMByrIWhAyqZ6+MlUveI4pDwDmjKIR/+jSg
X-Google-Smtp-Source: AGHT+IFk4pp3atZr9i1HsCbtkP4FZ9g8J17pYJBoFXxA6qZJ156yPX2XT6nPSSu7qjRYC7DcVFlOKg==
X-Received: by 2002:a17:902:cf10:b0:20c:3d9e:5f2b with SMTP id d9443c01a7336-20fb9b382a7mr56934405ad.57.1729818631749;
        Thu, 24 Oct 2024 18:10:31 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04b201sm559595ad.272.2024.10.24.18.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:10:31 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 3/4] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Fri, 25 Oct 2024 09:09:59 +0800
Message-ID: <20241025011000.244350-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025011000.244350-1-inochiama@gmail.com>
References: <20241025011000.244350-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ad868e8d195d..3c4e78b10dd6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -555,7 +555,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
 	    of_device_is_compatible(np, "snps,dwmac-4.20a") ||
 	    of_device_is_compatible(np, "snps,dwmac-5.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.20")) {
+	    of_device_is_compatible(np, "snps,dwmac-5.20") ||
+	    of_device_is_compatible(np, "snps,dwmac-5.30a")) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
2.47.0


