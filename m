Return-Path: <netdev+bounces-237139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8EBC45CB3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306E33B981D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE395302158;
	Mon, 10 Nov 2025 10:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiN1NZuc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9D2580E4
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768855; cv=none; b=QcnvspAovbw8qW2ZMlykSoO228FYe8vR4lSLEKJWJ0Dru8u74Y3NZKR/JO59wTnYRoeLbaaNoFnadD6rtTWoXrIz7AZJP4XW6hRM9FEq2P77sebBilpKBq3FyHD4idu75MgJxx7o2WrfqWlUFJcK7+apYqTM1H3VWKJ3RifNe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768855; c=relaxed/simple;
	bh=jF6+f4VHYPFfbxVuSEwKtWGyRJz6vQKrSblN3QDZFtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmgnpeoaxtNYW9wdPWlFnSe/8XZzWx9lzgldTBdUWRdUQ/pCedpZBCZT4sE05zVc0QYq+kD9DIu4We87WxSIBEpV903Oyg2NRW0wHFy/q9Sf1QzRdtRfYmYHxUhdg3x5OBI0U89QIVilEeJ+A1sVL42/u/ysTaMB5ULzMsUAmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiN1NZuc; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3410c86070dso1833345a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 02:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762768853; x=1763373653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOV+SViZSkVcco5rjWA22mOXDB4/YYgVehIqb2PHnaw=;
        b=EiN1NZucMJIblUz+EKnzwmilAMdsoRNKk2YQ9IzX8RjMJtPxx8LW4fabvWC5FNRaQR
         6INsU+igv4z25Jbf7UdGjIMUiSRnV4ycS3Y0THuaOmIpG6Wsn2PqF2QV2bPzIJFq/r/A
         kaF9JvD6NjRwPFsRkc19kDfP2IQ9SPADkhxMs77zEjtYErp9sJvwWypgqsrTub0rutea
         xQ0lgPMe72YlQt2sP/7ixSxYTc1KeqsKEVS/CssP0vSbIn8GSfafVn+CClFtF3HH6VMu
         5lOFJhsLww0WcbeN2C9sxp7cAmNXtw1zV+oOE3K6tVT8DA6CHhYhD2qrADp1SqO+p6CS
         I2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768853; x=1763373653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XOV+SViZSkVcco5rjWA22mOXDB4/YYgVehIqb2PHnaw=;
        b=RZrIBMEvPwIxVLjYoQPR6wCJponNPT3Z2LXxfWCaxk1y5KQ5DnoxBG/OUqzrTp2Tv6
         EIun396hXoDTeoxZmDKiq+2C5GhANoowvHIhhuTn/bac3/sFUTTndixmipBe0OsxQ1L/
         yorYJx9ogHFqcQj0kzz51vB91E83pYBO0fhtn15OT7tOnP+ssSw4gsgbqfP81NG6wcml
         mlS3yCTmUReHbIj1/vC420evlFiIqhZ+U5VTgG1Q+OXKcp6jYHpRCFInSREiGcZm8uo/
         8yQo5tKehMDYkEUScpAlNJQtYJyJLJi9EmvBhLMLw5Ms+wbFSi7ieEDSweveaOfIS5P6
         hnNw==
X-Gm-Message-State: AOJu0YxYxElOc1j631LxvDSA15kwLBTciw3rYYYmnqulX9m+f+fNjRDn
	do+XPC2ka4ycIISm3kVdnvtfBSJEdX/aQx+nykoOe+zHVELFvSnMhFq8nLw9N7tc
X-Gm-Gg: ASbGncu5p2ypz8QE/qbEZMst+0asS7A1aF6zD6y9H0Teow5mGrDsuyxFPucjyQlv2Ca
	7Cz2hbIMWHKMx48qwV/AiVGxolIvk0PWRjzPdHIQmKLONR4d8pm+wcGtNTyHQfsti7LsHEMhwml
	FOk5x4ncU16ybWHH/y4ssXh1tK1Nf/TYyVx2KIynT7nlAOG9+/mgI4Qmkfnfrv8p1gX82JBoIAt
	YtIsU4MuEYwnjKk/lU2JzUKdaWSaF7+QH13Sz7gOhwDj2AhqnE2b8kzAG37YzQGpWk42X5GDSpC
	ySLftFbD1MGDn/Es0r8ODbQv1AFh5LPoc85b7HFhqcpAOIkDMcIh9LjjJ+oIpohKVWxZlSnrRxy
	v8Zr6iHP8VopfZhQJVkk3LufhzT3pXmRGG5/hlcfr0Jz9g2xBBlAU7GVx3xjlYOguUQ91oxm5fC
	xYDj1SHzM9SmCTAhE=
X-Google-Smtp-Source: AGHT+IENeaBKLYEtCDlMzjL4j4y3hXbN+4b2zIALoC7lR5uPgWkrIgoUuqEUQi8yPC2O2Q8GQtAyCQ==
X-Received: by 2002:a17:90b:4ccd:b0:33e:2d0f:4793 with SMTP id 98e67ed59e1d1-3436cb89b10mr9930703a91.11.1762768853305;
        Mon, 10 Nov 2025 02:00:53 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm10374405a91.13.2025.11.10.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:00:52 -0800 (PST)
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
Subject: [PATCHv3 net-next 2/3] netlink: specs: support ipv4-or-v6 for dual-stack fields
Date: Mon, 10 Nov 2025 09:59:59 +0000
Message-ID: <20251110100000.3837-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110100000.3837-1-liuhangbin@gmail.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
index 2a23e9699c0b..5bfdcb5afa86 100644
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
@@ -1923,11 +1923,11 @@ attribute-sets:
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
@@ -1957,7 +1957,7 @@ attribute-sets:
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


