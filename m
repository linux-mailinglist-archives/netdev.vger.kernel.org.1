Return-Path: <netdev+bounces-13621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C673C496
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 00:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59AE281EBF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673411DDE6;
	Fri, 23 Jun 2023 22:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B561D2BF
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 22:55:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D02949
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687560953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZHrq272u78M4jQRc62xjzOjs56TE9G5qctmKlgdkdo=;
	b=YRa1UxVTsCLL/slFpDcPganzPGdHxjthqbn5xs5DDzFcZV57FV3svzrMgXt5C+lLT07f2k
	BhB7ez9Azf+RlLk52nkPPwBA0r8QwyQWo8sTm6m5PkUDI9Qgacxnvgijh+a5xxHvTOwRt3
	0YeTxZdduqyysUzCMjkwO1P4puqb7SY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-ADNZXf0mNHmnFJ3WbtgVaQ-1; Fri, 23 Jun 2023 18:55:52 -0400
X-MC-Unique: ADNZXf0mNHmnFJ3WbtgVaQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA1AE2A2AD56;
	Fri, 23 Jun 2023 22:55:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B6FB340C2063;
	Fri, 23 Jun 2023 22:55:48 +0000 (UTC)
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
	Maurizio Lombardi <mlombard@redhat.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH net-next v5 12/16] scsi: target: iscsi: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage
Date: Fri, 23 Jun 2023 23:55:09 +0100
Message-ID: <20230623225513.2732256-13-dhowells@redhat.com>
In-Reply-To: <20230623225513.2732256-1-dhowells@redhat.com>
References: <20230623225513.2732256-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use sendmsg() with MSG_SPLICE_PAGES rather than sendpage.  This allows
multiple pages and multipage folios to be passed through.

TODO: iscsit_fe_sendpage_sg() should perhaps set up a bio_vec array for the
entire set of pages it's going to transfer plus two for the header and
trailer and page fragments to hold the header and trailer - and then call
sendmsg once for the entire message.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Mike Christie <michael.christie@oracle.com>
cc: Maurizio Lombardi <mlombard@redhat.com>
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
    
    ver #2)
     - Wrap lines at 80.

 drivers/target/iscsi/iscsi_target_util.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index b14835fcb033..6231fa4ef5c6 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1129,6 +1129,8 @@ int iscsit_fe_sendpage_sg(
 	struct iscsit_conn *conn)
 {
 	struct scatterlist *sg = cmd->first_data_sg;
+	struct bio_vec bvec;
+	struct msghdr msghdr = { .msg_flags = MSG_SPLICE_PAGES,	};
 	struct kvec iov;
 	u32 tx_hdr_size, data_len;
 	u32 offset = cmd->first_data_sg_off;
@@ -1172,17 +1174,18 @@ int iscsit_fe_sendpage_sg(
 		u32 space = (sg->length - offset);
 		u32 sub_len = min_t(u32, data_len, space);
 send_pg:
-		tx_sent = conn->sock->ops->sendpage(conn->sock,
-					sg_page(sg), sg->offset + offset, sub_len, 0);
+		bvec_set_page(&bvec, sg_page(sg), sub_len, sg->offset + offset);
+		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, sub_len);
+
+		tx_sent = conn->sock->ops->sendmsg(conn->sock, &msghdr,
+						   sub_len);
 		if (tx_sent != sub_len) {
 			if (tx_sent == -EAGAIN) {
-				pr_err("tcp_sendpage() returned"
-						" -EAGAIN\n");
+				pr_err("sendmsg/splice returned -EAGAIN\n");
 				goto send_pg;
 			}
 
-			pr_err("tcp_sendpage() failure: %d\n",
-					tx_sent);
+			pr_err("sendmsg/splice failure: %d\n", tx_sent);
 			return -1;
 		}
 


