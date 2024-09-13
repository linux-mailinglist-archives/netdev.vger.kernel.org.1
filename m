Return-Path: <netdev+bounces-128235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC9978AAB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA18928A26E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80615B0EE;
	Fri, 13 Sep 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoFQYjQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D16156236
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263237; cv=none; b=LPC7GRp6mRv/PSoFt2DNqWJutGRFNn31HGWa3Ab6KN9EuNQYD91j0RUOljVznA/a9q0iz5CwKSaFTDuaiZkiuS4O1Jad/TGvfcoR3lnsUqcAjvHDrNOer/+tuUqpSxNjtrCA6qtar18HphjxapHWJxmL3/bp86NprRxwqEphhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263237; c=relaxed/simple;
	bh=MkfVfrMFBKZhPzzuv+Q0xVR3iXUZ+B4XFBxm6rOnls0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cQ9YMFDvYWuSUGxUznTzmsCoOXyresUvgClH5tp8s6gv3fRfzoahhYMCdYQ9JhcvCZmaObhpHmlvVygxzu79D71HDSU48rTQom2Xj7qxUPm6f4NUFkPEqqgJwxN3WzhT8q4UEfoM28/T7ASkuH6b20zGh5VGER1LfMGfAQesXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoFQYjQl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e178e745c49so3683321276.2
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726263234; x=1726868034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2T8h7PkrQu/P499dIgiz7AXqfHfFO+K5APloBO//pM=;
        b=QoFQYjQl1+5kVQKjtEzm2JVSsopQvSglmU5Q7R2QcEcycNjdPMo01NbasT8U4dK3aq
         7Vm+wXO5bhQb4dvmaSC1UyigjIy4S7d4zdt5qgWi0kZHi7R9uNlthux8EdlLOwAn3RWS
         kk99W1ntSiv5iC1w3bl6ge6YaZjGdJrxaYBi1TkxiqrnRsLk0KWwJbFp4VpKm8/LWpL4
         ai27a1ZQhcohisdk6R6F4RzOus4paD7pdZPZoJvywfe1Ps5TdxP0uIcaFLsgot7y5Wia
         tja+8MJ4xYy2SKDwU/F9M0Y4mPF/GiEK1/0zM6faXGsc9bFnQ0S3ccQRSlRncCUdKV0Y
         s7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263234; x=1726868034;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2T8h7PkrQu/P499dIgiz7AXqfHfFO+K5APloBO//pM=;
        b=DPvRsqg/yZuDxVo6zgvbJAoyvgggYRHx4aB1olJsToIt84TdCdc1gx/afnzAmp+6Tw
         Glc8MnlW1ra8fZ1cg+3LKq55VNuMqEe4lsZIwZiubokNSJp7767tEzY/67d9d7hfTd0n
         9EcgU/hBmQdxgaCyTzfKQeOxmOzYxXwIHifk3K8atrDlRbNUR9Dx+bXVRUDMVUESpgNr
         IlT3mU2XhWtdrkuxR+DoB2h45m00KcaQItRG2uPGWlvLAMCAr58VNU4aawz+O0IYBscB
         yaGbOTNodGNOpkaIPzaCHbL8OrYv8ElCVCBIfjwPLKmDoX83sAcUiYQIMPF/MA2E4Fn8
         lNxQ==
X-Gm-Message-State: AOJu0Ywv/22il1nrsTOE5EShWuu1YMvrFSEEd0Eg6PSOsP4mXi5BAkj5
	e8q7+hlNCDsxwZgvFXzD4EQMD6+gPzLdFs14NcXNVfZkKthmR2+PjWMhLyOPe+6oll4cazlGsVV
	pEbSYcbZRFzTtL6nuXYMp15Pd80wYC7re9KNnO1pYGpExV0mkjUbheKRYutd38xCxmsy/ezHEI7
	/J6Xg3BrKvRRe1ZVRSuqWsse7Cljyk/AbkKjFLpiImaXJhVzWxDm1BrlD6pBE=
X-Google-Smtp-Source: AGHT+IGKRzJx5PjSFO3E8tqWdgVC95OAYqJ2OCpdJ9chaj4/FshFhL9QqOypm1YXq6OH+fxO5D7luhUe9GMEMnCStg==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:cec3:0:b0:e1a:44fa:f09 with SMTP
 id 3f1490d57ef6-e1d9db95493mr10461276.2.1726263233997; Fri, 13 Sep 2024
 14:33:53 -0700 (PDT)
Date: Fri, 13 Sep 2024 21:33:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913213351.3537411-1-almasrymina@google.com>
Subject: [PATCH net-next v2] page_pool: fix build on powerpc with GCC 14
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

Building net-next with powerpc with GCC 14 compiler results in this
build error:

/home/sfr/next/tmp/ccuSzwiR.s: Assembler messages:
/home/sfr/next/tmp/ccuSzwiR.s:2579: Error: operand out of domain (39 is
not a multiple of 4)
make[5]: *** [/home/sfr/next/next/scripts/Makefile.build:229:
net/core/page_pool.o] Error 1

Root caused in this thread:
https://lore.kernel.org/netdev/913e2fbd-d318-4c9b-aed2-4d333a1d5cf0@cs-soprasteria.com/

We try to access offset 40 in the pointer returned by this function:

static inline unsigned long _compound_head(const struct page *page)
{
        unsigned long head = READ_ONCE(page->compound_head);

        if (unlikely(head & 1))
                return head - 1;
        return (unsigned long)page_fixed_fake_head(page);
}

The GCC 14 (but not 11) compiler optimizes this by doing:

ld page + 39

Rather than:

ld (page - 1) + 40

And causing an unaligned load. Get around this by issuing a READ_ONCE as
we convert the page to netmem.  That disables the compiler optimizing the
load in this way.

Cc: Simon Horman <horms@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Matthew Wilcox <willy@infradead.org>

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2: https://lore.kernel.org/netdev/20240913192036.3289003-1-almasrymina@google.com/

- Work around this issue as we convert the page to netmem, instead of
  a generic change that affects compound_head().
---
 net/core/page_pool.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..74ea491d0ab2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -859,12 +859,25 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 {
 	int i, bulk_len = 0;
 	bool allow_direct;
+	netmem_ref netmem;
+	struct page *page;
 	bool in_softirq;
 
 	allow_direct = page_pool_napi_local(pool);
 
 	for (i = 0; i < count; i++) {
-		netmem_ref netmem = page_to_netmem(virt_to_head_page(data[i]));
+		page = virt_to_head_page(data[i]);
+
+		/* GCC 14 powerpc compiler will optimize reads into the
+		 * resulting netmem_ref into unaligned reads as it sees address
+		 * arithmetic in _compound_head() call that the page has come
+		 * from.
+		 *
+		 * The READ_ONCE here gets around that by breaking the
+		 * optimization chain between the address arithmetic and later
+		 * indexing.
+		 */
+		netmem = page_to_netmem(READ_ONCE(page));
 
 		/* It is not the last user for the page frag case */
 		if (!page_pool_is_last_ref(netmem))
-- 
2.46.0.662.g92d0881bb0-goog


