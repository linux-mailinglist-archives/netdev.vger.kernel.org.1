Return-Path: <netdev+bounces-238573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3576EC5B3AE
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 04:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC173B702D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516DC266B46;
	Fri, 14 Nov 2025 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr6/BTVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E25D219313
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763092041; cv=none; b=VT2kZM3oG68WNZhzB+W1b7fGE6DI862beXhe4labVboF7mysSpOGJLRt6/6POExpXSHsQElqxH+1wKsffMl55LhGVsnAG4lQi4yBhTjOuhZy5Ha2LO+Kw1nsyQLOQeVJuSJSjlz1BwH3u/iuV57KR2Hii9uvlp6q/vBbhj1D8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763092041; c=relaxed/simple;
	bh=aZZIhhWiofvgkcAHqoG5f1gDDUjhtnHv6mLmQstFopQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvgmKiIP4tcoCxEqw430d/qvHCqI+2hBfeThCORtyOU+VtUET/YkSImrERN+4x3pHiT/mRHmReGx4eChQhDjIO3/kU2BrbYFRSGvA6n2LaS3/XpxFc8A5E3Af3nWTLaqb7XsD/4YHSGwKhje9hHw22JCvVGA4yskV6D9PffuP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr6/BTVq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so1490875a91.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 19:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763092038; x=1763696838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfDF6UQ4KgF1s2ORfk+YxpL9AkzEEjbU9rdg6qKctw4=;
        b=Rr6/BTVqwJ/MFiDRphgDjwkKWPF+aA0YB+uVPDwJy3GEKuWApyFQMhy1Otzw4cIs5D
         3IBTzUQnFon2XSsUBpBafAn/Ir8z8fA7EsljbY0QrVNwJZHWWZzztyEkXLpajAO3MyPn
         gBP17/TQZKOO5c3uYkPMMx/6yG6JzPhthjJ37bMfwImvE83od5q+4jOxu0aWTzYgEs1Q
         wR0NhGuJqtnMGtjjErl8Tto9MUOgmFVZHJ6i44LiuLxAYxL4JG/mEpCBhdn/gDfQecIl
         iXoorlaqEkVSeB/hW3d52vin31VhVG0TfAtAe/69wQ7g8zPiHslBlzJuOfKiqm5coxMk
         k/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763092038; x=1763696838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfDF6UQ4KgF1s2ORfk+YxpL9AkzEEjbU9rdg6qKctw4=;
        b=wTKbHrQglw+c5MFfPsFNieQ1RUvFpHetX1ld7Wo/Q9w23Wx72C4avhDZkmZWm3l646
         SMFgchJ9uhuj4oPhY1XCwX1VJJqatQGhbnCS670w2u7zIhiUWQE7RM9FT9xT4n5tw8/H
         ddqhuO0OtyyXfRlvlNm8N4r7jcelGSzopj6UyNlkWnzG5TyBzJYRHDEMVDX8iSCVF9AY
         x1+ixpvIaZXNTsBR4ottvV/UoTTAVVprrd3QCGKtmpI77WfCze4ZFZXjDOzL/Ir3isGE
         +PD/6R1/hcofnweg0iQAKfBZbIzQcONnm7Z5DsU7NkJLaNaw7DTTbw5dXMgFyLZ7dSjm
         o84g==
X-Gm-Message-State: AOJu0Yy/6qsVFNAzUfp2cqNWJALW7eW9jT4ANhVhq8xSoKlH1HeSpR7B
	36+36lNjv0lDvm5cEjL9B4O5eWYOAQU36aoJaSrRSSu9D4qbLxhFX1g9i1SlkfO/FBA=
X-Gm-Gg: ASbGncu2dxV7yuahPEc0l4K/1+YwDUkKvcIaKRj2BzngBK6e3ARj0pLd9ZF63tI7GoA
	vGSn1ZV2pk/+rn4CF8FCq/6V9S4sZb7hulDslrpeofVuuMfITf/G8W89fwrByT4/b/S5xk1fcIl
	7l0Xjbt4r+ME4gc6SNnqGkSq4Pm9Jqz2y+xqnMJefesKehsP5TZONW9QZpgkWVDbikElvUHfIE1
	c9k+HMo8il2K5mLAkW4VsflUCL0TLLfBjgiEKquGDgSW//XHbU7in66kMIlRiAuiTxWGIk/PXOi
	wlgG35hIL7oktcDPpMMMhi3nfIPG0hvXYn60Cp9ntLe7v/vFNS5w0//n/o8LsgvjyUk1yOoPYBl
	Syzx5FZx3tRdXPcSCBJ0qI0hJSGjW7sEvGr6nDuHmaAO/JasdsARd1/QLlA+ppQu2tWL4PxkP3P
	PNhu39
X-Google-Smtp-Source: AGHT+IEHJ4pqnsoBdxPR5hM09i5YfQBVkvbFVl0h1GhGNqRvzm397gzbQ/BoZAVWH74+XwAF5g5DQg==
X-Received: by 2002:a17:90b:4d11:b0:343:c3d1:8b9b with SMTP id 98e67ed59e1d1-343fa62be87mr1760124a91.19.1763092038496;
        Thu, 13 Nov 2025 19:47:18 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927826273sm3669756b3a.52.2025.11.13.19.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 19:47:18 -0800 (PST)
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
Subject: [PATCHv4 net-next 2/3] netlink: specs: support ipv4-or-v6 for dual-stack fields
Date: Fri, 14 Nov 2025 03:46:50 +0000
Message-ID: <20251114034651.22741-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251114034651.22741-1-liuhangbin@gmail.com>
References: <20251114034651.22741-1-liuhangbin@gmail.com>
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


