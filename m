Return-Path: <netdev+bounces-198659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E9DADCF9A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4828018874D0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABA2EACFA;
	Tue, 17 Jun 2025 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgsNViCD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3766D2EACE5
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169620; cv=none; b=pWDhimcaue9YR0KZr9qNJ+o2x2avT/Pu61ey2a6+TvLDN71HdskLuXVdm5rRwZDepSKd6qSPp/0bN0fOGV4R/I64dIBvxJ94jQfqKH8VyrpBEbmNswKTFqTLJSEb22JjjgUoOfvRP3g8+CMTv/bRj+zYWmrFOiG5mftncXGsYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169620; c=relaxed/simple;
	bh=hVwsYYZn36xXiF5W8xIP83MlOYW1QisiRJWsNZw5rJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzSs+Ss+Y6CG9EzEuMiOAqIfNF31clpKSpSuFfKgRMGgbv8uV7PE3zJp187nOSo/UuEOJVavTzcQfamxQoQ60qGG6fObFxBjyQNQJdj7poo8zu6Qh2BF3JaNNkHyJSdhXQ72nZYbg7jy5cJzcSJeryQDASYgDVrhN8MQJC+Xp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgsNViCD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750169617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTK+V3/5AEIMjD1XgMrGA0E/N7Cn3he/i5NWgha0jd4=;
	b=YgsNViCDZ0HCsmmfCFYz34aZRNfKbz2AD5bFIdGx6RlohYu8AkiMKeGDNZid+o7KpdNT6R
	lW/HKqNjEn4DhC5kGtDITesP77n4mUeAL78mp/wPrA517AnbOYSTaslmsjZd76LrenWmFI
	DrLNCt1tPXnpytbY6H338Wb3ytes+Xo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-SXHw_C3wNSyhpf-_cKXjFw-1; Tue, 17 Jun 2025 10:13:35 -0400
X-MC-Unique: SXHw_C3wNSyhpf-_cKXjFw-1
X-Mimecast-MFC-AGG-ID: SXHw_C3wNSyhpf-_cKXjFw_1750169615
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4530623eb8fso41464585e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169614; x=1750774414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTK+V3/5AEIMjD1XgMrGA0E/N7Cn3he/i5NWgha0jd4=;
        b=jMl3l8tFcsXebZIo5A92D6FCamJN24QtQHzSBXptkzp9URDwMO6lZY3+6mtQGHUfxB
         bZqPg2+Ck6VFIWw8ssGb/wKyAaHnXr68GRLa5GDrZDs/+Vx9Dj5c7+u+EepDkBx7hMwx
         C8Qt9DY9Dksr883JImejRabBNqxoFc4sW/zVEmLUmRxxD61uKtwSgsjZ2hQdfH+coNxp
         t2rwhYGqLTJCZqfUGeOpDsPWtaVmnnVPV25YKLl/hNdWmqAAuNDd8lSGYdvm5fQoHBBD
         zCizrUrS5THNelGIPZVuM5aMxOgr0yuER/j3SS0c+QhSDy5erp0RuT41uf7B2X0Zxxtm
         4jgA==
X-Forwarded-Encrypted: i=1; AJvYcCXZY3yhr77GEDSE3hO19KTsZKPUuYGZIQh1IYRHawYhacr1eXIyyLm/z++f93wMh7UPS6QkP8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFrnTd+im+YwkuNsa2sXklQXom2pzeiuydS63KrYHf4sh++wpf
	9Y1Cu4lJxHzmqwfsHq1R+dmQDnmBu8Gm+f/WFSV9i//UtrOSHDWxqptqfSmNtUHOd2Y4GJ6qq+a
	v7QeoRJ68+NL2Z/XkTmFoVzcr3/qp6fZTxBXg73ZDZjsg+bbuIwYn9bRJSw==
X-Gm-Gg: ASbGncv9rrpaDRN4R4JgbFX1pUhGus+fp7tAB3yYafkg14t/2/xFUVC9iJFJfGSscGQ
	bDE/Ri+ZYbsGhHPUt3cdCM+OYE2Llu27/h2sbL2gBcHWFCJaZEUq+P+GlHbeb7LYeipX4mXxUS6
	Ip7r7yFu0McwXzXpLZy/P34y+kbiLp8C7m/ZEMfTd1kTzNY/qtKovn+M6QreghDl1kLBWRhAOQr
	LJmfoETbaDs5Z4M3pSuoYiG4tCypBN8aaDm8gUqZrz38X40TfL7qSlo5N2uzxIdfU7CSYaOKN96
	IxxYcfHOB8EkGaFSmitcHo3W+nb2
