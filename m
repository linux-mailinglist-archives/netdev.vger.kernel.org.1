Return-Path: <netdev+bounces-278723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FzMBDtY32n1RwAAu9opvQ
	(envelope-from <netdev+bounces-278723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:19:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5484E4027B5
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19AC430E7D62
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F68E1A6822;
	Wed, 15 Apr 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WPd509RE"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040203314B9
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244601; cv=none; b=XplI3wTjtUmRwSBRQI+Ee1zJCGjmz8i+Zsu6QvXd+HFbwMYusc35J6p8wyL78cndOU7LDZDXz56jDPRM7QiPFZl/dyfrzPmkkW5I9tbcyA0CnZ9rSLrSj7Sf3F470oOzR4IWC2iSfaJzWzwy9Tf9osmSdLOU9mdAE+SyPWiNQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244601; c=relaxed/simple;
	bh=j4lFk/+qPXA6eEIINMAlpfhUyBqIoNeTBMMGZLESU/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTy2beZbhcB8spvsaMDGDl6RHf/617dB5eP+bjoQYqQ40tNRDP9bL+cCclj9crqdlfzM5eCvEMkiqtXP2nULoSJinHDc++YV9+hOLmtJ9NSxBMxqJjDF58myVJqUc2FLkeX5z58wA7MGAaYpd9SFf5WsX9mZFzyQjpJCdVJO2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WPd509RE; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776244588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jm2OTrB1IC4L+3C9wJ4DJw6F0AdGiQYFZiRAbNrcD70=;
	b=WPd509RE6lp2b+OTbhpEbapnpR6N34LbMIueBdCgb89IWwy8E36ChS4JYQznXoYCxzK5P9
	CX/JFhBZhiopRUiFRhRodcYoKPgpsYrWClgOxKD9zJpsGwL8SbVJKGd/dl1SXhGD6z1Ldb
	ZlIyXqUpwHGiNqSneD9lsRycMMMhHMc=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>,
	linux-ppp@vger.kernel.org,
	Jaco Kroon <jaco@uls.co.za>,
	James Carlson <carlsonj@workingcode.com>,
	Dianne Skoll <dianne@skoll.ca>,
	Denys Fedoryshchenko <nuclearcat@nuclearcat.com>
Subject: [RFC PATCH net-next] pppoe: drop getsockname() syscall
Date: Wed, 15 Apr 2026 17:16:12 +0800
Message-ID: <20260415091614.266198-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278723-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 5484E4027B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The getsockname syscall is not used by pppd. It also has two flaws:
1. It does not hold the socket lock, so if the struct is being changed
   in pppoe_connect() simultaneously, it may see partial updates.
2. If the lower network device is renamed, this operation still returns
   the original name.

Given it is unused and buggy, remove the syscall.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
Note: sent as RFC, since net-next is closed.

 drivers/net/ppp/pppoe.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index d546a7af0d54..0d64a16715e2 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -688,22 +688,6 @@ static int pppoe_connect(struct socket *sock, struct sockaddr_unsized *uservaddr
 	goto end;
 }
 
-static int pppoe_getname(struct socket *sock, struct sockaddr *uaddr,
-		  int peer)
-{
-	int len = sizeof(struct sockaddr_pppox);
-	struct sockaddr_pppox sp;
-
-	sp.sa_family	= AF_PPPOX;
-	sp.sa_protocol	= PX_PROTO_OE;
-	memcpy(&sp.sa_addr.pppoe, &pppox_sk(sock->sk)->pppoe_pa,
-	       sizeof(struct pppoe_addr));
-
-	memcpy(uaddr, &sp, len);
-
-	return len;
-}
-
 static int pppoe_ioctl(struct socket *sock, unsigned int cmd,
 		unsigned long arg)
 {
@@ -1049,7 +1033,7 @@ static const struct proto_ops pppoe_ops = {
 	.connect	= pppoe_connect,
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
-	.getname	= pppoe_getname,
+	.getname	= sock_no_getname,
 	.poll		= datagram_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.43.0


