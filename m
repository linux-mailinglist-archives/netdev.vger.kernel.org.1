Return-Path: <netdev+bounces-124292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B65968D30
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979B21C21CB2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3953021C19E;
	Mon,  2 Sep 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfV00p4r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100D21C176;
	Mon,  2 Sep 2024 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300942; cv=none; b=M50Os30KerXfXunEbVAQdANt8drBJGT89Q/UpIpXDcIqN2F69z73Qi1smzGO4uacxxGCJwKAngPYigURTM+fAR3bgj9lZ3LjgasgQZo8IubPXCS+sXZvQ74HlEega7/AeyYmqImINeiLUJ6ZfWhxJYWIRTmEQdPK3MaTHmkXPCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300942; c=relaxed/simple;
	bh=ojSmE4ICakMQsFJ/VK/KFMShrLGJutH8NtGfBIPXUhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6WiaRTDhGOseota8KxoW5sXEpyphOufEsswZytH8AI5G3B6bqhXyhtellYph2/LbRMcPcNC0Tpi0JWhAo+4Eg3IZE5kCZyqqDiov7EXCoTvNYbFgm0zFv1SRSWeoIhHlEbx1m/zOVulM2CLt3SMC5ve6ZfGTakbbGf3AnGBwIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfV00p4r; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7142a93ea9cso3534162b3a.3;
        Mon, 02 Sep 2024 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725300940; x=1725905740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdx1W0I5G+0kXQYcOyiGjfzO3ruj8/A6WXXhcyeobog=;
        b=jfV00p4rv7cr/Qcbty65BcgMGMXVgMB+0h1w9jAvGdk0sljrUuZtYJ94FWXm4Fp08t
         7CM75q32XY5J7G0aZ0tkaK6+sykd3SrAESaJBTdR0EvCGmg/S6LO86i60I0P89Co2TfF
         CaEANrkFnK2zKgl7cb0TkNvNNNFxzQcVu+LKvazci1aYOLvYOXM47A+9MDU/tf7sCbYW
         SxN71J7DjkSUsM7UnZmiHnaLuYiyc2/ra/avU1TOfN2b9knKoolRt98tYa2RRHmpHhDP
         +y0leEwbLC8eCPcD9O5g9iMY8hHoKRPypsF/3rEtU4TLaMxiEkztLkDSGBB7uCR4mjzp
         brwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300940; x=1725905740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdx1W0I5G+0kXQYcOyiGjfzO3ruj8/A6WXXhcyeobog=;
        b=e29osjBjSquWdFtSACMBkPrSsym92e2iT1eghV+apB8B/w+NpSIf+Rz81dyh4OabyP
         6wx10s6Hky8NC40y3xsgVnNVBD8ydVTpvnd5D8HGMk5SIXgQBx29Uk06DRl20lKSrHhl
         mSyVpswatFfxOHEBXtBeZ3732cr6dX8JTdGy2A8ucQzVS5sQDoluDzHWP93Wqhq1VRVI
         62FMKsIWVJo2KrHOf7Rzqk4ZFL2b5VUqRwKi1iD5SKRuYqzmO8k9VuB5RnF3Nuy/Pt/r
         zdbXArrrkT8Fu/+bRhZtzJentU87JUPVpc5M1g5VW6EWg+sf+sogo/l4lLcEUhoUWMuX
         9OvA==
X-Forwarded-Encrypted: i=1; AJvYcCWETplAHr4UZgb7xL13GnwCpIEQnq59Uv7m80Qltp2QBC03NjvRIv2f2FFvw32/4tkPzWfY7Qv/QKHXxQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCUoJn2SDMzEkZmDP1S0m4915CECIF/BVaaugVxSRRYzORc6S
	Z/zT+hWhVGrS4pgcoTWbTbJhxzTmuQCaImF2TPf1FH/fLPXXiSYPwNyO+XuI
X-Google-Smtp-Source: AGHT+IH5I9LECsloxp3pXs0FjKTSbm9dFP/LdgZoURsFmmogv7iJz/Gj748W3iaaaCbrcwZflA0MTw==
X-Received: by 2002:a05:6a00:10cc:b0:70d:2725:ebe4 with SMTP id d2e1a72fcca58-717457cc68amr6340529b3a.13.1725300939919;
        Mon, 02 Sep 2024 11:15:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7109167b3a.154.2024.09.02.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:15:39 -0700 (PDT)
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
Subject: [PATCH 5/6] net: ibm: emac: use devm for register_netdev
Date: Mon,  2 Sep 2024 11:15:14 -0700
Message-ID: <20240902181530.6852-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902181530.6852-1-rosenp@gmail.com>
References: <20240902181530.6852-1-rosenp@gmail.com>
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
index af26a30bb5de..fa871d7f93a9 100644
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


