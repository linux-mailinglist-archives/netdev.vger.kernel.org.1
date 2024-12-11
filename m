Return-Path: <netdev+bounces-150929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE59EC208
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D83167803
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FDA2A1CA;
	Wed, 11 Dec 2024 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="f8kXMY5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f229.google.com (mail-lj1-f229.google.com [209.85.208.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C344F9EC
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883574; cv=none; b=B/hPiUuHM2MG9sWIGW6GA3RBb1/W6mXT1Iq4thx9sArFVGClPJf+HTmv5HGpMdQtLBKhltl+mmwjMHITTv9c2qMBFAdqs9eDW+rLVpkqIWxoybCKAnYjM+1F3tJZGowDQmIjEpOabsm43JyXXku5solivkiiQkDFL0pUrM/xIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883574; c=relaxed/simple;
	bh=0smaCCZmfj6apClKQeBrc0YpGP2im63jvigixq0XRis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TTCQzNV2lU7e5kv5sddL7U4vDh3DC/AHHfvu4aPwRvw78NJNhyZHIuFsCcTeoLe1X026SZzSeVNGW1DBG1inG+mb4KohXDsvn7nqXsWu9QSmQhIH9ohzoYpD6i4chNOZ7fFldEAHFbfutbRk+3nvC56/xHCZYtbdCP2SVnbwJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=f8kXMY5O; arc=none smtp.client-ip=209.85.208.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f229.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so32831241fa.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1733883571; x=1734488371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MlJn08BiyJ2oNnmUwD/srfrXvDoUOP+ZCuf0+5Ldr1M=;
        b=f8kXMY5O5kHS25La6hY2i9Fqe1P2LTvZtvc0Kny2OPRxI0oo2qfJ28GWjJtKgY6nmK
         fAtilxMDb4nXNSpxZeTfFdyp8xT49zumSPz1Wfa6jFV8kOgqhJbtTAHUxiD66pWot0M3
         0rXr2VaKUEcFIK4Vx/J3c6u6k9k7AOXyc0TUGOpFcU1h9IEOC6k7K6E8VH8rDF6bqVMc
         sZQD1vyTlOdBzSCNBxJoirnE+Up8cClcUegIPErH+hmjc8ikTpdUFTHHoKNJb/VAXzS4
         45M/ILSkEhasU/r2dW0HR/aBmH/NTUF6ZEuuUFZb0c3k7eoVnf4vvLLyFfOQq79yLEXi
         w7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733883571; x=1734488371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MlJn08BiyJ2oNnmUwD/srfrXvDoUOP+ZCuf0+5Ldr1M=;
        b=a65AM7HYCzOMiRaXRI27c0gp0Khfw3DYgxsjZsZX2mzby7EPmBsuLtJOJg52/kc4MY
         jkX6Fhh2Evfdo7RMjE25u8uI2qfXuoNKwtESrcyNxyKGxSIYRczUctj709+yGfhtLSMy
         izmoVVzjqI743qwAuRpDtkyKN8OwNjVIn8m9DxO/3I6aSQlkejGItM3K+9IXF2ojkzTc
         Sni0zMzdVLTpqzrtqYVnp0BmQ++w6sv2c7XfBRpWxZnGaoV/Zyeyz3VQMc2LLXUHDuvw
         B/thQcew0fDDVltgTyyysM9/jC5QA6jOzO11Mz5VtbiqQc5faH7NB5ROmub9jG1atihV
         dG4g==
X-Gm-Message-State: AOJu0Yy1/iD1JeBG6OwxDxgTpZAwvnlRjhqCNwCLT8xzj9jPCm3TNsto
	p31k6bzFzVWhFdh+d6sSxyu2hEr7wt8T39HzLxHSGWzg5OLhSGODIsJP2H44/kGXnJh1AvhQpjO
	k9YiOwlk5tp5WEiMSMpJV5O2D1uqucCqa+/hrAxxDgtbSi9tR
