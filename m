Return-Path: <netdev+bounces-132434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD830991BC5
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 03:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD834B21ACE
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 01:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC015383A;
	Sun,  6 Oct 2024 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etxYSCv+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BA14A0A4;
	Sun,  6 Oct 2024 01:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728178783; cv=none; b=gKy5IRYxFimwkDSZs7N0giMogPQ1U88N6j2wX/PtCtObiZz/RsQLQKpdMlM6C+C+2QDRux8a72D5V86lLazyTa9JS0cCEct2aEBL6mRr/WiLPFvFq7B8W6icmDGeMoW+ukz7dLJ/i6fLPQbyiFc1xKtioD6dmT/LQMIi2ilOvT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728178783; c=relaxed/simple;
	bh=pYSc6OiU9q1iKa1xX0rwZ0lR9e6LiTxKsuskqYnE4HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqrnVUV1w8NfBAyxGgNhr6cHJJn0Nc4+NJcKY8Gh/dNHMSjtDGnIVzVGHxsPtBZvcEGKpSvkk9CEsjtpYTQ46ogVQtRUeHvoS1lUTUhYvjd8k18SdbPHXdosWzPyErHm4eKUQ0LrVKDAf9prVJvHVDdgkuL7sSdc8yd18/cXMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etxYSCv+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e1bfa9ddb3so2511104a91.0;
        Sat, 05 Oct 2024 18:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728178781; x=1728783581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kNE28Sv8c9PciX0+hCX7nPdBUet0b7HWalzU8LzDp1c=;
        b=etxYSCv+D3g4/EjcV0kszYeiMz4S1brRgMdrlSqDJETnuqanJcBcJPgqzE5n18d/P0
         mZQrVmNVrBV7tR3+n9fziM0CL8WDRSf8su7aBrPDFPb66WmPwOCGtvRK8LsIyeMneG1y
         MmSxI5w13YRZZl3Nc/zTixsei6bP+tPy9nD07X6qtVXnDfTLnGEOrQ4TkXXUJkLsj6UW
         chQ+AmoJ7TLTwO5JEVe5qi5jIxqS2DUGBy0WtbZsr0JSQoRP1p8BLY+ttARL7W5fYKom
         jtWXo9ttRwil8RobkzsKaLk8X7wBzxZjU5AnAnoIaOqupD288XEBbzu1Kk43I+ByYPKr
         fp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728178781; x=1728783581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNE28Sv8c9PciX0+hCX7nPdBUet0b7HWalzU8LzDp1c=;
        b=wjld677w66kr13YPnGyUO/8gN3UPLyTU+ME95kM2JWsQcZqPRPRhtOpjGc6bxd/mPa
         M4xJYB4DfmPZEuQnhiwX3e1KKW0oN53o5kIKvcolEous/AhEekHbNjwqZrdNOEndr8W6
         eUSgKEYyHYw2Mw3xBZz2x30I6mkXMB1ldvp2Cm2z9NAKk7ZJwVC+yKS8shP2DVP/qKUN
         ptQycZW/EynF70LSSMbBJfi5Ub9RKF6dWaHFujB4QHNb5wdsvYTbK7Jg3MNKNG1rQnVt
         KLBnOQw0AHGIHZiy4xNiEXngue59dItMf7Ies+XF9WXh2dhy4LKsB2qmI/LbO9vhgRU6
         mSYA==
X-Forwarded-Encrypted: i=1; AJvYcCVhi9F07hfRpBKgyC6aiMmpi1beKmMeAPGlipqHYRgjOaeoIDBLW7aXevuMHogJEP7PkuNkxBPSugrSr6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogGGrwFwZKAbhNWlsbkGf/srMry9fMwSv6IZ8hxPWvcME6okT
	FYeV7UrJScDOMnZkVj7E5/TvRmC/Bz8icCRo4xSuQrx2w3IdDSV0Ce16gA==
X-Google-Smtp-Source: AGHT+IG8Oe7ycEcoa/ELyN1z6vBugxKaa+tkUCsDG2fj6jGmblMGDfHiuimp+BiRrGbqF4NWOigU7w==
X-Received: by 2002:a17:90b:3890:b0:2e1:e280:3d59 with SMTP id 98e67ed59e1d1-2e1e639f23amr8600486a91.33.1728178780749;
        Sat, 05 Oct 2024 18:39:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83cab42sm4311359a91.2.2024.10.05.18.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 18:39:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: bgmac: use devm for register_netdev
Date: Sat,  5 Oct 2024 18:39:37 -0700
Message-ID: <20241006013937.948364-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes need to unregister in _remove.

Tested on ASUS RT-N16. No change in behavior.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 6ffdc4229407..2599ffe46e27 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1546,7 +1546,7 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 
 	bgmac->in_init = false;
 
-	err = register_netdev(bgmac->net_dev);
+	err = devm_register_netdev(bgmac->dev, bgmac->net_dev);
 	if (err) {
 		dev_err(bgmac->dev, "Cannot register net device\n");
 		goto err_phy_disconnect;
@@ -1568,7 +1568,6 @@ EXPORT_SYMBOL_GPL(bgmac_enet_probe);
 
 void bgmac_enet_remove(struct bgmac *bgmac)
 {
-	unregister_netdev(bgmac->net_dev);
 	phy_disconnect(bgmac->net_dev->phydev);
 	netif_napi_del(&bgmac->napi);
 	bgmac_dma_free(bgmac);
-- 
2.46.2


