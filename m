Return-Path: <netdev+bounces-179725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07271A7E606
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C136A1899DAB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC36207DFA;
	Mon,  7 Apr 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbUln0UZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D8206F05
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042313; cv=none; b=j0JIKpDDXFHiwFlNVQUrUZuqu7fNeAGpkLhHvjJlZd/Hh8E4VV2aWd5tobPndxlfSq+gNjXXGMhYuk+K+FtcE+DTXSJ0P79af3D0LP4g4BkjfiJaYuWg8Y3zvgcld0fOVJVT+CNJyOwpiWiuuB3qFqBXvg+9Rc7Y60grBwfc6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042313; c=relaxed/simple;
	bh=4rjnrKSxX8HaNn/73iXYKPvNT0PQ3HoDi0UZVDDqFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXVLNF+w8aaw/mw7SU1pii232oCUnSQOjgLJJ2IMvrIa/+d75Z/FA1F3KpYnweDet1jP4dtFHJmypPFQYglpieCnIdtU+z2zCrJnbnbPbTRT2SIGh19p6SbnVVoaZolO5GnrCugP/V2l/eRYNU3TBZ12Hb7ksxHFAFyyViDEmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbUln0UZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744042310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=basKNt/dVdZJlhN9BG9jPJBE93HbNbifjaEI7gA+qSw=;
	b=BbUln0UZvbXjTv1wvdbpGaIgcgK7c4LDqn1Hddb9aocrv6njgiDYb+to9Aw0Lx4oEm7T+q
	FU6wCBjzQPwe3WSSHzdGpK0zcPGijgOgQ+BEyzsIC3xgvzQnY8eQkIa0dxVIFOeH7NWeM9
	7iT8m7xE8w731Vt2rrIPRlyOujeZEBY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-sc0iDjMMOb6NFkbxOjyD6A-1; Mon,
 07 Apr 2025 12:11:46 -0400
X-MC-Unique: sc0iDjMMOb6NFkbxOjyD6A-1
X-Mimecast-MFC-AGG-ID: sc0iDjMMOb6NFkbxOjyD6A_1744042304
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEBC3180AF4E;
	Mon,  7 Apr 2025 16:11:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A2D81956094;
	Mon,  7 Apr 2025 16:11:39 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 01/13] rxrpc: kdoc: Update function descriptions and add link from rxrpc.rst
Date: Mon,  7 Apr 2025 17:11:14 +0100
Message-ID: <20250407161130.1349147-2-dhowells@redhat.com>
In-Reply-To: <20250407161130.1349147-1-dhowells@redhat.com>
References: <20250407161130.1349147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Update the kerneldoc function descriptions to add "Return:" sections for
AF_RXRPC exported functions that have return values to stop the kdoc
builder from throwing warnings.

Also add links from the rxrpc.rst API doc to add a function API reference
at the end.  (Note that the API doc really needs updating, but that's
beyond this patchset).

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
 Documentation/networking/rxrpc.rst | 11 +++++++++++
 net/rxrpc/af_rxrpc.c               | 21 +++++++++++++++++----
 net/rxrpc/key.c                    |  2 ++
 net/rxrpc/peer_object.c            | 22 ++++++++++++++++++----
 net/rxrpc/recvmsg.c                | 12 ++++++------
 net/rxrpc/sendmsg.c                |  7 +++++--
 net/rxrpc/server_key.c             |  2 ++
 7 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
index e807e18ba32a..2680abd1cb26 100644
--- a/Documentation/networking/rxrpc.rst
+++ b/Documentation/networking/rxrpc.rst
@@ -1172,3 +1172,14 @@ adjusted through sysctls in /proc/net/rxrpc/:
      header plus exactly 1412 bytes of data.  The terminal packet must contain
      a four byte header plus any amount of data.  In any event, a jumbo packet
      may not exceed rxrpc_rx_mtu in size.
+
+
+API Function Reference
+======================
+
+.. kernel-doc:: net/rxrpc/af_rxrpc.c
+.. kernel-doc:: net/rxrpc/key.c
+.. kernel-doc:: net/rxrpc/peer_object.c
+.. kernel-doc:: net/rxrpc/recvmsg.c
+.. kernel-doc:: net/rxrpc/sendmsg.c
+.. kernel-doc:: net/rxrpc/server_key.c
diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 86873399f7d5..2841ce72d7b8 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -265,7 +265,10 @@ static int rxrpc_listen(struct socket *sock, int backlog)
  * @gfp: Allocation flags
  *
  * Lookup or create a remote transport endpoint record for the specified