X-Gm-Gg: ASbGncuPqHT/mn71YbzLHHHGwSc1gZUyQUEAcqpwOLwtZyLf5n8Wqw9AjSo8V6umXii
	maxUPvQ4WWSM4i3fVUP3gs+XgriCzJef7p3Pm1O8jb+q3Jp7fk9RutGZ1hwlhiWkaLrwit15Wte
	3BHWiSoRlPLvmTIqAlDFXwoOADASgcDsVtWEf8p88faOYkQo1cUAs5jVXixWCNf4PQXL0N/hlAP
	avFS7Vp1R//7JJKlAKbn7VJkZ0CwuxIjD1u9KnuloeTDUgpjkxkVmp52eJ5F5TEL/xGyYMS2A==
X-Google-Smtp-Source: AGHT+IHQkEBsY9DLZk8MaS0MLHBKwTsGqgnZn54D7Qc00VuZYG+qHsBZRN/0BHwF9WwjHFMT/9CETDCwftDA
X-Received: by 2002:a05:6512:3d0e:b0:53e:3a73:ce5a with SMTP id 2adb3069b0e04-5402a60c2bamr277819e87.56.1733883570366;
        Tue, 10 Dec 2024 18:19:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-54021c78d45sm182991e87.87.2024.12.10.18.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 18:19:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8544C3401BC;
	Tue, 10 Dec 2024 19:19:28 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 707BBE55EEC; Tue, 10 Dec 2024 19:19:28 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
To: Breno Leitao <leitao@debian.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH] netconsole: allow selection of egress interface via MAC address
Date: Tue, 10 Dec 2024 19:18:52 -0700
Message-Id: <20241211021851.1442842-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, netconsole has two methods of configuration - kernel command
line parameter and configfs. The former interface allows for netconsole
activation earlier during boot, so it is preferred for debugging issues
which arise before userspace is up/the configfs interface can be used.
The kernel command line parameter syntax requires specifying the egress
interface name. This requirement makes it hard to use for a couple
reasons:
- The egress interface name can be hard or impossible to predict. For
  example, installing a new network card in a system can change the
  interface names assigned by the kernel.
- When constructing the kernel parameter, one may have trouble
  determining the original (kernel-assigned) name of the interface
  (which is the name that should be given to netconsole) if some stable
  interface naming scheme is in effect. A human can usually look at
  kernel logs to determine the original name, but this is very painful
  if automation is constructing the parameter.

For these reasons, allow selection of the egress interface via MAC
address. To maintain parity between interfaces, the local_mac entry in
configfs is also made read-write and can be used to select the local
interface, though this use case is less interesting than the one
highlighted above.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 Documentation/networking/netconsole.rst |  8 +++-
 drivers/net/netconsole.c                | 50 +++++++++++++++++++++----
 include/linux/netpoll.h                 |  7 ++++
 net/core/netpoll.c                      | 49 +++++++++++++++++++-----
 4 files changed, 94 insertions(+), 20 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index d55c2a22ec7a..c2e269dc8d75 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -45,7 +45,7 @@ following format::
 	r             if present, prepend kernel version (release) to the message
 	src-port      source for UDP packets (defaults to 6665)
 	src-ip        source IP to use (interface address)
-	dev           network interface (eth0)
+	dev           network interface name (eth0) or MAC address
 	tgt-port      port for logging agent (6666)
 	tgt-ip        IP address for logging agent
 	tgt-macaddr   ethernet MAC address for logging agent (broadcast)
@@ -62,6 +62,10 @@ or using IPv6::
 
  insmod netconsole netconsole=@/,@fd00:1:2:3::1/
 
+or using a MAC address to select the egress interface::
+
+   linux netconsole=4444@10.0.0.1/ab:cd:ef:12:34:56,9353@10.0.0.2/12:34:56:78:9a:bc
+
 It also supports logging to multiple remote agents by specifying
 parameters for the multiple agents separated by semicolons and the
 complete string enclosed in "quotes", thusly::
@@ -133,7 +137,7 @@ The interface exposes these parameters of a netconsole target to userspace:
 	remote_port	Remote agent's UDP port			(read-write)
 	local_ip	Source IP address to use		(read-write)
 	remote_ip	Remote agent's IP address		(read-write)
