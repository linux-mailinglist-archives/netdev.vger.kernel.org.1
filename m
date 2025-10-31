Return-Path: <netdev+bounces-234686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC5C260BF
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7701A4F69C3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45739313526;
	Fri, 31 Oct 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZNUvckcs"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908192FB633;
	Fri, 31 Oct 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926848; cv=none; b=VPCJ1ILYxylRqFC42vhBTdWtuyl5UdV8HxKb36vHWmHLb1ZmqAOtRYgx9t2LwAnVj1C7PKnnn6dKuWririIR8w6EstLrMuNTZn8Zke7WQtWv7Xpw03yzXM+7TEZ1+CxHzft9j5L1JN/Ix4SbHvmgz+UL2yRk+Xuu9r3gWWfi9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926848; c=relaxed/simple;
	bh=ZP+m8cZPjiaIXeRgbLsUMtByi0mBzTThTOiArKN3VlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWGrdeDzQNtcrZ896Sc2SA8+CRgZucYVcCjFfrGq6U9q7hBrhSGZL1lc6PA9WtTTUkitqeiuWlsUBnAu1Y9DplA9haEw+0j4Ospj9ggRBjabVU/LTM6IabiAxpqa+q+DNkFRCy800ENjTAdEweSZYT9IRHGdrCQ1Bz/HVvelluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZNUvckcs; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1761926832;
	bh=ZP+m8cZPjiaIXeRgbLsUMtByi0mBzTThTOiArKN3VlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNUvckcsrXyJO2/6OJ+Q6Rh5yPsojCcVkuxmsfdCOg2Yyhd34hVrs0RQ1nJ5bC6LH
	 rU8ngV8PUAeX27abxihjPbhN5tnt+Pe5lgjhAEJYUD36B4CSHbed/1R/Oni+OnopGu
	 fmJsipBmeoNbDrA/OobMQqCpgz0/27mD2lc/kCiUMC25bzfJsvflBCz8tB96uLwxmW
	 d4DHlWM4+Q2FxapZxmc7wqLCQdAg2/JAeBhLVHJhvgjHNbPw2jq7LTStXJZG+8TyEL
	 TKJBeOqtEelZHD9FXpyri/G0z76MyJE8Rp6rVOpbXL63KtpZjjTLKYnIru5awCLrXw
	 ZIHEVqeyciG/A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 4892660114;
	Fri, 31 Oct 2025 16:07:12 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id EA087205047; Fri, 31 Oct 2025 16:05:45 +0000 (UTC)
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
Subject: [PATCH net-next v2 08/11] tools: ynl: add sample for wireguard
Date: Fri, 31 Oct 2025 16:05:34 +0000
Message-ID: <20251031160539.1701943-9-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031160539.1701943-1-ast@fiberby.net>
References: <20251031160539.1701943-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a sample application for wireguard, using the generated C library,

The main benefit of this is to exercise the generated library,
which might be useful for future selftests.

The UAPI header is copied to tools/include/uapi/, when the header
changes ynl-gen will regenerate both copies.

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
 MAINTAINERS                          |   2 +
 tools/include/uapi/linux/wireguard.h |  79 ++++++++++++++++++++
 tools/net/ynl/samples/.gitignore     |   1 +
 tools/net/ynl/samples/wireguard.c    | 104 +++++++++++++++++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 tools/include/uapi/linux/wireguard.h
 create mode 100644 tools/net/ynl/samples/wireguard.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 65c71728e2c6..5b1b8cd37124 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27643,6 +27643,8 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/netlink/specs/wireguard.yaml
 F:	drivers/net/wireguard/
+F:	tools/include/uapi/linux/wireguard.h
+F:	tools/net/ynl/samples/wireguard.c
 F:	tools/testing/selftests/wireguard/
 
 WISTRON LAPTOP BUTTON DRIVER
diff --git a/tools/include/uapi/linux/wireguard.h b/tools/include/uapi/linux/wireguard.h
new file mode 100644
index 000000000000..dc3924d0c552
--- /dev/null
+++ b/tools/include/uapi/linux/wireguard.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/wireguard.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_WIREGUARD_H
+#define _UAPI_LINUX_WIREGUARD_H
+
+#define WG_GENL_NAME	"wireguard"
+#define WG_GENL_VERSION	1
+
+#define WG_KEY_LEN	32
+
+enum wgdevice_flag {
+	WGDEVICE_F_REPLACE_PEERS = 1,
+};
+
+enum wgpeer_flag {
+	WGPEER_F_REMOVE_ME = 1,
+	WGPEER_F_REPLACE_ALLOWEDIPS = 2,
+	WGPEER_F_UPDATE_ONLY = 4,
+};
+
+enum wgallowedip_flag {
+	WGALLOWEDIP_F_REMOVE_ME = 1,
+};
+
+enum wgdevice_attribute {
+	WGDEVICE_A_UNSPEC,
+	WGDEVICE_A_IFINDEX,
+	WGDEVICE_A_IFNAME,
+	WGDEVICE_A_PRIVATE_KEY,
+	WGDEVICE_A_PUBLIC_KEY,
+	WGDEVICE_A_FLAGS,
+	WGDEVICE_A_LISTEN_PORT,
+	WGDEVICE_A_FWMARK,
+	WGDEVICE_A_PEERS,
+
+	__WGDEVICE_A_LAST
+};
+#define WGDEVICE_A_MAX (__WGDEVICE_A_LAST - 1)
+
+enum wgpeer_attribute {
+	WGPEER_A_UNSPEC,
+	WGPEER_A_PUBLIC_KEY,
+	WGPEER_A_PRESHARED_KEY,
+	WGPEER_A_FLAGS,
+	WGPEER_A_ENDPOINT,
+	WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
+	WGPEER_A_LAST_HANDSHAKE_TIME,
+	WGPEER_A_RX_BYTES,
+	WGPEER_A_TX_BYTES,
+	WGPEER_A_ALLOWEDIPS,
+	WGPEER_A_PROTOCOL_VERSION,
+
+	__WGPEER_A_LAST
+};
+#define WGPEER_A_MAX (__WGPEER_A_LAST - 1)
+
+enum wgallowedip_attribute {
+	WGALLOWEDIP_A_UNSPEC,
+	WGALLOWEDIP_A_FAMILY,
+	WGALLOWEDIP_A_IPADDR,
+	WGALLOWEDIP_A_CIDR_MASK,
+	WGALLOWEDIP_A_FLAGS,
+
+	__WGALLOWEDIP_A_LAST
+};
+#define WGALLOWEDIP_A_MAX (__WGALLOWEDIP_A_LAST - 1)
+
+enum wg_cmd {
+	WG_CMD_GET_DEVICE,
+	WG_CMD_SET_DEVICE,
+
+	__WG_CMD_MAX
+};
+#define WG_CMD_MAX (__WG_CMD_MAX - 1)
+
+#endif /* _UAPI_LINUX_WIREGUARD_H */
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
index 000000000000..43f3551eb101
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


