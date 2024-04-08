Return-Path: <netdev+bounces-85621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C9489BA3B
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A481C209A4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09341374C3;
	Mon,  8 Apr 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHd/+uFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991E37714
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564931; cv=none; b=pB5d21cgsaWi9hOOCG53n5nPtpdDYbF7CP3WVfUqqeqKkYBsmYUWCb+I1t5ItaShTHZfTkxLnNiInvBBuItKdpuAOgrbl9ZdSgnwRQft9r2w9/+s0k4gVtiA7X55h3fdaHsssgMrUPFaXacNVWiFko1bFeR9+oOW6ZXIZgz/S0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564931; c=relaxed/simple;
	bh=Ogx6x8wEzFRYWl2JCGZob2NQ54bGTwQk0xC3KpFu2N4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X2h0HdjODsgSl+LlYqesLBdVHpwwmkoW14vyrZEqG0RfXtJBKO7UwJfrcGKJEStAX0u3eswkkB6Ccsm4XjtwplXCtEX4H6G+1UywSW8wIIDuMk8QWQQc/VaQRTkxlag+kaIwoBJLo5xzav9c5NWNdMWO+iMirkgMRohElSzVsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHd/+uFT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso6578102276.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712564929; x=1713169729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqf4RlGCPpFy6RShn6WYXNtP8jJeVY7I/inYXSrvjho=;
        b=BHd/+uFTp2TAGsVcU6i2OOP7DZAT6mjGVqAX4lnfR+twvFk3eZWMKZjrYtFOiQZh7D
         cIm/O6DY/45/kgJeOxFaW6HS9oO66yZ6X0sZQesL8PER35fDh3SXwSf/9T/u00lo1N8H
         ByC0gqR/QAe0+itdnuZ/LWJpbvLTiJMzykQILz6uTF/mtv7MGiMR8/60Xx+dnGlVHF0C
         h4HuvDVRIKpoE2XYgFgaRWs7uYgJuDUM4JBH0RB/+/U1ztQ8rX5VbFWcSWjzRb5kG4Yq
         nHrEEClnc7DBmRLamUrpoDnsgsNFj6GKiJj8/lsPVVLY3PO/3OLm1f9kmvI+P4x7aUCd
         1iSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712564929; x=1713169729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eqf4RlGCPpFy6RShn6WYXNtP8jJeVY7I/inYXSrvjho=;
        b=edtfXb5tUCju/68aDeSa/uSQQ3h4RcuknauZBEYut7plq0OQIBA/9w2cI33myJ5Jqq
         xVk9JDFMlYe2b5TOXJYsvUODH/utNw8EvFGn8vkMtp38jQjyPkX588FzrE1C6/06KeVe
         C186OhJZbCfTP9fjtEZwPpBUZbcYq98pWF+o8H+mYeTAxJDJrwlTx9ZvidG5DsdPIJAV
         3sQJcZW0O/xJ/WSgaChZpVjAN2RuLm+3o4sJk1aHUPM4sfXRsRl5vJ8NKMZu5JxeIWKV
         is8MkoTFz5UTCIRjpmF5o25lOdJ5YuiAodiN+8U8oomOJHppDqesV7fJzXIY5K4cJH0p
         oWVA==
X-Forwarded-Encrypted: i=1; AJvYcCUy/2BA2fqjVvVhWMY+rQS3OrkvC4/QCBad/BmMsYzEx4s0tG6ze603/VBHUxw6waVkyaWhKb3gFENqZQ976O+sMMJL6CCj
X-Gm-Message-State: AOJu0Yx1AaZouBiSm6ClxLuIDk2y0RwKwR7ze+1/8NeqeIFA4IeKxdKa
	5c5uCvE5+h8QNTVlmo+mX/BLZrh6a3vEdc+Qlj1rFjl1IKEuJ7ghJSrvqzuHt32Z4+FgoKRGw/w
	R4RmAbY76rg==
X-Google-Smtp-Source: AGHT+IE00yu6Nvif3YMTdsYdtDgowDLKhP5gCwhld7NaV1ISRN6ILkT3UuHX6US4r3NLC2leAYYWo0eMf7xoEQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aca4:0:b0:dcc:94b7:a7a3 with SMTP id
 x36-20020a25aca4000000b00dcc94b7a7a3mr654445ybi.12.1712564929122; Mon, 08 Apr
 2024 01:28:49 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:28:43 +0000
In-Reply-To: <20240408082845.3957374-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408082845.3957374-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408082845.3957374-2-edumazet@google.com>
Subject: [PATCH net 1/3] net: add copy_safe_from_sockptr() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

copy_from_sockptr() helper is unsafe, unless callers
did the prior check against user provided optlen.

Too many callers get this wrong, lets add a helper to
fix them and avoid future copy/paste bugs.

Instead of :

   if (optlen < sizeof(opt)) {
       err = -EINVAL;
       break;
   }
   if (copy_from_sockptr(&opt, optval, sizeof(opt)) {
       err = -EFAULT;
       break;
   }

Use :

   err = copy_safe_from_sockptr(&opt, sizeof(opt),
                                optval, optlen);
   if (err)
       break;

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/sockptr.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 307961b41541a620023ad40d3178d47b94768126..b272d6866c87d837e340ce9e78e8fb3423efbddf 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -50,11 +50,36 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
 	return 0;
 }
 
+/* Deprecated.
+ * This is unsafe, unless caller checked user provided optlen.
+ * Prefer copy_safe_from_sockptr() instead.
+ */
 static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
 {
 	return copy_from_sockptr_offset(dst, src, 0, size);
 }
 
+/**
+ * copy_safe_from_sockptr: copy a struct from sockptr
+ * @dst:   Destination address, in kernel space. This buffer must be @ksize
+ *         bytes long.
+ * @ksize: Size of @dst struct.
+ * @optval: Source address. (in user or kernel space)
+ * @optlen: Size of @optval data.
+ *
+ * Returns
+ *  * -EINVAL: @optlen < @ksize
+ *  * -EFAULT: access to userspace failed.
+ *  * 0 : @ksize bytes were copied
+ */
+static inline int copy_safe_from_sockptr(void *dst, size_t ksize,
+					 sockptr_t optval, unsigned int optlen)
+{
+	if (optlen < ksize)
+		return -EINVAL;
+	return copy_from_sockptr(dst, optval, ksize);
+}
+
 static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
 		sockptr_t src, size_t usize)
 {
-- 
2.44.0.478.gd926399ef9-goog


