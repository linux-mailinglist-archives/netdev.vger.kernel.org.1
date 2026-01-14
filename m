Return-Path: <netdev+bounces-249787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D2D1DEDF
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C2A0304ED9D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194E3393404;
	Wed, 14 Jan 2026 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h15BPRSu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBiEnuB6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429BD38B7C0
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385293; cv=none; b=JnUhj6i3SBFVCnbt6pFLwCjxicar7Nf7sSXqMufrpG/aH51dOhhBKMqhkfqexMVZzw9M/pS7VsjDJh9OBn28QvFdn/X1tudpJcAn2oYwCNrk0JjcpArYHPvV9B+2SAcDZEGFfuasQ1QybTg5+exhRtwy7VQ+CiGX9m2ED/952tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385293; c=relaxed/simple;
	bh=R34QuFzq0RM2B+MUSlKhuKjAZtk77eiyestyrQbTikI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu0HtuuvihBqH7UaflRC3ASVr2QzzJVdgc5Ui2xPTpOCWMVFio3cy3GZafRlCnGJsuVyX8VUDy4WQz4DWgJGV5TJ7Ot29QlnjUPNoXZ4dRHqhYBJuN5oo11aE+wiM5Ymd0t8uX4pC1XrJ5UihPFYb7kEJyIZ1X5vw3b7xYUfhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h15BPRSu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBiEnuB6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768385290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gLVLJe5ZoPPurYSTDDy8POZ2YmIqBUOxjilC1ypOvdA=;
	b=h15BPRSubujaR26aC/lP+rzsIrhqQJYCXKboOoo+Rfb7x7l9XqDwgmZVtxi270nUGQewRu
	qe1hY41liDpyXXNJT5DLg9S0GdTABttqZbFZPTBeG75vJMf3DIm6y9He4pRqzwYNY/NZsG
	N0rnnGLbhFGfTjdxzLU/z7WMbcj3d6k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-7RL_xKtlM22tha1_F_6Kmg-1; Wed, 14 Jan 2026 05:08:08 -0500
X-MC-Unique: 7RL_xKtlM22tha1_F_6Kmg-1
X-Mimecast-MFC-AGG-ID: 7RL_xKtlM22tha1_F_6Kmg_1768385287
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b844098869cso922474266b.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768385287; x=1768990087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLVLJe5ZoPPurYSTDDy8POZ2YmIqBUOxjilC1ypOvdA=;
        b=eBiEnuB66OPvOPhZxPaxxp7aC3QXE2up/Hs0Vq+K/u3RS8FSMGFlN1u4vZEiqlogQW
         7TD+m+n84xHWqz946E3EIoatAHxZwf9RnGeAAKrApHly084t55zr+nTtvUxoOTvLLs0z
         hTTfY9m9iqXMYgUTnvgxJbncpn9jju3OKaNL840XolDO4/EMzJt0bH5QMTdvsR5p+A2y
         IwqYsCQ4AJqPY1hDo3EvLqngqHHXYHc//VFe+yYASrIfq8wgALyQlvSstzVhVecFA3mh
         afEkR6tU0Pgusn3VWY1Hl4lorXqAEwbozwSawL55AaLNj8iWZ8HK1IIBqT4EyVIvZ/VB
         OD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385287; x=1768990087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLVLJe5ZoPPurYSTDDy8POZ2YmIqBUOxjilC1ypOvdA=;
        b=MoMm4IiUf2MDIQLN1obx9wkR511TNb5rO6yTptSAy3w8Kan9XOlwnWKm7evib5cTBz
         k0vSRFEwOZG1OF89WtZQuBl83HF9qqyCwshLif3m5fP1P/UKbDVAznfJZlCJqhR2NFxY
         vtFBaiXvHqAD/+oe+grJSE5gBCCDdUIPHgRQccWH8cKTNVKb7wpcntRcTp5hxGiHDZuk
         vvWNXo8IoPLa6zSUq7Mp7ft2VEY/3Je14UWhvhVi/lRVkUupnN2/s/GGMokvEsOpm1yi
         TMdES4VyrB2kadg+z8IzsgkRE9jsUDUyhkmDYuLC1X/eH6qvwgVkcLveMc+nuXL6UHj5
         tVxA==
