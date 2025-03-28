Return-Path: <netdev+bounces-178062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2E6A743FC
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 07:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D197188FB2B
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE401A3A8A;
	Fri, 28 Mar 2025 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBcjCvv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1AC2C8
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743142972; cv=none; b=mE6TjYgvhZJ/pM2U+/I69I1ALnVsQr66CRsA/bRnmRpudE+YnFn52NZKbL+hdyL+ri5z3CuEJQD2pdI3R6y9e4nbS46x0sZfSbv5X4jb+Ag4f+/gh4BSf/q9Igl8QMYbMWol6hzbsi78Gk10r38LyXW37MtEWj5wQUm7kWrc9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743142972; c=relaxed/simple;
	bh=zxGNgRmCkLUvwpU09PAAqcph5Ikp3rn+pQTrNBsUH54=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tACnh6/8APUV+TmGw/+mIQFLCGJYFQc+4RKU72X2MECMHLaAuMCwaORNxV66ni3TjGVwGt+SVFdobJN4V3/YaPUBKoljC8FEJQQ8D9QvlbuN98caz+c7VBbSLjBWd1ID+qGdkLWYYenbuAfrdA5TgDY7vJHBelhgfIHE8h6tNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBcjCvv1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de12bso51294635ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 23:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743142970; x=1743747770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bGgooy2JRa5SpFYE7djAmrY04qy2Z7qzgglUAQP+iD8=;
        b=dBcjCvv1uVNg2CY+kJRq1BhZmXP3rKf+vU9Pxn7t8hWfeY9bsm4J5uxyoBTBAOMRh0
         5v/GiX0hp+wfabo/BVeAZ+6rX9g9vkt3TJYMo9b6h8JH16FBIVmOQmRHNj08cujp5eTm
         utkOfnqnf3nhXuVdCJXRwf7DkQmhq30C6G6NRjdLs6k9vkhoBTXLyHQoNdTKNVullxeK
         MufDiBwNbMyP9S1wi3FpRGEdwnvGC1TClX9N0FwAqYOsH4UIO5Ppv3AGHw8tfy+4xpzt
         ruzhwEbV7LUfB7Lk3zvCCPVt6xqDZ2IAITOH5QN+qLvkXdOG6bXSYDVukmKf1ErTAlgr
         8jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743142970; x=1743747770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bGgooy2JRa5SpFYE7djAmrY04qy2Z7qzgglUAQP+iD8=;
        b=JiSgqkPSX8CQwXjIsuGlLhc7dUx01/ORary7MRhydB+G9YFS0zWKNmwqr9jdYPCjrR
         poPLfWLoWKTdLHESI1I47vhwd05w5hppgaADjzoXUUBsqU/aomsDTgie2QTZWuJ2yjRN
         MQW2w0oJrBZPrk11DUKpN+pUNxZDjxh8cBGHflwqJ74lqX39vT//sdq3V0JAnauozwOC
         ujU1Y2NYINuRNxVyS9yJnR/lxcf5a3Rog8WLYEj2Zzf0TmgRRec8uySbZ9Wj0l6neBAD
         7r/2U7mbutpp6OzsHh5M/rRaCKPYLe26s2gc5bZ8oWCUeEm2U6/fzUepmP3RvCQnupUP
         U+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVv4zBeidhsmFSd2uZ7OAAhu70On553/ZDNkUaUxSWca4YU2XNyQzfgcO33yMWAtYHzMJ2XDOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfsuI+E8AIWlxAU/Wq4NGpPuWKHfViDYJyMY31RH3DfIbMRPlY
	Oex45pnaOmVcCbVvqXelu+oDOc3ePD5BPcF2p9g6QcPCGAttJSIP
X-Gm-Gg: ASbGncuGU3Kgiw3+JXnV5HYoACf43HEeFbPOxb1v2Cv+avC99V+rS1K6uvQ/H1uXH+f
	J0EUBWmfVHiMpROo8CEHp+DyzVBWUdEf1PMFlDP44pzdjqch36ORswXQfwK7LKt78tQXYzTT+Bw
	x+iM4fZrVh1VGNwvmg8rrwkR3b2Y+U0oY7xJiCuvqFNo+FsC2NzkmK/5LfARac0hxrtmUypDyb4
	e2Vh26FtazQBTanE3/1j3HXxqtjU3hLfzzOh4Kqk0s2exBAxl2iYv+AepvwOhketkU6TrhuGmhu
	Bj9nceKT/bnLhOGRZDCG7wGcuyCrF69Pxg==
X-Google-Smtp-Source: AGHT+IH5BA/7DgtG/jc9w+67+YQm6ww4tGISe9fdx7qNdpT8H/XUCtvUGuIz/UbN/wtxB3Kb4svMMw==
X-Received: by 2002:a05:6a20:3953:b0:1f5:8a69:f41b with SMTP id adf61e73a8af0-1fea2f80c32mr9671793637.37.1743142969715;
        Thu, 27 Mar 2025 23:22:49 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b6ae46esm899960a12.21.2025.03.27.23.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 23:22:48 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: jdamato@fastly.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	xuanzhuo@linux.alibaba.com,
	ap420073@gmail.com
Subject: [PATCH net] net: fix use-after-free in the netdev_nl_sock_priv_destroy()
Date: Fri, 28 Mar 2025 06:22:37 +0000
Message-Id: <20250328062237.3746875-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the netdev_nl_sock_priv_destroy(), an instance lock is acquired
before calling net_devmem_unbind_dmabuf(), then releasing an instance
lock(netdev_unlock(binding->dev)).
However, a binding is freed in the net_devmem_unbind_dmabuf().
So using a binding after net_devmem_unbind_dmabuf() occurs UAF.
To fix this UAF, it needs to use temporary variable.

Fixes: ba6f418fbf64 ("net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 net/core/netdev-genl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fd1cfa9707dc..3afeaa8c5dc5 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -951,12 +951,14 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	struct net_devmem_dmabuf_binding *temp;
+	struct net_device *dev;
 
 	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
-		netdev_lock(binding->dev);
+		dev = binding->dev;
+		netdev_lock(dev);
 		net_devmem_unbind_dmabuf(binding);
-		netdev_unlock(binding->dev);
+		netdev_unlock(dev);
 	}
 	mutex_unlock(&priv->lock);
 }
-- 
2.34.1


