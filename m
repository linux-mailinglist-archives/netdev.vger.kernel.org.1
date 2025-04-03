Return-Path: <netdev+bounces-179078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF99A7A7D7
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979731887C87
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122D2512C7;
	Thu,  3 Apr 2025 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1ZhJjcG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C1E1A23BA
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697335; cv=none; b=ePD2Q8a8vmSgeE3GkFbOmPC7EI3MEhIO5vwGM/w5cnmAKdS9WrzlfswWXo5aD6zZYEMHLH0X2KcSDJiDVokVa23Qryu8bHrjwAyEX02Ck80AAi9fYVZTs9Udu0MCzi7QxRqAQ9hAKPM54IuWMrg8Uainxi7utsgDisAHDfSVly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697335; c=relaxed/simple;
	bh=tXnsV3mUN0wVSlraXDzI/9Dzjaw+JaiWTsN7w8G+VqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwXxl1a0n7N4HadTHKeoZyTRdYZJQ1Px1KEtBlGjvLRU8qtSPeEg/Xq/AO3UE9sfxnStsfOY9GMct9wCIaven1ATL8ofMdt/ZpIQpjT2YHdBRQZFJBLRdYEzvy/eBVrmNprdJaMJATGUUFH3W2vNTh4XpOjsO9L1koLQQrgpKgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1ZhJjcG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de12bso16871215ad.2
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743697332; x=1744302132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3GV0JOKexzEoVhEuF0ABk0n64KAUncmRtUJF6G+2pL8=;
        b=Z1ZhJjcGkL/gukMB/3YgWkTsKE1/bUZDpKmR7xrc2bSpjozeeIv+QSFqzy/9pfDlEu
         /ssVdY+W63TtzvrXIe/K8XP4gDj6d+ubRsjW4XaJFCHrcFLJllf55X+Zn50WCdrVz8Uu
         6ntJEgR0Np3oXsZCB3LDm5UcEjAIpj0o7qDpQn1O0GvVqIvdewC17yRjAecsyq/7ZZzE
         zYyZUcthY4s3epGay9SxzIkTvK6oqBXPEPu3B5H8aCO6rPzpN/qma8GCREu2kWwo2qDd
         JA6ACWuw5kg7Lg+UtW9QGLBmBPMJzPzWZx1Y2QoxYALabmKVH3LB13jKKNZjdpFVsgXi
         lxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743697332; x=1744302132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GV0JOKexzEoVhEuF0ABk0n64KAUncmRtUJF6G+2pL8=;
        b=GIo+2YCwEBg5oXGkLH95b6H+H2mrJuayPwjLRcOp0wR2NMpcwXqCVbtAsGNPwfL4Ci
         fNRsXJUl8bvP9+Ly2FdPnZh2Yd7Q48fIoEG6Cqw7eBZYfibaBi5IzMfEvNv4IzsxQXMd
         OmdAshbkrWiwBzl6oDTZdJTSFXj7i2qRhVyXRJf8t3VYkUCDRfDjqoR9S1YIRM6e57m3
         +8qCprqz/63W3+GzVraaPH+Jo2XeI/sZO1Bwtit2IG1OCXGMELwdAO6y/xufCMmpXMkj
         ngag/q7qQ6C6U5Ljys/AGHGy1lDkE3elxl+gsHgU/L//3vX13/nxyMM25DMvaXS9FUf7
         9qIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6SR80uB/A6pDalL+MAcfJ0TtqBtS0ay795LwoWFTTzSADOh5GMfk6Db4uBRdSk346edlF8Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySickorwDlMXJB/pp0by7ExlXqBy3sFXh6S9L3pmSYNqOIdloI
	qR/hJ8NgE1exPkv1KHwApXX63wUKxsOyLXPV68BwRuSG6U75BAI=
