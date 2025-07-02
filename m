Return-Path: <netdev+bounces-203282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC6AF11DC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB914A2C9D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4B258CF1;
	Wed,  2 Jul 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxBM+HxE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F824DD0B
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452092; cv=none; b=oRhfGgMkri72PHd23yrM9GnjhTeitxgYbfswHXckVhQuFB9N7enDxNV38s7Myy9vquQ6ELnifdfm4y0isjwdLNDDJVa84ySAtYzyKu4Bw7FS8WxKWu5ZOoEyj9cdbI3kbk5QRzYJ/jUAaKa0I1xeuspT737PEf7KmVbJQR9MoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452092; c=relaxed/simple;
	bh=HNC2JFG78BM6dYPJfeCu0c/eJ9neL+rvm7FBd1+Y4yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6w2zgWjGrPuiK9+hTLAG15nMIIGQH49hdlG1iZQ54I7LQmSHDMbEUvGvqPSgYHBPDFCzYHwLPlpXleOOSskJGLAg+e3KZFk0xJZ7xnhSZ+EwaYIt+EhYU9WtCcokB1GwEA7A/H4weey7A6X9naTe8sHBWUbJgWqo3dBUlSl5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxBM+HxE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751452086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85JXjacu6wCUmkF0dZfE+duwDw5BYHyt88jf8idGi/0=;
	b=CxBM+HxEKNkrlDHHvC6eXllFZf1Ea0LC7mtfLXOuWMo5kYolOt6Ri1JtRexgNoQeYlPb4J
	y5db4s3V5uMDYpdBABcxSmP0TzDR5vfEcLaqtWqEUGeacWdPszB01znLoZV/cnJwgrSDD2
	KXfHRn9zsiLXFYjXvthOJzd1mi85FGY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-4Y4zXtKZPWSXahQsQhEOHw-1; Wed, 02 Jul 2025 06:28:05 -0400
X-MC-Unique: 4Y4zXtKZPWSXahQsQhEOHw-1
X-Mimecast-MFC-AGG-ID: 4Y4zXtKZPWSXahQsQhEOHw_1751452085
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d413a10b4cso1132534185a.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751452085; x=1752056885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85JXjacu6wCUmkF0dZfE+duwDw5BYHyt88jf8idGi/0=;
        b=jNGaJdI/CUN9qzBhtt5sKP3v63E8JpL8+qHPom1yq+yaabF5McmlC14kA8syvDSMME
         MvevLN+v6ic0+M+mYNQQdjFwy4BDDMcdyLiFqmKqTgJBnzAtWAE+0CSydX3yhhO0iMB7
         Pnc5qYEoPUofT6W4883l7afW63vQFJyZtVUVAtDUaZgU7Mui2RvWgtDZwcpGoi/Kvlmk
         mDEGWL9k9YCI+4gJLKpTB8d0atcYP7HAJJDv8RbB+XW1XB50G6fV7Zd3siW9ynvS0LKB
         Gk9PNyYA6ArFteOQCjqR2yqswEIX7t185nETwOqmyRIDo6rlhJu3WWZ7BU50yl4BhmPW
         cvyA==
X-Forwarded-Encrypted: i=1; AJvYcCUUnzpXRjrWmwztI7rN4CZgSoQVgc6FSh828kdS5fVxVbyem4/nlzxjpss2w5UJN2Wi/F+dm2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4x8i04rJNuf8BQB4KGDzwkEss4ZmFBMMyu6Yes/RpV5ELFo1
	uwxwK1NrdpgyvCxVI1C0t711oIX4Vn7VCJPTtXEI7y/CcSjAK9phoKLXRGdayUA4Afbgxz+7yac
	oYFP7zGCZWnK4OjJdB2kF2XNJaCVmwxZ3FanfQZEuiQwq+6UGinddSaf7tQ==
X-Gm-Gg: ASbGncsgYPwqqwkpd70qHtEZWJnhPNoWfQMl8abERPCQ+eapA9mpcmju3bDIZFPJRo0
	gAHLQXSnBvyThDxh6lbgkoVmgnuFVbSJAv9bUl7fRLv/ng4oR9otgxfDsJoJgwb2qXM8S2Znymb
	NsbIDB7tPlkh9BHEZQKtQ4rxVm/NAMOk+h3ReLf3e/x/3gqv8kBaLCn1WZsj5EfmurV3WcDtmWB
	BpAgTgcHE1UbJNiQERuxLMWgf0XDkNUULkzO/2Rt7GAbt349kyuPiEqSo7X3ic3H5doCNPbwwQ1
	5sOoiWb8mt/quFF7fpwLRvWoDNNb
