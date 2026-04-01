Return-Path: <netdev+bounces-274053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ9WE6n8zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:08:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA83791B4
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0036D3110864
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F4407567;
	Wed,  1 Apr 2026 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/sfnItI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E743EC2CB
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041035; cv=none; b=hlVChGORbEJZB8w7w6BQ1kaK8LstjvaZWgVAm+FK1YY2aeCVOAfo+CrmDw+3B1k71Vflb0mLnbf4YXCG7NC8aFl9dMGT0nFrfWs0dt07pLDJx8Ts++ENNwjSUL1ff8QhO5N9MghSMRify/0D8WpuuW03TlTU8xb7WYvCozcM3aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041035; c=relaxed/simple;
	bh=wiH6DsMqrg29tzFgP11flkS65RZZkVoC9406w0ZzAqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDqATyk7dAM+ymKFwQU1dhCoicqHXv95uFEDIqA7hE6r459JHp+4foYbJiO16iK8izXQdluzCy6CW/Crg4CmMfpHyjS0fZUZ0ftRWyyBxcbK+V8rkXvlOLKmy+iWv5d4H1KPw/jP1DJqV/Dup7ILc+DzQQ0uA74FGPftt3OGH24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/sfnItI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loVxfrzyxYdQdW2xqgUXj+kDQbA4pbY0Yb3C1QbXM7A=;
	b=F/sfnItIX6Iof8Ns7RJZiGgkkDCZbRhKF3w+QYLpBKkhdyqt5VePNiNx3WuI1xLTnuM0zm
	P3nBmafPalaMusdGClaJplMyFHkmuYspXFyCcukBrDYBY9y45pCxqgRcPJR3bUbptHtLH8
	VzS2V+HnIARrnl0tx6S01/sP+F2FXqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-9LNxeDyuNFCuzQY6NuM-og-1; Wed,
 01 Apr 2026 06:57:09 -0400
X-MC-Unique: 9LNxeDyuNFCuzQY6NuM-og-1
X-Mimecast-MFC-AGG-ID: 9LNxeDyuNFCuzQY6NuM-og_1775041028
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E23AF19560B4;
	Wed,  1 Apr 2026 10:57:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D8491954102;
	Wed,  1 Apr 2026 10:57:03 +0000 (UTC)
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
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Simon Horman <horms@kernel.org>,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v4 07/15] rxrpc: Fix rack timer warning to report unexpected mode
Date: Wed,  1 Apr 2026 11:56:00 +0100
Message-ID: <20260401105614.1696001-8-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274053-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,oracle.com:email,davemloft.net:email,auristor.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBBA83791B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alok Tiwari <alok.a.tiwari@oracle.com>

rxrpc_rack_timer_expired() clears call->rack_timer_mode to OFF before
the switch. The default case warning therefore always prints OFF and
doesn't identify the unexpected timer mode.

Log the saved mode value instead so the warning reports the actual
unexpected rack timer mode.

Fixes: 7c482665931b ("rxrpc: Implement RACK/TLP to deal with transmission stalls [RFC8985]")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/input_rack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/input_rack.c b/net/rxrpc/input_rack.c
index 13c371261e0a..9eb109ffba56 100644
--- a/net/rxrpc/input_rack.c
+++ b/net/rxrpc/input_rack.c
@@ -413,6 +413,6 @@ void rxrpc_rack_timer_expired(struct rxrpc_call *call, ktime_t overran_by)
 		break;
 	//case RXRPC_CALL_RACKTIMER_ZEROWIN:
 	default:
-		pr_warn("Unexpected rack timer %u", call->rack_timer_mode);
+		pr_warn("Unexpected rack timer %u", mode);
 	}
 }


