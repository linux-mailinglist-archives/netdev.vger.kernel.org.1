Return-Path: <netdev+bounces-125683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A1996E3CF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015EDB256B8
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3253B1AED21;
	Thu,  5 Sep 2024 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LorUjlkg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52441A76B0;
	Thu,  5 Sep 2024 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567319; cv=none; b=D4FnGUkpFkxCChNslkU7aVENBfgYyMuguC0nax2XHFpLweSAInqLiGH9iDauJ2b1J95rW2XkwsDeFkSb0krCyuc+dFWQ5Fra4eJGjJlXcnH/ISVKrCkRiH1wUp2pdIbpnlLwRnmdDDFnLuZlA+RluM3+Y7+NyUVdTm6LLEcPqGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567319; c=relaxed/simple;
	bh=GkYv+8kiWtz4hwfxKF8OeLtk5p6hspiOWUildlsVxtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLijRvC8XYKeJeIFLXa9ZHgr6PJrtLosSAnQIaDO+RbnWL/oXvVy0zZqfUy96x0x71CS4+2qya9aQxUvX/M+7fA3B7nV+njI+/QqGncn8/edZx+GrqqQOXlHYaz+UnvfJjYNSj7gu5R8AZLocSvEgN+tHc117zhzLkVpLuNeMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LorUjlkg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2055a3f80a4so10282045ad.2;
        Thu, 05 Sep 2024 13:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567317; x=1726172117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPUULAONt1B1RbSQ7p1WxcMQIgouuFPwD4mGeO5shkE=;
        b=LorUjlkgVGFM4gu/6aCC2MuUX4arggVySPpR56KTKaGd2mzTUJy8mAjx0YgAma9s3Q
         rwnDPT8DUes3PrYXknv9sMbBbLpH9ug+5YswTuGFrhQF+lqggYV/fGqLwr0aaUuGblI2
         FW0L8BItZanEHkgfADDT7i90Dl1Vr18rLgTHR3Rre5GUzNDBJz7dnCW9954iYvXAFon1
         7eNG7jyWu9xIEoLq6AA6TNL8Q5rH1l480qyTPOaGw++uBirvJBGBb9gE+d5uU/dXIeZZ
         1O0Yh5/X6l6VFLLUOrbBew1X5NiXaY+4ypeDbBTaV+zNAaN9RVvpyz/PeUJpRsXaXr5c
         XCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567317; x=1726172117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPUULAONt1B1RbSQ7p1WxcMQIgouuFPwD4mGeO5shkE=;
        b=PvxNyWov0oLHhZOTRK0+GywgpKFU6LtvuDpl02NvUxFwwLdCVN9jjvEvYa4ph5/NeU
         40l1f3ugFrUUCn6p19dCoieKldRCSaZNFW71Oonmpa7NJkHVTx8VUz8IjbdDkoJpnLMV
         sDPm938YXUb5c5w/IO8TesjMC4ZM8vPqLT9zps3oeJDwHSP70jahVN7hXXQ+mr+16HxD
         PwhJJaYJoz5Pqao9W88Vg6AHo3WjWDH68sM0069LkhiXfQ9W3D+Caao+zOK0oeLkEq1t
         sInPLWnqhKKvAuueb9I3LUi/Zy2JDugtgQPOyxWmRBzXhc9tJgVJ28/YwCv4Ro0QQeBi
         X8fw==
X-Forwarded-Encrypted: i=1; AJvYcCV+y4x/Zg15hB5sgA1fe2RW06ZlWqrUUSWm7PJT9mAcLIw8YctCv0JxiJcKmyf/Jmiu/6K6bxQbOsiosxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvJlUi0acj9ZVbbVHiBt6D85DLChjjP6VTXn0ZilKfrY4N5F3
	TwzkYrF4lHNJEQsE4XhsdAi2V1PTDSfLMkPMff0+WH2DuflkRq9QS27xRub4
X-Google-Smtp-Source: AGHT+IEc5FimREygWoBU81L3wvd9dFLgOOYGMDyFc67p1PK+yN7KgP9RKw1M2Thdxcwe9Ihgv+eTfQ==
X-Received: by 2002:a17:903:1c5:b0:205:8b9e:964b with SMTP id d9443c01a7336-206f0612c09mr2265135ad.39.1725567317022;
        Thu, 05 Sep 2024 13:15:17 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv3 net-next 5/9] net: ibm: emac: use devm for register_netdev
Date: Thu,  5 Sep 2024 13:15:02 -0700
Message-ID: <20240905201506.12679-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleans it up automatically. No need to handle manually.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 66e8be73e09b..e2abda947a51 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3179,7 +3179,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	netif_carrier_off(ndev);
 
-	err = register_netdev(ndev);
+	err = devm_register_netdev(&ofdev->dev, ndev);
 	if (err) {
 		printk(KERN_ERR "%pOF: failed to register net device (%d)!\n",
 		       np, err);
@@ -3245,8 +3245,6 @@ static void emac_remove(struct platform_device *ofdev)
 
 	DBG(dev, "remove" NL);
 
-	unregister_netdev(dev->ndev);
-
 	cancel_work_sync(&dev->reset_work);
 
 	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
-- 
2.46.0