X-Forwarded-Encrypted: i=1; AJvYcCWKmwMQNHUfDltYUWIULqgztuaQ5sUYfjn8MQ6S6zTIEww57NB5clN7fU0ny1C6A0jgr/NEGus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4rr4qEknljOOoTDflIM/+CkRwKXFuMDrInQBK1DE4fOsspaC
	Jfl/AOe2XjnxkiPg4dMNk7sNVGuZt+JdTexshxuA89QAlB5fq45g/J3g1Cw00lz3VspZziZS+LF
	MDdpi2/89PcU1xfY+HqlMdjfOLtp6NWME+QDWnU0JA5PFaB23mzuYGg4Kcw==
X-Gm-Gg: AY/fxX6nJMSHPcPr8LXAAjCRxVGjyENaRfK4O3Ji4uXek846aTer0B6VSW0MSrJle0u
	fRJEp6hN08+Y6cIosIRyzuv7/B2eKe29NH4rwORsJNWQGCMIWrL3uXe4qU+dOqXR1trY0GjCa7z
	3MZSvSH7qhqdyB40/vwzLPORAkoVy87QZS6x888lFmrCAfSiAnR/GAVWjE/H7Ltv9YcGyOjThMC
	NwNeKkNACYDABBMtP6GE7kxz3otJlyz4q60y5G7yzsmdY/4ojSStJi07vMrzMJkEAQt9A3eAjXi
	Ap/Ytsj+XEKP156wogmoLRxFSn46Bluwu2pZ7gDbX75g8o/FpZuva4ZDa4OFV/2QZIQDmAObXjc
	tu3Y1wELg1siOxqoeXyuCbMSFAXWAVcle9ehVFnyNootr6dmP7qSCCdEZpHs4LA==
X-Received: by 2002:a17:906:ef0a:b0:b87:b22:f5eb with SMTP id a640c23a62f3a-b87612a48d8mr180864066b.31.1768385286959;
        Wed, 14 Jan 2026 02:08:06 -0800 (PST)
X-Received: by 2002:a17:906:ef0a:b0:b87:b22:f5eb with SMTP id a640c23a62f3a-b87612a48d8mr180858766b.31.1768385286318;
        Wed, 14 Jan 2026 02:08:06 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b871081b04bsm952619866b.53.2026.01.14.02.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:08:05 -0800 (PST)
Date: Wed, 14 Jan 2026 11:07:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] vsock/test: Add test for a linear and
 non-linear skb getting coalesced
Message-ID: <aWdq75AQZv50CMPQ@sgarzare-redhat>
References: <20260113-vsock-recv-coalescence-v2-0-552b17837cf4@rbox.co>
 <20260113-vsock-recv-coalescence-v2-2-552b17837cf4@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260113-vsock-recv-coalescence-v2-2-552b17837cf4@rbox.co>

