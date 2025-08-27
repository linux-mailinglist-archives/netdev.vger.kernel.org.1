Return-Path: <netdev+bounces-217235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71973B37EE1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 11:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8EA1737ED
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB932874FB;
	Wed, 27 Aug 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPOibS6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D40C283159
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287215; cv=none; b=mfObhVs2FW7Ohre0z4jHxpHDLj1k4VLPPbW6MUOyX8l1Jfv6YGmiVs5ymFl492nX/aDGFUi0GVboIWvrUNfd4WliPgV2Gyp9DpfG1e/ldtfNIMqmFCVr3jW+307EjGgmyh6D54TxESarGdcDfwbTIJvC+2ZHfFY/YuRRMC7oQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287215; c=relaxed/simple;
	bh=7an/2ktEuPQHrlB+W75/xb842bdixhsTGW3sP8EVgmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtHqb9jrjX+RcSgJ6d7z0oX+kig2je832NcUgsaaH/TUkd4D2d0OKb16OVGO8MbIRsPvxfOdv92w7YCfsEOwPPpNST4C/TzI7ZrorcXkk4sur7ZAqzSx7rSYcnukbnnE90QUKE89Eo/yLZ/gsSMoAEruMDppOkgh2S5JHsghv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPOibS6c; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47174beb13so4482693a12.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756287213; x=1756892013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bErEWuvQIkgq/XgiicHBE7SGEkwqsC2WhxhBJn4Bpyc=;
        b=dPOibS6cFoj477OhOlDFgWGp5tDSdbZvibg5aHEPQdeBexmO4pShMWsa5ofroImIBz
         QYVhIq5h7l253xHtrRFu9Q2MsNNFjTFj/F93/x2WHcAPUDAEjdpsaOdlABoVkTfq49Lc
         mLiRJM0EtF8EZdN4XMCl1vpivDUaf/Ywkf4K8MHmE7yvwuP0xnDL5aWRxCuvWku8BDxK
         dkEHvwXpKxcrYfiBVRlEd8Gz7w2oRjoqbcWU8LuZtNdRkW72AcNIRjG4RKcMnZl3D/bp
         hGjG3Krn1bq22IcbJWCyhyiih7NdjR5KwGLSZEAPplS9rElVjz2+GfUTHaTG1nsqAnCT
         L+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287213; x=1756892013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bErEWuvQIkgq/XgiicHBE7SGEkwqsC2WhxhBJn4Bpyc=;
        b=Sd4wtqMlRK69TILZ974fXXQ6nG4wbKHdaMf0PdPC+hV/prsOGgLAyoWc2y1Z+qOQrU
         mG0UAk2NTid6QnT4FMO9Rnrj8erIeCCO+Kq+ZDZT1H0B0kcbuKSsi6hsTfuI3DFnMdK9
         qpllGcGuv1fIphOrKjEtPKT0EHgcoITanEGDuGh2GMCc4YuwjJmYPHVUDXl+6Ik9i/RB
         Mq0qkwTIJO1/kyXV8EzaOPaaY3B4gnIldERX/IIpwssISMhU3IvpwpcMdsZ8T0080M5C
         zbcm+mbX42TD4C9t2XoJm2WuWdHvpVqYLWRR0KNTTsapTfEWYdtSa257p8IjHbntY6tF
         jOmQ==
X-Gm-Message-State: AOJu0Yzl2DBaLJCa/7mg3frY46Ny/Ig7ttduo3Oyk9wU4nvelKE9fi8t
	hxueuYj46YW8i6v2oy29va5cSB5+B5iOpi6oqeN2VaLZvfBncQBqu6F2mEHCL5w7HWc=
X-Gm-Gg: ASbGncsB8A8qNCGoWzWcLQw9ceDLSbrJ6VqwqNlLCYScHqkGJGPtNQ6SVaomXjMU2MS
	rEqTKpFYug0/gG35bzXrcIYXFdwtQJGOUIUDDEkgWCAsjbDUADMgchxpHEBVuFeRtRLrHkkov9a
	ZWSc57O+tm5g3YTflG0fomYPOyazQu2Ww8dnfUFVIFVxfraUGhpIIKNvTNB9th88fMvWxryKnlo
	/mI2fdOq/Zr2BeuGgtUPLItwsrmmAR4IMf0FnyttPu/r38iXs1wGk3jFLT7uVxHdcCyzgrjcfzD
	uWN9bA/w0wmImOps9V4u3h6GfSrggevoW70iXXPHHzEBCxE3UBGprxyexz2LxxgK5gp2N0ur7rf
	9i9tFp9ag3xAC8oYnwJE0wV5QQ7uQK4ib4aAeWdIk/g==
