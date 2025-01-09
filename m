Return-Path: <netdev+bounces-156775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90519A07CF3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708D3160B8D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFDD221D80;
	Thu,  9 Jan 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRA2Vn/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0122257E;
	Thu,  9 Jan 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438891; cv=none; b=acIcM0WvSd5xJuAe1Ju0wLUIpevIwB+a8rcdypt1k3deL+1n7WbmcKpFmQIfyIxQvPZPSpSkS4wNkYijrztsoQN+h70DUYO+PA4gP7gOAleCqhMAmIKQdiFJOupU+dpEFpMf2JAmy2CEmAaPMnSU/sSmFFT7JdYNTLSUDqmKCGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438891; c=relaxed/simple;
	bh=Ny6ilxI9jW1+p8xMGkxmpM+ELcaEw3RdKjeVLDhoLaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/4ZkzG9MePkgldG/LhTXiKZmrfLRVJdrQc4QQ/LZCr2bcRmdZtOh0fiIZMBWND3nkkscNR/Tp+4uAI5j6y6ljvcTfxxHknIdvDlKbtA8tUz8HNVLlicTNIQ/LAUwhzuJT00gOYkXBx0pWEwaSrjn9kPxryOuwrrdJ6suXxOpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRA2Vn/S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4362f61757fso11575315e9.2;
        Thu, 09 Jan 2025 08:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736438888; x=1737043688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDoiMsFnbn5JUQtcG1rs+LkrtkLOU3JtO7LMBBVfgVo=;
        b=ZRA2Vn/SjSOvuf5DhFbZcBUTwcOYukWBaRRczx0VFaOGpBGz9bRtl0XwgSfyc4oeji
         Go3hfI3FAQRksRhsptLn3XIfdWtoOAoAjZyH9YDQJmfMcD0WntlVub/HqOWX1OT12ong
         ookWBYFCDptr+UyAvUHxs38FzpeLxlvpWC3etVdzzo7Wv3EEIou7t71KMgaHjht+J1n3
         u12Wu6rMXgb+DU4GpuoLH0OC0YPS38Gi/VRez0zh6BssUYXsudGfcwhL3S7Sr8kxvt5Q
         La6S9NWGYAIL90YLv3opZALBPs6S+sOnR7wORQP6TBi0lT/9SU7E3OMvHkPoUqcSUG12
         ftuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736438888; x=1737043688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDoiMsFnbn5JUQtcG1rs+LkrtkLOU3JtO7LMBBVfgVo=;
        b=DoE1CELRAKbOBntETW9080VXUEusShgIT2s/4lyi7ZWqxmz0vN4uKa2f3RHGnNGNoP
         P6ySOPi1CLBJlMVcTHULx6LDPQKip3QeH9cXOq0nKP3AUgHDHyj12/H4K1fDwTRQhmsq
         jiyM+lwa40SVF3WmsK6ezuLASX6WPgGMzKsy2hUE9WrVo/eYGBozqiwHJtoazac9qg0J
         UgKOzg6l8uPIdCtm5YMX60PbwAjafFnndlIhQftfnbT6gghOFAFkcFKv0mqZuypCsI4o
         cSI52c2msgbcDgY5mlC43rd9NTMlbi/Z+8ILYCzOvApUR7NqATApc2tzucJaXOj72acH
         0mQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoAUaoawk6p7xKmqEfH9PflC/NpR+xqV0ufpHiTIjZ9pW6+SuMhBCNObKLV+2TNRoL9WqQTSg7UUE3akM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWDBoM4d0iMX4q0fLntY/ztpDybH3U+27Kzkr0neaAIsSu1GKQ
	l+yCYxHx8v7PfxQXPdX/kkqCxnDs1Ow3yJzQ+YWVbIZ+o52mporH
X-Gm-Gg: ASbGncvGPMLqV+MzdBSco1Ro/LkNoXO9XtFUx3fV7qcNUJSm28ytNo+3AnTiA7PSn44
	FDTxB/m27VaaC7m7afCfdMk45w7Sgd29w6jJUeVztPPP/64iwcdRF0K5gTLSOF5Qjpz2JQI894r
	ALFtYzIM+qEYItRPayFR81Y10/amlafmXJTEAmUvBMgsmcn6rLlmEJbyeTxzSTHqRh0v5dHBvsz
	hAO3ImbUqE6UoN54BpLwb+3RgROWUmcvGRUjmgndqHN8IB1dp0c5lmT
X-Google-Smtp-Source: AGHT+IEsGCIC45RR7BVCyQeCR8u7TPJ5P1zGMYvvoU4MqQxYu495kCeS24QxHR3OQGZbTFPwVjqHIg==
X-Received: by 2002:a05:600c:3103:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-436e26ae9b1mr68525405e9.5.1736438887686;
        Thu, 09 Jan 2025 08:08:07 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62333sm24728155e9.36.2025.01.09.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 08:08:07 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"'David S . Miller'" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: stmmac: sti: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date: Thu,  9 Jan 2025 16:58:42 +0100
Message-ID: <20250109155842.60798-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based kernel configuration guards.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
  - Split serie in single patches
  - Remove irrelevant 'Link:' from commit log
  - Link to v1: https://lore.kernel.org/r/20241229-update_pm_macro-v1-5-c7d4c4856336@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
index eabc4da9e1a9..de9b6dfef15b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c
@@ -313,7 +313,6 @@ static void sti_dwmac_remove(struct platform_device *pdev)
 	clk_disable_unprepare(dwmac->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sti_dwmac_suspend(struct device *dev)
 {
 	struct sti_dwmac *dwmac = get_stmmac_bsp_priv(dev);
@@ -333,10 +332,9 @@ static int sti_dwmac_resume(struct device *dev)
 
 	return stmmac_resume(dev);
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(sti_dwmac_pm_ops, sti_dwmac_suspend,
-					   sti_dwmac_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sti_dwmac_pm_ops, sti_dwmac_suspend,
+						  sti_dwmac_resume);
 
 static const struct sti_dwmac_of_data stih4xx_dwmac_data = {
 	.fix_retime_src = stih4xx_fix_retime_src,
@@ -353,7 +351,7 @@ static struct platform_driver sti_dwmac_driver = {
 	.remove = sti_dwmac_remove,
 	.driver = {
 		.name           = "sti-dwmac",
-		.pm		= &sti_dwmac_pm_ops,
+		.pm		= pm_sleep_ptr(&sti_dwmac_pm_ops),
 		.of_match_table = sti_dwmac_match,
 	},
 };
-- 
2.47.1


