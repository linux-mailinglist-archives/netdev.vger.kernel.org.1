Return-Path: <netdev+bounces-253185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB6iKxNAdmm6OAEAu9opvQ
	(envelope-from <netdev+bounces-253185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:08:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B359815F2
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB30C3011A6D
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD1326942;
	Sun, 25 Jan 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7Fgla07"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49A21B4244
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769357295; cv=none; b=gS89Kfw0RYGlQ1LJWt+GZVaw1NXeSBTnZ8gxf8MFyQPHpINOriEEvUxjxpuullmbMG8sXeKdTLhzN4788HW3d1paWKKVfCk4u1qvR0Dp+G1wzmIw1aCqsG7g7yW/er9585HDfklEK+f0mRZ4mWEiSXRhRPB8URZ/OUREDcfbL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769357295; c=relaxed/simple;
	bh=K2R9b0barWC68k/7xbhNUGCfm1zFHkjY7UaNg/NdOEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lS6Cv0m+QDFnRmyGHsbKJgFNp1K0/afLBkde1Uz/8bxLsFVDLrcw8EMbZQFxiN/yz+WKkuCqNlYqrDqtb01IlRWMUcUtTfbwwVFxna4G0oTrnzvo4KrEHtEAukCIEjlqrxX4qQxbgtRdMTMc0UQQ3/pm9ZcDKaWYqJwVBofKrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7Fgla07; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769357292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=vBKRDP8bqkordujGp7qy48QcPV4IJTrct7fsioyRbjk=;
	b=D7Fgla07Olwx7OgrDKxpmUMUsSAYlpvMJiB0SxRmfNg99AsWbv5FJ1Ao+gz4CFJsVQY3s3
	TPkgRaoRUBv72pkr4/D6wjyj8aVhn5pbhIVC61E+OoA3kFSKD7MolKQWCtn4LeEMxdUkuB
	LeRfgHJwmGanMOhkInIS2NhVacMYkTQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-flqaROaMMQSqWeM4JnXa7g-1; Sun,
 25 Jan 2026 11:08:09 -0500
X-MC-Unique: flqaROaMMQSqWeM4JnXa7g-1
X-Mimecast-MFC-AGG-ID: flqaROaMMQSqWeM4JnXa7g_1769357287
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 452B71956089;
	Sun, 25 Jan 2026 16:08:07 +0000 (UTC)
Received: from fedora (unknown [10.45.224.8])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 89E9F180049F;
	Sun, 25 Jan 2026 16:08:01 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 25 Jan 2026 17:08:06 +0100 (CET)
Date: Sun, 25 Jan 2026 17:08:00 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Steven Price <steven.price@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 7/7] netclassid: use thread_group_leader(p) in
 update_classid_task()
Message-ID: <aXY_4NSP094-Cf-2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXY_h8i78n6yD9JY@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253185-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 0B359815F2
X-Rspamd-Action: no action

Cleanup and preparation to simplify the next changes.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 net/core/netclassid_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index dff66d8fb325..db9a5354f9de 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -93,7 +93,7 @@ static void update_classid_task(struct task_struct *p, u32 classid)
 	/* Only update the leader task, when many threads in this task,
 	 * so it can avoid the useless traversal.
 	 */
-	if (p != p->group_leader)
+	if (!thread_group_leader(p))
 		return;
 
 	do {
-- 
2.52.0