X-Google-Smtp-Source: AGHT+IFIR4wFp6cXlLQ04AGy5XCWW++WlsW/cGskb7HZfkuxg3r5XU/Rv9L0nB7DyvAtpNJpyKMAIw==
X-Received: by 2002:a17:903:1b44:b0:246:931e:4db4 with SMTP id d9443c01a7336-246931e5571mr188318365ad.45.1756287213251;
        Wed, 27 Aug 2025 02:33:33 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a06esm117062255ad.31.2025.08.27.02.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 02:33:32 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net] hsr: use proper locking when iterating over ports
Date: Wed, 27 Aug 2025 09:33:23 +0000
Message-ID: <20250827093323.432414-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_for_each_port is called in many places without holding the RCU read
lock, this may trigger warnings on debug kernels like:

  [   40.457015] [  T201] WARNING: suspicious RCU usage
  [   40.457020] [  T201] 6.17.0-rc2-virtme #1 Not tainted
  [   40.457025] [  T201] -----------------------------
  [   40.457029] [  T201] net/hsr/hsr_main.c:137 RCU-list traversed in non-reader section!!
  [   40.457036] [  T201]
                          other info that might help us debug this:

  [   40.457040] [  T201]
                          rcu_scheduler_active = 2, debug_locks = 1
  [   40.457045] [  T201] 2 locks held by ip/201:
  [   40.457050] [  T201]  #0: ffffffff93040a40 (&ops->srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0xf2/0x280
  [   40.457080] [  T201]  #1: ffffffff92e7f968 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x5e1/0xb20
  [   40.457102] [  T201]
                          stack backtrace:
  [   40.457108] [  T201] CPU: 2 UID: 0 PID: 201 Comm: ip Not tainted 6.17.0-rc2-virtme #1 PREEMPT(full)
  [   40.457114] [  T201] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  [   40.457117] [  T201] Call Trace:
  [   40.457120] [  T201]  <TASK>
  [   40.457126] [  T201]  dump_stack_lvl+0x6f/0xb0
  [   40.457136] [  T201]  lockdep_rcu_suspicious.cold+0x4f/0xb1
  [   40.457148] [  T201]  hsr_port_get_hsr+0xfe/0x140
  [   40.457158] [  T201]  hsr_add_port+0x192/0x940
  [   40.457167] [  T201]  ? __pfx_hsr_add_port+0x10/0x10
  [   40.457176] [  T201]  ? lockdep_init_map_type+0x5c/0x270
  [   40.457189] [  T201]  hsr_dev_finalize+0x4bc/0xbf0
  [   40.457204] [  T201]  hsr_newlink+0x3c3/0x8f0
  [   40.457212] [  T201]  ? __pfx_hsr_newlink+0x10/0x10
  [   40.457222] [  T201]  ? rtnl_create_link+0x173/0xe40
  [   40.457233] [  T201]  rtnl_newlink_create+0x2cf/0x750
  [   40.457243] [  T201]  ? __pfx_rtnl_newlink_create+0x10/0x10
  [   40.457247] [  T201]  ? __dev_get_by_name+0x12/0x50
  [   40.457252] [  T201]  ? rtnl_dev_get+0xac/0x140
  [   40.457259] [  T201]  ? __pfx_rtnl_dev_get+0x10/0x10
  [   40.457285] [  T201]  __rtnl_newlink+0x22c/0xa50
  [   40.457305] [  T201]  rtnl_newlink+0x637/0xb20

Adding rcu_read_lock() for all hsr_for_each_port() looks confusing.

Introduce a new helper, hsr_for_each_port_rtnl(), that assumes the
RTNL lock is held. This allows callers in suitable contexts to iterate
ports safely without explicit RCU locking.

Other code paths that rely on RCU protection continue to use
hsr_for_each_port() with rcu_read_lock().

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

v2: check rtnl lock for net_device_ops (Kuniyuki Iwashima)
    hold rcu read lock in timer function (Kuniyuki Iwashima)