X-Gm-Gg: ASbGncukfcPqdToWF9XSO227k0fCHG6ANDoaKHFCyaW2s6R6KXRjzI+wdUeQCrFNV7l
	SzLzN22t8gH7Md39LvouNgmdlLS4CSKAmNlTbFnva+A1HvWMIo/SIwu9hM1Q6lPEUvpRLtT1MMu
	EAzzaqJcLP/Vv+rZvGBK05qh6oZ2lWtO94NGJtOwJ31habq7+5bMuEZc+c5WcBKVACn2rS/gYoZ
	166fIjNoB00iGJhoyn/TCfWZfV+o70Ru+AHtqgwqk+jsXrJr2V72VcW+jDbFSPR9Qv7NU+i1k9O
	wz8O2tFSCOJAbTeoy2/JRzxsVnvrL0JSlJtobSKHoqYB
X-Google-Smtp-Source: AGHT+IFJ6i4agO3m3pmVpsBU38vPI8DM2Bh9QKufZugMK2vofsayHm07eJuyYCcqpZZm9O1svRQSSA==
X-Received: by 2002:a17:903:166d:b0:220:e023:8fa6 with SMTP id d9443c01a7336-22977dff077mr48696125ad.50.1743697332445;
        Thu, 03 Apr 2025 09:22:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22978771c6csm16530275ad.213.2025.04.03.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:22:11 -0700 (PDT)
Date: Thu, 3 Apr 2025 09:22:11 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: another netdev instance lock bug in ipv6_add_dev
Message-ID: <Z-61sxcLSA6z9eoy@mini-arch>
References: <aac073de8beec3e531c86c101b274d434741c28e.camel@nvidia.com>
 <Z-3GVgPJHZSyxfaI@mini-arch>
 <c4b1397ffa83c73dfdab6bcbce51e564592e18c8.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4b1397ffa83c73dfdab6bcbce51e564592e18c8.camel@nvidia.com>

On 04/03, Cosmin Ratiu wrote:
> On Wed, 2025-04-02 at 16:20 -0700, Stanislav Fomichev wrote:
> > On 04/02, Cosmin Ratiu wrote:
> > > Hi,
> > > 
> > > Not sure if it's reported already, but I encountered a bug while
> > > testing with the new locking scheme.
> > > This is the call trace:
> > > 
> > > [ 3454.975672] WARNING: CPU: 1 PID: 58237 at
> > > ./include/net/netdev_lock.h:54 ipv6_add_dev+0x370/0x620
> > > [ 3455.008776]  ? ipv6_add_dev+0x370/0x620
> > > [ 3455.010097]  ipv6_find_idev+0x96/0xe0
> > > [ 3455.010725]  addrconf_add_dev+0x1e/0xa0
> > > [ 3455.011382]  addrconf_init_auto_addrs+0xb0/0x720
> > > [ 3455.013537]  addrconf_notify+0x35f/0x8d0
> > > [ 3455.014214]  notifier_call_chain+0x38/0xf0
> > > [ 3455.014903]  netdev_state_change+0x65/0x90
> > > [ 3455.015586]  linkwatch_do_dev+0x5a/0x70
> > > [ 3455.016238]  rtnl_getlink+0x241/0x3e0
> > > [ 3455.019046]  rtnetlink_rcv_msg+0x177/0x5e0
> > > 
> > > The call chain is rtnl_getlink -> linkwatch_sync_dev ->
> > > linkwatch_do_dev -> netdev_state_change -> ...
> > > 
> > > Nothing on this path acquires the netdev lock, resulting in a
> > > warning.
> > > Perhaps rtnl_getlink should acquire it, in addition to the RTNL
> > > already
> > > held by rtnetlink_rcv_msg?
> > > 
> > > The same thing can be seen from the regular linkwatch wq:
> > > 
> > > [ 3456.637014] WARNING: CPU: 16 PID: 83257 at
> > > ./include/net/netdev_lock.h:54 ipv6_add_dev+0x370/0x620
> > > [ 3456.655305] Call Trace:
> > > [ 3456.655610]  <TASK>
> > > [ 3456.655890]  ? __warn+0x89/0x1b0
> > > [ 3456.656261]  ? ipv6_add_dev+0x370/0x620
> > > [ 3456.660039]  ipv6_find_idev+0x96/0xe0
> > > [ 3456.660445]  addrconf_add_dev+0x1e/0xa0
> > > [ 3456.660861]  addrconf_init_auto_addrs+0xb0/0x720
> > > [ 3456.661803]  addrconf_notify+0x35f/0x8d0
> > > [ 3456.662236]  notifier_call_chain+0x38/0xf0
> > > [ 3456.662676]  netdev_state_change+0x65/0x90
> > > [ 3456.663112]  linkwatch_do_dev+0x5a/0x70
> > > [ 3456.663529]  __linkwatch_run_queue+0xeb/0x200
> > > [ 3456.663990]  linkwatch_event+0x21/0x30
> > > [ 3456.664399]  process_one_work+0x211/0x610
> > > [ 3456.664828]  worker_thread+0x1cc/0x380
> > > [ 3456.665691]  kthread+0xf4/0x210
> > > 
> > > In this case, __linkwatch_run_queue seems like a good place to grab
> > > a
> > > device lock before calling linkwatch_do_dev.
> > 
> > Thanks for the report! What about linkwatch_sync_dev in
> > netdev_run_todo
> > and carrier_show? Should probably also need to be wrapped?
> 
> Done, here's the patch I'm testing with which works for all tests I
> could get my hands on. Will you officially propose it (maybe in a
> slightly different form) please?

