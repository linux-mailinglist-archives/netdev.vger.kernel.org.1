Return-Path: <netdev+bounces-220145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D28CB4490D
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EF2A47ECF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7A2E5437;
	Thu,  4 Sep 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fHcq7dvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2A2DE6FA;
	Thu,  4 Sep 2025 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023411; cv=none; b=VC27VrXnySinll455Bd+sYezG6RWCLqusr2/+2nFz7g85+M56yuETNQ9n5wFuyGShZQkMRjrXcAx17iaJobfRx0C7BKzWLOqXEEdbRrxJi6PvZ/f7cyceck4czdWeTICRLmddLORkvUtyvjU0zHA8Dkqh1uZBLUdv81phDaDQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023411; c=relaxed/simple;
	bh=oSNm5eg5gYI2AKFp3yCBDv0gEfrms2mI0sAqlg7aafw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHs/Fn7XtRdDegB7CAmtiT6T/CJAMJe2A180E7VfmtSb/q1KIiIvrKQ4hswxuW8vMAsNEYBw1woPcUvPt3c9LmxfWYU8GakhZAUJgGgYYlswYuFEUUYl34V7t/IULIPORBt/reda3Ikw/QsCmeqeJG2X1HITWbqle868inrrAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fHcq7dvZ; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757023398;
	bh=oSNm5eg5gYI2AKFp3yCBDv0gEfrms2mI0sAqlg7aafw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHcq7dvZI6pvfn8YL/iDtqOpQcwj+xwC5DO1di5HGCXTjbl78kQhVe0DNSZMfwjKq
	 VRdyUOTMBDLGqCY9EvGXVi9Jx+alo7VSBMaFNyjoeNpsznTLk/3hh3X2+1wtxlKcs3
	 LRD8A66nzCJDkDXfWLGVAmAk5ZHGrTccrGbEzlgqte93tBB6KV5eIGW7m4Z6XPwYAB
	 dlTpayTugJX9t+AeKLLYc5mkl9wfAZByXV17/RIUIQ19TFrAwtUiuaFjAGxU1M6tXr
	 eHcBH5VVnGV0+ao/HkMZSnCiWcv2oYOsIRyDJoddw1pCGYw+NcIFiO17xs8CLIYPD7
	 lPUUD1QZbIsYg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4F3066013A;
	Thu,  4 Sep 2025 22:03:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id BFE61202B39; Thu, 04 Sep 2025 22:02:58 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 14/14] tools: ynl: add sample for wireguard
Date: Thu,  4 Sep 2025 22:02:48 +0000
Message-ID: <20250904220255.1006675-14-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904-wg-ynl-rfc@fiberby.net>
References: <20250904-wg-ynl-rfc@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a sample application using the generated C library.

Example:
  [install uapi headers, then]
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
 MAINTAINERS                       |   1 +
 tools/net/ynl/samples/.gitignore  |   1 +
 tools/net/ynl/samples/wireguard.c | 104 ++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 tools/net/ynl/samples/wireguard.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e8360e4b55c6..dafc374b25d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27171,6 +27171,7 @@ S:	Maintained
 F:	Documentation/netlink/specs/wireguard.yaml
 F:	drivers/net/wireguard/
 F:	include/uapi/linux/wireguard_params.h
+F:	tools/net/ynl/samples/wireguard.c
 F:	tools/testing/selftests/wireguard/
 
 WISTRON LAPTOP BUTTON DRIVER
diff --git a/tools/net/ynl/samples/.gitignore b/tools/net/ynl/samples/.gitignore
index 7f5fca7682d7..09c61e4c18cd 100644
--- a/tools/net/ynl/samples/.gitignore
+++ b/tools/net/ynl/samples/.gitignore
@@ -7,3 +7,4 @@ rt-addr
 rt-link
 rt-route
 tc
+wireguard
diff --git a/tools/net/ynl/samples/wireguard.c b/tools/net/ynl/samples/wireguard.c
new file mode 100644
index 000000000000..f1549e585949
--- /dev/null
+++ b/tools/net/ynl/samples/wireguard.c
@@ -0,0 +1,104 @@
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
+ * use constant-time implementation as found in wireguard-tools.
+ */
+static void print_peer_header(const struct wireguard_wgpeer *peer)
+{
+	unsigned int i;
+	uint8_t *key = peer->public_key;
+	unsigned int len = peer->_len.public_key;
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
+	struct ynl_sock *ys;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s <ifindex|ifname>\n", argv[0]);
+		return 1;
+	}
+
+	req = wireguard_get_device_req_alloc();
+	build_request(req, argv[1]);
+
+	ys = ynl_sock_create(&ynl_wireguard_family, NULL);
+	if (!ys)
+		return 2;
+
+	devs = wireguard_get_device_dump(ys, req);
+	if (!devs)
+		goto err_close;
+
+	ynl_dump_foreach(devs, d) {
+		unsigned int i;
+
+		printf("Interface %d: %s\n", d->ifindex, d->ifname);
+		for (i = 0; i < d->_count.peers; i++)
+			print_peer(&d->peers[i]);
+	}
+	wireguard_get_device_list_free(devs);
+	wireguard_get_device_req_free(req);
+	ynl_sock_destroy(ys);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL (%d): %s\n", ys->err.code, ys->err.msg);
+	wireguard_get_device_req_free(req);
+	ynl_sock_destroy(ys);
+	return 3;
+}
-- 
2.51.0


