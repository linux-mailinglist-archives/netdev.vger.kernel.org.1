Return-Path: <netdev+bounces-195052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AF1ACDA8F
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804597A38B0
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1E428C5CB;
	Wed,  4 Jun 2025 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCJHA/Xa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606A1EEA5D
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028093; cv=none; b=r9XFmeHCQqDEkqzD8LUnE81s+KlTqVhHzp9l+tY+dh4UFKEurGe40L4y7Io2Ptj2Q86aiwzHB3vXqsK8EQTclXGMBn6ZOoJ8De8afAFkgkD84ttxGXhTbI7k3w1HL772Hn022OVuHP/8N7il4ucyi+8SR7gP2kSKWMON40jpO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028093; c=relaxed/simple;
	bh=AWVVRYeTcC5KIYUL/i0dVqV59Y6SWKAcZkYtIStbTyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dr4IRfRqQ6cO/xDMN6fVNxWBnoEzbGw6L+wFIupMaHrZ5gyc+wd8UCfKzYssMXnUd/W7hRE+cONudzLmXNGaBKd9HgRM2EdzCityDSY3ELnIWacG0jPKh7gh/iK6HKrhYidEX/xXtCOdbZlDkxVPkoOfCWyjvI41b/2rQrfDHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bCJHA/Xa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749028090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2zCiWY9Cu6i9hpLnZ1UCqekXGUFWqxbi6R4HONx48g=;
	b=bCJHA/Xatrvg0aEhWaDkrKMrm2ekU4uGe8iO376Kld8BMk5geKIVs4gQ1r3id+AWJvxjkg
	GZX7IOtJAWFjPWd90GjdKl4hg5rcCQYQGfe1sHA8UR87hg5CzO6nYjkQTxEW0A4DSQEKHB
	GLkYL9uf2NOa4ivXiGOGc2Jdcr/uiyw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-24AlnNoTPYGrnSN00xy63w-1; Wed, 04 Jun 2025 05:08:09 -0400
X-MC-Unique: 24AlnNoTPYGrnSN00xy63w-1
X-Mimecast-MFC-AGG-ID: 24AlnNoTPYGrnSN00xy63w_1749028088
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4517abcba41so25346155e9.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 02:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749028088; x=1749632888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2zCiWY9Cu6i9hpLnZ1UCqekXGUFWqxbi6R4HONx48g=;
        b=HcR47QiTj0f0i0DTPhF8P6NGw8RXtwHx5T2e+TB9AH/E+xcibJywZ69Iuh8Lo8xxpf
         +NhFtN5TAgMH/MmL5aphzLgGSpvjd83sCjyLfG1zFq0FleRrLrZzi6r8+OhIwGTIC31P
         GQSQIQgRdN0NJetRiP/E11Fyqj1Boi4rWPl59evbeADEmwyLSB/Mi5ZE2OiuDA2wxQWh
         A52J5TmdUrU4GPZuICBiRr5VkRQuZ+3vBKX1jplv0EUrwBH4/6OdAxJEPtBOsLKV59L1
         ymnMGYzK2VzQlTfZYQ4Xk8LWzZ4zXVKb/1jtPX++0w2JKSqjnmlPrvqHdBddvWUuS6Gl
         42AA==
X-Forwarded-Encrypted: i=1; AJvYcCVuWdxOo9Qb6w0ovAUIPNNXFPKTLRzrkSxg12oXtG99GhCIWLpRox6GlzbKmq7h3JAXjJmjrns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7sGbH0ELb39629OcUtd0wbqCc4bu60TQyhhMuJNqfMkR8T2l
	GDp9RbSjCXbiIbEOFGclhoenyA3L27acQuZ3Q93mqnZuRgnNV7cjWgb4OG6BhDis7i2uJsHEZFH
	+eZH5S0up9CqBm8uwJvljA1OdNnZmhk6PoJkS/QuQXvGjGUQpyQMTu3VqEw==
X-Gm-Gg: ASbGnct1Hfy0sqaGdZJCmV+ws4LQPErq7ZQ4SC1RPvX/wAbzHZWh21sZCIUCEfdp4i8
	VY5jLEwPqOVHfUEW8ZXlajcyH54YFs0+9uwx3QdonhA5Wg4HpqStBx5dszB7dSKyocDGEGafucU
	U1ORSdM9j2esa62x/SpnGM3s5/065liKFhFpPR3mINmyj3gehY3A3xipwk3DnH/R5XNgYPM2Gv5
	Q1zQvjGLinGNNRyDSVMKMbZSZbNWlcMSzfIOXDcN3qONN7o6YU7Z3pZPE7vXTtKhhneFZV+YSsh
	LkGl58GW83swNHs=
X-Received: by 2002:a5d:64e2:0:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a51d9305e1mr1523502f8f.21.1749028087955;
        Wed, 04 Jun 2025 02:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKDlW7KBQY6VqzFIm9U5n5W/ayB7fhlMXCKIz73xa+dzMXlXDavnhpdJnz7rqheStpYyjOjQ==
