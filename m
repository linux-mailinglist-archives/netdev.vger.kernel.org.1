Return-Path: <netdev+bounces-276488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOgUJPxH1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:20:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5323BBE75
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F1FB3054948
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1633C6619;
	Wed,  8 Apr 2026 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqMXOJXu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E883C3BFB
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650502; cv=none; b=OC7fQhc8nU2nvgj8d58yMADk9UzE+VVheuYbdnnsN30v27bYQshjpp04LrACMKLLc6IO+WPxqnVUHwOzmVfSP39LPUvjfuv3CWH/dE3PVTKgTwpfiwtW7RxQKkw96Fj+0BmHahWfGfKoNcriMxtVxg9BpEPSo3/IjwOzGdRNJWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650502; c=relaxed/simple;
	bh=gSdG3lxZtbodJ/8L44TqxhLcf6+Icb6oHxg0d94YVWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZQTy9k3tHEh1J/OGKXic65mJdVk8AiTSt5XhO7TsXlu7QZdYkZDiZpFI5zXQcNkyBPESgZNGx583ZcTI01RaG8QaFz+u8yBlfVDDsBlOCMY1Cv2dw1WUN38iM5jwIPgFP28xzXcJPgNXDhKZb64FiKDW3MMsxCEmDqIo1LvNSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqMXOJXu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lv404gsX5xBUYBtRPDG/l4DcWqX3w7GtKwD1LHT73lQ=;
	b=AqMXOJXuHI88l2UBTORfUmBHh76A0Y2UqX8Gi1f8mQDUjaO+RKokLtp4eylUfCQjjkuYue
	hsIdxZSMDt8Tr3sM8Seg+10KaPXI4wAyc0Z/H2iZTnEHKuyxqSgCmKoBkyNZBDRyeS4Rjy
	4xf9P6U6+3tIN7UYahQpeyOQEch1MYo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-s2qtJE0vNXai7eDuy0zPZg-1; Wed,
 08 Apr 2026 08:14:55 -0400
X-MC-Unique: s2qtJE0vNXai7eDuy0zPZg-1
X-Mimecast-MFC-AGG-ID: s2qtJE0vNXai7eDuy0zPZg_1775650493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13ECE19560B2;
	Wed,  8 Apr 2026 12:14:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86E6D3000203;
	Wed,  8 Apr 2026 12:14:49 +0000 (UTC)
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
Subject: [PATCH net v5 18/21] rxrpc: Fix leak of rxgk context in rxgk_verify_response()
Date: Wed,  8 Apr 2026 13:12:46 +0100
Message-ID: <20260408121252.2249051-19-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276488-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davemloft.net:email,infradead.org:email,auristor.com:email]
X-Rspamd-Queue-Id: DD5323BBE75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix rxgk_verify_response() to clean up the rxgk context it creates.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
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
 net/rxrpc/rxgk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 064c1531fc99..c67e3c2ca871 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1270,16 +1270,18 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	if (ret < 0) {
 		rxrpc_abort_conn(conn, skb, RXGK_SEALEDINCON, ret,
 				 rxgk_abort_resp_auth_dec);
-		goto out;
+		goto out_gk;
 	}
 
 	ret = rxgk_verify_authenticator(conn, krb5, skb, auth_offset, auth_len);
 	if (ret < 0)
-		goto out;
+		goto out_gk;
 
 	conn->key = key;
 	key = NULL;
 	ret = 0;
+out_gk:
+	rxgk_put(gk);
 out:
 	key_put(key);
 	_leave(" = %d", ret);


