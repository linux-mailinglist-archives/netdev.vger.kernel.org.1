Return-Path: <netdev+bounces-180400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC65A81351
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26ED1BA6D51
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7811222FF4D;
	Tue,  8 Apr 2025 17:14:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B14B191F79;
	Tue,  8 Apr 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744132497; cv=none; b=KbnoOceYT49FkgKqIIfuMcNMcNda+sZ7YcCZDwVtO/oddFXJVAsweD8HD71OUqrEI2nCNHrU8UYzwxQ/O3PRt+yZYRO9viqB7R5Tts3kjhtuCs2KokGuphtScbIDipEvBdcouAmEN1ZVPC/zgFdV+d3Unc45xTsM9QGQ745Nkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744132497; c=relaxed/simple;
	bh=jcyK2mN7KL6A10vMwCASXq/OxRL74veeQ/dmNNMAYtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMNxVKlg3ZLOv3weqJRYc1QtnauhPvtSyIqZ6asoDUXjCEIuLFoVbNoPwtKRAnmPSeZp4tDuYblTLh0RA9z1PhGp6J35eseBBULvgfND4RkoDjJLYyER+kQoVo/qd10MmQ8PXoBdeUWHE0ZKCs4AHUKE27d0LjXK2oa+1vSrKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22580c9ee0aso64127225ad.2;
        Tue, 08 Apr 2025 10:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744132494; x=1744737294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AW5WeJLIZtIq8T9byhQyeBBnS+bdUWcEU8FgEy7dvi0=;
        b=OtI1nQ9d+LCoRF4rt3RgkRzxg3KoZoXRSic/Xu87nDPJOsJjyUkcuxvReML/JXh90Y
         /AXi+94MAxt1/hwlv5XNBdq1oEki4asmc6dbIGryWF+6athU4qiWeubuIcbanplnpku8
         JsudhSNW5zZ3MkGmuRII5EE5T2zx+BjukDfDv/FrmHQVyThoKL+vAdUBmolDtsxm26ar
         SOwMlvq6Be7ZV7ygspv8+cZjzb7jEMFvGaKxqPEQABE5AsSZiaCtDAADBbzrcSVxk6U+
         jrcn6omA4kGQknv53keeSsG/0OY8TrbuYXvhcefTjQwAJ70xanZLG47X68alo1RBqZ5c
         gLeA==
X-Forwarded-Encrypted: i=1; AJvYcCXuidifYiYOc7sxoWJ8cfTgNvOKjQl2m0ZbRx3bZ5axkTxqQMa3Q7A5gUoa6K+CLk0TAr2LAnEgLo6pQC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiAZeDCGZhTCw3LesQeylGkPj5+im4kRF6hw4LaKOBFGoPq86
	aJmEQNJkJ/dNd7AsVH8xpsczabQwCNLSDYJS4CjIRaPUmqnlVHvaqbn6
X-Gm-Gg: ASbGncv/BZP2QwJep04bWlwWO+WkSRtQ5bjhR+y7+gf2jv+4MJqe1IftxGFcnnU7CP3
	syJLLgRrGY9d0JwVRTutU05gkTzaOLZ8gDoVVUW58oYJpT6K29bMZ83RIZS6lnHK8NqGiUMwA4P
	ad09s05ijEVUELZI8b+BPjfu1yAyl/dk3R8BwuX9iGkQwWHcEGgeGNY74wS5svfjndBUutzW4tu
	f2KoulGxloezS45scpSzWbCv++0xNLkSpjziuyO9FhtHbb2pdA12v3KHN+ju3bygMhy0EAI7uKE
	RMARcqzDGVOs2kVAkLCOCWQ4WKbGRrX2507qkRzoqY9b
X-Google-Smtp-Source: AGHT+IE6rpUteQ6/c4exxF09OpehWY2Hv9kpbP0+sLAH3pLaunBDR4/hyikJ8JyzkiV/Sq847v+J1A==
X-Received: by 2002:a17:902:cf07:b0:223:f9a4:3f99 with SMTP id d9443c01a7336-22ac29c19f4mr449465ad.29.1744132493955;
        Tue, 08 Apr 2025 10:14:53 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2297866e161sm102717155ad.171.2025.04.08.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 10:14:53 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: [PATCH net] bonding: hold ops lock around get_link
Date: Tue,  8 Apr 2025 10:14:51 -0700
Message-ID: <20250408171451.2278366-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a case of ethtool_ops->get_link being called without
ops lock:

 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
 bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
 bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Commit 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
changed to lockless __linkwatch_sync_dev in ethtool_op_get_link.
All paths except bonding are coming via locked ioctl. Add necessary
locking to bonding.

Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 950d8e4d86f8..d1ec5ec6f7e5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -850,8 +850,9 @@ static int bond_check_dev_link(struct bonding *bond,
 			       struct net_device *slave_dev, int reporting)
 {
 	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
-	struct ifreq ifr;
 	struct mii_ioctl_data *mii;
+	struct ifreq ifr;
+	int ret;
 
 	if (!reporting && !netif_running(slave_dev))
 		return 0;
@@ -860,9 +861,14 @@ static int bond_check_dev_link(struct bonding *bond,
 		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
 
 	/* Try to get link status using Ethtool first. */
-	if (slave_dev->ethtool_ops->get_link)
-		return slave_dev->ethtool_ops->get_link(slave_dev) ?
+	if (slave_dev->ethtool_ops->get_link) {
+		netdev_lock_ops(slave_dev);
+		ret = slave_dev->ethtool_ops->get_link(slave_dev) ?
 			BMSR_LSTATUS : 0;
+		netdev_unlock_ops(slave_dev);
+
+		return ret;
+	}
 
 	/* Ethtool can't be used, fallback to MII ioctls. */
 	if (slave_ops->ndo_eth_ioctl) {
-- 
2.49.0


