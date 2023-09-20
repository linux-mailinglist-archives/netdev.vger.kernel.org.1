Return-Path: <netdev+bounces-35338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5707A8F48
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 00:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB68281A09
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157741231;
	Wed, 20 Sep 2023 22:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAD450D5
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 22:22:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831BBDE
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695248566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/K7bby96tUMA/iC07lWusXqTlhgR9zlJgJ7++h0ZQI=;
	b=RcRWvkhI1BiqVmLKFttQ9oFKZjpjBGPXL7K/sSPgmrmYBk+m1kb74bTKXe4gAqxpdmu35l
	DT/9vlngEb4kK72fZrbmIaX/SKjANHcW+s/QbbyXdd3oRAxPgdgBrALP/SHG4mEbo7A2oE
	KvosjIuGsn3LbSKvNDEwdyWbFQ0UkcI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-qSI8WUj0N3Orf3pb4D2D6g-1; Wed, 20 Sep 2023 18:22:45 -0400
X-MC-Unique: qSI8WUj0N3Orf3pb4D2D6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58FB9185A797;
	Wed, 20 Sep 2023 22:22:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB58E492C37;
	Wed, 20 Sep 2023 22:22:40 +0000 (UTC)
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
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH v5 02/11] infiniband: Use user_backed_iter() to see if iterator is UBUF/IOVEC
Date: Wed, 20 Sep 2023 23:22:22 +0100
Message-ID: <20230920222231.686275-3-dhowells@redhat.com>
In-Reply-To: <20230920222231.686275-1-dhowells@redhat.com>
References: <20230920222231.686275-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use user_backed_iter() to see if iterator is UBUF/IOVEC rather than poking
inside the iterator.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
cc: Jason Gunthorpe <jgg@ziepe.ca>
cc: Leon Romanovsky <leon@kernel.org>
cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/hfi1/file_ops.c    | 2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index a5ab22cedd41..788fc249234f 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -267,7 +267,7 @@ static ssize_t hfi1_write_iter(struct kiocb *kiocb, struct iov_iter *from)
 
 	if (!HFI1_CAP_IS_KSET(SDMA))
 		return -EINVAL;
-	if (!from->user_backed)
+	if (!user_backed_iter(from))
 		return -EINVAL;
 	idx = srcu_read_lock(&fd->pq_srcu);
 	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 152952127f13..29e4c59aa23b 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -2244,7 +2244,7 @@ static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
 	struct qib_user_sdma_queue *pq = fp->pq;
 
-	if (!from->user_backed || !from->nr_segs || !pq)
+	if (!user_backed_iter(from) || !from->nr_segs || !pq)
 		return -EINVAL;
 
 	return qib_user_sdma_writev(rcd, pq, iter_iov(from), from->nr_segs);


