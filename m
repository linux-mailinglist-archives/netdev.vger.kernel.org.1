Return-Path: <netdev+bounces-181346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6181AA84951
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4642A17C4CD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743CC1EB1BC;
	Thu, 10 Apr 2025 16:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF01EB5FD;
	Thu, 10 Apr 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301483; cv=none; b=NFIqKx/G0J6aUnke1VUUoJWYvDCPgXT+N/im4xyK/m3qrCO7y5IZ/dAaktX7PE0T6/weXRfMZtPm/lVA8dpQVtG8RdvV+MkFAS9sR0zoCjrgZTgHmp7OqrraxkIJPbdQ8RZp6YRJdHWHOUHrM57d2roG9rTM3gok4/LvnCUff8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301483; c=relaxed/simple;
	bh=eoLFo4St2bRVAWzDrRnDkbVxFTPTOLrZe/jve9RJ6iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uM1uRh2oNe/v8z3Zgz1UXSpaHHucC4Fx9oM4CAOR89Bk+ksV+dpMGw/pBJcQa2GbTWdbhe+4puNtSqhQIXkaiioTRGSK2qZDM5ONs34UlUvUZzYFAeDFxYP4yalzxilEw9nt2rgcrUiItBfgHj2TvLDDC+KaTqvhvaj80H4PaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376dd56f60so726226b3a.3;
        Thu, 10 Apr 2025 09:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744301479; x=1744906279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O2Jn034guzAl2Fd5lC5sxo3WJiV73Esjg9KWHNnQZ4=;
        b=f/o40NfWVT+S7XkCX/x3zC4iMM98VtHFCu8RvnPG5/uKRWM5TbkYHePogL5EXTjBvn
         XZsTvC99Xt8GFkpAaGkjUgx0h/15SMElNm4y9CG+4eEz/WZ/BWWQzJ9kUAbHqZEM1H/O
         0rhPfw8MB/wn17Y7aa+rSgtcGSunk/Jsx8slkhPj2h+O1pTK0qiTXCkjV1enlwRLLHeu
         Utcwm/shNbjkO/NbgXlI+a8MyhCKzWZf5CpqHVemi+gpy0n7ZTFz/2sUhQgrTtTOiiwO
         2u5/677k9yKOVcxNYYbUBqePhjR7DTE7775pMiFXQiI2S1MA8WzX1s329mp+gYMKl55P
         g4Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUMnALjFBeXCZrgpdtqa6ONpowBLFFX3hSYa5yl8lnBV7T7BbrtVo57HGLcHVI2NYfUVCYB4ZM3yKPB5sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcP7zYEd/LtdGR/7LIvdz6XEWQNukQ+GuHZEKQJ//b36Y5GV+l
	Kpj7EusR31S5+/Kdii2ZLJYp5TOimfrHiLK2zODI4lUJxO8GuYLLw7wiRFE=
X-Gm-Gg: ASbGncsYA7q79BHFPaAemrrKAeFMy+4S4jDMcU3bKXISicQRvMphvxJsulLFRlYKvHg
	ncEyfTKM0EZP1TOsytKvpojDlSWREF5MC/xpLXP7Y+YIaKSQ/4OCoPx1bYjAZdG5/ejLVSxhSwv
	/Sc/d/hFrDhTn3UuI5YmlIRWpome7UqM9zNR/bnCbVZh/Q3lDRODiC+YyHZYvUdXvgS1O0braBQ
	5uyOpyJDVPsmfPRW/ZsAUWjTAqhXYYTeXg2BszWIsJno39LMvQ+I379WM+oc9ZFbfLaoZClBExG
	Jgpl8wqmMdw6mFCkG8/6iyn1+J6xDB8gAXvqrqvl
X-Google-Smtp-Source: AGHT+IHLz9mJ8ATkWmHe5s3iZ/5LWaxRzO7DIGXyfWGoOW6eG9uo1VajnZaOuk52QXWZtGmtPfovjQ==
X-Received: by 2002:a05:6a20:6f90:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-2016ce189b2mr4646742637.35.1744301479179;
        Thu, 10 Apr 2025 09:11:19 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bb1d2b3c2sm3454818b3a.26.2025.04.10.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:11:18 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>,
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: [PATCH net v2] bonding: hold ops lock around get_link
Date: Thu, 10 Apr 2025 09:11:17 -0700
Message-ID: <20250410161117.3519250-1-sdf@fomichev.me>
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

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
v2:
- move 'BMSR_LSTATUS : 0' part out (Jakub)
---
 drivers/net/bonding/bond_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 950d8e4d86f8..8ea183da8d53 100644
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
@@ -860,9 +861,13 @@ static int bond_check_dev_link(struct bonding *bond,
 		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
 
 	/* Try to get link status using Ethtool first. */
-	if (slave_dev->ethtool_ops->get_link)
-		return slave_dev->ethtool_ops->get_link(slave_dev) ?
-			BMSR_LSTATUS : 0;
+	if (slave_dev->ethtool_ops->get_link) {
+		netdev_lock_ops(slave_dev);
+		ret = slave_dev->ethtool_ops->get_link(slave_dev);
+		netdev_unlock_ops(slave_dev);
+
+		return ret ? BMSR_LSTATUS : 0;
+	}
 
 	/* Ethtool can't be used, fallback to MII ioctls. */
 	if (slave_ops->ndo_eth_ioctl) {
-- 
2.49.0


