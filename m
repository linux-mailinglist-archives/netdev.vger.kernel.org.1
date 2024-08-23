Return-Path: <netdev+bounces-121246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789C595C574
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4BD1C20E72
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B71762D0;
	Fri, 23 Aug 2024 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFYGd/m8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE46A01E;
	Fri, 23 Aug 2024 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394450; cv=none; b=g8vVEHlLez/w4kM1tKve5kXpBrXMQjDRwXMeSgQyvyW1tKLiko/5EtEcN/hbL+ElZwA0fxUENTvP6yuFwmFtkJ6nPVf4p5ZGNvVF7oLKYge1m/+hoNTMvYIghcCI3D1X9X3WaPS2ETwtaIJhOGiT9+jRjINVvM8HTI25TXeXna8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394450; c=relaxed/simple;
	bh=Q32yoIuMJEJ78gJZ7XWTYja8kr7BM8WpKDmwHaerRlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nAeOL6t49SkXjATsRvP315bOozFw5stEDuB8a7dWQiaBD+6oY7N+AfS5R7pKiEw+BuPX4UGO2CiFU9qHHdSy048HoPw/eYi/OAKT4LDcpbq3Vf1O4VXKx/a7t3fX6ve5tqIQ8vW5zZlC6c5DvPHv/jUMsQEKDR+D5Hp1VsSPOto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFYGd/m8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7143ae1b560so856675b3a.1;
        Thu, 22 Aug 2024 23:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724394448; x=1724999248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOPah6ZcESxnWHirfOBkqgaXZOMAL4YLUAOH8R/cfg4=;
        b=aFYGd/m8+Yb0rq1ORm482YPRPVMf1+xZlbovgOkN/2bhf9b0T/yZ0e6kjX+RccwXi2
         7XAWl3+LKpGb3IOn8te3ph38jlXtZz2VZBe1VUfJZgQPtcvEOfA0/6iYHmzjhYdRpEOH
         kxsj8qnSRlkCbfOkS8isj8NsklaiuDQL5y+2QfyZKRNicG6kKDgFgH+76dJmxEX83xbv
         +Yi16lS7uZwfp6zvjRajMf7raVkOHvJbPSq2GI6h+W9jNyjRVtxWX5S8Xiu9GxCLRM0a
         WAe0rWjQ3/ug6KNgjNFv+NXV/ELWnc0/JFFiW3u6OJE5eTSzSJZjs4/8afqXkIenKXgN
         xE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724394448; x=1724999248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOPah6ZcESxnWHirfOBkqgaXZOMAL4YLUAOH8R/cfg4=;
        b=jzcBBEs2r16foeO82AjpzfmYeQe8ejeULRXaCKu99mm73V7ItqDKMPnaLWLhx/3Txy
         cAgv9mFcARjW2B/lFBFhrHBI/AocM0JcSHEOE6vW3JGtL1ZLAF3SwKafQHvlcn7WewHr
         TtULN1ls844qyw9hdxgnesTNTUIv0NOCBR/mNj17m11sqY2i5VAgajTRW1BduxiobS2l
         LwlWUU47IvrWOLKEJ0Sc7J8t/roj6kNDTx6XUFgrwzVw5yh+w+Gn6QTmmOGdtuTHxgVj
         P1ML3MChWKXWnEwKY1ciLjjJrGozxc77QLhRktTowlrbAYwM2HDv4sSiUdcsFtz/gIgZ
         /+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV0jJqYPDnOoHAlL/ab7eTOzpi/6LEJYT0clF+81QZen6Rb5MJXBAQmWxLT/3TrCg2C3XgZxUxt73Xuo1E=@vger.kernel.org, AJvYcCVYj/oarNl/BfTbdZofLDp41R0ML180/MX3H14UD5AdYKgme4T6B4WBJk3hiqogpBhRk2A2cWW/@vger.kernel.org
X-Gm-Message-State: AOJu0YxMoh6vcpE/IcWzMTdyOuH/mXMSZrrpjR+tN+rjo4AE+J6LN14m
	A0Pt1p1RyRun1DHVELoIF+YkZ3rKQR3AyCLRwQyni5AzxMZix2zpdmv7T/wF
X-Google-Smtp-Source: AGHT+IGx3fZxTVG/evzvRWqE4007d+Yt3nHGbQC0ud24wvL0haFdv/KAmRENBQ+nRa4kouMRRzLboQ==
X-Received: by 2002:a05:6a00:124c:b0:710:50c8:ddcb with SMTP id d2e1a72fcca58-7144573facamr1699819b3a.5.1724394447714;
        Thu, 22 Aug 2024 23:27:27 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343388bcsm2333419b3a.189.2024.08.22.23.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 23:27:27 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	suresh kumar <suresh2514@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5] ethtool: check device is present when getting link settings
Date: Fri, 23 Aug 2024 16:26:58 +1000
Message-Id: <8bae218864beaa44ed01628140475b9bf641c5b0.1724393671.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal, attempting to
read device state when the device is not actually present. eg:

     [exception RIP: qed_get_current_link+17]
  #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
  #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
 #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
 #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
 #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
 #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
 #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
 #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
 #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
 #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb

 crash> struct net_device.state ffff9a9d21336000
    state = 5,

state 5 is __LINK_STATE_START (0b1) and __LINK_STATE_NOCARRIER (0b100).
The device is not present, note lack of __LINK_STATE_PRESENT (0b10).

This is the same sort of panic as observed in commit 4224cfd7fb65
("net-sysfs: add check for netdevice being present to speed_show").

There are many other callers of __ethtool_get_link_ksettings() which
don't have a device presence check.

Move this check into ethtool to protect all callers.

Fixes: d519e17e2d01 ("net: export device speed and duplex via sysfs")
Fixes: 4224cfd7fb65 ("net-sysfs: add check for netdevice being present to speed_show")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
v2: Restrict patch to just required path and describe problem in more
    detail as suggested by Johannes Berg. Improve commit message format
    as suggested by Shigeru Yoshida.
v3: Use earlier Fixes commit as suggested by Paolo Abeni.
v4: Typo as suggested by Simon Horman.
v5: Move further up into ethtool as suggested by Jakub Kicinski.
---
 net/core/net-sysfs.c | 2 +-
 net/ethtool/ioctl.c  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e2084ce7b7572bff458ed7e02358d9258c74628..444f23e74f8e6bed058eee09e03e045d4df6bd52 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -235,7 +235,7 @@ static ssize_t speed_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev) && netif_device_present(netdev)) {
+	if (netif_running(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
 		if (!__ethtool_get_link_ksettings(netdev, &cmd))
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e18823bf23306dffd32ddc752458e3c350a29b42..ae041f51cd2da4e6f98a1dc24ff109432dae2946 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -442,6 +442,9 @@ int __ethtool_get_link_ksettings(struct net_device *dev,
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
 	memset(link_ksettings, 0, sizeof(*link_ksettings));
 	return dev->ethtool_ops->get_link_ksettings(dev, link_ksettings);
 }
-- 
2.39.2


