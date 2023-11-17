Return-Path: <netdev+bounces-48597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F447EEEBB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448231F270CF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750AB14015;
	Fri, 17 Nov 2023 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMjWBOb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8141727
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:25 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b709048d8eso1636543b3a.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213544; x=1700818344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Vo75FcuvNVlq4TjmwAxJVAawHxP5B8FdSellSWuvng=;
        b=YMjWBOb6H1P5+EMm05vbjvgguxceFkcRLNZ3v1ynhUdkQ4T+v0X4BoSV+QVnO6DVvg
         0gDo8hOQtCJotnQ7rItZP+/zDVbmrtdNBpsrFhbRoWhCqhiENW4LxJkp7ZTqT8smmFQR
         d5ONeF9xBusbM38M42roukEyotAmDziqtJGqJH4ldX6hQ/jTnMhDVrsTk82inJbzhhWS
         VkJLeu4IpZY0FMo9DVRrfwkwehDjexctRnly2ZCdhQbyhKQLHmhMiniDD0F3rBK2YKUd
         K4kkyjLV6N+Rm2mc+uvTcYSEq8/GdYTVsktf+7hCUk0sAFsZcDWX8CWMeJPSjGnVaNJf
         h5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213544; x=1700818344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vo75FcuvNVlq4TjmwAxJVAawHxP5B8FdSellSWuvng=;
        b=BYaP61Nrs0UEJ/dE6k57O9VWxlkmidfCGwH1nq8liYlU5y0aRescyZRSW8IZKd2+/G
         ybfzQ/ffZYB8YkdhdRQ39QnHDLOfqAJU+PqJiYR3BugaAKfqT9xEQKKZT3PUOKPqPJoj
         aM15tYkv/rxjqVpVK5fmonnL4iOWMYRS6K6N5PBJ5viQHnyW6333V/+o6CYbprz75db2
         BQpTgNhhDZrW5nOaR504xjY2NWSmOpCQRdUpy+CiSqfXgtHLk+fiSuyIOXZFIyA9sKKA
         X5PMBowRyJy8B/ZuRyjtm84auFLF3bpr7yORx1jgLnvIVjNSrMRHAoZnB/EnVLPhQl19
         vW9Q==
X-Gm-Message-State: AOJu0YyuuOiT7Ge5lzDoPqbq6fuiUOebsd+ObzIqg+wDhOiLMGQoV1WQ
	BZ0ULv9xl0U6mE3uKawj9idWX66ZH2Cse+Ix
X-Google-Smtp-Source: AGHT+IHXeLA6fVZUE/3M/3VuEy7Auh3kgakaShFZy1NY18t8ZpYap6dg4Tt7SkgtwYxQa8SuRigRyQ==
X-Received: by 2002:a05:6a20:e111:b0:188:c44:5e5 with SMTP id kr17-20020a056a20e11100b001880c4405e5mr1867004pzb.30.1700213544260;
        Fri, 17 Nov 2023 01:32:24 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:23 -0800 (PST)
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
Subject: [PATCH net-next 07/10] docs: bridge: add multicast doc
Date: Fri, 17 Nov 2023 17:31:42 +0800
Message-ID: <20231117093145.1563511-8-liuhangbin@gmail.com>
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


