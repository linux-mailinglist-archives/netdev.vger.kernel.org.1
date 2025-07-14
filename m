Return-Path: <netdev+bounces-206881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C54B04A9B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 649E74A2BDF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C7327A914;
	Mon, 14 Jul 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJlvhrHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530E27A468
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532073; cv=none; b=A6wJ6AUcG8N91/a7XjlVzytblPgxtYxwVThPxaAJ6A5nkVnq5q3YmR7JYeCeJ4OX+6bCMDnZxSVhGsmKnVrdzLp+AZwVuR3QWXSWwL+dowg+y+w6qHxDW+u7IJGZqJLuc6l02QOxv1O9lVbFJYvIuYMQ4d3QfhXxnxSnqNnIz4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532073; c=relaxed/simple;
	bh=Fa8hoLeSrsuYDam7LKJFUgkSfEBwYiUBjpHR0xgonpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODv6b5S+RONPybq3RiEDekIbwlR8w5KUbexrgtO4YstXxfPmMlPupSf8GyE5qgk4+Z3MN87TGNWadn5PsopXekaM149/uRvVEyQm2S7Y2+cjfhH29iQvfy9ndHwonleyw8kbu3OD3ucuDWiEC6DdUtuR//WOOFpmxOy3zG/9FEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJlvhrHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB30C4CEF0;
	Mon, 14 Jul 2025 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532073;
	bh=Fa8hoLeSrsuYDam7LKJFUgkSfEBwYiUBjpHR0xgonpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJlvhrHQ9bYNjV3JK4xwX4EnxHMfIitYldsFmbcwmDfsEeXi7wtZaH0VRSQMCGFzU
	 Y1NNau0+npEicoBqHvUd4IY8eytzfgdiqmi3/Ud9cda/V5cWGUnjc1r4rnyK4rIo1B
	 1ykBhLm1ukpI6ZBPOQHYd6e2M3i8xi2Vcl0UiBzu95wSmQkJ/CYzCe/M/NiJ6TZ/sa
	 qL2NlhKUomYtt03W+557eh6cxRe7LmDVFf9DSRxQgFXZBM1U7Dsx4uHbRqmr7cpdhO
	 ZeBMOgWyqc4G6Y5I1yOjZ2vBgrgcs1s1ab8QLqLPoysOYNIVzcbubcSTPNo4jtgHuL
	 uSnh7aEWctncQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 08/11] netlink: specs: define input-xfrm enum in the spec
Date: Mon, 14 Jul 2025 15:27:26 -0700
Message-ID: <20250714222729.743282-9-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714222729.743282-1-kuba@kernel.org>
References: <20250714222729.743282-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Help YNL decode the values for input-xfrm by defining
the possible values in the spec. Don't define "no change"
as it's an IOCTL artifact with no use in Netlink.

With this change on mlx5 input-xfrm gets decoded:

 # ynl --family ethtool --dump rss-get
 [{'header': {'dev-index': 2, 'dev-name': 'eth0'},
   'hfunc': 1,
   'hkey': b'V\xa8\xf9\x9 ...',
   'indir': [0, 1, ... ],
   'input-xfrm': 'sym-or-xor',                         <<<
   'flow-hash': {'ah4': {'ip-dst', 'ip-src'},
                 'ah6': {'ip-dst', 'ip-src'},
                 'esp4': {'ip-dst', 'ip-src'},
                 'esp6': {'ip-dst', 'ip-src'},
                 'ip4': {'ip-dst', 'ip-src'},
                 'ip6': {'ip-dst', 'ip-src'},
                 'tcp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
                 'tcp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
                 'udp4': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'},
                 'udp6': {'l4-b-0-1', 'ip-dst', 'l4-b-2-3', 'ip-src'}}
 }]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - adjust the test to decoded values
---
 Documentation/netlink/specs/ethtool.yaml      | 23 +++++++++++++++++++
 .../drivers/net/hw/rss_input_xfrm.py          |  2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index aa55fc9068e1..3a0453a92300 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -158,6 +158,28 @@ c-version-name: ethtool-genl-version
       -
         name: pse-event-sw-pw-control-error
         doc: PSE faced an error managing the power control from software
+  -
+    name: input-xfrm
+    doc: RSS hash function transformations.
+    type: enum
+    enum-name:
+    name-prefix: rxh-xfrm-
+    header: linux/ethtool.h
+    entries:
+      -
+        name: sym-xor
+        value: 1
+        doc: >-
+          XOR the corresponding source and destination fields of each specified
+          protocol. Both copies of the XOR'ed fields are fed into the RSS and
+          RXHASH calculation. Note that this XORing reduces the input set
+          entropy and could be exploited to reduce the RSS queue spread.
+      -
+        name: sym-or-xor
+        value: 2
+        doc: >-
+          Similar to SYM_XOR, except that one copy of the XOR'ed fields is
+          replaced by an OR of the same fields.
   -
     name: rxfh-fields
     name-prefix: rxh-
@@ -1621,6 +1643,7 @@ c-version-name: ethtool-genl-version
       -
         name: input-xfrm
         type: u32
+        enum: input-xfrm
       -
         name: start-context
         type: u32
diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
index 648ff50bc1c3..d647a66fa30e 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -41,7 +41,7 @@ from lib.py import rand_port
         {'header': {'dev-name': cfg.ifname}}).get('input-xfrm')
 
     # Check for symmetric xor/or-xor
-    if not input_xfrm or (input_xfrm != 1 and input_xfrm != 2):
+    if not input_xfrm or 'sym' not in input_xfrm:
         raise KsftSkipEx("Symmetric RSS hash not requested")
 
     cpus = set()
-- 
2.50.1