- * address and return it with a ref held.
+ * address.
+ *
+ * Return: The peer record found with a reference, %NULL if no record is found
+ * or a negative error code if the address is invalid or unsupported.
  */
 struct rxrpc_peer *rxrpc_kernel_lookup_peer(struct socket *sock,
 					    struct sockaddr_rxrpc *srx, gfp_t gfp)
@@ -283,9 +286,11 @@ EXPORT_SYMBOL(rxrpc_kernel_lookup_peer);
 
 /**
  * rxrpc_kernel_get_peer - Get a reference on a peer
- * @peer: The peer to get a reference on.
+ * @peer: The peer to get a reference on (may be NULL).
+ *
+ * Get a reference for a remote peer record (if not NULL).
  *
- * Get a record for the remote peer in a call.
+ * Return: The @peer argument.
  */
 struct rxrpc_peer *rxrpc_kernel_get_peer(struct rxrpc_peer *peer)
 {
@@ -296,6 +301,8 @@ EXPORT_SYMBOL(rxrpc_kernel_get_peer);
 /**
  * rxrpc_kernel_put_peer - Allow a kernel app to drop a peer reference
  * @peer: The peer to drop a ref on
+ *
+ * Drop a reference on a peer record.
  */
 void rxrpc_kernel_put_peer(struct rxrpc_peer *peer)
 {
@@ -320,10 +327,12 @@ EXPORT_SYMBOL(rxrpc_kernel_put_peer);
  *
  * Allow a kernel service to begin a call on the nominated socket.  This just
  * sets up all the internal tracking structures and allocates connection and
- * call IDs as appropriate.  The call to be used is returned.
+ * call IDs as appropriate.
  *
  * The default socket destination address and security may be overridden by
  * supplying @srx and @key.
+ *
+ * Return: The new call or an error code.
  */
 struct rxrpc_call *rxrpc_kernel_begin_call(struct socket *sock,
 					   struct rxrpc_peer *peer,
@@ -437,6 +446,8 @@ EXPORT_SYMBOL(rxrpc_kernel_put_call);
  *
  * Allow a kernel service to find out whether a call is still alive - whether
  * it has completed successfully and all received data has been consumed.
+ *
+ * Return: %true if the call is still ongoing and %false if it has completed.
  */
 bool rxrpc_kernel_check_life(const struct socket *sock,
 			     const struct rxrpc_call *call)
@@ -456,6 +467,8 @@ EXPORT_SYMBOL(rxrpc_kernel_check_life);
  *
  * Allow a kernel service to retrieve the epoch value from a service call to
  * see if the client at the other end rebooted.
+ *
+ * Return: The epoch of the call's connection.
  */
 u32 rxrpc_kernel_get_epoch(struct socket *sock, struct rxrpc_call *call)
 {
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 33e8302a79e3..8c99cf19b19d 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -531,6 +531,8 @@ EXPORT_SYMBOL(rxrpc_get_server_data_key);
  *
  * Generate a null RxRPC key that can be used to indicate anonymous security is
  * required for a particular domain.
+ *
+ * Return: The new key or a negative error code.
  */
 struct key *rxrpc_get_null_key(const char *keyname)
 {
diff --git a/net/rxrpc/peer_object.c b/net/rxrpc/peer_object.c
index 71b6e07bf161..e2f35e6c04d6 100644
--- a/net/rxrpc/peer_object.c
+++ b/net/rxrpc/peer_object.c
@@ -475,6 +475,8 @@ void rxrpc_destroy_all_peers(struct rxrpc_net *rxnet)
  * @call: The call to query
  *
  * Get a record for the remote peer in a call.
+ *
+ * Return: The call's peer record.
  */
 struct rxrpc_peer *rxrpc_kernel_get_call_peer(struct socket *sock, struct rxrpc_call *call)
 {
@@ -486,7 +488,9 @@ EXPORT_SYMBOL(rxrpc_kernel_get_call_peer);
  * rxrpc_kernel_get_srtt - Get a call's peer smoothed RTT
  * @peer: The peer to query
  *
- * Get the call's peer smoothed RTT in uS or UINT_MAX if we have no samples.
+ * Get the call's peer smoothed RTT.
+ *
+ * Return: The RTT in uS or %UINT_MAX if we have no samples.
  */
 unsigned int rxrpc_kernel_get_srtt(const struct rxrpc_peer *peer)
 {
@@ -499,7 +503,10 @@ EXPORT_SYMBOL(rxrpc_kernel_get_srtt);
  * @peer: The peer to query
  *
  * Get a pointer to the address from a peer record.  The caller is responsible
- * for making sure that the address is not deallocated.
+ * for making sure that the address is not deallocated.  A fake address will be
+ * substituted if %peer in NULL.
+ *
+ * Return: The rxrpc address record or a fake record.
  */
 const struct sockaddr_rxrpc *rxrpc_kernel_remote_srx(const struct rxrpc_peer *peer)
 {
@@ -512,7 +519,10 @@ EXPORT_SYMBOL(rxrpc_kernel_remote_srx);
  * @peer: The peer to query
  *
  * Get a pointer to the transport address from a peer record.  The caller is
- * responsible for making sure that the address is not deallocated.
+ * responsible for making sure that the address is not deallocated.  A fake
+ * address will be substituted if %peer in NULL.
+ *
+ * Return: The transport address record or a fake record.
  */
 const struct sockaddr *rxrpc_kernel_remote_addr(const struct rxrpc_peer *peer)
 {
@@ -527,7 +537,9 @@ EXPORT_SYMBOL(rxrpc_kernel_remote_addr);
  * @app_data: The data to set
  *
  * Set the app-specific data on a peer.  AF_RXRPC makes no effort to retain
- * anything the data might refer to.  The previous app_data is returned.
+ * anything the data might refer to.
+ *
+ * Return: The previous app_data.
  */
 unsigned long rxrpc_kernel_set_peer_data(struct rxrpc_peer *peer, unsigned long app_data)
 {
@@ -540,6 +552,8 @@ EXPORT_SYMBOL(rxrpc_kernel_set_peer_data);
  * @peer: The peer to query
  *
  * Retrieve the app-specific data from a peer.
+ *
+ * Return: The peer's app data.
  */
 unsigned long rxrpc_kernel_get_peer_data(const struct rxrpc_peer *peer)
 {
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 32cd5f1d541d..4c622752a569 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -477,14 +477,14 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
  * @_service: Where to store the actual service ID (may be upgraded)
  *
  * Allow a kernel service to receive data and pick up information about the
- * state of a call.  Returns 0 if got what was asked for and there's more
- * available, 1 if we got what was asked for and we're at the end of the data
- * and -EAGAIN if we need more data.
+ * state of a call.  Note that *@_abort should also be initialised to %0.
  *
- * Note that we may return -EAGAIN to drain empty packets at the end of the
- * data, even if we've already copied over the requested data.
+ * Note that we may return %-EAGAIN to drain empty packets at the end
+ * of the data, even if we've already copied over the requested data.
  *
- * *_abort should also be initialised to 0.
+ * Return: %0 if got what was asked for and there's more available, %1
+ * if we got what was asked for and we're at the end of the data and
+ * %-EAGAIN if we need more data.
  */
 int rxrpc_kernel_recv_data(struct socket *sock, struct rxrpc_call *call,
 			   struct iov_iter *iter, size_t *_len,
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 84dc6c94f23b..3f62c34ce7de 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -794,6 +794,8 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
  * appropriate to sending data.  No control data should be supplied in @msg,
  * nor should an address be supplied.  MSG_MORE should be flagged if there's
  * more data to come, otherwise this data will end the transmission phase.
+ *
+ * Return: %0 if successful and a negative error code otherwise.
  */
 int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
@@ -829,8 +831,9 @@ EXPORT_SYMBOL(rxrpc_kernel_send_data);
  * @error: Local error value
  * @why: Indication as to why.
  *
- * Allow a kernel service to abort a call, if it's still in an abortable state
- * and return true if the call was aborted, false if it was already complete.
+ * Allow a kernel service to abort a call if it's still in an abortable state.
+ *
+ * Return: %true if the call was aborted, %false if it was already complete.
  */
 bool rxrpc_kernel_abort_call(struct socket *sock, struct rxrpc_call *call,
 			     u32 abort_code, int error, enum rxrpc_abort_reason why)
diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
index e51940589ee5..eb7525e92951 100644
--- a/net/rxrpc/server_key.c
+++ b/net/rxrpc/server_key.c
@@ -152,6 +152,8 @@ int rxrpc_server_keyring(struct rxrpc_sock *rx, sockptr_t optval, int optlen)
  *
  * Set the server security keyring on an rxrpc socket.  This is used to provide
  * the encryption keys for a kernel service.
+ *
+ * Return: %0 if successful and a negative error code otherwise.
  */
 int rxrpc_sock_set_security_keyring(struct sock *sk, struct key *keyring)
 {