X-Received: by 2002:a5d:64e2:0:b0:3a4:e5bc:9892 with SMTP id ffacd0b85a97d-3a51d9305e1mr1523467f8f.21.1749028087400;
        Wed, 04 Jun 2025 02:08:07 -0700 (PDT)
Received: from sgarzare-redhat ([57.133.22.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa2541sm187792925e9.15.2025.06.04.02.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 02:08:06 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:07:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/3] vsock/test: Introduce
 get_transports()
Message-ID: <wzbyv7fvzgpf4ta775of6k4ozypnfe6szysvnz4odd3363ipsp@2v3h5w77cr7a>
References: <20250528-vsock-test-inc-cov-v2-0-8f655b40d57c@rbox.co>
 <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250528-vsock-test-inc-cov-v2-2-8f655b40d57c@rbox.co>

On Wed, May 28, 2025 at 10:44:42PM +0200, Michal Luczaj wrote:
>Return a bitmap of registered vsock transports. As guesstimated by grepping
>/proc/kallsyms (CONFIG_KALLSYMS=y) for known symbols of type `struct
>virtio_transport`.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
> tools/testing/vsock/util.h | 12 ++++++++++
> 2 files changed, 72 insertions(+)
>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39..74fb52f566148b16436251216dd9d9275f0ec95b 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -7,6 +7,7 @@
>  * Author: Stefan Hajnoczi <stefanha@redhat.com>
>  */
>
>+#include <ctype.h>
> #include <errno.h>
> #include <stdio.h>
> #include <stdint.h>
>@@ -17,6 +18,7 @@
> #include <assert.h>
> #include <sys/epoll.h>
> #include <sys/mman.h>
>+#include <linux/kernel.h>
> #include <linux/sockios.h>
>
> #include "timeout.h"
>@@ -854,3 +856,61 @@ void enable_so_linger(int fd, int timeout)
> 		exit(EXIT_FAILURE);
> 	}
> }
>+
>+static int __get_transports(void)
>+{
>+	/* Order must match transports defined in util.h.
>+	 * man nm: "d" The symbol is in the initialized data section.
>+	 */
>+	const char * const syms[] = {
>+		"d loopback_transport",
>+		"d virtio_transport",
>+		"d vhost_transport",
>+		"d vmci_transport",
>+		"d hvs_transport",
>+	};

I would move this array (or a macro that define it), near the transport 
defined in util.h, so they are near and we can easily update/review 
changes.

BTW what about adding static asserts to check we are aligned?

>+	char buf[KALLSYMS_LINE_LEN];
>+	int ret = 0;
>+	FILE *f;
>+
>+	f = fopen(KALLSYMS_PATH, "r");
>+	if (!f) {
>+		perror("Can't open " KALLSYMS_PATH);
>+		exit(EXIT_FAILURE);
>+	}
>+
>+	while (fgets(buf, sizeof(buf), f)) {
>+		char *match;
>+		int i;
>+
>+		assert(buf[strlen(buf) - 1] == '\n');
>+
>+		for (i = 0; i < ARRAY_SIZE(syms); ++i) {
>+			match = strstr(buf, syms[i]);
>+
>+			/* Match should be followed by '\t' or '\n'.
>+			 * See kallsyms.c:s_show().
>+			 */
>+			if (match && isspace(match[strlen(syms[i])])) {
>+				ret |= _BITUL(i);
>+				break;
>+			}
>+		}
>+	}
>+
>+	fclose(f);
>+	return ret;
>+}
>+
>+/* Return integer with TRANSPORT_* bit set for every (known) registered vsock
>+ * transport.
>+ */
>+int get_transports(void)
>+{
>+	static int tr = -1;
>+
>+	if (tr == -1)
>+		tr = __get_transports();
>+
>+	return tr;
>+}
>diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
>index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..63953e32c3e18e1aa5c2addcf6f09f433660fa84 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -3,8 +3,19 @@
> #define UTIL_H
>
> #include <sys/socket.h>
>+#include <linux/bitops.h>
> #include <linux/vm_sockets.h>
>
>+#define KALLSYMS_PATH		"/proc/kallsyms"
>+#define KALLSYMS_LINE_LEN	512

We don't need to expose them in util.h IMO, we can keep in util.c

>+
>+/* All known transports */
>+#define TRANSPORT_LOOPBACK	_BITUL(0)
>+#define TRANSPORT_VIRTIO	_BITUL(1)
>+#define TRANSPORT_VHOST		_BITUL(2)
>+#define TRANSPORT_VMCI		_BITUL(3)
>+#define TRANSPORT_HYPERV	_BITUL(4)
>+
> /* Tests can either run as the client or the server */
> enum test_mode {
> 	TEST_MODE_UNSET,
>@@ -82,4 +93,5 @@ void setsockopt_timeval_check(int fd, int level, int optname,
> 			      struct timeval val, char const *errmsg);
> void enable_so_zerocopy_check(int fd);
> void enable_so_linger(int fd, int timeout);
>+int get_transports(void);
> #endif /* UTIL_H */
>
>-- 
>2.49.0
>