-	local_mac	Local interface's MAC address		(read-only)
+	local_mac	Local interface's MAC address		(read-write)
 	remote_mac	Remote agent's MAC address		(read-write)
 	==============  =================================       ============
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4ea44a2f48f7..865c43a97f70 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -113,7 +113,7 @@ static struct console netconsole_ext;
  *		remote_port	(read-write)
  *		local_ip	(read-write)
  *		remote_ip	(read-write)
- *		local_mac	(read-only)
+ *		local_mac	(read-write)
  *		remote_mac	(read-write)
  */
 struct netconsole_target {
@@ -211,6 +211,8 @@ static struct netconsole_target *alloc_and_init(void)
 
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
+	/* the "don't use" or N/A value for this field */
+	eth_broadcast_addr(nt->np.local_mac);
 	nt->np.local_port = 6665;
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
@@ -360,10 +362,7 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
 {
-	struct net_device *dev = to_target(item)->np.dev;
-	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
-
-	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
+	return sysfs_emit(buf, "%pM\n", to_target(item)->np.local_mac);
 }
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)
@@ -511,11 +510,41 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 
 	strscpy(nt->np.dev_name, buf, IFNAMSIZ);
 	trim_newline(nt->np.dev_name, IFNAMSIZ);
+	/* the "don't use" or N/A value for this field */
+	eth_broadcast_addr(nt->np.local_mac);
 
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return strnlen(buf, count);
 }
 
