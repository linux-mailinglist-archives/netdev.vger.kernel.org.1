Return-Path: <netdev+bounces-158620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B18A12B54
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1637618896FF
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5911D63DF;
	Wed, 15 Jan 2025 19:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="XNEbbOcP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF641D7994
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736967669; cv=none; b=OnluNTRQgcy59CXbhreATZbXKg4mx81JU0NaQzLHGWOxSWpXCNwME6BAjDLQhQqSD2EaGjL8B+ZpEuG91xwVymrwiOr93nn2vJc5nyt0D74VNKDEc5qCZyeJ/YFi8A8iFvMh3cfv91OE7q+hDidy4H3XFZaVfN8x6aHknj9iVYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736967669; c=relaxed/simple;
	bh=TNsFtvqyU0l2NX9S+tWQ/A3SvJnR/AKXImTLMG0xfvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP5hODm5zkd/Zs6/8zP49vPsP0S3/atJAtj7MKgbMl/4I4sqT6s4XumjNZ9YemTb4aixnXzqbF5o3IJ/78bXstlVCBBcZo3kfUhHUwCpWr5oqJAJ+R/F8JFZ+cuu7NF0IiblhTrY74QzdlhB5nKxqfpZ+53C5zYByQKBi6+hHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=XNEbbOcP; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iQrVPU5uog7jpjUtVjkajHdCjaJUeZpJnJfJOdCRpms=; t=1736967630; x=1737831630; 
	b=XNEbbOcPYktpa6JPAib51KzfOPy7yaZ4mfGP2/vY+4XJJZo85g9jkMR/QlgdtZlojqfBIw+1QMa
	arL15toi6RgJOhwSYF4RNskJms04i8jOlQSqWpLcsfIP1NQGhbOFx7lbPfgnWwPA6rWRvjYhBjn0n
	pS/YFviQd8KrxtnDkcPbUB8tu3g9pmEGQLO2WNRkth8Q/QT/XyYuXOQUAsVnEFngQjGi7gREAPiAv
	qiQbb7+VRKjdcH2G43FRHRfYLHn+Tzw3rCt0saU/ZhcLiyH/nEPjlXu6dwbpgm+PXiqRMUUfqv7c0
	sCR9qg90pIgM1BXki/PHLnV8vNhn5IQGNrig==;
Received: from ouster448.stanford.edu ([172.24.72.71]:52661 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tY8ct-0002BF-75; Wed, 15 Jan 2025 11:00:29 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v6 11/12] net: homa: create homa_plumbing.c and homa_utils.c
Date: Wed, 15 Jan 2025 10:59:35 -0800
Message-ID: <20250115185937.1324-12-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250115185937.1324-1-ouster@cs.stanford.edu>
References: <20250115185937.1324-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: a33086719a8a5ca8dde9de61cebef3bc

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/homa/homa_plumbing.c | 1004 ++++++++++++++++++++++++++++++++++++++
 net/homa/homa_utils.c    |  166 +++++++
 2 files changed, 1170 insertions(+)
 create mode 100644 net/homa/homa_plumbing.c
 create mode 100644 net/homa/homa_utils.c

diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
new file mode 100644
index 000000000000..6c654444241b
--- /dev/null
+++ b/net/homa/homa_plumbing.c
@@ -0,0 +1,1004 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file consists mostly of "glue" that hooks Homa into the rest of
+ * the Linux kernel. The guts of the protocol are in other files.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+
+/* Not yet sure what these variables are for */
+static long sysctl_homa_mem[3] __read_mostly;
+static int sysctl_homa_rmem_min __read_mostly;
+static int sysctl_homa_wmem_min __read_mostly;
+
+/* Global data for Homa. Never reference homa_data directly. Always use
+ * the global_homa variable instead; this allows overriding during unit tests.
+ */
+static struct homa homa_data;
+
+/* This variable contains the address of the statically-allocated struct homa
+ * used throughout Homa. This variable should almost never be used directly:
+ * it should be passed as a parameter to functions that need it. This
+ * variable is used only by functions called from Linux (so they can't pass
+ * in a pointer).
+ */
+struct homa *global_homa = &homa_data;
+
+/* True means that the Homa module is in the process of unloading itself,
+ * so everyone should clean up.
+ */
+static bool exiting;
+
+/* Thread that runs timer code to detect lost packets and crashed peers. */
+static struct task_struct *timer_kthread;
+
+/* This structure defines functions that handle various operations on
+ * Homa sockets. These functions are relatively generic: they are called
+ * to implement top-level system calls. Many of these operations can
+ * be implemented by PF_INET6 functions that are independent of the
+ * Homa protocol.
+ */
+static const struct proto_ops homa_proto_ops = {
+	.family		   = PF_INET,
+	.owner		   = THIS_MODULE,
+	.release	   = inet_release,
+	.bind		   = homa_bind,
+	.connect	   = inet_dgram_connect,
+	.socketpair	   = sock_no_socketpair,
+	.accept		   = sock_no_accept,
+	.getname	   = inet_getname,
+	.poll		   = homa_poll,
+	.ioctl		   = inet_ioctl,
+	.listen		   = sock_no_listen,
+	.shutdown	   = homa_shutdown,
+	.setsockopt	   = sock_common_setsockopt,
+	.getsockopt	   = sock_common_getsockopt,
+	.sendmsg	   = inet_sendmsg,
+	.recvmsg	   = inet_recvmsg,
+	.mmap		   = sock_no_mmap,
+	.set_peek_off	   = sk_set_peek_off,
+};
+
+static const struct proto_ops homav6_proto_ops = {
+	.family		   = PF_INET6,
+	.owner		   = THIS_MODULE,
+	.release	   = inet6_release,
+	.bind		   = homa_bind,
+	.connect	   = inet_dgram_connect,
+	.socketpair	   = sock_no_socketpair,
+	.accept		   = sock_no_accept,
+	.getname	   = inet6_getname,
+	.poll		   = homa_poll,
+	.ioctl		   = inet6_ioctl,
+	.listen		   = sock_no_listen,
+	.shutdown	   = homa_shutdown,
+	.setsockopt	   = sock_common_setsockopt,
+	.getsockopt	   = sock_common_getsockopt,
+	.sendmsg	   = inet_sendmsg,
+	.recvmsg	   = inet_recvmsg,
+	.mmap		   = sock_no_mmap,
+	.set_peek_off	   = sk_set_peek_off,
+};
+
+/* This structure also defines functions that handle various operations
+ * on Homa sockets. However, these functions are lower-level than those
+ * in homa_proto_ops: they are specific to the PF_INET or PF_INET6
+ * protocol family, and in many cases they are invoked by functions in
+ * homa_proto_ops. Most of these functions have Homa-specific implementations.
+ */
+static struct proto homa_prot = {
+	.name		   = "HOMA",
+	.owner		   = THIS_MODULE,
+	.close		   = homa_close,
+	.connect	   = ip4_datagram_connect,
+	.disconnect	   = homa_disconnect,
+	.ioctl		   = homa_ioctl,
+	.init		   = homa_socket,
+	.destroy	   = NULL,
+	.setsockopt	   = homa_setsockopt,
+	.getsockopt	   = homa_getsockopt,
+	.sendmsg	   = homa_sendmsg,
+	.recvmsg	   = homa_recvmsg,
+	.backlog_rcv       = homa_backlog_rcv,
+	.hash		   = homa_hash,
+	.unhash		   = homa_unhash,
+	.get_port	   = homa_get_port,
+	.sysctl_mem	   = sysctl_homa_mem,
+	.sysctl_wmem	   = &sysctl_homa_wmem_min,
+	.sysctl_rmem	   = &sysctl_homa_rmem_min,
+	.obj_size	   = sizeof(struct homa_sock),
+	.no_autobind       = 1,
+};
+
+static struct proto homav6_prot = {
+	.name		   = "HOMAv6",
+	.owner		   = THIS_MODULE,
+	.close		   = homa_close,
+	.connect	   = ip6_datagram_connect,
+	.disconnect	   = homa_disconnect,
+	.ioctl		   = homa_ioctl,
+	.init		   = homa_socket,
+	.destroy	   = NULL,
+	.setsockopt	   = homa_setsockopt,
+	.getsockopt	   = homa_getsockopt,
+	.sendmsg	   = homa_sendmsg,
+	.recvmsg	   = homa_recvmsg,
+	.backlog_rcv       = homa_backlog_rcv,
+	.hash		   = homa_hash,
+	.unhash		   = homa_unhash,
+	.get_port	   = homa_get_port,
+	.sysctl_mem	   = sysctl_homa_mem,
+	.sysctl_wmem	   = &sysctl_homa_wmem_min,
+	.sysctl_rmem	   = &sysctl_homa_rmem_min,
+
+	.obj_size	   = sizeof(struct homa_v6_sock),
+	.ipv6_pinfo_offset = offsetof(struct homa_v6_sock, inet6),
+
+	.no_autobind       = 1,
+};
+
+/* Top-level structure describing the Homa protocol. */
+static struct inet_protosw homa_protosw = {
+	.type              = SOCK_DGRAM,
+	.protocol          = IPPROTO_HOMA,
+	.prot              = &homa_prot,
+	.ops               = &homa_proto_ops,
+	.flags             = INET_PROTOSW_REUSE,
+};
+
+static struct inet_protosw homav6_protosw = {
+	.type              = SOCK_DGRAM,
+	.protocol          = IPPROTO_HOMA,
+	.prot              = &homav6_prot,
+	.ops               = &homav6_proto_ops,
+	.flags             = INET_PROTOSW_REUSE,
+};
+
+/* This structure is used by IP to deliver incoming Homa packets to us. */
+static struct net_protocol homa_protocol = {
+	.handler =	homa_softirq,
+	.err_handler =	homa_err_handler_v4,
+	.no_policy =     1,
+};
+
+static struct inet6_protocol homav6_protocol = {
+	.handler =	homa_softirq,
+	.err_handler =	homa_err_handler_v6,
+	.flags =        INET6_PROTO_NOPOLICY | INET6_PROTO_FINAL,
+};
+
+/* Sizes of the headers for each Homa packet type, in bytes. */
+static __u16 header_lengths[] = {
+	sizeof32(struct homa_data_hdr),
+	0,
+	sizeof32(struct homa_resend_hdr),
+	sizeof32(struct homa_unknown_hdr),
+	sizeof32(struct homa_busy_hdr),
+	0,
+	0,
+	sizeof32(struct homa_need_ack_hdr),
+	sizeof32(struct homa_ack_hdr)
+};
+
+static DECLARE_COMPLETION(timer_thread_done);
+
+/**
+ * homa_load() - invoked when this module is loaded into the Linux kernel
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int __init homa_load(void)
+{
+	struct homa *homa = global_homa;
+	int status;
+
+	pr_notice("Homa module loading\n");
+	status = proto_register(&homa_prot, 1);
+	if (status != 0) {
+		pr_err("proto_register failed for homa_prot: %d\n", status);
+		goto proto_register_err;
+	}
+	status = proto_register(&homav6_prot, 1);
+	if (status != 0) {
+		pr_err("proto_register failed for homav6_prot: %d\n", status);
+		goto proto_register_v6_err;
+	}
+	inet_register_protosw(&homa_protosw);
+	status = inet6_register_protosw(&homav6_protosw);
+	if (status != 0) {
+		pr_err("inet6_register_protosw failed in %s: %d\n", __func__,
+		       status);
+		goto register_protosw_v6_err;
+	}
+	status = inet_add_protocol(&homa_protocol, IPPROTO_HOMA);
+	if (status != 0) {
+		pr_err("inet_add_protocol failed in %s: %d\n", __func__,
+		       status);
+		goto add_protocol_err;
+	}
+	status = inet6_add_protocol(&homav6_protocol, IPPROTO_HOMA);
+	if (status != 0) {
+		pr_err("inet6_add_protocol failed in %s: %d\n",  __func__,
+		       status);
+		goto add_protocol_v6_err;
+	}
+
+	status = homa_init(homa);
+	if (status)
+		goto homa_init_err;
+
+	timer_kthread = kthread_run(homa_timer_main, homa, "homa_timer");
+	if (IS_ERR(timer_kthread)) {
+		status = PTR_ERR(timer_kthread);
+		pr_err("couldn't create homa pacer thread: error %d\n",
+		       status);
+		timer_kthread = NULL;
+		goto timer_err;
+	}
+
+	return 0;
+
+timer_err:
+	homa_destroy(homa);
+homa_init_err:
+	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
+add_protocol_v6_err:
+	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
+add_protocol_err:
+	inet6_unregister_protosw(&homav6_protosw);
+register_protosw_v6_err:
+	inet_unregister_protosw(&homa_protosw);
+	proto_unregister(&homav6_prot);
+proto_register_v6_err:
+	proto_unregister(&homa_prot);
+proto_register_err:
+	return status;
+}
+
+/**
+ * homa_unload() - invoked when this module is unloaded from the Linux kernel.
+ */
+void __exit homa_unload(void)
+{
+	struct homa *homa = global_homa;
+
+	pr_notice("Homa module unloading\n");
+	exiting = true;
+
+	if (timer_kthread)
+		wake_up_process(timer_kthread);
+	wait_for_completion(&timer_thread_done);
+	homa_destroy(homa);
+	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
+	inet_unregister_protosw(&homa_protosw);
+	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
+	inet6_unregister_protosw(&homav6_protosw);
+	proto_unregister(&homa_prot);
+	proto_unregister(&homav6_prot);
+}
+
+module_init(homa_load);
+module_exit(homa_unload);
+
+/**
+ * homa_bind() - Implements the bind system call for Homa sockets: associates
+ * a well-known service port with a socket. Unlike other AF_INET6 protocols,
+ * there is no need to invoke this system call for sockets that are only
+ * used as clients.
+ * @sock:     Socket on which the system call was invoked.
+ * @addr:    Contains the desired port number.
+ * @addr_len: Number of bytes in uaddr.
+ * Return:    0 on success, otherwise a negative errno.
+ */
+int homa_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+{
+	union sockaddr_in_union *addr_in = (union sockaddr_in_union *)addr;
+	struct homa_sock *hsk = homa_sk(sock->sk);
+	int port = 0;
+
+	if (unlikely(addr->sa_family != sock->sk->sk_family))
+		return -EAFNOSUPPORT;
+	if (addr_in->in6.sin6_family == AF_INET6) {
+		if (addr_len < sizeof(struct sockaddr_in6))
+			return -EINVAL;
+		port = ntohs(addr_in->in4.sin_port);
+	} else if (addr_in->in4.sin_family == AF_INET) {
+		if (addr_len < sizeof(struct sockaddr_in))
+			return -EINVAL;
+		port = ntohs(addr_in->in6.sin6_port);
+	}
+	return homa_sock_bind(hsk->homa->port_map, hsk, port);
+}
+
+/**
+ * homa_close() - Invoked when close system call is invoked on a Homa socket.
+ * @sk:      Socket being closed
+ * @timeout: ??
+ */
+void homa_close(struct sock *sk, long timeout)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+
+	homa_sock_destroy(hsk);
+	sk_common_release(sk);
+}
+
+/**
+ * homa_shutdown() - Implements the shutdown system call for Homa sockets.
+ * @sock:    Socket to shut down.
+ * @how:     Ignored: for other sockets, can independently shut down
+ *           sending and receiving, but for Homa any shutdown will
+ *           shut down everything.
+ *
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int homa_shutdown(struct socket *sock, int how)
+{
+	homa_sock_shutdown(homa_sk(sock->sk));
+	return 0;
+}
+
+/**
+ * homa_disconnect() - Invoked when disconnect system call is invoked on a
+ * Homa socket.
+ * @sk:    Socket to disconnect
+ * @flags: ??
+ *
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int homa_disconnect(struct sock *sk, int flags)
+{
+	pr_warn("unimplemented disconnect invoked on Homa socket\n");
+	return -EINVAL;
+}
+
+/**
+ * homa_ioctl() - Implements the ioctl system call for Homa sockets.
+ * @sk:    Socket on which the system call was invoked.
+ * @cmd:   Identifier for a particular ioctl operation.
+ * @karg:  Operation-specific argument; typically the address of a block
+ *         of data in user address space.
+ *
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int homa_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	return -EINVAL;
+}
+
+/**
+ * homa_socket() - Implements the socket(2) system call for sockets.
+ * @sk:    Socket on which the system call was invoked. The non-Homa
+ *         parts have already been initialized.
+ *
+ * Return: always 0 (success).
+ */
+int homa_socket(struct sock *sk)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa *homa = global_homa;
+	int result;
+
+	result = homa_sock_init(hsk, homa);
+	if (result != 0)
+		homa_sock_destroy(hsk);
+	return result;
+}
+
+/**
+ * homa_setsockopt() - Implements the getsockopt system call for Homa sockets.
+ * @sk:      Socket on which the system call was invoked.
+ * @level:   Level at which the operation should be handled; will always
+ *           be IPPROTO_HOMA.
+ * @optname: Identifies a particular setsockopt operation.
+ * @optval:  Address in user space of information about the option.
+ * @optlen:  Number of bytes of data at @optval.
+ * Return:   0 on success, otherwise a negative errno.
+ */
+int homa_setsockopt(struct sock *sk, int level, int optname,
+		    sockptr_t optval, unsigned int optlen)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa_rcvbuf_args args;
+	int ret;
+
+	if (level != IPPROTO_HOMA || optname != SO_HOMA_RCVBUF)
+		return -ENOPROTOOPT;
+	if (optlen != sizeof(struct homa_rcvbuf_args))
+		return -EINVAL;
+
+	if (copy_from_sockptr(&args, optval, optlen))
+		return -EFAULT;
+
+	/* Do a trivial test to make sure we can at least write the first
+	 * page of the region.
+	 */
+	if (copy_to_user(u64_to_user_ptr(args.start), &args,
+			 sizeof(args)))
+		return -EFAULT;
+
+	homa_sock_lock(hsk, "homa_setsockopt SO_HOMA_RCV_BUF");
+	ret = homa_pool_init(hsk, u64_to_user_ptr(args.start), args.length);
+	homa_sock_unlock(hsk);
+	return ret;
+}
+
+/**
+ * homa_getsockopt() - Implements the getsockopt system call for Homa sockets.
+ * @sk:      Socket on which the system call was invoked.
+ * @level:   Selects level in the network stack to handle the request;
+ *           must be IPPROTO_HOMA.
+ * @optname: Identifies a particular setsockopt operation.
+ * @optval:  Address in user space where the option's value should be stored.
+ * @optlen:  Number of bytes available at optval; will be overwritten with
+ *           actual number of bytes stored.
+ * Return:   0 on success, otherwise a negative errno.
+ */
+int homa_getsockopt(struct sock *sk, int level, int optname,
+		    char __user *optval, int __user *optlen)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa_rcvbuf_args val;
+	int len;
+
+	if (copy_from_sockptr(&len, USER_SOCKPTR(optlen), sizeof(int)))
+		return -EFAULT;
+
+	if (level != IPPROTO_HOMA || optname != SO_HOMA_RCVBUF)
+		return -ENOPROTOOPT;
+	if (len < sizeof(val))
+		return -EINVAL;
+
+	homa_pool_get_rcvbuf(hsk, &val);
+	len = sizeof(val);
+
+	if (copy_to_sockptr(USER_SOCKPTR(optlen), &len, sizeof(int)))
+		return -EFAULT;
+
+	if (copy_to_sockptr(USER_SOCKPTR(optval), &val, len))
+		return -EFAULT;
+	return 0;
+}
+
+/**
+ * homa_sendmsg() - Send a request or response message on a Homa socket.
+ * @sk:     Socket on which the system call was invoked.
+ * @msg:    Structure describing the message to send; the msg_control
+ *          field points to additional information.
+ * @length: Number of bytes of the message.
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t length)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa_sendmsg_args args;
+	union sockaddr_in_union *addr;
+	struct homa_rpc *rpc = NULL;
+	int result = 0;
+
+	addr = (union sockaddr_in_union *)msg->msg_name;
+	if (!addr) {
+		result = -EINVAL;
+		goto error;
+	}
+
+	if (unlikely(!msg->msg_control_is_user)) {
+		result = -EINVAL;
+		goto error;
+	}
+	if (unlikely(copy_from_user(&args, (void __user *)msg->msg_control,
+				    sizeof(args)))) {
+		result = -EFAULT;
+		goto error;
+	}
+	if (addr->sa.sa_family != sk->sk_family) {
+		result = -EAFNOSUPPORT;
+		goto error;
+	}
+	if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
+	    (msg->msg_namelen < sizeof(struct sockaddr_in6) &&
+	     addr->in6.sin6_family == AF_INET6)) {
+		result = -EINVAL;
+		goto error;
+	}
+
+	if (!args.id) {
+		/* This is a request message. */
+		rpc = homa_rpc_new_client(hsk, addr);
+		if (IS_ERR(rpc)) {
+			result = PTR_ERR(rpc);
+			rpc = NULL;
+			goto error;
+		}
+		rpc->completion_cookie = args.completion_cookie;
+		result = homa_message_out_fill(rpc, &msg->msg_iter, 1);
+		if (result)
+			goto error;
+		args.id = rpc->id;
+		homa_rpc_unlock(rpc); /* Locked by homa_rpc_new_client. */
+		rpc = NULL;
+
+		if (unlikely(copy_to_user((void __user *)msg->msg_control,
+					  &args, sizeof(args)))) {
+			rpc = homa_find_client_rpc(hsk, args.id);
+			result = -EFAULT;
+			goto error;
+		}
+	} else {
+		/* This is a response message. */
+		struct in6_addr canonical_dest;
+
+		if (args.completion_cookie != 0) {
+			result = -EINVAL;
+			goto error;
+		}
+		canonical_dest = canonical_ipv6_addr(addr);
+
+		rpc = homa_find_server_rpc(hsk, &canonical_dest, args.id);
+		if (!rpc)
+			/* Return without an error if the RPC doesn't exist;
+			 * this could be totally valid (e.g. client is
+			 * no longer interested in it).
+			 */
+			return 0;
+		if (rpc->error) {
+			result = rpc->error;
+			goto error;
+		}
+		if (rpc->state != RPC_IN_SERVICE) {
+			/* Locked by homa_find_server_rpc. */
+			homa_rpc_unlock(rpc);
+			rpc = NULL;
+			result = -EINVAL;
+			goto error;
+		}
+		rpc->state = RPC_OUTGOING;
+
+		result = homa_message_out_fill(rpc, &msg->msg_iter, 1);
+		if (result && rpc->state != RPC_DEAD)
+			goto error;
+		homa_rpc_unlock(rpc); /* Locked by homa_find_server_rpc. */
+	}
+	return 0;
+
+error:
+	if (rpc) {
+		homa_rpc_free(rpc);
+		homa_rpc_unlock(rpc); /* Locked by homa_find_server_rpc. */
+	}
+	return result;
+}
+
+/**
+ * homa_recvmsg() - Receive a message from a Homa socket.
+ * @sk:          Socket on which the system call was invoked.
+ * @msg:         Controlling information for the receive.
+ * @len:         Total bytes of space available in msg->msg_iov; not used.
+ * @flags:       Flags from system call; only MSG_DONTWAIT is used.
+ * @addr_len:    Store the length of the sender address here
+ * Return:       The length of the message on success, otherwise a negative
+ *               errno.
+ */
+int homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
+		 int *addr_len)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa_recvmsg_args control;
+	struct homa_rpc *rpc;
+	int result;
+
+	if (unlikely(!msg->msg_control)) {
+		/* This test isn't strictly necessary, but it provides a
+		 * hook for testing kernel call times.
+		 */
+		return -EINVAL;
+	}
+	if (msg->msg_controllen != sizeof(control))
+		return -EINVAL;
+	if (unlikely(copy_from_user(&control, (void __user *)msg->msg_control,
+				    sizeof(control))))
+		return -EFAULT;
+	control.completion_cookie = 0;
+
+	if (control.num_bpages > HOMA_MAX_BPAGES ||
+	    (control.flags & ~HOMA_RECVMSG_VALID_FLAGS)) {
+		result = -EINVAL;
+		goto done;
+	}
+	result = homa_pool_release_buffers(hsk->buffer_pool, control.num_bpages,
+					   control.bpage_offsets);
+	control.num_bpages = 0;
+	if (result != 0)
+		goto done;
+
+	rpc = homa_wait_for_message(hsk, (flags & MSG_DONTWAIT)
+			? (control.flags | HOMA_RECVMSG_NONBLOCKING)
+			: control.flags, control.id);
+	if (IS_ERR(rpc)) {
+		/* If we get here, it means there was an error that prevented
+		 * us from finding an RPC to return. If there's an error in
+		 * the RPC itself we won't get here.
+		 */
+		result = PTR_ERR(rpc);
+		goto done;
+	}
+	result = rpc->error ? rpc->error : rpc->msgin.length;
+
+	/* Collect result information. */
+	control.id = rpc->id;
+	control.completion_cookie = rpc->completion_cookie;
+	if (likely(rpc->msgin.length >= 0)) {
+		control.num_bpages = rpc->msgin.num_bpages;
+		memcpy(control.bpage_offsets, rpc->msgin.bpage_offsets,
+		       sizeof(rpc->msgin.bpage_offsets));
+	}
+	if (sk->sk_family == AF_INET6) {
+		struct sockaddr_in6 *in6 = msg->msg_name;
+
+		in6->sin6_family = AF_INET6;
+		in6->sin6_port = htons(rpc->dport);
+		in6->sin6_addr = rpc->peer->addr;
+		*addr_len = sizeof(*in6);
+	} else {
+		struct sockaddr_in *in4 = msg->msg_name;
+
+		in4->sin_family = AF_INET;
+		in4->sin_port = htons(rpc->dport);
+		in4->sin_addr.s_addr = ipv6_to_ipv4(rpc->peer->addr);
+		*addr_len = sizeof(*in4);
+	}
+
+	/* This indicates that the application now owns the buffers, so
+	 * we won't free them in homa_rpc_free.
+	 */
+	rpc->msgin.num_bpages = 0;
+
+	/* Must release the RPC lock (and potentially free the RPC) before
+	 * copying the results back to user space.
+	 */
+	if (homa_is_client(rpc->id)) {
+		homa_peer_add_ack(rpc);
+		homa_rpc_free(rpc);
+	} else {
+		if (result < 0)
+			homa_rpc_free(rpc);
+		else
+			rpc->state = RPC_IN_SERVICE;
+	}
+	homa_rpc_unlock(rpc); /* Locked by homa_wait_for_message. */
+
+done:
+	if (unlikely(copy_to_user((__force void __user *)msg->msg_control,
+				  &control, sizeof(control)))) {
+		/* Note: in this case the message's buffers will be leaked. */
+		pr_notice("%s couldn't copy back args\n", __func__);
+		result = -EFAULT;
+	}
+
+	return result;
+}
+
+/**
+ * homa_hash() - Not needed for Homa.
+ * @sk:    Socket for the operation
+ * Return: ??
+ */
+int homa_hash(struct sock *sk)
+{
+	return 0;
+}
+
+/**
+ * homa_unhash() - Not needed for Homa.
+ * @sk:    Socket for the operation
+ */
+void homa_unhash(struct sock *sk)
+{
+}
+
+/**
+ * homa_get_port() - It appears that this function is called to assign a
+ * default port for a socket.
+ * @sk:    Socket for the operation
+ * @snum:  Unclear what this is.
+ * Return: Zero for success, or a negative errno for an error.
+ */
+int homa_get_port(struct sock *sk, unsigned short snum)
+{
+	/* Homa always assigns ports immediately when a socket is created,
+	 * so there is nothing to do here.
+	 */
+	return 0;
+}
+
+/**
+ * homa_softirq() - This function is invoked at SoftIRQ level to handle
+ * incoming packets.
+ * @skb:   The incoming packet.
+ * Return: Always 0
+ */
+int homa_softirq(struct sk_buff *skb)
+{
+	struct sk_buff *packets, *other_pkts, *next;
+	struct sk_buff **prev_link, **other_link;
+	struct homa *homa = global_homa;
+	struct homa_common_hdr *h;
+	int header_offset;
+	int pull_length;
+
+	/* skb may actually contain many distinct packets, linked through
+	 * skb_shinfo(skb)->frag_list by the Homa GRO mechanism. Make a
+	 * pass through the list to process all of the short packets,
+	 * leaving the longer packets in the list. Also, perform various
+	 * prep/cleanup/error checking functions.
+	 */
+	skb->next = skb_shinfo(skb)->frag_list;
+	skb_shinfo(skb)->frag_list = NULL;
+	packets = skb;
+	prev_link = &packets;
+	for (skb = packets; skb; skb = next) {
+		next = skb->next;
+
+		/* Make the header available at skb->data, even if the packet
+		 * is fragmented. One complication: it's possible that the IP
+		 * header hasn't yet been removed (this happens for GRO packets
+		 * on the frag_list, since they aren't handled explicitly by IP.
+		 */
+		header_offset = skb_transport_header(skb) - skb->data;
+		pull_length = HOMA_MAX_HEADER + header_offset;
+		if (pull_length > skb->len)
+			pull_length = skb->len;
+		if (!pskb_may_pull(skb, pull_length))
+			goto discard;
+		if (header_offset)
+			__skb_pull(skb, header_offset);
+
+		/* Reject packets that are too short or have bogus types. */
+		h = (struct homa_common_hdr *)skb->data;
+		if (unlikely(skb->len < sizeof(struct homa_common_hdr) ||
+			     h->type < DATA || h->type >= BOGUS ||
+			     skb->len < header_lengths[h->type - DATA]))
+			goto discard;
+
+		/* Process the packet now if it is a control packet or
+		 * if it contains an entire short message.
+		 */
+		if (h->type != DATA || ntohl(((struct homa_data_hdr *)h)
+				->message_length) < 1400) {
+			*prev_link = skb->next;
+			skb->next = NULL;
+			homa_dispatch_pkts(skb, homa);
+		} else {
+			prev_link = &skb->next;
+		}
+		continue;
+
+discard:
+		*prev_link = skb->next;
+		kfree_skb(skb);
+	}
+
+	/* Now process the longer packets. Each iteration of this loop
+	 * collects all of the packets for a particular RPC and dispatches
+	 * them (batching the packets for an RPC allows more efficient
+	 * generation of grants).
+	 */
+	while (packets) {
+		struct in6_addr saddr, saddr2;
+		struct homa_common_hdr *h2;
+		struct sk_buff *skb2;
+
+		skb = packets;
+		prev_link = &skb->next;
+		saddr = skb_canonical_ipv6_saddr(skb);
+		other_pkts = NULL;
+		other_link = &other_pkts;
+		h = (struct homa_common_hdr *)skb->data;
+		for (skb2 = skb->next; skb2; skb2 = next) {
+			next = skb2->next;
+			h2 = (struct homa_common_hdr *)skb2->data;
+			if (h2->sender_id == h->sender_id) {
+				saddr2 = skb_canonical_ipv6_saddr(skb2);
+				if (ipv6_addr_equal(&saddr, &saddr2)) {
+					*prev_link = skb2;
+					prev_link = &skb2->next;
+					continue;
+				}
+			}
+			*other_link = skb2;
+			other_link = &skb2->next;
+		}
+		*prev_link = NULL;
+		*other_link = NULL;
+		homa_dispatch_pkts(packets, homa);
+		packets = other_pkts;
+	}
+
+	return 0;
+}
+
+/**
+ * homa_backlog_rcv() - Invoked to handle packets saved on a socket's
+ * backlog because it was locked when the packets first arrived.
+ * @sk:     Homa socket that owns the packet's destination port.
+ * @skb:    The incoming packet. This function takes ownership of the packet
+ *          (we'll delete it).
+ *
+ * Return:  Always returns 0.
+ */
+int homa_backlog_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	pr_warn_once("unimplemented backlog_rcv invoked on Homa socket\n");
+	kfree_skb(skb);
+	return 0;
+}
+
+/**
+ * homa_err_handler_v4() - Invoked by IP to handle an incoming error
+ * packet, such as ICMP UNREACHABLE.
+ * @skb:   The incoming packet.
+ * @info:  Information about the error that occurred?
+ *
+ * Return: zero, or a negative errno if the error couldn't be handled here.
+ */
+int homa_err_handler_v4(struct sk_buff *skb, u32 info)
+{
+	const struct icmphdr *icmp = icmp_hdr(skb);
+	struct homa *homa = global_homa;
+	struct in6_addr daddr;
+	int type = icmp->type;
+	int code = icmp->code;
+	struct iphdr *iph;
+	int error = 0;
+	int port = 0;
+
+	iph = (struct iphdr *)(skb->data);
+	ipv6_addr_set_v4mapped(iph->daddr, &daddr);
+	if (type == ICMP_DEST_UNREACH && code == ICMP_PORT_UNREACH) {
+		struct homa_common_hdr *h = (struct homa_common_hdr *)(skb->data
+				+ iph->ihl * 4);
+
+		port = ntohs(h->dport);
+		error = -ENOTCONN;
+	} else if (type == ICMP_DEST_UNREACH) {
+		if (code == ICMP_PROT_UNREACH)
+			error = -EPROTONOSUPPORT;
+		else
+			error = -EHOSTUNREACH;
+	} else {
+		pr_notice("%s invoked with info %x, ICMP type %d, ICMP code %d\n",
+			  __func__, info, type, code);
+	}
+	if (error != 0)
+		homa_abort_rpcs(homa, &daddr, port, error);
+	return 0;
+}
+
+/**
+ * homa_err_handler_v6() - Invoked by IP to handle an incoming error
+ * packet, such as ICMP UNREACHABLE.
+ * @skb:    The incoming packet.
+ * @opt:    Not used.
+ * @type:   Type of ICMP packet.
+ * @code:   Additional information about the error.
+ * @offset: Not used.
+ * @info:   Information about the error that occurred?
+ *
+ * Return: zero, or a negative errno if the error couldn't be handled here.
+ */
+int homa_err_handler_v6(struct sk_buff *skb, struct inet6_skb_parm *opt,
+			u8 type,  u8 code,  int offset,  __be32 info)
+{
+	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
+	struct homa *homa = global_homa;
+	int error = 0;
+	int port = 0;
+
+	if (type == ICMPV6_DEST_UNREACH && code == ICMPV6_PORT_UNREACH) {
+		const struct homa_common_hdr *h;
+
+		h = (struct homa_common_hdr *)(skb->data + sizeof(*iph));
+		port = ntohs(h->dport);
+		error = -ENOTCONN;
+	} else if (type == ICMPV6_DEST_UNREACH && code == ICMPV6_ADDR_UNREACH) {
+		error = -EHOSTUNREACH;
+	} else if (type == ICMPV6_PARAMPROB && code == ICMPV6_UNK_NEXTHDR) {
+		error = -EPROTONOSUPPORT;
+	}
+	if (error != 0)
+		homa_abort_rpcs(homa, &iph->daddr, port, error);
+	return 0;
+}
+
+/**
+ * homa_poll() - Invoked by Linux as part of implementing select, poll,
+ * epoll, etc.
+ * @file:  Open file that is participating in a poll, select, etc.
+ * @sock:  A Homa socket, associated with @file.
+ * @wait:  This table will be registered with the socket, so that it
+ *         is notified when the socket's ready state changes.
+ *
+ * Return: A mask of bits such as EPOLLIN, which indicate the current
+ *         state of the socket.
+ */
+__poll_t homa_poll(struct file *file, struct socket *sock,
+		   struct poll_table_struct *wait)
+{
+	struct sock *sk = sock->sk;
+	__u32 mask;
+
+	sock_poll_wait(file, sock, wait);
+	mask = POLLOUT | POLLWRNORM;
+
+	if (homa_sk(sk)->shutdown)
+		mask |= POLLIN;
+
+	if (!list_empty(&homa_sk(sk)->ready_requests) ||
+	    !list_empty(&homa_sk(sk)->ready_responses))
+		mask |= POLLIN | POLLRDNORM;
+	return (__poll_t)mask;
+}
+
+/**
+ * homa_hrtimer() - This function is invoked by the hrtimer mechanism to
+ * wake up the timer thread. Runs at IRQ level.
+ * @timer:   The timer that triggered; not used.
+ *
+ * Return:   Always HRTIMER_RESTART.
+ */
+enum hrtimer_restart homa_hrtimer(struct hrtimer *timer)
+{
+	wake_up_process(timer_kthread);
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * homa_timer_main() - Top-level function for the timer thread.
+ * @transport:  Pointer to struct homa.
+ *
+ * Return:         Always 0.
+ */
+int homa_timer_main(void *transport)
+{
+	struct homa *homa = (struct homa *)transport;
+
+	/* The following variable is static because hrtimer_init will
+	 * complain about a stack-allocated hrtimer if in debug mode.
+	 */
+	static struct hrtimer hrtimer;
+	ktime_t tick_interval;
+	u64 nsec;
+
+	hrtimer_init(&hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer.function = &homa_hrtimer;
+	nsec = 1000000;                   /* 1 ms */
+	tick_interval = ns_to_ktime(nsec);
+	while (1) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!exiting) {
+			hrtimer_start(&hrtimer, tick_interval,
+				      HRTIMER_MODE_REL);
+			schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+		if (exiting)
+			break;
+		homa_timer(homa);
+	}
+	hrtimer_cancel(&hrtimer);
+	kthread_complete_and_exit(&timer_thread_done, 0);
+	return 0;
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("John Ousterhout <ouster@cs.stanford.edu>");
+MODULE_DESCRIPTION("Homa transport protocol");
+MODULE_VERSION("1.0");
+
+/* Arrange for this module to be loaded automatically when a Homa socket is
+ * opened. Apparently symbols don't work in the macros below, so must use
+ * numeric values for IPPROTO_HOMA (146) and SOCK_DGRAM(2).
+ */
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 146, 2);
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 146, 2);
diff --git a/net/homa/homa_utils.c b/net/homa/homa_utils.c
new file mode 100644
index 000000000000..ac851eaff8b6
--- /dev/null
+++ b/net/homa/homa_utils.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains miscellaneous utility functions for Homa, such
+ * as initializing and destroying homa structs.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_stub.h"
+
+struct completion homa_pacer_kthread_done;
+
+/**
+ * homa_init() - Constructor for homa objects.
+ * @homa:   Object to initialize.
+ *
+ * Return:  0 on success, or a negative errno if there was an error. Even
+ *          if an error occurs, it is safe (and necessary) to call
+ *          homa_destroy at some point.
+ */
+int homa_init(struct homa *homa)
+{
+	int err;
+
+	homa->pacer_kthread = NULL;
+	init_completion(&homa_pacer_kthread_done);
+	atomic64_set(&homa->next_outgoing_id, 2);
+	atomic64_set(&homa->link_idle_time, sched_clock());
+	spin_lock_init(&homa->pacer_mutex);
+	homa->pacer_fifo_fraction = 50;
+	homa->pacer_fifo_count = 1;
+	homa->pacer_wake_time = 0;
+	spin_lock_init(&homa->throttle_lock);
+	INIT_LIST_HEAD_RCU(&homa->throttled_rpcs);
+	homa->throttle_add = 0;
+	homa->throttle_min_bytes = 200;
+	homa->prev_default_port = HOMA_MIN_DEFAULT_PORT - 1;
+	homa->port_map = kmalloc(sizeof(*homa->port_map), GFP_KERNEL);
+	if (!homa->port_map) {
+		pr_err("%s couldn't create port_map: kmalloc failure",
+		       __func__);
+		return -ENOMEM;
+	}
+	homa_socktab_init(homa->port_map);
+	homa->peers = kmalloc(sizeof(*homa->peers), GFP_KERNEL);
+	if (!homa->peers) {
+		pr_err("%s couldn't create peers: kmalloc failure", __func__);
+		return -ENOMEM;
+	}
+	err = homa_peertab_init(homa->peers);
+	if (err) {
+		pr_err("%s couldn't initialize peer table (errno %d)\n",
+		       __func__, -err);
+		return err;
+	}
+
+	/* Wild guesses to initialize configuration values... */
+	homa->link_mbps = 25000;
+	homa->resend_ticks = 5;
+	homa->resend_interval = 5;
+	homa->timeout_ticks = 100;
+	homa->timeout_resends = 5;
+	homa->request_ack_ticks = 2;
+	homa->reap_limit = 10;
+	homa->dead_buffs_limit = 5000;
+	homa->max_dead_buffs = 0;
+	homa->pacer_kthread = kthread_run(homa_pacer_main, homa,
+					  "homa_pacer");
+	if (IS_ERR(homa->pacer_kthread)) {
+		err = PTR_ERR(homa->pacer_kthread);
+		homa->pacer_kthread = NULL;
+		pr_err("couldn't create homa pacer thread: error %d\n", err);
+		return err;
+	}
+	homa->pacer_exit = false;
+	homa->max_nic_queue_ns = 5000;
+	homa->ns_per_mbyte = 0;
+	homa->max_gso_size = 10000;
+	homa->gso_force_software = 0;
+	homa->max_gro_skbs = 20;
+	homa->gro_policy = HOMA_GRO_NORMAL;
+	homa->timer_ticks = 0;
+	homa->flags = 0;
+	homa->bpage_lease_usecs = 10000;
+	homa->next_id = 0;
+	homa_outgoing_sysctl_changed(homa);
+	homa_incoming_sysctl_changed(homa);
+	return 0;
+}
+
+/**
+ * homa_destroy() -  Destructor for homa objects.
+ * @homa:      Object to destroy.
+ */
+void homa_destroy(struct homa *homa)
+{
+	if (homa->pacer_kthread) {
+		homa_pacer_stop(homa);
+		wait_for_completion(&homa_pacer_kthread_done);
+	}
+
+	/* The order of the following statements matters! */
+	if (homa->port_map) {
+		homa_socktab_destroy(homa->port_map);
+		kfree(homa->port_map);
+		homa->port_map = NULL;
+	}
+	if (homa->peers) {
+		homa_peertab_destroy(homa->peers);
+		kfree(homa->peers);
+		homa->peers = NULL;
+	}
+}
+
+/**
+ * homa_symbol_for_type() - Returns a printable string describing a packet type.
+ * @type:  A value from those defined by &homa_packet_type.
+ *
+ * Return: A static string holding the packet type corresponding to @type.
+ */
+char *homa_symbol_for_type(uint8_t type)
+{
+	switch (type) {
+	case DATA:
+		return "DATA";
+	case RESEND:
+		return "RESEND";
+	case UNKNOWN:
+		return "UNKNOWN";
+	case BUSY:
+		return "BUSY";
+	case NEED_ACK:
+		return "NEED_ACK";
+	case ACK:
+		return "ACK";
+	}
+	return "??";
+}
+
+/**
+ * homa_spin() - Delay (without sleeping) for a given time interval.
+ * @ns:   How long to delay (in nanoseconds)
+ */
+void homa_spin(int ns)
+{
+	__u64 end;
+
+	end = sched_clock() + ns;
+	while (sched_clock() < end)
+		/* Empty loop body.*/
+		;
+}
+
+/**
+ * homa_throttle_lock_slow() - This function implements the slow path for
+ * acquiring the throttle lock. It is invoked when the lock isn't immediately
+ * available. It waits for the lock, but also records statistics about
+ * the waiting time.
+ * @homa:    Overall data about the Homa protocol implementation.
+ */
+void homa_throttle_lock_slow(struct homa *homa)
+	__acquires(&homa->throttle_lock)
+{
+	spin_lock_bh(&homa->throttle_lock);
+}
-- 
2.34.1