On Tue, Jan 13, 2026 at 04:08:19PM +0100, Michal Luczaj wrote:
>Loopback transport can mangle data in rx queue when a linear skb is
>followed by a small MSG_ZEROCOPY packet.
>
>To exercise the logic, send out two packets: a weirdly sized one (to ensure
>some spare tail room in the skb) and a zerocopy one that's small enough to
>fit in the spare room of its predecessor. Then, wait for both to land in
>the rx queue, and check the data received. Faulty packets merger manifests
>itself by corrupting payload of the later packet.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/vsock_test.c          |  5 +++
> tools/testing/vsock/vsock_test_zerocopy.c | 74 +++++++++++++++++++++++++++++++
> tools/testing/vsock/vsock_test_zerocopy.h |  3 ++
> 3 files changed, 82 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index bbe3723babdc..27e39354499a 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
> 		.run_client = test_stream_accepted_setsockopt_client,
> 		.run_server = test_stream_accepted_setsockopt_server,
> 	},
>+	{
>+		.name = "SOCK_STREAM virtio MSG_ZEROCOPY coalescence corruption",
>+		.run_client = test_stream_msgzcopy_mangle_client,
>+		.run_server = test_stream_msgzcopy_mangle_server,
>+	},
> 	{},
> };
>
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.c b/tools/testing/vsock/vsock_test_zerocopy.c
>index 9d9a6cb9614a..a31ddfc1cd0c 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.c
>+++ b/tools/testing/vsock/vsock_test_zerocopy.c
>@@ -9,14 +9,18 @@
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <unistd.h>
> #include <poll.h>
> #include <linux/errqueue.h>
> #include <linux/kernel.h>
>+#include <linux/sockios.h>
>+#include <linux/time64.h>
> #include <errno.h>
>
> #include "control.h"
>+#include "timeout.h"
> #include "vsock_test_zerocopy.h"
> #include "msg_zerocopy_common.h"
>
>@@ -356,3 +360,73 @@ void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts)
> 	control_expectln("DONE");
> 	close(fd);
> }
>+
>+#define GOOD_COPY_LEN	128	/* net/vmw_vsock/virtio_transport_common.c */
>+
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts)
>+{
>+	char sbuf1[PAGE_SIZE + 1], sbuf2[GOOD_COPY_LEN];
>+	unsigned long hash;
>+	struct pollfd fds;
>+	int fd, i;
>+
>+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>+	if (fd < 0) {
>+		perror("connect");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	enable_so_zerocopy_check(fd);
>+
>+	memset(sbuf1, 'x', sizeof(sbuf1));
>+	send_buf(fd, sbuf1, sizeof(sbuf1), 0, sizeof(sbuf1));
>+
>+	for (i = 0; i < sizeof(sbuf2); i++)
>+		sbuf2[i] = rand() & 0xff;
>+
>+	send_buf(fd, sbuf2, sizeof(sbuf2), MSG_ZEROCOPY, sizeof(sbuf2));
>+
>+	hash = hash_djb2(sbuf2, sizeof(sbuf2));
>+	control_writeulong(hash);
>+
>+	fds.fd = fd;
>+	fds.events = 0;
>+
>+	if (poll(&fds, 1, TIMEOUT * MSEC_PER_SEC) != 1 ||
>+	    !(fds.revents & POLLERR)) {
>+		perror("poll");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>+
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts)
>+{
>+	unsigned long local_hash, remote_hash;
>+	char rbuf[PAGE_SIZE + 1];
>+	int fd;
>+
>+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>+	if (fd < 0) {
>+		perror("accept");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	/* Wait, don't race the (buggy) skbs coalescence. */
>+	vsock_ioctl_int(fd, SIOCINQ, PAGE_SIZE + 1 + GOOD_COPY_LEN);
>+
>+	/* Discard the first packet. */
>+	recv_buf(fd, rbuf, PAGE_SIZE + 1, 0, PAGE_SIZE + 1);
>+
>+	recv_buf(fd, rbuf, GOOD_COPY_LEN, 0, GOOD_COPY_LEN);
>+	remote_hash = control_readulong();
>+	local_hash = hash_djb2(rbuf, GOOD_COPY_LEN);
>+
>+	if (local_hash != remote_hash) {
>+		fprintf(stderr, "Data received corrupted\n");
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	close(fd);
>+}
>diff --git a/tools/testing/vsock/vsock_test_zerocopy.h b/tools/testing/vsock/vsock_test_zerocopy.h
>index 3ef2579e024d..d46c91a69f16 100644
>--- a/tools/testing/vsock/vsock_test_zerocopy.h
>+++ b/tools/testing/vsock/vsock_test_zerocopy.h
>@@ -12,4 +12,7 @@ void test_seqpacket_msgzcopy_server(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_client(const struct test_opts *opts);
> void test_stream_msgzcopy_empty_errq_server(const struct test_opts *opts);
>
>+void test_stream_msgzcopy_mangle_client(const struct test_opts *opts);
>+void test_stream_msgzcopy_mangle_server(const struct test_opts *opts);
>+
> #endif /* VSOCK_TEST_ZEROCOPY_H */
>
>-- 
>2.52.0
>


