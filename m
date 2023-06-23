Return-Path: <netdev+bounces-13620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CC073C495
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 00:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE82281E82
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C21DDD3;
	Fri, 23 Jun 2023 22:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCD1D2BF
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 22:55:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D8273F
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687560952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eD9cwJhfzpjqArgDx6+FQer5AVxYbVfQjKZhNYJ+UE=;
	b=WXgHJBr8ZTgmwztLr9R18HkFzWlrphe4gtwMCq9LhcX7o0uW8yPXJKynruzAjtnHMC9Nuz
	XFaRbLRyUkykxPg5nGNmUM0SPP6LnwKIl1Ig0+k+rQLkQVvXrrPFiYHvejWs8nRbU9XjWn
	PtoyoQwjGtbj9xMxNfWCGX4IqEf0Wic=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-PTJ_wQD9ObaVu43jKmpMaw-1; Fri, 23 Jun 2023 18:55:49 -0400
X-MC-Unique: PTJ_wQD9ObaVu43jKmpMaw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17CAE3C0BE35;
	Fri, 23 Jun 2023 22:55:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CEDA91400C35;
	Fri, 23 Jun 2023 22:55:45 +0000 (UTC)
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
	Mike Christie <michael.christie@oracle.com>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH net-next v5 11/16] scsi: iscsi_tcp: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
Date: Fri, 23 Jun 2023 23:55:08 +0100
Message-ID: <20230623225513.2732256-12-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use sendmsg() with MSG_SPLICE_PAGES rather than sendpage.  This allows
multiple pages and multipage folios to be passed through.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Mike Christie <michael.christie@oracle.com>
cc: Lee Duncan <lduncan@suse.com>
cc: Chris Leech <cleech@redhat.com>
cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
cc: "Martin K. Petersen" <martin.petersen@oracle.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: open-iscsi@googlegroups.com
cc: linux-scsi@vger.kernel.org
cc: target-devel@vger.kernel.org
cc: netdev@vger.kernel.org
---

Notes:
    ver #5)
     - Split iscsi changes into client and target patches

 drivers/scsi/iscsi_tcp.c | 26 ++++++++++----------------
 drivers/scsi/iscsi_tcp.h |  2 --
 2 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9637d4bc2bc9..9ab8555180a3 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -301,35 +301,32 @@ static int iscsi_sw_tcp_xmit_segment(struct iscsi_tcp_conn *tcp_conn,
 
 	while (!iscsi_tcp_segment_done(tcp_conn, segment, 0, r)) {
 		struct scatterlist *sg;
+		struct msghdr msg = {};
+		struct bio_vec bv;
 		unsigned int offset, copy;
-		int flags = 0;
 
 		r = 0;
 		offset = segment->copied;
 		copy = segment->size - offset;
 
 		if (segment->total_copied + segment->size < segment->total_size)
-			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
+			msg.msg_flags |= MSG_MORE;
 
 		if (tcp_sw_conn->queue_recv)
-			flags |= MSG_DONTWAIT;
+			msg.msg_flags |= MSG_DONTWAIT;
 
-		/* Use sendpage if we can; else fall back to sendmsg */
 		if (!segment->data) {
+			if (!tcp_conn->iscsi_conn->datadgst_en)
+				msg.msg_flags |= MSG_SPLICE_PAGES;
 			sg = segment->sg;
 			offset += segment->sg_offset + sg->offset;
-			r = tcp_sw_conn->sendpage(sk, sg_page(sg), offset,
-						  copy, flags);
+			bvec_set_page(&bv, sg_page(sg), copy, offset);
 		} else {
-			struct msghdr msg = { .msg_flags = flags };
-			struct kvec iov = {
-				.iov_base = segment->data + offset,
-				.iov_len = copy
-			};
-
-			r = kernel_sendmsg(sk, &msg, &iov, 1, copy);
+			bvec_set_virt(&bv, segment->data + offset, copy);
 		}
+		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bv, 1, copy);
 
+		r = sock_sendmsg(sk, &msg);
 		if (r < 0) {
 			iscsi_tcp_segment_unmap(segment);
 			return r;
@@ -746,7 +743,6 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
 	sock_no_linger(sk);
 
 	iscsi_sw_tcp_conn_set_callbacks(conn);
-	tcp_sw_conn->sendpage = tcp_sw_conn->sock->ops->sendpage;
 	/*
 	 * set receive state machine into initial state
 	 */
@@ -777,8 +773,6 @@ static int iscsi_sw_tcp_conn_set_param(struct iscsi_cls_conn *cls_conn,
 			return -ENOTCONN;
 		}
 		iscsi_set_param(cls_conn, param, buf, buflen);
-		tcp_sw_conn->sendpage = conn->datadgst_en ?
-			sock_no_sendpage : tcp_sw_conn->sock->ops->sendpage;
 		mutex_unlock(&tcp_sw_conn->sock_lock);
 		break;
 	case ISCSI_PARAM_MAX_R2T:
diff --git a/drivers/scsi/iscsi_tcp.h b/drivers/scsi/iscsi_tcp.h
index 68e14a344904..89a6fc552f0b 100644
--- a/drivers/scsi/iscsi_tcp.h
+++ b/drivers/scsi/iscsi_tcp.h
@@ -47,8 +47,6 @@ struct iscsi_sw_tcp_conn {
 	/* MIB custom statistics */
 	uint32_t		sendpage_failures_cnt;
 	uint32_t		discontiguous_hdr_cnt;
-
-	ssize_t (*sendpage)(struct socket *, struct page *, int, size_t, int);
 };
 
 struct iscsi_sw_tcp_host {


