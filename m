Return-Path: <netdev+bounces-148603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C529E296D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AE6162BF7
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B631FAC49;
	Tue,  3 Dec 2024 17:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3EPfPRkn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E51F76CE
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247382; cv=none; b=Xf2lMa6PqIX7x1liVASwEy1R2lamuSTr8yaUKkRdalqEq9jQjmxHMwffjLWDAQlEnyKQIfB4BeZmuIxjygbEDXNw3uHBXhfAqoOXQK+U3fjdIeKedSgdWGgcUqq6x0Cp9HwYpUlYy/+A9oe14kf9ja+iTWvz+7rBymjvQNh0oSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247382; c=relaxed/simple;
	bh=PHYBsi7jyDAeU4n8cwu3t4Nr0+sKhKxPopmY7e4LNIo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jl3zjfRlf/l5xDMtjEk2k0IldA5Xr24fQRfLcBu7/HPmytvrBErjjY+mred0zR1syDDqBbpla4tePOLj2P9GvG79YESTBzuANKZ33ru+d1JpI2wg1DU1vMs/WTDIgI+9UCyP44Fg4d2QW+t3C078jPEUD3OTpULDlXsxSiR/200=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3EPfPRkn; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b69c165621so359359585a.0
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733247379; x=1733852179; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XnIKdDm69+K/wCTqYJ2JAyW89fU9l94WPOs9w5mh8gI=;
        b=3EPfPRkncVYYmYBVh+FC72hvchFtKQx5GXxhyIKIYxuaSCGIiRSBf0FyR32UEPR+PO
         qSVA2aM4OTYoUIn6320WOulKpsWEqE6O27efWKA/j0gVTcjw90MGnxSWKWvQ2NcwMvJJ
         BJ+qD6QUgfxexgy+Iht73jknxt1woPuWbZrSHPfj4jYGPjgjFEY/y05NtgixUKZhZYR4
         DkaMn52aah9U0kQ5pOzL9jAFCxjPpT0Q+7ITXXw9cpma3lSaYc1JOmZanjKs56DQ5Hzh
         Ssec0NPjuYOfk45Vto8zDJrOa1Di5pUUhSO19s2Bb7OSVgMo0adMjF2lie+ghVLRhbZ7
         CLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733247379; x=1733852179;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnIKdDm69+K/wCTqYJ2JAyW89fU9l94WPOs9w5mh8gI=;
        b=fMO5a6FdTzkSYySa2XYYSUmP/dtnas/t8vWypnMpjaqbrMHze8Af0m8eR7AHrpglaO
         kLrChsd8RJb3tZvl+PgRbMHNE4CRXVAdYj8K+4IlxCIlwblh9Ga47+YLRcg3CIBbK3Jp
         KWP3X6AlV6mWZy1N52cHf9nJKaaO3A835FhnyB6j0oXxzSlU3bqNEoTeJxi75cDPlu/0
         yiJQG+JmCNxXQWrekVlhMxPaAJThJpQZsCcibnLEQquwnOuYEAa21OWvAOlZV7fIrFuu
         679RvdIE5Kn2OIFwwBnv0OPPL4iNCIooAKzT2TNOCpDYZFqvo2TINuhAUyxfc+i1QoGy
         jgBg==
X-Gm-Message-State: AOJu0Yx3QqpDMIfErL3zBs9rUyZRPV9X7zYQVlCfYcF0kB3AK7ee7+uZ
	o8FrlUnF+MvRcYDMhRUmEfGqESPS9138mVe9RAMgMMv4v5u7UpG3/I7KJVnC8iEdhuWtYyqvsQR
	N/TPbNgqgsg==
