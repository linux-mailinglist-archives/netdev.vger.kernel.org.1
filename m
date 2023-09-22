Return-Path: <netdev+bounces-35809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58AC7AB1A6
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 14:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6AACD282BD9
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6622EFE;
	Fri, 22 Sep 2023 12:03:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BED2032C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 12:03:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CE5CC8
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 05:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695384189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEnm3txfdKWMLGG8rrdFEcQBV2WWgkp8Kq4P7DhBB1I=;
	b=IU+bLF0P4OVRiEvSTMiOU07+eizfq7cWE1QQmQBX0IH7ZAFHsKotNfeqOZZc4TldU2Hnff
	K+aJWUf8/l5gv6NGQYwTQneQrfDjQ75bPpLM+kU2pBIwceZ3reK+DdDixiCtTbA83UrY8o
	co99U5KCufnEvp9LCfXLqxvNWscTDes=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-_gvf6TzuMjGxNRBZi_i66w-1; Fri, 22 Sep 2023 08:03:03 -0400
X-MC-Unique: _gvf6TzuMjGxNRBZi_i66w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BC2B185A790;
	Fri, 22 Sep 2023 12:03:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A4EC20268D7;
	Fri, 22 Sep 2023 12:03:00 +0000 (UTC)
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v6 12/13] iov_iter, net: Merge csum_and_copy_from_iter{,_full}() together
Date: Fri, 22 Sep 2023 13:02:26 +0100
Message-ID: <20230922120227.1173720-13-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-1-dhowells@redhat.com>
References: <20230922120227.1173720-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Move csum_and_copy_from_iter_full() out of line and then merge
csum_and_copy_from_iter() into its only caller.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
cc: netdev@vger.kernel.org
---
 include/linux/skbuff.h | 19 ++-----------------
 net/core/datagram.c    |  5 +++++
 net/core/skbuff.c      | 20 +++++++++++++-------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c81ef5d76953..be402f55f6d6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3679,23 +3679,8 @@ static inline int __must_check skb_put_padto(struct sk_buff *skb, unsigned int l
 	return __skb_put_padto(skb, len, true);
 }
 
-struct csum_state {
-	__wsum csum;
-	size_t off;
-};
-
-size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
-
-static __always_inline __must_check
-bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
-				  __wsum *csum, struct iov_iter *i)
-{
-	size_t copied = csum_and_copy_from_iter(addr, bytes, csum, i);
-	if (likely(copied == bytes))
-		return true;
-	iov_iter_revert(i, copied);
-	return false;
-}
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i)
+	__must_check;
 
 static inline int skb_add_data(struct sk_buff *skb,
 			       struct iov_iter *from, int copy)
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 452620dd41e4..722311eeee18 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -738,6 +738,11 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
 	return 0;
 }
 
+struct csum_state {
+	__wsum csum;
+	size_t off;
+};
+
 static size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 				    struct iov_iter *i)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 3efed86321db..2bfa6a7ba244 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6955,13 +6955,19 @@ size_t copy_from_user_iter_csum(void __user *iter_from, size_t progress,
 	return next ? 0 : len;
 }
 
-size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
-			       struct iov_iter *i)
+bool csum_and_copy_from_iter_full(void *addr, size_t bytes,
+				  __wsum *csum, struct iov_iter *i)
 {
+	size_t copied;
+
 	if (WARN_ON_ONCE(!i->data_source))
-		return 0;
-	return iterate_and_advance2(i, bytes, addr, csum,
-				    copy_from_user_iter_csum,
-				    memcpy_from_iter_csum);
+		return false;
+	copied = iterate_and_advance2(i, bytes, addr, csum,
+				      copy_from_user_iter_csum,
+				      memcpy_from_iter_csum);
+	if (likely(copied == bytes))
+		return true;
+	iov_iter_revert(i, copied);
+	return false;
 }
-EXPORT_SYMBOL(csum_and_copy_from_iter);
+EXPORT_SYMBOL(csum_and_copy_from_iter_full);


