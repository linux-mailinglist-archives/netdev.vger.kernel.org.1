Return-Path: <netdev+bounces-307064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sdaMAaudVGohoQMAu9opvQ
	(envelope-from <netdev+bounces-307064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:11:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5374885E
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:11:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KVnR5rTq;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307064-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307064-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61F0E300847A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344B3A6B92;
	Mon, 13 Jul 2026 08:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298903A5E70
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:10:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930252; cv=none; b=Tv32BtU+4dLUh2ZFXj7HLtpb72Pu5sqOCT7n/xz2WBJpM808JUipZ68n05mxQLW64UGBJGXBOAGCECmUPAikHA+8jmpTzPwfJ+/1IeM/EtVpFBGt2byB85rjhZtMHtUtoSDpTw8D1DUF8ostGvL17c7LbUJKcLqS3r7wR6YVfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930252; c=relaxed/simple;
	bh=Jwc5fJ9xrRVYizICnQ5yAooHRkTMnng50fBKpa7UdCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRyHaM5Le7USKvGS/MF5XwgI/5o52jpUBAfIFezpi1+xhVyeUzwnz0BFbywPM/YqeWgaZY2vBLdnc4VRMF6EKTnkuZ29PBcw/J6+S8ulKrUEFhbwrfep5+6R1319LkQw5ltSvxs+si88CsMtDEn+Eqt8LI8AMqBmItD2KjreTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVnR5rTq; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJbYCTF46Xtoig1WDNcBh4wAMxmGdrepxhiioBEnY2E=;
	b=KVnR5rTqkQ5Pqyjqwg+Ud3Wammt3f0mcdcaUO6hQ8XOEgks2Rc6TY8FIrOBfWjKbHJS9+T
	qWu22uoTcdeC5xH9Ym5HVKEtz5QxUr3wLG/nn9e9HxIsRXbALmZ4nFzsCxz3zPjbHAj5Zm
	7jqUtfw6AqgeNlyYW0geB+xWww32h9Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-JZFpb0L8P4aVcdFTGB51KQ-1; Mon,
 13 Jul 2026 04:10:46 -0400
X-MC-Unique: JZFpb0L8P4aVcdFTGB51KQ-1
X-Mimecast-MFC-AGG-ID: JZFpb0L8P4aVcdFTGB51KQ_1783930245
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 133851955F21;
	Mon, 13 Jul 2026 08:10:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4FBF195394B;
	Mon, 13 Jul 2026 08:10:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v3 03/14] afs: Fix afs_fs_fetch_data() to set call->async
Date: Mon, 13 Jul 2026 09:10:09 +0100
Message-ID: <20260713081022.2186481-4-dhowells@redhat.com>
In-Reply-To: <20260713081022.2186481-1-dhowells@redhat.com>
References: <20260713081022.2186481-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,davemloft.net:email,auristor.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16F5374885E

Fix afs_fs_fetch_data() to set call->async on an async operation as does
afs_fs_fetch_data64().

Fixes: eddf51f2bb2c ("afs: Make {Y,}FS.FetchData an asynchronous operation")
Link: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/fsclient.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index a2ffd60889f8..626e1d37b915 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -477,6 +477,9 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp[0] = htonl(FSFETCHDATA);