I'm thinking maybe we should push down the locking a bit? To the
level of netdev_state_change. Since, in theory, every NETDEV_CHANGE
can reach addrconf_notify. I was playing with the patch below,
but I think the ethtool will lockup, so I need to fix that at least...
Let me spend a bit more time today chasing down the callers...

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9fb03a292817..f5a322b63e37 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4975,6 +4975,7 @@ void dev_set_rx_mode(struct net_device *dev);
 int dev_set_promiscuity(struct net_device *dev, int inc);
 int netif_set_allmulti(struct net_device *dev, int inc, bool notify);
 int dev_set_allmulti(struct net_device *dev, int inc);
+void netif_state_change(struct net_device *dev);
 void netdev_state_change(struct net_device *dev);
 void __netdev_notify_peers(struct net_device *dev);
 void netdev_notify_peers(struct net_device *dev);
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index ccaaf4c7d5f6..ea39dd23a197 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -240,6 +240,6 @@ rtnl_notify_needed(const struct net *net, u16 nlflags, u32 group)
 	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, group);
 }
 
-void netdev_set_operstate(struct net_device *dev, int newstate);
+void netif_set_operstate(struct net_device *dev, int newstate);
 
 #endif	/* __LINUX_RTNETLINK_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index 87cba93fa59f..d4a5c07a0d73 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1567,15 +1567,7 @@ void netdev_features_change(struct net_device *dev)
 }
 EXPORT_SYMBOL(netdev_features_change);
 
