Return-Path: <netdev+bounces-73418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96685C504
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 20:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F245287344
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36ACD14A4D7;
	Tue, 20 Feb 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3NUHv+Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C912EBEC
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 19:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458170; cv=none; b=oUHRql11XrMy1ksdwBVV4Aq6tQLe4lnxcCM1vlV8RDiIEXPC2jsGZfUDp5PrShP3bgiImzwqqrKzJB2rzjwKnfpbgwnzdvBqYbKrCfB2MzQNLs+Rf7PWPIk3tW0sMfLuSCEZffW4+F4Ts1qeYd+6am/HDb2henMAndeOpJGZggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458170; c=relaxed/simple;
	bh=QWkFrEkzqGLs/fYUGukOscI15ZpBZW3mTKO1W6b7TVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHjiyseeLOWPJ86XbRNqAgNCtCl7n/BePaB1zDrzpoIYps2GK7JiPWzvvmVud8WfEjvQduhuOCsemXhgl6YRz31NrDZ9ExOGfnrK4ha/tVYFtsfJ7PMyRsAQ7I6xMpSst2K5Eh2C6ENPFFVrZJMATLreQs1FpGcnyEjULtcLKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3NUHv+Y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-411d9e901dcso14795e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708458167; x=1709062967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7s18ZG9gNKC9uT7R7r7LhtOPq8sUOZ+fxeck077+80w=;
        b=x3NUHv+YiGbITA9O44l/u70MINCo6vTef9MgMy7kqc1B5JCVOlcbTBYKvGoqQzQwak
         K5mjS+y3HWWP3S34bqtM3/B2jh8TtzbvF+yHVOkJZ4h3N0ojzxLmKInlvnslRhLz3IvY
         2KQGq5MYLWRJmqnQI6V+L/OG+eY51T3zg9t5NqhjR4G0tzxd6eMnHgBzeP6Pd5s5pRhp
         6a/NgH3yRw51PIKBcEIYL88En2cDojMKZx8TGJRKKVIVB/S3i3KRENnil1RflsMGSTpF
         6v/fc+6t6oldy1EiAOqtwmhuAMUHJAvegspK1ir0tEAbogX+zOor8Qo+X77Ps3fWOK/V
         BRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458167; x=1709062967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7s18ZG9gNKC9uT7R7r7LhtOPq8sUOZ+fxeck077+80w=;
        b=LjadWzpGMleUdVXKKoxnGA5lyltkRDlkTLU133j6pRDcdBFE6PXg8D3y4X6HiimbIF
         T3GvzG4/JUurGIE1VZeK/VhLHUXWtUJPQTkcf2OYqSsde4ADqcj/IQv2bY0pJJt3wbbf
         1LkukwfF2oOdVoBgrkIuXZLE2e6c5vNYmPHLCpzQFF81MIGyvXZ6/nfpi66SUzmmt+F/
         6NYUrPnhYu89S4deRM7T+thEy87x4Y6R6Vj2b3/AUIqYRsOA7e/wOXCsb76sOqReGgTF
         LPqesEm0BNZnm/RrvELECxsZuN6aeP5OB8/KoFhn7LvGqEQ9WvNsfrC1Mch7ALh7UXlB
         Xa9w==
X-Gm-Message-State: AOJu0Yxd5pRPYzTNpnqxuv5naMapbNGPFxzXqJmZMaOpn3Bq7LFIig1u
	gJkCyqYaPmEdIEMw9SqA9NaWYRiVLML7HYWMDof8mUiXYv2O1dAhYOezSIMhLA==
X-Google-Smtp-Source: AGHT+IFDuo+kJoH4p7MCeEqXZhInLzEs/29YVgqwTAcQKleXtoZoSakL+Du4Fy5tc8aQCpvtH4nYlA==
X-Received: by 2002:a05:600c:1e20:b0:412:730e:5a82 with SMTP id ay32-20020a05600c1e2000b00412730e5a82mr6425wmb.1.1708458166723;
        Tue, 20 Feb 2024 11:42:46 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:cba0:1b55:6833:859e])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b004120b4c57c9sm15840571wmo.4.2024.02.20.11.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:42:46 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: [PATCH] net: ethtool: avoid rebuilds on UTS_RELEASE change
Date: Tue, 20 Feb 2024 20:42:44 +0100
Message-ID: <20240220194244.2056384-1-jannh@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when you switch between branches or something like that and
rebuild, net/ethtool/ioctl.c has to be built again because it depends
on UTS_RELEASE.

By instead referencing a string variable stored in another object file,
this can be avoided.

Signed-off-by: Jann Horn <jannh@google.com>
---
(alternatively we could also use the utsname info from the current UTS
namespace, but that'd be a bit of a behavior change, and I wanted to
keep this change a no-op)

 net/ethtool/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7519b0818b91..575642b3070e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -26,12 +26,12 @@
 #include <linux/sched/signal.h>
 #include <linux/net.h>
 #include <linux/pm_runtime.h>
+#include <linux/utsname.h>
 #include <net/devlink.h>
 #include <net/ipv6.h>
 #include <net/xdp_sock_drv.h>
 #include <net/flow_offload.h>
 #include <linux/ethtool_netlink.h>
-#include <generated/utsrelease.h>
 #include "common.h"
 
 /* State held across locks and calls for commands which have devlink fallback */
@@ -713,7 +713,8 @@ ethtool_get_drvinfo(struct net_device *dev, struct ethtool_devlink_compat *rsp)
 	struct device *parent = dev->dev.parent;
 
 	rsp->info.cmd = ETHTOOL_GDRVINFO;
-	strscpy(rsp->info.version, UTS_RELEASE, sizeof(rsp->info.version));
+	strscpy(rsp->info.version, init_uts_ns.name.release,
+		sizeof(rsp->info.version));
 	if (ops->get_drvinfo) {
 		ops->get_drvinfo(dev, &rsp->info);
 		if (!rsp->info.bus_info[0] && parent)
-- 
2.44.0.rc0.258.g7320e95886-goog


