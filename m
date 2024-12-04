Return-Path: <netdev+bounces-148849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279219E346B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0936285BCF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5C1922E8;
	Wed,  4 Dec 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmIOtPIm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40314191484
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298467; cv=none; b=hEYRGeImdNd48pcbGAk8ctM82CnST/ENHv6eXNqFlqCOeLTZV5iQ4s5pTZlbx3tofFVA+YzveaKmeGrn6XU/ie5wLDJk0KuJUGMG9sKL/wjEhem5EK+1HCUsN5k0jxsSh6ZUoZmqiaLkdCdDvZLUBZqATRGxGu5IERMrn0kfTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298467; c=relaxed/simple;
	bh=nPLLAv80bSsdFzVdKVGyYb87epdi2nVWr770CVc/eEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVBF33ig1lKFzerHkyq5TdxX9KAod9VzdWfxC38PGPP3usX7fx7I2ZzhPXyTx9KiCh1ncwfU3IZAmQewyHAHZZ5lyotxXKzPZd9BE1ZwbLNl0W5OkSaJDQpXWIfY5xKrX1CIXNs3BNyoQbVCGgqDBTFlks1QrFQlAC4l9c9kqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmIOtPIm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjpai5tSDIjcrPtWrI7pL4/bw52/8YrvhGJIA2364Ug=;
	b=KmIOtPImYEiBSLfjRFhSo3Db/+vInbBBrip9gtEHvfECKaLfOJ8Fa1jZivEDW8VD7MyCDM
	0cbtG9YLwatrT46bc/ciTGw2kvIrUdsX9Ric+/U9FphPw6HI2oSEWs9uIquY+jfaBI4qeC
	cTg+6frqNVmsu/nAnTqqVyYUCZ1i/5w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-LaVSvlZUMUO0pf_z8UEqvw-1; Wed,
 04 Dec 2024 02:47:40 -0500
X-MC-Unique: LaVSvlZUMUO0pf_z8UEqvw-1
X-Mimecast-MFC-AGG-ID: LaVSvlZUMUO0pf_z8UEqvw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B41691955F38;
	Wed,  4 Dec 2024 07:47:38 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB3CE1956089;
	Wed,  4 Dec 2024 07:47:35 +0000 (UTC)
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
Subject: [PATCH net-next v2 05/39] rxrpc: Don't set the MORE-PACKETS rxrpc wire header flag
Date: Wed,  4 Dec 2024 07:46:33 +0000
Message-ID: <20241204074710.990092-6-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The MORE-PACKETS rxrpc header flag hasn't actually been looked at by
anything since 1988 and not all implementations generate it.

Change rxrpc so that it doesn't set MORE-PACKETS at all rather than setting
it inconsistently.

Signed-off-by: David Howells <dhowells@redhat.com>
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


