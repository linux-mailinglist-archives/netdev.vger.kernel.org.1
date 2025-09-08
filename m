Return-Path: <netdev+bounces-220922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66239B4974B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4251A7A5521
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E2313E1A;
	Mon,  8 Sep 2025 17:36:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155F2FF645;
	Mon,  8 Sep 2025 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352978; cv=none; b=mBac7ISJaK4ePcpfHKaFf6VcWPtzgpazkommtIb023d2oRZFOuwm5DBBxiCyKVHm3nkL1GgndP1tjrUtnFe83J23l4BywWnnjdhR9u+Entr64Jztx+kuzh0hkdJ1ybpMiv1438GcV0ZHKUoJJCT3+VSC9KA0Yz/8/xSWnIO7cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352978; c=relaxed/simple;
	bh=8idK2oy7Zo4ccmkOav1LwfHm/x5wjjv4iakprekjEws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeWBHzZ5NVIgYia/u6LYpmkB/j3RMdVSLQP6uUv7qjIwy4z5kehS+EWbcbu1n/N2kNg7sMiPjBiCPvNurT7ToQ1oS0MqYFLzgVdZZAFSqXk3nr+st3ryZMTDkn0SSyPIP+78vFH2399GYVihhoMzjRMYyroVgeSHWZat2teI5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77256e75eacso4195859b3a.0;
        Mon, 08 Sep 2025 10:36:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352975; x=1757957775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWOkXO1YSMafh5wZGCwi36l6ttH6nWTujllVdXtHiw4=;
        b=m41Gjo3atWX/arjH9Hj5AMHd1en2zOIBI1NfDbA/IGaIgO90asBuuHbo8xvRAQMQMH
         LJou2BkW9g0HSoB1uLnG4qLJqTTGtM7ATsO/KQvs2rSKaaOad5Z3Uj1zOABid0LPU/Fe
         2okzYuvCnEtvxkpZuyMM3Ryi9knnuSFKynqX9uc75ROdOb4tkpGy0DcQR7fAq+HhQq6R
         pUvyN+dOs4kQlgE8yDfh0KNIShJcttpRucWJdWgNCmpv1hnS1be+8e6IbO5B/qvWxy5e
         G6UM101sf5Nc1av1FVAl5hLiQF2oVfxJCSed1X15+aChYw6Ak5qfubAXLYe550REVvOP
         qt+g==
X-Forwarded-Encrypted: i=1; AJvYcCU7RCQoghAoDz8gFFVj0olHpBySE4WacD7TDSlK7HZBfNAcyiaUK0YF2THcRy1W2zTGEeaOHKe/rId5hlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4PRozg7QB4gbIb1F+Y1HHhEdZlaNhEALdHrcKOeK2Ig07Q3Qd
	5QknhyFi8XCnWRaCG2Y+2IIJsUWRPFBct465eoX762rmxn+LYUxhv0DhGHiM
X-Gm-Gg: ASbGncti4KdZGp5+39n/ZEHwM7JeonGk4WKoMBAqlDUiZNIF330qi6+WwNNhawdk2/2
	4K9Pm0gYIA1CaPd40GnvKa2Qi2Xypk0Pgc61wuDPCMCiPF8i75h8GOtXW+vU2OHEIzqz96s3L/D
	L1xkFVgJaJrM5mV+MPzkxNs1Vdkl/KP4YRTBUNNZDUbIoSWANHDXkPJncMC9d/jB5G+ZDEoVqIm
	oKZG1gH/jHHyoreSlrPZZDFqLCtbS2ISLmifpyx+x3SZ8rd7BUNxrYgdBZFiEYVARUsVMM3QP+b
	MXyLEXe3JgNhITcvnXpOA1ouJOHsNmT64dAtjr244kzgPoXMQa6dR+x4idPjMSL6Qavj9R2qMJJ
	bYx9HACxnwsfPxMH5qECB2uTR35FGLRPXgoYJzl9JzGsnHr0zdygwvMuqhTXMBSlXsFlX9fY3gp
	Rv9r8mmGYfvL9YKg6wFJVc2PEk4tQR/QxaP7KJYRJrHvMfXBJcdNmAVU8n0YJYaE5ZMlU4EKY1f
	8I5YDE+6R0K+2c=
X-Google-Smtp-Source: AGHT+IERN6EDSYSkg/6wareSlQZNsXYOru97WYIXq6nvOxJ+0c5Ptsp/1vjusxPOKzL+cQOBPJs60A==
X-Received: by 2002:a05:6a00:188b:b0:772:63ba:11b with SMTP id d2e1a72fcca58-7742ded355emr10665305b3a.28.1757352975241;
        Mon, 08 Sep 2025 10:36:15 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7722a2b2f56sm29887344b3a.26.2025.09.08.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:36:14 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
Subject: [PATCH net] macsec: sync features on RTM_NEWLINK
Date: Mon,  8 Sep 2025 10:36:14 -0700
Message-ID: <20250908173614.3358264-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller managed to lock the lower device via ETHTOOL_SFEATURES:

 netdev_lock include/linux/netdevice.h:2761 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 netdev_sync_lower_features net/core/dev.c:10649 [inline]
 __netdev_update_features+0xcb1/0x1be0 net/core/dev.c:10819
 netdev_update_features+0x6d/0xe0 net/core/dev.c:10876
 macsec_notify+0x2f5/0x660 drivers/net/macsec.c:4533
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 netdev_features_change+0x85/0xc0 net/core/dev.c:1570
 __dev_ethtool net/ethtool/ioctl.c:3469 [inline]
 dev_ethtool+0x1536/0x19b0 net/ethtool/ioctl.c:3502
 dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:759

It happens because lower features are out of sync with the upper:

  __dev_ethtool (real_dev)
    netdev_lock_ops(real_dev)
    ETHTOOL_SFEATURES
      __netdev_features_change
        netdev_sync_upper_features
          disable LRO on the lower
    if (old_features != dev->features)
      netdev_features_change
        fires NETDEV_FEAT_CHANGE
	macsec_notify
	  NETDEV_FEAT_CHANGE
	    netdev_update_features (for each macsec dev)
	      netdev_sync_lower_features
	        if (upper_features != lower_features)
	          netdev_lock_ops(lower) # lower == real_dev
		  stuck
		  ...

    netdev_unlock_ops(real_dev)

Per commit af5f54b0ef9e ("net: Lock lower level devices when updating
features"), we elide the lock/unlock when the upper and lower features
are synced. Makes sure the lower (real_dev) has proper features after
the macsec link has been created. This makes sure we never hit the
situation where we need to sync upper flags to the lower.

Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/macsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 01329fe7451a..0eca96eeed58 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -4286,6 +4286,7 @@ static int macsec_newlink(struct net_device *dev,
 	if (err < 0)
 		goto del_dev;
 
+	netdev_update_features(dev);
 	netif_stacked_transfer_operstate(real_dev, dev);
 	linkwatch_fire_event(dev);
 
-- 
2.51.0


