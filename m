Return-Path: <netdev+bounces-204926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E578AFC8FA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6757A1F68
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356C2C3769;
	Tue,  8 Jul 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6ejZmVL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FC2D23A6
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972091; cv=none; b=Rwl7+0D+NZcQjeyVIK+XpjdD82hzdfuz5Q/2zUIFU77PiOwEXjDL4Rv9MwtG7LSMt2QQKWMQAjOUfofzLmGlfvFR3MUd29+ldHOtddcd0odWSMeLerzzI0+8j1jkPQFwQQVa5lNtM/248luMu13GPKewxK3YTYQhSJ8XAr34x7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972091; c=relaxed/simple;
	bh=pt6duYiMCIehtx4IxrjJmNZ1YzZaoG3aJy7HoAatvQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeAXVZdw5QKbmY4WPJCwmELQU5YNVztNH2lvHrMTkWQshWsgon6fPqHx6rUlD4PxIwzEe8dsaBDc4iv4sHO4y6hYKoa4j/pWmOWh17f932dkbflooK1pcAhDES7LJsaaGh63xQMazjRzHQU5ATnoNgC6QQBowmJYwtzCCvmGkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6ejZmVL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751972088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
	b=B6ejZmVLAb453YCu9tDrgsP68cdGmHBOCoHdKJDaCXAovhQY1nyfCA3Mdolrzp+f2+4GkB
	I5DFlk+12RAxRqmPk7l6RjrwTOGapKRNT1TfVBARLD/MSesHJ0T3SI2tG841d7Wx5Fx1f7
	xTRXuTEUj2nsWlXH0GG8OyWIADTDWM8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208--cZxe2dQNMKqGMvHxOxZzQ-1; Tue, 08 Jul 2025 06:54:47 -0400
X-MC-Unique: -cZxe2dQNMKqGMvHxOxZzQ-1
X-Mimecast-MFC-AGG-ID: -cZxe2dQNMKqGMvHxOxZzQ_1751972087
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d38fe2eff2so590132685a.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972087; x=1752576887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zVRF5eqOqy+l/yn1UXOkezwlr4g/SUUPIur6RAL+Y0=;
        b=Ymb2DeYPuzqoFaO++CFiIH+QCqAQHe0y3aIcZR3kmvRerY1OHaRda9X9ZVrGcDu48v
         m9bTC4gCF43GImN0d5A9sTGnD+rdkIZqKrOwS5DfVXK5qp4NhEDRB2RcIerA3YpMDCDM
         JZfccKTHfFEGVLzEl39OzG3eD1tRfFydMUD4af4nnB6sA+3M9ylASDZ0H3RleQBBOiWf
         YrcrF6XAkeHx+Iy1fMmYBCKLmBDesJTRgk7Lan2cRqcJGo/kRDRzDG4UqZxXQGOmH5RY
         23ruDpVM+o/Ly63jJ5XE3gcztFwm2X0qAtWdgbEBRx2/sH3Dji9ZO8F65U5eL/ftTmaY
         /q6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnO/BXj+ANYBNmiRe0eaBz2v9daAoyMlCBWN4UD3ubWvAbQE5kBNTCIhHeVkNoudIdgvz/8NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIZsFSFSQIFJ9SD7peNzsFwGLoXowKyxLmbdfkOaN61GrcjR/+
	UzVcu+LsktcdOZvoDPY0s6DHDcBC/MzYqFKb3flglRpY0c7C7r2Y+b/4Tc9b6SCee8Zy+fM28Gp
	kaCCTLtFJXHDoFcGlSp7KeMeILCgWr8AJtdgLhFHlQIrfy9JiYUQmks/OXw==
X-Gm-Gg: ASbGncuN93JsS2xPwog+5KNSsVWA5+2r3qRk1FRl6AE+68u9qweilQaDflav8wxFgly
	O6kkCwQkJSecIT1z9/bqo7Ji5kyE1SkyWjYc92DBh8bDul6B8aTdwdN2tmjXJjoaRKdjAw4W8Sn
	rb7ijZFz/zr35g0+wbCpUeq8C9yY7tQ3lUukiwMJGdi/NEy3Y8GVNQlWNGgF4FG0jXgCWc49W/6
	s0qu8W7v3wqvVGkOPLGuV9Moyn8Le9hIo2m5WhJ8ZZwHB6BLwPIKSFGF/ybjXjIf1KeZbE1DNUd
	bIZnE8g+Q6mzktn8F51V9rFHpfXf
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344297185a.51.1751972087261;
        Tue, 08 Jul 2025 03:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGODJ+k5iQwpBD8zrN9hRkPcNeibB7riAG/EN8ncnQ9dHTW0DTOP7oRQy4VBda/jQ7Oc5xqfg==
X-Received: by 2002:a05:620a:4089:b0:7d3:8f51:a5a5 with SMTP id af79cd13be357-7da04137a83mr344292285a.51.1751972086595;
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe8f861sm757715685a.86.2025.07.08.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:54:46 -0700 (PDT)
Date: Tue, 8 Jul 2025 12:54:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuxuewei97@gmail.com
Subject: Re: [PATCH net-next v6 3/4] test/vsock: Add retry mechanism to ioctl
 wrapper
Message-ID: <xvteph5sh4wkvfaa754xxakufgwkjzjawzfttnfqcvmei2zcpf@ig6fawckff2h>
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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


