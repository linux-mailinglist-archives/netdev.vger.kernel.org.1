Return-Path: <netdev+bounces-50538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B72D7F60B2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E637B215D4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373C62576E;
	Thu, 23 Nov 2023 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thl1G8b1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C2D42
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-285636785ddso513258a91.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747198; x=1701351998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Vo75FcuvNVlq4TjmwAxJVAawHxP5B8FdSellSWuvng=;
        b=Thl1G8b1PoEMJV2XI0c/Rfo+G7KvKW35l6IGDWW3WvAf1OSTMbI0GKFz385l6lHlnX
         IqvPG3wH8E19JQPYGsgPweOwmZ4jAXfDLiru0anLYVYXB0etVsxmjv30a5cx8pZ+AZiz
         HM1phn81O0Lp/apyXoLdnSPi8tO5RJML/c5fFKoZW1eNC66r6/Umik50ow/WW42LGXPz
         KYcccQGC6p9D0HAdt5PJcfH8wjjP8hjibnbydKbJnk+2kEcywYOdQxLO6pkbCCdawpWV
         FMJ9E6AMByVEcXBuh6lBZtsfomzJ9Lx1WOjJEUdRfRdbstXGND+Zha1iuDYnu/KKrMJA
         dCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747198; x=1701351998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vo75FcuvNVlq4TjmwAxJVAawHxP5B8FdSellSWuvng=;
        b=R9A8qimN/Zb49Uwsl1M9BMOIeN0t25V0dHQ1r02xbwD9cQgFKUIEB+PLd57NBf3hdJ
         bovLFLb+RcdMpn1DfDXAa8mctGUenBhyhE0xX+WWiOAMtRQEktND97mergMZqGNgPwyb
         dsFbHl2kzYVR3EDudyPkDPfTzByrB9q5y87DhCrgqbKsEJceHLrc3Jx0xCPNrWiVa2b9
         PBfejrpZriUgxpTGPXRyrOYqeaMF3Wp5tU0nAxjvGnSifRhL5ofpNoejg+YCyk/TfM4m
         jrrAQQEiHx4PRjI3KMYqoaEoL+zmZt2U69cXXuYjCBvInTimYDfHc/p6Iag7qC1g0C2x
         85wA==
X-Gm-Message-State: AOJu0YwN6m+zUFaqfvpBMRfEeHRlSF66sXaL6N1sP5gCZPAkrpQvrqoa
	ZI4ATdh/HIHX+66p1EdA/Q3QmUPCFqSSCinH
X-Google-Smtp-Source: AGHT+IG9RYEu2C8PrmCD7QI2qMQNJEgSBO8xbaEp4NAAU1USG7/prOI0PY2Pwn1n8TmhwdYShjpjNQ==
X-Received: by 2002:a17:90b:180f:b0:280:8356:10b2 with SMTP id lw15-20020a17090b180f00b00280835610b2mr5672876pjb.5.1700747198316;
        Thu, 23 Nov 2023 05:46:38 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:37 -0800 (PST)
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
Subject: [PATCHv2 net-next 07/10] docs: bridge: add multicast doc
Date: Thu, 23 Nov 2023 21:45:50 +0800
Message-ID: <20231123134553.3394290-8-liuhangbin@gmail.com>
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

Add multicast part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 55 +++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index f70f42ab7396..62cb6695cd22 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -165,6 +165,61 @@ on a bridge is disabled by default. After enabling VLAN filtering on a bridge,
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


