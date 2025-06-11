Return-Path: <netdev+bounces-196694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A4AD5F96
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D977AD2C1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A572BDC06;
	Wed, 11 Jun 2025 19:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ant7PzNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0EF2BD01E
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 19:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749671850; cv=none; b=I8d7S6ffJGWA1hYk6KCpLCsTsd4WcsrIvuOJ9wh9Xz8vTY+rvYEGUN93GVhFwsKMb+t7AO5gCwaRRqOEE3kIjT9iT8WVhHKF1p59bss9RmxqHPrsWxPwdCV/Sz4BaM4F0w+2M424dv0E0BMyOV9Yo67nI/11JnF3c73TLDExWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749671850; c=relaxed/simple;
	bh=ZssVXgx8hnnbULRb36vOlgpHe97BLFLepJWPJ+kY1BE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLGXN/4XzbNlyXeT1vAM39QM82Z1JDuKjP/hUno7HxGWfPF01OoX6GbYiN0OQiloA7myWW19EVKAnRcVsIvWutQnU6zIwxvTOR4aa5byiQk5UTypBECDNKLKXlQ8orJhrvUVGaJ8kyp2StXG5Liv8scR//2nefhR0GL0ecq4HJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ant7PzNJ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZU-00BIDS-Nw
	for netdev@vger.kernel.org; Wed, 11 Jun 2025 21:57:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=ewM7ow5NIDiWYLcRgpurn6xaYCHK+eeVvzpYtjNmuR8=; b=ant7PzNJleX8zqd5bFKA/t5+Pp
	fJ2DOf2RQIoY4e26o2JpLwuwdzZLUbXObCKnBJovSAbO8KW2nQxOZwNYUDcYng6b+n5ZMs8MfQRuE
	QTpImTsOiOCTz8fBbvyDAbgoRhzTJi8tZP3DXW4qHBFJSMka65YSpA6UwSUTVJtHLlJYZ5uYnLot+
	/XnxzTrcVYyE925cePhq1EvKf+NyH0NYUL6V3//oY9UVBkbk/6eW9lahRKZ5M5o92v5vbJyMD3Grw
	9I+z5Nnn4DFPUPNzcBz/Y4NMG+lDQBDcXLRnwohomdVymLwsFs7Kzu8VtZNqfVSLeEMidYZqY37YW
	hUr15p3A==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uPRZU-0004Al-6E; Wed, 11 Jun 2025 21:57:16 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uPRZH-00BycS-WF; Wed, 11 Jun 2025 21:57:04 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Wed, 11 Jun 2025 21:56:52 +0200
Subject: [PATCH net-next v3 3/3] vsock/test: Cover more CIDs in
 transport_uaf test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-vsock-test-inc-cov-v3-3-5834060d9c20@rbox.co>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
In-Reply-To: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Increase the coverage of test for UAF due to socket unbinding, and losing
transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
Add test for UAF due to socket unbinding") and discussion in [1].

The idea remains the same: take an unconnected stream socket with a
transport assigned and then attempt to switch the transport by trying (and
failing) to connect to some other CID. Now do this iterating over all the
well known CIDs (plus one).

While at it, drop the redundant synchronization between client and server.

