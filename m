Return-Path: <netdev+bounces-48599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612467EEEC1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDB4B20AD5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497D1401A;
	Fri, 17 Nov 2023 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMW46Pwb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17154D7A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:34 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2802c41b716so1562892a91.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213553; x=1700818353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mZC2nzFnQ3mwWSpuHTtFu23MzIGQ3zdT55w09zMXZo=;
        b=PMW46PwbyUTGfZLkfiTwea14Yn7Jz8000kaVzJdzbAr7efLE4NjYx+ggBk7wMmShsn
         OhwyT51OBtH972SxW2N/81EebaoU87yJ/quNaGoj5gZ4RbE+WKCtexFiMUkS7CAV60xD
         i8BLqtQ5xrNCIDhxitu8D3tWpTefMBXMId8LvVEx/Af3XJ2WDLSvGfpivaelZm7Y8IDD
         cck3qryHs4g+s2twQhlg+7p4umP4r+msj03t3b9dbW0v9hLz32ta03KjXP6eDrOb7NOK
         2rYMTKOcUQ5qV4FMKDOfIBQkXtVl+BW6miVSFf34ZXVzydlJqCdLAMH3VR9Ze8MOjEia
         DBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213553; x=1700818353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mZC2nzFnQ3mwWSpuHTtFu23MzIGQ3zdT55w09zMXZo=;
        b=OrHDEpjzf2KLaw2tFWM3vcZefGc6WpBfKKh836xi2pFusBKekTdL2iY80t8eNRblc5
         Q1axs+C3xs+sVbdP8hsBcPj54LEPjL1bs5HAXKgQEhCmloEmcpSaYYCQqVHhEZUzXN1H
         +gd2GDXubP5ZMKLdSC9mWGFoGRglLYz1guRdqxSfqRnbTUDIZTAA6UzFIFsNWnjaeNss
         7cRc7cCQUbFElPdNnX8LjjqxvTPh+IkAm0E2w34pRFp8WbVhmneM4NyF+rkvwkdbXIMu
         sleE8j5oCENpOLPD1hz2ajiuO9jdxfgzTLhEc3HDg9RbvA6oWw86b225OtJ68XDhqW0u
         wwxQ==
X-Gm-Message-State: AOJu0YzXY2Y0+Qew/XELr7LXNYAX2KSfaMEzlvUKRwki5eSW/q3vZwd0
	mff1pRKqryTvofmy/KkDfUae+QwKV7t4jCeS
X-Google-Smtp-Source: AGHT+IHOnwjHKN4TGwCvNxWPenwiRh2u0sWgCCRndtVe0KUFRZYxNILlHIF2dohlB7YPQTOOUtrC+w==
X-Received: by 2002:a17:90b:3504:b0:280:5e8:58be with SMTP id ls4-20020a17090b350400b0028005e858bemr14165728pjb.48.1700213552921;
        Fri, 17 Nov 2023 01:32:32 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:32 -0800 (PST)
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
Subject: [PATCH net-next 09/10] docs: bridge: add netfilter doc
Date: Fri, 17 Nov 2023 17:31:44 +0800
Message-ID: <20231117093145.1563511-10-liuhangbin@gmail.com>
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


