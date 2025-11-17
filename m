Return-Path: <netdev+bounces-239011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547AC62244
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 03:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E07A3488FA
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 02:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1D23C8A0;
	Mon, 17 Nov 2025 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iirzeuqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC61F17E8
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 02:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763347523; cv=none; b=fljTYYj9xa8fXLUj2wVcABB4XdaL+d0CDvEjebx7STLbaSjBtaiUhb/E0lTSS9h9wRKELWY9lys9Bm7DMJzYuzVzEEBiheR9AASXqqzQXgK5U6nFLrn59cxs73KnTXRB4PTKkW7Q4yVG3SrKBVItmt7+zokVAJartBxVNK5F3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763347523; c=relaxed/simple;
	bh=aZZIhhWiofvgkcAHqoG5f1gDDUjhtnHv6mLmQstFopQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgKwG2o8ZoRHD2AdeZeN4iZ/3IW/M/LcqvIidjjAZuX1vCPiImR6FYh7VE08msMmtLziTDH15AT9hc6StXaxl5Z363/A8bWg1qFd5hiPO12lcU0iQXMhd+E3FntTMD0JO5FUQzGsS0Pyn8wbd53cawbyjNhA+mINWLSl27WlyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iirzeuqV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2984dfae0acso50657005ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 18:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763347520; x=1763952320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfDF6UQ4KgF1s2ORfk+YxpL9AkzEEjbU9rdg6qKctw4=;
        b=iirzeuqV8HPisCn8WYxoa+jjjYdGciPZruk80V/Rus0YTjjDODv3FLQgB85tOPGD7T
         Thc4SCBV1Dv4aL9poLPs8MpJNoAXIGFv8zGKXJ3ghBTAWUN7N/HeqVEODL7TkKtrE4H5
         osjUXhqHCjDxfEeJxsWQPm9d1Md58urEuDlCaNfLYbgDOgq6AhwHABq3Em3eSyDqYbsV
         dvenaSiXlg2IW/6IIftQzUU1id16psBSh15EN7p556Y8K5KhW53mf9m+lmimSbMERf3F
         bg0FG7hNsNhCODorm6MM/gr0Yz0vBkYNn+boCCJBln8+tHAQcmRjzc6jddk9JavsxXmp
         VTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763347520; x=1763952320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfDF6UQ4KgF1s2ORfk+YxpL9AkzEEjbU9rdg6qKctw4=;
        b=HFIjMNtylL1OYNjyQnkQ97e/3ACJRQl1o8D/e53RgPre8AdzY/2ll9OMBiySNi6jIV
         DH/hrkYrtIV/j6dUqN5EPvVBTYwu9cm4znKQ1xlch4vAIRBkt8fu15jSdFteEOAUaMl7
         ZK4TH3Nqmo1YZf3d/aiG53l6MAUeViT6GSdrFtdVGK5dnvohassVs9jYDmKK7VDjXq7A
         SV686soDiV+JHXlODPyJmfhrGC7YK1SgpwUSPInGh8YC90rduRHBjpu8YLc1r/gXaMq/
         qXQz6dmQpb7W1jIFIh5BkuAZhLbPNK+srGVyNg+rX2rMLbS0dfueFvu9VvYupUaC1oHj
         f7EA==
X-Gm-Message-State: AOJu0Yz4cAlC9lgHUsLdCxhpRWjIWXVwjb3GItpcC3KXG3GMfhUp5fhd
	Yw3Mw64WkRWpoExHKlRslMNcSSNPt97vJIWqnSbpUrgCCasqEth4JPAXzJ+ItaiU
X-Gm-Gg: ASbGncs0Na7HR0j7N9NmRKqezuqcFlAcmB4LJvoYcK61MKhd6QN6qEoAw5Ix/eDCNDk
	cnXrwSvYy9pbHF8+6RnYnKRQ2w9GDK4dWYkA5wUBM4Dwiijzxe6Y2Xp++NeuQLS7M22ppk2WiBa
	r597gp8rWUV4wu9AGnrJub58UjuYwK8iXaIL9+OPZyHmfKLrXqFEYh23VE87kjiMUezwKQPiRxY
	xdYQPsM30EsyagSGmLKkXK6GC82u8O/PwxmdYNVmD4vY5t6ujR9tCDD4dtVmCcMr1FL9A/Jz4I5
	6tMf1dJwkPNvzkWlqO8p9t++6GhnUrHMoDDteL2tR7jvwFW7WBR0QFJ12kL13sbgzkLlGCg08Hh
	irZfrtlwSn3SsIfcsUaMYK48h6x81WBpznBt04PGolHVBcGKqpqmPzVKC9Yd0o7xsxsz7pSwjF3
	ftQahbGkuEh/0c9Hk=
X-Google-Smtp-Source: AGHT+IFbtHvhMon0h1naDAwJd8VKEX7YWkc8ymm6tiKSlvxikPxouvA7u4uut1zE9U3o9iiE+Hg1lA==
X-Received: by 2002:a17:903:1a10:b0:272:dee1:c133 with SMTP id d9443c01a7336-2986a6d29a3mr135292465ad.22.1763347520216;
        Sun, 16 Nov 2025 18:45:20 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e5ef32asm85041885ad.39.2025.11.16.18.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 18:45:19 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net-next 2/3] netlink: specs: support ipv4-or-v6 for dual-stack fields
