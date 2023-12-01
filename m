Return-Path: <netdev+bounces-52837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0C280055B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3D7B210B6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C118629;
	Fri,  1 Dec 2023 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUSD0RTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971D1170C
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:28 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c628bf8d2eso207541a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418827; x=1702023627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHqwQUgQ8mrgGryY+KexlZG8akRS3/6ltC7LSWSk9iU=;
        b=KUSD0RTGekYwggYea7bCWeiNHYgNef0PJ9nzzi8zpN8UH7czLy73gBtjHMCgdtQg0x
         o9X24d3g8ILnvTPNZtsHLhAM+ZRzwxZVN9eZ9Paed64fiUbLh62sAa3QTeW1w8RsCR6E
         8LoER62FKngICMVwwOwvLCWQd/OmfJfLQSyREE71hXLQUXXYfJzmNHdzaAmEoc3a20bP
         tC6CXpfz2/HMZTSdSVjarB/CaeBPSAC8VmYbYjf6aKRU92SuuQWMHKh7QN21MAD+BCwL
         L4SIRp7TQGKHSBxYGr8JLOf1RxW9UUvyhZKnBG7QxAfWb3nT/65V5mqArzo031GZgSoL
         Suyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418827; x=1702023627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHqwQUgQ8mrgGryY+KexlZG8akRS3/6ltC7LSWSk9iU=;
        b=I26O6Lva/Z8whHV6qk9VYWqLQZ7R0N3HACLgzkEjHCJYlseSBU9HKCmzzbihFEa/Rx
         DQAne7tgJ1EFSEYhqvNX0GISWaNlkWJwRaatQs5VhsrD7LTXTql9ziVL2IfchV9mMtMF
         AHSMy71zJ6JHXFFoAdRlHhQj5qJMgx51rIZLluDVFRJumFKVUero12P8K1OfA/HMLgmd
         rfODsA5akoYHc3wAIIq6rpR6dsh4fjg0gBh7Jar7dPAdbDz+vH+wOu69x61A2J7/sU/l
         T+iOqQuMgz/Bqq3gaBaOLdqeDnMuj6K+9UkImx4mBBszm4PFyy+pNui1uJ8P6ZzRY+2C
         mFJg==
X-Gm-Message-State: AOJu0YxQg/jCXlVIkO/gAy2JK8l/Djowmy6efpp/ohJiFhShNDne54zE
	a4bMoAjwE0XsOPj7+JRdyH9/LxtHZB/t8g==
X-Google-Smtp-Source: AGHT+IGgWPl9o4LKgjADM1AJrtAJgEliOrhiw3ttAwfKXP8vrlGJDuFS9qM5fyNXRhIrPnB3DCzglg==
X-Received: by 2002:a17:90a:bc84:b0:286:2013:cfe9 with SMTP id x4-20020a17090abc8400b002862013cfe9mr10654611pjr.2.1701418827388;
        Fri, 01 Dec 2023 00:20:27 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:26 -0800 (PST)
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
	Hangbin Liu <liuhangbin@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCHv4 net-next 05/10] docs: bridge: add STP doc
Date: Fri,  1 Dec 2023 16:19:45 +0800
Message-ID: <20231201081951.1623069-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201081951.1623069-1-liuhangbin@gmail.com>
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add STP part for bridge document.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 101 ++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index a717563eaa15..c14410008ddf 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -47,6 +47,107 @@ Bridge sysfs
 The sysfs interface is deprecated and should not be extended if new
 options are added.
 
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
+The 802.1D-2004 removed the original Spanning Tree Protocol, instead
+incorporating the Rapid Spanning Tree Protocol (RSTP). By 2014, all the
+functionality defined by IEEE 802.1D has been incorporated into either
+IEEE 802.1Q (Bridges and Bridged Networks) or IEEE 802.1AC (MAC Service
+Definition). 802.1D has been officially withdrawn in 2022.
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
+influence network performance, path selection and which bridge becomes the
+Root Bridge.
+
+User space STP helper
+---------------------
+
+The user space STP helper *bridge-stp* is a program to control whether to use
+user mode spanning tree. The ``/sbin/bridge-stp <bridge> <start|stop>`` is
+called by the kernel when STP is enabled/disabled on a bridge
+(via ``brctl stp <bridge> <on|off>`` or ``ip link set <bridge> type bridge
+stp_state <0|1>``).  The kernel enables user_stp mode if that command returns
+0, or enables kernel_stp mode if that command returns any other value.
+
 FAQ
 ===
 
-- 
2.41.0


