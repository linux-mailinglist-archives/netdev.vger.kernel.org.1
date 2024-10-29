Return-Path: <netdev+bounces-140094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E379B5371
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A94F2826A4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B30A20C002;
	Tue, 29 Oct 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6Gd2IBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B320B1F9;
	Tue, 29 Oct 2024 20:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233455; cv=none; b=JXZYujBz+m/SlYN1EE0VfBDwUuEd3fddb3I01houSzMdOCG8MSmmN+Cc9/FEpVidaG4LekAYZup7dhSZojXXrJMT3QXHi2uh3kxd4wso3GLbEZlOxXf3Js3jGGqmamLJOdT3E6ck4S8MRfUYkNpJ0culxg54WLuO5P/EWYu6T6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233455; c=relaxed/simple;
	bh=ZAE88CsUYehZ4x7ZfB1SApqPKCTLYYoYKH85vSPILZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwgeB0dVB5i/ME7wO1O2EEjR6nLIe0t1Y3IYWfPq8BkFolNJOYA4SRQ211stnwSMOPR7sjiWqv1QhXMDaZuujUr7+wk0A+Cn5fuyU9qCxnvGW+ja/JlWZ4liDcSANEgbocjpb6NufhR39hmr3yOAVJPNYC6iVRa5KL623yAjI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6Gd2IBq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4ddd7ac1so592478f8f.0;
        Tue, 29 Oct 2024 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730233451; x=1730838251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg56kOzcgZYyfjxOgtlPIecLk2wzzp7fMeuBDM37L6g=;
        b=f6Gd2IBq8HatuO6huVkBbxLcIJUwERKIhEVEMeK89/bRhIVNi/7jKMjdrtjt0esvMR
         4lu/Xv3RZUmbYKoldKj5djUZBZbU/78UfWJmz12KuM602QajKrmPgmKLUCr3f2aEmiF5
         Wf9EealPmg8uhVMdA5iBCtHDNBV3hX3mhEtPX7xUoSpBFR7XlwMJYVmaMLC0meAQ57jg
         zkAVp1yBXddmhENlhCMLe8rWrTPafsVKHrYCGlTFUeoaMRiUtiTCNZOULXzHBiivemKe
         5jTCM4gQHjYL+ATojTg5k8EEuGPfCsKefyXUB+FWY3Oh6qW9UWIt5+7x7oajq4DBBvn5
         AtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233451; x=1730838251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mg56kOzcgZYyfjxOgtlPIecLk2wzzp7fMeuBDM37L6g=;
        b=pXILfGM0auG50c+vIAJBwszoU0TO0/jNfXrAB3/Ly1L1XUy9lpApzHpFpkKN+Nurxn
         pVAqSxR+FjXK5lYVApWp0Tc7wtnLGP66abDIUEP+hxlw73eSys5p+JqyfnswTb8rCBRj
         B3aHRhhUlflQRVgYGIKDfdCQ3VxrHMjxVTmZAMAthpPdeiowY1hH161iNvd4qh29PV0/
         uDvFU+vCcR8ijZIj51QMOaddxWCvUTJqXuXjtcdQMpmpIW5byX6mUqtY7qbj9xi4f07m
         +XztGhPgJwETqRwP+aHQ5gHJUJK00tOeWA/Ezgc7bxCq6C8JPTKRufhptrnaI85mNBNv
         6V5A==
X-Forwarded-Encrypted: i=1; AJvYcCU27oVpfcFAsPKLojR03Filxyh+fWhAdMy2RkWeC0GevLkpwUmC41VxBZglH+i3GB+gsUFxNwIsqqsD@vger.kernel.org, AJvYcCU2LiJKxx3ciG1IyRe74bzVHBo1n1ma3L9FoYt75ZyxV6om/bz2+VfDKgE2/06+Qazlz4ISOxLt/hBGYqWo@vger.kernel.org, AJvYcCXtbyGMf7STqslXk1EUZhDSsoNxqb1+0qLGsmoklX1pPwVCYQQExRJhjGoeRUpvZN+DOO05gmYF@vger.kernel.org
X-Gm-Message-State: AOJu0YyP02VmEGPf2v+Sxx7mQ0od/zThP9WFjW6Doj9aBQ6sjqQZQEri
	4m5tNUbtDt0BYkkzombwFrP5qNR9uut8RMWI+WI3yjDNu/tl3cGX
X-Google-Smtp-Source: AGHT+IE2SE7Pl9hETa2QNaY4l2Zh1J8tx94HJ1BeI0oGFH/nw6C1/hbm9Btnw9C+KXluDRBZKD/PmQ==
X-Received: by 2002:a05:600c:511b:b0:431:558c:d9e9 with SMTP id 5b1f17b1804b1-4319ad24126mr50500815e9.5.1730233451009;
        Tue, 29 Oct 2024 13:24:11 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3bf85sm13619976f8f.42.2024.10.29.13.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:24:10 -0700 (PDT)
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
Subject: [PATCH v4 11/23] net: stmmac: add support for dwmac 3.72a
Date: Tue, 29 Oct 2024 20:23:37 +0000
Message-Id: <20241029202349.69442-12-l.rubusch@gmail.com>
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

The dwmac 3.72a is an ip version that can be found on Intel/Altera Arria10
SoCs. Going by the hardware features "snps,multicast-filter-bins" and
"snps,perfect-filter-entries" shall be supported. Thus add a
compatibility flag, and extend coverage of the driver for the 3.72a.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c   | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index 598eff926..b9218c07e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -56,6 +56,7 @@ static const struct of_device_id dwmac_generic_match[] = {
 	{ .compatible = "snps,dwmac-3.610"},
 	{ .compatible = "snps,dwmac-3.70a"},
 	{ .compatible = "snps,dwmac-3.710"},
+	{ .compatible = "snps,dwmac-3.72a"},
 	{ .compatible = "snps,dwmac-4.00"},
 	{ .compatible = "snps,dwmac-4.10a"},
 	{ .compatible = "snps,dwmac"},
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 54797edc9..e7e2d6c20 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -522,6 +522,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_device_is_compatible(np, "st,spear600-gmac") ||
 		of_device_is_compatible(np, "snps,dwmac-3.50a") ||
 		of_device_is_compatible(np, "snps,dwmac-3.70a") ||
+		of_device_is_compatible(np, "snps,dwmac-3.72a") ||
 		of_device_is_compatible(np, "snps,dwmac")) {
 		/* Note that the max-frame-size parameter as defined in the
 		 * ePAPR v1.1 spec is defined as max-frame-size, it's
-- 
2.25.1


