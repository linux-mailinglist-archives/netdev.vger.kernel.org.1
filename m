Return-Path: <netdev+bounces-114140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447609412B6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0081F2479F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83619EEAA;
	Tue, 30 Jul 2024 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go/1Zx3T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB3442C;
	Tue, 30 Jul 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344352; cv=none; b=BqjgC8qk9d0bGhpRuos5a5XbEyb3+Z9bdAZOVc9BoBea7Nl5g73QQlt5z4poLkDxB4T9QtrzHxFT1pWmKDV3KavjBI24EVpwI2dVXQFlooeDVy4lf2tX8PW5BAUglFw/tyKpa3nPZcMJ3PFnf2ay8naXgamxB4gGr9JRcyxgzBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344352; c=relaxed/simple;
	bh=eqXcPBYhZBDafuHBni2TZwrobW4eaMMgljUweKQ30xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IP3wTEs3HKIfqom1o/I4Iiv22B36HvHv15RriwAkETffEL/kzRJ0jc6glpobwYa81KHRGlvTNTVuMhx8kWIWcK4x8jGfrM+bWyoytGUGCoczb0OLyW3HP30cVA2+o8PFpJCSyPvYEvxDO1z/omkQRD4q2c2pQ0fdK22ykP4VP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go/1Zx3T; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f01993090so7118015e87.2;
        Tue, 30 Jul 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344348; x=1722949148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nqx6Y1Pu/keDudNv6N0ITjqRriMkyri+n9sVB+9k5k=;
        b=go/1Zx3TImHB3COHB74AuQ/Wjy55d1irY8jsYttfa5luugl9vMipq+Zvj02RDaD+VD
         l+/vT839F+TX2NLiAZ1XS4mXMs4mgsS6p1j6/bfFtguqJ7AfT2vqpKuJmeNHwVlpERTM
         AEa73jJPFQNdBlQpHmSkgySgbgdJ8+qPpnH3W7QJlIFeHrY7PoO2oUQyoXjKtg6LNQs8
         gCE2BR+nxhPNXsI/DNSu3lmpdrIDlLM+AIRY5ikPPyxiJIG5ISs+N5kCOFANrz9YRWMJ
         nhVPDwD8LmelMCFisPoyjvtu5/a0PJ8WeZlJyED/VqS33hq5+DEUtRgZu+MO40Doj7Zb
         D4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344348; x=1722949148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nqx6Y1Pu/keDudNv6N0ITjqRriMkyri+n9sVB+9k5k=;
        b=ZQSnQkSIbBbLR3posMa4j/wfZGX/LeAu99ppvzxPVeHnIgkEwmn8AWrukmlwcCC95f
         l6b0f2uSjIsPEs0ffFHPEGTWDUlagA+kOfdkaMyVEX9PxKpZf53Ou4QvL7kq9C8s4WsF
         ibJHYfkIM7gnRSW7GGzWhu9FNhlnIA2ahG7PtIu/2nm0Zpva4hFBXOzLMDm83Ab+aEqW
         KPSrTSXD6QFXUa4L0lT0YSiPbD26oj3H38Ch1wl0oCzeMsietf5szJtdYo7gxrVfxJsN
         biQgPQrbuj+F63JflhfDRK2K0Yg3Hu/Jp5AH0HGsEPAQTAM0uotE9qbe2fhHBamPBu/O
         Cvpg==
X-Forwarded-Encrypted: i=1; AJvYcCWEg5BKDkXL7D8Vw5Fbz4TL5mj8TDYw0vrLzglYnH2LmAMGbnJtsfFTJo8bSR2eskdnWaPlah1BZcrV5ZDxAWO4RnNjuvfSc4FvZOQW
X-Gm-Message-State: AOJu0YyOWc/BiZrXun2IPxcu42ddPkFX7rydGyKil3S+G/UzZIOZDQjA
	+kbLUlPEk1MuuZKjLLX1lPhum41Xq694/vjN29ku2T7UP4r1CVHrZZkaCw==
X-Google-Smtp-Source: AGHT+IGZ+UjHZXid+MQwVVXxMKLUsxgcRy2pLmFUwyU4tteUjKrlEcbQ316/hXV2XIB3k+h2jjb4+w==
X-Received: by 2002:a05:6512:3e15:b0:52c:e28f:4da6 with SMTP id 2adb3069b0e04-5309b2c54fbmr8564267e87.51.1722344348005;
        Tue, 30 Jul 2024 05:59:08 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad418f1sm636286166b.135.2024.07.30.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:59:07 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net/chelsio/libcxgb: Add __percpu annotations to libcxgb_ppm.c
Date: Tue, 30 Jul 2024 14:58:19 +0200
Message-ID: <20240730125856.7321-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling libcxgb_ppm.c results in several sparse warnings:

libcxgb_ppm.c:368:15: warning: incorrect type in assignment (different address spaces)
libcxgb_ppm.c:368:15:    expected struct cxgbi_ppm_pool *pools
libcxgb_ppm.c:368:15:    got void [noderef] __percpu *_res
libcxgb_ppm.c:374:48: warning: incorrect type in initializer (different address spaces)
libcxgb_ppm.c:374:48:    expected void const [noderef] __percpu *__vpp_verify
libcxgb_ppm.c:374:48:    got struct cxgbi_ppm_pool *
libcxgb_ppm.c:484:19: warning: incorrect type in assignment (different address spaces)
libcxgb_ppm.c:484:19:    expected struct cxgbi_ppm_pool [noderef] __percpu *pool
libcxgb_ppm.c:484:19:    got struct cxgbi_ppm_pool *[assigned] pool
libcxgb_ppm.c:511:21: warning: incorrect type in argument 1 (different address spaces)
libcxgb_ppm.c:511:21:    expected void [noderef] __percpu *__pdata
libcxgb_ppm.c:511:21:    got struct cxgbi_ppm_pool *[assigned] pool

Add __percpu annotation to *pools and *pool percpu pointers and to
ppm_alloc_cpu_pool() function that returns percpu pointer to fix
these warnings.

Compile tested only, but there is no difference in the resulting object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 854d87e1125c..01d776113500 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -342,10 +342,10 @@ int cxgbi_ppm_release(struct cxgbi_ppm *ppm)
 }
 EXPORT_SYMBOL(cxgbi_ppm_release);
 
-static struct cxgbi_ppm_pool *ppm_alloc_cpu_pool(unsigned int *total,
-						 unsigned int *pcpu_ppmax)
+static struct cxgbi_ppm_pool __percpu *ppm_alloc_cpu_pool(unsigned int *total,
+							  unsigned int *pcpu_ppmax)
 {
-	struct cxgbi_ppm_pool *pools;
+	struct cxgbi_ppm_pool __percpu *pools;
 	unsigned int ppmax = (*total) / num_possible_cpus();
 	unsigned int max = (PCPU_MIN_UNIT_SIZE - sizeof(*pools)) << 3;
 	unsigned int bmap;
@@ -392,7 +392,7 @@ int cxgbi_ppm_init(void **ppm_pp, struct net_device *ndev,
 		   unsigned int iscsi_edram_size)
 {
 	struct cxgbi_ppm *ppm = (struct cxgbi_ppm *)(*ppm_pp);
-	struct cxgbi_ppm_pool *pool = NULL;
+	struct cxgbi_ppm_pool __percpu *pool = NULL;
 	unsigned int pool_index_max = 0;
 	unsigned int ppmax_pool = 0;
 	unsigned int ppod_bmap_size;
-- 
2.45.2


