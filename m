Return-Path: <netdev+bounces-192351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4947ABF8BD
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 17:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E38D1649EC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087F1DE8A8;
	Wed, 21 May 2025 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zpjj1SrQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36601C860F
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839704; cv=none; b=erVnK+K6/hwgv5QbJOZdjQVeVqWkcaSNUKclHerPVPpG83E8ZXt7nWCd+P6wdUoeepkG1vTsrcp+9xsSV3pvCwJW7Gxcw9H6zt7U3bDZVDz36MlhxAJHFFY1WiRRGvS3PgoVNUy8QU+nvFAP5FwUo0JeXaabnfVMwxesGV+Z0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839704; c=relaxed/simple;
	bh=xehhInAtDXNQ/n5gfDz6llbpaPNmLMER2GgFqEhTcvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtK8z7KKQWBQLDKxI1SOO1FYCnctyakqDUNQeCnDhF2jMPBwUbneQP8UguEmRJpCS3VyLwmS0vTIrd58hi0iKPPstwUpqNPHqtrTbUBRlNBeNR5ApyFESCiAU9n46IST5L0T9d7PFhPCB9r74LJIKXVINW9ZOu1PKEC2RZkrFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zpjj1SrQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747839700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IQaN0Uw5ksNxoFenF66ughGD5YHdupsTVLr1isPbs2c=;
	b=Zpjj1SrQACGGMiHaMssRHeQpM24ghzF/GAoY4lxSTeki8HUkqIgwN+DjaBHqS5HqORmsgs
	NioqU5dnN6zQNJ9wIBvOZepjmZVumrnJEWDQe5zQKx8UV9vsBJ3bsbka8UwT2OQvyUIoAb
	TnyVUnzcwHDam1xBvtFVsn4OOMK2Cl8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-by4ssfZtOv-zpYgQK4pE3A-1; Wed, 21 May 2025 11:01:39 -0400
X-MC-Unique: by4ssfZtOv-zpYgQK4pE3A-1
X-Mimecast-MFC-AGG-ID: by4ssfZtOv-zpYgQK4pE3A_1747839697
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad55e6f09efso368368966b.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 08:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839697; x=1748444497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQaN0Uw5ksNxoFenF66ughGD5YHdupsTVLr1isPbs2c=;
        b=EmT2PdrmlrdJ5YhTv5ToYPJv9S3imn30phqi7ph1CLw5EdCIEX7oha6+miM3buhwbX
         wKGdJoXah8lekTqi60Bucw+B0+eyB8ItJx3unaPS650WOkP7qxv/Gp1bkJHFtzKOnHdP
         Qm6Qk038YKhT84iQeHVph/CNHWC6+JZQOtV5tjQsSTZl8Yydlnq4xU5PY4WEKY3vSF/+
         zFxQobm0r/qN8JzX/PPsxJteqQSyC8QbVjYT672zmEOdlwMfRKNOy7jIx9zAybXDkfC6
         Oo+aqgzLnI0AKiVwMu2z+zTZJ3EvyCe/LhVkh4YFlwyL2aG7kaQEMSMRWfAtc8JLd/qz
         ELQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeESV8cjcaJaBALhqc4edY9NDc0/9cqAhYhY0EKJBP4eridtxQDAUKcUJEyCbv1ZZJeicVvR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVL+Mt1Pzbqvk83f65VP9OEu9WN7fZA3bDVrUKpNQZ4Du8ZPZd
	LAFS0p00rKXhQCA7cyg3hZX5wPDMmCUP1pOCgSXM1bd2G6pnFwlmZT30nniOYoBwjKNC1BR+hTN
	sgVoYR4EvLmoyCjtLB4DdY2XP+4AThJcxNnPhChYgt6Tm6mlN/O2fjLlj/Q==
X-Gm-Gg: ASbGncvEjTUlr3StIHnMep6+PbOhR2quqn93Tqugz4FM4jlpxc/LKmswuJcQ8Kod9vu
	GZFanIHT0Hn7uHLNADN5a6bWt2DhHxajHX2wOEW45bsHjnpiDdufmiSESK8ayiYDiRLTHwSM9wR
	tRPQqFWUyWicAWxP43huXl5uJb/N0o+aR6l+UzpQodqS/5Ic+Ae5LEeDgYvxuPi7mAxXUtuyQKk
	hNFHMXHJNf7/HxkqqucTEjZBUFbp4FH/AE37TjTxqqUJFPpepr0D/4L+f6Kl594ZpgPAw1W79C1
	6B/JOIc4RfCfAA8PW3aQeDY0impjqM55EhOu0fM8PybAPKOvS/ELlo9DncWq
