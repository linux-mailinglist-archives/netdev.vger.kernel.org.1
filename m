Return-Path: <netdev+bounces-163365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C44A2A00E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513B9165F53
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796722236EA;
	Thu,  6 Feb 2025 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SJbC8piE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD5722257D
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819298; cv=none; b=EwV77OuwDZtIpPYnweiY950bdfhCyTGFX8fufMAOOs2Eu9JyRj6NOWa4xJtMvgIrP6O7HNR/MnOTGYYTinFMn049WvKRjUO1/+f9q7HOZ7nOFFcviwAkkXswVMOj2nsO1Nwpv3vcqCPeR2vRcpLYlLm5hxgzpZd8SWLD8SutrWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819298; c=relaxed/simple;
	bh=BroGEX3nunAdikjx03Lrr0TXP2Y+6z/r/wQ8/CLIkPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2Q6x7PHRzC6zl0biFORw/htBlsKhYJip0sOyZcwOsdYa5/676/qK5U2XZwCwqXHMbUPTyyJfGBWmyAgss2yoZvkiJ16dHHftf/boAqflRm6LMDbr97a6T2Kp8l1egALPVTeSw5Mfgi2EMrFIYv69ANyXbF2u+T+vrIKfuG2GDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SJbC8piE; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-ab771575040so70455466b.1
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 21:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1738819293; x=1739424093; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otzVsN1NW+U9mK3ObL5P0pr2UFgS62iOxxgXBwBSQ+o=;
        b=SJbC8piEB6uYrqUfMLXlOPryFjaiRBfK/WMMVt2NkpFkue2aiGeoPrd0Dagr5g1DAR
         L+rRPC+7PFtdkXYMMvaodEhEOhMpxo1KqQ3pzIBU6mi4+yX0HGfnQsuObx710OTMnS0s
         vBsX3l38MuHv4gw8vk4CRR8IapLeQFEVhCxJoAnKFCR/NTkDy4SVWx5qNzVv/lY5Nij+
         Pz04Q/bTpmw4zrg/lI01s6TcQleKiXHZUTRXH/gLjg2tXFVZWD+0YFsWV/D2999jg65H
         RotzVa2vmMpj29MdwEdoZ/XOONV4pQVEDqpFxwE1UdIPOgiCmM27zc0DudkNidL7xr7k
         Fuzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738819293; x=1739424093;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otzVsN1NW+U9mK3ObL5P0pr2UFgS62iOxxgXBwBSQ+o=;
        b=SBgvc7My7LQ2K/faZ9XlcN806+ED32stCK43tTsM3iQEw9Sn5mebOiHYAm4/9Apkp8
         ZXF2JiFe3zkuzehSeLNut+oYv2sfHss6Dywv/9NMBMUVoQfPW81VYHi4uBNeDsh756rz
         ECGpqr1FEtu3UAl2IydR8s2gxCyi7jja58TEeUVT1SVU0Q6bD8n+DZgkYn0rN0Qmhzgk
         L1tsTDqn+AL8A3GjRTwLV31jPB4fFPgb+he4T8aBL7xNfdd6/JKKZuX2RIL9fbr63P5B
         y9m2iegNb0M2IbmTKUOMFVF5syYjnwLqBauRV6ZmlBCf7x7yy4IuAJxG9UKlwDAanj6G
         g//w==
X-Gm-Message-State: AOJu0YwlL2cHKwMb3TVeag89Qfr2Q4xUFbxf8Gj2pvr6lZ2hR5gfvUBD
	WFeMQRYx2NdlZ0xdBg3K+km5fLv4aCKs3sK8uowilbdwUlW+uR65GM0LFL+oD9OoaJUUYWO0BsD
	zmaLSqgtzHUHWJBrbXFp50hdDhtIWUPDb
X-Gm-Gg: ASbGncuRBXB3jPPslU7zkJGvCrO5khcM2iTHCiFMvkzFWcz9qWs8nRFq8OlynRe1pS7
	w+RzDOicBquPmjvV71zkgteP7sBzfrN6A3djCQ9uE7z11kUcmU/qi0k4G6sZme7dI8YVcydH9r9
	foYYn13Ms/XR5RzHu6AyUE2d/o597+2AAQtze6yKphNkAzP8OFnAAHMoJD+IidbHMKc+0U1SoCJ
	p9oQcTRG37lue7Ir5yFAHCfNCP16xJY4VYaNOZlg2diHcXDS6QfjmL3ynJlAjZk9TtBYmKXFVt5
	k32ppfoFFEb8i7DkrswA5O4HsgZJKiOUrXrY0Zk=
