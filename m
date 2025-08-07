Return-Path: <netdev+bounces-212009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95ADB1D238
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 07:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130BD1AA1C26
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 05:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89121C179;
	Thu,  7 Aug 2025 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEbD175Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A3921ABBB;
	Thu,  7 Aug 2025 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546205; cv=none; b=L1844+9uDCUMiemY4KovHRDjGGUw5e8AUn6LiYXaqxiLYTsCcXN8ki8msebwID06LOxPwL5ZupG1F5zw5YhKVCbbQ4xWCPXUP9wi8Dnq8HpeFhVdi3LTwwsiolZhtgtY5x+aFA3JF9IEDiWpzySnWIMpdbwEBOifv7lbDMnUb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546205; c=relaxed/simple;
	bh=D0wZ73kZHtWcZ7ewkcs0n/rwuFyxCNSno1e/7sCGb7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mC4UEDI4kxyLdXHXu65HG0mWNLPgDyXnAPEP/+7SLw6ohlVchEjTQnZRjzY9X7YllNgjSWlc4RsRjFBhlnwfro3ahg7a9QvA/j3Gl8/7zVA48+X5CwE0XjwrSVlseOnyMOR5S+MOUd313QtQA5RY7da8NjAdZLtwNZ50oRAKsoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEbD175Q; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7426c44e014so589064b3a.3;
        Wed, 06 Aug 2025 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754546203; x=1755151003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0h+05C1Zh46EQQzElmpftBnQyamWVK9FugfE4dlg48=;
        b=PEbD175QN+UaE0nhgbBYiLQP7EsKmZsSvAcvy8jhI+S1vGgUsPrJxzDpmPDjHbXwI1
         sTWYOTQrPHZTCqRn60jirGAx77AbuPJBmUTooLF1oHY9Idn7yV7rpekQ7FcDQV4oVbKt
         VWR4d5SMnjTHWVa784IolFH20NbsWW5S9AJQ3Swalr9jULzcAU4rFFBMkOyG3wNoqPkc
         wVU3DbgUA4EATNsL12VmcuI68Dk7+PKEH5ZRVFwUnRp7KdCsBDa7yjwIcTuvLGUeV+Wp
         6u1pIl1gWdzhwSubfMlbL870r2o/kzBcovXE0r9XQduUdYl3FwXJU8+D0Pm7GqozJy7T
         vavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754546203; x=1755151003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0h+05C1Zh46EQQzElmpftBnQyamWVK9FugfE4dlg48=;
        b=jMkVEKkuli4ie1l0/HeORO8efJH+66qWcGl02lr1fiNB3iCx/0usoHZ3PA0/10U/OG
         PcisJz0GWr52kp7sxs9Nn5eKvRkHKlSdBxXAejtRfU4t0n+Km0+jmxgHDEnx3F4ZaCVn
         mkimcCDtF7gwDET7FAW7ACffNvhJup0zX76ypvkNkeGCgg8IkdzT5VyAU9r3LmptHVbB
         qsZZXW+EsRaiVJm/VIhA/1pwGFXwsTtgVZ7zWG1jrVTPbmYY65uPZ7AryRayVaFSoYG/
         ejg0mf2nD0SfQRXUQvL9GAPeGrtXxdGD3jdjde6N68a51XX/H0Id/QnO7Z/hLaHkRI50
         ECvA==
X-Forwarded-Encrypted: i=1; AJvYcCV1rF86Ul4GCn5G5ccX+1rKybfwuX1zfynJ0GIpQIQxn/gF2TlCwqr2GW1TwSF3c7fkRCOgKiWkYgGxoYM=@vger.kernel.org, AJvYcCXBT0uc8Wj1wI/2+qEI/QbapLzuMSfMGMOOVTY8N6aWeM8tN+B0HPF+1P3V/0s7vZtsIvUaFJuT@vger.kernel.org
X-Gm-Message-State: AOJu0YzVY30AqTRey13hUIfp5W2UQ2S5MXJn9EYAJqjRgC2/80aPKTRX
	QHzPLuTBjSQSwSwM0scfb+5qU4B4c8qmdxe2pb9c3UrkkUlGBzBY9CKi
