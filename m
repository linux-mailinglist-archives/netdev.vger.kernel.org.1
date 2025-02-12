Return-Path: <netdev+bounces-165488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC39A324B4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0B27A3A50
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420DE209674;
	Wed, 12 Feb 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDtHNWdJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC072080F4
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739359296; cv=none; b=lY2aU45lqrO48FxKXrq+je83pi3VSh4ETt6umJNZXOZKg1DeAnlOkSPDBF2tMxx/CCkYWcHZSvyPnbjU/CcuOwX53apBmoIp7Ff1HzQOTi80OTgcY3j2E9F1MIUQtGbSStHfKRN625OUD9XxK10UWICxkTO/dTHCWEnb6Ys2QLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739359296; c=relaxed/simple;
	bh=9zjcqeUtecmQeRWAWpi41Dkd2R98ynxq3ouQNuuU3ns=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=H69/g03KRiHSG1Ovvdc9oK4jvnOrgrk/hb3Ev+BJSw1bTEvzIs3/hRcvRFswiP9gHVnushvCN49hxTWSP/fYI9WSr1E+HmIrtTl6S152d6ySZ0VoMcMZDRJFyMbJZixSpnr66dOHaNJBoWMt1oDq94sUBd2nydiwleA0nKwraXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDtHNWdJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739359293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NuZ2sxYlFvOf7TTka/ZiERQ0yfFGzXJI8jS/5gyfwX0=;
	b=YDtHNWdJGcGCSJLme9Sf9rUhCvml/kqIz3dwnG99n+iXLMa9WkgZUdxvpZHOPLljTBP1x0
	mChdcgx+k9Gzf8thtRrPQUJDDzwQZkKtnspXpnfpyIs1CYQDQsqyqs5jiutM/FoaXhvJUm
	kJ7QdChUplO+sb3pe7g2InUWrrA6jkw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-X9bnpjtdOgy9mUdRJ-bm0w-1; Wed,
 12 Feb 2025 06:21:30 -0500
X-MC-Unique: X9bnpjtdOgy9mUdRJ-bm0w-1
X-Mimecast-MFC-AGG-ID: X9bnpjtdOgy9mUdRJ-bm0w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76D941800983;
	Wed, 12 Feb 2025 11:21:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8EE46180056F;
	Wed, 12 Feb 2025 11:21:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Chuck Lever <chuck.lever@oracle.com>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix ipv6 path MTU discovery
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3517282.1739359284.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2025 11:21:24 +0000
Message-ID: <3517283.1739359284@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

rxrpc path MTU discovery currently only makes use of ICMPv4, but not
ICMPv6, which means that pmtud for IPv6 doesn't work correctly.  Fix it to
check for ICMPv6 messages also.

Fixes: eeaedc5449d9 ("rxrpc: Implement path-MTU probing using padded PING =
ACKs (RFC8899)")
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
 net/rxrpc/peer_event.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index e874c31fa901..bc283da9ee40 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -169,6 +169,13 @@ void rxrpc_input_error(struct rxrpc_local *local, str=
uct sk_buff *skb)
 		goto out;
 	}
 =

+	if ((serr->ee.ee_origin =3D=3D SO_EE_ORIGIN_ICMP6 &&
+	     serr->ee.ee_type =3D=3D ICMPV6_PKT_TOOBIG &&
+	     serr->ee.ee_code =3D=3D 0)) {
+		rxrpc_adjust_mtu(peer, serr->ee.ee_info);
+		goto out;
+	}
+
 	rxrpc_store_error(peer, skb);
 out:
 	rxrpc_put_peer(peer, rxrpc_peer_put_input_error);


