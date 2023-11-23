Return-Path: <netdev+bounces-50535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD27F60AF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD771C21141
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF025745;
	Thu, 23 Nov 2023 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxbYqfCR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E793C1
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:25 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28396255b81so715171a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747184; x=1701351984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjIpsKXI3OC/NrpW4LsyvsWGhqOOR0eezUm9Sj+X5y0=;
        b=BxbYqfCRsAQMhwZ3udraeXOubsMlUi8O4/7cA3unHpK+kHUOoaXjT53c+rzxy2RJ7L
         oePMGEiYijsY8EN4GGB3FIw7sh0lhnnr5i11PGPrkTLLGuAh9A827WMt5y6wax6jvzmC
         zl25BksbYe+0EgoMkYzDxSwwQlfuU5ydUqUo9aDXnqm8ojiWGOmqw7S+ozkdHoyGS6gC
         6/tR0b3rqqFz59idgXEQQrR65PmCywBV7sHlsl92Lhlkaay9pUjxgymIuVyTqsQTc0Ld
         LHooP73JTMzquqy8KDCvtFzY03WXbQzk6kVVtTb0wXRjr3wfxv95saDYsAHomzFjY0Hy
         Qieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747184; x=1701351984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjIpsKXI3OC/NrpW4LsyvsWGhqOOR0eezUm9Sj+X5y0=;
        b=iI7Z3XJzaOgroklGBrjyPVgwXSuuh6AL37maLOrWLPfeqqqZC+fGtPwUDw9wvG3/ib
         Rmt24lpbBnJsNgyQaztdYCpzaaufUjX0VP5OeUfa8T0HE3ESNFt9BimdJQI+umexOulO
         +uC3rTmZYc8u6NnjE0oB6ZpckEc7oWl9gHgcomI0eux75nYK/S9rMw6mwHaFTfZCGWTM
         K3zEZht+vpB6k2PDRG++FQ3QO5OeexLk61Gyi2aOCUcS4zGZ+RSycRTzywrCamg8yMbA
         ZpYP+pLK0VzkRyBlioRL2rXk03LNlhwMyPxOk8Yln+qc4xUq6sWsgBX0/kc+pnYFYlC3
         Hwlw==
X-Gm-Message-State: AOJu0Yz7jGGfaJicjuMQerX5gQyRZwoknXmf0ZEjWCDsbTNmMWB8XltG
	6EzGflNjjwbDnybG/3uEz1TIOspcFCTErhUi
X-Google-Smtp-Source: AGHT+IGxLjVBl4F5xMDn8ReYmVb8L9MW2/nQFxvN4j9ZsYpaKHjSugCkq4tpjFdJ+ay0k2qQHOn8Bg==
X-Received: by 2002:a17:90b:4a45:b0:281:554d:b318 with SMTP id lb5-20020a17090b4a4500b00281554db318mr5242203pjb.39.1700747183883;
        Thu, 23 Nov 2023 05:46:23 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:23 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Date: Thu, 23 Nov 2023 21:45:47 +0800
Message-ID: <20231123134553.3394290-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123134553.3394290-1-liuhangbin@gmail.com>
References: <20231123134553.3394290-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bridge kernel doc is too old. It only pointed to the
linuxfoundation wiki page which lacks of the new features.

Here let's start the new bridge document and put all the bridge info
so new developers and users could catch up the last bridge status soon.

First, add kAPI/uAPI and FAQ fields. These 2 fields are only examples and
more APIs need to be added in future.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 84 +++++++++++++++++++++++++----
 net/bridge/br_private.h             |  2 +
 2 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c859f3c1636e..84aae94f6598 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -4,18 +4,82 @@
 Ethernet Bridging
 =================
 
-In order to use the Ethernet bridging functionality, you'll need the
-userspace tools.
+Introduction
+============
 
-Documentation for Linux bridging is on:
-   https://wiki.linuxfoundation.org/networking/bridge
+A bridge is a way to connect multiple Ethernet segments together in a protocol
+independent way. Packets are forwarded based on Layer 2 destination Ethernet
+address, rather than IP address (like a router). Since forwarding is done
+at Layer 2, all Layer 3 protocols can pass through a bridge transparently.
 
-The bridge-utilities are maintained at:
-   git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
+Bridge kAPI
+===========
 
-Additionally, the iproute2 utilities can be used to configure
-bridge devices.
+Here are some core structures of bridge code.
 
-If you still have questions, don't hesitate to post to the mailing list 
-(more info https://lists.linux-foundation.org/mailman/listinfo/bridge).
+.. kernel-doc:: net/bridge/br_private.h
+   :identifiers: net_bridge_vlan
 
+Bridge uAPI
+===========
+
+Modern Linux bridge uAPI is accessed via Netlink interface. You can find
+below files where the bridge and bridge port netlink attributes are defined.
+
+Bridge netlink attributes
+-------------------------
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: Bridge enum definition
+
+Bridge port netlink attributes
+------------------------------
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: Bridge port enum definition
+
+Bridge sysfs
+------------
+
+All sysfs attributes are also exported via the bridge netlink API.
+You can find each attribute explanation based on the correspond netlink
+attribute.
+
+NOTE: the sysfs interface is deprecated and should not be extended if new
+options are added.
+
+.. kernel-doc:: net/bridge/br_sysfs_br.c
+   :doc: Bridge sysfs attributes
+
+FAQ
+===
+
+What does a bridge do?
+----------------------
+
+A bridge transparently forwards traffic between multiple network interfaces.
+In plain English this means that a bridge connects two or more physical
+Ethernet networks, to form one larger (logical) Ethernet network.
+
+Is it L3 protocol independent?
+------------------------------
+
+Yes. The bridge sees all frames, but it *uses* only L2 headers/information.
+As such, the bridging functionality is protocol independent, and there should
+be no trouble forwarding IPX, NetBEUI, IP, IPv6, etc.
+
+Contact Info
+============
+
+The code is currently maintained by Roopa Prabhu <roopa@nvidia.com> and
+Nikolay Aleksandrov <razor@blackwall.org>. Bridge bugs and enhancements
+are discussed on the linux-netdev mailing list netdev@vger.kernel.org and
+bridge@lists.linux-foundation.org.
+
+The list is open to anyone interested: http://vger.kernel.org/vger-lists.html#netdev
+
+External Links
+==============
+
+The old Documentation for Linux bridging is on:
+https://wiki.linuxfoundation.org/networking/bridge
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6b7f36769d03..051ea81864ac 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -186,6 +186,7 @@ enum {
  * struct net_bridge_vlan - per-vlan entry
  *
  * @vnode: rhashtable member
+ * @tnode: rhashtable member
  * @vid: VLAN id
  * @flags: bridge vlan flags
  * @priv_flags: private (in-kernel) bridge vlan flags
@@ -196,6 +197,7 @@ enum {
  * @refcnt: if MASTER flag set, this is bumped for each port referencing it
  * @brvlan: if MASTER flag unset, this points to the global per-VLAN context
  *          for this VLAN entry
+ * @tinfo: bridge tunnel info
  * @br_mcast_ctx: if MASTER flag set, this is the global vlan multicast context
  * @port_mcast_ctx: if MASTER flag unset, this is the per-port/vlan multicast
  *                  context
-- 
2.41.0