X-Gm-Gg: ASbGncveZ2B9v2FIC0HhS4Rxo+OUMlHm07U6MK3OQDvNchbskt0/ktzlAswYXUCRanx
	a7uNZc1LgtrQo8lmgeRfB9B1CBynn1S7mOu2Vfh7ISWgZp8H9WOdNDj0ZY5G3BMFhCe1NtuOEO2
	yTZT8N8n5L+CY+fuep9xHaoFmx0FctYsbQtDRwx3W9Vb8NXquPkiNz3H0LgyGxugZMucxjed3y/
	qZOJ4A2CJVWyf/nYHYWb+8ozCk8CT1o+m2QMVWxDZYVE2+0yr+UybSxUgOv4iqMXFMM4dQYrA+o
	P+ImirUkY7PMgYxs3h3ABBq1oQG53ri9S/ZO8x72QXzZnI/IwwVc+ioGD9mbPNX31wnFB+vvfQA
	H1d8ttQIgBRlal7CGRjI=
X-Google-Smtp-Source: AGHT+IG9yDUlwCKQIVAqUp20xYAGbdtnddYTdgHP45UqnDGUusE38+/YLENZC+19yKuNzdaGqxX/Gw==
X-Received: by 2002:a05:6a00:4f95:b0:76b:c09a:ae9 with SMTP id d2e1a72fcca58-76c38819ae0mr1969509b3a.10.1754546203079;
        Wed, 06 Aug 2025 22:56:43 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8b5basm16893506b3a.41.2025.08.06.22.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 22:56:42 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@idosch.org
Cc: dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	kuniyu@google.com,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: vrf: don't down the interface when add slave
Date: Thu,  7 Aug 2025 13:56:34 +0800
Message-ID: <20250807055634.113753-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, cycle_netdev() will be called to flush the neighbor cache when
add slave by downing and upping the slave netdev. When the slave has
vlan devices, the data transmission can interrupted.

Optimize it by introducing the NETDEV_VRF_MASTER event. When a net device
is added to the slave of the vrf, the NETDEV_VRF_MASTER event will be
triggered, and the neighbor cache will be flushed, and the routes will be
moved to the corresponding table.

