Return-Path: <netdev+bounces-192566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B981BAC067C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F181BA0752
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69F261398;
	Thu, 22 May 2025 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aymg8Yts"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8825B66D
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747901114; cv=none; b=QvwKvP44MCVBOgaY+M/CpgCbOmnfN39VWw6XbxLOUCWrKCBjWbbNifDRKSdgq3UpKOZWwMbgq7aeWJbmIuoO152YAM4RKCiwR6jTdP9UDlJHAirWSeRSihbBqPoGnZn1b42amaHYlOJE8MJBO5a9U2oZEpd6IDkTZHxGqk1j/m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747901114; c=relaxed/simple;
	bh=wxs7csRE3XeEa2HaCc9AcyuRKeM0KTS4eqAyS8l8t9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1FfIOohmwO3qs/PIRBu7WpcHurqsLRhTI9EnqgOhBx9xnwjeZxgSzwYkLCywmPh6ZapzeMU4RVO5V+yGV9yuGSJCxSVb55wiB9RDoICqXE36ATiOi+QJI/2Zbl8zrA4a1UWCniOoXEwhF0EeS+iwBUmUTRKvoO4cqU5TUeEwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aymg8Yts; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747901111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A2ioWDY4VnaW+8IoK+nfxRztpprRUfPENEYGqc38imY=;
	b=Aymg8YtssMegXch83jypoxYBWRjC81gA+W+2JrCZoH4KB3hmt4t7T3e3tFrvEFoPRZce5A
	dDGrFkNWdja1qgOE/TSa4iu7nZW+5Pgsb8pMswTLd1fhwWBTpLm91IIeoHZfHyMcd/s2Cp
	CqfX20qu0CtXFArtlviRWToClQCVIMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-7Tcu0qVdObGcBPa4zvTrrQ-1; Thu, 22 May 2025 04:05:09 -0400
X-MC-Unique: 7Tcu0qVdObGcBPa4zvTrrQ-1
X-Mimecast-MFC-AGG-ID: 7Tcu0qVdObGcBPa4zvTrrQ_1747901108
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a36416aef2so2452111f8f.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747901108; x=1748505908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2ioWDY4VnaW+8IoK+nfxRztpprRUfPENEYGqc38imY=;
        b=FQmvceU+irvWPxaub7u9tDM8HqY0m7D+1lUUb+8JhxHlX1obUtryi27lPCvdC7nyeN
         Cc2aX1YoMwaiwE+6CLrQs4zP+X9H9RGx7JQ4NBCu8JDaoCkc1pVlABGJNWKlI51+96KL
         fLN7YIRh0xf2nfHErFb04CEXeALYlS8vSXPLFcvHQjUGuK5RlKAIZ19RhP2spa11aSZH
         abRogRS0OCbWqQynpk6SHRjjZ1fSBMSmnno07qthTtsd0NMQVkjX1w5J2pHymmBWC21C
         GLVMjE9zZ+j4704ZnDdT6ZzI1T9chrVXCcTfBXJdFcZtf8Wf1p0gIyY5Ob7YuikGPJbt
         Cqqg==
X-Forwarded-Encrypted: i=1; AJvYcCXOOnFH2lmHoQzl7AywngeeWP2T5b1bn85tgI1+QMuu8CVGNLSvoTj6q/D6DKriR6WOIfKdCBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRMYzK2IxJki2lyIK2aXMHiFzYZICpRgKu+a+forph443nJE2j
	/rRTIb7geG3o+WV+o2lmYdTtKhvwRfetHnP97Fo3vIN0Tb/eU+YyJFsgifFjgREx/TxpddQ5G2K
	Z1CgOiVUKwiYtWuoT7jQyoo/qshhbROfuwl5Wzhqs9qaCzi/OqT4+CRVy4Q==
X-Gm-Gg: ASbGnctuYTZFE9YPgmL/HArz6MNVi33VJaATa/XA+MFEsHKbcRmprw0FExHxYsc8rDu
	egNGp7BAuaDbaRgkBu1jhk39E17pm6UNP/kf49AQm2j4unryy9rSNRz6bs7Ek4ek/viNM0XXzKX
	/idT5eWX+hboestknODtMsPe984I+eLvQoGFigA2u1zIYMO3ySlp8JtR8+uOo+A5eMdOtWwa3Ka
	edRizstTixZfVwspfR09afbOI15Jv9Zy/FogvUR++ipkR2RRByPmK+wP/5Kh7OJp8G0SGrA7s71
	+y5BGbjcF5fw1HXhc2ut83NBm2VezzoAFTFW9GWz/WM97Zwgz3FtmrKddQgt
X-Received: by 2002:a5d:5888:0:b0:3a4:7373:7179 with SMTP id ffacd0b85a97d-3a47373741fmr5304194f8f.21.1747901108283;
        Thu, 22 May 2025 01:05:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET+BoZdLjjXwzK++Hg7tw0FGXknQcCMl4uWniUd2z+PpZjOknS9vNZNNh286EYaTyLr1a3Ag==
X-Received: by 2002:a5d:5888:0:b0:3a4:7373:7179 with SMTP id ffacd0b85a97d-3a47373741fmr5304163f8f.21.1747901107793;
        Thu, 22 May 2025 01:05:07 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62204sm21800704f8f.42.2025.05.22.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:05:07 -0700 (PDT)
Date: Thu, 22 May 2025 10:05:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/5] vsock/test: Introduce vsock_wait_sent()
 helper
Message-ID: <foo7xlczou4dl45qblliqfru4yaglxsudqbaejpnc27ocqmc5x@fdevtzvtdfwb>
References: <20250522-vsock-linger-v6-0-2ad00b0e447e@rbox.co>
 <20250522-vsock-linger-v6-3-2ad00b0e447e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522-vsock-linger-v6-3-2ad00b0e447e@rbox.co>

On Thu, May 22, 2025 at 01:18:23AM +0200, Michal Luczaj wrote:
>Distill the virtio_vsock_sock::bytes_unsent checking loop (ioctl SIOCOUTQ)
>and move it to utils. Tweak the comment.
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c       | 25 +++++++++++++++++++++++++
> tools/testing/vsock/util.h       |  1 +
> tools/testing/vsock/vsock_test.c | 23 ++++++-----------------
> 3 files changed, 32 insertions(+), 17 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index de25892f865f07672da0886be8bd1a429ade8b05..4427d459e199f643d415dfc13e071f21a2e4d6ba 100644
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
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
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
>+	return !ret;
>+}
>+
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
> int vsock_bind(unsigned int cid, unsigned int port, int type)
> {
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index d1f765ce3eeeed8f738630846bb47c4f3f6f946f..91f9df12f26a0858777e1a65456f8058544a5f18 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
> void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 9ea33b78b9fcb532f4f9616b38b4d2b627b04d31..9d3a77be26f4eb5854629bb1fce08c4ef5485c84 100644
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
>+	if (!vsock_wait_sent(fd))
>+		fprintf(stderr, "Test skipped, SIOCOUTQ not supported.\n");
>+
> 	close(fd);
> }
>
>
>-- 
>2.49.0
>


