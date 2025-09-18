Return-Path: <netdev+bounces-224498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B581B85933
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF341888066
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6330E0FD;
	Thu, 18 Sep 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="hfuTM+QM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79319241664
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208888; cv=none; b=ScsPGS5BBYLQvys6aFk3BmDRs+p5GQ9X0IFuALXIBQfMkw5XHwF46bRbBlE2pGhPgQJsSiRtFUssjBMRTHgLx0BKeW7M4LMHKSPZMwadFdvpzQ/hYiakvB8EovHKUP8Ups6ZwAyapjN8TY0GiiMHnsYSN9zZGB4+5rnWVNTXl44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208888; c=relaxed/simple;
	bh=9SbAd6lP36gt16xC9yFkaKnibURkMF/x2f9dLSqkhFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKSDjzFpPXyFvFygblDuWw/E9Wk5xDdzK583w0FZ/86ddd7Q0plJPW+ZjsuENMCUut9DkthV3p7jCgp0JFdD3JdpZP9uC/V95p+4tEY4KPCLzMTJgEP6svr8mZ0Ip9O/BXKF4+YtlPXy7y0Smntrf7uI5ncwqHj6x9VHPg7WyBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=hfuTM+QM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so10669095e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1758208883; x=1758813683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylcWxUXdU8honSrVTIhGq3i2sQFAjhJAdOnLNwwvVdY=;
        b=hfuTM+QMQDyH4oJszdenDX4+nPsYPXpEmR+TAakDcvu2JFipCbx6f1TbIOkS+Cwhy2
         6m8pz9cmGsTnqd7GtHAHVVXYFUZnGUrKfkfIis3XqWyEovEDSLXy4maXbGgeYFt3Otuw
         zuo6fuSJPfAEq9bfKx5rNXgX85IVhtpRvH/EoqPi26HmoaXnQ5QA2Yd065NCQMyBuusz
         gaV+Is4nk4gh/Xp4fi7lTemL4Yi62N2+5wZZEtsUBZZ+1DxqmhbEV2Ieae+iZ0VkJ5p4
         OrKulcFhM+4ByzXQW8SmmL3N3B8jbIbKJYTIySZMyK4wOyKPIk4qSR75mvpUjHBadp9U
         9qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208883; x=1758813683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylcWxUXdU8honSrVTIhGq3i2sQFAjhJAdOnLNwwvVdY=;
        b=J4BIzT0psC1s3Q751Oxw5cKw6UfbmzWHZUcNiMSNCA2nyc1QoyulZ2DcSNIopLTjqP
         y+OWMuPrLu2J/hGfgCyDoHmTac/4yaqZhmycgBoWYWHW/K9xWjRrqwGmaA19ofhv72Ge
         xJUsKQ76OkBey/xxTcxhAbrhBSO6N+bwB4ov/3usu1u92wfZStvRgarTQI+0lgBhFIRO
         C58nXgWVv7T1/528M3h4+G4IAunUbaDs2zpNQZ8+O8x4ZwOKoWER0USGP+pqD5EczbXV
         ddOG2f8nxK8/bBvuR8+UOGlTub/DDt1t+tQScY085ynZlNU6GJYRS2aBzOb/o72akDAK
         oO8w==
X-Gm-Message-State: AOJu0YwQKYVlCabBaIl8tsOqP/zACIuGPap2/RZ21/MhxqwUBQXd6eaq
	8HO/ybNNk27+L10ZyjQ9dg0Gbh4lIrF3tF/qXl1NZGWQW4iyzvtWwk9+YJA4LqOHop3rgUblgFZ
	9bh5kNg==
X-Gm-Gg: ASbGncvC5vec5IRO0YIVrprBFgr0irp7y7jRmKFK4oEitHMSOFme6KFd8RneGz9S04l
	IzANKDPqGaCQ0WfMxtaGtFhwA2ysKfOK1Qpf6GdiSuYdr46UBk5DoQiRimfkRs6M9KMK2aaCfIP
	jD9fwHStCsLkPO3rOi+ZD62VF090U6ggV7VQq5e9ue9ymIpqPpT+Wva26CPmRiMxeYKjyvVZxeT
	TebBWsCfr3w2ZLQ0R/BFWunAWkOoLjnuiAN5xeWAC7ui+CkA7pKHPlCE0fNxf+Cq6l5ZNp2GeqI
	SL3WybjgrSouZ/eWtu3N9a7zcuPL/EiP6MtLT1RmULqJb+l49NHMqGGLNnq4ay5GZHR2hmHtoOW
	kxI/zIaYv8N5gCMsl4i4DvgPViQ==
X-Google-Smtp-Source: AGHT+IGqoRepZZO3KNR0rp6rbNYObkG/Jv6YMIvoI0FFMQUr9pHZ2vszICO4uPsiNvC64zcpDMoc7g==
X-Received: by 2002:a05:600c:b86:b0:455:f59e:fd9b with SMTP id 5b1f17b1804b1-46205eb1674mr67744485e9.24.1758208882588;
        Thu, 18 Sep 2025 08:21:22 -0700 (PDT)
Received: from ntb.lan ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-461391232e7sm84593175e9.6.2025.09.18.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:21:22 -0700 (PDT)
From: Petr Malat <oss@malat.biz>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	sbhatta@marvell.com,
	Petr Malat <oss@malat.biz>
Subject: [PATCH net v2] ethernet: rvu-af: Remove slash from the driver name
Date: Thu, 18 Sep 2025 17:21:07 +0200
Message-Id: <20250918152106.1798299-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250917113710.75b5f9db@hermes.local>
References: <20250917113710.75b5f9db@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having a slash in the driver name leads to EIO being returned while
reading /sys/module/rvu_af/drivers content.

Remove DRV_STRING as it's not used anywhere.

Fixes: 91c6945ea1f9 ("octeontx2-af: cn10k: Add RPM MAC support")
Signed-off-by: Petr Malat <oss@malat.biz>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 0c46ba8a5adc..69324ae09397 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -21,8 +21,7 @@
 #include "rvu.h"
 #include "lmac_common.h"
 
-#define DRV_NAME	"Marvell-CGX/RPM"
-#define DRV_STRING      "Marvell CGX/RPM Driver"
+#define DRV_NAME	"Marvell-CGX-RPM"
 
 #define CGX_RX_STAT_GLOBAL_INDEX	9
 
-- 
2.39.5


