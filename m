Return-Path: <netdev+bounces-198097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E1ADB3CB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4C41884285
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEBE1EA7E1;
	Mon, 16 Jun 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DANrcQj7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AF1E32CF
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750083830; cv=none; b=ZzVVWPzqDiPJvlLKci02uMRlMZGs/qR9AnPdGfxjtTtah/XKVCvCSOq48xwTb1roTKhP908oafFMbqfLC7WG5j3Tx8lI0ulfDj0h5JHP1oP6urC9tSNZLVXVLoquDfeac6vtXsPPmJ983M7wAyLbkC1KB0xPNfEux7lpkS2XCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750083830; c=relaxed/simple;
	bh=v8tipBw1Rg8uUUI8WgiokNzRTX+JlMQF/S8IRZIRHs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGerkrtqIlBXTN3sIqug0OOYdgAXiDqTwj3WCXd77Hlv3jRadCI1N1cvubd3FU9uhizBtXsmefdFA1zUQl72o+hdpPadI2TIByGBx5CvH58nd88q2+nYFbyeJfAqgvRa64FYQsd4l76ZBn3oylbFMUYdf3kLy1mviltSo7hzSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DANrcQj7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750083827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+2gsbjGMfxgj+GtSEJhJLLfivzU+vrOQd2XrrPgUqI=;
	b=DANrcQj7cPIkIJw0VOCj2o5UbdZ16JaSYlWqw3ejrcbIbeTCx8+ulthYjwglZrqOmswORW
	g711h5gGUQYJP9YeFpP2w0Xw6gZUdaZmSno3cTCmXuXuL1Y6gGEXWiCMFTmhUyvULBDzPG
	Q4Hnt1T7Km+/HecIDVCTCZHoiasgO0c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-rEXKxMEGNgyHKboidp1b1A-1; Mon, 16 Jun 2025 10:23:45 -0400
X-MC-Unique: rEXKxMEGNgyHKboidp1b1A-1
X-Mimecast-MFC-AGG-ID: rEXKxMEGNgyHKboidp1b1A_1750083824
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso24138795e9.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750083824; x=1750688624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+2gsbjGMfxgj+GtSEJhJLLfivzU+vrOQd2XrrPgUqI=;
        b=t8iY7qW/UOZQ8EM6h9v8h0rVHuGXi1r4Pcf8IM9/cLGNV1u2sVDPfQ2RgoeGqWDFvG
         GI1JYvm6z2+WMbrxMn8pTmDVrOVk8bCwx1dROOyJuc5rU8T61WJcnt0Eagqu9+kSfl8S
         0TphUG4GJFCZZyaB3uIam9H1Arf3vFAiTkCsfVd8iyMK2r2txF9M0bpsJnBXRpOPUdvg
         wJkz0LjoALdmlR+l9lwxNBayFhkGR8//gbjB9NEE3RTj8VaMHG3CBdydm7W5hj25Ae0t
         TrRmeIYfbjaa3/ZzZhGRdhdzMfVxLq/c6kbTe2WtbJsrjzRNlaLGLaheRxPAzs+YQiMk
         izjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC9Z1SDrA7w2jVUkLlSAZQ6IDy+q6m4T95n1XRqdaZan5QiyNfUk0olJaX0VIG7IeONnKQmm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGEkJ7ujrxpsubawg6Ujy+bFghuTviiABT/Zig37P55leRQkn
	gstbeRTmKBANrGipQkI7u7tQIBm9THdAXfXZ4vpH5EmoM/mxL5Ztp+ZkKN3/1RrdRbzq9vqIq3S
	Cu/aK9/DPqP/2JSib1shfwlM5hgy3TYRNVoYk2pmtqwezPqi61e+xPFrt1g==
