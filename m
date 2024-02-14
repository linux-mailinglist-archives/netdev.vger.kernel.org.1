Return-Path: <netdev+bounces-71863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB67B855605
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6209DB2888B
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCD814533E;
	Wed, 14 Feb 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IN5K5B0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6997141996
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 22:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950052; cv=none; b=ZCjq+NdYcVRHWvefQGe4dyofJsRI5SisK3+Q35ox23RwbkYUE5NRcYWCo0UCD/rtG7CNqQ0iRb7hhbxZDmdr8kvEkilI0gJxuu1TP+jGrw9ugYWizOuAuyKoFsdJo4Ok8H4zYGQEtNWC3doAKP7jgO+TTV8nmqdT80rpm5PPXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950052; c=relaxed/simple;
	bh=leH3pMjjZZlhwesnoi+WanMfgfX5sx1qPhM1PONSqZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V2cETILpOOuznw1m1DaDXDcR2H0J23dCT/6gdn7DYneArrlnIZM8ifPLffui9isx8L/ByAoiqQDbLho9EeKDBK70FVu+7bg9Lq7B87cNh+POA2Bv801+hoYlR+SGqHCuMHDnxpC4SA/BCUAfGsMFeAR9GDqdwWQZYFvnNgjHcsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IN5K5B0c; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so237467276.2
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 14:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707950049; x=1708554849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ODLPgmrC2GnAqjAqHk0mi7EspXfDsuvboDPS66T9iTs=;
        b=IN5K5B0cEzU21QCY6eOP+j0ECMGQbimN5KIODDicQe7+nLpKdw52+9UdDdO77VUlVs
         4Tx/1wJmsgeCPfHH7Xy0nWbsS6xODiVqARX8g9bi6tgrdQWBznJ69E3N00+U4hEukuhY
         Br0rJvbhhVZf4+AtGLJca9hS2cSLNOnYK6PNtrt3Ze4uzhV5FLTGrD22qxNLnL8Y9XAo
         AZIR3TstcK05cz1NkO6qxKGPfny4kU6wZ12na2hFFz/a4VCVuAyKahxsrBQsq2Xbnz9B
         kW4bsah1mlEYjPi6clkeHf4DunzkuHCR/WCMLwRDwRkcpOmXDV70TVFtR5CnzSWnwFjI
         N0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707950049; x=1708554849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODLPgmrC2GnAqjAqHk0mi7EspXfDsuvboDPS66T9iTs=;
        b=aqPQWTdkVN6QYWp8qPzvWYf9dto04hcjWYHubpsse9o2PqjVxxMT6MSaTkOd4G66CM
         UkOlNGrZPF4+cbt3EhPe0j0iB/NtsTPCreJbGoLOqHtyk1KFxPNmAioxpDMozDADLucG
         tZG2bpx6257pxkgfJmIE9C1cGdH39M90lexOkbZevFE1C/YG86mBDIZPdKp25g1wx4Bp
         RKCRCzKhm1GcS7VoZgOjLbZpti8egknAnRk0lFnJwls7HL44hinRCbMoCu/VcgdBehaf
         hsGbDdBUPbFZuMfmEk1A76Tv9DfcfjoWAD98WiKsmfwXcz+hTvdJiUgUHVIaiXf3YCXr
         QJUw==
X-Forwarded-Encrypted: i=1; AJvYcCXS6ywxCgmPirJTHXfe4Z1i0UAkZV++4FuLgNMGOdkoeD+ilG+gss4x1kN5yQE0H8IURqsbJmlJfno3N2UCbD+eG1saGxCk
X-Gm-Message-State: AOJu0Yy4pwruBmgSQY3mOMM1HzUx3BfFuVvsjAvuuLK5Ip6d8jy4o3Pm
	U1CwqROMk5VTvxe3KbB3h7qgTnrwQ9adDQHWe1XA3AqvC8jm7Pq5BMbIe0JzJs22Z4HMLzhbzn+
	TPYnJJ79LVSjtW8VZerqlmQ==
X-Google-Smtp-Source: AGHT+IEdxuewwN8eca4ATiY9sKLns3Dxbq83VjZOnNMu8/lDGLoOd7qXkUWYU4F4N7m610kudwxHYWFgyVyvRObzuQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:e4bb:b13c:bc16:afe5])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:10c3:b0:dc6:ebd4:cca2 with
 SMTP id w3-20020a05690210c300b00dc6ebd4cca2mr97605ybu.11.1707950049630; Wed,
 14 Feb 2024 14:34:09 -0800 (PST)
Date: Wed, 14 Feb 2024 14:34:02 -0800
In-Reply-To: <20240214223405.1972973-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214223405.1972973-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214223405.1972973-2-almasrymina@google.com>
Subject: [PATCH net-next v8 1/2] net: introduce abstraction for network memory
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

v7:
- Fix netmem_ref kdoc.

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
index 000000000000..d8b810245c1d
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
+ * typedef netmem_ref - a nonexistent type marking a reference to generic
+ * network memory.
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
2.43.0.687.g38aa6559b0-goog