---
 net/hsr/hsr_device.c  | 24 ++++++++++++++----------
 net/hsr/hsr_main.c    | 12 ++++++++++--
 net/hsr/hsr_main.h    |  3 +++
 net/hsr/hsr_netlink.c |  4 ----
 4 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 88657255fec1..c7d2419abecd 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -49,7 +49,7 @@ static bool hsr_check_carrier(struct hsr_port *master)
 
 	ASSERT_RTNL();
 
-	hsr_for_each_port(master->hsr, port) {
+	hsr_for_each_port_rtnl(master->hsr, port) {
 		if (port->type != HSR_PT_MASTER && is_slave_up(port->dev)) {
 			netif_carrier_on(master->dev);
 			return true;
@@ -105,7 +105,7 @@ int hsr_get_max_mtu(struct hsr_priv *hsr)
 	struct hsr_port *port;
 
 	mtu_max = ETH_DATA_LEN;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type != HSR_PT_MASTER)
 			mtu_max = min(port->dev->mtu, mtu_max);
 
@@ -139,7 +139,7 @@ static int hsr_dev_open(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -172,7 +172,7 @@ static int hsr_dev_close(struct net_device *dev)
 	struct hsr_priv *hsr;
 
 	hsr = netdev_priv(dev);
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -205,7 +205,7 @@ static netdev_features_t hsr_features_recompute(struct hsr_priv *hsr,
 	 * may become enabled.
 	 */
 	features &= ~NETIF_F_ONE_FOR_ALL;
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		features = netdev_increment_features(features,
 						     port->dev->features,
 						     mask);
@@ -484,7 +484,7 @@ static void hsr_set_rx_mode(struct net_device *dev)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -506,7 +506,7 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER)
 			continue;
 		switch (port->type) {
@@ -534,7 +534,7 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		if (port->type == HSR_PT_MASTER ||
 		    port->type == HSR_PT_INTERLINK)
 			continue;
@@ -580,7 +580,7 @@ static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
 
 	hsr = netdev_priv(dev);
 
-	hsr_for_each_port(hsr, port) {
+	hsr_for_each_port_rtnl(hsr, port) {
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
 		case HSR_PT_SLAVE_B:
@@ -672,9 +672,13 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
 	struct hsr_priv *hsr = netdev_priv(ndev);
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type == pt)
+		if (port->type == pt) {
+			rcu_read_unlock();
 			return port->dev;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 EXPORT_SYMBOL(hsr_get_port_ndev);
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index 192893c3f2ec..eec6e20a8494 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -22,9 +22,13 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
 {
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type != HSR_PT_MASTER)
+		if (port->type != HSR_PT_MASTER) {
+			rcu_read_unlock();
 			return false;
+		}
+	rcu_read_unlock();
 	return true;
 }
 
@@ -134,9 +138,13 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
 {
 	struct hsr_port *port;
 
+	rcu_read_lock();
 	hsr_for_each_port(hsr, port)
-		if (port->type == pt)
+		if (port->type == pt) {
+			rcu_read_unlock();
 			return port;
+		}
+	rcu_read_unlock();
 	return NULL;
 }
 
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index 135ec5fce019..33b0d2460c9b 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -224,6 +224,9 @@ struct hsr_priv {
 #define hsr_for_each_port(hsr, port) \
 	list_for_each_entry_rcu((port), &(hsr)->ports, port_list)
 
+#define hsr_for_each_port_rtnl(hsr, port) \
+	list_for_each_entry_rcu((port), &(hsr)->ports, port_list, lockdep_rtnl_is_held())
+
 struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt);
 
 /* Caller must ensure skb is a valid HSR frame */
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b120470246cc..f57c289e2322 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -241,10 +241,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 	kfree_skb(skb);
 
 fail:
-	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_warn(master->dev, "Could not send HSR ring error message\n");
-	rcu_read_unlock();
 }
 
 /* This is called when we haven't heard from the node with MAC address addr for
@@ -278,10 +276,8 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	kfree_skb(skb);
 
 fail:
-	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	netdev_warn(master->dev, "Could not send HSR node down\n");
-	rcu_read_unlock();
 }
 
 /* HSR_C_GET_NODE_STATUS lets userspace query the internal HSR node table
-- 
2.50.1


