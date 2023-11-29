Return-Path: <netdev+bounces-52024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12B47FCFE1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 08:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0332828B2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2C10977;
	Wed, 29 Nov 2023 07:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MX/XF/u5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3E19BA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cfe0b63eeeso52178757b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 23:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701242883; x=1701847683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWrUAHj+LREfhagj/5p9N1CYzQOlzwvf0m0DD/YzVk4=;
        b=MX/XF/u5RVZ8QHQ/Rj1xs/ebz6hgdyBN0znJDl3YqDWztmZ8n4chBnZ6HbRqL/xo7a
         i5vNClgkov+EI/o49bnTGP1PQs8lKyKDrCdu7He/1BzeTA31ASi/QWk1sK4EVAO3l9+Z
         q2dvp9Kg1c8QF2KE7ZqDF9GMG6/lXWgFwIziuxIHMjqzs+hBw19P09QM4Z/IWna0u3pa
         /RiSFGnCn1aDliOAXSH2AxmO8S30HCu5Nvd7FB/e705gizJO7HUVV6PAzXMDK2kuW4p9
         KCNeJDHacDZ7CIOqukafB0+8D8ZqRsc5YZs7p90bs5Y0+yur17qQ0m/XFeEbhJBD25MV
         t+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701242883; x=1701847683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWrUAHj+LREfhagj/5p9N1CYzQOlzwvf0m0DD/YzVk4=;
        b=xVZ7e1qYnY1ztkgybeLFWsjSYfu1CUtpR1eqf1JnQMawREzsAGJVk9Jo+FkPByJ5mQ
         a+kYqYxrUQ5klwBDlsyMg/cDEdqufoKglcl6IPCVbtfgZSkGUEOdwaVzcECj574G3f8j
         iZAJDw77Ok4p2Y6CqwDE9+uvwMcfvpPQTtJjxoYaExQVQalHKlTT1eT/mbyrcgCI+uUW
         miKbW37uZO1Wd+j4p7gaxjOSGjXRdjmlnUygC+vfrlsCU3c7sKQ/01iwECFwODHdrp1D
         xWhv22pfsdH32mwHdQJvEraAm6MbFOaCfgtGx39lzGeSoWqfCQ3r1oNuUlrWiuyuDo3F
         pyaA==
X-Gm-Message-State: AOJu0YwL6JqesVE+C7MJd6TAqdrawJEm3I3pvYLkbECresKE/7oon9Ve
	qDO2DG04XWXlsckvFAk6TCeL8w3oob3Z+K4=
X-Google-Smtp-Source: AGHT+IE9ZnYIk2DbdqYd7pRsU0JXQqpvCSAcYhourcDdEMWawiCZqJA5eabGLsZ/IbXAp7b7OoVjU9FSmfJlfh4=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:690c:340b:b0:5cb:73ab:3e4d with SMTP
 id fn11-20020a05690c340b00b005cb73ab3e4dmr489228ywb.6.1701242883083; Tue, 28
 Nov 2023 23:28:03 -0800 (PST)
Date: Wed, 29 Nov 2023 07:27:53 +0000
In-Reply-To: <20231129072756.3684495-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129072756.3684495-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129072756.3684495-3-lixiaoyan@google.com>
Subject: [PATCH v8 net-next 2/5] cache: enforce cache groups
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Set up build time warnings to safeguard against future header changes of
organized structs.

Warning includes:

1) whether all variables are still in the same cache group
2) whether all the cache groups have the sum of the members size (in the
   maximum condition, including all members defined in configs)

The __cache_group* variables are ignored in kernel-doc check in the
various header files they appear in to enforce the cache groups.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Coco Li <lixiaoyan@google.com>
---
 include/linux/cache.h | 25 +++++++++++++++++++++++++
 scripts/kernel-doc    |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 9900d20b76c28..0ecb17bb68837 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -85,6 +85,31 @@
 #define cache_line_size()	L1_CACHE_BYTES
 #endif
 
+#ifndef __cacheline_group_begin
+#define __cacheline_group_begin(GROUP) \
+	__u8 __cacheline_group_begin__##GROUP[0]
+#endif
+
+#ifndef __cacheline_group_end
+#define __cacheline_group_end(GROUP) \
+	__u8 __cacheline_group_end__##GROUP[0]
+#endif
+
+#ifndef CACHELINE_ASSERT_GROUP_MEMBER
+#define CACHELINE_ASSERT_GROUP_MEMBER(TYPE, GROUP, MEMBER) \
+	BUILD_BUG_ON(!(offsetof(TYPE, MEMBER) >= \
+		       offsetofend(TYPE, __cacheline_group_begin__##GROUP) && \
+		       offsetofend(TYPE, MEMBER) <= \
+		       offsetof(TYPE, __cacheline_group_end__##GROUP)))
+#endif
+
+#ifndef CACHELINE_ASSERT_GROUP_SIZE
+#define CACHELINE_ASSERT_GROUP_SIZE(TYPE, GROUP, SIZE) \
+	BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP) - \
+		     offsetofend(TYPE, __cacheline_group_begin__##GROUP) > \
+		     SIZE)
+#endif
+
 /*
  * Helper to add padding within a struct to ensure data fall into separate
  * cachelines.
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 08a3e603db192..0a890fe4d22b1 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1592,6 +1592,11 @@ sub push_parameter($$$$$) {
 		$parameterdescs{$param} = "anonymous\n";
 		$anon_struct_union = 1;
 	}
+	elsif ($param =~ "__cacheline_group" )
+	# handle cache group enforcing variables: they do not need be described in header files
+	{
+		return; # ignore __cacheline_group_begin and __cacheline_group_end
+	}
 
 	# warn if parameter has no description
 	# (but ignore ones starting with # as these are not parameters
-- 
2.43.0.rc1.413.gea7ed67945-goog


