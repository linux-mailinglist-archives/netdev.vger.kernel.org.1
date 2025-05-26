Return-Path: <netdev+bounces-193383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A415FAC3BA3
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BDEF1895EE1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF81E47B4;
	Mon, 26 May 2025 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbRHNMh/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9811DF26B
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247949; cv=none; b=MYntl1MYh67smWbt7/ejsTUi2cRx3Intrs1hBM2IPKZX4CSP+fg5HL/QJ78xbLtmIVepfFk7aLJHvzeKv2OMYj85Pr9KfKj8hbC7RyIIu4hlH9RGS/iHoB4jULdh9nslllL6No6AqaGEHEoy+oLdsNw/S6K6t5eGn918uDKQnZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247949; c=relaxed/simple;
	bh=K83yCE+YzRiWzacXiQCLsKtaqmiaTfFf5Eo2iw8w190=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAUBOAScoUytt3cPNR6wum3fqKUiny0nw8DD15Q2IM2QqEDKP61peVHPthNKwq6hx5/pdJ0T+KcMJLD8ROYv0tjh37paZ4HQ2gR9EbsdBvAuXvvtepwBPRPfynPcm6Tmd1bgcnozfw9Wy8VgRFGPCCujnVcYdTBd0PkAj5+4HvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FbRHNMh/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748247946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=brR9RanZLd9PDDvGU6pW/0vav9vfvMbdh04Ccji6D3Y=;
	b=FbRHNMh/3D2M6sK3WsbMCvEYdapDXK2oU330sDmoDpMurxuoGwRSz5fPLbRvzG1UTIY+zm
	DLY7fURGj1ogwk919AtuJyOw3lN/eV0+/iVbV9igZfp8VFZ6SiUAEQmjOlPn0oL9kqwlet
	LlKteCORAB8Kz9Ha5/rOunsR3DLbvsU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-_DBtj77zPpC19NNGIDAvVg-1; Mon, 26 May 2025 04:25:43 -0400
X-MC-Unique: _DBtj77zPpC19NNGIDAvVg-1
X-Mimecast-MFC-AGG-ID: _DBtj77zPpC19NNGIDAvVg_1748247942
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so158231266b.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748247942; x=1748852742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brR9RanZLd9PDDvGU6pW/0vav9vfvMbdh04Ccji6D3Y=;
        b=KVit9bUaB53/pp9FZHyi/8D+zMm4yupKL6gqU/XkFNEKDXM9W5ZE7gOEiJLU8EMr8V
         cQell7iN8gUGZpr/oKXkjp2mLcHSUM20hSkKI4Sql7xd4zrZ9eLUC8qpa7tmbKQ6rUK0
         +ZQJjjnAnamHNq1IWsSG1jFmpxclsnIIPetRICQpjmArP0JvCKzPy1v8Pns7EvAT7CzE
         VBLuhwyd7liupNYIkyZQD5oVScm7c4FF7U5z57yk7ItT0vO8bRttDA5zt2vdV1DpXGWK
         efcvJoQdpH1TRkMyt3JWDoazPyG9SO4T0gJKfFIhn0VeiksTwuPxoITXPNvr2MfYP5Yz
         hyHA==
X-Forwarded-Encrypted: i=1; AJvYcCXMR0iyO+uzsfzDBfP+Pki7FdsQd2Rbgj92tqejBnQgnjlfTKhKcFruoOefOQot68MD0X13DIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLglMalnmuuOw9gXIYHbWuHhhREvPdzm+6Bi0kiBKfMWJwSe0Z
	9hzz4QUmqOyjGFtCl3ipfIed8NidHBhbTsaK9oHMa8rlRdh88MQaW0RVnu9zrWP1OO0ezvyycsu
	Zb6cDWx4kobVGzvYoqjA4HJZNzFqw/brwZqS5WGSZDqbvKcyZrnMa9xkdSg==
X-Gm-Gg: ASbGncsldWf4oWfA6i0I01Y3N0nOBqeotJsQa80TV6NNZ5xD6s6vTrnx63tjcQ5J299
	08UcP4139JXWMW44LQm7MLMd4sOWuQ4m/zlKeRgAA4hT5N0s3MelwrUvFAZLTQ8DUzmXC93JLYV
	5dVstBxqHcHRaTHNreSFSEA1uB1jn3zuaVk4AV3vNDiI8rKKU8II/hhN6kiOVD+KoUhNrCu+86d
	bm9w4oPDo4k4DT2P4kysGReUTY6Uz9lKB9+ClBNz13INf8p2wQzLBxM6JntKSVT2Nb2iZKSocC+
	jEKLVr9zjHsAeRAelNpvIVy9TmWz6N5gXCLwgnhtPgi0GJ2zCuzAna2Q+O0o
X-Received: by 2002:a17:907:6091:b0:ad2:541f:b663 with SMTP id a640c23a62f3a-ad85b03dffdmr799372266b.16.1748247941981;
        Mon, 26 May 2025 01:25:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6YPwyH+H3hAxOxOP41htYHc+je4EMl3hPGFZtw4HbhwMYTqW3rxKk3dK/pDtj9+zmOaQp4w==
X-Received: by 2002:a17:907:6091:b0:ad2:541f:b663 with SMTP id a640c23a62f3a-ad85b03dffdmr799368766b.16.1748247941312;
        Mon, 26 May 2025 01:25:41 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d27192dsm1640853866b.71.2025.05.26.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 01:25:40 -0700 (PDT)
Date: Mon, 26 May 2025 10:25:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vsock/test: Cover more CIDs in transport_uaf
 test
