Return-Path: <netdev+bounces-32816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6779A806
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738902810A9
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5E8C8DB;
	Mon, 11 Sep 2023 12:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16820F9F5
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B71BC433C7;
	Mon, 11 Sep 2023 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694436613;
	bh=Ij41ybCGuDW0ic6HLnKIf1eYLQndXU6pbAajOQ4+vXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=stTHYRxvHDPDSjFwPMtpr7/MlXXVZ3LxFflhK/TPwk2F8Y8eQeVZA32wHDPB7vySi
	 IHGkonIhvdRypf4dryir+PQXOvOFCpF6ap1BNfm1fOBfbzWxcMEzQ0+b6kUd7jkC5M
	 GJ2ftRgtZVY7p55r4TgcwWC/azL6uQAIOM6uqx/E5SpSeXnzVEPlVFGu0kvXEJLe2Z
	 7aTCM2/MyptgrTZygw1nbDFGG3QGW+t3J/MbC0XpdMLP2lYeKOc4IyoZsjeLycir8H
	 5aIAOGBX+yWw10o2sAzl7cvJqCPvvWu4JCIShA929vfNQuJmgoc6yT4PRRTBAM2bH0
	 a6K3xo4Vdw+vg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	netdev@vger.kernel.org
Subject: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for nfsd_server
Date: Mon, 11 Sep 2023 14:49:44 +0200
Message-ID: <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce nfsd_server.yaml specs to generate uAPI and netlink
code for nfsd server.
Add rpc-status specs to define message reported by the nfsd server
dumping the pending RPC requests.

Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/netlink/specs/nfsd_server.yaml | 97 ++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/netlink/specs/nfsd_server.yaml

diff --git a/Documentation/netlink/specs/nfsd_server.yaml b/Documentation/netlink/specs/nfsd_server.yaml
new file mode 100644
index 000000000000..e681b493847b
--- /dev/null
+++ b/Documentation/netlink/specs/nfsd_server.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+name: nfsd_server
+
+doc:
+  nfsd server configuration over generic netlink.
+
+attribute-sets:
+  -
+    name: rpc-status-comp-op-attr
+    enum-name: nfsd-rpc-status-comp-attr
+    name-prefix: nfsd-attr-rpc-status-comp-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: op
+        type: u32
+  -
+    name: rpc-status-attr
+    enum-name: nfsd-rpc-status-attr
+    name-prefix: nfsd-attr-rpc-status-
+    attributes:
+      -
+        name: unspec
+        type: unused
+        value: 0
+      -
+        name: xid
+        type: u32
+        byte-order: big-endian
+      -
+        name: flags
+        type: u32
+      -
+        name: prog
+        type: u32
+      -
+        name: version
+        type: u8
+      -
+        name: proc
+        type: u32
+      -
+        name: service_time
+        type: s64
+      -
+        name: pad
+        type: pad
+      -
+        name: saddr4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: daddr4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: saddr6
+        type: binary
+        display-hint: ipv6
+      -
+        name: daddr6
+        type: binary
+        display-hint: ipv6
+      -
+        name: sport
+        type: u16
+        byte-order: big-endian
+      -
+        name: dport
+        type: u16
+        byte-order: big-endian
+      -
+        name: compond-op
+        type: array-nest
+        nested-attributes: rpc-status-comp-op-attr
+
+operations:
+  enum-name: nfsd-commands
+  name-prefix: nfsd-cmd-
+  list:
+    -
+      name: unspec
+      doc: unused
+      value: 0
+    -
+      name: rpc-status-get
+      doc: dump pending nfsd rpc
+      attribute-set: rpc-status-attr
+      dump:
+        pre: nfsd-server-nl-rpc-status-get-start
+        post: nfsd-server-nl-rpc-status-get-done
-- 
2.41.0


