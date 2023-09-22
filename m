Return-Path: <netdev+bounces-35799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55C7AB19C
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 14:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C45DA282B33
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFA7200DC;
	Fri, 22 Sep 2023 12:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9896C200D9
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 12:02:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE7199
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695384162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQ7llY41C7nXc6PO5+rWDb67yJZYIoiIAsyEYwhjg+w=;
	b=e4BWwMdFAmBmYinrIhys6uhQmYkJq05vmQkSqm/9gvpi6HiiEV890HzY1s1x4Nf4xhco2u
	cUY2Zlsj45d80Q7N6RqiU9sv73kU7M6b0sS2Sh7p0Ful/tFu7qlvk6/QO2KutHwkvWThMN
	HufAtXu2ZkfXmlbh87Zy588pSS9dskc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-8-QZXS7iNU2GtXgc29v2FQ-1; Fri, 22 Sep 2023 08:02:37 -0400
X-MC-Unique: 8-QZXS7iNU2GtXgc29v2FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E637185A78E;
	Fri, 22 Sep 2023 12:02:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DF47A40C6EBF;
	Fri, 22 Sep 2023 12:02:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <christian@brauner.io>,
	David Laight <David.Laight@ACULAB.COM>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v6 02/13] iov_iter: Be consistent about the __user tag on copy_mc_to_user()
Date: Fri, 22 Sep 2023 13:02:16 +0100
Message-ID: <20230922120227.1173720-3-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-1-dhowells@redhat.com>
References: <20230922120227.1173720-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

copy_mc_to_user() has the destination marked __user on powerpc, but not on
x86; the latter results in a sparse warning in lib/iov_iter.c.

Fix this by applying the tag on x86 too.

Fixes: ec6347bb4339 ("x86, powerpc: Rename memcpy_mcsafe() to copy_mc_to_{user, kernel}()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dan Williams <dan.j.williams@intel.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 arch/x86/include/asm/uaccess.h | 2 +-
 arch/x86/lib/copy_mc.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 8bae40a66282..5c367c1290c3 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -496,7 +496,7 @@ copy_mc_to_kernel(void *to, const void *from, unsigned len);
 #define copy_mc_to_kernel copy_mc_to_kernel
 
 unsigned long __must_check
-copy_mc_to_user(void *to, const void *from, unsigned len);
+copy_mc_to_user(void __user *to, const void *from, unsigned len);
 #endif
 
 /*
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index 80efd45a7761..6e8b7e600def 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -70,23 +70,23 @@ unsigned long __must_check copy_mc_to_kernel(void *dst, const void *src, unsigne
 }
 EXPORT_SYMBOL_GPL(copy_mc_to_kernel);
 
-unsigned long __must_check copy_mc_to_user(void *dst, const void *src, unsigned len)
+unsigned long __must_check copy_mc_to_user(void __user *dst, const void *src, unsigned len)
 {
 	unsigned long ret;
 
 	if (copy_mc_fragile_enabled) {
 		__uaccess_begin();
-		ret = copy_mc_fragile(dst, src, len);
+		ret = copy_mc_fragile((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
 	if (static_cpu_has(X86_FEATURE_ERMS)) {
 		__uaccess_begin();
-		ret = copy_mc_enhanced_fast_string(dst, src, len);
+		ret = copy_mc_enhanced_fast_string((__force void *)dst, src, len);
 		__uaccess_end();
 		return ret;
 	}
 
-	return copy_user_generic(dst, src, len);
+	return copy_user_generic((__force void *)dst, src, len);
 }


