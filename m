Return-Path: <netdev+bounces-51590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574C7FB4C5
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A082F28112F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82EC19BA7;
	Tue, 28 Nov 2023 08:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/tkVR+R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79720A7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:12 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cbe5b6ec62so4137370b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161411; x=1701766211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IacZAzLju3D9+KaX6gJPJ/9NzActBkRpe8J66DiTOxs=;
        b=m/tkVR+R6Z8CxyLQHlCBxhkuex/QmS5/X/ZM1hSyV1VcbcdbfF09ccdWUPll/jE426
         a240P3xXB9589RRqtmV0kAroJaVTWmwsudMfz88IZxUIhhvHvlYucob+Du51FJfxdpM6
         eDURqJ37M/kZo1aoqn3hEtChnT4q5tdV7gcADo01cUmuSsUJZT3Be1NMN30zPekmima/
         q4m6dl59ah9Z2SUpfVmNY2StGicizFJZ985iJHy4hTuWAHSvfuNRQxKdk4XstcvAFHG0
         BfaO1JA3a+VELIFXbx4nYKHY866t5ckGzTRepV/SdaHiOg+Q3bfM0jTTfJmUDXk3hl7Z
         8vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161411; x=1701766211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IacZAzLju3D9+KaX6gJPJ/9NzActBkRpe8J66DiTOxs=;
        b=vVqtIZm8TAf9tKGVD58ei1BuIMiuNywcQ8AIaI0XiAuiBF27/24pmm12OZI+Rl5U5D
         q7MOaCe6dNX6fQf2xC6xaHmageFMUUVRpqzRmVRmGHKFpCqmZ/692ggDWw+168zg4Z1/
         XNzVdudAvD3xnEqnKDd9a/rR0q8y7LLXy3wHrKtkjAeUGwi9FkW74sIjd2sxDUVDvtCW
         LBfI5L7oIVvVLhv0kilg3JNTJAHBm2E7yIu8eq9nKae5mwtOq+BBDXr9Bt5hzL3uTCkJ
         ll8Vbhuyi8JFsiCpC+WVPVd3rbLb679N4bsUuYUEL20dE+/NAxCBR3wIutkiAcR5AMdE
         3eIg==
X-Gm-Message-State: AOJu0YxoZC8dseESFFFa/2+wkgBBkp5G/YsgdZN20+GIfegbALG9q/eW
	uoSQA80xa1Kld4eBjZ2fsDD0Vjn1hadjaZYQ
X-Google-Smtp-Source: AGHT+IGlALMz0glr/FaO4pxwKz/mgtPKXljR57aosieNTZriNKUDK4yBWJHRxBOyfqkCLCPzTmBNng==
X-Received: by 2002:a05:6a00:27ab:b0:6be:265:1bf6 with SMTP id bd43-20020a056a0027ab00b006be02651bf6mr15867223pfb.32.1701161411311;
        Tue, 28 Nov 2023 00:50:11 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:10 -0800 (PST)
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
Subject: [PATCHv3 net-next 01/10] docs: bridge: update doc format to rst
Date: Tue, 28 Nov 2023 16:49:34 +0800
Message-ID: <20231128084943.637091-2-liuhangbin@gmail.com>
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

The current bridge kernel doc is too old. It only pointed to the
linuxfoundation wiki page which lacks of the new features.

Here let's start the new bridge document and put all the bridge info
so new developers and users could catch up the last bridge status soon.

In this patch, Convert the doc to rst format. Add bridge brief introduction,
FAQ and contact info.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 45 ++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c859f3c1636e..de112e92a305 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -4,18 +4,43 @@
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
+FAQ
+===
 
-Additionally, the iproute2 utilities can be used to configure
-bridge devices.
+What does a bridge do?
+----------------------
 
-If you still have questions, don't hesitate to post to the mailing list 
-(more info https://lists.linux-foundation.org/mailman/listinfo/bridge).
+A bridge transparently forwards traffic between multiple network interfaces.
+In plain English this means that a bridge connects two or more physical
+Ethernet networks, to form one larger (logical) Ethernet network.
 
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