+static ssize_t local_mac_store(struct config_item *item, const char *buf,
+			       size_t count)
+{
+	struct netconsole_target *nt = to_target(item);
+	u8 local_mac[ETH_ALEN];
+	ssize_t ret = -EINVAL;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	if (nt->enabled) {
+		pr_err("target (%s) is enabled, disable to update parameters\n",
+		       config_item_name(&nt->group.cg_item));
+		goto out_unlock;
+	}
+
+	if (!mac_pton(buf, local_mac))
+		goto out_unlock;
+	if (buf[3 * ETH_ALEN - 1] && buf[3 * ETH_ALEN - 1] != '\n')
+		goto out_unlock;
+	memcpy(nt->np.local_mac, local_mac, ETH_ALEN);
+	/* force use of local_mac for device lookup */
+	nt->np.dev_name[0] = '\0';
+
+	ret = strnlen(buf, count);
+out_unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
 static ssize_t local_port_store(struct config_item *item, const char *buf,
 		size_t count)
 {
@@ -839,7 +868,7 @@ CONFIGFS_ATTR(, local_port);
 CONFIGFS_ATTR(, remote_port);
 CONFIGFS_ATTR(, local_ip);
 CONFIGFS_ATTR(, remote_ip);
-CONFIGFS_ATTR_RO(, local_mac);
+CONFIGFS_ATTR(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
 CONFIGFS_ATTR(, release);
 
@@ -1001,8 +1030,9 @@ static int netconsole_netdev_event(struct notifier_block *this,
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	bool stopped = false;
 
-	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
+	if (!(event == NETDEV_CHANGENAME || event == NETDEV_CHANGEADDR ||
+	      event == NETDEV_UNREGISTER || event == NETDEV_RELEASE ||
+	      event == NETDEV_JOIN))
 		goto done;
 
 	mutex_lock(&target_cleanup_list_lock);
@@ -1014,6 +1044,10 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_CHANGENAME:
 				strscpy(nt->np.dev_name, dev->name, IFNAMSIZ);
 				break;
+			case NETDEV_CHANGEADDR:
+				memcpy(nt->np.local_mac, dev->dev_addr,
+				       ETH_ALEN);
+				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b34301650c47..e5cdb4d40f13 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -25,7 +25,14 @@ union inet_addr {
 struct netpoll {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	/*
+	 * Either dev_name or local_mac can be used to specify the local
+	 * interface - dev_name will be used if it is nonempty, else
+	 * local_mac is used. Once netpoll_setup returns successfully,
+	 * both fields are populated.
+	 */
 	char dev_name[IFNAMSIZ];
+	u8 local_mac[ETH_ALEN];
 	const char *name;
 
 	union inet_addr local_ip, remote_ip;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 2e459b9d88eb..485093387b9f 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -501,7 +501,8 @@ void netpoll_print_options(struct netpoll *np)
 		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
 	else
 		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
-	np_info(np, "interface '%s'\n", np->dev_name);
+	np_info(np, "interface name '%s'\n", np->dev_name);
+	np_info(np, "local ethernet address '%pM'\n", np->local_mac);
 	np_info(np, "remote port %d\n", np->remote_port);
 	if (np->ipv6)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
@@ -570,11 +571,20 @@ int netpoll_parse_options(struct netpoll *np, char *opt)
 	cur++;
 
 	if (*cur != ',') {
-		/* parse out dev name */
+		/* parse out dev_name or local_mac */
 		if ((delim = strchr(cur, ',')) == NULL)
 			goto parse_failed;
 		*delim = 0;
-		strscpy(np->dev_name, cur, sizeof(np->dev_name));
+		if (!strchr(cur, ':')) {
+			strscpy(np->dev_name, cur, sizeof(np->dev_name));
+			eth_broadcast_addr(np->local_mac);
+		} else {
+			if (!mac_pton(cur, np->local_mac)) {
+				goto parse_failed;
+			}
+			/* force use of local_mac for device lookup */
+			np->dev_name[0] = '\0';
+		}
 		cur = delim;
 	}
 	cur++;
@@ -660,6 +670,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 	np->dev = ndev;
 	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
+	memcpy(np->local_mac, ndev->dev_addr, ETH_ALEN);
 	npinfo->netpoll = np;
 
 	/* last thing to do is link it to the net device structure */
@@ -674,29 +685,46 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
+/* upper bound on length of %pM output */
+#define MAX_MAC_ADDR_LEN (4 * ETH_ALEN)
+
+static char *local_dev(struct netpoll *np, char *buf)
+{
+	if (np->dev_name[0]) {
+		return np->dev_name;
+	}
+
+	snprintf(buf, MAX_MAC_ADDR_LEN, "%pM", np->local_mac);
+	return buf;
+}
+
 int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
 	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
+	char buf[MAX_MAC_ADDR_LEN];
 
 	skb_queue_head_init(&np->skb_pool);
 
 	rtnl_lock();
+	struct net *net = current->nsproxy->net_ns;
 	if (np->dev_name[0]) {
-		struct net *net = current->nsproxy->net_ns;
 		ndev = __dev_get_by_name(net, np->dev_name);
+	} else if (is_valid_ether_addr(np->local_mac)) {
+		ndev = dev_getbyhwaddr_rcu(net, ARPHRD_ETHER, np->local_mac);
 	}
 	if (!ndev) {
-		np_err(np, "%s doesn't exist, aborting\n", np->dev_name);
+		np_err(np, "%s doesn't exist, aborting\n", local_dev(np, buf));
 		err = -ENODEV;
 		goto unlock;
 	}
 	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
 
 	if (netdev_master_upper_dev_get(ndev)) {
-		np_err(np, "%s is a slave device, aborting\n", np->dev_name);
+		np_err(np, "%s is a slave device, aborting\n",
+		       local_dev(np, buf));
 		err = -EBUSY;
 		goto put;
 	}
@@ -704,7 +732,8 @@ int netpoll_setup(struct netpoll *np)
 	if (!netif_running(ndev)) {
 		unsigned long atmost;
 
-		np_info(np, "device %s not up yet, forcing it\n", np->dev_name);
+		np_info(np, "device %s not up yet, forcing it\n",
+			local_dev(np, buf));
 
 		err = dev_open(ndev, NULL);
 
@@ -738,7 +767,7 @@ int netpoll_setup(struct netpoll *np)
 			if (!ifa) {
 put_noaddr:
 				np_err(np, "no IP address for %s, aborting\n",
-				       np->dev_name);
+				       local_dev(np, buf));
 				err = -EDESTADDRREQ;
 				goto put;
 			}
@@ -769,13 +798,13 @@ int netpoll_setup(struct netpoll *np)
 			}
 			if (err) {
 				np_err(np, "no IPv6 address for %s, aborting\n",
-				       np->dev_name);
+				       local_dev(np, buf));
 				goto put;
 			} else
 				np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
 #else
 			np_err(np, "IPv6 is not supported %s, aborting\n",
-			       np->dev_name);
+			       local_dev(np, buf));
 			err = -EINVAL;
 			goto put;
 #endif
-- 
2.34.1


