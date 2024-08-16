Return-Path: <netdev+bounces-119336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EBA95537E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 00:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7211F21C1A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9A613FD84;
	Fri, 16 Aug 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEpgicnw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3913AD32;
	Fri, 16 Aug 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723848466; cv=none; b=dShnXQzRk9WPIqG52/Sb5uyepCWImuJ/Qp4qgHxKGo1r17SwqgJuvX3CfMExhHby5OLTJEt7MOfYO7D9udokHKIdJ+2tqxYcb2PZlsCg+wQ2hN0EpkZ8g88I7c0j321NuHm+jtW8j9LuoyZpijjaIIxE/q/h8059E6nThLpa260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723848466; c=relaxed/simple;
	bh=p9RdvmXOTdSV2hiV76+ufrWOZpY8z0ks2DlgEYcE7mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/6PMxUNoUeS9DPD4I+9wMAmicm2t6aHMh1XnvaP5QPD9+0OyURd1QwVgLlYigeooT61w7roKDfLkHiq7ZDZ5k16Q5QOq4MGoy8uzcPYd674Url6tL3/wFHvVBJq06JxL0pj4sFUYEL8618KAKbGeP14fl0SVdJgGEqafukQj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEpgicnw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc65329979so23694075ad.0;
        Fri, 16 Aug 2024 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723848464; x=1724453264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOPfVm15ymydsCIAseE4yRDn9MeBebUa2gJkh5sMWvY=;
        b=cEpgicnwQZ+kE1+n/+46mvAU8HbEVUkqm04/U2vWU32IstKFYhXJz004qKNTJX9FmA
         hPsDWmo827lQgiZNfnGomQAjipG0tIo3GlC+rgtXUGyn1PlWp/IF2C5Yv87MHyhXijc+
         67pMsfAR2HiJ57Pxpa+o7OwpdPWKCi6Cmn6gpVbC8Q/cTHjujK0lF+CS3e5Ul7kddWvX
         g1VGFH1nLYxPIBjafq+qgrQA7PKnk4O8q4WIL01TyK+qu0ABNR0K2nk6AcxIbWBEZgLl
         NJftg6KGJqk5qj68e25R+YTyjOt/CL5kJHfKhV9sxUFhdmZr5XqLcFMRo6/GGKvrmD+W
         acbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723848464; x=1724453264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOPfVm15ymydsCIAseE4yRDn9MeBebUa2gJkh5sMWvY=;
        b=RxannkriX7pWd/kmf+XH3imPoylvtQrX+WhOn0/Zwfn82Rg3LCraAys7lrNQoc60DR
         MDl5SXXrsLRmJiEd3NELesp5gi6j+EL1sBpkIrCR5jRfVp6dapTdVUc4qdM7ODt18dwy
         kaWjXzr/cmmH2sAI7ztkgw2/cN9ShtG5OYWl9npJJMa3/SXIa4cGuFp4kKLKmMO4Yu6w
         JR8DOWetchdaraZe+ETHqenM0UJRUmSUaqnf2VrpVbd4BbgCL4dXaJck0SyB+BZvGt0i
         uS9H1WiqzLdHWPS/ZpW+1mMIZ1iU9ylvQkEcvBYBihagdtpwOuNsfiuYNVrUp7hXi5su
         X6bw==
X-Forwarded-Encrypted: i=1; AJvYcCXKbvwxpiwD29fAoKxyvyRvFROVTt2yS2C+0v/g3BMavHKZiLz7W6TmUAccP0YlarZBPohM7l+wbG0c3XtA7rRrjz1LGUm44T9D+HvD
X-Gm-Message-State: AOJu0YxRpC6TE70DO07Cs3WT8XthVyybzEzMxDYYyIX5zd/P4BVtxGPc
	sOTALwPei95kYr9AFODdG1tg0zyv6BhssscYG4ZyuwxilBXv/xDGPrXyNg==
X-Google-Smtp-Source: AGHT+IHlgstrZOMcGjUJ6rZyQCrcXVqA+cc/4A7B7r/xDQ+Xfv6o1PYg2CAQSb3XzhP4sziDnI+/eg==
X-Received: by 2002:a17:902:c64a:b0:201:fd52:d4f0 with SMTP id d9443c01a7336-20203f2bc4fmr41113135ad.47.1723848463616;
        Fri, 16 Aug 2024 15:47:43 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037563dsm29936175ad.131.2024.08.16.15.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 15:47:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	nbd@nbd.name
Subject: [PATCH RFC net-next] net: ag71xx: disable GRO by default
Date: Fri, 16 Aug 2024 15:47:33 -0700
Message-ID: <20240816224741.596989-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

```
Currently this is handled in userspace with ethtool. Not sure if this
should be done in the kernel or if this is even the proper place for it.
```

ag71xx is usually paired with qca8k or ar9331, both DSA drivers. DSA
internally uses GRO cells to speed up transactions. But this speed up
only works if hardware checksumming is supported. Unfortunately for
ag71xx, this is unsupported. On newer QCA devices, there is an external
HWNAT module that can be used to provide this, but the necessary code
has not been written. Mainly because at the time, the proper netfilter
code adding the proper APIs was not present.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index b74856760be3..95da34c71b34 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1770,6 +1770,15 @@ static int ag71xx_change_mtu(struct net_device *ndev, int new_mtu)
 	return 0;
 }
 
+static netdev_features_t ag71xx_fix_features(struct net_device *ndev,
+					     netdev_features_t features)
+{
+	/* remove GRO. Hardware checksumming is needed to avoid a massive
+	 * reduction in switching speed */
+	features &= ~NETIF_F_SOFT_FEATURES;
+	return features;
+}
+
 static const struct net_device_ops ag71xx_netdev_ops = {
 	.ndo_open		= ag71xx_open,
 	.ndo_stop		= ag71xx_stop,
@@ -1777,6 +1786,7 @@ static const struct net_device_ops ag71xx_netdev_ops = {
 	.ndo_eth_ioctl		= phy_do_ioctl,
 	.ndo_tx_timeout		= ag71xx_tx_timeout,
 	.ndo_change_mtu		= ag71xx_change_mtu,
+	.ndo_fix_features	= ag71xx_fix_features,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 };
-- 
2.46.0


