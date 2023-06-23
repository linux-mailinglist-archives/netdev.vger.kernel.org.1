Return-Path: <netdev+bounces-13623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26773C49A
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 00:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD143281E8C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BEE1DDF2;
	Fri, 23 Jun 2023 22:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93006AAA
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 22:56:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75D2954
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687560961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qW7QONKdXKQCe18ckz4PBDuqjad2A9AyVw+035R3zM=;
	b=auIDuNcAGou0hGH/soGonz4YrtFmTjp8RcTaLywmr/okxyJUtRKK0vzW04uOJnfPUxKE0S
	4iIZLqnOkj/NxkAUS9OnF+skyRvZoLO9YhFH1yoLolfXZUe4At6SzamDLYrTkef+8VKgr+
	2BkwQoCg+RDiZ6VrYB6bziWtY09Wigo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-a9340YSgPS-PNmqg9L7xcg-1; Fri, 23 Jun 2023 18:55:57 -0400
X-MC-Unique: a9340YSgPS-PNmqg9L7xcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 548C490ED21;
	Fri, 23 Jun 2023 22:55:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89A49C1ED97;
	Fri, 23 Jun 2023 22:55:54 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@oss.oracle.com
Subject: [PATCH net-next v5 14/16] ocfs2: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()
Date: Fri, 23 Jun 2023 23:55:11 +0100
Message-ID: <20230623225513.2732256-15-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Switch ocfs2 from using sendpage() to using sendmsg() + MSG_SPLICE_PAGES so
that sendpage can be phased out.

Signed-off-by: David Howells <dhowells@redhat.com>

cc: Mark Fasheh <mark@fasheh.com>
cc: Joel Becker <jlbec@evilplan.org>
cc: Joseph Qi <joseph.qi@linux.alibaba.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: ocfs2-devel@oss.oracle.com
cc: netdev@vger.kernel.org
---

Notes:
    ver #4)
     - Use folio_alloc() for o2net_hand, o2net_keep_req and o2net_keep_resp.
    
    ver #2)
     - Wrap lines at 80.

 fs/ocfs2/cluster/tcp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 929a1133bc18..960080753d3b 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -930,19 +930,22 @@ static int o2net_send_tcp_msg(struct socket *sock, struct kvec *vec,
 }
 
 static void o2net_sendpage(struct o2net_sock_container *sc,
-			   void *kmalloced_virt,
-			   size_t size)
+			   void *virt, size_t size)
 {
 	struct o2net_node *nn = o2net_nn_from_num(sc->sc_node->nd_num);
+	struct msghdr msg = {};
+	struct bio_vec bv;
 	ssize_t ret;
 
+	bvec_set_virt(&bv, virt, size);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, size);
+
 	while (1) {
+		msg.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES;
 		mutex_lock(&sc->sc_send_lock);
-		ret = sc->sc_sock->ops->sendpage(sc->sc_sock,
-						 virt_to_page(kmalloced_virt),
-						 offset_in_page(kmalloced_virt),
-						 size, MSG_DONTWAIT);
+		ret = sock_sendmsg(sc->sc_sock, &msg);
 		mutex_unlock(&sc->sc_send_lock);
+
 		if (ret == size)
 			break;
 		if (ret == (ssize_t)-EAGAIN) {