X-Google-Smtp-Source: AGHT+IEOeUong+iqEZmE/uaY2diPiB8AmCybH/LMhnwCuyEOfGjLLgOGIi3uenVtSrG1ZH7jt6SIEBI035c5
X-Received: by 2002:a17:907:1c0f:b0:ab6:726e:b14d with SMTP id a640c23a62f3a-ab76e9d8cb5mr212784566b.23.1738819292450;
        Wed, 05 Feb 2025 21:21:32 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-ab77332cb2dsm1017866b.186.2025.02.05.21.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:21:32 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4605634032D;
	Wed,  5 Feb 2025 22:21:31 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3BEC3E55FE0; Wed,  5 Feb 2025 22:21:31 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Date: Wed, 05 Feb 2025 22:21:31 -0700
Subject: [PATCH v3 2/2] netconsole: allow selection of egress interface via
 MAC address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-netconsole-v3-2-132a31f17199@purestorage.com>
References: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
In-Reply-To: <20250205-netconsole-v3-0-132a31f17199@purestorage.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-wireless@vger.kernel.org, linux-doc@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Currently, netconsole has two methods of configuration - module
parameter and configfs. The former interface allows for netconsole
activation earlier during boot (by specifying the module parameter on
the kernel command line), so it is preferred for debugging issues which
arise before userspace is up/the configfs interface can be used. The
module parameter syntax requires specifying the egress interface name.
This requirement makes it hard to use for a couple reasons:
- The egress interface name can be hard or impossible to predict. For
  example, installing a new network card in a system can change the
  interface names assigned by the kernel.
- When constructing the module parameter, one may have trouble
  determining the original (kernel-assigned) name of the interface
  (which is the name that should be given to netconsole) if some stable
  interface naming scheme is in effect. A human can usually look at
  kernel logs to determine the original name, but this is very painful
  if automation is constructing the parameter.