X-Google-Smtp-Source: AGHT+IE7m1MHgecjn80GG002QWqO6t5LnIqSyaKzJ2epoI9gcy+eE3w+70vedzC7mhn5TXQ8N04A36BJ5j07Mw==
X-Received: from qtbcb20.prod.google.com ([2002:a05:622a:1f94:b0:466:8c54:dc8e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4103:b0:7b1:45be:2e80 with SMTP id af79cd13be357-7b6ab9a158dmr167167585a.0.1733247379133;
 Tue, 03 Dec 2024 09:36:19 -0800 (PST)
Date: Tue,  3 Dec 2024 17:36:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203173617.2595451-1-edumazet@google.com>
Subject: [PATCH net-next] inet: add indirect call wrapper for getfrag() calls
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"

UDP send path suffers from one indirect call to ip_generic_getfrag()

We can use INDIRECT_CALL_1() to avoid it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Willem de Bruijn <willemb@google.com>
Cc: Brian Vazquez <brianvv@google.com>
---
 net/ipv4/ip_output.c  | 13 +++++++++----
 net/ipv6/ip6_output.c | 13 ++++++++-----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c947078bea210c9abe5c80fa0e0ab4f..a59204a8d85053a9b8c9e86a404aa4bf2f0d2416 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1169,7 +1169,10 @@ static int __ip_append_data(struct sock *sk,
 			/* [!] NOTE: copy will be negative if pagedlen>0
 			 * because then the equation reduces to -fraggap.
 			 */
-			if (copy > 0 && getfrag(from, data + transhdrlen, offset, copy, fraggap, skb) < 0) {
+			if (copy > 0 &&
+			    INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
+					    from, data + transhdrlen, offset,
+					    copy, fraggap, skb) < 0) {
 				err = -EFAULT;
 				kfree_skb(skb);
 				goto error;
@@ -1213,8 +1216,9 @@ static int __ip_append_data(struct sock *sk,
 			unsigned int off;
 
 			off = skb->len;
-			if (getfrag(from, skb_put(skb, copy),
-					offset, copy, off, skb) < 0) {
+			if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
+					    from, skb_put(skb, copy),
+					    offset, copy, off, skb) < 0) {
 				__skb_trim(skb, off);
 				err = -EFAULT;
 				goto error;
@@ -1252,7 +1256,8 @@ static int __ip_append_data(struct sock *sk,
 				get_page(pfrag->page);
 			}
 			copy = min_t(int, copy, pfrag->size - pfrag->offset);
-			if (getfrag(from,
+			if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
+				    from,
 				    page_address(pfrag->page) + pfrag->offset,
 				    offset, copy, skb->len, skb) < 0)
 				goto error_efault;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7b4608bb316ed2114a0e626aad530b62b767fc1..3d672dea9f56284e7a8ebabec037e04e7f3d19f4 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1697,8 +1697,9 @@ static int __ip6_append_data(struct sock *sk,
 				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 			if (copy > 0 &&
-			    getfrag(from, data + transhdrlen, offset,
-				    copy, fraggap, skb) < 0) {
+			    INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
+					   from, data + transhdrlen, offset,
+					   copy, fraggap, skb) < 0) {
 				err = -EFAULT;
 				kfree_skb(skb);
 				goto error;
@@ -1742,8 +1743,9 @@ static int __ip6_append_data(struct sock *sk,
 			unsigned int off;
 
 			off = skb->len;
-			if (getfrag(from, skb_put(skb, copy),
-						offset, copy, off, skb) < 0) {
+			if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
+					    from, skb_put(skb, copy),
+					    offset, copy, off, skb) < 0) {
 				__skb_trim(skb, off);
 				err = -EFAULT;
 				goto error;
@@ -1781,7 +1783,8 @@ static int __ip6_append_data(struct sock *sk,
 				get_page(pfrag->page);
 			}
 			copy = min_t(int, copy, pfrag->size - pfrag->offset);
-			if (getfrag(from,
+			if (INDIRECT_CALL_1(getfrag, ip_generic_getfrag,
+				    from,
 				    page_address(pfrag->page) + pfrag->offset,
 				    offset, copy, skb->len, skb) < 0)
 				goto error_efault;
-- 
2.47.0.338.g60cca15819-goog


