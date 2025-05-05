Return-Path: <netdev+bounces-187785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A04AA9A02
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC7F17DF04
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D2926D4E8;
	Mon,  5 May 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfNiySAZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2D26D4D9
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746464549; cv=none; b=fUb1yBaod+8E1ju1Kv3cPn7drRsLGozyyNWrYB5l0azQ2SlsIhRkbLT07LVSVZuwKbvHD8F91PbCHZeRnm1LLZq4ZbJwg6g8RcGMNnp6fD29/M854okDKlSywmOLJpRRfSi8PdaQ16B9mNJdVpSYoe4YI/IAGxizOszwxOSIKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746464549; c=relaxed/simple;
	bh=Ih42Gdpb8IAcr7RWYmBWGj9ZyhDoIzHGjTl8K6pldSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyyywOIZGBDiV8fbqoDlI7sHeWsmcVwFeArr/YJ1GR8hndkR68e1LdclQvI4ozmHasTJANv9o9ydie/uSaBiMXZGA0xQwyplerrKFd2um2l6FZTyQpO/aUrQNN0xvkeBuSRX3K0iln8ZCp50hd2hEj9oXJj7XsBY7R/M2LFvZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfNiySAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B1C4CEF5;
	Mon,  5 May 2025 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746464549;
	bh=Ih42Gdpb8IAcr7RWYmBWGj9ZyhDoIzHGjTl8K6pldSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LfNiySAZ7gOc3uMCEFRnkOpnewbmmeEs5A7mq3RKz2ZfNQTsBHMVqL3t3c38oAf58
	 pe45Fx2ZOG3ZUOm/S/uik4HXxFNP23bGJbDxZBxMWrn/JW6Brfk0IGb0Vqo/Fesdof
	 Tu3g+9L2gfNO0VyiEK4X879T2b0T9l0Wf/R/jTz6x4wQ51DbCg6KBuyDdPPHNmXEQv
	 ksxa2VtVin4B9IrUZDKJws6XgIWmHyaZwemXZRAziRXFB11/tUY4D2gRpOF198UPAo
	 2s+R3+OgTlPyqGP5FyQzvRCobpxHqhQCwFHWQzKwDhlFJPf+5iF2jbDc7UqBkwPKpe
	 23yTvVIYyZf7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	johannes@sipsolutions.net,
	razor@blackwall.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] netlink: specs: rt-link: remove implicit structs from devconf
Date: Mon,  5 May 2025 10:02:15 -0700
Message-ID: <20250505170215.253672-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250505170215.253672-1-kuba@kernel.org>
References: <20250505170215.253672-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devconf is even odder than SNMP. On input it reports an array of u32s
which seem to be indexed by the enum values - 1. On output kernel
expects a nest where each attr has the enum type as the nla type.

sub-type: u32 is probably best we can do right now.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 107 +++--------------------
 1 file changed, 10 insertions(+), 97 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 2fbf4ac55c9c..5ec3d35b7a38 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -304,285 +304,196 @@ protonum: 0
         type: u8
   -
     name: ipv4-devconf
-    type: struct
-    members:
+    enum-name:
+    type: enum
+    entries:
       -
         name: forwarding
-        type: u32
       -
         name: mc-forwarding
-        type: u32
       -
         name: proxy-arp
-        type: u32
       -
         name: accept-redirects
-        type: u32
       -
         name: secure-redirects
-        type: u32
       -
         name: send-redirects
-        type: u32
       -
         name: shared-media
-        type: u32
       -
         name: rp-filter
-        type: u32
       -
         name: accept-source-route
-        type: u32
       -
         name: bootp-relay
-        type: u32
       -
         name: log-martians
-        type: u32
       -
         name: tag
-        type: u32
       -
         name: arpfilter
-        type: u32
       -
         name: medium-id
-        type: u32
       -
         name: noxfrm
-        type: u32
       -
         name: nopolicy
-        type: u32
       -
         name: force-igmp-version
-        type: u32
       -
         name: arp-announce
-        type: u32
       -
         name: arp-ignore
-        type: u32
       -
         name: promote-secondaries
-        type: u32
       -
         name: arp-accept
-        type: u32
       -
         name: arp-notify
-        type: u32
       -
         name: accept-local
-        type: u32
       -
         name: src-vmark
-        type: u32
       -
         name: proxy-arp-pvlan
-        type: u32
       -
         name: route-localnet
-        type: u32
       -
         name: igmpv2-unsolicited-report-interval