Message-ID: <limbmrszio42lvkmalapooflj5miedlszkmnnm4ckmy2upfghw@24vxuhgdji2z>
References: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250523-vsock-test-inc-cov-v1-1-fa3507941bbd@rbox.co>

On Fri, May 23, 2025 at 12:31:16AM +0200, Michal Luczaj wrote:
>Increase the coverage of test for UAF due to socket unbinding, and losing
>transport in general. It's a follow up to commit 301a62dfb0d0 ("vsock/test:
>Add test for UAF due to socket unbinding") and discussion in [1].
>
>The idea remains the same: take an unconnected stream socket with a
>transport assigned and then attempt to switch the transport by trying (and
>failing) to connect to some other CID. Now do this iterating over all the
>well known CIDs (plus one).
>
>Note that having only a virtio transport loaded (without vhost_vsock) is
>unsupported; test will always pass. Depending on transports available, a

Do you think it might make sense to print a warning if we are in this 
case, perhaps by parsing /proc/modules and looking at vsock 
dependencies?

>variety of splats are possible on unpatched machines. After reverting
>commit fcdd2242c023 ("vsock: Keep the binding until socket destruction"):
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
> tools/testing/vsock/vsock_test.c | 72 +++++++++++++++++++++++++++++++---------
> 1 file changed, 57 insertions(+), 15 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9ea33b78b9fcb532f4f9616b38b4d2b627b04d31..460a8838e5e6a0f155e66e7720358208bab9520f 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1729,16 +1729,32 @@ static void test_stream_msgzcopy_leak_zcskb_server(const struct test_opts *opts)
>
> #define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
>
>-/* Test attempts to trigger a transport release for an unbound socket. This can
>- * lead to a reference count mishandling.
>- */
>-static void test_stream_transport_uaf_client(const struct test_opts *opts)
>+static bool test_stream_transport_uaf(int cid)
> {
>+	struct sockaddr_vm addr = {
>+		.svm_family = AF_VSOCK,
>+		.svm_cid = cid,
>+		.svm_port = VMADDR_PORT_ANY
>+	};
> 	int sockets[MAX_PORT_RETRIES];
>-	struct sockaddr_vm addr;
>-	int fd, i, alen;
>+	socklen_t alen;
>+	int fd, i, c;
>
>-	fd = vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, SOCK_STREAM);
>+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>+	if (fd < 0) {
>+		perror("socket");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr))) {
>+		if (errno != EADDRNOTAVAIL) {
>+			perror("Unexpected bind() errno");
>+			exit(EXIT_FAILURE);
>+		}
>+
>+		close(fd);
>+		return false;

Perhaps we should mention in the commit or in a comment above this 
function, what we return and why we can expect EADDRNOTAVAIL.

>+	}

What about adding a vsock_bind_try() in util.c that can fail returning
errno, so we can share most of the code with vsock_bind()?

>
> 	alen = sizeof(addr);
> 	if (getsockname(fd, (struct sockaddr *)&addr, &alen)) {
>@@ -1746,9 +1762,9 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
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
> 	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
>@@ -1757,21 +1773,47 @@ static void test_stream_transport_uaf_client(const struct test_opts *opts)
> 		exit(EXIT_FAILURE);
> 	}
>
>-	if (!vsock_connect_fd(fd, addr.svm_cid, addr.svm_port)) {
>-		perror("Unexpected connect() #1 success");
>+	/* Assign transport, while failing to autobind.
>+	 * ENODEV indicates a missing transport.
>+	 */
>+	errno = 0;
>+	if (!vsock_connect_fd(fd, cid, VMADDR_PORT_ANY) ||
>+	    errno != EADDRNOTAVAIL) {
>+		perror("Unexpected connect() result");
> 		exit(EXIT_FAILURE);
> 	}
>
>-	/* Vulnerable system may crash now. */
>-	if (!vsock_connect_fd(fd, VMADDR_CID_HOST, VMADDR_PORT_ANY)) {
>-		perror("Unexpected connect() #2 success");
>-		exit(EXIT_FAILURE);
>+	/* Reassign transport, triggering old transport release and
>+	 * (potentially) unbinding of an unbound socket.
>+	 *
>+	 * Vulnerable system may crash now.
>+	 */
>+	for (c = VMADDR_CID_HYPERVISOR; c <= VMADDR_CID_HOST + 1; ++c) {
>+		if (c != cid)
>+			(void)vsock_connect_fd(fd, c, VMADDR_PORT_ANY);
> 	}
>
> 	close(fd);
> 	while (i--)
> 		close(sockets[i]);
>
>+	return true;
>+}
>+
>+/* Test attempts to trigger a transport release for an unbound socket. This can
>+ * lead to a reference count mishandling.
>+ */
>+static void test_stream_transport_uaf_client(const struct test_opts *opts)
>+{
>+	bool tested = false;
>+	int cid;
>+
>+	for (cid = VMADDR_CID_HYPERVISOR; cid <= VMADDR_CID_HOST + 1; ++cid)

>+		tested |= test_stream_transport_uaf(cid);
>+
>+	if (!tested)
>+		fprintf(stderr, "No transport tested\n");
>+
> 	control_writeln("DONE");

While we're at it, I think we can remove this message, looking at 
run_tests() in util.c, we already have a barrier.

Thanks,
Stefano

> }
>
>
>---
>base-commit: 610c248178b38fac2b601cd9f0f8a5e8be7fd248
>change-id: 20250326-vsock-test-inc-cov-b823822bdb78
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>


