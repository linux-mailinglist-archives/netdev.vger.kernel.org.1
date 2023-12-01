Return-Path: <netdev+bounces-52841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C904800565
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED21B20F7C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521E1A28F;
	Fri,  1 Dec 2023 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ0Ows40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5521711
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cfae5ca719so2509715ad.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418857; x=1702023657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOauDL/BL1hbePcjoQZwAVMMwsKjtm97MLl5BNo7AiQ=;
        b=jZ0Ows40wiw2oHaQ4jLMKoeleWszznsRG01+YWoKuGOCtMJKoLQ+pKgpc/9Ag+GKXE
         oXLXCcDd7wZsp2pUEu285spWuMoyxVXtMPBZUajHHGCV1weSdD07Z29vM3XMpbvoKt3I
         5AMridJvkBdG4kUWeEnqLVBVvOyQx4P16BEUouzTPFd5NTxm3lGvfCfVdkg/goiWM8UZ
         PHG2Sy+u4bMjKIvQwi0na/ac1vzLBDkxhNw6iJJDMAov4qfcNaCt/Zw3q5S89hlIs0Cz
         et41AKq0PDi67vykrwB84jibrQr5j+7rOccQgWaqW6NgwNCDhIlWPlJPRg90B9QfBy+H
         wEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418857; x=1702023657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOauDL/BL1hbePcjoQZwAVMMwsKjtm97MLl5BNo7AiQ=;
        b=W6NlDav94PIXHqFn8aHJTH4f6GmtoW8N7RE+wB/BQCmVGsr1eYwh17ywhsMEREayPR
         MbRzEII8EYLOM3dTiXseUYYuTyg0gM4mvc4DgZrazeguKI2ZOGTB3RGrm4jzVcNivFEj
         yzaN5KyhH6s9hmTjwuNQZAIl94qtlrIiqWaUPyaqrLEHYhxBoNFSWNL39e/QiuVYQ7kN
         N3f432Lnr6RbduZvRr4xzyVNxNG4oUZFZYwaVq/n/VsITiLkkbg/2Fu9jBmQwZB3wscs
         5rm6JuwmrhQuzoMUqlbqMXA9XCu5wk+6xYY/yaUAHjZSIDHUJcLK16egp5qhsQxKfPtO
         TIpQ==
X-Gm-Message-State: AOJu0YzlJ6rO+n083RA1Gnop8sjJ7iMGNOOk/XuNBXLAdzG3Q0eMPUio
	V55A1XtHu4LF/gVgBwNq3ZWQmrrWwnJmdg==
X-Google-Smtp-Source: AGHT+IEWJPIdygeyI/6MSxqd3q/mp4V1IcNvbr1/YlbqhfGh5oKsS9OSDW4hNmmpgKwY5L6eSdhmAQ==
X-Received: by 2002:a17:902:ceca:b0:1cf:cda3:ecf4 with SMTP id d10-20020a170902ceca00b001cfcda3ecf4mr15863547plg.10.1701418857514;
        Fri, 01 Dec 2023 00:20:57 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:56 -0800 (PST)
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
Subject: [PATCHv4 net-next 09/10] docs: bridge: add netfilter doc
Date: Fri,  1 Dec 2023 16:19:49 +0800
Message-ID: <20231201081951.1623069-10-liuhangbin@gmail.com>
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

Add netfilter part for bridge document.

Reviewed-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index e96af89cd061..39ff8d126a04 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -251,6 +251,42 @@ kernel.
 
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