Date: Mon, 17 Nov 2025 02:44:56 +0000
Message-ID: <20251117024457.3034-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117024457.3034-1-liuhangbin@gmail.com>
References: <20251117024457.3034-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 1b255e1beabf ("tools: ynl: add ipv4-or-v6 display hint"), we
can display either IPv4 or IPv6 addresses for a single field based on the
address family. However, most dual-stack fields still use the ipv4 display
hint. This update changes them to use the new ipv4-or-v6 display hint and
converts IPv4-only fields to use the u32 type.

Field changes:
  - v4-or-v6
    - IFA_ADDRESS, IFA_LOCAL
    - IFLA_GRE_LOCAL, IFLA_GRE_REMOTE
    - IFLA_VTI_LOCAL, IFLA_VTI_REMOTE
    - IFLA_IPTUN_LOCAL, IFLA_IPTUN_REMOTE
    - NDA_DST
    - RTA_DST, RTA_SRC, RTA_GATEWAY, RTA_PREFSRC
    - FRA_SRC, FRA_DST
  - ipv4
    - IFA_BROADCAST
    - IFLA_GENEVE_REMOTE
    - IFLA_IPTUN_6RD_RELAY_PREFIX

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml    |  2 +-
 Documentation/netlink/genetlink.yaml      |  2 +-
 Documentation/netlink/netlink-raw.yaml    |  2 +-
 Documentation/netlink/specs/rt-addr.yaml  |  6 +++---
 Documentation/netlink/specs/rt-link.yaml  | 16 ++++++++--------
 Documentation/netlink/specs/rt-neigh.yaml |  2 +-
 Documentation/netlink/specs/rt-route.yaml |  8 ++++----
 Documentation/netlink/specs/rt-rule.yaml  |  6 ++++--
 8 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 5a234e9b5fa2..57f59fe23e3f 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -227,7 +227,7 @@ properties:
                   Optional format indicator that is intended only for choosing
                   the right formatting mechanism when displaying values of this
                   type.
-                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+                enum: [ hex, mac, fddi, ipv4, ipv6, ipv4-or-v6, uuid ]
               # Start genetlink-c
               name-prefix:
                 type: string
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 7b1ec153e834..b020a537d8ac 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -185,7 +185,7 @@ properties:
                   Optional format indicator that is intended only for choosing
                   the right formatting mechanism when displaying values of this
                   type.
-                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+                enum: [ hex, mac, fddi, ipv4, ipv6, ipv4-or-v6, uuid ]
 
       # Make sure name-prefix does not appear in subsets (subsets inherit naming)
       dependencies:
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 246fa07bccf6..0166a7e4afbb 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -157,7 +157,7 @@ properties:
                   Optional format indicator that is intended only for choosing
                   the right formatting mechanism when displaying values of this
                   type.
-                enum: [ hex, mac, fddi, ipv4, ipv6, uuid ]
+                enum: [ hex, mac, fddi, ipv4, ipv6, ipv4-or-v6, uuid ]
               struct:
                 description: Name of the nested struct type.
                 type: string
diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 3a582eac1629..abcbaa73fa9d 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -86,17 +86,17 @@ attribute-sets:
       -
         name: address
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: local
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: label
         type: string
       -
         name: broadcast
-        type: binary
+        type: u32
         display-hint: ipv4
       -
         name: anycast
diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index e07341582771..ca22c68ca691 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1707,11 +1707,11 @@ attribute-sets:
       -
         name: local
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: remote
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: ttl
         type: u8
@@ -1833,11 +1833,11 @@ attribute-sets:
       -
         name: local
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: remote
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: fwmark
         type: u32
@@ -1868,7 +1868,7 @@ attribute-sets:
         type: u32
       -
         name: remote
-        type: binary
+        type: u32
         display-hint: ipv4
       -
         name: ttl
@@ -1952,11 +1952,11 @@ attribute-sets:
       -
         name: local
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: remote
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: ttl
         type: u8
@@ -1986,7 +1986,7 @@ attribute-sets:
         display-hint: ipv6
       -
         name: 6rd-relay-prefix
-        type: binary
+        type: u32
         display-hint: ipv4
       -
         name: 6rd-prefixlen
diff --git a/Documentation/netlink/specs/rt-neigh.yaml b/Documentation/netlink/specs/rt-neigh.yaml
index 2f568a6231c9..0f46ef313590 100644
--- a/Documentation/netlink/specs/rt-neigh.yaml
+++ b/Documentation/netlink/specs/rt-neigh.yaml
@@ -194,7 +194,7 @@ attribute-sets:
       -
         name: dst
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: lladdr
         type: binary
diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 1ecb3fadc067..33195db96746 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -87,11 +87,11 @@ attribute-sets:
       -
         name: dst
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: src
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: iif
         type: u32
@@ -101,14 +101,14 @@ attribute-sets:
       -
         name: gateway
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: priority
         type: u32
       -
         name: prefsrc
         type: binary
-        display-hint: ipv4
+        display-hint: ipv4-or-v6
       -
         name: metrics
         type: nest
diff --git a/Documentation/netlink/specs/rt-rule.yaml b/Documentation/netlink/specs/rt-rule.yaml
index bebee452a950..7f03a44ab036 100644
--- a/Documentation/netlink/specs/rt-rule.yaml
+++ b/Documentation/netlink/specs/rt-rule.yaml
@@ -96,10 +96,12 @@ attribute-sets:
     attributes:
       -
         name: dst
-        type: u32
+        type: binary
+        display-hint: ipv4-or-v6
       -
         name: src
-        type: u32
+        type: binary
+        display-hint: ipv4-or-v6
       -
         name: iifname
         type: string
-- 
2.50.1


