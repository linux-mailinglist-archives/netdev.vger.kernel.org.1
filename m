Return-Path: <netdev+bounces-48595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE407EEEB9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4F9EB20AEE
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E867014AAC;
	Fri, 17 Nov 2023 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMN6FlS5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3771BCC
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2802c41b716so1562705a91.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213536; x=1700818336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDbV4TqVpQY3WWJc+DEqiCW2ek6jh/ijW23lPWhz1m0=;
        b=aMN6FlS5BHAXiXyoGpt13fFgS5XghRRcZGLl+RKjAj925aflh0daXkJESPU8DRH9JT
         v8Pz91OAWwD4SVS+SIOXrV2e7OBbxW8vdu50IlB6Z6PKe/SYAm3IkA7xyB+Md0A42S5K
         O+OwgJwz5OnreJvVsMFPjpsft5WY96VPTHd/J9q5adUwjc4Vcmotbrh2l24YcbluwFLD
         Q0AJNbmjih2zjulfEJKCiMv415fJohki70puwH0/C8mcH3AiYt9IweKrQbZAX4IGM24i
         hBYwQnIhKNgmbIWqwxkXmdPtl9pEJQnF31VHDW3Ojds9SS81LjdRxNFoBvmpbvVP0NJk
         9Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213536; x=1700818336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDbV4TqVpQY3WWJc+DEqiCW2ek6jh/ijW23lPWhz1m0=;
        b=sk/v3xmtYTOosENWDvGnH5UHlCtWX7wj1+rcPBHZQckR43lqq0o9qkz902KWiV0ygQ
         bcFVYYs0hezy5k1yFc7TwFBfTcrC6+WJKIphRUiJKfM882gJg0y/fQd5v7q1SZOD6dco
         PU4oR0fOHuM8MHXfsmzPMQ365StDa2AYXJYd5Ku5xgGUcY9Sn/GLkLS2apYidegDxXZA
         AiuFJTQqedJUJC+eAg4G5QWUN6GeYwrXMVP13+yQW4HBNhhz1bFK8R8f1czX2L+CKWJl
         UxhpE4dD6GEpfLf9IrEucM2HR3I14zcWvhH4v9xDriDKlLxeqnLly6Y+unbrqYz39B+x
         rUbw==
X-Gm-Message-State: AOJu0Yz5cTQbiHJaSZuxYgZUW0e1XryGHO3HA0OwjboL6dFVzXXTs5C4
	yssNNtJRIA5y7RAdyFrtZTCMNqizZeLjWZdM
X-Google-Smtp-Source: AGHT+IGnvuPcFevZ2lxOJb+Pr0AtVrczInfnz12JkDQKnMqINvXIZhbsgm/QHng1irnRi8dCfAwJdw==
X-Received: by 2002:a17:90a:195b:b0:280:4c36:5feb with SMTP id 27-20020a17090a195b00b002804c365febmr16525702pjh.17.1700213535846;
        Fri, 17 Nov 2023 01:32:15 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:15 -0800 (PST)
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
Subject: [PATCH net-next 05/10] docs: bridge: add STP doc
Date: Fri, 17 Nov 2023 17:31:40 +0800
Message-ID: <20231117093145.1563511-6-liuhangbin@gmail.com>
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


