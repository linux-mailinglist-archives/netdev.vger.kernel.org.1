Return-Path: <netdev+bounces-241976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D49C8B3E9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F0E3A25B7
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6C2315761;
	Wed, 26 Nov 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KDR6fhWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2309312836;
	Wed, 26 Nov 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764178601; cv=none; b=OYUXJaGW8guY2OncLSgr5n25s+ChhrRB7qfTSlB60HTFpu9YyqYpzSRusDk6wKIo7ngjU1q9oNs3ExlCbwPtIJ4K9QMqg5VOyL/etmF4JeQgUTju7U39aFTv+JUlT3Y2JbiXArqMuGLuHYavXoNZQ+9g2rrEZ41lXrD2TeUy6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764178601; c=relaxed/simple;
	bh=oAc5lLTvSoXT1miS4IBqz89hqPf/jtLfqkSsakiDm5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxPsMka4XqwtyGWZdo1oL107BUxHwtCJcSUo4fTMCTCy0chO4l4cK4c4431l4Dxx32el7ZAtZRXMJlVhozH5XiL4uxpwEPFlmrENjWlmSsnOoo1qWEWrhqQTExNAg764AMxycq3TJ2nh3mmzo09rMnSKwCnP9MuYlysHjzzxybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KDR6fhWd; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764178585;
	bh=oAc5lLTvSoXT1miS4IBqz89hqPf/jtLfqkSsakiDm5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDR6fhWd+xCVxkICDStMC9xcrFTkWjBCPiZ7TtPrvwmI+jFH/tL/1u+zeTSMpwFo0
	 bP2By3iG++Jrg918alD2+pIdpyxBIpDBnQm0QBOoQL2s1MX3jXXvIYQs4SlnUxSr4c
	 B9UsMlqsT+j8X+YNYE7g3e/tqaKipNXWblLj02f5qk5VYMzojbuCem1B7ltopZQmY4
	 4wcCY/Gb4XaG3WhI1j3YcHbwbjIN+HT4PZNMzPO60aQ+I+H9eEEkVLnDKVc/5TAWSu
	 8cSn05aD0yPibHN3p0HaiALlsMUhJHvfKoj6h0sFg0jcyXV/Dth6XMYzyqZVRXT+AJ
	 ZeoCw41l/QTBg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id A06126010D;
	Wed, 26 Nov 2025 17:36:25 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id E1067204071; Wed, 26 Nov 2025 17:35:52 +0000 (UTC)
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
	Andrew Lunn <andrew+netdev@lunn.ch>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: [PATCH wireguard v4 09/10] tools: ynl: add sample for wireguard
Date: Wed, 26 Nov 2025 17:35:41 +0000
Message-ID: <20251126173546.57681-10-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126173546.57681-1-ast@fiberby.net>
References: <20251126173546.57681-1-ast@fiberby.net>
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
which might be useful for future selftests.

In order to support usage with a pre-YNL wireguard.h in /usr/include,
the former header guard is added to Makefile.deps as well.

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
 MAINTAINERS                       |   1 +
 tools/net/ynl/Makefile.deps       |   2 +
 tools/net/ynl/samples/.gitignore  |   1 +
 tools/net/ynl/samples/wireguard.c | 104 ++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 tools/net/ynl/samples/wireguard.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a72fe5ce334b6..dfc7b7a017561 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27665,6 +27665,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/netlink/specs/wireguard.yaml
 F:	drivers/net/wireguard/
+F:	tools/net/ynl/samples/wireguard.c
 F:	tools/testing/selftests/wireguard/
 
 WISTRON LAPTOP BUTTON DRIVER
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 865fd2e8519ed..a9a5348b31a3b 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -48,3 +48,5 @@ CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_TC_SKBEDIT_H,tc_act/tc_skbedit.h) \
 	$(call get_hdr_inc,_TC_TUNNEL_KEY_H,tc_act/tc_tunnel_key.h)
 CFLAGS_tcp_metrics:=$(call get_hdr_inc,_LINUX_TCP_METRICS_H,tcp_metrics.h)
+CFLAGS_wireguard:=$(call get_hdr_inc,_LINUX_WIREGUARD_H,wireguard.h) \
+	-D _WG_UAPI_WIREGUARD_H # alternate pre-YNL guard
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
index 0000000000000..43f3551eb101a
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
+ * use the constant-time implementation as found in wireguard-tools.
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