X-Received: by 2002:a05:620a:40c7:b0:7ce:ed86:3c53 with SMTP id af79cd13be357-7d5c47987e4mr317701985a.29.1751452084838;
        Wed, 02 Jul 2025 03:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR5QITigHAdyrF17S/UdoELcefsX+cFxFfTUVGXCWeNu5QcphpyqGLWYDxcztIwzYT+8d6Rg==
X-Received: by 2002:a05:620a:40c7:b0:7ce:ed86:3c53 with SMTP id af79cd13be357-7d5c47987e4mr317697485a.29.1751452084338;
        Wed, 02 Jul 2025 03:28:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc15932esm89449261cf.34.2025.07.02.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:28:03 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:27:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, decui@microsoft.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RESEND PATCH net-next v4 4/4] test/vsock: Add ioctl SIOCINQ
 tests
Message-ID: <qe45fgoj32f4lyfpqvor2iyse6rdzhhkji7g5snnyqw4wuxa7s@mu4eghcet6sn>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
 <20250630075727.210462-5-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250630075727.210462-5-niuxuewei.nxw@antgroup.com>

On Mon, Jun 30, 2025 at 03:57:27PM +0800, Xuewei Niu wrote:
>Add SIOCINQ ioctl tests for both SOCK_STREAM and SOCK_SEQPACKET.
>
>The client waits for the server to send data, and checks if the SIOCINQ
>ioctl value matches the data size. After consuming the data, the client
>checks if the SIOCINQ value is 0.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
> 1 file changed, 80 insertions(+)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index f669baaa0dca..1f525a7e0098 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -1305,6 +1305,56 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	close(fd);
> }
>
>+static void test_unread_bytes_server(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int client_fd;
>+
>+	client_fd = vsock_accept(VMADDR_CID_ANY, opts->peer_port, NULL, type);
>+	if (client_fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	for (int i = 0; i < sizeof(buf); i++)
>+		buf[i] = rand() & 0xFF;
>+
>+	send_buf(client_fd, buf, sizeof(buf), 0, sizeof(buf));
>+	control_writeln("SENT");
>+
>+	close(client_fd);
>+}
>+
>+static void test_unread_bytes_client(const struct test_opts *opts, int type)
>+{
>+	unsigned char buf[MSG_BUF_IOCTL_LEN];
>+	int fd;
>+	int sock_bytes_unread;
>+
>+	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	control_expectln("SENT");
>+	/* The data has arrived but has not been read. The expected is
>+	 * MSG_BUF_IOCTL_LEN.
>+	 */
>+	if (!vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread,

I know that TIOCINQ is the same of SIOCINQ, but IMO is confusing, why 
not using SIOCINQ ?

The rest LGTM.

Thanks,
Stefano

>+			     MSG_BUF_IOCTL_LEN)) {
>+		fprintf(stderr, "Test skipped, TIOCINQ not supported.\n");
>+		goto out;
>+	}
>+
>+	recv_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
>+	/* All data has been consumed, so the expected is 0. */
>+	vsock_ioctl_int(fd, TIOCINQ, &sock_bytes_unread, 0);
>+
>+out:
>+	close(fd);
>+}
>+
> static void test_stream_unsent_bytes_client(const struct test_opts *opts)
> {
> 	test_unsent_bytes_client(opts, SOCK_STREAM);
>@@ -1325,6 +1375,26 @@ static void test_seqpacket_unsent_bytes_server(const struct test_opts *opts)
> 	test_unsent_bytes_server(opts, SOCK_SEQPACKET);
> }
>
>+static void test_stream_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_STREAM);
>+}
>+
>+static void test_stream_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_STREAM);
>+}
>+
>+static void test_seqpacket_unread_bytes_client(const struct test_opts *opts)
>+{
>+	test_unread_bytes_client(opts, SOCK_SEQPACKET);
>+}
>+
>+static void test_seqpacket_unread_bytes_server(const struct test_opts *opts)
>+{
>+	test_unread_bytes_server(opts, SOCK_SEQPACKET);
>+}
>+
> #define RCVLOWAT_CREDIT_UPD_BUF_SIZE	(1024 * 128)
> /* This define is the same as in 'include/linux/virtio_vsock.h':
>  * it is used to decide when to send credit update message during
>@@ -2051,6 +2121,16 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_nolinger_client,
> 		.run_server = test_stream_nolinger_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM ioctl(SIOCINQ) functionality",
>+		.run_client = test_stream_unread_bytes_client,
>+		.run_server = test_stream_unread_bytes_server,
>+	},
>+	{
>+		.name = "SOCK_SEQPACKET ioctl(SIOCINQ) functionality",
>+		.run_client = test_seqpacket_unread_bytes_client,
>+		.run_server = test_seqpacket_unread_bytes_server,
>+	},
> 	{},
> };
>
>-- 
>2.34.1
>


