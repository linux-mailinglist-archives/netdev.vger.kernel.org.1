Return-Path: <netdev+bounces-59123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC21B81967F
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 02:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82DB4288830
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DB8C1A;
	Wed, 20 Dec 2023 01:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="HQ+etCdI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887A8827
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35fb96f3404so8500275ab.2
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703036870; x=1703641670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ink5cy61/xEFj7DTnQzb0Xv/R0xZT7Aw5SRjnGefOho=;
        b=HQ+etCdIgmv91RayXEJ/rMAiqQoHKo1ag6o4jyevgBnjArsMk4QcegVpdmWz91zH0V
         YCRqMviyP2X2Iia1gE2YtNlNiCtJTk+lnKW6FoEQ8AEnDxNuLn8W4XKbbAK07sMVt62J
         KSDRqrILGlsDbgRllqB243FPkkRcBl4Zt4Yv1Ae9dPK4fJzo+4mJZXI1xilXIqsjqpC8
         MbCJSMvpHNGDHVcVhpWJKboQPi0Eh4vy6817L3mem2HH9rs2qK+VGlt+EUEhsI7oFJbl
         c1cuOJONLFMUpv2KNeeLuJOXJG79q+HxMWk2R4OPBX1B96TJda2GuYtnDDIkjGX1QVfC
         7GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036870; x=1703641670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ink5cy61/xEFj7DTnQzb0Xv/R0xZT7Aw5SRjnGefOho=;
        b=XlLgNmy8mz+UGQIeDYMnnybFTK9i/PqyrzZe0SzpQMj8qLC1taXUPuqc/sanqsl8XS
         h7ZyikuQpAyRmPqt5rT3ieDlSRt9altsNgx7iay6YfMcbpJQeiG4J56mn8LWzAj0xX7l
         FPWMA9qcyXegtdUydIf+lLtmKlSU8hHSLSnNxgYn2T1wVeu42u9BGZiQTdWt3BUOuAyq
         xOXf+xGVay2h/Cd3CLkW8k5mOEBu73O7XRvi6JMGKH4G1ARxbPKG2BNVuvO6vPU1iOaN
         CtSZm19gSljjBeXS5CxRW7UPxUgkfNeWluyLuG9mxMXzYHcmLSS/vbMvacsbU75Et2YC
         xqSg==
X-Gm-Message-State: AOJu0YztD+XKffYIL44eC2g9pMyr/WZGvKFEDl3QN08TMbvEXpoq97d2
	7PnGpzboHl1LHq0iqAfi3FszLQ==
X-Google-Smtp-Source: AGHT+IHqzsB8PqHwr4LOSLr54YHN6AazAZw6Rm/HCo/2alvnYAjzXDvL7SJ4cZA/hdVQ2rBI0dbBfg==
X-Received: by 2002:a05:6e02:1605:b0:35d:7ac7:359c with SMTP id t5-20020a056e02160500b0035d7ac7359cmr34093668ilu.40.1703036870488;
        Tue, 19 Dec 2023 17:47:50 -0800 (PST)
Received: from localhost (fwdproxy-prn-015.fbsv.net. [2a03:2880:ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c14b00b001d3bfd30886sm4241618plj.37.2023.12.19.17.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:47:50 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 1/5] netdevsim: maintain a list of probed netdevsims
Date: Tue, 19 Dec 2023 17:47:43 -0800
Message-Id: <20231220014747.1508581-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231220014747.1508581-1-dw@davidwei.uk>
References: <20231220014747.1508581-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a linked list nsim_dev_list of probed netdevsims, added
during nsim_drv_probe() and removed during nsim_drv_remove(). A mutex
nsim_dev_list_lock protects the list.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/dev.c       | 17 +++++++++++++++++
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b4d3b9cde8bd..e30a12130e07 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -35,6 +35,9 @@
 
 #include "netdevsim.h"
 
+static LIST_HEAD(nsim_dev_list);
+static DEFINE_MUTEX(nsim_dev_list_lock);
+
 static unsigned int
 nsim_dev_port_index(enum nsim_dev_port_type type, unsigned int port_index)
 {
@@ -1531,6 +1534,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 				 nsim_bus_dev->initial_net, &nsim_bus_dev->dev);
 	if (!devlink)
 		return -ENOMEM;
+	mutex_lock(&nsim_dev_list_lock);
 	devl_lock(devlink);
 	nsim_dev = devlink_priv(devlink);
 	nsim_dev->nsim_bus_dev = nsim_bus_dev;
@@ -1544,6 +1548,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 	spin_lock_init(&nsim_dev->fa_cookie_lock);
 
 	dev_set_drvdata(&nsim_bus_dev->dev, nsim_dev);
+	list_add(&nsim_dev->list, &nsim_dev_list);
 
 	nsim_dev->vfconfigs = kcalloc(nsim_bus_dev->max_vfs,
 				      sizeof(struct nsim_vf_config),
@@ -1607,6 +1612,7 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 
 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
 	devl_unlock(devlink);
+	mutex_unlock(&nsim_dev_list_lock);
 	return 0;
 
 err_hwstats_exit:
@@ -1668,8 +1674,18 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 {
 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
 	struct devlink *devlink = priv_to_devlink(nsim_dev);
+	struct nsim_dev *pos, *tmp;
 
+	mutex_lock(&nsim_dev_list_lock);
 	devl_lock(devlink);
+
+	list_for_each_entry_safe(pos, tmp, &nsim_dev_list, list) {
+		if (pos == nsim_dev) {
+			list_del(&nsim_dev->list);
+			break;
+		}
+	}
+
 	nsim_dev_reload_destroy(nsim_dev);
 
 	nsim_bpf_dev_exit(nsim_dev);
@@ -1681,6 +1697,7 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	kfree(nsim_dev->vfconfigs);
 	kfree(nsim_dev->fa_cookie);
 	devl_unlock(devlink);
+	mutex_unlock(&nsim_dev_list_lock);
 	devlink_free(devlink);
 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 028c825b86db..babb61d7790b 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -277,6 +277,7 @@ struct nsim_vf_config {
 
 struct nsim_dev {
 	struct nsim_bus_dev *nsim_bus_dev;
+	struct list_head list;
 	struct nsim_fib_data *fib_data;
 	struct nsim_trap_data *trap_data;
 	struct dentry *ddir;
-- 
2.39.3