X-Received: by 2002:a05:600c:3e0f:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-4533ca6e93fmr146086595e9.15.1750169614471;
        Tue, 17 Jun 2025 07:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPlcYkMqJhY85N5kdJ0NVPIrUeWzKVBvVBAW5XUvo4CXxFBhQJGAXlkXspSZkF+qZOv0I1Kw==
X-Received: by 2002:a05:600c:3e0f:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-4533ca6e93fmr146086135e9.15.1750169613883;
        Tue, 17 Jun 2025 07:13:33 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea15b0sm179940885e9.11.2025.06.17.07.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:13:32 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:13:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] vsock/test: Cover more CIDs in
 transport_uaf test
Message-ID: <ktw4ong6tsucyx2j2okeow6do7x6whakjg75hyoc7cwzxnt2mu@qzkve4sdpu4o>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
 <20250611-vsock-test-inc-cov-v3-3-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250611-vsock-test-inc-cov-v3-3-5834060d9c20@rbox.co>

On Wed, Jun 11, 2025 at 09:56:52PM +0200, Michal Luczaj wrote:
>Increase the coverage of test for UAF due to socket unbinding, and losing
>transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>Add test for UAF due to socket unbinding") and discussion in [1].
>
>The idea remains the same: take an unconnected stream socket with a
>transport assigned and then attempt to switch the transport by trying (and
>failing) to connect to some other CID. Now do this iterating over all the
>well known CIDs (plus one).
>
>While at it, drop the redundant synchronization between client and server.
>
>Some single-transport setups can't be tested effectively; a warning is
>issued. Depending on transports available, a variety of splats are possible
>on unpatched machines. After reverting commit 78dafe1cf3af ("vsock: Orphan
>socket after transport release") and commit fcdd2242c023 ("vsock: Keep the
>binding until socket destruction"):
>
>BUG: KASAN: slab-use-after-free in __vsock_bind+0x61f/0x720
>Read of size 4 at addr ffff88811ff46b54 by task vsock_test/1475
>Call Trace:
> dump_stack_lvl+0x68/0x90
> print_report+0x170/0x53d
> kasan_report+0xc2/0x180
> __vsock_bind+0x61f/0x720
> vsock_connect+0x727/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>WARNING: CPU: 0 PID: 1475 at net/vmw_vsock/virtio_transport_common.c:37 virtio_transport_send_pkt_info+0xb2b/0x1160
>Call Trace:
> virtio_transport_connect+0x90/0xb0
> vsock_connect+0x782/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>RIP: 0010:sock_has_perm+0xa7/0x2a0
>Call Trace:
> selinux_socket_connect_helper.isra.0+0xbc/0x450
> selinux_socket_connect+0x3b/0x70
> security_socket_connect+0x31/0xd0
> __sys_connect_file+0x79/0x1f0
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>refcount_t: addition on 0; use-after-free.
>WARNING: CPU: 7 PID: 1518 at lib/refcount.c:25 refcount_warn_saturate+0xdd/0x140
>RIP: 0010:refcount_warn_saturate+0xdd/0x140
>Call Trace:
> __vsock_bind+0x65e/0x720
> vsock_connect+0x727/0xc40
> __sys_connect+0xe8/0x100
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x92/0x1c0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>refcount_t: underflow; use-after-free.
>WARNING: CPU: 0 PID: 1475 at lib/refcount.c:28 refcount_warn_saturate+0x12b/0x140
>RIP: 0010:refcount_warn_saturate+0x12b/0x140
>Call Trace:
> vsock_remove_bound+0x18f/0x280
> __vsock_release+0x371/0x480
> vsock_release+0x88/0x120
> __sock_release+0xaa/0x260
> sock_close+0x14/0x20
> __fput+0x35a/0xaa0
> task_work_run+0xff/0x1c0
> do_exit+0x849/0x24c0
> make_task_dead+0xf3/0x110
> rewind_stack_and_make_dead+0x16/0x20
>
>[1]: https://lore.kernel.org/netdev/CAGxU2F5zhfWymY8u0hrKksW8PumXAYz-9_qRmW==92oAx1BX3g@mail.gmail.com/
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c | 93 ++++++++++++++++++++++++++++++++--------
> 1 file changed, 74 insertions(+), 19 deletions(-)

Thanks again for this!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f669baaa0dca3bebc678d00eafa80857d1f0fdd6..eb6f54378667ac7ed324f4823e988ec9846e41a3 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1718,16 +1718,27 @@ static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
>
> #define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
>
>-/* Test attempts to trigger a transport release for an unbound socket. This can
>- * lead to a reference count mishandling.
>- */
>-static void test_stream_transport_uaf_client(const struct test_opts *opts)
>+static bool test_stream_transport_uaf(int cid)
> {
> 	int sockets[MAX_PORT_RETRIES];
> 	struct sockaddr_vm addr;
>-	int fd, i, alen;
>+	socklen_t alen;
>+	int fd, i, c;
>+	bool ret;
>+
>+	/* Probe for a transport by attempting a local CID bind. Unavailable
>+	 * transport (or more specifically: an unsupported transport/CID
>+	 * combination) results in EADDRNOTAVAIL, other errnos are fatal.
>+	 */
>+	fd = vsock_bind_try(cid, VMADDR_PORT_ANY, SOCK_STREAM);
>+	if (fd < 0) {
>+		if (errno != EADDRNOTAVAIL) {
>+			perror("Unexpected bind() errno");
>+			exit(EXIT_FAILURE);
>+		}
>
>-	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>+		return false;
>+	}
>
> 	alen = sizeof(addr);
> 	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
>@@ -1735,38 +1746,83 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>+	/* Drain the autobind pool; see __vsock_bind_connectible(). */
> 	for (i = 0; i < MAX_PORT_RETRIES; ++i)
>-		sockets[i] = vsock_bind(VMADDR_CID_ANY, ++addr.svm_port,
>-					SOCK_STREAM);
>+		sockets[i] = vsock_bind(cid, ++addr.svm_port, SOCK_STREAM);
>
> 	close(fd);
>-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+
>+	/* Setting SOCK_NONBLOCK makes connect() return soon after
>+	 * (re-)assigning the transport. We are not connecting to anything
>+	 * anyway, so there is no point entering the main loop in
>+	 * vsock_connect(); waiting for timeout, checking for signals, etc.
>+	 */
>+	fd = socket(AF_VSOCK, SOCK_STREAM | SOCK_NONBLOCK, 0);
> 	if (fd < 0) {
> 		perror("socket");
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
>-		perror("Unexpected connect() #1 success");
>+	/* Assign transport, while failing to autobind. Autobind pool was
>+	 * drained, so EADDRNOTAVAIL coming from __vsock_bind_connectible() is
>+	 * expected.
>+	 *
>+	 * One exception is ENODEV which is thrown by vsock_assign_transport(),
>+	 * i.e. before vsock_auto_bind(), when the only transport loaded is
>+	 * vhost.
>+	 */
>+	if (!connect(fd, (struct sockaddr *)&addr, alen)) {
>+		fprintf(stderr, "Unexpected connect() success\n");
> 		exit(EXIT_FAILURE);
> 	}
>-
>-	/* Vulnerable system may crash now. */
>-	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
>-		perror("Unexpected connect() #2 success");
>+	if (errno == ENODEV && cid == VMADDR_CID_HOST) {
>+		ret = false;
>+		goto cleanup;
>+	}
>+	if (errno != EADDRNOTAVAIL) {
>+		perror("Unexpected connect() errno");
> 		exit(EXIT_FAILURE);
> 	}
>
>+	/* Reassign transport, triggering old transport release and
>+	 * (potentially) unbinding of an unbound socket.
>+	 *
>+	 * Vulnerable system may crash now.
>+	 */
>+	for (c = VMADDR_CID_HYPERVISOR; c <= VMADDR_CID_HOST + 1; ++c) {
>+		if (c != cid) {
>+			addr.svm_cid = c;
>+			(void)connect(fd, (struct sockaddr *)&addr, alen);
>+		}
>+	}
>+
>+	ret = true;
>+cleanup:
> 	close(fd);
> 	while (i--)
> 		close(sockets[i]);
>
>-	control_writeln("DONE");
>+	return ret;
> }
>
>-static void test_stream_transport_uaf_server(const struct test_opts *opts)
>+/* Test attempts to trigger a transport release for an unbound socket. This can
>+ * lead to a reference count mishandling.
>+ */
>+static void test_stream_transport_uaf_client(const struct test_opts *opts)
> {
>-	control_expectln("DONE");
>+	bool tested = false;
>+	int cid, tr;
>+
>+	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)
>+		tested |= test_stream_transport_uaf(cid);
>+
>+	tr = get_transports();
>+	if (!tr)
>+		fprintf(stderr, "No transports detected\n");
>+	else if (tr == TRANSPORT_VIRTIO)
>+		fprintf(stderr, "Setup unsupported: sole virtio transport\n");
>+	else if (!tested)
>+		fprintf(stderr, "No transports tested\n");
> }
>
> static void test_stream_connect_retry_client(const struct test_opts *opts)
>@@ -2034,7 +2090,6 @@ static struct test_case test_cases[] = {
> 	{
> 		.name = "SOCK_STREAM transport release use-after-free",
> 		.run_client = test_stream_transport_uaf_client,
>-		.run_server = test_stream_transport_uaf_server,
> 	},
> 	{
> 		.name = "SOCK_STREAM retry failed connect()",
>
>-- 
>2.49.0
>


