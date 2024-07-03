Return-Path: <netdev+bounces-108921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5029263D9
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE371C20E11
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3E17BB1F;
	Wed,  3 Jul 2024 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNyYVSL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3658F6A342;
	Wed,  3 Jul 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018330; cv=none; b=jpHjr9SNKGAlal1BmXN1NxQ8an9tgZhCEA3NaKkcbhiqNWYldonpINGHJdfVWCKmxBb6tvkGXAwQydvWY19BqUX//F6WUr+GxPKuN1XE29/2mSGMddXWdDMzrJqdkSYF5aYy19R1qlLab4/xnQLDM2iJAjk84R5fjh9D7yNrN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018330; c=relaxed/simple;
	bh=WWBTexeKlu3/m4CBeaLtt0EX7DuzSpqIQxTrunqvRBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tSISzq4mewB123g3Kcof56HDakidBhR5u311XKBZ7dgXDv/bP+Njm2/ZgWg47zAhgQ/xHbKiZ/YJ8e8JR6+MsnS5c5Gfok6KMm6CaMredmoUdIkGW2gz5Ef18Q6q3JQkX9VkiEACecksN99y8PirH1i/BvGVWbz+ZXBol9rcibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNyYVSL6; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d841a56e1dso1788683b6e.2;
        Wed, 03 Jul 2024 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720018328; x=1720623128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ2PNk6wpFX/f/zn7sOj1CSv21ZtsJPh8OUiiFyP9QU=;
        b=hNyYVSL6yggH5eum30z7TeE1HV6kDsqD90Tw8HEMY4d+VgdoAhIqCH6Um4Rm7new9V
         doeFw1O9MrJ75FLQQx5cGtnQkCGDmzPC0+LHZwLtT7noVrEECj5KB5m5JuegihVq1prJ
         wy7ijQY6qVJ5NpKwcsoESIFFjnHWbYybE8dDPfC5yAP+MKD4GVc6zvZg6SE3pw+jUavx
         bL2KItxFWcQL2QYadGl/NULYFHTgB3silB0gGCIbn3iWYCsbNJ9zUrTigDcO6mc1WUcE
         wHYPapTk5sIbQ6dZ6ihFTBODkWLTUwQlzgTmSFe4x7YSHc+F+CBe7Zevh1oFi6wd3iMh
         ky8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720018328; x=1720623128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQ2PNk6wpFX/f/zn7sOj1CSv21ZtsJPh8OUiiFyP9QU=;
        b=Vv63a2VA/2rnyYt6GSkz3kl8YfJO/zxoaEuQk+KCnSHLWIGbU0+zM3jBrkx1PRl1oj
         4PAndn9qZUz0kDxSx/cZBwATtffMEHDssjmyWR34GSz4vKBVGN+l/uUrvqGKjx4OmTCQ
         7ufT9cRa2o9/zKF7JWpg/NzAvmOwca3C1xfxYUeRGtm8jFIFhReDbJhW4wtSwr1pES9M
         tGQDu/BD+6oWpFY/0RF8YDSLEdg9AOxd0FY9YJOdxCoxQgqkzbn6vlnZhBsfzkXjmuYk
         q3jNo0ICGrDnZvm75m44II+d9edgE0mCSL+SPX2gEVMfXcV5yAGWdi/J7YDJer5Ov0uG
         2dog==
X-Forwarded-Encrypted: i=1; AJvYcCW9ywuvKeVhoNATr7++agpETgjsRkN+aVSLux0tE4VaOB0dIW0jT20/2Y5BCWKYtJ32bpfuIoV7f0nMPgQ4CxbXYlCpIK5lxFhbYQZMPcyZMWqMYOxuK3uFRLQwysqom0Z2IVBv
X-Gm-Message-State: AOJu0Yy/QeaSGbOtLyCiCgbZaU0t6XVZyHB6/ISpX9I6vWecf71cQ93+
	0LWZPH00RhV1sX2evljfxjekROPE0ymffF4alNXnTC+lSJxLyybb
X-Google-Smtp-Source: AGHT+IFDfhm0K6JoG12J5Rx2/x1IL2tWJEvmqkrUiN32sQcsyQBavttJjBMt0d5//xNr1G/wMaxoIA==
X-Received: by 2002:a05:6808:23ca:b0:3d5:fdc5:cfb9 with SMTP id 5614622812f47-3d6b2b24facmr17631436b6e.1.1720018328311;
        Wed, 03 Jul 2024 07:52:08 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b0c5csm10492973b3a.167.2024.07.03.07.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 07:52:07 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jiri@resnulli.us
Cc: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] team: Fix ABBA deadlock caused by race in team_del_slave
Date: Wed,  3 Jul 2024 23:51:59 +0900
Message-Id: <20240703145159.80128-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: <000000000000ffc5d80616fea23d@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

       CPU0                    CPU1
       ----                    ----
  lock(&rdev->wiphy.mtx);
                               lock(team->team_lock_key#4);
                               lock(&rdev->wiphy.mtx);
  lock(team->team_lock_key#4);

Deadlock occurs due to the above scenario. Therefore,
modify the code as shown in the patch below to prevent deadlock.

Regards,
Jeongjun Park.

Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Fixes: 61dc3461b954 ("team: convert overall spinlock to mutex")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/team/team_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..3ac82df876b0 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1970,11 +1970,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
                          struct netlink_ext_ack *extack)
 {
        struct team *team = netdev_priv(dev);
-       int err;
+       int err, locked;
 
-       mutex_lock(&team->lock);
+       locked = mutex_trylock(&team->lock);
        err = team_port_add(team, port_dev, extack);
-       mutex_unlock(&team->lock);
+       if (locked)
+               mutex_unlock(&team->lock);
 
        if (!err)
                netdev_change_features(dev);
@@ -1985,11 +1986,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 {
        struct team *team = netdev_priv(dev);
-       int err;
+       int err, locked;
 
-       mutex_lock(&team->lock);
+       locked = mutex_trylock(&team->lock);
        err = team_port_del(team, port_dev);
-       mutex_unlock(&team->lock);
+       if (locked)
+               mutex_unlock(&team->lock);
 
        if (err)
                return err;
--