X-Gm-Gg: ASbGnct+pAuyK3k56LobGZvwZOGnELwtxOkPFcEkiJUtLH5a6GGQff3h5B15D4Gbzcb
	FsujwkLQe2DwEH7ZN1ob8Boa5gfR4glEM+MU7U3iNXj69TgnJ4ThkilY2CU+LnaaeEEv1BsQWCo
	A/Fk57pCxop3kJpXLyXONgAHMv6Rw1Cumem76P9/a1AvHi+76ZNecvOYW1emap9cqjL4vg+unPy
	ox6sICOp74cSTqAz+hMKYqVaJi9mG6r++PrtM5LoEKKw/HbGS7m0SM30EboMU6mg3xASgPibyRE
	d9CEv9FdtcEh3Rd+b9fPYIplW84=
X-Received: by 2002:a05:600c:8b21:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-4533ca4291fmr82823355e9.5.1750083824364;
        Mon, 16 Jun 2025 07:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1RMolTO9eDEe9qR38ZhX3HK9hH9v80M70WdDnGgFJKvA6JD25WeKSon+jf5NTkGxpDWO43A==
X-Received: by 2002:a05:600c:8b21:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-4533ca4291fmr82823115e9.5.1750083823852;
        Mon, 16 Jun 2025 07:23:43 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25f207sm145671275e9.35.2025.06.16.07.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:23:43 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:23:40 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH net-next v3] vsock/test: Add test for null ptr deref when
 transport changes
Message-ID: <pjwrj4pnl3jheypjbkcopjv7uilcdiog3pxb3m57zyeq47sc22@7sl6otxuims2>
References: <20250611-test_vsock-v3-1-8414a2d4df62@redhat.com>
 <zpc6pbabs5m5snrsfubtl3wp4eb64w4qwqosywp7tsmrfnba3j@ybkgg2cnhqec>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <zpc6pbabs5m5snrsfubtl3wp4eb64w4qwqosywp7tsmrfnba3j@ybkgg2cnhqec>

Hi Stefano,

