Return-Path: <netdev+bounces-270581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH/gCzBuwWnDTAQAu9opvQ
	(envelope-from <netdev+bounces-270581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:45:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 592942F8C0E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 17:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA91D33FB3B9
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415343B38B1;
	Mon, 23 Mar 2026 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SruhDrDX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5D3B389F
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278334; cv=none; b=Trdkbwz7M9LTN+wAPxtxwb500l5HNE4fDMLBnKveB/NBAdQbzguPfCVqvyOXQb4wH73wZDlnXLeiyNpyn6ltk5ElmkxrABaTcJAGEsNcthu2fe2Q8HZln6afc9V0YT+H8XFqVefSrPil9dq0zobjxkyMmSIItpwrseE9lZrNbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278334; c=relaxed/simple;
	bh=lNi53xaZ2dGL9nGQo2Q5PUubxeSgR378CvFt6gObZgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVQAbt7XIXJuelBvCbgKnEPTfdcn6RQPlWDgJBmVw7J2i5BKerUpTmx/cLj2FRKdc4pYQ+9cv1RRoz0ahhpV+Yp49t3Hg5+8paqoi1yqC+6RorwNTr4vw2ITpAXoPWtRlj5warHuWuz8a1gjJUqtt79PqWrJMh7BsE416Vo5Vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SruhDrDX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774278332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaIw1S56HP9C94n6EHAzBdJx0jJ6g47etF8yPJICPVc=;
	b=SruhDrDXXadeOAmzhUNHNrRTOUXaVocYknmtG50aAFahJJaqwqIUSXaz9L97jlxPS+8OkJ
	HCIDbDB2ojm057Mw2YK91dzqVE1H45Tm1XUewBXsrsDk/ywRrQdnSmRXwharxtYhWz6v8h
	xuXDFnNKOozxFqg9hh9VEc8ZU8cRcqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-FU9qcOY5NciB73N_CMT9-A-1; Mon,
 23 Mar 2026 11:05:28 -0400
X-MC-Unique: FU9qcOY5NciB73N_CMT9-A-1
X-Mimecast-MFC-AGG-ID: FU9qcOY5NciB73N_CMT9-A_1774278325
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A3B419560BF;
	Mon, 23 Mar 2026 15:05:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CE8A180075D;
	Mon, 23 Mar 2026 15:05:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v2 02/10] rxrpc: Fix key parsing memleak
Date: Mon, 23 Mar 2026 15:04:53 +0000
Message-ID: <20260323150505.3513839-3-dhowells@redhat.com>
In-Reply-To: <20260323150505.3513839-1-dhowells@redhat.com>
References: <20260323150505.3513839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270581-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 592942F8C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rxrpc_preparse_xdr_yfs_rxgk(), the memory attached to token->rxgk can be
leaked in a few error paths after it's allocated.

Fix this by freeing it in the "reject_token:" case.

Fixes: 0ca100ff4df6 ("rxrpc: Add YFS RxGK (GSSAPI) security class")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index af403f0ccab5..26d4336a4a02 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -274,6 +274,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 nomem:
 	return -ENOMEM;
 reject_token:
+	kfree(token->rxgk);
 	kfree(token);
 reject:
 	return -EKEYREJECTED;


