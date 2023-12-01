Return-Path: <netdev+bounces-52833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB20800556
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2B21C20953
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811AA18625;
	Fri,  1 Dec 2023 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3h6VB3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C60B170C
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfbce92362so2098285ad.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418807; x=1702023607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZBDkpNPcullmg2ZrjoSc/KjdpI4wddQiZVrmKtbFFs=;
        b=L3h6VB3KyLPN/qMHWWqveF2UyYHw5HiFPzu6SDVOq76rP+UuD++k/f1QsN+gkqlmmK
         AKMYvVzcBv5fY60Jf742QbWmmXdmKhyzTZt+AWtS/gAcrMbs3pbMwwrE9/UOgLJUgoPX
         amGngvxangBqE+FgJdTR9ISUXGD9s/OimsNLNduD2BYRPUd66fouKssQVs5eNwzaqbYM
         CO4r2ZlMXxom96lRbI4wzInrGVCStp5v0Vmrhvq87R1Vlz5E9XhzheFexuZK5XMgfkJY
         AHCyIaVIWIcKjMN8n9FZs8IqIB1F3icz2hR2LiDEKc0WBsPlDuF1EfB8mJ91A3q6qRSK
         H+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418807; x=1702023607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZBDkpNPcullmg2ZrjoSc/KjdpI4wddQiZVrmKtbFFs=;
        b=NTlZzjn2zRwbhOxXP7BqogThs3TXgkir79K/A81mUTawoapTcazo0JKV+Cz0QoiOhb
         MH2OuPoH0sCl2vH8TT3I/uvwAHhtT69ZsrODm1w9vcGS0pyK7EcYMNAl0YKms2M4VbSd
         oZ88FyxqBxZlE0LhhnVKY6MxI+LT/JchFfwvaXklKOncM8uevALwQje/XImXstO3OqLp
         DRJrC5Lq6S/KzDi+1+goRBEoDy7gcjJ+6jCxIAsucuQMlkFGqosOGvw7vZHkvnfbBkHl
         Em7jLNMBTWuZoJcGq4YQ1We/mojVgpUu0fo+FIz6NWKWN4btbmK2krAkOnJgkusGqWdq
         vN5Q==
X-Gm-Message-State: AOJu0YzLwvIqCBAO+xsdHd5ass3AMKrsbbpAv/3RxzazRLlP88GdXnuO
	6OAhSVpduLk3Sn5RECCSP2ZqnVIcN4CqFg==
X-Google-Smtp-Source: AGHT+IHkTVnlzX74dBfR8nL0TdvzkBLcwRvTetc2a6DZFYUpkdS69AYmkPAtuHuZvmGgaZjZBUrRIw==
X-Received: by 2002:a17:902:e5cc:b0:1d0:4759:bb60 with SMTP id u12-20020a170902e5cc00b001d04759bb60mr4225902plf.26.1701418807260;
        Fri, 01 Dec 2023 00:20:07 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:06 -0800 (PST)
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
Subject: [PATCHv4 net-next 01/10] docs: bridge: update doc format to rst
Date: Fri,  1 Dec 2023 16:19:41 +0800
Message-ID: <20231201081951.1623069-2-liuhangbin@gmail.com>
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

The current bridge kernel doc is too old. It only pointed to the
linuxfoundation wiki page which lacks of the new features.

Here let's start the new bridge document and put all the bridge info
so new developers and users could catch up the last bridge status soon.

In this patch, Convert the doc to rst format. Add bridge brief introduction,
FAQ and contact info.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 47 +++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c859f3c1636e..6ad8b42b2c50 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -4,18 +4,45 @@
 Ethernet Bridging
 =================
 
-In order to use the Ethernet bridging functionality, you'll need the
-userspace tools.
+Introduction
+============
 
-Documentation for Linux bridging is on:
-   https://wiki.linuxfoundation.org/networking/bridge
+The IEEE 802.1Q-2022 (Bridges and Bridged Networks) standard defines the
+operation of bridges in computer networks. A bridge, in the context of this
+standard, is a device that connects two or more network segments and operates
+at the data link layer (Layer 2) of the OSI (Open Systems Interconnection)
+model. The purpose of a bridge is to filter and forward frames between
+different segments based on the destination MAC (Media Access Control) address.
 
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