Some single-transport setups can't be tested effectively; a warning is
issued. Depending on transports available, a variety of splats are possible
on unpatched machines. After reverting commit 78dafe1cf3af ("vsock: Orphan
socket after transport release") and commit fcdd2242c023 ("vsock: Keep the
binding until socket destruction"):

BUG: KASAN: slab-use-after-free in __vsock_bind+0x61f/0x720
Read of size 4 at addr ffff88811ff46b54 by task vsock_test/1475
Call Trace:
 dump_stack_lvl+0x68/0x90
 print_report+0x170/0x53d
 kasan_report+0xc2/0x180
 __vsock_bind+0x61f/0x720
 vsock_connect+0x727/0xc40
 __sys_connect+0xe8/0x100
 __x64_sys_connect+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

WARNING: CPU: 0 PID: 1475 at net/vmw_vsock/virtio_transport_common.c:37 virtio_transport_send_pkt_info+0xb2b/0x1160
Call Trace:
 virtio_transport_connect+0x90/0xb0
 vsock_connect+0x782/0xc40
 __sys_connect+0xe8/0x100
 __x64_sys_connect+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
RIP: 0010:sock_has_perm+0xa7/0x2a0
Call Trace:
 selinux_socket_connect_helper.isra.0+0xbc/0x450
 selinux_socket_connect+0x3b/0x70
 security_socket_connect+0x31/0xd0
 __sys_connect_file+0x79/0x1f0
 __sys_connect+0xe8/0x100
 __x64_sys_connect+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 7 PID: 1518 at lib/refcount.c:25 refcount_warn_saturate+0xdd/0x140
RIP: 0010:refcount_warn_saturate+0xdd/0x140
Call Trace:
 __vsock_bind+0x65e/0x720
 vsock_connect+0x727/0xc40
 __sys_connect+0xe8/0x100
 __x64_sys_connect+0x6e/0xc0
 do_syscall_64+0x92/0x1c0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 1475 at lib/refcount.c:28 refcount_warn_saturate+0x12b/0x140
RIP: 0010:refcount_warn_saturate+0x12b/0x140
Call Trace:
 vsock_remove_bound+0x18f/0x280
 __vsock_release+0x371/0x480
 vsock_release+0x88/0x120
 __sock_release+0xaa/0x260
 sock_close+0x14/0x20
 __fput+0x35a/0xaa0
 task_work_run+0xff/0x1c0
 do_exit+0x849/0x24c0
 make_task_dead+0xf3/0x110
 rewind_stack_and_make_dead+0x16/0x20

[1]: https://lore.kernel.org/netdev/CAGxU2F5zhfWymY8u0hrKksW8PumXAYz-9_qRmW==92oAx1BX3g@mail.gmail.com/

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 93 ++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 19 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index f669baaa0dca3bebc678d00eafa80857d1f0fdd6..eb6f54378667ac7ed324f4823e988ec9846e41a3 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1718,16 +1718,27 @@ static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
 
 #define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
 
-/* Test attempts to trigger a transport release for an unbound socket. This can
- * lead to a reference count mishandling.
- */
-static void test_stream_transport_uaf_client(const struct test_opts *opts)
+static bool test_stream_transport_uaf(int cid)
 {
 	int sockets[MAX_PORT_RETRIES];
 	struct sockaddr_vm addr;
-	int fd, i, alen;
+	socklen_t alen;
+	int fd, i, c;
+	bool ret;
+
+	/* Probe for a transport by attempting a local CID bind. Unavailable
+	 * transport (or more specifically: an unsupported transport/CID
+	 * combination) results in EADDRNOTAVAIL, other errnos are fatal.
+	 */
+	fd = vsock_bind_try(cid, VMADDR_PORT_ANY, SOCK_STREAM);
+	if (fd < 0) {
+		if (errno != EADDRNOTAVAIL) {
+			perror("Unexpected bind() errno");
+			exit(EXIT_FAILURE);
+		}
 
-	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
+		return false;
+	}
 
 	alen = sizeof(addr);
 	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
@@ -1735,38 +1746,83 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	/* Drain the autobind pool; see __vsock_bind_connectible(). */
 	for (i = 0; i < MAX_PORT_RETRIES; ++i)
-		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
-					SOCK_STREAM);
+		sockets[i] = vsock_bind(cid, ++addr.svm_port, SOCK_STREAM);
 
 	close(fd);
-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+
+	/* Setting SOCK_NONBLOCK makes connect() return soon after
+	 * (re-)assigning the transport. We are not connecting to anything
+	 * anyway, so there is no point entering the main loop in
+	 * vsock_connect(); waiting for timeout, checking for signals, etc.
+	 */
+	fd = socket(AF_VSOCK, SOCK_STREAM | SOCK_NONBLOCK, 0);
 	if (fd < 0) {
 		perror("socket");
 		exit(EXIT_FAILURE);
 	}
 
-	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
-		perror("Unexpected connect() #1 success");
+	/* Assign transport, while failing to autobind. Autobind pool was
+	 * drained, so EADDRNOTAVAIL coming from __vsock_bind_connectible() is
+	 * expected.
+	 *
+	 * One exception is ENODEV which is thrown by vsock_assign_transport(),
+	 * i.e. before vsock_auto_bind(), when the only transport loaded is
+	 * vhost.
+	 */
+	if (!connect(fd, (struct sockaddr *)&addr, alen)) {
+		fprintf(stderr, "Unexpected connect() success\n");
 		exit(EXIT_FAILURE);
 	}
-
-	/* Vulnerable system may crash now. */
-	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
-		perror("Unexpected connect() #2 success");
+	if (errno == ENODEV && cid == VMADDR_CID_HOST) {
+		ret = false;
+		goto cleanup;
+	}
+	if (errno != EADDRNOTAVAIL) {
+		perror("Unexpected connect() errno");
 		exit(EXIT_FAILURE);
 	}
 
+	/* Reassign transport, triggering old transport release and
+	 * (potentially) unbinding of an unbound socket.
+	 *
+	 * Vulnerable system may crash now.
+	 */
+	for (c = VMADDR_CID_HYPERVISOR; c <= VMADDR_CID_HOST + 1; ++c) {
+		if (c != cid) {
+			addr.svm_cid = c;
+			(void)connect(fd, (struct sockaddr *)&addr, alen);
+		}
+	}
+
+	ret = true;
+cleanup:
 	close(fd);
 	while (i--)
 		close(sockets[i]);
 
-	control_writeln("DONE");
+	return ret;
 }
 
-static void test_stream_transport_uaf_server(const struct test_opts *opts)
+/* Test attempts to trigger a transport release for an unbound socket. This can
+ * lead to a reference count mishandling.
+ */
+static void test_stream_transport_uaf_client(const struct test_opts *opts)
 {
-	control_expectln("DONE");
+	bool tested = false;
+	int cid, tr;
+
+	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
+		tested |= test_stream_transport_uaf(cid);
+
+	tr = get_transports();
+	if (!tr)
+		fprintf(stderr, "No transports detected\n");
+	else if (tr == TRANSPORT_VIRTIO)
+		fprintf(stderr, "Setup unsupported: sole virtio transport\n");
+	else if (!tested)
+		fprintf(stderr, "No transports tested\n");
 }
 
 static void test_stream_connect_retry_client(const struct test_opts *opts)
@@ -2034,7 +2090,6 @@ static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM transport release use-after-free",
 		.run_client = test_stream_transport_uaf_client,
-		.run_server = test_stream_transport_uaf_server,
 	},
 	{
 		.name = "SOCK_STREAM retry failed connect()",

-- 
2.49.0


