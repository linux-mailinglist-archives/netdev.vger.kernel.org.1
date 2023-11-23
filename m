Return-Path: <netdev+bounces-50540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5457F60B4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7B5281F08
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923D325748;
	Thu, 23 Nov 2023 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2Kcr6S7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4B1B6
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso6647855ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747207; x=1701352007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mZC2nzFnQ3mwWSpuHTtFu23MzIGQ3zdT55w09zMXZo=;
        b=S2Kcr6S76l65JoUH3ifV2MVOnge/u1CX0U4CUcyDwEQigJdQsvUpzYaTWCn/e84Lan
         /oJ7DeSgoyHCYsnaM/MBREI14HibrqA2bCnncx9EyG4Cbmm+R5Nod8Jg3k+3xVpotB1C
         +I/eHQRCh2zdSzJTlo0OWKKZeviec6i/JhH13PkUFspPrxEKdONvUbkriIw12AwS6fP5
         xzgzV0Ph2wGn48EUaioMuH4LOKeHCAxxVdtAY1r+YQijTiTwb68QULmv+Sh30kARw9ma
         GHPI0JW0vekXjWUSGXKxNWcU16txSvc3Kcb7LMOZzcMf/Q/HbdOtG7aefsovxI/eu3Vb
         0ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747207; x=1701352007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mZC2nzFnQ3mwWSpuHTtFu23MzIGQ3zdT55w09zMXZo=;
        b=fShptx7IqTqK2J5cXpsrkPAdgDGa1Pn1tvETrk6YWa+Qa9yma3csXRQZd7zOhfVPgL
         BQvgCsIRY+oNrQ6z6Fremyukj8mRWsz4O8eAU3Kb6Ko+GKemOl8DR2QZ7USpueNKxs8U
         KpRJIZMu/MHa8edqNcUkvjZZB/0qM2+PA+vKu4dpugpy0wCccoO/3NBL+ktJkFx81+u2
         G35V82xUG//QSS9GkKpXi/s1Q035Sv4q+UrWO7ygHqyM4n8MtFK8ULt7E00rlxKMxkH0
         D8gkLcAUvShcxmLGDHnO19m098h4hmeBAKhA7HmioOuMcmv1LkpIRPNt6UlSW2mUGkGx
         bFgQ==
X-Gm-Message-State: AOJu0YxmV5aL9pSWHARyThe9w5C+Z128S36mBs4Wb8w/NtcsmxXQeo05
	5JP4AS0b5HB1FY/VmevVm5g2H3jFLb8U64x/
X-Google-Smtp-Source: AGHT+IHV/SqpHg0/Lsq5ApqSOF8iMqYWd3uMTiEaamksK/49RhJ/m4b9miU/KcqLuLQy3D7VvtRxSw==
X-Received: by 2002:a17:90b:1b41:b0:285:6946:e51e with SMTP id nv1-20020a17090b1b4100b002856946e51emr1067483pjb.36.1700747207697;
        Thu, 23 Nov 2023 05:46:47 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:47 -0800 (PST)
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
Subject: [PATCHv2 net-next 09/10] docs: bridge: add netfilter doc
Date: Thu, 23 Nov 2023 21:45:52 +0800
Message-ID: <20231123134553.3394290-10-liuhangbin@gmail.com>
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

Add netfilter part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index f42c19e59268..772bbe28aefe 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -238,6 +238,42 @@ kernel.
 
 Please see the :ref:`switchdev` document for more details.
 
+Netfilter
+=========
+
+The bridge netfilter module is a legacy feature that allows to filter bridged
+packets with iptables and ip6tables. Its use is discouraged. Users should
+consider using nftables for packet filtering.
+
+The older ebtables tool is more feature-limited compared to nftables, but
+just like nftables it doesn't need this module either to function.
+
+The br_netfilter module intercepts packets entering the bridge, performs
+minimal sanity tests on ipv4 and ipv6 packets and then pretends that
+these packets are being routed, not bridged. br_netfilter then calls
+the ip and ipv6 netfilter hooks from the bridge layer, i.e. ip(6)tables
+rulesets will also see these packets.
+
+br_netfilter is also the reason for the iptables *physdev* match:
+This match is the only way to reliably tell routed and bridged packets
+apart in an iptables ruleset.
+
+Note that ebtables and nftables will work fine without the br_netfilter module.
+iptables/ip6tables/arptables do not work for bridged traffic because they
+plug in the routing stack. nftables rules in ip/ip6/inet/arp families won't
+see traffic that is forwarded by a bridge either, but that's very much how it
+should be.
+
+Historically the feature set of ebtables was very limited (it still is),
+this module was added to pretend packets are routed and invoke the ipv4/ipv6
+netfilter hooks from the bridge so users had access to the more feature-rich
+iptables matching capabilities (including conntrack). nftables doesn't have
+this limitation, pretty much all features work regardless of the protocol family.
+
+So, br_netfilter is only needed if users, for some reason, need to use
+ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
+traffic. For pure link layer filtering, this module isn't needed.
+
 FAQ
 ===
 
-- 
2.41.0


