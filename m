Return-Path: <netdev+bounces-250322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 579A9D28AB7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 22:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DEFF3031CF6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A18131ED72;
	Thu, 15 Jan 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QMFAfxuk"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFE2D0298;
	Thu, 15 Jan 2026 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511493; cv=none; b=QUwvjB+BtcCbKvoTrkVujKeFFV0Wpis/q0+ZX5KRKy+zFsRwQ6q2GZOCReFewPsY0VkAITmqUJ93dwrF2ndSlb2qd8TdBVh3vjHWOX+jryVTqVKtH0UmgNLTPfYsMBtOwhbU/7Eo51aNcBu5H9FOUCamnk5oxQ/YAhMm1agS4tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511493; c=relaxed/simple;
	bh=KF0R/gDJpkoxYLzmZ3oOaOT27TcsbydoZPtKtU2/eHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRj1cYWDyLZgemi5ZD5EeIb0g7hYXau4+rZhNPuBQHB9GOR2wDbZEjtfRrmitR25PVnXCu2ToIPRVe9/9DiRGGFRI5oyk9/mwAnDF7ZB633WLXeOQaLGrk4W9EiReGVZUfBb2G0zLt54DEgA4/TobThxxVLPNKKJubtpTkKComA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QMFAfxuk; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1768511486;
	bh=KF0R/gDJpkoxYLzmZ3oOaOT27TcsbydoZPtKtU2/eHM=;
	h=From:To:Cc:Subject:Date:From;
	b=QMFAfxukOYMVGfoRJbBNBmTmtt2fJkDmx8U8kzJ+yFHJj5HJw9PiDl2argFKEDz05
	 YITpzxn0BPiQWwIlVQADNjGTQxLwoAQZNOKOkyGFRT5kQeMytZOjZMFgwE9U/XIkoY
	 dAWmgpo9NSEpadNT7OW7pQSe2ettuPjxFG47SjGUWgVEI5XEzckG7W+N4Uf/xu8yxm
	 UZmWPfWjTRQ83/hrWRYSP+PnCkBHhJ1APgZZhPD3YcUnxXbbJRB7jwGQ6jpxc/sbFO
	 qRwTOTx9YZxZ3th/q/ONVbxhDw+70DENwVrsnN5gGsUOesh2JAhKK3EtpPz6097Mq6
	 oZw/MEdPM+HhA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 1E71C60075;
	Thu, 15 Jan 2026 21:10:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 606EA2020D7; Thu, 15 Jan 2026 21:10:45 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireguard v5] tools: ynl: add sample for wireguard
Date: Thu, 15 Jan 2026 21:10:31 +0000
Message-ID: <20260115211032.204481-1-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a sample application for WireGuard, using the generated C library.

The main benefit of this is to exercise the generated library,
which might be useful for future self-tests.

Example:
  $ make -C tools/net/ynl/lib
  $ make -C tools/net/ynl/generated
  $ make -C tools/net/ynl/samples wireguard
  $ ./tools/net/ynl/samples/wireguard
  usage: ./tools/net/ynl/samples/wireguard <ifindex|ifname>
  $ sudo ./tools/net/ynl/samples/wireguard wg-test
  Interface 3: wg-test
      Peer 6adfb183a4a2c94a2f92dab5ade762a4788[...]:
          Data: rx: 42 / tx: 42 bytes
          Allowed IPs:
              0.0.0.0/0
              ::/0

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
v5:
- The series was applied, except patch 09 which had a leaky error path.
  The leak was fixed, so wireguard_get_device_req_free() is always called.
- The Makefile.deps changes was removed (commited in db6b35cffe59).
- The ynl_sock_create() is now given an struct ynl_error pointer.

v4: https://lore.kernel.org/r/20251126173546.57681-1-ast@fiberby.net/
- Thanks Jason and Jakub for all the feedback.
- Old patch 03 has been accepted into Jason's tree.
- Old patch 09 split_ops conversion has been moved to new 03.
- Old patch 10 function renaming was merged into old patch 11 (new 10).
- Patch 04 has been added to adjust .maxattr for GET_DEVICE.
- The old patches 04-08 and 11 was renumbered to patch 05-10.
- Changes to the spec:
  - Re-wrap the documentation lines in the spec.
  - Reword the index/type documentation.
  - get-device now have a more strict request attribute list.
  - The pre/post functions now avoids renaming.
- Changes to patch 10 (was 10+11):
  - The generated kernel code now uses YNL-ARG --function-prefix,
    to reduce the function renaming.
  - The generated files have been moved to their own sub-directory.
- The commit messages have in general been tweaked a bit.

v3: https://lore.kernel.org/r/20251105183223.89913-1-ast@fiberby.net/
- Spec: Make flags-mask checks implicit (thanks Jakub).
- Sample: Add header to Makefile.deps, and avoid copy (thanks Jakub).

