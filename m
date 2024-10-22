Return-Path: <netdev+bounces-137681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814309A94E3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 02:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285DE1F21B9B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1913A416;
	Tue, 22 Oct 2024 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3aWPkkd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7031132114;
	Tue, 22 Oct 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556573; cv=none; b=G5fL9Qwg/cqnWspgqWb5hTMfCNW6AXvkTGtKr5PkRP+afddcJxuIapJ23Kar2LEcnWnqWJV69sWwCoHI9xoZTVQd0SFwnqAxrbYm1Rboq92lxuKJFVJYWr5HnuJuNEFEx+Ikvw/qawrllHehz6J6j+v346LQB+McPzdCOT9CdzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556573; c=relaxed/simple;
	bh=Ijr5qcYCwL0MP8IwvmauY2dTqu7ak11nbr/ucp6yWLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfE2vFqv56ZSLhxl5/1tpY2oUzg3Zlj6zdniaefX+nx3ajC202Aq1eJTYxFztGJD9e8FwvKMHDH6reWmiKd3jnyLtnYMUhJIkh00NsDR7iAaol05Kbxd1QelqcO5/590jZlU/yXCk4fNaFP7fpy7/mQQ/6fDMtJAUTy7+Uzxy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3aWPkkd; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso3377936a12.0;
        Mon, 21 Oct 2024 17:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729556571; x=1730161371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iOvJHY7noQWPo50zyN8nZPU/GMtWV7jlXjn0h+1KFs=;
        b=K3aWPkkdsv8y+2k/OcnZhrc83pJd0T/X5hGMgIrm8FBxIKt7PNUDgzia091Fj+2i5z
         9hw0V1miRVCf0aQ0K6y/YGRdAprpDBOG/g1qLHREGxCmzgMtPnmBsAFHWekgHAQ46jB/
         vjONXY2c1357eh4G0J2BTO6suFOl4XG82h5wWimG2vuFozVbfHZYyToYR2H8T3ZFa1Ju
         9hPxjsmO6ztX/mLsubZZwks0V0lgfvfkvKQ/f8s3vtHkJK3OeD9nwNHaELnDfvmpNUui
         /2aWRcHS+WwQg9G+KSal4HPS9vzuu10uIewJpKv7FUgmSl2uHb4r1QmphZ8o2Om0abLB
         cWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556571; x=1730161371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iOvJHY7noQWPo50zyN8nZPU/GMtWV7jlXjn0h+1KFs=;
        b=qcZbCQrmFkiBXTDxhHj0uz330mjb1VniMF3XcJQHJ9DQbFYg3aH9/S7kLaO+RSJ9Fn
         LmtwnxJJcos9DeoIUgpCC6cpamV8N+V1f/i6FBcR2xMq5zSbTKp7RhkBE46+yd7F/KFv
         ozKBGDJbRuTOxPu8TcFtT1ECOVc4+cG8V/rxOCd4y71qpxXs62mVNzQgzzHcm7Cwn01R
         H2Npa6z8ju451LhyTp3vfoVgjHuBPZTOzdtq3hBaSFX+BK1pdWv1S56ORYWrSgs5BrP+
         ulwZx5AJ/Lo5zRFK8/5uqQFsYUOtGba+nDenT00AXYFvbXOk2H1Q6JyNuMRs43IHKl3E
         IiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoQj9qX0Fa5WZFtEJ6McyAiqtYx5tPmjuupG7WKNQd++/6BqHR5KoaEPIuQgBT4yapCHYlg72QduHy9/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz66ZLVEEOuis9MYXM8PKCADZCw24MzRMO76gnlpnB3xCURKa+R
	gu/DIHdt2JsqxdJQQsPirphQx6SmJiBYYYqmY6WalPGnWpSCrRRKA8tbIist
X-Google-Smtp-Source: AGHT+IE2rCRwOxopf2j76K1O6AnrRG+wVa6XiRbvonFZCPdGPIs9bL50VQeZhEfT3GwR5nm/BeJIoQ==
X-Received: by 2002:a05:6a20:cc0a:b0:1d8:f97e:b402 with SMTP id adf61e73a8af0-1d96c3cb217mr1962195637.13.1729556570862;
        Mon, 21 Oct 2024 17:22:50 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3515828b3a.46.2024.10.21.17.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 17:22:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv8 net-next 2/5] net: ibm: emac: use devm_platform_ioremap_resource
Date: Mon, 21 Oct 2024 17:22:42 -0700
Message-ID: <20241022002245.843242-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022002245.843242-1-rosenp@gmail.com>
References: <20241022002245.843242-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to have a struct resource. Gets rid of the TODO.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/ibm/emac/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 0edcb435e62f..f387c4635cc6 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3050,12 +3050,10 @@ static int emac_probe(struct platform_device *ofdev)
 
 	ndev->irq = dev->emac_irq;
 
-	/* Map EMAC regs */
-	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
-	if (!dev->emacp) {
+	dev->emacp = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->emacp)) {
 		dev_err(&ofdev->dev, "can't map device registers");
-		err = -ENOMEM;
+		err = PTR_ERR(dev->emacp);
 		goto err_gone;
 	}
 
-- 
2.47.0


