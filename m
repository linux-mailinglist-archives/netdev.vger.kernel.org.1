Return-Path: <netdev+bounces-13610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612E73C44E
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 00:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1CD1C213B1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185566AAA;
	Fri, 23 Jun 2023 22:55:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC46AA6
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 22:55:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C7C270E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687560928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96le6Nv7f7Jm2em1nCUehde2Ld5Ng9GbgAM0NyDY2H8=;
	b=irqyeMHGueA41WpjvkmmFLE373NjfuT8TSLHIg8Heb7miYm/ivTRYr+h7c3zDBwQ1XCrej
	yNOyqHClanlJidBB1XaFcwPSFF7yvrnj0Qnt5BtrprPP/QvT8wos3RPkfmU2QASGB+WHLS
	17feecjMBkMlnbzXkKzupeFNwqdQT58=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-JAj_tgg_MAmagZcoZ9ODJA-1; Fri, 23 Jun 2023 18:55:25 -0400
X-MC-Unique: JAj_tgg_MAmagZcoZ9ODJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C11F21C05ED2;
	Fri, 23 Jun 2023 22:55:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 594DEF5ADA;
	Fri, 23 Jun 2023 22:55:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 02/16] net: Use sendmsg(MSG_SPLICE_PAGES) not sendpage in skb_send_sock()
Date: Fri, 23 Jun 2023 23:54:59 +0100
Message-ID: <20230623225513.2732256-3-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use sendmsg() with MSG_SPLICE_PAGES rather than sendpage in
skb_send_sock().  This causes pages to be spliced from the source iterator
if possible.

This allows ->sendpage() to be replaced by something that can handle
multiple multipage folios in a single transaction.

Note that this could perhaps be improved to fill out a bvec array with all
the frags and then make a single sendmsg call, possibly sticking the header
on the front also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: netdev@vger.kernel.org
---

Notes:
    ver #2)
     - Wrap lines at 80.

 net/core/skbuff.c | 50 ++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index fee2b1c105fe..6c5915efbc17 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2989,32 +2989,32 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(skb_splice_bits);
 
-static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg,
-			    struct kvec *vec, size_t num, size_t size)
+static int sendmsg_locked(struct sock *sk, struct msghdr *msg)
 {
 	struct socket *sock = sk->sk_socket;
+	size_t size = msg_data_left(msg);
 
 	if (!sock)
 		return -EINVAL;
-	return kernel_sendmsg(sock, msg, vec, num, size);
+
+	if (!sock->ops->sendmsg_locked)
+		return sock_no_sendmsg_locked(sk, msg, size);
+
+	return sock->ops->sendmsg_locked(sk, msg, size);
 }
 
-static int sendpage_unlocked(struct sock *sk, struct page *page, int offset,
-			     size_t size, int flags)
+static int sendmsg_unlocked(struct sock *sk, struct msghdr *msg)
 {
 	struct socket *sock = sk->sk_socket;
 
 	if (!sock)
 		return -EINVAL;
-	return kernel_sendpage(sock, page, offset, size, flags);
+	return sock_sendmsg(sock, msg);
 }
 
-typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg,
-			    struct kvec *vec, size_t num, size_t size);
-typedef int (*sendpage_func)(struct sock *sk, struct page *page, int offset,
-			     size_t size, int flags);
+typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
 static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
-			   int len, sendmsg_func sendmsg, sendpage_func sendpage)
+			   int len, sendmsg_func sendmsg)
 {
 	unsigned int orig_len = len;
 	struct sk_buff *head = skb;
@@ -3034,8 +3034,9 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		memset(&msg, 0, sizeof(msg));
 		msg.msg_flags = MSG_DONTWAIT;
 
-		ret = INDIRECT_CALL_2(sendmsg, kernel_sendmsg_locked,
-				      sendmsg_unlocked, sk, &msg, &kv, 1, slen);
+		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
+		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
+				      sendmsg_unlocked, sk, &msg);
 		if (ret <= 0)
 			goto error;
 
@@ -3066,11 +3067,18 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 		slen = min_t(size_t, len, skb_frag_size(frag) - offset);
 
 		while (slen) {
-			ret = INDIRECT_CALL_2(sendpage, kernel_sendpage_locked,
-					      sendpage_unlocked, sk,
-					      skb_frag_page(frag),
-					      skb_frag_off(frag) + offset,
-					      slen, MSG_DONTWAIT);
+			struct bio_vec bvec;
+			struct msghdr msg = {
+				.msg_flags = MSG_SPLICE_PAGES | MSG_DONTWAIT,
+			};
+
+			bvec_set_page(&bvec, skb_frag_page(frag), slen,
+				      skb_frag_off(frag) + offset);
+			iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,
+				      slen);
+
+			ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
+					      sendmsg_unlocked, sk, &msg);
 			if (ret <= 0)
 				goto error;
 
@@ -3107,16 +3115,14 @@ static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
 int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
 			 int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, kernel_sendmsg_locked,
-			       kernel_sendpage_locked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_locked);
 }
 EXPORT_SYMBOL_GPL(skb_send_sock_locked);
 
 /* Send skb data on a socket. Socket must be unlocked. */
 int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len)
 {
-	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked,
-			       sendpage_unlocked);
+	return __skb_send_sock(sk, skb, offset, len, sendmsg_unlocked);
 }
 
 /**


