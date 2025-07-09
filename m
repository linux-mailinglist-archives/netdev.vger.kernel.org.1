Return-Path: <netdev+bounces-205461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABAAFED1C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F991669EC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CFC2DAFBE;
	Wed,  9 Jul 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dErvXQD8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E431DFE1
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073349; cv=none; b=mjlax5JZLAtVwzBsBxN+jokgWU4A6XHXSxhHUaOdJBzj8r6QOqjXJ1l9/i2tmvsI1DaEnCakgdKgOWmjDGPMKmuadyr3+c9NV+l8HLV0yDmBbEDbvCZT+VTR5fG01C/6HCkedUgcRLxVaD9hLUhmZ/8OpEwGR9O6TyYVWBwXdTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073349; c=relaxed/simple;
	bh=qQzR+Sm5b5Z4CzPC2NcCXxweWFm55uF7TL7SSGOdvak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3Tjqwcc/L8E76tWiasizYEYYaUcXufpxcmQe1vfGEcAoh8VQ6gmCwG6ozssTl+0/JksatKOVBOvZoVtJUmGkqavRhTYuuSFFGPE3xITZBrwlJZgBZKPCxKu/5sNGzBevv8clkVgLrapWmHxOl3M9nAcUNcR3NcuVwHMuR0swVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dErvXQD8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752073347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K/2GYA3xGzU3Q7c5wwHJlSwh88wrrH29hih0NjGmI1c=;
	b=dErvXQD8qHWJHLlGlB1DSwrrGvtVmNqE7jEId0jfeFUeAzWy48Z0o+hp1sZm1/uAPB0ait
	kXh2cERTs3d4eunhq/KYjLxoVLUxHzq2tSvuK62jZ9MPxNet+Xm5t+y3MjvII0eD6kFO4w
	9rQLkhTOmaIX70YK4ZKA4ATTLP7ZGUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-z0IpOgcGMyC3TVYrIYMY-A-1; Wed, 09 Jul 2025 11:02:25 -0400
X-MC-Unique: z0IpOgcGMyC3TVYrIYMY-A-1
X-Mimecast-MFC-AGG-ID: z0IpOgcGMyC3TVYrIYMY-A_1752073345
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso9377f8f.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 08:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752073344; x=1752678144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/2GYA3xGzU3Q7c5wwHJlSwh88wrrH29hih0NjGmI1c=;
        b=qNAl2/3i7XcRbwwqqxSn39a/QAdCONpIUXhphfJe5CE5x05uplhF2eJY9BUoDY5kTe
         AlIhIHEa9yzifmPotSsK6iJqe7KvPco5S1YJq9aSOZrXrWl4dHAZf3klkxy7+ddCct4N
         9yvoQPjy4eAFet9N4Dy7ioSz5twuIEoSDNvJ7MqUucgdQ9MXh1+o5c86Rqs7AuSIS3hh
         8YRY3D5TFqQpRg08RE6Cy16WffClsnbw1MMoftW1H0DkNZ2pgpBnOQ5fRsiFQrZ1wh3f
         YtUkZRlV03rpj+ZLxYWd/hOQTLT3pdlwEVKPZoBJ60te0vptQvAksCoq0lw0Er7DDiyf
         1WqA==
X-Forwarded-Encrypted: i=1; AJvYcCXIGcPi/otYKeS6bPpXlrtX5+rRk3Yc4V/qmfLYU4Unt7vLYlxZXkYuZ9pPUCbIGssdOZvkj6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXd+oG7BMtxjm3ClhDIvWFGxE9fS7Bfp+LBJRyBF/NqvqzYMnV
	F3NHX5q7qylHWOO+HrBXIiChF1uLfK0a14dBgH7xl9dEBbKMSUzLuAi33bfFK/UPWoqgZD5OuQg
	5imgRwq3eAkBSSSHiZgbthTCb5y9b0fOylVAVgHcdIWWucgXiUaYg4WdOdA==
