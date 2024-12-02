Return-Path: <netdev+bounces-148072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6411A9E074D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E580B3231A
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84383207A3B;
	Mon,  2 Dec 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbadNAHb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE22207A2B
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149889; cv=none; b=DzEZaKN4vsI7raYFuwot6EK5QOtTaXbh3e7RX9za+shM+Lz7kVh/LWcwgbWOeoeZorLgBu2THRU8ToErT33vgH6vggEWeIPgSJ0i7kXopa9Wb3ziu88ZRMG1N79cXWSfaT9BXibZT7FxkwTv95OF9aXeRyoJCqiLCcy1JwbcT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149889; c=relaxed/simple;
	bh=c+yOwyyxQYG08akHuv3PKVnnno4S/E/jkgJR2qyHucM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/cWugv5sVrX5WCi3D6cf6dp6dbbMkB33ZDgt43WyOUvDvCe/EjH8/+1RKz4Sh0N7iUGSJM4/wIcyx//Osl7j8QjhWQ8+e7A0l6OmTf7ULMl3au4pnyMOn3KZSIZMbFtvJAECeceyVUzkC9ANuS8kqGfDhEYeZTnTgDd8+YbFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbadNAHb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UxMeOVuQD05rf41KERxBJE40Z+FM1XZR5vvRZvaEiVw=;
	b=DbadNAHbEboi9FVUchI6440nTv6YCv7Mwga+dZgHW+ouH9NL0crmAsam3AFBGOFcWUSFFt
	8v4zzIepyIKY1z1dPMjk93cMMOPqUXF34VreYCku93ans/66TjIlClRDmSe8tfUKjs9dvH
	vOr4FtrZ7W9Tyd1u+aU7qxccnu7DmJ8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-1KS-4Ai1MwWnbcZKnpOTqA-1; Mon,
 02 Dec 2024 09:31:22 -0500
X-MC-Unique: 1KS-4Ai1MwWnbcZKnpOTqA-1
X-Mimecast-MFC-AGG-ID: 1KS-4Ai1MwWnbcZKnpOTqA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0846818EBB5B;
	Mon,  2 Dec 2024 14:31:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCA241955F41;
	Mon,  2 Dec 2024 14:31:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/37] rxrpc: Don't set the MORE-PACKETS rxrpc wire header flag
Date: Mon,  2 Dec 2024 14:30:22 +0000
Message-ID: <20241202143057.378147-5-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The MORE-PACKETS rxrpc header flag hasn't actually been looked at by
anything since 1988 and not all implementations generate it.

Change rxrpc so that it doesn't set MORE-PACKETS at all rather than setting
it inconsistently.

cc: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/sendmsg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index b04afb5df241..546abb463c3f 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -385,9 +385,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		    (msg_data_left(msg) == 0 && !more)) {
 			if (msg_data_left(msg) == 0 && !more)
 				txb->flags |= RXRPC_LAST_PACKET;
-			else if (call->tx_top - call->acks_hard_ack <
-				 call->tx_winsize)
-				txb->flags |= RXRPC_MORE_PACKETS;
 
 			ret = call->security->secure_packet(call, txb);
 			if (ret < 0)


