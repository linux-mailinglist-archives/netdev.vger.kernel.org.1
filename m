Return-Path: <netdev+bounces-203277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841FCAF11A3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E3F3BB56A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B30A253B7B;
	Wed,  2 Jul 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWFkujCN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38EE22D4F9
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451666; cv=none; b=IyJjDzFuOpph1455lPlk8Di78XgpK7rnHqUPMi2TRK4jDhikMJDhFwvtb444q+LWznGePtnZgOlVvXfFQXf2s3GgtcvuWvbQC8yP7BS/ZJPE6aTs1y5eGPD4aKdkIehStxCOygRt5S/0YdFweYd9KCCozNOp222mTTY1Xfsi8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451666; c=relaxed/simple;
	bh=QTZub8qteyJ2SpbKYksOY3pPnrsQfuP9btWZHNiTahM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRiLOBhLpc2i9tpbnn3IVU66vDA3+Qnqqf3aSeWiGJEZR+UFumhrtQcCp50aH4c0QdrmRU/M42s13ESEZNusJSidZEV7PNhsHEKJzYF+D4pb9pSYbtJd4SvY3KDxALdB3gnwJ70FaSE6C7kqdGBJrf//M/Q7vngJevDfJSoY+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWFkujCN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751451662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z33Cff3RmOVjIT9wRyC2s6MYaglNGGjjzC0Meo8MshM=;
	b=MWFkujCN3ZmGmyUSFFCnPPdHCNc5aLJ7ai0J+mXRzVgRs3MXjghw1QboKeC3OYQ2AgK5qh
	zz1dH4S74aPt94MES8gs6vOVi9J9vBZw1qEXHFe9OaaE3FowMIL6ulzzF0JeXCo2B5Vw2U
	Z2F/y5GtsFO6obWQPGbkA9Dq0lwD504=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-bmEZtr6FN6mVzdEkwszVMw-1; Wed, 02 Jul 2025 06:21:01 -0400
X-MC-Unique: bmEZtr6FN6mVzdEkwszVMw-1
X-Mimecast-MFC-AGG-ID: bmEZtr6FN6mVzdEkwszVMw_1751451661
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2e92a214e2eso2650944fac.1
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 03:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451661; x=1752056461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z33Cff3RmOVjIT9wRyC2s6MYaglNGGjjzC0Meo8MshM=;
        b=wdY47Z5XFVo6MMZjfZdWVtSopItQ8RP0CDZoYCsMXOUu7nqEAATUzuXwPrQZkgslpP
         TubGkV+xF+aiLSYTdyNxWQk2BxeJmKDco3fwNcI/4ztqzFevImK9fCy1WYuXcdMz+D1r
         dIT0GHZ9tReAaJ7KXy4VwoNkBnphKFPSNbZc2A29FJJ08VaKWTLHDaUgP03vb0MymLEQ
         rpL6SNXpwR13cflMqJzZdafNe9PN++XmC8gDcu2mTr/G/e2axOY1Z5+ppunVMz2pd1gI
         QHeZ5GHQJLj8bgh7KOfToVaVb+3Baa7ECDg8jnBdpX2O12YKOkXVjFJ8Cu6xF/axrZzU
         nUJA==
X-Forwarded-Encrypted: i=1; AJvYcCVhTNd2QF1mTNNfG1xGSYoYzDESOGPh9FNVoavqvQ0LNut9bym8w3IYmrT7mQVroVHORPBe4w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHncNk5DZYDCcLRne/TBsdtRHR4HOZNnkvw+TymDlr+jnX13z
	6v9Mr3xXtB5M17iBa45RGr1tepZ7w1/9RLyNcffEnBmaEkt70xcuVoaHFHlfMXBwJiJvC3/louN
	HLQiHVNCyri3eg8wxZ4uEshsv9nq8ArpS/Saz8I97trkgXD/ScCM5mT7ebg==
X-Gm-Gg: ASbGncvzib/sdKP6rOYU7U1uEs1ov6++mc+eOKQ6dmXRqbInmbLyCKLFF2ka92yRHa6
	V7LW5pO266HlE4XiKACIGTQfrqRDx9g9GRBZSIryaHDG5N6ecdcRrzLDHLxtB5ay/ID3h6yjbMT
	0OPOX9TYEveGehHzU4uEVPHQ5x3ITIxYSELcpd3O8aVRwnM6mNkJugoDauXfH4xWHQr7tl+Vd4z
	mAOfHZmPg1ZRuj3tFF17nApB7OC4Z3XeT67vzFc9/u4qy/BiuLrtdtoskq0koas9ZoBN8YTMPVk
	fobZ1LF2+/bP+nGE/ht2eCWUKhZm
X-Received: by 2002:a05:6871:2101:b0:2d9:8578:9478 with SMTP id 586e51a60fabf-2f5a89a2456mr1620088fac.4.1751451660850;
        Wed, 02 Jul 2025 03:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjnqBPdraA9wKo6pHyy4bnNYvJ2ThZk+lGjpFEgWafOmcLKgFaCiU2WyDUSEWN1BVbih6pWA==
X-Received: by 2002:a05:6871:2101:b0:2d9:8578:9478 with SMTP id 586e51a60fabf-2f5a89a2456mr1620073fac.4.1751451660486;
        Wed, 02 Jul 2025 03:21:00 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.164.126])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd4efb7cfsm3767218fac.16.2025.07.02.03.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:20:59 -0700 (PDT)
Date: Wed, 2 Jul 2025 12:20:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, decui@microsoft.com, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, 
	Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RESEND PATCH net-next v4 3/4] test/vsock: Add retry mechanism
 to ioctl wrapper
Message-ID: <2cpqw23kr4qiatpzcty6wve4qdyut5su7g7fr4kg52dx33ikdu@ljicf6mktu5z>
References: <20250630075727.210462-1-niuxuewei.nxw@antgroup.com>
 <20250630075727.210462-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250630075727.210462-4-niuxuewei.nxw@antgroup.com>

On Mon, Jun 30, 2025 at 03:57:26PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 32 +++++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 24 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85..481c395227e4 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -16,6 +16,7 @@
> #include <unistd.h>
> #include <assert.h>
> #include <sys/epoll.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <linux/sockios.h>
>
>@@ -97,28 +98,41 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() 
>callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return false if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected)

Why we need the `actual` parameter?

> {
>-	int ret, sock_bytes_unsent;
>+	int ret;
>+	char name[32];
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, actual);
> 		if (ret < 0) {
> 			if (errno == EOPNOTSUPP)
> 				break;
>
>-			perror("ioctl(SIOCOUTQ)");
>+			perror(name);
> 			exit(EXIT_FAILURE);
> 		}
>-		timeout_check("SIOCOUTQ");
>-	} while (sock_bytes_unsent != 0);
>+		timeout_check(name);
>+	} while (*actual != expected);
> 	timeout_end();
>
>-	return !ret;
>+	return ret >= 0;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	int sock_bytes_unsent;
>+
>+	return vsock_ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0);
> }
>
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5..d59581f68d61 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_ioctl_int(int fd, unsigned long op, int *actual, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>-- 
>2.34.1
>


