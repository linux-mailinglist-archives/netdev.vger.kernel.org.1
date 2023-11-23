Return-Path: <netdev+bounces-50537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EAA7F60B1
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9F7281F09
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB325744;
	Thu, 23 Nov 2023 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNuAS/y4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DCBD42
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:35 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-285196aaecaso791703a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747194; x=1701351994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8oUo9C5xcva8KJDqQvql+tezZAPIpLAGnaZWqMceG4=;
        b=gNuAS/y4XC+na0ZFB3qxdRz7dItiF7DvI5ePNxOlvB6L/6Sm0nP/WLyu/IJbbfFW3a
         xyBjwZaislCQkA0+r6Bag1XZ+xp3R57tqIzbguNQ6QPg6Kvx2TLxSLVroTahm5MjcSoM
         0keyf7g245SAk5tFyENJ+23mUZa5TDifjMjMm567jUA45wqVzcrMeoOFLjhWvxldNmWU
         McLUle6zN9wxzsZQEJfIq/FKNqLm+7cqRVwkKNW6rV0h2yQIrY1GDPWIpi2XalQDGQm9
         KnscLCCirmgYV8uLOEuZ7caA241krQC1GBhzjtWByVB4/DQoB7wRUt5ULLVK2hFaO+dO
         P5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747194; x=1701351994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8oUo9C5xcva8KJDqQvql+tezZAPIpLAGnaZWqMceG4=;
        b=GZegClyc5sa4xvtO5SVToZF8hAvEvzO5Ag2UjQ6zazfOi0sXgs4+jgiq0gd05eq2yh
         GIDy9MeAUkkj187xWD4SzyTbzWJ9OeHNFPBPt8/Sj0a+JrENlUQuVqNPKvY6sroRhXSu
         O0VggkTsRj+GGqb7aKrvIX39xWCD4MQqWSh49b0gjXqtGuRgmrZwUncIH7Yj+EkhUt87
         /ZWhlcshNfUlVlR6IfTPmzK5QBJg2B18icHfgHmTzYdIU2i01RTlWsRIdQmOary3g3G5
         2RIJtkuc2jkL7sjbmWFoUlzxppwHRGdzNg8pd6iUNUly6CyGulFaBy3fHfRFTD7jpOaF
         YdQQ==
X-Gm-Message-State: AOJu0Yw6RIATrlD0BrTOs8hri7BQVP9tadjXd5nj1PRWSwUOuyW3mTyW
	F426S8rAqXZQxOjuP//jwhPpt1jpK0fZzscy
X-Google-Smtp-Source: AGHT+IEJq5XWKbHo8kngvVlJ8lzWLbh5bOpr1TRYMiCURJJEvv4ijK+Yecb6Hve0+Yzf0UQO8gliRQ==
X-Received: by 2002:a17:90a:c:b0:283:2612:714a with SMTP id 12-20020a17090a000c00b002832612714amr5205177pja.36.1700747193759;
        Thu, 23 Nov 2023 05:46:33 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:33 -0800 (PST)
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
Subject: [PATCHv2 net-next 06/10] docs: bridge: add VLAN doc
Date: Thu, 23 Nov 2023 21:45:49 +0800
Message-ID: <20231123134553.3394290-7-liuhangbin@gmail.com>
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

Add VLAN part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 1fd339e48129..f70f42ab7396 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -136,6 +136,35 @@ Proper configuration of STP parameters, such as the bridge priority, can
 influence which bridge becomes the Root Bridge. Careful configuration can
 optimize network performance and path selection.
 
+VLAN
+====
+
+A LAN (Local Area Network) is a network that covers a small geographic area,
+typically within a single building or a campus. LANs are used to connect
+computers, servers, printers, and other networked devices within a localized
+area. LANs can be wired (using Ethernet cables) or wireless (using Wi-Fi).
+
+A VLAN (Virtual Local Area Network) is a logical segmentation of a physical
+network into multiple isolated broadcast domains. VLANs are used to divide
+a single physical LAN into multiple virtual LANs, allowing different groups of
+devices to communicate as if they were on separate physical networks.
+
+Typically there are two VLAN implementations, IEEE 802.1Q and IEEE 802.1ad
+(also known as QinQ). IEEE 802.1Q is a standard for VLAN tagging in Ethernet
+networks. It allows network administrators to create logical VLANs on a
+physical network and tag Ethernet frames with VLAN information, which is
+called *VLAN-tagged frames*. IEEE 802.1ad, commonly known as QinQ or Double
+VLAN, is an extension of the IEEE 802.1Q standard. QinQ allows for the
+stacking of multiple VLAN tags within a single Ethernet frame. The Linux
+bridge supports both the IEEE 802.1Q and `802.1AD
+<https://lore.kernel.org/netdev/1402401565-15423-1-git-send-email-makita.toshiaki@lab.ntt.co.jp/>`_
+protocol for VLAN tagging.
+
+`VLAN filtering <https://lore.kernel.org/netdev/1360792820-14116-1-git-send-email-vyasevic@redhat.com/>`_
+on a bridge is disabled by default. After enabling VLAN filtering on a bridge,
+it will start forwarding frames to appropriate destinations based on their
+destination MAC address and VLAN tag (both must match).
+
 FAQ
 ===
 
-- 
2.41.0