X-Received: by 2002:a17:907:7da2:b0:ad4:d9c9:c758 with SMTP id a640c23a62f3a-ad536b7c8dfmr1808154066b.11.1747839694892;
        Wed, 21 May 2025 08:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlYrXcyUQ/GFhKIGPeqwLg3L9B+4cCMXz+eKCUeTZ4xCrnP7r7wqBOBXYGqGyAGakMiIi6NQ==
X-Received: by 2002:a17:907:7da2:b0:ad4:d9c9:c758 with SMTP id a640c23a62f3a-ad536b7c8dfmr1808102866b.11.1747839690863;
        Wed, 21 May 2025 08:01:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4ca5c5sm909001966b.162.2025.05.21.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:01:30 -0700 (PDT)
Date: Wed, 21 May 2025 17:01:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] vsock/test: Introduce vsock_wait_sent()
 helper
Message-ID: <kva35i6sjyxuugywlanlnkbdunbyauadgnciteakxu2jsb2kl7@24fgdq2glxk6>
References: <20250521-vsock-linger-v5-0-94827860d1d6@rbox.co>
 <20250521-vsock-linger-v5-3-94827860d1d6@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250521-vsock-linger-v5-3-94827860d1d6@rbox.co>

On Wed, May 21, 2025 at 12:55:21AM +0200, Michal Luczaj wrote:
>Distill the virtio_vsock_sock::bytes_unsent checking loop (ioctl SIOCOUTQ)
>and move it to utils. Tweak the comment.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 25 +++++++++++++++++++++++++
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 23 ++++++-----------------
> 3 files changed, 32 insertions(+), 17 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index de25892f865f07672da0886be8bd1a429ade8b05..120277be14ab2f58e0350adcdd56fc18861399c9 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -17,6 +17,7 @@
> #include <assert.h>
> #include <sys/epoll.h>
> #include <sys/mman.h>
>+#include <linux/sockios.h>
>
> #include "timeout.h"
> #include "control.h"
>@@ -96,6 +97,30 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>+/* Wait until transport reports no data left to be sent.
>+ * Return non-zero if transport does not implement the unsent_bytes() callback.
>+ */
>+int vsock_wait_sent(int fd)

nit: I just see we use `bool` in the test to store the result of this 
function, so maybe we can return `bool` directl from here...

(not a strong opinion, it's fine also this).

Thanks,
Stefano

>+{
>+	int ret, sock_bytes_unsent;
>+
>+	timeout_begin(TIMEOUT);
>+	do {
>+		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		if (ret < 0) {
>+			if (errno == EOPNOTSUPP)
>+				break;
>+
>+			perror("ioctl(SIOCOUTQ)");
>+			exit(EXIT_FAILURE);
>+		}
>+		timeout_check("SIOCOUTQ");
>+	} while (sock_bytes_unsent != 0);
>+	timeout_end();
>+
>+	return ret;
>+}
>+
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> int vsock_bind(unsigned int cid, unsigned int port, int type)
> {
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index d1f765ce3eeeed8f738630846bb47c4f3f6f946f..e307f0d4f6940e984b84a95fd0d57598e7c4e35f 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+int vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
> void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9ea33b78b9fcb532f4f9616b38b4d2b627b04d31..4c2c94151070d54d1ed6e6af5a6de0b262a0206e 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -21,7 +21,6 @@
> #include <poll.h>
> #include <signal.h>
> #include <sys/ioctl.h>
>-#include <linux/sockios.h>
> #include <linux/time64.h>
>
> #include "vsock_test_zerocopy.h"
>@@ -1280,7 +1279,7 @@ static void test_unsent_bytes_server(const struct test_opts *opts, int type)
> static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> {
> 	unsigned char buf[MSG_BUF_IOCTL_LEN];
>-	int ret, fd, sock_bytes_unsent;
>+	int fd;
>
> 	fd = vsock_connect(opts->peer_cid, opts->peer_port, type);
> 	if (fd < 0) {
>@@ -1297,22 +1296,12 @@ static void test_unsent_bytes_client(const struct test_opts *opts, int type)
> 	/* SIOCOUTQ isn't guaranteed to instantly track sent data. Even though
> 	 * the "RECEIVED" message means that the other side has received the
> 	 * data, there can be a delay in our kernel before updating the "unsent
>-	 * bytes" counter. Repeat SIOCOUTQ until it returns 0.
>+	 * bytes" counter. vsock_wait_sent() will repeat SIOCOUTQ until it
>+	 * returns 0.
> 	 */
>-	timeout_begin(TIMEOUT);
>-	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>-		if (ret < 0) {
>-			if (errno == EOPNOTSUPP) {
>-				fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>-				break;
>-			}
>-			perror("ioctl");
>-			exit(EXIT_FAILURE);
>-		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>-	timeout_end();
>+	if (vsock_wait_sent(fd))
>+		fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+
> 	close(fd);
> }
>
>
>-- 
>2.49.0
>


