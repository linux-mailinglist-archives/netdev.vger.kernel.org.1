Return-Path: <netdev+bounces-52839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3480055D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266A91C20E74
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834218B02;
	Fri,  1 Dec 2023 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRnfIxHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB77E1717
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ce28faa92dso2402105ad.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418841; x=1702023641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+h3oxJf+7/pQGQ/bGbBRcdc3TZ4iSlZopQ/xxQA12Q=;
        b=fRnfIxHdI3KcaE3t6qr3GIeWzWTYqlNbPPKf98RvPGSwW9/OBlc5yOQc9EjpiP3BY7
         yfd4Zsnlr+4eXx1T7fnegm+A3kJGmxpJPcxW57OjBa1rYz+t6Ttnj+rOnXT4m2fJcu6v
         Nq6ziIEMAu2frAczsUcToMIwGj7UnlHK3HUQRncrxr1JA1/zXkc/YXhWJUI+vg72XFxb
         SnQwRl4DyBB4DzoGW55cs/gCxR/s9FZa4dAMfbw9Okxl6zPWmzJIQeMnkw99voPp3R0M
         RcoIYhC633YzsvclWxucXCk4UazRLBVbczz5w09ckpWg2WEgqeRujlHJJIqF40/92H6g
         LHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418841; x=1702023641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+h3oxJf+7/pQGQ/bGbBRcdc3TZ4iSlZopQ/xxQA12Q=;
        b=YXjMzDfNmxq/G1lwLIV2O7EfpMn73GqtnodoElyXfDJp6SLgRZJT6P5qy29mcjYXaj
         OqtDkwsxris4TeS570zucf2Pe4xkRKXFFuPlDfJs5JoKFGGVfskLJ64VC5CH7vtqbGgc
         jxJa+L0rORCU2Cbwp2TxIPlrdgBTdVbI43a9F4eaD+UfIHsZupPzwRfRFyf09hk00cTU
         5RrTHLaLG3yuf5sVGH2ZDukmGSP9vo44rn+6+IKlMlhHB1KYyuygVrnNnztH671udS9h
         w1ouh9YdHJrOJNzlU5fZ7hP38zQWM0QIynbV+MbP+j3uWlAxHN3dxffpGMdrEtrkcx+g
         Efuw==
X-Gm-Message-State: AOJu0Yyy0XQMwxUl9tpxDKzyXB4dqAb+unB7hp2m64M4JZ1RYqI3MXoy
	+lpUf1uS+/Q/Tl0Lyuq5cKVYN2fhv4BHqw==
X-Google-Smtp-Source: AGHT+IGCifeWpHuMj9SGKzxc0rqDhyEtnD3UPHULCKwV+uNHGf9rdaYveQLjotYKFVn9x9GGu/e67Q==
X-Received: by 2002:a17:902:bd46:b0:1cc:1efb:1bab with SMTP id b6-20020a170902bd4600b001cc1efb1babmr25320780plx.38.1701418840677;
        Fri, 01 Dec 2023 00:20:40 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:40 -0800 (PST)
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
Subject: [PATCHv4 net-next 07/10] docs: bridge: add multicast doc
Date: Fri,  1 Dec 2023 16:19:47 +0800
Message-ID: <20231201081951.1623069-8-liuhangbin@gmail.com>
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

Add multicast part for bridge document.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 56 +++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 97936b9564fd..863ad2c8d146 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -177,6 +177,62 @@ on a bridge is disabled by default. After enabling VLAN filtering on a bridge,
 it will start forwarding frames to appropriate destinations based on their
 destination MAC address and VLAN tag (both must match).
 
+Multicast
+=========
+
+The Linux bridge driver has multicast support allowing it to process Internet
+Group Management Protocol (IGMP) or Multicast Listener Discovery (MLD)
+messages, and to efficiently forward multicast data packets. The bridge
+driver supports IGMPv2/IGMPv3 and MLDv1/MLDv2.
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
+traffic based on the destination MAC address only to ports which have
+subscribed the respective destination multicast group.
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
+
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


