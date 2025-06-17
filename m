Return-Path: <netdev+bounces-198699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B2ADD112
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 17:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C14F188CF55
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE062E88BC;
	Tue, 17 Jun 2025 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch7lVb55"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389802E8897
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750173069; cv=none; b=im5wtXEj7SvqfNc/C/3dLRBW/lzMwlM+QJl2XWAe+MYZymcOY+tsV9PSUCcFq28wg7jVopEa1mU8F7syrqY+whJBAAVGtQIi2NKBrRhxEYrbmr6m4mpxVUL9igkrMXdLdbkAkIOF0rAIwrWyquHdD6bBLuf/L8MrQLfkM+5s7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750173069; c=relaxed/simple;
	bh=pdPq9PlVlHWZ2cVzJk1emG6nTw+vRlKhWuL8ddlKXW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOWvHtoFfYdCk4q75eHk5tK205dYhAdjE/OO7Vz2ldLUxoJIucHaZpRkKzyn4NOS8rSvXE+NlrVVsT9x04P/fCsXHuj2wcoH4/apHHAwlkKiBOCHmbI70ZZP6Cbe7vHWzNwda2w7e4nZd3E/E/k9NLNJrueCD/8lJLhWB+kSTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch7lVb55; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750173067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGX6svIlWpZEQ5EFYjPNzt7elF0IRahwc1dWlkYR+Go=;
	b=ch7lVb55ygvkafVcr0sV4mtXe13cyh1+QBcqnOpzHgGAdx7pznKq1RSEoVCx26VzFzG8Sf
	yBd+8iA83NLY76SM+JTCMh7SyZ7lS65fOXg6tI6DnXML2qAWLRExVVuk0tv7b1SkM2SwXG
	fJFCYtxZDkFopIUIVaVe6FqK02559gQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-4yMlnIUuOhWGLiElpsoKSA-1; Tue, 17 Jun 2025 11:11:06 -0400
X-MC-Unique: 4yMlnIUuOhWGLiElpsoKSA-1
X-Mimecast-MFC-AGG-ID: 4yMlnIUuOhWGLiElpsoKSA_1750173065
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d290d542so35530245e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 08:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750173065; x=1750777865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGX6svIlWpZEQ5EFYjPNzt7elF0IRahwc1dWlkYR+Go=;
        b=r5mOvfHh0bCc4nQ7tuiPrvK0rfGht8pAAH8T9DzPQCWFJ2Npz5LgxoeA9cGqFYayD6
         tY4+csLA4s8c+1VvKzTMrl0TmJr47T+ViMcl4IzCtEIrhlu6N9v4gMTfGEZtvHUwNFjV
         5wfL+SK3ZfCS57TmN4ooWx92XjiGyoLao6Yg9vRysm+Rn2K9hjgip+V5mTDXDqF+bY++
         MTWZ0LeOgOwSC0ugoJpA5HDJBe4ghv6HmscfsTo8QTONC8CGolT2OY5hcEHNJo14mk3P
         uv7tPTyaSx9oyCgcIMxD2QO5nMPOWGwIXvL53mtkeoNp6/nZBuRVOx+zN6k0Swu8XLyJ
         k3QA==
X-Forwarded-Encrypted: i=1; AJvYcCXLM8amVe5w8TkqFv0XIvpVl5VP/v/zOasHt7OUHmHq7mi5x7HI6eNrS1WCzHYSk46wII91tq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhodqLwGK3zpg5NF03H1VGAxEr2NI5Ef/58VlR/PHrz0tjKRoQ
	9b0I8gVhHVkZn1/Vxqu5i91stxgXl2QfiVn45u9NKN/xp99u9CnKiLVrpbncCqu6/aK+1Fy/3Yq
	wF3gzJjmEB/i7an/TdZrWMP7eA6CE7773iP3LRpCSVxvCB6/8lNZe1ZPrmQ==
X-Gm-Gg: ASbGnctusmKIVt+Ss2V8/x2/qJ/DwQFzY+HZzkhdp3d0iK0+jLz4bCjzfaO+ATyZfET
	RX1skfjQ4d/69J4wXiYOPe2hLbvjshTHkZtZ54tusUuHgSi4A8SGpogQ/KFPgCcNFp+/xbG/7qo
	dp65GLfaseqLNmTSEMxzEpYyZ/vnLznbxMQ4Q3O93O3jJg57MQfc7vb0CRlBrCVEld7QITi3KBC
	D90RBZY4hbdcBRRWc6obLfRPytQFNb9p6K5Zu6aByoru3PGLEYc8hof7/E0MiviKdRt8FaGM7tY
	Z/FuqumCEfypYIXp3E91llAtDfzU
X-Received: by 2002:a05:600c:4f54:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-4533cab1c91mr100034865e9.25.1750173064652;
        Tue, 17 Jun 2025 08:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLw5YcffSL+V+Aaktp6ydgR00R6Aiz6j5f4o7u0CbWcG6l7Jh0rci6v44UVdISCb4YtYblWQ==
X-Received: by 2002:a05:600c:4f54:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-4533cab1c91mr100034365e9.25.1750173064079;
        Tue, 17 Jun 2025 08:11:04 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13c192sm179620505e9.26.2025.06.17.08.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 08:11:03 -0700 (PDT)
Date: Tue, 17 Jun 2025 17:10:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: mst@redhat.com, pabeni@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, netdev@vger.kernel.org, stefanha@redhat.com, 
	leonardi@redhat.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [PATCH net-next v3 2/3] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <uqpldq5hhpmmgayozfh62wiloggk7rsih6n5lzby75cgxvhbiq@fspi6ik7lbp6>
References: <20250617045347.1233128-1-niuxuewei.nxw@antgroup.com>
 <20250617045347.1233128-3-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250617045347.1233128-3-niuxuewei.nxw@antgroup.com>

On Tue, Jun 17, 2025 at 12:53:45PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 37 ++++++++++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 29 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 0c7e9cbcbc85..ecfbe52efca2 100644
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
>@@ -97,28 +98,46 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return a negative value if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int ret;
>+	char name[32];
>+
>+	if (!actual) {
>+		fprintf(stderr, "%s requires a non-null pointer\n", __func__);
>+		exit(EXIT_FAILURE);
>+	}

I think we can skip this kind of validation in a test, it will crash 
anyway and we don't have in other places.

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
>+	return ret;
>+}
>+
>+/* Wait until transport reports no data left to be sent.
>+ * Return false if transport does not implement the unsent_bytes() callback.
>+ */
>+bool vsock_wait_sent(int fd)
>+{
>+	int sock_bytes_unsent;
>+
>+	return !(ioctl_int(fd, SIOCOUTQ, &sock_bytes_unsent, 0));
> }
>
> /* Create socket <type>, bind to <cid, port> and return the file descriptor. */
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 5e2db67072d5..f3fe725cdeab 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -54,6 +54,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+int ioctl_int(int fd, unsigned long op, int *actual, int expected);

what about using vsock_* prefix?
nit: if not, please move after the vsock_* functions.

The rest LGTM!

Thanks,
Stefano

> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>-- 
>2.34.1
>


