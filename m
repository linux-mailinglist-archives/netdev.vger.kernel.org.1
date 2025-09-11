Return-Path: <netdev+bounces-222338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ED0B53EF7
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A304444BB
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABE2F4A05;
	Thu, 11 Sep 2025 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDpwE/kh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1051A08A3
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631987; cv=none; b=LEhMep6lNMhEJxZcBDT62vikKdAJgCmrRaOcUlt+DvAB6V1R3YGbvbGvhneDu4jFhbyuFAnchUWrMYqNgpFYIMvrk3GlGb68uGeb1eTfqY/MVlycmzE3lbepkZPkw2YIZKD9xFQ/HyBKchjWLtlSODrXsIA+FTMbcRhmyGFsULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631987; c=relaxed/simple;
	bh=zYm0m59md0YmJAnONrIhr+tPVXmFfeUu+aOXXuIcRMY=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Kcis9avy1Bvb9tEmc5Z3wENB3c0nADrq93iO3f5lRAxV6ByOkDWS+E9xO6rMR2KU77cwVPIs9inKKCma627B6cDq9QudH26BSjz9jK1tkxgF5x4FeRxoiYDOs/TUiVwRUGw8AbIR41hM6mUwdObybd8fu3K98XmctrJbSpZmqNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDpwE/kh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757631984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OQwBcPZWGnJ87xzP7ruqoRhyhedrtIzZGOwOMMIChZg=;
	b=BDpwE/khaj9PVRdVyZmcUAqfp9KCmB4GvP1evUP9w7qJ6Fe/NQiDgkoSJmMgAUT+v5upLC
	749u+LyXOXanPH8oQTW/fvsn8xtyJJqJDhfYlLYuLcphSG4pdGKxzPo/4T1R7nbeVinrDP
	4z4DTq3MCrC21v2aip0r8rbFAM88BuE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-YvqObOyDPT675tMG43FfYA-1; Thu,
 11 Sep 2025 19:06:23 -0400
X-MC-Unique: YvqObOyDPT675tMG43FfYA-1
X-Mimecast-MFC-AGG-ID: YvqObOyDPT675tMG43FfYA_1757631982
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A17BF1955EA4;
	Thu, 11 Sep 2025 23:06:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97BF51800451;
	Thu, 11 Sep 2025 23:06:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix untrusted unsigned subtract
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2039267.1757631977.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 00:06:17 +0100
Message-ID: <2039268.1757631977@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix the following Smatch Smatch static checker warning:

   net/rxrpc/rxgk_app.c:65 rxgk_yfs_decode_ticket()
   warn: untrusted unsigned subtract. 'ticket_len - 10 * 4'

by prechecking the length of what we're trying to extract in two places in
the token and decoding for a response packet.

Also use sizeof() on the struct we're extracting rather specifying the siz=
e
numerically to be consistent with the other related statements.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (=
GSSAPI)")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lists.infradead.org/pipermail/linux-afs/2025-September/010=
135.html
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
 net/rxrpc/rxgk_app.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index df684b5a8531..30275cb5ba3e 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -54,6 +54,10 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *con=
n, struct sk_buff *skb,
 =

 	_enter("");
 =

+	if (ticket_len < 10 * sizeof(__be32))
+		return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
+					rxgk_abort_resp_short_yfs_tkt);
+
 	/* Get the session key length */
 	ret =3D skb_copy_bits(skb, ticket_offset, tmp, sizeof(tmp));
 	if (ret < 0)
@@ -195,22 +199,23 @@ int rxgk_extract_token(struct rxrpc_connection *conn=
, struct sk_buff *skb,
 		__be32 token_len;
 	} container;
 =

+	if (token_len < sizeof(container))
+		goto short_packet;
+
 	/* Decode the RXGK_TokenContainer object.  This tells us which server
 	 * key we should be using.  We can then fetch the key, get the secret
 	 * and set up the crypto to extract the token.
 	 */
 	if (skb_copy_bits(skb, token_offset, &container, sizeof(container)) < 0)
-		return rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
-					rxgk_abort_resp_tok_short);
+		goto short_packet;
 =

 	kvno		=3D ntohl(container.kvno);
 	enctype		=3D ntohl(container.enctype);
 	ticket_len	=3D ntohl(container.token_len);
 	ticket_offset	=3D token_offset + sizeof(container);
 =

-	if (xdr_round_up(ticket_len) > token_len - 3 * 4)
-		return rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
-					rxgk_abort_resp_tok_short);
+	if (xdr_round_up(ticket_len) > token_len - sizeof(container))
+		goto short_packet;
 =

 	_debug("KVNO %u", kvno);
 	_debug("ENC  %u", enctype);
@@ -285,4 +290,8 @@ int rxgk_extract_token(struct rxrpc_connection *conn, =
struct sk_buff *skb,
 	 * also come out this way if the ticket decryption fails.
 	 */
 	return ret;
+
+short_packet:
+	return rxrpc_abort_conn(conn, skb, RXGK_PACKETSHORT, -EPROTO,
+				rxgk_abort_resp_tok_short);
 }


