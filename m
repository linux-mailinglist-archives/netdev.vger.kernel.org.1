Return-Path: <netdev+bounces-207316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A8B06A4A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADFBC7A8E9A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974E19DFAB;
	Wed, 16 Jul 2025 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmuPpW6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E960D19CC27
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624261; cv=none; b=DK3gpbg7d+i6k7B9jeh2EVVL5oU0soiUzTDe1v5qAQaqSC61mTDX/qkEvAnX7QrzSfQZwgvR5WMDqJIdvswuMQdsnX+GtPoLXKl5WEiU3W9siEw4WCW9AnyPB28qpXAqJFvaCycDVDQggQjl4Tb0oXUYjSJEP35HXuNFJfB2a2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624261; c=relaxed/simple;
	bh=9XCvWF5EcyViEo/tSybtdxr+r5QbuvAgFHqZA85sEUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgauZ8w6xI4bTAtn+UPFnCQTYH3MMdHOckDFOxrWHiD9vwI7NW9tNcOQXsLYcCsxo+sTOY5uHikiQtJm8erTPggAudbWFEGW6OxphsNBxoXNzlk8F+pfE7mtEJbA5RM6oS9Z+kf17kWaKf27MESlI66c9XeHvTqLADgI1fxJ58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmuPpW6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5305C4CEFA;
	Wed, 16 Jul 2025 00:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624260;
	bh=9XCvWF5EcyViEo/tSybtdxr+r5QbuvAgFHqZA85sEUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmuPpW6M/OjlMh9exVG7bQqEPqd5Zd1ZR7kMN8ZwShfM7AjDnYuF/aniz29QHt5Ph
	 c7ORoisIPhKeqVz9mmX2UixPJ74/ceyyXdanQGFQT+PPNsCOzoRBtTg6G378l4v6Ms
	 hgDXemvgipzsfwGCZfrKb8R1PCXZrTelMg7c2d9yeDIYuUpS3ymO+ihl2uMBx9lHq1
	 EoeTv6Qb9jf+/KJ1HQa//51srzI7EyG1PmOkzhwhE4Ewgddsxz1/2u/s4WJUksNRRw
	 CGT6BpZ3lcEh54gbIDecbFl3WkmJ/iJgWi2vrCqxNK/Fc8ECjWHS199h3phuPfWgf+
	 Cnsr/nhDd4L0g==
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
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 08/11] netlink: specs: define input-xfrm enum in the spec
Date: Tue, 15 Jul 2025 17:03:28 -0700
Message-ID: <20250716000331.1378807-9-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
References: <20250716000331.1378807-1-kuba@kernel.org>
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
   'input-xfrm': {'sym-or-xor'},                         <<<
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
v3:
 - make input xfrm a flags field
v2:
 - adjust the test to decoded values
---
 Documentation/netlink/specs/ethtool.yaml      | 21 +++++++++++++++++++
 .../drivers/net/hw/rss_input_xfrm.py          |  6 +++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index aa55fc9068e1..d0a9c4120a19 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -158,6 +158,26 @@ c-version-name: ethtool-genl-version
       -
         name: pse-event-sw-pw-control-error
         doc: PSE faced an error managing the power control from software
+  -
+    name: input-xfrm
+    doc: RSS hash function transformations.
+    type: flags
+    enum-name:
+    name-prefix: rxh-xfrm-
+    header: linux/ethtool.h
+    entries:
+      -
+        name: sym-xor
+        doc: >-
+          XOR the corresponding source and destination fields of each specified
+          protocol. Both copies of the XOR'ed fields are fed into the RSS and
+          RXHASH calculation. Note that this XORing reduces the input set
+          entropy and could be exploited to reduce the RSS queue spread.
+      -
+        name: sym-or-xor
+        doc: >-
+          Similar to SYM_XOR, except that one copy of the XOR'ed fields is
+          replaced by an OR of the same fields.
   -
     name: rxfh-fields
     name-prefix: rxh-
@@ -1621,6 +1641,7 @@ c-version-name: ethtool-genl-version
       -
         name: input-xfrm
         type: u32
+        enum: input-xfrm
       -
         name: start-context
         type: u32
diff --git a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
index 648ff50bc1c3..6e90fb290564 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
@@ -37,11 +37,11 @@ from lib.py import rand_port
     if not hasattr(socket, "SO_INCOMING_CPU"):
         raise KsftSkipEx("socket.SO_INCOMING_CPU was added in Python 3.11")
 
-    input_xfrm = cfg.ethnl.rss_get(
-        {'header': {'dev-name': cfg.ifname}}).get('input-xfrm')
+    rss = cfg.ethnl.rss_get({'header': {'dev-name': cfg.ifname}})
+    input_xfrm = set(filter(lambda x: 'sym' in x, rss.get('input-xfrm', {})))
 
     # Check for symmetric xor/or-xor
-    if not input_xfrm or (input_xfrm != 1 and input_xfrm != 2):
+    if not input_xfrm:
         raise KsftSkipEx("Symmetric RSS hash not requested")
 
     cpus = set()
-- 
2.50.1


