Return-Path: <netdev+bounces-198658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73E1ADCF86
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5F316DFF0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7E22ECEBF;
	Tue, 17 Jun 2025 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeCirBGH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A28C236A99
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169534; cv=none; b=s5VSGKD4KAu88hp1W5zj6brZOdXnfKKC9KNKTgtf2WBIr8yNpavwZ9Tl/ftRxwOg7xKZj6ikrBdlhrkwic19ZK3Tk2zR2WskuLL11B5XFUgkXQIkYfmgzSe6dMCU3HXof54OsRtHFkcS+Yc1Fh5i3YUwzJhjG9VV1VoOA7jizrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169534; c=relaxed/simple;
	bh=p01vA1PBCXZmwTD9ipYGalgea25sUjLAH06zPyyCzos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLOwjMraQvsLGfoxH2Zmz2LH9LcYH8Ay8SlpKUspAydVmPZcYxoLtQmAL7Lw79fVmDOt9X+fMfuN56gSVkcQppMCKc7GlNXndwwWiBXy5LhiKMkNhNbVWZOgMl6nYWbandJUsHj8/rL62HpcEYDncBhzNzmHZNN2QCmXAYa0gKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QeCirBGH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750169531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tDQawTMiyaVh5j2oaJP/el64wEr3+7ENbyMBrC9glDw=;
	b=QeCirBGHXUPG7qAql9f6+j5rmRl0zozekmxoZYPjhfOF7z4GlX0GXnpHKcHEl3w1N+63ZK
	9JEoGaGsewyQba6z/rbEjKZgFUzb0Eu/Zc6UddDvTWlHY3K67CPmUxuL/uihr72Rgh4mJW
	0w/hpGrQZidgDWxJqkNMS28kivZhl1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-yfCWzfn7PKCUhsuHgeey6Q-1; Tue, 17 Jun 2025 10:12:10 -0400
X-MC-Unique: yfCWzfn7PKCUhsuHgeey6Q-1
X-Mimecast-MFC-AGG-ID: yfCWzfn7PKCUhsuHgeey6Q_1750169529
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so34309075e9.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169528; x=1750774328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDQawTMiyaVh5j2oaJP/el64wEr3+7ENbyMBrC9glDw=;
        b=NONBAYAdnsqOn07Mdpasuia93DKcFqj3rYVwSb520SVhOp4YxEbC7TX3wpRQ78xfus
         B1WbjHfpY14rysBp1+oqjN5IwfHKTNG2lO8fKiXVt0iIY9txxYhbdc+Fia/qPoexvrF6
         FELcGdakpWmGZ9qeNKoLlceJkNXnaM2oaj/DLTMi2EQzXa+hDTs14eXeXkzZvCW1oBqK
         SmTp2bkZqd5YOiLcTed36mxs7FINE7+AiFtqKXlt2uNEKsRdpkXz7IBpVvtYSL1uUaL+
         zZhy//VS+6Cc0UQ/AA80XWPsHEuP0zwpaNqTjYDRJIh3hQxSuXET3wwtnTqnuQ5Bt684
         8KtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb2fim8UZJDgdJJ4cK4uMqzVJbOHJjotN6zZERH3T1oMW8DOHPIoNhqO/CHrEobwjsGp33/wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uKv6L8w/p7qP1C0UuehMW/ie40QZB4WzMl7Svro/vUexGg2q
	T439F3AV39pFq2PivAue8WK46qbcBt3qajgVCbVRT29iq/lh435ou3FmeXJUpiZoaQ3URlAXdoP
	ZvlAg52cs4xVw6uVijrWSRzZgpgDKc4YAbk3D33BcYyC4OO5r7Igo3XkKfAf0bSY0fA==
X-Gm-Gg: ASbGncu/YTreVAYB+HLfMJnuXXsrx7z1bSF0nkBgxSVnsjmtqxdY/+c/tt/x9LBSOin
	BlcK+F1Bm5OBdo6YV+hz/PgfbuG2P1yiTCEHoJ8uOpIcZGUNP50Pp7LL79gJELZHTKljua6Czgo
	AEIBOczxVA3SMQK7XcpwACv6wMJW+GUQ8p+mFPvXFBKG9iZkF5DLLeEks2bup1wEVYnyQczuCvG
	LNBgSflxQYAbd0L7+QeWO5dzjSB9QBaDZ8oZIHhk8oYMzssAP756uIGnp7UyRlIC7Tn8xngJdt5
	OzQMPSgjSsyO4zpkwkzJLifzhgl7
X-Received: by 2002:a05:600c:1f94:b0:450:d019:263 with SMTP id 5b1f17b1804b1-4533cad3c9cmr144825165e9.18.1750169528365;
        Tue, 17 Jun 2025 07:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpOFjhK6ipEOxmVfRV3fbYV+dQY5pR+5sd2WS6/OERnStK2AUSFKitcs+M6aAjkClrM9e7nQ==
X-Received: by 2002:a05:600c:1f94:b0:450:d019:263 with SMTP id 5b1f17b1804b1-4533cad3c9cmr144824595e9.18.1750169527774;
        Tue, 17 Jun 2025 07:12:07 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.200.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e156e8dsm183349865e9.31.2025.06.17.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:12:06 -0700 (PDT)
Date: Tue, 17 Jun 2025 16:12:03 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] vsock/test: Introduce get_transports()
Message-ID: <sbfcl6s233hmkry3ecq6rwzvpl2gw2z23g2dsymruetn436ou7@znv2hen5wkde>
References: <20250611-vsock-test-inc-cov-v3-0-5834060d9c20@rbox.co>
 <20250611-vsock-test-inc-cov-v3-2-5834060d9c20@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250611-vsock-test-inc-cov-v3-2-5834060d9c20@rbox.co>