v2: https://lore.kernel.org/r/20251031160539.1701943-1-ast@fiberby.net/
- Add missing forward declaration

v1: https://lore.kernel.org/r/20251029205123.286115-1-ast@fiberby.net/
- Policy arguement to nla_parse_nested() changed to NULL (thanks Johannes).
- Added attr-cnt-name to the spec, to reduce the diff a bit.
- Refined the doc in the spec a bit.
- Reword commit messages a bit.
- Reordered the patches, and reduced the series from 14 to 11 patches.

RFC: https://lore.kernel.org/r/20250904-wg-ynl-rfc@fiberby.net/

---
 MAINTAINERS                       |   1 +
 tools/net/ynl/samples/.gitignore  |   1 +
 tools/net/ynl/samples/wireguard.c | 106 ++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 tools/net/ynl/samples/wireguard.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d38dcab1fa068..f2a68bfc45963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28113,6 +28113,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/netlink/specs/wireguard.yaml
 F:	drivers/net/wireguard/
+F:	tools/net/ynl/samples/wireguard.c
 F:	tools/testing/selftests/wireguard/
 
 WISTRON LAPTOP BUTTON DRIVER
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index 05087ee323ba2..6fbed294feac0 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -8,3 +8,4 @@ rt-link
 rt-route
 tc
 tc-filter-add
+wireguard
diff --git a/tools/net/ynl/samples/wireguard.c b/tools/net/ynl/samples/wireguard.c
new file mode 100644
index 0000000000000..df601e742c287
--- /dev/null
+++ b/tools/net/ynl/samples/wireguard.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
+#include <string.h>
+#include <stdio.h>
+#include <errno.h>
+#include <ynl.h>
+
+#include "wireguard-user.h"
+
+static void print_allowed_ip(const struct wireguard_wgallowedip *aip)
+{
+	char addr_out[INET6_ADDRSTRLEN];
+
+	if (!inet_ntop(aip->family, aip->ipaddr, addr_out, sizeof(addr_out))) {
+		addr_out[0] = '?';
+		addr_out[1] = '\0';
+	}
+	printf("\t\t\t%s/%u\n", addr_out, aip->cidr_mask);
+}
+
+/* Only printing public key in this demo. For better key formatting,
+ * use the constant-time implementation as found in wireguard-tools.
+ */
+static void print_peer_header(const struct wireguard_wgpeer *peer)
+{
+	unsigned int len = peer->_len.public_key;
+	uint8_t *key = peer->public_key;
+	unsigned int i;
+
+	if (len != 32)
+		return;
+	printf("\tPeer ");
+	for (i = 0; i < len; i++)
+		printf("%02x", key[i]);
+	printf(":\n");
+}
+
+static void print_peer(const struct wireguard_wgpeer *peer)
+{
+	unsigned int i;
+
+	print_peer_header(peer);
+	printf("\t\tData: rx: %llu / tx: %llu bytes\n",
+	       peer->rx_bytes, peer->tx_bytes);
+	printf("\t\tAllowed IPs:\n");
+	for (i = 0; i < peer->_count.allowedips; i++)
+		print_allowed_ip(&peer->allowedips[i]);
+}
+
+static void build_request(struct wireguard_get_device_req *req, char *arg)
+{
+	char *endptr;
+	int ifindex;
+
+	ifindex = strtol(arg, &endptr, 0);
+	if (endptr != arg + strlen(arg) || errno != 0)
+		ifindex = 0;
+	if (ifindex > 0)
+		wireguard_get_device_req_set_ifindex(req, ifindex);
+	else
+		wireguard_get_device_req_set_ifname(req, arg);
+}
+
+int main(int argc, char **argv)
+{
+	struct wireguard_get_device_list *devs;
+	struct wireguard_get_device_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <ifindex|ifname>\n", argv[0]);
+		return 1;
+	}
+
+	ys = ynl_sock_create(&ynl_wireguard_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return 2;
+	}
+
+	req = wireguard_get_device_req_alloc();
+	build_request(req, argv[1]);
+
+	devs = wireguard_get_device_dump(ys, req);
+	if (!devs) {
+		fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
+		wireguard_get_device_req_free(req);
+		ynl_sock_destroy(ys);
+		return 3;
+	}
+
+	ynl_dump_foreach(devs, d) {
+		unsigned int i;
+
+		printf("Interface %d: %s\n", d->ifindex, d->ifname);
+		for (i = 0; i < d->_count.peers; i++)
+			print_peer(&d->peers[i]);
+	}
+
+	wireguard_get_device_list_free(devs);
+	wireguard_get_device_req_free(req);
+	ynl_sock_destroy(ys);
+
+	return 0;
+}
-- 
2.51.0


