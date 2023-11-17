Return-Path: <netdev+bounces-48594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8C7EEEB8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E9F1C20A6A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF4F13FEA;
	Fri, 17 Nov 2023 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDZLZ3E9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2919A2
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2839b922c18so195442a91.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213531; x=1700818331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjIpsKXI3OC/NrpW4LsyvsWGhqOOR0eezUm9Sj+X5y0=;
        b=IDZLZ3E9Voab8/NafORENu8/nATaztuxLARXPO2B0xvWQ6h+n4noSTMqi4w8fTfulP
         1C042LpZ01Vhz2ZjLqmFeTVrIjRpGCFbhoVb15+TOsz0ZRo5/QFBYK7jQT1k8L376oS8
         yFVhW9coYNEtCh0Lr8kqFcRTBco20n0PoBmkuBpdevc7256T/kx6Z3XLf4fI2rGoXdn+
         4KStN7LQ3K+Ck/ZDaEo5MPFpK6ou34nPueeHyq/4Jap2zJRlJRxqkCeM38355358OArm
         YFZN1e4dO70Vy5pn08QvUWCb2HAvYpmQUcflLYwMRDUxZONK6U1Dr04AfxI55JIInNqv
         D0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213531; x=1700818331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjIpsKXI3OC/NrpW4LsyvsWGhqOOR0eezUm9Sj+X5y0=;
        b=iGrh7SnxRUgmsaLePsbLonI8V+8NoCOuFw31nf508lCgVJkDY7PKQvVj9Rv6RHSvP8
         /4SG/Ag7I/PHVE7DMxyC9ta9GQ18A+h1NrGAiPWS588vb5VbkkMnE2n+sn0Rb+EYLqJU
         VJb2B0hwpplzrbfY/4vIoch2sl5R5NiQz4U+WHN7FQsnLFDASMmI2I+qPkJ3Q9LFvAgn
         2W49C7dtAb9Ar8P44dsWCoX2yjjAtX6VcAkTkueTjnM9RXJzfcSptCimLgiNMx1QWcXw
         Jc1McowCz9E0ef20bBeMcrQuE8fUN4c3/Rag1WpQkpy60ddPdibvTOPi749kTfNwXHRZ
         dPmw==
X-Gm-Message-State: AOJu0Yz/JJZj3x9z8ASiDkbG06xexHG4udjyw/THpaAE1yy6Sz4iCi24
	1KpOt9l4OSSJHqcpuEM36H+LqD4fJdF4/01V
X-Google-Smtp-Source: AGHT+IGC71Jgs0Nhjh4lsdtwcFOo9Aa/aqAR6fW6DPkOMTfO+eQHCzO6VVtdOJxVbUoAUlWTcOwaxw==
X-Received: by 2002:a17:90b:1a91:b0:27d:166b:40f6 with SMTP id ng17-20020a17090b1a9100b0027d166b40f6mr16460136pjb.41.1700213531458;
        Fri, 17 Nov 2023 01:32:11 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:10 -0800 (PST)
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
Subject: [PATCH net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Date: Fri, 17 Nov 2023 17:31:39 +0800
Message-ID: <20231117093145.1563511-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117093145.1563511-1-liuhangbin@gmail.com>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
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


