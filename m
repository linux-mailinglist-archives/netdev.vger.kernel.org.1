Return-Path: <netdev+bounces-169246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F4A4311E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB44189B71A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DBC20D4EE;
	Mon, 24 Feb 2025 23:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BllaTQef"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10C20E6E8
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440547; cv=none; b=BnnBuZeeRQOYJQfK2bxKsQd4KzU48jZ7TnlCpaKXxjhGYb/TIODC6m0HHaa4I+F5ZqsPvFUEf9r0wIl7YdSAmEIohlZICTdemdl4KVtPFdDp+LYbBP4FoOZjMLqRh8um7ENPxZ2trkCngUtQ+sxspWuHaIlH2gcIq6ftnNFz8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440547; c=relaxed/simple;
	bh=wtEOdGs2YSi6iCFHbcNdsyGHm5cwYWHaRiJS1CB7fE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sydjx1nGxOPpMb6dBFTGiYXWDmKC4wHxTewrJBqkwUvVhNszYuorkPs28uJrX48bMl3oV4yUBtnGPPjUfPNmDr7850dqfezlm6NNbz90GyIBg5VPxn4SP+OCA56OY6utj19cKhvjZ6HoSDjgNr0KQwHHr8l+Ka0nj9nnFQtkof4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BllaTQef; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qtAxVvogmmtKwzUjDbJVTd9fTHTMk8w5vttE1KliMWs=;
	b=BllaTQefLEk91OnBag8JBHonml7klJ0/qVWrtpGKzBIJnpTbhGx1Dt4Tw5/CcTTyYzlycW
	nFycmT4R7rq6xtNeAaNABlNOJEiWnbCeapEAVZoaAu5BEFfVPB3/+OFkgOutOwrb80ZwpZ
	xqhTX3oko7LKK13F9rZz+IXhz6RAryk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-410-wWc2qRQ2PcmcnhPUDd99_w-1; Mon,
 24 Feb 2025 18:42:20 -0500
X-MC-Unique: wWc2qRQ2PcmcnhPUDd99_w-1
X-Mimecast-MFC-AGG-ID: wWc2qRQ2PcmcnhPUDd99_w_1740440539
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E1B3180087D;
	Mon, 24 Feb 2025 23:42:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 941941800944;
	Mon, 24 Feb 2025 23:42:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 04/15] afs: Fix the server_list to unuse a displaced server rather than putting it
Date: Mon, 24 Feb 2025 23:41:41 +0000
Message-ID: <20250224234154.2014840-5-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
References: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When allocating and building an afs_server_list struct object from a VLDB
record, we look up each server address to get the server record for it -
but a server may have more than one entry in the record and we discard the
duplicate pointers.  Currently, however, when we discard, we only put a
server record, not unuse it - but the lookup got as an active-user count.

The active-user count on an afs_server_list object determines its lifetime
whereas the refcount keeps the memory backing it around.  Failing to reduce
the active-user counter prevents the record from being cleaned up and can
lead to multiple copied being seen - and pointing to deleted afs_cell
objects and other such things.

Fix this by switching the incorrect 'put' to an 'unuse' instead.

Without this, occasionally, a dead server record can be seen in
/proc/net/afs/servers and list corruption may be observed:

    list_del corruption. prev->next should be ffff888102423e40, but was 0000000000000000. (prev=ffff88810140cd38)

Fixes: 977e5f8ed0ab ("afs: Split the usage count on struct afs_server")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 fs/afs/server_list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index 7e7e567a7f8a..d20cd902ef94 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -97,8 +97,8 @@ struct afs_server_list *afs_alloc_server_list(struct afs_volume *volume,
 				break;
 		if (j < slist->nr_servers) {
 			if (slist->servers[j].server == server) {
-				afs_put_server(volume->cell->net, server,
-					       afs_server_trace_put_slist_isort);
+				afs_unuse_server(volume->cell->net, server,
+						 afs_server_trace_put_slist_isort);
 				continue;
 			}
 


