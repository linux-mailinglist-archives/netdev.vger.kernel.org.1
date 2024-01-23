Return-Path: <netdev+bounces-65254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B4839BF9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 23:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCE41C2577A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8424D4F61B;
	Tue, 23 Jan 2024 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvAyWCgT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362EE4F217
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048279; cv=none; b=NR7zU970z8SdZuaQmkJC9JoS+EbW/fVeJv/wA00s68/4w8sogLe6NaqBnuuzINdKDWRskpvlWmk+D1qUXYB2zr9PnXUTV9h7r0cHISyD+tMA/UL7dO2Av2G43IlxBqkBuwQTSQilQhzhrqZ7FAfJ+Wo3NGskQbnAL7S2j/I3NGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048279; c=relaxed/simple;
	bh=eQc/0XprESJCX8/SL8NWCcerd2+39PRmvZ4jwBgHHms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kB6Xt7LTBC4xPfoA9ULtufXQiscV9k4SPr8dTa2yuVBdIN6IGvYOBhErpuD5KM7gorrLPwCI9D0t7nlXK9c8CNrOR2zqN/09dbjvaiDxR9np3z3RXN3ircnqDOR8I13cq9seyNZBcYBTbtXAo5jJKX/iVxO1Pq9hlbSnSPd+Q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvAyWCgT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645a6790so3449833276.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 14:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706048276; x=1706653076; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sq2A5rdPoZzXe3JfsyjEi2DmgNcsMleYf8+7wJXU3oU=;
        b=bvAyWCgTdB7xqhlCHl4FccHzz0TK4HuT69XojP7Cihu+xUqrUNsjr6aNdFRlc0lsA6
         oVP+JJe+KMh22It+JjF8vj3488kwKDj6QU20MRaBCLEZ1i8xL+HzBcyLfACMM/GAmzkc
         KTaARTv6Pgz+NXkYt8/JkL35I0bDegpG5Eug7Ry8RDHnbw34yfpkPqaeKOO7bph7hcCb
         Hz3IzdfhsiEoI7zRO/kpcKycv9QKpLW7Gqcl/msLocu02G6gQCaYgUYPyWAzNu5qRZUj
         2Z7BEswmWXCYGl6FBdDwUgEIgTT8CGLjVoEGurlb5lE3NpvaAlXYiFfM8/E8QngSuMFR
         shoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706048276; x=1706653076;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sq2A5rdPoZzXe3JfsyjEi2DmgNcsMleYf8+7wJXU3oU=;
        b=VW7LSinO9H/qaSG7tjeq8CPOWkbIqavJRhwchifhgLAFiseCtqt1XrsBCjwcd1BGoV
         Qyppm+QUrVSwTg8DqMffqGIBIW7hMko2vTkKy5o/6SAJENOnL4lGQPLxiPhpzLCx5vSe
         Bqs14YysshAIBlfnlfvFxKdICBIhIGWOzzMbe2u2KAftoeyyaAnwPXDwFIKAT0EdEisU
         sJz3kBLHBtOlecjpjH0IwiXGxZ5QJ+tmiABAqhWrrCWZi2Lzq8G/d6RaEnRZ4KM3z38B
         4aKO3dbBQe/mkjBA0VNdPRZg+whMtmOLV+6vsbfqC7KrEA1TRNPWwDnBg50aPilTabLW
         FTJQ==
X-Gm-Message-State: AOJu0YzJSCQvBUy8nnxEBrtRyFzqH6/2/0tEYZ5IdhwZa1wJru97sJKs
	+BLTN7uZTJSq9ybMoUqxQibpmguIW8c09y5JGqczKN+XSt0HA698ZkmC4vLlLs6VFNV0kwxWwOa
	wqkCuSGWLSilOfmOWqFJWbw==
