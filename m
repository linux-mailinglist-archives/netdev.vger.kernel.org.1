Return-Path: <netdev+bounces-105385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C30F910EDC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97EE1C21BA2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D581B4C24;
	Thu, 20 Jun 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DycXPULK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8101BBBD8
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904730; cv=none; b=brC/9ghIet7Mp+HZ3eIXgtnjFAVZai5+mdMCMJVaYOmHN7YaPZ6iQJgi6p7TIbC6mgNb/Tpkg4BfXfoh5D1tC1H8nJjqyLgBuQWImet9KZl7BeiSIAkLPFe8Pidv4jCdLzYPrk6tJX6jijY8eb7H/h4Bye/tc00Cqzzj5EB3igc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904730; c=relaxed/simple;
	bh=jtd3A5lE7SdB7AfrKnbG2Q1+vYzwWAMHHyI8mnIvrEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joWnXNPXQUnM8WUwlMDArKnI8gZlgRZiIvk0c5mDawjAGKiGx1npcHPjFgbFpVXE7tOB+/bVD8sQkuZwfUiGUPSudsmkIP5oItoRKnx7BKNLG602ey8ddZP2RJJx2IJXMUBFyxSj+XnFGQLa/W6bX/ZDAvs73YhyLN/VhYX7jUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DycXPULK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOxliJmAhngSfDrJfQOkQc4/7NxulOuU/yfY7uglXAU=;
	b=DycXPULKWLbk1IZX0ECg/b/bB9xDfar2keYuG4+GKA2//L6xa648ReWfHja5gQfPs78U1D
	WIZLCiRvFm3tgXrlHkHBFwLC7CA6v+7L4kYcmO4VcRgQus1CStOsa1jcGbuCmet20zXSIX
	H25uuoc837mCUCPSWdHFjrk0pQWeS54=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-xwNS2YLuPLuNd7fIfy6AIQ-1; Thu,
 20 Jun 2024 13:32:05 -0400
X-MC-Unique: xwNS2YLuPLuNd7fIfy6AIQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2F4D195608C;
	Thu, 20 Jun 2024 17:31:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4E3119560B4;
	Thu, 20 Jun 2024 17:31:50 +0000 (UTC)
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
	Steve French <stfrench@microsoft.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 01/17] netfs: Fix io_uring based write-through
Date: Thu, 20 Jun 2024 18:31:19 +0100
Message-ID: <20240620173137.610345-2-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

[This was included in v2 of 9b038d004ce95551cb35381c49fe896c5bc11ffe, but
v1 got pushed instead]

Fix netfs_unbuffered_write_iter_locked() to set the total request length in
the netfs_io_request struct rather than leaving it as zero.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Steve French <stfrench@microsoft.com>
cc: Enzo Matsumiya <ematsumiya@suse.de>
cc: Christian Brauner <brauner@kernel.org>
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/direct_write.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index e14cd53ac9fd..88f2adfab75e 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -92,8 +92,9 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
 	if (async)
 		wreq->iocb = iocb;
+	wreq->len = iov_iter_count(&wreq->io_iter);
 	wreq->cleanup = netfs_cleanup_dio_write;
-	ret = netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), iov_iter_count(&wreq->io_iter));
+	ret = netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
 	if (ret < 0) {
 		_debug("begin = %zd", ret);
 		goto out;


