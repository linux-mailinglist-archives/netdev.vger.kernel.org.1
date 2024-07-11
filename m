Return-Path: <netdev+bounces-110732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4E892DFE2
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE028196F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 06:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651382C67;
	Thu, 11 Jul 2024 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StOFiJaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04B8003F
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678226; cv=none; b=uWyz5uyIZSvqNB5a28ppTeA3AxJPqjzPKPdnwwonenTJQX1ZxzESy2CZ1RYGJ8GlM0OPjMrxo22Wr/YjCkHAFlBXRmjXfMLde/XUwWw63OOETlgUHa2P8dH++0tkgT6K03JFcP6C/yzbp6fGJHDBERxQHvDRlaw6INkqTTEe+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678226; c=relaxed/simple;
	bh=iQPzFMdbmzx9hLL9dlZMCzn7guYqJR/CzJLFRkaCF8g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eYpFfZTNGM7YcORREzFZ4BgUrRyvTzqq9fPEjh0wZtWToDZ9tIBG5Yxq/hySZZpLQjR5ZGg1YegM2OILZSd1ur9+/TKSJISHuhNYUyE4I3g2JhL2nAEUDp5huRQOh7bOlO9CwQnQvRTAg1mz0rXe7U5YrMbEnIH9a49Xy+xDQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StOFiJaW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70364e06dc6so254552a34.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 23:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720678224; x=1721283024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbgeEFeW1rvJhEB4MfgZ6aOvwNGbhGVs1MY4OIv8ZiI=;
        b=StOFiJaWmqUzb1vSyh16hYi/mlYNYWsxDxd+sCIFhlkZ2c4t0vGZaDwDGyPS85fFci
         ZxzGIX/gB5u/WmiFenbtfwexQhVOZ5gDOB5xn2Y3bGmSWlGlFaLoUi8dEru80jhHm/T5
         s3ybu3v/yFUpLtzXnrNkkoWO43a/6XEODZRur0L+W/Ty0iTK94FQu+hTdq/yG4aUqlEd
         BbMgeO8k8MfwZTAp+LHFozBloUnRY+ngWmE6SIoJ/+HblJGUZiceG8BB6rD7+cxbrtTX
         Fp/WnbD30LhYBx+iQhELP4hk1qdIPxdGZtmSDFVn9AhtV+BS+CCZpBT4sTBNMy2Bht+j
         l+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678224; x=1721283024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbgeEFeW1rvJhEB4MfgZ6aOvwNGbhGVs1MY4OIv8ZiI=;
        b=kez91cdMuDT1GbIm0MRhN4J5/ESdf9tGV2GKpcfNcMuzmIYDK50Fapqyou4sOUrRiy
         Hq35D0eCP/pRYM5DzxRnkB2xUpbvtNBFhbJPivpP++f/JMcS10Z6B3U4g5vq3NJXdyqx
         ya7yDw8WeLJKhoM7TlwroqyvnvdkyAbGMJ4nOdytZJYI/FEco5tDMpVTFop/ehEwWYjy
         dPrdWhoW6sfXjaBjZ13nxM8tQ77nqrn3HeqjT1VfJv3u8ZV4mwNlEj3SCde7nYhv/bYf
         BKwlGzCKO8qWGmFTSMPtkFf/bV43gR5j/PhKgQSPZipvTYqB9Qtd1aehvX2Es3VC2WtH
         4zmA==
X-Gm-Message-State: AOJu0YyZikYKaPhUkW5DjeD7BcajqzASpZSMpgIorFgoqOCdQIaNeszu
	WQ/GCwHUOXwma8TIVSx+lLW7hv/vX2/YEO9GplOB93+pL/aVAnx5NzonLbCRyts=
X-Google-Smtp-Source: AGHT+IHn7/BN32F1Wd/dNunrw0sPOK/6A9cLFCDhJ6SjGFWn05IcdDp6Pq4LFVhKiBy2QShFZ2/XQg==
X-Received: by 2002:a05:6830:5:b0:704:494e:fa1c with SMTP id 46e09a7af769-704494efaa6mr5108601a34.5.1720678223595;
        Wed, 10 Jul 2024 23:10:23 -0700 (PDT)
Received: from localhost ([2402:7500:477:cd01:80d2:d16c:b02e:82fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d66cb5359sm3165325a12.70.2024.07.10.23.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:10:23 -0700 (PDT)
From: wojackbb@gmail.com
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	jackbb_wu <wojackbb@gmail.com>
Subject: [PATCH] [net,v2] net: wwan: t7xx: add support for Dell DW5933e
Date: Thu, 11 Jul 2024 14:09:59 +0800
Message-Id: <20240711060959.61908-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jackbb_wu <wojackbb@gmail.com>

add support for Dell DW5933e (0x14c0, 0x4d75)

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e0b1e7a616ca..10a8c1080b10 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -852,6 +852,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id t7xx_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x4d75) },
+	{ PCI_DEVICE(0x14c0, 0x4d75) }, // Dell DW5933e
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, t7xx_pci_table);
-- 
2.34.1


