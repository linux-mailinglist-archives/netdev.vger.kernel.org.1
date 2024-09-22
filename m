Return-Path: <netdev+bounces-129199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A3097E2E1
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 20:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976212812E7
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 18:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41F92C1AC;
	Sun, 22 Sep 2024 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfltYumk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E826AD0;
	Sun, 22 Sep 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727029068; cv=none; b=ILR0gysqhtyaot2OVXCIi30AIc1wqhBa/5IRcM2keUZ1Hhk873Xov01SEyZzAVvdJ362hDeKPwtakCWR8x8rajLu2to3kb/96WHOEj3SDkgSBka5dvC7UCl+vdNcqdDim5fSTZO6CCCrHVrvE7tZZKcafusqJMyCDyNa5AyhVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727029068; c=relaxed/simple;
	bh=rZ6b3wmRBPEsCGtllsYERcy1LvK8nRW1J6EAqGDXdG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lcfVlTFxjWnpHIwM5skkCInXatD11UhIQ8eCgH8jtTWk+XHlk7TJsiANUyfYAhfDe9cbbljmTrO7ReEszKseuvnu0UCOc3MWX37lZDx8dctRSzJe1v8Y6+VuSbcqWiWSM3ABTzeEMIua5JR2h5mB+rcKKtHuqf+hm4G3cFpuvhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfltYumk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so2306246a12.3;
        Sun, 22 Sep 2024 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727029066; x=1727633866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/c69hqY01XgTVDN3EgAstJmT/RyGJ73fcAPMsJ4AMU=;
        b=YfltYumkRwjzPwqWfKBkyuJEtrxtT1zx55YJbSIbR0r8ccaAIxGqdwYhXlbUkt6MPO
         8RMhAMO1r0Ay0MLSUi9yG/gMmLZnB+WYctEqxO6zjLVPwufrPJ1V4CReNoRBFg7fgrjH
         VQBWdDiYf3so8varp49zlTgKIFM6jhl3oR7Joc4XqWm9Ivdt4gmZm1OdkA+ZtkilDv2S
         oBvNJbdXTqHnCoPBuFdtnXgeZPiwvB6ZKUKyGhePFg5MVBLNqATo/QQZcX91HhLYDE8Y
         +X5u9BcFaXJ+zWKO/av6Y2U9scvPt3lpfEDj8ywP2k+BjkNJ9dw+t38F5V0zYOtGkw+x
         ai0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727029066; x=1727633866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/c69hqY01XgTVDN3EgAstJmT/RyGJ73fcAPMsJ4AMU=;
        b=cONZx/WmGd4DUXq0v+PHPar/OHTVNfMG/6pyPDMBipXaSW3V0/CvndF3c1mCCASKmY
         0wAbUmfkbK75766EOBMnc3ExbyY3k8mC4t88eD+OMjKYgo7olaYbIen1Ji0xFjC77IBb
         vPXEFjciggmqddxlyEbD0QpDa+BJbHWomZvIQME6J0GX5L+gOP4bGE2dAGM0x4dkf3RK
         cOVk5jwzcvQnJQsZ49RMksf2g3O+9e2F6ysSASopGO9uI3245qGvq1UPoBj4tRciQRrC
         vOxXL2B0ACrflktoGmZ8bEyoWTOySlkiDHsWtzs3VX6BG6+D8sO/b0tZn0rToogvhI7R
         It9w==
X-Forwarded-Encrypted: i=1; AJvYcCWuP2ToWjdI7mi70eDPpHcivLkt/QVlZEnIcQvac7TZLblEx8zfA25CQWnwY8+v1WBYxK46a9UC@vger.kernel.org, AJvYcCXh+feqgSm9c6qeGRjRV7w9W4dpRtXEXwox21XMvMQdYxodli229RFEdfNAAIW9cqP6rlCW31V0ejMzH08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPvwLHr5mwyRE4wnWRs7odqJQD5UPxamfV2nm/rgDQnpGzqv3u
	z0GmApXdHJjTtBoRszlOwcnOO9mNHP+51GA+4GpYmmmOTgGGi9kJ
X-Google-Smtp-Source: AGHT+IHCsG4FOhEk/055Ejqr94ExyoroChpIyrCql1L7Uuxy9TZE64gkX7RiVbEHve7Wg6Mx+1NJzQ==
X-Received: by 2002:a17:90a:3f82:b0:2d3:c4d3:de19 with SMTP id 98e67ed59e1d1-2dd80acf02dmr10893464a91.0.1727029066525;
        Sun, 22 Sep 2024 11:17:46 -0700 (PDT)
Received: from ubuntu.worldlink.com.np ([27.34.65.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6eec7b36sm7868359a91.30.2024.09.22.11.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 11:17:45 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: net/ethernet/broadcom: Add error pointer check in bcmsysport.c
Date: Sun, 22 Sep 2024 18:17:37 +0000
Message-ID: <20240922181739.50056-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reported following:
'''
drivers/net/ethernet/broadcom/bcmsysport.c:2343 bcm_sysport_map_queues() error: 'dp' dereferencing possible ERR_PTR()
drivers/net/ethernet/broadcom/bcmsysport.c:2395 bcm_sysport_unmap_queues() error: 'dp' dereferencing possible ERR_PTR()
'''

Adding error pointer check before dereferencing 'dp'.

Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..b849c11e2bb6 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2337,6 +2337,9 @@ static int bcm_sysport_map_queues(struct net_device *dev,
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
 
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);
+
 	/* We can't be setting up queue inspection for non directly attached
 	 * switches
 	 */
@@ -2392,6 +2395,9 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
 	unsigned int num_tx_queues;
 	unsigned int q, qp, port;
 
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);
+
 	port = dp->index;
 
 	num_tx_queues = slave_dev->real_num_tx_queues;
-- 
2.43.0


