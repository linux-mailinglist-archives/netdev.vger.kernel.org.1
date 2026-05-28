Return-Path: <netdev+bounces-292545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONznDQ6zF2p+NggAu9opvQ
	(envelope-from <netdev+bounces-292545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:14:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC75EC24C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 772FC3028B68
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0E305E10;
	Thu, 28 May 2026 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwj/AfZB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C542C3259;
	Thu, 28 May 2026 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937908; cv=none; b=sDz7Fb+GLdsB7mTDljZJ8JPVSA4Nf19du0AS++YnOvszwJ24W+CZNf9SKxLhsT/ix0EXuVyVMfd/WL7TSpzyZsLPyUOSomQXA6szyZgk/lhtECNoapyv7H0jL7uEw7B6Dmv6242WulxX8z0gE0ze3+T8kM+cEbds79Sveel4eKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937908; c=relaxed/simple;
	bh=R++BFsDYqoN45G4VPN/MEPg83HDSC1/RgrcnZkwmN+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9Rd8pdfJh1EmVPMPq+RI34jxOLr4lGFMECL22WUZtXPEY2wSnqeDzEDlXR43WtzrW3ixDlfmomBYgKTRZFr6tBU3bR4zbC5W+bN+kWVmFMUc+UrizCBBJdBSoY/MGwCRYTTi0a9nOtCNOHR3sdKS5kjdYiMYD+TOyXhstRwffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwj/AfZB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF831F000E9;
	Thu, 28 May 2026 03:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937907;
	bh=syMmlg+JD2nqzhG8uZF0dK37U+gNHucnr241k0jXdP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kwj/AfZBJ757bJtFH6WyL4zOdpKKFBchHHXONEy8CtC+MbLScB3LDRtLf1ijVmHwy
	 KaBFgvupu6KuM3iVxoPL7zS+grgolZzqdcTI9UVfzj/hJ2kQuuHSUFY4PswXMtPQyp
	 QZzBdoJh39+ujdwwY+7UEgEJSIeEf8gHZR3GHVUsh09qHg2mltkZo+4TlhE3UMfqQf
	 tNBB9jQ3fhkLLLcQ6hbmzQohW0Yck5m6TSsKDv1nruh7gIwnZTgCfrqGYdhR49uDRj
	 TWJJq6k4XXyQQrlQoa82MKOPNR+b+9ihj/JUquikAwI6k3aUf3owBSM3WP5jWdTuQN
	 K7sMUQclMCzzg==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 03/11] nvmet-tcp: define listen socket ops
Date: Thu, 28 May 2026 11:10:37 +0800
Message-ID: <b3a26e1ee5bb3ea097edb60be479d9d52e02a772.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292545-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kylinos.cn:mid,kylinos.cn:email,purestorage.com:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CEFC75EC24C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

To support MPTCP on the target side, the listen socket needs to pass
IPPROTO_MPTCP to sock_create() for MPTCP ports, and use MPTCP-specific
setsockopt functions.

This patch adds struct nvmet_tcp_proto_ops to hold listen socket protocol
operations (protocol, set_reuseaddr, set_nodelay, set_priority). A TCP
version is defined and used for TCP ports.

v2:
 - use trtype instead of tsas (Hannes).

v3:
 - check mptcp protocol from disc_addr.trtype instead of passing a
parameter (Hannes).

v4:
 - check CONFIG_MPTCP.

v5:
 - define nvmet_tcp_proto struct.
 - add a pointer to this structure in nvmet_tcp_port.

v6:
 - split nvmet_tcp_proto struct into two structs, nvmet_tcp_proto and
nvmet_tcp_proto_ops, one for the accept socket, the other for the liston
socket.
 - add a pointer to nvmet_tcp_proto struct in nvmet_tcp_queue.

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 16f153a9772b..83fe001fc619 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2087,8 +2087,23 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+struct nvmet_tcp_proto_ops {
+	int			protocol;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+};
+
+static const struct nvmet_tcp_proto_ops nvmet_tcp_proto_ops = {
+	.protocol	= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
+	const struct nvmet_tcp_proto_ops *ops;
 	struct nvmet_tcp_port *port;
 	__kernel_sa_family_t af;
 	int ret;
@@ -2111,6 +2126,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		ops = &nvmet_tcp_proto_ops;
+	} else {
+		ret = -EINVAL;
+		goto err_port;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2125,7 +2147,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				ops->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2134,10 +2156,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	ops->set_reuseaddr(port->sock->sk);
+	ops->set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		ops->set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.53.0


