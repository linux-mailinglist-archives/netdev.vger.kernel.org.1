Return-Path: <netdev+bounces-51594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E57FB4C9
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D804D1C210C9
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744E19BD7;
	Tue, 28 Nov 2023 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noSPwpRH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08206183
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:31 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d7fc4661faso2907576a34.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161430; x=1701766230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yFRtmyS85rV52NQPdd+8lfnrVozuV/vm6n/cbY3XKo=;
        b=noSPwpRH9c4lQqoC70omw1+3FpS4WWtMUDUeEirmbfrpjbS4IdhS9O00AJBb7lxvff
         A6eREzAuaIMfPCwTxVI1VwQsrPAzH4GU97x3PWs2IY/GRHJQVYYhyo5VXLDczS4U0hpB
         QL7lzRven9KoWsFl+DIY3b+/yS49FtUhADQR3GMmPN/ZKbN6owJvvmk+ec8XbjdPWTCw
         79G6jtVcb4PLh/a/OsUlBTqwyPJKl+3XD6G2fTm7aaV0iwmG9MNZdts0eDcCsDYqfsJx
         5ksRj+mvQlZWZgb2K2xuBOtJubIRBK3eETqunVT/1jMi5Rg4y36BkpV342w4qmli1HP1
         zRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161430; x=1701766230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yFRtmyS85rV52NQPdd+8lfnrVozuV/vm6n/cbY3XKo=;
        b=X1DYGjck1+2xmStcpKDOvjfFFnk1F83JuCBqGaJ3cihFJr8crtoYoUD8yTeV/2Fd5f
         iSqog6ofHF7jehEXZWXSKjOqtz8zpPlfEauppV+225uc79G6SRGRTaftoq/SF+YyJDNg
         lbkro3a70lUTaJ8hlsT5BGVjZr4WSCV+IFc7G4WJF7+kuyFAqsAZAMMv6qhuLpK0lM2n
         /mRvNw64pFP6U0mwmI60ssQ5+rHCbXftmprBfkxzldlbX8RsMKXQAvkfhj7D8+ZNwrMe
         MVh3DsdVow9BXX9f+4Vrj6gzeSy4AEOPYAWl/oP4yvxpbzWoM2plGxnW1dxai+2xq0WE
         oWOA==
X-Gm-Message-State: AOJu0YxfR+8DIvSsf2pZwR7Xf7TA3NqIomre3ZzmIYxyQTuN0LfwNIge
	AYtOr76Y1bjEnF7Cipcoqw0tBj8VYvbSrMPN
X-Google-Smtp-Source: AGHT+IFSTmvyhG+D5w12FwRc0yyh3kqvvD+vyltH7atKLIon/jetNpV6tzqbCKj4vuZd3oZp9/LJXw==
X-Received: by 2002:a05:6870:80c9:b0:1fa:2b53:cbef with SMTP id r9-20020a05687080c900b001fa2b53cbefmr12041263oab.32.1701161429801;
        Tue, 28 Nov 2023 00:50:29 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:29 -0800 (PST)
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
Subject: [PATCHv3 net-next 05/10] docs: bridge: add STP doc
Date: Tue, 28 Nov 2023 16:49:38 +0800
Message-ID: <20231128084943.637091-6-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128084943.637091-1-liuhangbin@gmail.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
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
 Documentation/networking/bridge.rst | 94 +++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 5d6d3c0c15c1..9d07da681bc5 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -38,6 +38,100 @@ Bridge port netlink attributes
 .. kernel-doc:: include/uapi/linux/if_link.h
    :doc: Bridge port enum definition
 
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
+influence network performance, path selection and which bridge becomes the
+Root Bridge.
+
+User space STP helper
+---------------------
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


