Return-Path: <netdev+bounces-160666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707AA1AC03
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77154188EB96
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC381CAA61;
	Thu, 23 Jan 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JleYC7Lm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94F16EC19;
	Thu, 23 Jan 2025 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668540; cv=none; b=kst6ntdsl2n32YkMVxIcHk9Bths0WZKN0/o7fPXLxiXdC7fuh/9TP0kO0VC804AnCCJcHo0VWpfArtnotdcf2jE3CYxL/ahDkRsGgqQZM61kdAxMPrKtSnM0FUILLjTTt7xYu6dPuOTbjESRDw2Px6SQJ+dVhLQpwYEqZT3bD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668540; c=relaxed/simple;
	bh=nwlDDY7tIK5w7BJS48cd7MrY+KLCh8Yr2T9dE5IHlbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qtFkLdCsrTrSkcOEN7ZfaIKxkb2A5IfzPriDit7LBAcjknmHsN2kauExdZq6d8dzcZMy5VjlA1leUCcEr8QY8lAPAfjIie//Jc8rn0tP3cb/FTYsyTLVNPn5xAxqfLpbJR/CVUQNBeLPU9zO7OGvxyz2gL8HJ36pn3LrslQerZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JleYC7Lm; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e6c5edb7so6207439f.0;
        Thu, 23 Jan 2025 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737668537; x=1738273337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9223l2BmfSBaY3dY5TNHCY9nfj71nO6Vl98UoEMd1dU=;
        b=JleYC7Lmlw6lVmdgnhBzftIfnR3TklHgDBVoc0aJzbIiiJ2owg3e+syJrk9641YTy/
         57lWzo4ylOiViU1ZgilQSgsC2dqq1x9rCA0skYKE0XSZTWWo/IssEB6Ki6jQapbEhYVA
         rvUUoVzw6E2j3TTrTPaPiUDADfWel20rtgS/lU0xlPEPxi/w1mrcAKpPpkUd5mUc233c
         +Dm3C4YtZUVb8yNgVN1cOrE0uMA0e7WhBwtVYsn1Lra9BeeQYlwqO4+M9QYqxZaaDhnC
         27/H1abLcUzrfGNfGmMuka6f4Cdda5/mEPO84e1LOmiZt5gWcCkUSi7xjkKn7rEkqEnp
         XVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737668537; x=1738273337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9223l2BmfSBaY3dY5TNHCY9nfj71nO6Vl98UoEMd1dU=;
        b=ezT11+K8s96KuMM0VAsMCWx394FUX7DuO43Ex8s6wX7jZUMsk2gRozj93Bo+zubm3I
         N9779nr1N/hZKkA9Iwj5WMfGQUiJ/8wwPN0L0VXzore5WQw4ck4Qa9OqChNoGF/37YXQ
         eLYGkQdMf8/sefeft128wmptj0RXb1zOflHcjbW0ePF0+ZFLocry5dS2u+79KJbKWSyb
         wP/BKexMTuhM+wVvQAshbG2ktoBmkH5d/FgDBnhJ3eO3pIS98aLgrGjQS3jHZvNK44IN
         XH//VEGD1o3yD6liBuHPljnRRsQI2vc6chrudgqryanRLecwpyABg/BRn2bEqHxyhT+R
         IF5w==
X-Forwarded-Encrypted: i=1; AJvYcCXNofUJJkznR5F9CvqPB5loJZ6F241wVDnAmYadHU8wTQ97m6DqrJZuaWkNFUnWSMyajIcel2xjwlPSmR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Urk3YSSUvCm54eQLQzqr3Y9IgHNod/w6yzMyv3GHgRo+8Rj8
	vDyBNEewzfrlUSV0bpM1oha7dQq+NhSGEX59XzvtV2LWx/BKsko=
X-Gm-Gg: ASbGncsMjljeD7wd0JZ2mJ8df39v56Nl9pgpd82+jVVVzGiod1osburXfgoKczPnQNO
	7HJq4yu06WNrWqO6b739U2c48ogOTBEdpZIqjfjFEy6nYAb9dr/nrJ+n4bLkuY/el1Idqw6M/Qc
	rcOdNE+pJMZ0vS3KOhn2dqvEGW1J/hMo+I667um1Z5QkrLh8SPp1Mij4hZAqc1E3pHIROvQRvP4
	TVJeCCFldOmYNeChPndoMvvWjkov474hvzpoefzxzLp3DtiKTkbzUXNM1+5KA84q4ZFJek36ZR9
	cw==
X-Google-Smtp-Source: AGHT+IGTZrnKhpHIgebu2kiG40ChCrDC7x6ukNoZS+cdX2nmmRX35rt4xbV3zElzr4R7k9EmgndVkA==
X-Received: by 2002:a05:6602:737:b0:84a:7a0d:c516 with SMTP id ca18e2360f4ac-852007519e0mr205293439f.4.1737668537261;
        Thu, 23 Jan 2025 13:42:17 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec1db85cb7sm138930173.119.2025.01.23.13.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 13:42:16 -0800 (PST)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	u.kleine-koenig@baylibre.com,
	paul@crapouillou.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zijie98@gmail.com,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH net v2] net: davicom: fix UAF in dm9000_drv_remove
Date: Thu, 23 Jan 2025 15:42:13 -0600
Message-Id: <20250123214213.623518-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This bug is detected by our static analysis tool.

dm is netdev private data and it cannot be
used after free_netdev() call. Using dm after free_netdev()
can cause UAF bug. Fix it by moving free_netdev() at the end of the
function.

This is similar to the issue fixed in commit
ad297cd2db89 ("net: qcom/emac: fix UAF in emac_remove").

Fixes: cf9e60aa69ae ("net: davicom: Fix regulator not turned off on driver removal")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/ethernet/davicom/dm9000.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 8735e333034c..b87eaf0c250c 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1777,10 +1777,11 @@ static void dm9000_drv_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 	dm9000_release_board(pdev, dm);
-	free_netdev(ndev);		/* free device structure */
 	if (dm->power_supply)
 		regulator_disable(dm->power_supply);
 
+	free_netdev(ndev);		/* free device structure */
+
 	dev_dbg(&pdev->dev, "released and freed device\n");
 }
 
-- 
2.34.1


