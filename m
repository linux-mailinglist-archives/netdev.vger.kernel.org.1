Return-Path: <netdev+bounces-51593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6C27FB4C8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D001C20C4D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA571D520;
	Tue, 28 Nov 2023 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3vzCz/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E3AA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:26 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so3071247fac.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161426; x=1701766226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjWAZ2g9jGxIJrM6FtJnZy4QStHHUvpNZrX2gK/Tr0Q=;
        b=R3vzCz/1v15o/v9WfcmTTmVGqwl6GrTMWY5ysrJOR5JexE91Dd10q6Cw1Fbophbnq4
         J4vcS55KTDnLtXQp5sCZy7H2tgChnPZiKniggBrfG8eH5vst6mRgXTrm9nWL+IHjPOYl
         gQrqJeYFQn77e+V8wHg6krp8cOGdMkI+8+7mM+dswqfBDz9H2dhecO7CNDDyg8wiTzZh
         6f7tUWzhW6F42LtSA7rq4Ht33gIROQ6ZAA4SIMsQDKRHenHwcVmh/hCCjyK6UKLxGSAv
         MZgb8QFo/MkghnNBUsyr9emn59i5IJHerlHRb1mE83Q4449cU69sBAwaMi3WSIOzlzL7
         9Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161426; x=1701766226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjWAZ2g9jGxIJrM6FtJnZy4QStHHUvpNZrX2gK/Tr0Q=;
        b=oZoGxLfqMrXCFsfiWA4F/aETvGVNCluVdv+slDn1robJgeHKGV4f3OfRWBLBEteC6f
         fDRJAdXfg3euM4A4w8fCaj1VW8moUypENDlIFkC9QaZtR20cd6h0Y6mUZPKOmuMslHvo
         6dkLObWTXp/MAm5jiG72BZd2l9R0GLLXiedJqrmQzZFKxOYp+ytk6wDbLxzHfagJmI9M
         ZHeN+ClwAOGMKyL2GKm9jdeuDisC1K5LplVhfYm7l6mNAUKPt12oGfyuRpk6ilgfKfPH
         QyqmwvOBhheoGgEbjMPh8saCU+zVJJQ4V8FLVJJ0+HgbstjXl/0vN0XAGuvnNOa0eIFI
         BfZA==
X-Gm-Message-State: AOJu0YxwxlUrLl5CX5xydWVs0CmpyQGwfFOum1CKVxuP+G95h+bZ7KWC
	FSLDaRt8HRShTjzasp6mOHyAosgfMRtDVlG/
X-Google-Smtp-Source: AGHT+IF3Gi6DHzbLpkuG1wiTgL9gAN99IKS9XzJCZu7ho4fNPzPjZbeUiCkVp1P3YbjYAKzs3KcTYA==
X-Received: by 2002:a05:6870:2809:b0:1f9:eba4:f54a with SMTP id gz9-20020a056870280900b001f9eba4f54amr19473801oab.59.1701161425553;
        Tue, 28 Nov 2023 00:50:25 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:25 -0800 (PST)
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
Subject: [PATCHv3 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Date: Tue, 28 Nov 2023 16:49:37 +0800
Message-ID: <20231128084943.637091-5-liuhangbin@gmail.com>
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

Add kAPI/uAPI field for bridge doc. Update struct net_bridge_vlan
comments to fix doc build warning.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 26 ++++++++++++++++++++++++++
 net/bridge/br_private.h             |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index de112e92a305..5d6d3c0c15c1 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -12,6 +12,32 @@ independent way. Packets are forwarded based on Layer 2 destination Ethernet
 address, rather than IP address (like a router). Since forwarding is done
 at Layer 2, all Layer 3 protocols can pass through a bridge transparently.
 
+Bridge kAPI
+===========
+
+Here are some core structures of bridge code.
+
+.. kernel-doc:: net/bridge/br_private.h
+   :identifiers: net_bridge_vlan
+
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
+   :doc: Bridge enum definition
+
+Bridge port netlink attributes
+------------------------------
+
+.. kernel-doc:: include/uapi/linux/if_link.h
+   :doc: Bridge port enum definition
+
 FAQ
 ===
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6b7f36769d03..051ea81864ac 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -186,6 +186,7 @@ enum {
  * struct net_bridge_vlan - per-vlan entry
  *
  * @vnode: rhashtable member
+ * @tnode: rhashtable member
  * @vid: VLAN id
  * @flags: bridge vlan flags
  * @priv_flags: private (in-kernel) bridge vlan flags
@@ -196,6 +197,7 @@ enum {
  * @refcnt: if MASTER flag set, this is bumped for each port referencing it
  * @brvlan: if MASTER flag unset, this points to the global per-VLAN context
  *          for this VLAN entry
+ * @tinfo: bridge tunnel info
  * @br_mcast_ctx: if MASTER flag set, this is the global vlan multicast context
  * @port_mcast_ctx: if MASTER flag unset, this is the per-port/vlan multicast
  *                  context
-- 
2.41.0


