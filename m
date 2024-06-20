Return-Path: <netdev+bounces-105387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F2910EE9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC45D2854D4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F7F1BD01A;
	Thu, 20 Jun 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="df/rjwXd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F1D1B4C44
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904751; cv=none; b=dUTduE0tvEMUlyAscTzvOQLaHuAuiyzame9LkyhzxH+SbkN+mzc36vYEeWtS2O9tMgAhWVoumbG2Nine2TDTTFxvZCu0C5zIWuTKlOpJDU4C5NVzgWXaK4wv3lGsDnoM6hpEDtsi6dc8b8pUC43/9Ic1KEYgJSuMzbGEMHdqAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904751; c=relaxed/simple;
	bh=uqr+c6TSD+IA6jAqPedpS4BUZPZmSd7r1lKskAQEvlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py9WJczTm39xrD2cSWHgaDJUZrY7kaE1riAfFNp18vJWqVs78cU0wugio9WkTcgv+2XN6xDUFXMhGvFP/1JW96plHF3Od+PkX3qMMEj0SSfKORqSA4wD3Mduj8NCnIRUbOzQWV8mz93Yry1+3dECxcpAmLGumuBC9HkGgLC4fTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=df/rjwXd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Za3sI46DNoDRS2zLMaVKKAo5577Q7Mj2mbpphqJpg8=;
	b=df/rjwXdnYFcFYjORBxgcSSl6AuVmsBhz5TUgLNZ/9o2TdnPAu85D0wYDZ4VlWGRvT/NOu
	KzpdMJ2/6Wqb1VYje+/yvNJMU4X+D7DKrMeappLu3THEBAZ1GYck1UpLpK++nEL2hkWqhL
	ecVU9UNKrtC89+8GjF8LtRPe2Ll2yLY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-lamvqmTDOOq2ya95QZA4mQ-1; Thu,
 20 Jun 2024 13:32:23 -0400
X-MC-Unique: lamvqmTDOOq2ya95QZA4mQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 270E61956068;
	Thu, 20 Jun 2024 17:32:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7215F3000602;
	Thu, 20 Jun 2024 17:32:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 03/17] netfs: Fix early issue of write op on partial write to folio tail
Date: Thu, 20 Jun 2024 18:31:21 +0100
Message-ID: <20240620173137.610345-4-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

During the writeback procedure, at the end of netfs_write_folio(), pending
write operations are flushed if the amount of write-streaming data stored
in a page is less than the size of the folio because if we haven't modified
a folio to the end, it cannot be contiguous with the following folio...
except if the dirty region of the folio is right at the end of the folio
space.

Fix the test to take the offset into the folio into account as well, such
that if the dirty region runs right up to the end of the folio, we leave
the flushing for later.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com> (DFS, global name space)
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 3aa86e268f40..ec6cf8707fb0 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -483,7 +483,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	if (!debug)
 		kdebug("R=%x: No submit", wreq->debug_id);
 
-	if (flen < fsize)
+	if (foff + flen < fsize)
 		for (int s = 0; s < NR_IO_STREAMS; s++)
 			netfs_issue_write(wreq, &wreq->io_streams[s]);
 