On Wed, Jun 11, 2025 at 09:56:51PM +0200, Michal Luczaj wrote:
>Return a bitmap of registered vsock transports. As guesstimated by grepping
>/proc/kallsyms (CONFIG_KALLSYMS=y) for known symbols of type `struct
>vsock_transport`, or `struct virtio_transport` in case the vsock_transport
>is embedded within.
>
>Note that the way `enum transport` and `transport_ksyms[]` are defined
>triggers checkpatch.pl:
>
>util.h:11: ERROR: Macros with complex values should be enclosed in parentheses
>util.h:20: ERROR: Macros with complex values should be enclosed in parentheses
>util.h:20: WARNING: Argument 'symbol' is not used in function-like macro
>util.h:28: WARNING: Argument 'name' is not used in function-like macro
>
>While commit 15d4734c7a58 ("checkpatch: qualify do-while-0 advice")
>suggests it is known that the ERRORs heuristics are insufficient, I can not
>find many other places where preprocessor is used in this
>checkpatch-unhappy fashion. Notable exception being bcachefs, e.g.
>fs/bcachefs/alloc_background_format.h. WARNINGs regarding unused macro
>arguments seem more common, e.g. __ASM_SEL in arch/x86/include/asm/asm.h.
>
>In other words, this might be unnecessarily complex. The same can be
>achieved by just telling human to keep the order:
>
>enum transport {
>	TRANSPORT_LOOPBACK = BIT(0),
>	TRANSPORT_VIRTIO = BIT(1),
>	TRANSPORT_VHOST = BIT(2),
>	TRANSPORT_VMCI = BIT(3),
>	TRANSPORT_HYPERV = BIT(4),
>	TRANSPORT_NUM = 5,
>};
>
> #define KSYM_ENTRY(sym) "d " sym "_transport"
>
>/* Keep `enum transport` order */
>static const char * const transport_ksyms[] = {
>	KSYM_ENTRY("loopback"),
>	KSYM_ENTRY("virtio"),
>	KSYM_ENTRY("vhost"),
>	KSYM_ENTRY("vmci"),
>	KSYM_ENTRY("vhs"),
>};
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> tools/testing/vsock/util.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
> tools/testing/vsock/util.h | 29 ++++++++++++++++++++++++
> 2 files changed, 85 insertions(+)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index b7b3fb2221c1682ecde58cf12e2f0b0ded1cff39..803f1e075b62228c25f9dffa1eff131b8072a06a 100644
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
>@@ -23,6 +24,9 @@
> #include "control.h"
> #include "util.h"
>
>+#define KALLSYMS_PATH		"/proc/kallsyms"
>+#define KALLSYMS_LINE_LEN	512
>+
> /* Install signal handlers */
> void init_signals(void)
> {
>@@ -854,3 +858,55 @@ void enable_so_linger(int fd, int timeout)
> 		exit(EXIT_FAILURE);
> 	}
> }
>+
>+static int __get_transports(void)
>+{
>+	char buf[KALLSYMS_LINE_LEN];
>+	const char *ksym;
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
>+		for (i = 0; i < TRANSPORT_NUM; ++i) {
>+			if (ret & BIT(i))
>+				continue;
>+
>+			/* Match should be followed by '\t' or '\n'.
>+			 * See kallsyms.c:s_show().
>+			 */
>+			ksym = transport_ksyms[i];
>+			match = strstr(buf, ksym);
>+			if (match && isspace(match[strlen(ksym)])) {
>+				ret |= BIT(i);
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
>index 0afe7cbae12e5194172c639ccfbeb8b81f7c25ac..71895192cc02313bf52784e2f77aa3b0c28a0c94 100644
>--- a/tools/testing/vsock/util.h
>+++ b/tools/testing/vsock/util.h
>@@ -3,8 +3,36 @@
> #define UTIL_H
>
> #include <sys/socket.h>
>+#include <linux/bitops.h>
>+#include <linux/kernel.h>
> #include <linux/vm_sockets.h>
>
>+/* All known vsock transports, see callers of vsock_core_register() */
>+#define KNOWN_TRANSPORTS(x)		\
>+	x(LOOPBACK, "loopback")		\
>+	x(VIRTIO, "virtio")		\
>+	x(VHOST, "vhost")		\
>+	x(VMCI, "vmci")			\
>+	x(HYPERV, "hvs")
>+
>+enum transport {
>+	TRANSPORT_COUNTER_BASE = __COUNTER__ + 1,
>+	#define x(name, symbol)		\
>+		TRANSPORT_##name = BIT(__COUNTER__ - TRANSPORT_COUNTER_BASE),
>+	KNOWN_TRANSPORTS(x)
>+	TRANSPORT_NUM = __COUNTER__ - TRANSPORT_COUNTER_BASE,
>+	#undef x
>+};
>+
>+static const char * const transport_ksyms[] = {
>+	#define x(name, symbol) "d " symbol "_transport",
>+	KNOWN_TRANSPORTS(x)
>+	#undef x
>+};
>+
>+static_assert(ARRAY_SIZE(transport_ksyms) == TRANSPORT_NUM);
>+static_assert(BITS_PER_TYPE(int) >= TRANSPORT_NUM);
>+
> /* Tests can either run as the client or the server */
> enum test_mode {
> 	TEST_MODE_UNSET,
>@@ -82,4 +110,5 @@ void setsockopt_timeval_check(int fd, int level, int optname,
> 			      struct timeval val, char const *errmsg);
> void enable_so_zerocopy_check(int fd);
> void enable_so_linger(int fd, int timeout);
>+int get_transports(void);
> #endif /* UTIL_H */
>
>-- 
>2.49.0
>


