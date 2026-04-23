Return-Path: <netdev+bounces-280872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNsmEAB96mmqzwIAu9opvQ
	(envelope-from <netdev+bounces-280872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:11:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6404572C5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7872D302BDCD
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB41399349;
	Thu, 23 Apr 2026 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZZEIWhk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CE2D5940
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974980; cv=none; b=o2t5fwR/SbyR8TBKb9oPMi1UKo94xZBusAmYVVMdLyi6fxD86kta+weUyu10nR9vcBTNfzX34u5+FInpxwYc95JZNIE5ivQW2UYRN1m5fTUYzDIs75kFjAVFojGJO+X7ZeoBSzLkrzao2kSUmlJGe6p0r5igPbXgzHbHcx+3GZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974980; c=relaxed/simple;
	bh=b/6JXvza5g4eLgfbGPwDE/CWDXWxEHuALrwvzQL2m2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmYBLqmNO0mQ6iIKTQp2AoWKbHoHun2IIXTOtDxDNW3lBkt4S3jhbJTgq3/DJx/ELrAOOzt2wvbHLe9vbuN+UIsLu6LvGU47L2UMydtjG6ysFd94lFIOfBOjJ/YQXRIxwecZvSKE2cjPhqyPi2cNPqywlgUQaCyaYI54kaqo9EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZZEIWhk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776974978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm7vC+JEMIfKisaEodeahWfK8J8nWBHew+0swW+Q2kI=;
	b=cZZEIWhka37Y1ua5/4yWHBnumPgdaPDETVgJ2b5Z8gmnObRP65OIBgGOzMz/dMxFJcJB9k
	DWppOaKBdx+9QXSb+hA8e5xe5w34tZtZyvsXt7aCo0a96IDGXOeOAkjPj+Ob3s42s8sGdO
	e/tNcUh3XllabBAa0ggj2cBvYuc5LEI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-apZ8UIwqPl6UNOmunFlFXQ-1; Thu,
 23 Apr 2026 16:09:34 -0400
X-MC-Unique: apZ8UIwqPl6UNOmunFlFXQ-1
X-Mimecast-MFC-AGG-ID: apZ8UIwqPl6UNOmunFlFXQ_1776974973
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 232B9195608F;
	Thu, 23 Apr 2026 20:09:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 76FBF19560AB;
	Thu, 23 Apr 2026 20:09:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net 3/3] rxrpc: Fix error handling in rxgk_extract_token()
Date: Thu, 23 Apr 2026 21:09:08 +0100
Message-ID: <20260423200909.3049438-4-dhowells@redhat.com>
In-Reply-To: <20260423200909.3049438-1-dhowells@redhat.com>
References: <20260423200909.3049438-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280872-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,davemloft.net:email,infradead.org:email,auristor.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC6404572C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix a missing bit of error handling in rxgk_extract_token(): in the event
that rxgk_decrypt_skb() returns -ENOMEM, it should just return that rather
than continuing on (for anything else, it generates an abort).

Fixes: 64863f4ca494 ("rxrpc: Fix unhandled errors in rxgk_verify_packet_integrity()")
Closes: https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com
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
 net/rxrpc/rxgk_app.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index 5587639d60c5..0ef2a29eb695 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -245,6 +245,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 		if (ret != -ENOMEM)
 			return rxrpc_abort_conn(conn, skb, ec, ret,
 						rxgk_abort_resp_tok_dec);
+		return ret;
 	}
 
 	ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,