-/**
- *	netdev_state_change - device changes state
- *	@dev: device to cause notification
- *
- *	Called to indicate a device has changed state. This function calls
- *	the notifier chains for netdev_chain and sends a NEWLINK message
- *	to the routing socket.
- */
-void netdev_state_change(struct net_device *dev)
+void netif_state_change(struct net_device *dev)
 {
 	if (dev->flags & IFF_UP) {
 		struct netdev_notifier_change_info change_info = {
@@ -1587,7 +1579,6 @@ void netdev_state_change(struct net_device *dev)
 		rtmsg_ifinfo(RTM_NEWLINK, dev, 0, GFP_KERNEL, 0, NULL);
 	}
 }
-EXPORT_SYMBOL(netdev_state_change);
 
 /**
  * __netdev_notify_peers - notify network peers about existence of @dev,
diff --git a/net/core/dev_api.c b/net/core/dev_api.c
index 90bafb0b1b8c..6c6ca15ef2a3 100644
--- a/net/core/dev_api.c
+++ b/net/core/dev_api.c
@@ -327,3 +327,19 @@ int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_xdp_propagate);
+
+/**
+ *	netdev_state_change - device changes state
+ *	@dev: device to cause notification
+ *
+ *	Called to indicate a device has changed state. This function calls
+ *	the notifier chains for netdev_chain and sends a NEWLINK message
+ *	to the routing socket.
+ */
+void netdev_state_change(struct net_device *dev)
+{
+	netdev_lock_ops(dev);
+	netif_state_change(dev);
+	netdev_unlock_ops(dev);
+}
+EXPORT_SYMBOL(netdev_state_change);
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 72e522a68775..c442bf52dbaf 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -20,11 +20,11 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	switch (cmd) {
 	case NETDEV_REGISTER:
 	case NETDEV_UP:
+	case NETDEV_CHANGE:
 		netdev_ops_assert_locked(dev);
 		fallthrough;
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
-	case NETDEV_CHANGE:
 	case NETDEV_UNREGISTER:
 	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGEADDR:
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c23852835050..d8d03ff87a3b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1043,7 +1043,7 @@ int rtnl_put_cacheinfo(struct sk_buff *skb, struct dst_entry *dst, u32 id,
 }
 EXPORT_SYMBOL_GPL(rtnl_put_cacheinfo);
 
-void netdev_set_operstate(struct net_device *dev, int newstate)
+void netif_set_operstate(struct net_device *dev, int newstate)
 {
 	unsigned int old = READ_ONCE(dev->operstate);
 
@@ -1052,9 +1052,9 @@ void netdev_set_operstate(struct net_device *dev, int newstate)
 			return;
 	} while (!try_cmpxchg(&dev->operstate, &old, newstate));
 
-	netdev_state_change(dev);
+	netif_state_change(dev);
 }
-EXPORT_SYMBOL(netdev_set_operstate);
+EXPORT_SYMBOL(netif_set_operstate);
 
 static void set_operstate(struct net_device *dev, unsigned char transition)
 {
@@ -1080,7 +1080,7 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 		break;
 	}
 
-	netdev_set_operstate(dev, operstate);
+	netif_set_operstate(dev, operstate);
 }
 
 static unsigned int rtnl_dev_get_flags(const struct net_device *dev)
@@ -3396,7 +3396,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 errout:
 	if (status & DO_SETLINK_MODIFIED) {
 		if ((status & DO_SETLINK_NOTIFY) == DO_SETLINK_NOTIFY)
-			netdev_state_change(dev);
+			netif_state_change(dev);
 
 		if (err < 0)
 			net_warn_ratelimited("A link change request failed with some changes committed already. Interface %s may have been left with an inconsistent configuration, please check.\n",
@@ -3676,8 +3676,11 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 				nla_len(tb[IFLA_BROADCAST]));
 	if (tb[IFLA_TXQLEN])
 		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
-	if (tb[IFLA_OPERSTATE])
+	if (tb[IFLA_OPERSTATE]) {
+		netdev_lock_ops(dev);
 		set_operstate(dev, nla_get_u8(tb[IFLA_OPERSTATE]));
+		netdev_unlock_ops(dev);
+	}
 	if (tb[IFLA_LINKMODE])
 		dev->link_mode = nla_get_u8(tb[IFLA_LINKMODE]);
 	if (tb[IFLA_GROUP])
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 439cfb7ad5d1..1b1b700ec05e 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -33,14 +33,14 @@ static void hsr_set_operstate(struct hsr_port *master, bool has_carrier)
 	struct net_device *dev = master->dev;
 
 	if (!is_admin_up(dev)) {
-		netdev_set_operstate(dev, IF_OPER_DOWN);
+		netif_set_operstate(dev, IF_OPER_DOWN);
 		return;
 	}
 
 	if (has_carrier)
-		netdev_set_operstate(dev, IF_OPER_UP);
+		netif_set_operstate(dev, IF_OPER_UP);
 	else
-		netdev_set_operstate(dev, IF_OPER_LOWERLAYERDOWN);
+		netif_set_operstate(dev, IF_OPER_LOWERLAYERDOWN);
 }
 
 static bool hsr_check_carrier(struct hsr_port *master)

