Return-Path: <netdev+bounces-51598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08547FB4D2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F1F281F92
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6F19BA5;
	Tue, 28 Nov 2023 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLY8cqGR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6B192
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:49 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d7fc4661faso2907721a34.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161448; x=1701766248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxZ5zD+I0en9ub3kYEw1EEDwC69X80mv/SznaVKR+p4=;
        b=iLY8cqGRJ1b2ZKK5bNgqWid/orFGsc8Ze9yH5MXI8dcPFZ6DjRWNMSISyHSUkVhgYi
         QvzEA0j/RmZ583euzOsL52EFZFStJ8ninAAf9GF9gjMWVUzJIzdQuNFJdwSOwctRRWE2
         DiQVmfVYSVqk5GMwXC3GXXL/isJK5EaDh50wfu4vXzRnVkcVebdvRaoLqs04JCt7+uoa
         VRQWf75OdRadz/NsizfleS4FxAgbZR4aX3mtT4u6JLXYsJ0nEzTgE0PBJrWYhvFtjcC+
         CTzLAxoERsnPQoVwMERz1ion8yNnjH68bm1ICXffO1fuO55ctS0sVxaIuLTBh+kQpSvq
         11Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161448; x=1701766248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxZ5zD+I0en9ub3kYEw1EEDwC69X80mv/SznaVKR+p4=;
        b=d8Fv9ZCwnX0ubuPPdaF7e8Y1lZ7Pd6Ex21N/6sTmjCTmiriDKsReN0eUIQ+7Yzl8+0
         IPDMc7x9zs7+QdmnPZpU3DOD47usglPf2IiMMVMU2pDOnR184NpfVMgTW1T8h3D/vc+3
         jH5QZybps2jyXPSqB2h4VV1RAsk+xYq1gLBkh1r/+R3K7swZkRg0CI0Lr3tGC9umygWV
         n0HGXsrXf7NSkWc3p4Ck6TlkD2/Hn8Dhj0Q9BOeqIjO3IlxGeMdoW54A0Kl/7qfc/cJv
         tIcw3uVr5YR2JLGy2B2OGHVtwzyIVHVIssQt0RJNtZGDecRMxK8fHebAE57DbPaNubQs
         R32A==
X-Gm-Message-State: AOJu0YybdnJPto+Quy3V6EAheU+le9fjadYJaS0cZRaEHkAP+QaAzD5r
	5zesj2U1NXRopmPqGVmEziUQipRn5jz/UhV2
X-Google-Smtp-Source: AGHT+IE60tI5UTqAlJQJPaFwpGKRfjKtsjY+69PG7OmpNPddHLp/pYHHQmsG6bM9P8/Ye21psd0u0g==
X-Received: by 2002:a05:6870:8287:b0:1fa:2876:a641 with SMTP id q7-20020a056870828700b001fa2876a641mr12544723oae.21.1701161448390;
        Tue, 28 Nov 2023 00:50:48 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:47 -0800 (PST)
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
Subject: [PATCHv3 net-next 09/10] docs: bridge: add netfilter doc
Date: Tue, 28 Nov 2023 16:49:42 +0800
Message-ID: <20231128084943.637091-10-liuhangbin@gmail.com>
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

Add netfilter part for bridge document.

Reviewed-by: Florian Westphal <fw@strlen.de>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 36 +++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 3b82cf52bfec..06c2915211d8 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -234,6 +234,42 @@ kernel.
 
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


