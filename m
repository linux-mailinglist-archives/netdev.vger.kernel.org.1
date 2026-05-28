Return-Path: <netdev+bounces-292543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJi7EdmyF2p+NggAu9opvQ
	(envelope-from <netdev+bounces-292543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:13:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E08E25EC22D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34CF3027B40
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5B305057;
	Thu, 28 May 2026 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EykKuMgj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB018C933;
	Thu, 28 May 2026 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937894; cv=none; b=ek89of3gUsLRVxIn69NfuS/O47Fs8I0NvG/yjUYRGyoEmD7k1Vx0OSGBPY7m0BUulOCngCgdu8dgn70+q5RXJt4rAT6DfMNQegV8KWVglW4VFDpmStjIxFQ3mScLEmD3nWPA0sLLIPTRmIvGmNqwCtT4y0gMYq+WqpCWAba9big=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937894; c=relaxed/simple;
	bh=ZMNuIVT8gV8ZN6nKIeG2ScAwpDxPEviwNrWCPBg4o50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMq6NKjMogHM7Mh/+2rnJsVJmeofdJ57BSYPihznPQlxTpmCwnz85Ui+D+uyW8GDgBwNrE2/7uv92d48ZC66os13dBtQmNL6+yIfw2oKIn7hU1tD8Eaw7Z5M4eK7Zfa3PZ9ZuCCR5rahNMErIG/wu9djRYe2GTZTa3dUSMGkfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EykKuMgj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02A11F00A3A;
	Thu, 28 May 2026 03:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937893;
	bh=KVemK4auRRniSZlXG4406d5EhydMfgsXDt+TRcAqsZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EykKuMgj03gMuLQOj3o1AIgKvtmgGBM8DHNrKutO+1iaDAojjho67lVlS5CaToFch
	 taSn951lGHAbUFONOES4Tdhhjf14dmzAtlEPyW5+Y9VCXAEnWnPyeMec10oDvve6FE
	 +4ChgVeg8Zy1oa2Oy0YuD1vsILiPrnK7HwNtZXM9VcS4xeTsCRwt+XPTlCm1CF9gCF
	 7Pl2X7oUwZGdBlA8lLMjaAcIJpPwLKq2yNm9H09CtMEWyZSJtlLC6tcIr4O+UIQBNp
	 YD14HI3E3QEZy9PpfVRqyj9XJDjPV40DNmXdWq9wf6QIikdGn0a3jla0hGg+Y3oKDR
	 bwFg+uF7F23IA==
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
Subject: [PATCH 01/11] nvmet-tcp: define accept tcp_proto struct
Date: Thu, 28 May 2026 11:10:35 +0800
Message-ID: <4b377515d055f8097f4268f9570bc8d5e4e0dba8.1779934709.git.tanggeliang@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292543-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kylinos.cn:mid,kylinos.cn:email,purestorage.com:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E08E25EC22D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Geliang Tang <tanggeliang@kylinos.cn>

To handle accepted sockets, this patch adds struct nvmet_tcp_proto to
hold accept socket operations (no_linger, set_priority, set_tos, ops).
A proto field is added to struct nvmet_tcp_queue, which points to the
appropriate protocol structure. A TCP version is defined and assigned
to queue->proto for TCP connections.

Also modify nvmet_tcp_set_queue_sock() and nvmet_tcp_done_recv_pdu()
to use queue->proto for socket operations and fabrics callbacks.

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
 drivers/nvme/target/tcp.c | 40 +++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..01c23fb15b79 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -145,6 +145,13 @@ enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_FAILED,
 };
 
+struct nvmet_tcp_proto {
+	void (*no_linger)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*set_tos)(struct sock *sk);
+	const struct nvmet_fabrics_ops *ops;
+};
+
 struct nvmet_tcp_queue {
 	struct socket		*sock;
 	struct nvmet_tcp_port	*port;
@@ -196,6 +203,7 @@ struct nvmet_tcp_queue {
 	void (*data_ready)(struct sock *);
 	void (*state_change)(struct sock *);
 	void (*write_space)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 struct nvmet_tcp_port {
@@ -1081,7 +1089,8 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     queue->proto->ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1698,7 +1707,6 @@ static void nvmet_tcp_state_change(struct sock *sk)
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1716,14 +1724,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	queue->proto->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		queue->proto->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	queue->proto->set_tos(sock->sk);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -1906,6 +1913,21 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w) {}
 #endif
 
+static void tcp_sock_set_tos(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	if (inet->rcv_tos > 0)
+		ip_sock_set_tos(sk, inet->rcv_tos);
+}
+
+static const struct nvmet_tcp_proto nvmet_tcp_proto = {
+	.no_linger	= sock_no_linger,
+	.set_priority	= sock_set_priority,
+	.set_tos	= tcp_sock_set_tos,
+	.ops		= &nvmet_tcp_ops,
+};
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1923,6 +1945,12 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	kref_init(&queue->kref);
 	queue->sock = newsock;
+	if (newsock->sk->sk_protocol == IPPROTO_TCP) {
+		queue->proto = &nvmet_tcp_proto;
+	} else {
+		ret = -EINVAL;
+		goto out_free_queue;
+	}
 	queue->port = port;
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
-- 
2.53.0


