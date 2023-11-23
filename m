Return-Path: <netdev+bounces-50536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 429867F60B0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D661C2115C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC51225579;
	Thu, 23 Nov 2023 13:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5w1wGAR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30A3F9
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:29 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c2066accc5so628160a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747189; x=1701351989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDbV4TqVpQY3WWJc+DEqiCW2ek6jh/ijW23lPWhz1m0=;
        b=F5w1wGARnk8pK8thL+m6BvHAsSb4L39tqnGXCOkT/2OopZQ39nbAVblzKSZ1iUkd81
         QyUSuoFgVDqoc0hX6BsZ739FJwximEy0/PzLCUwf8KbAtKTkNB/9eR4pDKnlvq6J83v/
         4P5ykSDLBVjde+x/ehLg3N2LNu0ldhtBCtQsjrv8mn34DzhNqXkrnlzkkX/Qr5HorJ2n
         xbTPuLZVRPI7t4Pklv6Cg+rAY4S7Rz7/S+fEROkJoEkdwW0wwYBcL/PLLOxGbfnzgiPS
         DhXvxKIBVYtAgVvbK8+hxdoFC52OimO0MgelLy8fgsITy0MHpHyB1EHH5YcAXpdQonSl
         pv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747189; x=1701351989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDbV4TqVpQY3WWJc+DEqiCW2ek6jh/ijW23lPWhz1m0=;
        b=DM9cmgqZ0dIHfI8ni33odmLsc116ToauaGxnC5NX76OOFP/CEn61vPwsx48/U9CDMS
         ENk598XjycbKtb7+5oRd+WWOthXdxL6E4aV4p+cFuzhsnieurgO5VSQxCjqNL5FF29US
         JFBiicRKS/TWta3K8uzQt5LhW5JwQF2m0qUdJYjn/aM423nPRhq6qdMRIEFmFfnnlMTc
         gvwiI6ri5XjLGYyKlZJOKyRUWlw+kN5jE2aLnzdRQycXa+kRks8IdlcD9ZSOYsetCyRV
         C88GmbBVnwIDqYnGjgRj+U32LOEk3BFWF43YEc0t2U7gSnsDEdie9U5lqnJaP7ZyBs7s
         KkIw==
X-Gm-Message-State: AOJu0Yx9wkuahoUVX3Zz6Cg9Lxt3X8f0R53T+AA5PFycnNCgjGQz3BZ2
	94j2wKUQ1557P7wMsdVMvK8vhoyOx81d/zqe
X-Google-Smtp-Source: AGHT+IGp2UvAqedWM1WdpELsQ15s9O5ug8vy4pnoOSAQLb/+ttVFrHjRKSJmBrbKzuCjZkj2PDZ0sg==
X-Received: by 2002:a17:90a:1951:b0:280:a01a:906a with SMTP id 17-20020a17090a195100b00280a01a906amr5687128pjh.5.1700747188919;
        Thu, 23 Nov 2023 05:46:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:28 -0800 (PST)
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
Subject: [PATCHv2 net-next 05/10] docs: bridge: add STP doc
Date: Thu, 23 Nov 2023 21:45:48 +0800
Message-ID: <20231123134553.3394290-6-liuhangbin@gmail.com>
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

Add STP part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 85 +++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 84aae94f6598..1fd339e48129 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -51,6 +51,91 @@ options are added.
 .. kernel-doc:: net/bridge/br_sysfs_br.c
    :doc: Bridge sysfs attributes
 
+STP
+===
+
+The STP (Spanning Tree Protocol) implementation in the Linux bridge driver
+is a critical feature that helps prevent loops and broadcast storms in
+Ethernet networks by identifying and disabling redundant links. In a Linux
+bridge context, STP is crucial for network stability and availability.
+
+STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
+model. It was originally developed as IEEE 802.1D and has since evolved into
+multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
+`Multiple Spanning Tree Protocol (MSTP)
+<https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/>`_.
+
+Bridge Ports and STP States
+---------------------------
+
+In the context of STP, bridge ports can be in one of the following states:
+  * Blocking: The port is disabled for data traffic and only listens for
+    BPDUs (Bridge Protocol Data Units) from other devices to determine the
+    network topology.
+  * Listening: The port begins to participate in the STP process and listens
+    for BPDUs.
+  * Learning: The port continues to listen for BPDUs and begins to learn MAC
+    addresses from incoming frames but does not forward data frames.
+  * Forwarding: The port is fully operational and forwards both BPDUs and
+    data frames.
+  * Disabled: The port is administratively disabled and does not participate
+    in the STP process. The data frames forwarding are also disabled.
+
+Root Bridge and Convergence
+---------------------------
+
+In the context of networking and Ethernet bridging in Linux, the root bridge
+is a designated switch in a bridged network that serves as a reference point
+for the spanning tree algorithm to create a loop-free topology.
+
+Here's how the STP works and root bridge is chosen:
+  1. Bridge Priority: Each bridge running a spanning tree protocol, has a
+     configurable Bridge Priority value. The lower the value, the higher the
+     priority. By default, the Bridge Priority is set to a standard value
+     (e.g., 32768).
+  2. Bridge ID: The Bridge ID is composed of two components: Bridge Priority
+     and the MAC address of the bridge. It uniquely identifies each bridge
+     in the network. The Bridge ID is used to compare the priorities of
+     different bridges.
+  3. Bridge Election: When the network starts, all bridges initially assume
+     that they are the root bridge. They start advertising Bridge Protocol
+     Data Units (BPDU) to their neighbors, containing their Bridge ID and
+     other information.
+  4. BPDU Comparison: Bridges exchange BPDUs to determine the root bridge.
+     Each bridge examines the received BPDUs, including the Bridge Priority
+     and Bridge ID, to determine if it should adjust its own priorities.
+     The bridge with the lowest Bridge ID will become the root bridge.
+  5. Root Bridge Announcement: Once the root bridge is determined, it sends
+     BPDUs with information about the root bridge to all other bridges in the
+     network. This information is used by other bridges to calculate the
+     shortest path to the root bridge and, in doing so, create a loop-free
+     topology.
+  6. Forwarding Ports: After the root bridge is selected and the spanning tree
+     topology is established, each bridge determines which of its ports should
+     be in the forwarding state (used for data traffic) and which should be in
+     the blocking state (used to prevent loops). The root bridge's ports are
+     all in the forwarding state. while other bridges have some ports in the
+     blocking state to avoid loops.
+  7. Root Ports: After the root bridge is selected and the spanning tree
+     topology is established, each non-root bridge processes incoming
+     BPDUs and determines which of its ports provides the shortest path to the
+     root bridge based on the information in the received BPDUs. This port is
+     designated as the root port. And it is in the Forwarding state, allowing
+     it to actively forward network traffic.
+  8. Designated ports: A designated port is the port through which the non-root
+     bridge will forward traffic towards the designated segment. Designated ports
+     are placed in the Forwarding state. All other ports on the non-root
+     bridge that are not designated for specific segments are placed in the
+     Blocking state to prevent network loops.
+
+STP ensures network convergence by calculating the shortest path and disabling
+redundant links. When network topology changes occur (e.g., a link failure),
+STP recalculates the network topology to restore connectivity while avoiding loops.
+
+Proper configuration of STP parameters, such as the bridge priority, can
+influence which bridge becomes the Root Bridge. Careful configuration can
+optimize network performance and path selection.
+
 FAQ
 ===
 
-- 
2.41.0