The moving of the routes across tables is tested with following command:

  $ ip link add name dummy1 up type dummy
  $ sysctl -wq net.ipv6.conf.dummy1.keep_addr_on_down=1
  $ ip address add 192.0.2.1/24 dev dummy1
  $ ip address add 2001:db8:1::1/64 dev dummy1
  $ ip link add name vrf1 up type vrf table 100
  $ ip link set dev dummy1 master vrf1

  $ ip -6 r show table 100
  local 2001:db8:1::1 dev dummy1 proto kernel metric 0 pref medium
  2001:db8:1::/64 dev dummy1 proto kernel metric 256 pref medium
  local fe80::cc26:8ff:fe02:ae95 dev dummy1 proto kernel metric 0 pref medium
  fe80::/64 dev dummy1 proto kernel metric 256 pref medium
  multicast ff00::/8 dev dummy1 proto kernel metric 256 pref medium

  $ ip -4 r show table 100
  192.0.2.0/24 dev dummy1 proto kernel scope link src 192.0.2.1
  local 192.0.2.1 dev dummy1 proto kernel scope host src 192.0.2.1
  broadcast 192.0.2.255 dev dummy1 proto kernel scope link src 192.0.2.1

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- introduce the NETDEV_VRF_MASTER
---
 drivers/net/vrf.c         | 6 ++----
 include/linux/netdevice.h | 1 +
 net/core/dev.c            | 2 +-
 net/ipv4/arp.c            | 1 +
 net/ipv4/fib_frontend.c   | 3 +++
 net/ipv6/addrconf.c       | 6 +++++-
 net/ipv6/ndisc.c          | 1 +
 7 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 3ccd649913b5..0fee1f46ef97 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1042,15 +1042,13 @@ static int vrf_rtable_create(struct net_device *dev)
 static void cycle_netdev(struct net_device *dev,
 			 struct netlink_ext_ack *extack)
 {
-	unsigned int flags = dev->flags;
 	int ret;
 
 	if (!netif_running(dev))
 		return;
 
-	ret = dev_change_flags(dev, flags & ~IFF_UP, extack);
-	if (ret >= 0)
-		ret = dev_change_flags(dev, flags, extack);
+	ret = call_netdevice_notifiers(NETDEV_VRF_MASTER, dev);
+	ret = notifier_to_errno(ret);
 
 	if (ret < 0) {
 		netdev_err(dev,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5e5de4b0a433..62f0f7f7bcee 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3159,6 +3159,7 @@ enum netdev_cmd {
 	NETDEV_OFFLOAD_XSTATS_REPORT_USED,
 	NETDEV_OFFLOAD_XSTATS_REPORT_DELTA,
 	NETDEV_XDP_FEAT_CHANGE,
+	NETDEV_VRF_MASTER,
 };
 const char *netdev_cmd_to_name(enum netdev_cmd cmd);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index b28ce68830b2..cd5c3ae08487 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1853,7 +1853,7 @@ const char *netdev_cmd_to_name(enum netdev_cmd cmd)
 	N(SVLAN_FILTER_PUSH_INFO) N(SVLAN_FILTER_DROP_INFO)
 	N(PRE_CHANGEADDR) N(OFFLOAD_XSTATS_ENABLE) N(OFFLOAD_XSTATS_DISABLE)
 	N(OFFLOAD_XSTATS_REPORT_USED) N(OFFLOAD_XSTATS_REPORT_DELTA)
-	N(XDP_FEAT_CHANGE)
+	N(XDP_FEAT_CHANGE) N(VRF_MASTER)
 	}
 #undef N
 	return "UNKNOWN_NETDEV_EVENT";
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 5cfc1c939673..67d7c4c949a2 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1328,6 +1328,7 @@ static int arp_netdev_event(struct notifier_block *this, unsigned long event,
 	bool evict_nocarrier;
 
 	switch (event) {
+	case NETDEV_VRF_MASTER:
 	case NETDEV_CHANGEADDR:
 		neigh_changeaddr(&arp_tbl, dev);
 		rt_cache_flush(dev_net(dev));
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 6e1b94796f67..53de7b11e731 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1510,6 +1510,9 @@ static int fib_netdev_event(struct notifier_block *this, unsigned long event, vo
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_VRF_MASTER:
+		fib_disable_ip(dev, event, false);
+		fallthrough;
 	case NETDEV_UP:
 		in_dev_for_each_ifa_rtnl(ifa, in_dev) {
 			fib_add_ifaddr(ifa);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f17a5dd4789f..c1f8c8a3e394 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3677,6 +3677,7 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 
 		run_pending = 1;
 		fallthrough;
+	case NETDEV_VRF_MASTER:
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
 		if (idev && idev->cnf.disable_ipv6)
@@ -3689,7 +3690,10 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 			break;
 		}
 
-		if (event == NETDEV_UP) {
+		if (event == NETDEV_VRF_MASTER)
+			addrconf_ifdown(dev, false);
+
+		if (event == NETDEV_UP || event == NETDEV_VRF_MASTER) {
 			/* restore routes for permanent addresses */
 			addrconf_permanent_addr(net, dev);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 7d5abb3158ec..8db8c34b9108 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1858,6 +1858,7 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 	bool evict_nocarrier;
 
 	switch (event) {
+	case NETDEV_VRF_MASTER:
 	case NETDEV_CHANGEADDR:
 		neigh_changeaddr(&nd_tbl, dev);
 		fib6_run_gc(0, net, false);
-- 
2.50.1