X-Google-Smtp-Source: AGHT+IH87J0v28hXMQrSfT2AvSQ99998vzYrtkl0Kh0l9IUSxf/Sr2m7Wvvoa8btav6qxFFlBuAzv1P6tFn0ptW02Q==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:3608:aa16:52d:3594])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:86:b0:dbe:a214:888c with SMTP
 id h6-20020a056902008600b00dbea214888cmr3189553ybs.11.1706048276193; Tue, 23
 Jan 2024 14:17:56 -0800 (PST)
Date: Tue, 23 Jan 2024 14:17:45 -0800
In-Reply-To: <20240123221749.793069-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123221749.793069-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123221749.793069-2-almasrymina@google.com>
Subject: [PATCH net-next v6 1/2] net: introduce abstraction for network memory
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add the netmem_ref type, an abstraction for network memory.

To add support for new memory types to the net stack, we must first
abstract the current memory type. Currently parts of the net stack
use struct page directly:

- page_pool
- drivers
- skb_frag_t

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for compiler type checking we need to introduce a new type.

netmem_ref is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page
underneath. In parallel there is an undergoing effort to add support
for devmem to the net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/

netmem_ref can be pointers to different underlying memory types, and the
low bits are set to indicate the memory type. Helpers are provided
to convert netmem pointers to the underlying memory type (currently only
struct page). In the devmem series helpers are provided so that calling
code can use netmem without worrying about the underlying memory type
unless absolutely necessary.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v6:
- Applied Reviewed-by from Shakeel.

rfc v5:
- RFC due to merge window.
- Change to 'typedef unsigned long __bitwise netmem_ref;'
- Fixed commit message (Shakeel).
- Did not apply Shakeel's reviewed-by since the code changed
  significantly.

v4:
- use 'struct netmem;' instead of 'typedef void *__bitwise netmem_ref;'

  Using __bitwise with a non-integer type was wrong and triggered many
  patchwork bot errors/warnings.

  Using an integer type causes the compiler to warn when casting NULL to
  the integer type.

  Attempt to use an empty struct for our opaque network memory.

v3:

- Modify struct netmem from a union of struct page + new types to an opaque
  netmem_ref type.  I went with:

  +typedef void *__bitwise netmem_ref;

  rather than this that Jakub recommended:

  +typedef unsigned long __bitwise netmem_ref;

  Because with the latter the compiler issues warnings to cast NULL to
  netmem_ref. I hope that's ok.

- Add some function docs.

v2:

- Use container_of instead of a type cast (David).
---
 include/net/netmem.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 include/net/netmem.h

diff --git a/include/net/netmem.h b/include/net/netmem.h
new file mode 100644
index 000000000000..9f327d964782
--- /dev/null
+++ b/include/net/netmem.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ *	Network memory
+ *
+ *	Author:	Mina Almasry <almasrymina@google.com>
+ */
+
+#ifndef _NET_NETMEM_H
+#define _NET_NETMEM_H
+
+/**
+ * netmem_ref - a nonexistent type marking a reference to generic network
+ * memory.
+ *
+ * A netmem_ref currently is always a reference to a struct page. This
+ * abstraction is introduced so support for new memory types can be added.
+ *
+ * Use the supplied helpers to obtain the underlying memory pointer and fields.
+ */
+typedef unsigned long __bitwise netmem_ref;
+
+/* This conversion fails (returns NULL) if the netmem_ref is not struct page
+ * backed.
+ *
+ * Currently struct page is the only possible netmem, and this helper never
+ * fails.
+ */
+static inline struct page *netmem_to_page(netmem_ref netmem)
+{
+	return (__force struct page *)netmem;
+}
+
+/* Converting from page to netmem is always safe, because a page can always be
+ * a netmem.
+ */
+static inline netmem_ref page_to_netmem(struct page *page)
+{
+	return (__force netmem_ref)page;
+}
+
+#endif /* _NET_NETMEM_H */
-- 
2.43.0.429.g432eaa2c6b-goog


