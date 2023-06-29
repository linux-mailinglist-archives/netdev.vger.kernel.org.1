Return-Path: <netdev+bounces-14677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D74742FAB
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 23:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124DA1C20B50
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A2FFC13;
	Thu, 29 Jun 2023 21:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5FFBF6
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 21:48:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911F30C4
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688075279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K03oWfg7ltpvcM3Ih7makmSjGjXBMyrolfLAXXIm6H0=;
	b=ETabmBBVtfHZUZdPmr4QpyCd2rE9qPx3pa5glsk78K9bYXTip2J9Bbzk31i//un3w+RsmM
	OMEN2AQ65MI+X7mzvXA8LDwQ7OrDn38LFwW8t/EdQ3KW/qRSiiYzz6kQwfgNmOF+OaaSeH
	15Q8C83JNXgIvtCd6CA/LMnuvjl4T0M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-11qw2n_LObuF0zIJeZUVIA-1; Thu, 29 Jun 2023 17:47:56 -0400
X-MC-Unique: 11qw2n_LObuF0zIJeZUVIA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C353185A793;
	Thu, 29 Jun 2023 21:47:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D355B492B02;
	Thu, 29 Jun 2023 21:47:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Aurelien Aptel <aaptel@nvidia.com>,
    Sagi Grimberg <sagi@grimberg.me>,
    Willem de Bruijn <willemb@google.com>,
    Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
    Matthew Wilcox <willy@infradead.org>, linux-nvme@lists.infradead.org
Subject: [PATCH net] nvme-tcp: Fix comma-related oops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59061.1688075273.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2023 22:47:53 +0100
Message-ID: <59062.1688075273@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix a comma that should be a semicolon.  The comma is at the end of an
if-body and thus makes the statement after (a bvec_set_page()) conditional
too, resulting in an oops because we didn't fill out the bio_vec[]:

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    ...
    Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
    RIP: 0010:skb_splice_from_iter+0xf1/0x370
    ...
    Call Trace:
     tcp_sendmsg_locked+0x3a6/0xdd0
     tcp_sendmsg+0x31/0x50
     inet_sendmsg+0x47/0x80
     sock_sendmsg+0x99/0xb0
     nvme_tcp_try_send_data+0x149/0x490 [nvme_tcp]
     nvme_tcp_try_send+0x1b7/0x300 [nvme_tcp]
     nvme_tcp_io_work+0x40/0xc0 [nvme_tcp]
     process_one_work+0x21c/0x430
     worker_thread+0x54/0x3e0
     kthread+0xf8/0x130

Fixes: 7769887817c3 ("nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then =
sendpage")
Reported-by: Aurelien Aptel <aaptel@nvidia.com>
Link: https://lore.kernel.org/r/253mt0il43o.fsf@mtr-vdi-124.i-did-not-set-=
-mail-host-address--so-tickle-me/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Sagi Grimberg <sagi@grimberg.me>
cc: Willem de Bruijn <willemb@google.com>
cc: Keith Busch <kbusch@kernel.org>
cc: Jens Axboe <axboe@fb.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Chaitanya Kulkarni <kch@nvidia.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-nvme@lists.infradead.org
cc: netdev@vger.kernel.org
---
 drivers/nvme/host/tcp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e7dd6f91832..9ce417cd32a7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1014,7 +1014,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_re=
quest *req)
 			msg.msg_flags |=3D MSG_MORE;
 =

 		if (!sendpage_ok(page))
-			msg.msg_flags &=3D ~MSG_SPLICE_PAGES,
+			msg.msg_flags &=3D ~MSG_SPLICE_PAGES;
 =

 		bvec_set_page(&bvec, page, len, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);


