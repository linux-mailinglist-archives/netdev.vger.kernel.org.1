Return-Path: <netdev+bounces-192866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C508AC16D8
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939B81BC873C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C38277021;
	Thu, 22 May 2025 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="ZO0mvMwz"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CD1B4254
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953099; cv=none; b=HZjA7Q3KpQcXmxDlYZFCBXdYqahnIKnipxWcF2d1YpNQvZ1tSL7D86E2ch/R/Dy7xR2/5YDxo9m7RZoxQpD5aIc3HqfU8xezipcq7npDstlE4aJeEiPwAraFM3z3u5gjLQKQHmFIjhbLJpBOFBdVOC5cPhCMLLUwK166W+SOVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953099; c=relaxed/simple;
	bh=8jYgux2zyNhAr7RiTJU6scAIFsWzTW41T6SuCq8cTxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SQMj62cmFJFxvJmSO24QXMRXeXUpRI2pVIR0NQp2nwMJuL3cvY3XGajC+WXro+ilkj0CrawbSsnrAqpNx++gTC8p63lQGrw/tXZFvRbpfNWWAf67yYMUWAbsbFtcggFi7ILScnyyaoA/6syLECmmqPc3cpsY+LjXfjMeWbG+DEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=ZO0mvMwz; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uIERp-0077L7-Ed; Fri, 23 May 2025 00:31:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From;
	bh=EqLCIP2omh6G05kQeDPe8g5jcYP+8sXBvbnmWmz/eKA=; b=ZO0mvMwzf6cpPVbJ7klvJhME+G
	qkbvz3mX51sog5NtzgjOiNXZOqq9QpqF8IANczk9bwo2W+Bq5YUG9MgPPuWwlgXNwTTu3WbloOrRU
	D9V3xTVbAwy9IoIJq07A3Ycp4sh8c5PccgalCPYNlBJF9Vi0UN5vASYjfUVbsPWR2AlOq0Eyaezf4
	+YipfIBL1xTWSFs2bnIhxOaUN4vgGhZ2H8qoouAQ0DsewKpra1CW3ZRs41nf9kjdsX7N92iBGO3hv
	UOb8gvyu/cYIUT9kQP0QruxsZpXGL0EFp8v7csdCqLroeHtXmKg5ohiuKZewdCZ/Q3VSZNYztNuPA
	ozlAPy8g==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uIERm-0007Fn-UN; Fri, 23 May 2025 00:31:33 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uIERj-0096Ef-7A; Fri, 23 May 2025 00:31:27 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 23 May 2025 00:31:16 +0200
Subject: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
X-B4-Tracking: v=1; b=H4sIALOlL2gC/x3MwQqDMAyA4VeRnA1oilvxVYYHW7MtDNLRlCKI7
 27x+B3+/wDjLGwwdwdkrmKStGHsO4jfVT+MsjUDDTQNjh5YLcUfFraCohFjqhg8OU8UtvD00MJ
 /5rfs9/QFygWV9wLLeV7XPjrtbgAAAA==
X-Change-ID: 20250326-vsock-test-inc-cov-b823822bdb78
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

Note that having only a virtio transport loaded (without vhost_vsock) is
unsupported; test will always pass. Depending on transports available, a
variety of splats are possible on unpatched machines. After reverting
commit fcdd2242c023 ("vsock: Keep the binding until socket destruction"):

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
 tools/testing/vsock/vsock_test.c | 72 +++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 9ea33b78b9fcb532f4f9616b38b4d2b627b04d31..460a8838e5e6a0f155e66e7720358208bab9520f 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1729,16 +1729,32 @@ static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
 
 #define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
 
-/* Test attempts to trigger a transport release for an unbound socket. This can
- * lead to a reference count mishandling.
- */
-static void test_stream_transport_uaf_client(const struct test_opts *opts)
+static bool test_stream_transport_uaf(int cid)
 {
+	struct sockaddr_vm addr = {
+		.svm_family = AF_VSOCK,
+		.svm_cid = cid,
+		.svm_port = VMADDR_PORT_ANY
+	};
 	int sockets[MAX_PORT_RETRIES];
-	struct sockaddr_vm addr;
-	int fd, i, alen;
+	socklen_t alen;
+	int fd, i, c;
 
-	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
+		if (errno != EADDRNOTAVAIL) {
+			perror("Unexpected bind() errno");
+			exit(EXIT_FAILURE);
+		}
+
+		close(fd);
+		return false;
+	}
 
 	alen = sizeof(addr);
 	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
@@ -1746,9 +1762,9 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
+	/* Drain the autobind pool; see __vsock_bind_connectible(). */
 	for (i = 0; i < MAX_PORT_RETRIES; ++i)
-		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
-					SOCK_STREAM);
+		sockets[i] = vsock_bind(cid, ++addr.svm_port, SOCK_STREAM);
 
 	close(fd);
 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
@@ -1757,21 +1773,47 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
 		exit(EXIT_FAILURE);
 	}
 
-	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
-		perror("Unexpected connect() #1 success");
+	/* Assign transport, while failing to autobind.
+	 * ENODEV indicates a missing transport.
+	 */
+	errno = 0;
+	if (!vsock_connect_fd(fd, cid, VMADDR_PORT_ANY) ||
+	    errno != EADDRNOTAVAIL) {
+		perror("Unexpected connect() result");
 		exit(EXIT_FAILURE);
 	}
 
-	/* Vulnerable system may crash now. */
-	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
-		perror("Unexpected connect() #2 success");
-		exit(EXIT_FAILURE);
+	/* Reassign transport, triggering old transport release and
+	 * (potentially) unbinding of an unbound socket.
+	 *
+	 * Vulnerable system may crash now.
+	 */
+	for (c = VMADDR_CID_HYPERVISOR; c <= VMADDR_CID_HOST + 1; ++c) {
+		if (c != cid)
+			(void)vsock_connect_fd(fd, c, VMADDR_PORT_ANY);
 	}
 
 	close(fd);
 	while (i--)
 		close(sockets[i]);
 
+	return true;
+}
+
+/* Test attempts to trigger a transport release for an unbound socket. This can
+ * lead to a reference count mishandling.
+ */
+static void test_stream_transport_uaf_client(const struct test_opts *opts)
+{
+	bool tested = false;
+	int cid;
+
+	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
+		tested |= test_stream_transport_uaf(cid);
+
+	if (!tested)
+		fprintf(stderr, "No transport tested\n");
+
 	control_writeln("DONE");
 }
 

---
base-commit: 610c248178b38fac2b601cd9f0f8a5e8be7fd248
change-id: 20250326-vsock-test-inc-cov-b823822bdb78

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


