Return-Path: <netdev+bounces-159875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE96A1749A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 23:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7473A8ABA
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D71B423C;
	Mon, 20 Jan 2025 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOfikxNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074723A9;
	Mon, 20 Jan 2025 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737411964; cv=none; b=UiizmUacGDTX1cPX4lBTNOG0XCMGMuj6E67nyTfkSKU3++oeZOKytwEYf+RT51UeMhzH53nOpflKWucHn/jHW2zpRnEkt33xS5XYo6fzvTllf1yb6cfqOo4RXMzYz68KuHPzyAYG5qeZwYQLz0zTFKm1nbZAohypK1+fGN4T0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737411964; c=relaxed/simple;
	bh=N1yl0a3qWWgDrksZOFD+HV6EwfRG6qtuU6kWWkZEfmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8cP3CiKy1ZyP+fE7Hg9viTkmM3TTVrDtwBP+u1YEHhppJsXB9hmEt1w22m/lSzq/6Sh9nHP8yMQHAmoZYPKhqlX2Fd7Yxbbsv3V6pOg7zGhRVYp92Tf4rUYNXM3Xi4zfcEhPo20Hcepo4cLkIv86PKeBjTPX6aGqjprG7GC3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOfikxNn; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b858357124so54614485a.1;
        Mon, 20 Jan 2025 14:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737411961; x=1738016761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxUxVxwLv4o/bc4XcmUkwOAtz1vz6XJrG7xLCMfGGyc=;
        b=UOfikxNnwZBl/UiSzSqyr3RW7HseNhn831+bmNYfotCg3xOpxDtu/ClWpzwmmoLz1V
         NDs2jMFQf8RSdpurcouv6czak9GEt4e3qIAVHVQ5ySH/sPoKSSQip6aFu7O+fo5esnRY
         2MF+fXXLWlOV5tRjHb3MCUWqnUL8CGopcDCYg7lmbdMXadclW1RfZJtJQq5r+kMd+bVZ
         iyNgk8fX+hEMlhOIQFv9L/urvr7dqpZdo8ZrYU64wl3G1EsdDWGI0LFpGPjp16VmvCSV
         LayrwIQR6zaNdNJNMDPOvbz2xxLAwTC2/ZhGHojYC7pgsU+qAI/aQFPC2BTzKHTN/Wem
         cytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737411961; x=1738016761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxUxVxwLv4o/bc4XcmUkwOAtz1vz6XJrG7xLCMfGGyc=;
        b=HhqibZ2eUNO8NlRm/Lp0YqL2osXvMhmZESRVpo1hyWme+ZAsdFA0rhR4r7r62wImHj
         B1SL5VtcmiwVRvRCwHBP5BBWNNI5nRmyFwFJrh39d11Lgv7r0lGIQvbReOovhm5Gb1GH
         /5MVuMxZcErhIB7v3zBXqQeE/AbEeAvbtSg6GvuW8axwTbsXbet8fQc/thXqc1OrGWPc
         KJkSaaCVQiCtKLwh+UOBgyL3ZR2+hWlU3VaD/24q70JxD6LyeSQPAGPmVB3ihKoroAFf
         +nmF/gNJvNo97tSiAHXwbFnv7ykgdjYJ5Vt7jlJnlTpMdhXPadn35Gn6Bn7JE2/v75DA
         e6wA==
X-Forwarded-Encrypted: i=1; AJvYcCVb1bBLAUOq8yWhihgvORS2t970KMI+jqUVP6i2fHCw555y7tMQjmGHvzuafI6zR/Rq/vzjr0ZUM2W5SrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU4XVjzlV29f2xo0c2M79HeLDlz5SBJ/3E7sZufsTtfHYbb8jY
	Lx17sV9+uRHAOZAsPRnyP8yRi8DiHiKHW182//FyX0WLeI8KDO4=
X-Gm-Gg: ASbGncvl8+gFIB3mpidBfkhZ7MRt2x3BszfLhaOQEKYii10yDihGzxRVnYy0BhBMZty
	kQ6/2vJ+HXSoXqmAQRHaM5QLPbPLIlhD8crOWfnXzO80gd4Yes+4fO1GJwLrdPANxPOBpvGS4mc
	Jgjpg8in5gW4xj5fPs5m3/CUQ2rugn214IhPS8qpYdctr9qVIoZYyrRUMBDuslTS6qNX0qTBeVc
	TGEPMnFp189jNUf+eSy+HJEx79tBI74xEf6aFVgptWhdY8c+1D0RR5v4vl1JF//CB8=
X-Google-Smtp-Source: AGHT+IHXojpr0g2zpaCikrNI5TGky5sZ/uuS4mK9GhNqhhJ15GoMTtHzMAKJAgUeWquuHkotZkNOYQ==
X-Received: by 2002:a05:622a:1b92:b0:460:3a41:a9e5 with SMTP id d75a77b69052e-46e12bb2ec9mr85421851cf.13.1737411961505;
        Mon, 20 Jan 2025 14:26:01 -0800 (PST)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e1030e4e8sm47075441cf.37.2025.01.20.14.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 14:26:00 -0800 (PST)
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
Subject: [PATCH] net: davicom: fix UAF in dm9000_drv_remove
Date: Mon, 20 Jan 2025 16:25:57 -0600
Message-Id: <20250120222557.833100-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dm is netdev private data and it cannot be
used after free_netdev() call. Using adpt after free_netdev()
can cause UAF bug. Fix it by moving free_netdev() at the end of the
function.

This is similar to the issue fixed in commit
ad297cd2db8953e2202970e9504cab247b6c7cb4 ("net: qcom/emac: fix UAF in emac_remove").

Fixes: cf9e60aa69ae ("net: davicom: Fix regulator not turned off on driver removal")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
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


