Return-Path: <netdev+bounces-51596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE537FB4CC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B159C1C21086
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DAF1DDCF;
	Tue, 28 Nov 2023 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4efwJ4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19337E7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:40 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4879921b3a.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161439; x=1701766239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND75AnxP9o6edoo6d0k++1k4h8vC8KMUihiX/v8OTos=;
        b=J4efwJ4AGZopp/4qD+seEQzYv7NfWnmaxEg/tWT5U6T7OrRDbeo/92JtgzYzOLwt6n
         49WDUxzDVkZshqQYD9Q8q864qPPCTH5TsI0NDzOE9Vdn6dbHOkB9xFWHMh+N+9fdaEtx
         tIldED9lkrYVnjw50srHSnPt7CTi8eEut/q9sN/GeauO4yaymSU1AOZP1jCl8MgTUx2L
         tYTu49hGnx294/Mf5k1pkBhaLfPV47r3Ss4t+RyzP52lfidZxj7QPXWl3ZnIV0MH6k0+
         4REx6j8yJsI6ykgIVxTQp5VW7VVosYpD8Aj6/Zx8I/8E1nQ3d0wEaartkhxLVyR0VwL1
         eSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161439; x=1701766239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND75AnxP9o6edoo6d0k++1k4h8vC8KMUihiX/v8OTos=;
        b=on3H4DFK/hGXTFjnezTIyXwxcaOzNiGQpiOhjAGuq9QI8Uwmzejy3ZWDbzk0oelT7N
         CqYIPWnGjYZb9fvGxJvtvv/p00hB05NE7xJSnl3oHtKBTLQ/Ji9eYYakJRr84HeYueu1
         XuQ7MUcfMgfdQUHylvZIEW3lG3bKYzYcHazxkdSFvz7JHTulwaAiBnMu0ZEEr7WcO1VO
         aoA4iBDjKTAyEDsndpIpn9g//GTMVuxJh3YxFIoewKUouA9m1ltip9t3xzNzhInG1ND/
         JuhImQCHEhutkkMmNWUEYbiwITbjYH2mLo4/DFqXoUo01wA3otDYqdu7j3lz28XQiNus
         Jy/Q==
X-Gm-Message-State: AOJu0YwXBf4fWSoH6hFUnm3uy+zldhMIbfks6AZTWMI+Sedipau3Sqqp
	vRLJuqBeGDPRcslrEyrQgpdGxf3bWoj00KOR
X-Google-Smtp-Source: AGHT+IEDwdl4H1SNovDrvpQEXVl5l+VHekDEpF015DN0iW9aHqkhuD+NMbHIMclVsligRuJJnY3NJA==
X-Received: by 2002:a05:6a00:8f0c:b0:6cc:298:eb30 with SMTP id ji12-20020a056a008f0c00b006cc0298eb30mr15668799pfb.29.1701161438859;
        Tue, 28 Nov 2023 00:50:38 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:38 -0800 (PST)
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
Subject: [PATCHv3 net-next 07/10] docs: bridge: add multicast doc
Date: Tue, 28 Nov 2023 16:49:40 +0800
Message-ID: <20231128084943.637091-8-liuhangbin@gmail.com>
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

Add multicast part for bridge document.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 55 +++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 764d44c93c65..956583d2a184 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -161,6 +161,61 @@ on a bridge is disabled by default. After enabling VLAN filtering on a bridge,
 it will start forwarding frames to appropriate destinations based on their
 destination MAC address and VLAN tag (both must match).
 
+Multicast
+=========
+
+The Linux bridge driver has multicast support allowing it to process Internet
+Group Management Protocol (IGMP) or Multicast Listener Discovery (MLD)
+messages, and to efficiently forward multicast data packets. The bridge
+driver support IGMPv2/IGMPv3 and MLDv1/MLDv2.
+
+Multicast snooping
+------------------
+
+Multicast snooping is a networking technology that allows network switches
+to intelligently manage multicast traffic within a local area network (LAN).
+
+The switch maintains a multicast group table, which records the association
+between multicast group addresses and the ports where hosts have joined these
+groups. The group table is dynamically updated based on the IGMP/MLD messages
+received. With the multicast group information gathered through snooping, the
+switch optimizes the forwarding of multicast traffic. Instead of blindly
+broadcasting the multicast traffic to all ports, it sends the multicast
+traffic based on the destination MAC address only to ports which have joined
+the respective destination multicast group.
+
+When created, the Linux bridge devices have multicast snooping enabled by
+default. It maintains a Multicast forwarding database (MDB) which keeps track
+of port and group relationships.
+
+IGMPv3/MLDv2 EHT support
+------------------------
+
+The Linux bridge supports IGMPv3/MLDv2 EHT (Explicit Host Tracking), which
+was added by `474ddb37fa3a ("net: bridge: multicast: add EHT allow/block handling")
+<https://lore.kernel.org/netdev/20210120145203.1109140-1-razor@blackwall.org/>`_
+
+The explicit host tracking enables the device to keep track of each
+individual host that is joined to a particular group or channel. The main
+benefit of the explicit host tracking in IGMP is to allow minimal leave
+latencies when a host leaves a multicast group or channel.
+
+The length of time between a host wanting to leave and a device stopping
+traffic forwarding is called the IGMP leave latency. A device configured
+with IGMPv3 or MLDv2 and explicit tracking can immediately stop forwarding
+traffic if the last host to request to receive traffic from the device
+indicates that it no longer wants to receive traffic. The leave latency
+is thus bound only by the packet transmission latencies in the multiaccess
+network and the processing time in the device.
+
+Other multicast features
+------------------------
+The Linux bridge also supports `per-VLAN multicast snooping
+<https://lore.kernel.org/netdev/20210719170637.435541-1-razor@blackwall.org/>`_,
+which is disabled by default but can be enabled. And `Multicast Router Discovery
+<https://lore.kernel.org/netdev/20190121062628.2710-1-linus.luessing@c0d3.blue/>`_,
+which help identify the location of multicast routers.
+
 FAQ
 ===
 
-- 
2.41.0


