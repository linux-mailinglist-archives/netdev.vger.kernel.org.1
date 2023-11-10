Return-Path: <netdev+bounces-47068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A98FD7E7B37
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10805B20DDF
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A418813AED;
	Fri, 10 Nov 2023 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpEwA951"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53413AEC
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:16:17 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB61E27B3D
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:15 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c10f098a27so1651512b3a.2
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699611374; x=1700216174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=navMiCGRd9pBWD05coLFaYzT6FFtcpjB5T1w91L5O+Q=;
        b=jpEwA951fmSqmSZnd1Ws4UYVfL0UVta3Co0qFnL8/zaUaBo7n6GmiR64uRRRv0tGk2
         LbjZ/I0CQ7aA3DBgZ7n0k8j4uspMsscIdefn+SWF22ILIX3TPZFMKQegTL5zUuIoqJFb
         v5XucdpaFFEI419BbZXI2myEa2VYy7BhUiOR92+EMT5uLjm5nTymLFnHwhPtMDX0jDa6
         O+bxsN7Wlj42XUyRZPM2fWUeJIydKdt5tzPk1B6XD+giPfE2TDxOZ5Q5mcIOwuaDtUe9
         iQg9fp8we6i8WlAqXO1MohVlCTQoAKvYYQFyoGLznXy4PVKsQ+s9DNfYam6Qi1Ldss2Y
         aAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611374; x=1700216174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=navMiCGRd9pBWD05coLFaYzT6FFtcpjB5T1w91L5O+Q=;
        b=u4YPqaKru3MGDPWYsOFLF4VJi29tYopyAGs4f8VWDL+/UC/6/2dqEcmuuG4lqaDnwW
         jvLgqsSWzXSUjba9z0hdFyRn8MndOTLyYeQs7pctIs+HxDeBK0MfJJ7Np/sdoeGq8XP6
         e6Fa0Wg3kozPrNy02oFDQiuuZSggik11c6qRaTpOmnOv8EB6NOEx1D5UQi+EkYeTpuEj
         2VQ5b8uoI03Emr50tMoJ4N/r0uRKkPZeImtEUYBipLHxyHpGgjBRCHD5mTND5kpluiYx
         hl5KwZKtobUzf7oHcx4ZJxcajKw+08FV+/C4oHgfvt/dop6QuB1G5q/0GMYvihWaQ0Ad
         LM4A==
X-Gm-Message-State: AOJu0YyurrwrckOAT9WlMSXtPLUCEdpSEBZIxyZ/o7Iime/3s8vKxjhw
	I8+mUkNIo6Zv2m8AsUd8GvV+C8GqMq82rA==
X-Google-Smtp-Source: AGHT+IHnIMr4aYqcq+AcHylO/ogzlVpUlFmcz5fMvKOIre5714Ks6D7bpfc6a5ysYGTO2pWNp1LXtA==
X-Received: by 2002:a05:6300:800a:b0:180:7df:76ca with SMTP id an10-20020a056300800a00b0018007df76camr7484556pzc.62.1699611374426;
        Fri, 10 Nov 2023 02:16:14 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cc13-20020a17090af10d00b0027d015c365csm1244631pjb.31.2023.11.10.02.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:16:13 -0800 (PST)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [RFC PATCHv3 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Date: Fri, 10 Nov 2023 18:15:41 +0800
Message-ID: <20231110101548.1900519-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110101548.1900519-1-liuhangbin@gmail.com>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
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

First add kAPI/uAPI and FAQ fields. These 2 fileds are only examples and
more APIs need to be added in future.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 83 +++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c859f3c1636e..d06c51960f45 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -4,18 +4,81 @@
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
+   :doc: The bridge enum defination
+
+Bridge port netlink attributes
+------------------------------
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: The bridge port enum defination
+
+Bridge sysfs
+------------
+
+All the sysfs parameters are also exported via the bridge netlink API.
+Here you can find the explanation based on the correspond netlink attributes.
+
+NOTE: the sysfs interface is deprecated and should not be extended if new
+options are added.
+
+.. kernel-doc:: net/bridge/br_sysfs_br.c
+   :doc: The sysfs bridge attrs
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
-- 
2.41.0


