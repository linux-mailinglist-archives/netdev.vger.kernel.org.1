Return-Path: <netdev+bounces-264365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BA4EZ53qWl77wAAu9opvQ
	(envelope-from <netdev+bounces-264365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:31:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D01211B28
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4DCD30330DA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D762382386;
	Thu,  5 Mar 2026 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OW36hWi1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09539E183
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713875; cv=none; b=Nse/5KnbD/jP6XW453K7wNphUbnCC/TgyuonGfJKuLt7OAjO3ln1AQl8kOCwMXlVOaYAsPaJARXeU55UUmW02fel0t/535PJnVo5lDU0/xt9JHaV9Z69aujE4SY0Etksnth6OB1yZCQ/NEn+cx6ah6F9Y/NtxwUzLvottxvXyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713875; c=relaxed/simple;
	bh=M0amzjYDjOcDwk9Xa9WDvX5EOw6fUANFKMHFxJuIIkk=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=Tdc6WI7oILpKih6s+j5Q4qG28JYrDr6XRu+U2auTSKWbHenzYUe697GjG4PACwm4XQyG649b/aiDANhEIHwGHTGXEv4FEZCb3bzTM3rYgISQgHtf3YoFhQvVZdCf8YKAucs2/zCdeLtoxBRVAgjEOhN2NxYhIyuCfeExXU5OvdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OW36hWi1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772713872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZqdId1iMtj4MPWpnH/YCF5w6wH/a+rmaUSETnQbvze0=;
	b=OW36hWi1bAuL8D4/51ksP/bSq9GIHhmrgyQYrgR5b38xTdR06vtk5rU1AIcdciZJmLCBME
	R/oDZe+UHPTyq5VYavTzamvTss3A+bonSfkiIsyqM98sJdLpvBj9hPiNnsfTZHmSJjwMks
	taggYgFLGnn4J7Og3CuWM3u4uyIfwIY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-i7K1aqaGOdSglcqmJumKVA-1; Thu,
 05 Mar 2026 07:31:09 -0500
X-MC-Unique: i7K1aqaGOdSglcqmJumKVA-1
X-Mimecast-MFC-AGG-ID: i7K1aqaGOdSglcqmJumKVA_1772713868
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C799419560AD;
	Thu,  5 Mar 2026 12:31:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C47E180075E;
	Thu,  5 Mar 2026 12:31:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Miaoqian Lin <linmq006@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc, afs: Fix missing error pointer check after rxrpc_kernel_lookup_peer()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <368271.1772713861.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 12:31:01 +0000
Message-ID: <368272.1772713861@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: B0D01211B28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,auristor.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264365-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email,davemloft.net:email,auristor.com:email]
X-Rspamd-Action: no action

    =

rxrpc_kernel_lookup_peer() can also return error pointers in addition to
NULL, so just checking for NULL is not sufficient.

Fix this by:

 (1) Changing rxrpc_kernel_lookup_peer() to return -ENOMEM rather than NUL=
L
     on allocation failure.

 (2) Making the callers in afs use IS_ERR() and PTR_ERR() to pass on the
     error code returned.

Fixes: 72904d7b9bfb ("rxrpc, afs: Allow afs to pin rxrpc_peer objects")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Co-developed-by: David Howells <dhowells@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 fs/afs/addr_list.c   |    8 ++++----
 net/rxrpc/af_rxrpc.c |    8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index a936f9ea5610..63bf096b721a 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -298,8 +298,8 @@ int afs_merge_fs_addr4(struct afs_net *net, struct afs=
_addr_list *alist,
 	srx.transport.sin.sin_addr.s_addr =3D xdr;
 =

 	peer =3D rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
-	if (!peer)
-		return -ENOMEM;
+	if (IS_ERR(peer))
+		return PTR_ERR(peer);
 =

 	for (i =3D 0; i < alist->nr_ipv4; i++) {
 		if (peer =3D=3D alist->addrs[i].peer) {
@@ -342,8 +342,8 @@ int afs_merge_fs_addr6(struct afs_net *net, struct afs=
_addr_list *alist,
 	memcpy(&srx.transport.sin6.sin6_addr, xdr, 16);
 =

 	peer =3D rxrpc_kernel_lookup_peer(net->socket, &srx, GFP_KERNEL);
-	if (!peer)
-		return -ENOMEM;
+	if (IS_ERR(peer))
+		return PTR_ERR(peer);
 =

 	for (i =3D alist->nr_ipv4; i < alist->nr_addrs; i++) {
 		if (peer =3D=3D alist->addrs[i].peer) {
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 0c2c68c4b07e..0f90272ac254 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -267,12 +267,13 @@ static int rxrpc_listen(struct socket *sock, int bac=
klog)
  * Lookup or create a remote transport endpoint record for the specified
  * address.
  *
- * Return: The peer record found with a reference, %NULL if no record is =
found
- * or a negative error code if the address is invalid or unsupported.
+ * Return: The peer record found with a reference or a negative error cod=
e if
+ * the address is invalid or unsupported.
  */
 struct rxrpc_peer *rxrpc_kernel_lookup_peer(struct socket *sock,
 					    struct sockaddr_rxrpc *srx, gfp_t gfp)
 {
+	struct rxrpc_peer *peer;
 	struct rxrpc_sock *rx =3D rxrpc_sk(sock->sk);
 	int ret;
 =

@@ -280,7 +281,8 @@ struct rxrpc_peer *rxrpc_kernel_lookup_peer(struct soc=
ket *sock,
 	if (ret < 0)
 		return ERR_PTR(ret);
 =

-	return rxrpc_lookup_peer(rx->local, srx, gfp);
+	peer =3D rxrpc_lookup_peer(rx->local, srx, gfp);
+	return peer ?: ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(rxrpc_kernel_lookup_peer);
 =


