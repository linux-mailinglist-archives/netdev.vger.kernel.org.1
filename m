Return-Path: <netdev+bounces-131049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285BD98C71B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E2B1F23A82
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3898B1CF5DF;
	Tue,  1 Oct 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdbwdcBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B888D1CF2A2;
	Tue,  1 Oct 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816336; cv=none; b=DHTOsKlGdOIeG+cGnHKVDsb9tQIiDZZunqOSceD1ZGSqeOBpUg3N3DwqdNCVfRBZ3ueAW32WMEGWFLSdjTWFI+IDtz/07Wk2/G8nIy5sD5CudPth08fbJVCfAqujcHmK4J6HKYd+EA5qtjX9p8SIgDgmAObFfdDeF8oUwQeH4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816336; c=relaxed/simple;
	bh=k+hWWt4RJCuaq34feyjRdwmdzmEmgz88H7zHH0eqdeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4lBb3vH17mub9aFnp+lYby8q+EGI8lEk/jvzuARxXSb/PUXnoVo0ZAIxHCVugf6NzHxPrnNal2HsZHMdWqZ5j0FcZFFQQbAr6+IeHy4NbSFCYsH4wzJlxKIdGdDiCqwRNb1rVAAb1ah5lIXeg34UChkl7FqMdLHNnPDmst6F9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdbwdcBo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71b0722f221so4633289b3a.3;
        Tue, 01 Oct 2024 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816334; x=1728421134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=WdbwdcBoCdVKEH0AyhKLz3yLBaMYQ/wNrIwwtmnLwDtCrfy/0HWt2vz8jrbo8s8HXp
         aw01L7dDWdxF+HQ/G4/CY3/W55mb9/qO0Ky6BwVe+Ek7g0ayKPcObtm8C4FdWD/Zc+VH
         tDD2pi1Pz1pJJGTWgG+noOpP4X3EI5xttxOx9+ZJmWXr9vRweBUURTORXOsZPxoDpWkY
         79pqW8w//B51POMP1OBac4Z/5uTcLpHrwo9ham3+Ykzv2wHKaeKYDFuc7M4o06kcE80Q
         8GQde+s0IadKyDj6KEHxFZwHAiwODJpvivRAmwo4nxiPFuatTczt9/8DQGG9FNsSoGP3
         ppeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816334; x=1728421134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFaFgc9POesph+LsrZhmZjoY7P5q5F3QfbVs+MT0fXs=;
        b=YajdRA2WlqdNJkoxAFrZqzf3kEPueGcglhKnfgQNreHBivMnCRxsOZ+Dnd86C+pjLY
         XdE+jtveseMvIVFlE+JwpPnFnyuaB3SipSgByvKG8rSytNalLuML4yYC7Pf22XN8g+mm
         SuE/WGGb/Rsz+pWPXwyhxuVSTM27ZUDacaOtwYlLctIkSIJHT75eRDOxX0UJ0GlGn5qk
         u1asKAuODIvU/HJD+T7T42K8aeL5d+aq+5K7bYVYS+Yj4Y0X/vGZR1mfQtjfiShzTgTJ
         6lY9QRg3ZizxIkEKQOJPmi0rJuNDD5Ew7jngKhl3OEmgCeS8quLJlP00qIeCeH8QCxuP
         kTBg==
X-Forwarded-Encrypted: i=1; AJvYcCVV/HSDlYH8thRmPuIwRcIiSHQH2viAU8y9cU08G5TCmxEIta9IqLKIR/gUx6KNidESwm3h6oGtBaGAf2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyocwaGaHnsvlDvNIt7LtA+0QAg1IG7grNBD3Jl6oOr0qHl+ew+
	va9rb0hTBjDWg5v8gYb5EWelpKlM3K5j7SpCpdhhMW6GZFdQ+Nd9kdpRMbV8
X-Google-Smtp-Source: AGHT+IGE5uk8JS4v9klDh6dqy3EEdN/CIxhx8jOqp+96IFnDKyRW0HzOE5M2uFwmadrHfky3BvFG3A==
X-Received: by 2002:a05:6a00:1490:b0:714:1e28:da95 with SMTP id d2e1a72fcca58-71dc5c7847emr1528000b3a.7.1727816333774;
        Tue, 01 Oct 2024 13:58:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv2 net-next 05/18] net: ibm: emac: use platform_get_irq
Date: Tue,  1 Oct 2024 13:58:31 -0700
Message-ID: <20241001205844.306821-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need for irq_of_parse_and_map since we have platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 205ba7aa02d4..a55e84eb1d4d 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3031,15 +3031,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory */
-	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	if (!dev->emac_irq) {
-		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
-		err = -ENODEV;
-		goto err_gone;
-	}
-
 	/* Setup error IRQ handler */
+	dev->emac_irq = platform_get_irq(ofdev, 0);
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
 			       dev);
 	if (err) {
-- 
2.46.2


