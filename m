Return-Path: <netdev+bounces-190469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF62AB6E02
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F903BF421
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBF719D8BC;
	Wed, 14 May 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hw7ozJgG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1261A19CC22
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232384; cv=none; b=jkHuO67AFgcNNVYmM473kskbGjOfV9+Pb+ksWzqgU+DKmVCSGzZuDXdozWhe69b6m+RXMThHMAta+DBdLMOzZLaK3k5PkfeApdyz3BNGUndLV7r89YSBRLJ5h5pBDcCzK85MHmfy370HCtPrB+crUk6IMS8NmlGOP8g6GvKFJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232384; c=relaxed/simple;
	bh=MDkS8ldGXScRZONUBL673Asf/ksz7j4BMNcyHSf2rFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlT7e3Lr58IPFOQIQ84C+RAeFTTqA2v7K+CYWRaEQ5JBoInDfQTTUEGbxSaBh/FiULl7eHgYURMt/Jy8hcJc4LVyxeUKYKHPfGw9UmkI6VA5N6Fv72xmZQGsC2v+Mbe2n6CqfIzPzQLGhH9QtJxTgSWV45xCy1FM+csX9kIUWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hw7ozJgG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRSwjGEuphQPWi9/jNcoY4twWfTF60gioe70+GQBSH4=;
	b=hw7ozJgG1HNl2gzbCEbpV6RHv6qQ459x4PfE8/NEeWTsfv2mWuHYdE8TDAnPKuIW9aUPl8
	oFkJpFqgGLNOkIhtCLNbTm6fz5+8/0XrMuSxmbhrqPcl3Q3f9ZQ+HouBLXY9NKqZsmRSYv
	eLKdB4dcDJ7IexuvcJxNsEYyS5/7JdM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-3TVXcDhkPOyv4oIgWzQ7UQ-1; Wed, 14 May 2025 10:19:40 -0400
X-MC-Unique: 3TVXcDhkPOyv4oIgWzQ7UQ-1
X-Mimecast-MFC-AGG-ID: 3TVXcDhkPOyv4oIgWzQ7UQ_1747232379
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-441c96c1977so45169525e9.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232378; x=1747837178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRSwjGEuphQPWi9/jNcoY4twWfTF60gioe70+GQBSH4=;
        b=aentFsp3uMXDnvkyzY4QfX4v1nJ0M0OHs/d2lizLo+rti6tZWqf+6WdWz6liMNFqOE
         T/yCaEjpq9FI76Fl6NCEJHyntRlZTj4ntpAzauMOt3u2UzWF1AOTXxK1EaCc4sgLrqXb
         A+B30Z77wGWZ0+KKrzaNXUa9qgjL74Vyox3GAgdsSe8uyjczRuYRvSVTi3DwQ3DqCXbk
         vEPpfatG1jlKPOhGS3ZcgVHRvyfF4TbsGJyiF223w5ZoBd1/FqG9JrKbOEXdscIZZO4h
         n0lYgJvIYslbqG2HRgdAeeh70aRVVPbSVqjCDhGd8SsRHXF/npc7LhBuK5zOI8eg2pi7
         izsw==
X-Gm-Message-State: AOJu0YztqHz+IlQJzr7AvsJ6A11R50/YQjrBrJ7GC4/5MNNnIUGalbQj
	FfmcxOr1RXaHjYfEfQWd++J73gtTs3LKWIXXkbtg3DG3FN3t4B5hiDhFo1Zt4vPwhHai6sQXzgx
	l1r7N0UvnKWHC2rGtJY3FwIcMcUpeMlnVNKHl/suOaAUx78jlDf0UblOT84SyxYRZVFdQ3ru/0e
	C3lexQimMAGmB+RWWJQaOr0LYV3h5l4SwjH1RY8A==
X-Gm-Gg: ASbGncs0FjxR1Ncd9DfXQzBtNzQbsn3fxsyAQy6eIvHlhowKDmab3mcc5rP9nm685Pg
	cNlkqkJqVj/fHB3ygWmJASFT7PL8XR6+lBRfaKcl+tqCzR4f5vrZ41fJ4wfYtRUNvegBR5okWNG
	YhBkZR7U8MtQUcucRoPOgAwp7gdSkfnIUd8T14ejSrdy2fTrxWf1/hnaiOPuJy+55bNo9Ds7Yxn
	dJdX+T4z9019mvnsKH89CK8nwA3PIUkc2X8NtxKTBUQkyjiGqAWj7HxCNp0twKqInLsN50iHeEr
	GhD5+41B94pI4BJqug==
X-Received: by 2002:a05:600c:3494:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-442f20b9b46mr35323585e9.4.1747232378313;
        Wed, 14 May 2025 07:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEF2R2tDjrWwT+L3uOaPxQKRvbLVHWMJVYv5KC6EA6jIX0QqXFdhjGQEIvk4sDMFBkXNW9ig==
X-Received: by 2002:a05:600c:3494:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-442f20b9b46mr35323015e9.4.1747232377726;
        Wed, 14 May 2025 07:19:37 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e8578sm33288515e9.29.2025.05.14.07.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:37 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/3] vsock/test: add timeout_usleep() to allow sleeping in timeout sections
Date: Wed, 14 May 2025 16:19:25 +0200
Message-ID: <20250514141927.159456-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514141927.159456-1-sgarzare@redhat.com>
References: <20250514141927.159456-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

The timeout API uses signals, so we have documented not to use sleep(),
but we can use nanosleep(2) since POSIX.1 explicitly specifies that it
does not interact with signals.

Let's provide timeout_usleep() for that.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/timeout.h |  1 +
 tools/testing/vsock/timeout.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/vsock/timeout.h b/tools/testing/vsock/timeout.h
index ecb7c840e65a..1c3fcad87a49 100644
--- a/tools/testing/vsock/timeout.h
+++ b/tools/testing/vsock/timeout.h
@@ -11,5 +11,6 @@ void sigalrm(int signo);
 void timeout_begin(unsigned int seconds);
 void timeout_check(const char *operation);
 void timeout_end(void);
+int timeout_usleep(useconds_t usec);
 
 #endif /* TIMEOUT_H */
diff --git a/tools/testing/vsock/timeout.c b/tools/testing/vsock/timeout.c
index 44aee49b6cee..1453d38e08bb 100644
--- a/tools/testing/vsock/timeout.c
+++ b/tools/testing/vsock/timeout.c
@@ -21,6 +21,7 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <time.h>
 #include "timeout.h"
 
 static volatile bool timeout;
@@ -28,6 +29,8 @@ static volatile bool timeout;
 /* SIGALRM handler function.  Do not use sleep(2), alarm(2), or
  * setitimer(2) while using this API - they may interfere with each
  * other.
+ *
+ * If you need to sleep, please use timeout_sleep() provided by this API.
  */
 void sigalrm(int signo)
 {
@@ -58,3 +61,18 @@ void timeout_end(void)
 	alarm(0);
 	timeout = false;
 }
+
+/* Sleep in a timeout section.
+ *
+ * nanosleep(2) can be used with this API since POSIX.1 explicitly
+ * specifies that it does not interact with signals.
+ */
+int timeout_usleep(useconds_t usec)
+{
+	struct timespec ts = {
+		.tv_sec = usec / 1000000,
+		.tv_nsec = (usec % 1000000) * 1000,
+	};
+
+	return nanosleep(&ts, NULL);
+}
-- 
2.49.0


