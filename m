Return-Path: <netdev+bounces-52836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF2D80055A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0814A281819
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF871862A;
	Fri,  1 Dec 2023 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEcegFXZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5948A1713
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:23 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d04d286bc0so2332175ad.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418822; x=1702023622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfbXDcsTP32EQODpdMMX8eNoBDZKgGgbprWGNtRuFOA=;
        b=AEcegFXZJAkSG0BGWiL4FRiFXdEoZn51PLmeLPf1sNnPMB+92Stqr8ZZTTWAGHmQl8
         9/y3OM1Xz0x3VSJE2b/lgUFhr+b03e3Cpde6zHAbLTgyiGJPTNFQpoZj9Vw+X8+oWWp8
         VrU9jxGkVlTovUlmq1R8h61rBrxTBwQMLFdOiY6tc3COotfWd4tP/bmIkLUWJhd7oJh+
         Q5uV2pn1aFFpJfEvXeUVnd7bVeDN/+YRG4kBYFs67KudTjIDpNy+tNaATN1hIM2O82Pm
         txtEOubshqYo36yY/hnMuRr2O5ED3EUzMNh0wguZ9OJxU+bu66nZd46l/+N1zmha+PQ8
         xEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418822; x=1702023622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfbXDcsTP32EQODpdMMX8eNoBDZKgGgbprWGNtRuFOA=;
        b=MAICSEfYDf46HEgGtTo8z9GTiLQrGQO3RNdTGHpwTso7LtUdgBKnY/G8pCfEfbWh6E
         ULTG3xYjeHJwSl9XX/NxTdeJ4LVwsBhV0wS+Fe+nRFpDCMQl0uXtj9o+RF270+Tm8bB6
         GO1MXfxRU25r/UhBZNqmb+XaQyOuUJtaLNGYl5dflb0N9HNGRdSiOQc6leebzlnKchZa
         NBAnBpjhQzKpJQhlp3+fgEfyPwFn94JTcPrvPjOiyEb2tby5/NnO8LGcXCpT5fHXSwUw
         K94+bePYRfmD8KTO2FtgLlotpYJ8RztSmdHRMWvsMMsrjqlp//B3enmus6u7mA5Ejg/W
         +New==
X-Gm-Message-State: AOJu0YySYDPmWtgc5b1Kohzf2fXHVPhKReiJP77bKjNVenTpBeVrSvmi
	aVKc/g/btrk5HCeIj8leVooHhwpJayokSA==
X-Google-Smtp-Source: AGHT+IGMJ/Cm0mp9e+XWief0Y0MEr2fXS2l3EvOkiPNH6+AtkchU/c0IXg6n0UGERaNDj/TkDDFB+w==
X-Received: by 2002:a17:902:db0d:b0:1cf:cb80:3f75 with SMTP id m13-20020a170902db0d00b001cfcb803f75mr17963407plx.69.1701418822167;
        Fri, 01 Dec 2023 00:20:22 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:21 -0800 (PST)
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
Subject: [PATCHv4 net-next 04/10] docs: bridge: Add kAPI/uAPI fields
Date: Fri,  1 Dec 2023 16:19:44 +0800
Message-ID: <20231201081951.1623069-5-liuhangbin@gmail.com>
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

Add kAPI/uAPI field for bridge doc. Update struct net_bridge_vlan
comments to fix doc build warning.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 33 +++++++++++++++++++++++++++++
 net/bridge/br_private.h             |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 6ad8b42b2c50..a717563eaa15 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -14,6 +14,39 @@ at the data link layer (Layer 2) of the OSI (Open Systems Interconnection)
 model. The purpose of a bridge is to filter and forward frames between
 different segments based on the destination MAC (Media Access Control) address.
 
+Bridge kAPI
+===========
+
+Here are some core structures of bridge code. Note that the kAPI is *unstable*,
+and can be changed at any time.
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
+Bridge sysfs
+------------
+
+The sysfs interface is deprecated and should not be extended if new
+options are added.
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


