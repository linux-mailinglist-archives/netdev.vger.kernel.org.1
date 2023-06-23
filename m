Return-Path: <netdev+bounces-13622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A832A73C499
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 00:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90121C20B26
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 22:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B8915AE4;
	Fri, 23 Jun 2023 22:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40766AA3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 22:56:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E92952
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687560959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DznK2AUeRuZJq7eWmkzDsLOFPhbrN3vu6EuXAdMNepE=;
	b=SoAGJ6iNifHJfs/vJ19Vf949dH2tPMJ8fhyx1C1r0ncPFVfDayzDgojBigXS+z+2CMkQdj
	kwgGqIHPzr1HyV2vbJfCElD0mBoa2sfN0z7W+IeqgBp63Z+7i2FXLBmFlaYf3MRjISsYjO
	NIO6IHfwSUSxvYyUPk/sOB7QuVTOhLw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-scLXM6p0PSyn60UPmGbLlg-1; Fri, 23 Jun 2023 18:55:54 -0400
X-MC-Unique: scLXM6p0PSyn60UPmGbLlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCC862A2AD53;
	Fri, 23 Jun 2023 22:55:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8918B40C2063;
	Fri, 23 Jun 2023 22:55:51 +0000 (UTC)
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
	Kurt Hackel <kurt.hackel@oracle.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@oss.oracle.com
Subject: [PATCH net-next v5 13/16] ocfs2: Fix use of slab data with sendpage
Date: Fri, 23 Jun 2023 23:55:10 +0100
Message-ID: <20230623225513.2732256-14-dhowells@redhat.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ocfs2 uses kzalloc() to allocate buffers for o2net_hand, o2net_keep_req and
o2net_keep_resp and then passes these to sendpage.  This isn't really
allowed as the lifetime of slab objects is not controlled by page ref -
though in this case it will probably work.  sendmsg() with MSG_SPLICE_PAGES
will, however, print a warning and give an error.

Fix it to use folio_alloc() instead to allocate a buffer for the handshake
message, keepalive request and reply messages.

Fixes: 98211489d414 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Mark Fasheh <mark@fasheh.com>
cc: Kurt Hackel <kurt.hackel@oracle.com>
cc: Joel Becker <jlbec@evilplan.org>
cc: Joseph Qi <joseph.qi@linux.alibaba.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: ocfs2-devel@oss.oracle.com
cc: netdev@vger.kernel.org
---
 fs/ocfs2/cluster/tcp.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index aecbd712a00c..929a1133bc18 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -2087,18 +2087,24 @@ void o2net_stop_listening(struct o2nm_node *node)
 
 int o2net_init(void)
 {
+	struct folio *folio;
+	void *p;
 	unsigned long i;
 
 	o2quo_init();
-
 	o2net_debugfs_init();
 
-	o2net_hand = kzalloc(sizeof(struct o2net_handshake), GFP_KERNEL);
-	o2net_keep_req = kzalloc(sizeof(struct o2net_msg), GFP_KERNEL);
-	o2net_keep_resp = kzalloc(sizeof(struct o2net_msg), GFP_KERNEL);
-	if (!o2net_hand || !o2net_keep_req || !o2net_keep_resp)
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 0);
+	if (!folio)
 		goto out;
 
+	p = folio_address(folio);
+	o2net_hand = p;
+	p += sizeof(struct o2net_handshake);
+	o2net_keep_req = p;
+	p += sizeof(struct o2net_msg);
+	o2net_keep_resp = p;
+
 	o2net_hand->protocol_version = cpu_to_be64(O2NET_PROTOCOL_VERSION);
 	o2net_hand->connector_id = cpu_to_be64(1);
 
@@ -2124,9 +2130,6 @@ int o2net_init(void)
 	return 0;
 
 out:
-	kfree(o2net_hand);
-	kfree(o2net_keep_req);
-	kfree(o2net_keep_resp);
 	o2net_debugfs_exit();
 	o2quo_exit();
 	return -ENOMEM;
@@ -2135,8 +2138,6 @@ int o2net_init(void)
 void o2net_exit(void)
 {
 	o2quo_exit();
-	kfree(o2net_hand);
-	kfree(o2net_keep_req);
-	kfree(o2net_keep_resp);
 	o2net_debugfs_exit();
+	folio_put(virt_to_folio(o2net_hand));
 }