For these reasons, allow selection of the egress interface via MAC
address when configuring netconsole using the module parameter. Update
the netconsole documentation with an example of the new syntax.
Selection of egress interface by MAC address via configfs is far less
interesting (since when this interface can be used, one should be able
to easily convert between MAC address and interface name), so it is left
unimplemented.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
Tested-by: Breno Leitao <leitao@debian.org>
---
 Documentation/networking/netconsole.rst |  6 +++-
 include/linux/netpoll.h                 |  6 ++++
 net/core/netpoll.c                      | 51 +++++++++++++++++++++++++--------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 94c4680fdf3e7e1a0020d11b44547acfd68072a5..90a1bbb52918a0163828f4e96c89781e0bc6856b 100644
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
+   linux netconsole=4444@10.0.0.1/22:33:44:55:66:77,9353@10.0.0.2/12:34:56:78:9a:bc
+
 It also supports logging to multiple remote agents by specifying
 parameters for the multiple agents separated by semicolons and the
 complete string enclosed in "quotes", thusly::
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index f91e50a76efd4b016381c632456397eea1ea877f..1ade65b59be49cfdcf86ed6e938287b949aa9f58 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -25,7 +25,13 @@ union inet_addr {
 struct netpoll {
 	struct net_device *dev;
 	netdevice_tracker dev_tracker;
+	/*
+	 * Either dev_name or dev_mac can be used to specify the local
+	 * interface - dev_name is used if it is a nonempty string, else
+	 * dev_mac is used.
+	 */
 	char dev_name[IFNAMSIZ];
+	u8 dev_mac[ETH_ALEN];
 	const char *name;
 
 	union inet_addr local_ip, remote_ip;
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 62b4041aae1ae8c7dc47c89fb40b14bbd4ad0e0e..327c409b1974b9ecc1e078c78ca090b05c3ca9dd 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -501,7 +501,8 @@ void netpoll_print_options(struct netpoll *np)
 		np_info(np, "local IPv6 address %pI6c\n", &np->local_ip.in6);
 	else
 		np_info(np, "local IPv4 address %pI4\n", &np->local_ip.ip);
-	np_info(np, "interface '%s'\n", np->dev_name);
+	np_info(np, "interface name '%s'\n", np->dev_name);
+	np_info(np, "local ethernet address '%pM'\n", np->dev_mac);
 	np_info(np, "remote port %d\n", np->remote_port);
 	if (np->ipv6)
 		np_info(np, "remote IPv6 address %pI6c\n", &np->remote_ip.in6);
@@ -570,11 +571,18 @@ int netpoll_parse_options(struct netpoll *np, char *opt)
 	cur++;
 
 	if (*cur != ',') {
-		/* parse out dev name */
+		/* parse out dev_name or dev_mac */
 		if ((delim = strchr(cur, ',')) == NULL)
 			goto parse_failed;
 		*delim = 0;
-		strscpy(np->dev_name, cur, sizeof(np->dev_name));
+
+		np->dev_name[0] = '\0';
+		eth_broadcast_addr(np->dev_mac);
+		if (!strchr(cur, ':'))
+			strscpy(np->dev_name, cur, sizeof(np->dev_name));
+		else if (!mac_pton(cur, np->dev_mac))
+			goto parse_failed;
+
 		cur = delim;
 	}
 	cur++;
@@ -679,27 +687,45 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 }
 EXPORT_SYMBOL_GPL(__netpoll_setup);
 
+/*
+ * Returns a pointer to a string representation of the identifier used
+ * to select the egress interface for the given netpoll instance. buf
+ * must be a buffer of length at least MAC_ADDR_STR_LEN + 1.
+ */
+static char *egress_dev(struct netpoll *np, char *buf)
+{
+	if (np->dev_name[0])
+		return np->dev_name;
+
+	snprintf(buf, MAC_ADDR_STR_LEN, "%pM", np->dev_mac);
+	return buf;
+}
+
 int netpoll_setup(struct netpoll *np)
 {
+	struct net *net = current->nsproxy->net_ns;
+	char buf[MAC_ADDR_STR_LEN + 1];
 	struct net_device *ndev = NULL;
 	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
 
 	rtnl_lock();
-	if (np->dev_name[0]) {
-		struct net *net = current->nsproxy->net_ns;
+	if (np->dev_name[0])
 		ndev = __dev_get_by_name(net, np->dev_name);
-	}
+	else if (is_valid_ether_addr(np->dev_mac))
+		ndev = dev_getbyhwaddr_rcu(net, ARPHRD_ETHER, np->dev_mac);
+
 	if (!ndev) {
-		np_err(np, "%s doesn't exist, aborting\n", np->dev_name);
+		np_err(np, "%s doesn't exist, aborting\n", egress_dev(np, buf));
 		err = -ENODEV;
 		goto unlock;
 	}
 	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
 
 	if (netdev_master_upper_dev_get(ndev)) {
-		np_err(np, "%s is a slave device, aborting\n", np->dev_name);
+		np_err(np, "%s is a slave device, aborting\n",
+		       egress_dev(np, buf));
 		err = -EBUSY;
 		goto put;
 	}
@@ -707,7 +733,8 @@ int netpoll_setup(struct netpoll *np)
 	if (!netif_running(ndev)) {
 		unsigned long atmost;
 
-		np_info(np, "device %s not up yet, forcing it\n", np->dev_name);
+		np_info(np, "device %s not up yet, forcing it\n",
+			egress_dev(np, buf));
 
 		err = dev_open(ndev, NULL);
 
@@ -741,7 +768,7 @@ int netpoll_setup(struct netpoll *np)
 			if (!ifa) {
 put_noaddr:
 				np_err(np, "no IP address for %s, aborting\n",
-				       np->dev_name);
+				       egress_dev(np, buf));
 				err = -EDESTADDRREQ;
 				goto put;
 			}
@@ -772,13 +799,13 @@ int netpoll_setup(struct netpoll *np)
 			}
 			if (err) {
 				np_err(np, "no IPv6 address for %s, aborting\n",
-				       np->dev_name);
+				       egress_dev(np, buf));
 				goto put;
 			} else
 				np_info(np, "local IPv6 %pI6c\n", &np->local_ip.in6);
 #else
 			np_err(np, "IPv6 is not supported %s, aborting\n",
-			       np->dev_name);
+			       egress_dev(np, buf));
 			err = -EINVAL;
 			goto put;
 #endif

-- 
2.34.1


