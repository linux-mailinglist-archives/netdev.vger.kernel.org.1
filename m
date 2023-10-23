Return-Path: <netdev+bounces-43479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7540A7D376B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B72B20C2D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4417758;
	Mon, 23 Oct 2023 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB515EBF
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 13:06:36 +0000 (UTC)
Received: from janet.servers.dxld.at (mail.servers.dxld.at [IPv6:2001:678:4d8:200::1a57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB5697
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 06:06:35 -0700 (PDT)
Received: janet.servers.dxld.at; Mon, 23 Oct 2023 15:06:26 +0200
From: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [PATCH] wireguard: Fix leaking sockets in wg_socket_init error paths
Date: Mon, 23 Oct 2023 15:06:09 +0200
Message-Id: <20231023130609.595122-1-dxld@darkboxed.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This doesn't seem to be reachable normally, but while working on a patch
for the address binding code I ended up triggering this leak and had to
reboot to get rid of the leaking wg sockets.
---
 drivers/net/wireguard/socket.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireguard/socket.c b/drivers/net/wireguard/socket.c
index 0414d7a6ce74..c35163f503e7 100644
--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -387,7 +387,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 	ret = udp_sock_create(net, &port4, &new4);
 	if (ret < 0) {
 		pr_err("%s: Could not create IPv4 socket\n", wg->dev->name);
-		goto out;
+		goto err;
 	}
 	set_sock_opts(new4);
 	setup_udp_tunnel_sock(net, new4, &cfg);
@@ -402,7 +402,7 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 				goto retry;
 			pr_err("%s: Could not create IPv6 socket\n",
 			       wg->dev->name);
-			goto out;
+			goto err;
 		}
 		set_sock_opts(new6);
 		setup_udp_tunnel_sock(net, new6, &cfg);
@@ -414,6 +414,11 @@ int wg_socket_init(struct wg_device *wg, u16 port)
 out:
 	put_net(net);
 	return ret;
+
+err:
+	sock_free(new4 ? new4->sk : NULL);
+	sock_free(new6 ? new6->sk : NULL);
+	goto out;
 }
 
 void wg_socket_reinit(struct wg_device *wg, struct sock *new4,
-- 
2.39.2


