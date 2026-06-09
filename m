Return-Path: <netdev+bounces-297066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7qC5FhwgKGqH+QIAu9opvQ
	(envelope-from <netdev+bounces-297066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:15:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8C660E6F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 16:15:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=IQMHSzF4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297066-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297066-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 673AF304FBA7
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 14:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D731432B126;
	Tue,  9 Jun 2026 14:09:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7929323417
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 14:09:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014182; cv=none; b=OkAaxdiKGHKnOqJfU9Fp3NYLDtO06k86vJLxQtSc4+50B9+e+sV+bCeVYOvqSejX6M7A1xew3fov3+c9h4zLQaagMmg945J86yr43HPgPJsXO2NDTT3kr2RwvnmQs/1j1nJyaQ/1O1EcwPVx7/GesQT5NBnblgnCfM/6il76qPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014182; c=relaxed/simple;
	bh=BxD+O4Ijp5zMQqM/VS4Jgl27fQnTa0Nq3wzj1uocalI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcun8DNVuOs13KvOO5dQ+OKSfn/1cJv3zvei13eXF2ZHFiDfi6L+vN+B9HoOvdfZEBX0kufn3ksHMddM0qw314RiSFtc0z+NqvqJ3KAg/7laM3IsQKGyn/FsIJg2VYc8AJ2cryNetythJ0IrnY3VW0J9EB83o4vguPDnvBNrFIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQMHSzF4; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781014179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwJMUFPgjW5e6jvLKVE7Z0GhdQbtewOyNmik1nONpLc=;
	b=IQMHSzF4wflFZPJ/ROaQHQmy6lx+teSl3HOK4tANLvrU2Na7AsqpeNmyDhcwfBIMwa5MH1
	XPfAWBwZp0UF5JO3Q7Q111fRXc2OOdC08Bn+PcBmrtUPwqYttVSq7eFpSrpaqCxfxmYcLv
	SM+YXJlcL26XQZPVVXR2ZIf7UHqOvH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-7B027HZSNjOYMdMxxd4eGQ-1; Tue,
 09 Jun 2026 10:09:36 -0400
X-MC-Unique: 7B027HZSNjOYMdMxxd4eGQ-1
X-Mimecast-MFC-AGG-ID: 7B027HZSNjOYMdMxxd4eGQ_1781014174
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3625118501F8;
	Tue,  9 Jun 2026 14:09:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.43])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B32F1954102;
	Tue,  9 Jun 2026 14:09:30 +0000 (UTC)
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
	Hyunwoo Kim <imv4bel@gmail.com>,
	stable@kernel.org
Subject: [PATCH net 2/5] rxrpc: Don't move a peeked OOB message onto the pending queue
Date: Tue,  9 Jun 2026 15:09:06 +0100
Message-ID: <20260609140911.838677-3-dhowells@redhat.com>
In-Reply-To: <20260609140911.838677-1-dhowells@redhat.com>
References: <20260609140911.838677-1-dhowells@redhat.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-297066-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:imv4bel@gmail.com,m:stable@kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,infradead.org:email,auristor.com:email,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60E8C660E6F

From: Hyunwoo Kim <imv4bel@gmail.com>

rxrpc_recvmsg_oob() takes a received oob message off recvmsg_oobq and,
if a response is needed, moves it onto the pending_oobq tree. However,
only the unlink from recvmsg_oobq is guarded by MSG_PEEK; the move onto
pending_oobq always runs.

As a result, reading a challenge with MSG_PEEK leaves the skb on
recvmsg_oobq while also adding it to pending_oobq. Since struct
sk_buff's rbnode shares storage with its next and prev pointers,
rb_insert_color() overwrites the list linkage, and the skb, which holds
a single reference, becomes reachable from both queues at once.

When the socket is closed both queues are drained in turn. While
draining recvmsg_oobq, __skb_unlink() follows the next and prev
pointers that rbnode has overwritten and writes to a bad address. Also,
as the skb holds a single reference but is freed from each queue, both
the skb and the connection reference it holds are released twice. This
leads to memory corruption and to a use-after-free caused by the
connection refcount underflow.

MSG_PEEK does not consume the message from the queue, so only unlink it
from recvmsg_oobq and then move it onto pending_oobq or free it when
the message is actually consumed.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/recvmsg.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index a3cf5358f16e..82614cbdb60f 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -262,12 +262,13 @@ static int rxrpc_recvmsg_oob(struct socket *sock, struct msghdr *msg,
 		break;
 	}
 
-	if (!(flags & MSG_PEEK))
+	if (!(flags & MSG_PEEK)) {
 		skb_unlink(skb, &rx->recvmsg_oobq);
-	if (need_response)
-		rxrpc_add_pending_oob(rx, skb);
-	else
-		rxrpc_free_skb(skb, rxrpc_skb_put_oob);
+		if (need_response)
+			rxrpc_add_pending_oob(rx, skb);
+		else
+			rxrpc_free_skb(skb, rxrpc_skb_put_oob);
+	}
 	return ret;
 }
 