On Wed, Jun 11, 2025 at 04:53:11PM +0200, Stefano Garzarella wrote:
>On Wed, Jun 11, 2025 at 04:07:25PM +0200, Luigi Leonardi wrote:
>>Add a new test to ensure that when the transport changes a null pointer
>>dereference does not occur. The bug was reported upstream [1] and fixed
>>with commit 2cb7c756f605 ("vsock/virtio: discard packets if the
>>transport changes").
>>
>>KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>>CPU: 2 UID: 0 PID: 463 Comm: kworker/2:3 Not tainted
>>Workqueue: vsock-loopback vsock_loopback_work
>>RIP: 0010:vsock_stream_has_data+0x44/0x70
>>Call Trace:
>>virtio_transport_do_close+0x68/0x1a0
>>virtio_transport_recv_pkt+0x1045/0x2ae4
>>vsock_loopback_work+0x27d/0x3f0
>>process_one_work+0x846/0x1420
>>worker_thread+0x5b3/0xf80
>>kthread+0x35a/0x700
>>ret_from_fork+0x2d/0x70
>>ret_from_fork_asm+0x1a/0x30
>>
>>Note that this test may not fail in a kernel without the fix, but it may
>>hang on the client side if it triggers a kernel oops.
>>
>>This works by creating a socket, trying to connect to a server, and then
>>executing a second connect operation on the same socket but to a
>>different CID (0). This triggers a transport change. If the connect
>>operation is interrupted by a signal, this could cause a null-ptr-deref.
>>
>>Since this bug is non-deterministic, we need to try several times. It
>>is reasonable to assume that the bug will show up within the timeout
>>period.
>>
>>If there is a G2H transport loaded in the system, the bug is not
>>triggered and this test will always pass.
>
>Should we re-use what Michal is doing in https://lore.kernel.org/virtualization/20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co/
>to print a warning?

Yes, good idea! IMHO we can skip the test if a G2H transport is loaded.  
I'll wait for Michal's patch to be merged before sending v4.
>
>>
>>[1]https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/
>>
>>Suggested-by: Hyunwoo Kim <v4bel@theori.io>
>>
>>#include "vsock_test_zerocopy.h"
>>#include "timeout.h"
>>@@ -1811,6 +1813,168 @@ static void test_stream_connect_retry_server(const struct test_opts *opts)
>>	close(fd);
>>+		/* Set CID to 0 cause a transport change. */
>>+		sa.svm_cid = 0;
>>+		/* This connect must fail. No-one listening on CID 0
>>+		 * This connect can also be interrupted, ignore this error.
>>+		 */
>>+		ret = connect(s, (struct sockaddr *)&sa, sizeof(sa));
>>+		if (ret != -1 && errno != EINTR) {
>
>Should this condition be `ret != -1 || errno != EINTR` ?
>
Right, good catch.
>
>>+			fprintf(stderr,
>>+				"connect: expected a failure because of unused CID: %d\n", errno);
>>+			exit(EXIT_FAILURE);
>>+		}
>>+
>>+		close(s);
>>+
>>+		control_writeulong(CONTROL_CONTINUE);
>>+
>>+	} while (current_nsec() < tout);
>>+
>>+	control_writeulong(CONTROL_DONE);
>>+
>>+	ret = pthread_cancel(thread_id);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_cancel: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	/* Wait for the thread to terminate */
>>+	ret = pthread_join(thread_id, NULL);
>>+	if (ret) {
>>+		fprintf(stderr, "pthread_join: %d\n", ret);
>>+		exit(EXIT_FAILURE);
>>+	}
>>+
>>+	/* Restore the old handler */
>>+	if (signal(SIGUSR1, old_handler) == SIG_ERR) {
>>+		perror("signal");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+}
>>+
>>+static void test_stream_transport_change_server(const struct test_opts *opts)
>>+{
>>+	int ret, s;
>>+
>>+	s = vsock_stream_listen(VMADDR_CID_ANY, opts->peer_port);
>>+
>>+	/* Set the socket to be nonblocking because connects that have been interrupted
>>+	 * (EINTR) can fill the receiver's accept queue anyway, leading to connect failure.
>>+	 * As of today (6.15) in such situation there is no way to understand, from the
>>+	 * client side, if the connection has been queued in the server or not.
>>+	 */
>>+	ret = fcntl(s, F_SETFL, fcntl(s, F_GETFL, 0) | O_NONBLOCK);
>>+	if (ret < 0) {
>
>nit: If you need to resend, I'd remove `ret` and check fcntl directly:
>	if (fcntl(...) < 0) {
Ok!
>
>>+		perror("fcntl");
>>+		exit(EXIT_FAILURE);
>>+	}
>>+	control_writeln("LISTENING");
>>+
>>+	while (control_readulong() == CONTROL_CONTINUE) {
>>+		struct sockaddr_vm sa_client;
>>+		socklen_t socklen_client = sizeof(sa_client);
>>+
>>+		/* Must accept the connection, otherwise the `listen`
>>+		 * queue will fill up and new connections will fail.
>>+		 * There can be more than one queued connection,
>>+		 * clear them all.
>>+		 */
>>+		while (true) {
>>+			int client = accept(s, (struct sockaddr *)&sa_client, &socklen_client);
>>+
>>+			if (client < 0 && errno != EAGAIN) {
>>+				perror("accept");
>>+				exit(EXIT_FAILURE);
>>+			} else if (client > 0) {
>
>0 in theory is a valid fd, so here we should check `client >= 0`.
Right!
>
>>+				close(client);
>>+			}
>>+
>>+			if (errno == EAGAIN)
>>+				break;
>
>I think you can refactor in this way:
>			if (client < 0) {
>				if (errno == EAGAIN)
>					break;
>
>				perror("accept");
>				exit(EXIT_FAILURE);
>			}
>
>			close(client);
>
Will do.
>Thanks,
>Stefano
>

Thanks for the review.
Luigi