X-Gm-Gg: ASbGncvsgijDYM0xWjSeRwvbeBdNNWOmUFKDYm5CVA1FVfhZYsh99XnatHNjLQoJlrT
	RSegJKa2LhcSTDbvfdu3IaueDaTsV1wMB+R3g3KqIXrrm3NG8De6CdsqxsSayZU4Uls2yUzOyxr
	x+0G0vh1+eUknRnQLefWrReiNNycWSa6k5RceUzB68iSwID/KG8Y4fZJDHT+AGYsQtTgKDIwfSR
	n27co37VnQU37yyfUCQAzfx72VNGmukojPu4Ip+7B0qfZCHXvyruezs3zJjkphK4qoQbdS92x1r
	iL3zENq2y3/bcttrz5FbtM98iMI=
X-Received: by 2002:a05:6000:18a4:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b5e453e95amr2687761f8f.53.1752073343905;
        Wed, 09 Jul 2025 08:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj0X5fq5/CoLZOI4l1DS8uyjk64bp7E2wVLV9ayUvzfkSXxf8Z+pKpdKwZlMv5UOeEL6CVYQ==
X-Received: by 2002:a05:6000:18a4:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b5e453e95amr2687560f8f.53.1752073341897;
        Wed, 09 Jul 2025 08:02:21 -0700 (PDT)
Received: from leonardi-redhat ([176.206.17.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97f10sm16385987f8f.57.2025.07.09.08.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:02:21 -0700 (PDT)
Date: Wed, 9 Jul 2025 17:02:19 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <7j36bxpo4bgitf5jwi5kgs6pagrzg76thyfcyzpt2uikb7yqnl@5khvkwbgyphm>
References: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
 <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250708-siocinq-v6-3-3775f9a9e359@antgroup.com>

On Tue, Jul 08, 2025 at 02:36:13PM +0800, Xuewei Niu wrote:
>Wrap the ioctl in `ioctl_int()`, which takes a pointer to the actual
>int value and an expected int value. The function will not return until
>either the ioctl returns the expected value or a timeout occurs, thus
>avoiding immediate failure.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> tools/testing/vsock/util.c | 30 +++++++++++++++++++++---------
> tools/testing/vsock/util.h |  1 +
> 2 files changed, 22 insertions(+), 9 deletions(-)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 803f1e075b62228c25f9dffa1eff131b8072a06a..1e65c5abd85b8bcf5886272de15437d7be13eb89 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -17,6 +17,7 @@
> #include <unistd.h>
> #include <assert.h>
> #include <sys/epoll.h>
>+#include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <linux/sockios.h>
>
>@@ -101,28 +102,39 @@ void vsock_wait_remote_close(int fd)
> 	close(epollfd);
> }
>
>-/* Wait until transport reports no data left to be sent.
>- * Return false if transport does not implement the unsent_bytes() callback.
>+/* Wait until ioctl gives an expected int value.
>+ * Return false if the op is not supported.
>  */
>-bool vsock_wait_sent(int fd)
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected)
> {
>-	int ret, sock_bytes_unsent;
>+	int actual, ret;
>+	char name[32];
>+
>+	snprintf(name, sizeof(name), "ioctl(%lu)", op);
>
> 	timeout_begin(TIMEOUT);
> 	do {
>-		ret = ioctl(fd, SIOCOUTQ, &sock_bytes_unsent);
>+		ret = ioctl(fd, op, &actual);
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
>+	} while (actual != expected);
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
>+	return vsock_ioctl_int(fd, SIOCOUTQ, 0);
> }
>
> /* Create socket <type>, bind to <cid, port>.
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index fdd4649fe2d49f57c93c4aa5dfbb37b710c65918..142c02a6834acb7117aca485b661332b73754b63 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -87,6 +87,7 @@ int vsock_stream_listen(unsigned int cid, unsigned int port);
> int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
> 			   struct sockaddr_vm *clientaddrp);
> void vsock_wait_remote_close(int fd);
>+bool vsock_ioctl_int(int fd, unsigned long op, int expected);
> bool vsock_wait_sent(int fd);
> void send_buf(int fd, const void *buf, size_t len, int flags,
> 	      ssize_t expected_ret);
>
>-- 
>2.34.1
>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