-        type: u32
       -
         name: igmpv3-unsolicited-report-interval
-        type: u32
       -
         name: ignore-routes-with-linkdown
-        type: u32
       -
         name: drop-unicast-in-l2-multicast
-        type: u32
       -
         name: drop-gratuitous-arp
-        type: u32
       -
         name: bc-forwarding
-        type: u32
       -
         name: arp-evict-nocarrier
-        type: u32
   -
     name: ipv6-devconf
-    type: struct
-    members:
+    enum-name:
+    type: enum
+    entries:
       -
         name: forwarding
-        type: u32
       -
         name: hoplimit
-        type: u32
       -
         name: mtu6
-        type: u32
       -
         name: accept-ra
-        type: u32
       -
         name: accept-redirects
-        type: u32
       -
         name: autoconf
-        type: u32
       -
         name: dad-transmits
-        type: u32
       -
         name: rtr-solicits
-        type: u32
       -
         name: rtr-solicit-interval
-        type: u32
       -
         name: rtr-solicit-delay
-        type: u32
       -
         name: use-tempaddr
-        type: u32
       -
         name: temp-valid-lft
-        type: u32
       -
         name: temp-prefered-lft
-        type: u32
       -
         name: regen-max-retry
-        type: u32
       -
         name: max-desync-factor
-        type: u32
       -
         name: max-addresses
-        type: u32
       -
         name: force-mld-version
-        type: u32
       -
         name: accept-ra-defrtr
-        type: u32
       -
         name: accept-ra-pinfo
-        type: u32
       -
         name: accept-ra-rtr-pref
-        type: u32
       -
         name: rtr-probe-interval
-        type: u32
       -
         name: accept-ra-rt-info-max-plen
-        type: u32
       -
         name: proxy-ndp
-        type: u32
       -
         name: optimistic-dad
-        type: u32
       -
         name: accept-source-route
-        type: u32
       -
         name: mc-forwarding
-        type: u32
       -
         name: disable-ipv6
-        type: u32
       -
         name: accept-dad
-        type: u32
       -
         name: force-tllao
-        type: u32
       -
         name: ndisc-notify
-        type: u32
       -
         name: mldv1-unsolicited-report-interval
-        type: u32
       -
         name: mldv2-unsolicited-report-interval
-        type: u32
       -
         name: suppress-frag-ndisc
-        type: u32
       -
         name: accept-ra-from-local
-        type: u32
       -
         name: use-optimistic
-        type: u32
       -
         name: accept-ra-mtu
-        type: u32
       -
         name: stable-secret
-        type: u32
       -
         name: use-oif-addrs-only
-        type: u32
       -
         name: accept-ra-min-hop-limit
-        type: u32
       -
         name: ignore-routes-with-linkdown
-        type: u32
       -
         name: drop-unicast-in-l2-multicast
-        type: u32
       -
         name: drop-unsolicited-na
-        type: u32
       -
         name: keep-addr-on-down
-        type: u32
       -
         name: rtr-solicit-max-interval
-        type: u32
       -
         name: seg6-enabled
-        type: u32
       -
         name: seg6-require-hmac
-        type: u32
       -
         name: enhanced-dad
-        type: u32
       -
         name: addr-gen-mode
-        type: u8
       -
         name: disable-policy
-        type: u32
       -
         name: accept-ra-rt-info-min-plen
-        type: u32
       -
         name: ndisc-tclass
-        type: u32
       -
         name: rpl-seg-enabled
-        type: u32
       -
         name: ra-defrtr-metric
-        type: u32
       -
         name: ioam6-enabled
-        type: u32
       -
         name: ioam6-id
-        type: u32
       -
         name: ioam6-id-wide
-        type: u32
       -
         name: ndisc-evict-nocarrier
-        type: u32
       -
         name: accept-untracked-na
-        type: u32
   -
     name: ifla-icmp6-stats
     enum-name:
@@ -2147,7 +2058,8 @@ protonum: 0
       -
         name: conf
         type: binary
-        struct: ipv4-devconf
+        sub-type: u32
+        doc: u32 indexed by ipv4-devconf - 1 on output, on input it's a nest
   -
     name: ifla6-attrs
     name-prefix: ifla-inet6-
@@ -2158,7 +2070,8 @@ protonum: 0
       -
         name: conf
         type: binary
-        struct: ipv6-devconf
+        sub-type: u32
+        doc: u32 indexed by ipv6-devconf - 1 on output, on input it's a nest
       -
         name: stats
         type: binary
-- 
2.49.0


