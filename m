Return-Path: <netdev+bounces-72875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524285A04A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592521C2133E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F399286B2;
	Mon, 19 Feb 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="cnlGHRd/"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C125630
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336441; cv=none; b=nMsMFewRlhD/Of0WxwPwFRm3Qd6xX1UCbooHlsbsJKSTAD7hlxc+ioIiVc5XcE/4oQkViegUwqbfQ+bYvrX5iFFCEaLhsZq6E/14+ZV7i44ojoOEyMNYYdi8aKFBt3QpgiqsX5tYrug4ne92+Liq/nLk/KuaoREUPXFGenHvfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336441; c=relaxed/simple;
	bh=0QuibDSUc8SSRXZnjbsbWS32AZN3MBKOnUhxefL0j2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SyM+4oNTFXvHjq5bwOy+T1dLlyMAnHhoXcHzIKXH1SrW12ETaEX1NbICEs21ZE2BoKWR5GzW3+BAdW9Y1NZ0TjY/JkDrwshLS7m/cVEHRqk8mQLeMlqodHwTBReHvzmbNkxlYQN09gyikAa7hVpTckN7va+1phPQZbukHC1Sn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=cnlGHRd/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7735720489; Mon, 19 Feb 2024 17:53:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336435;
	bh=zWPzklpWEFBCGzJFIhpeXaDRfeNWsBFubkOcIB9JSOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnlGHRd/iuhSDDpKLMC/ttI7siRhdsCt3UdqK4EI8KGlE3Za04NhelSsWLq76uDb4
	 dXFaXOqW0ZgrGvpWFXH1QtyShS7Mgn2c6L69UduZn4HweZDzvpGIA6RFwYiRwGZ6Gi
	 VRbJ3zr0XcIKxvNvzQ9a2pqI4ZYRbZfn5uv5jC4UinorvYQK4ArBQyYeAdlrqGigk5
	 GL0XxjYvxp/JEIcQPbEfiS0oJ4672gJ++rCASUhMKXW3n2OIAKql0ocdNzPkXq7MNI
	 tOt4leTNjoXeH8bicvO+/nCNbPtD7Gz7S5WSua9z8pUrDW5x2FSlNSzuK3jcA1UcJk
	 lzpnUN8XKoXPw==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 06/11] net: mctp: provide a more specific tag allocation ioctl
Date: Mon, 19 Feb 2024 17:51:51 +0800
Message-Id: <51d5c788d3931fdb0edb50a56e3010245025a394.1708335994.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
References: <cover.1708335994.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have net-specific tags, extend the tag allocation ioctls
(SIOCMCTPALLOCTAG / SIOCMCTPDROPTAG) to allow a network parameter to be
passed to the tag allocation.

We also add a local_addr member to the ioc struct, to allow for a future
finer-grained tag allocation using local EIDs too. We don't add any
specific support for that now though, so require MCTP_ADDR_ANY or
MCTP_ADDR_NULL for those at present.

The old ioctls will still work, but allocate for the default MCTP net.
These are now marked as deprecated in the header.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v2:
 - fix forwards-compat check on local_peer, based on feedback from Dan
   Carpenter <dan.carpenter@linaro.org>
---
 include/uapi/linux/mctp.h |  32 +++++++++++
 net/mctp/af_mctp.c        | 117 +++++++++++++++++++++++++++++++-------
 2 files changed, 129 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/mctp.h b/include/uapi/linux/mctp.h
index 154ab56651f1..e1db65df9359 100644
--- a/include/uapi/linux/mctp.h
+++ b/include/uapi/linux/mctp.h
@@ -50,7 +50,14 @@ struct sockaddr_mctp_ext {
 
 #define SIOCMCTPALLOCTAG	(SIOCPROTOPRIVATE + 0)
 #define SIOCMCTPDROPTAG		(SIOCPROTOPRIVATE + 1)
+#define SIOCMCTPALLOCTAG2	(SIOCPROTOPRIVATE + 2)
+#define SIOCMCTPDROPTAG2	(SIOCPROTOPRIVATE + 3)
 
+/* Deprecated: use mctp_ioc_tag_ctl2 / TAG2 ioctls instead, which defines the
+ * MCTP network ID as part of the allocated tag. Using this assumes the default
+ * net ID for allocated tags, which may not give correct behaviour on system
+ * with multiple networks configured.
+ */
 struct mctp_ioc_tag_ctl {
 	mctp_eid_t	peer_addr;
 
@@ -65,4 +72,29 @@ struct mctp_ioc_tag_ctl {
 	__u16		flags;
 };
 
+struct mctp_ioc_tag_ctl2 {
+	/* Peer details: network ID, peer EID, local EID. All set by the
+	 * caller.
+	 *
+	 * Local EID must be MCTP_ADDR_NULL or MCTP_ADDR_ANY in current
+	 * kernels.
+	 */
+	unsigned int	net;
+	mctp_eid_t	peer_addr;
+	mctp_eid_t	local_addr;
+
+	/* Set by caller, but no flags defined currently. Must be 0 */
+	__u16		flags;
+
+	/* For SIOCMCTPALLOCTAG2: must be passed as zero, kernel will
+	 * populate with the allocated tag value. Returned tag value will
+	 * always have TO and PREALLOC set.
+	 *
+	 * For SIOCMCTPDROPTAG2: userspace provides tag value to drop, from
+	 * a prior SIOCMCTPALLOCTAG2 call (and so must have TO and PREALLOC set).
+	 */
+	__u8		tag;
+
+};
+
 #endif /* __UAPI_MCTP_H */
diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index 05315a422ffb..de52a9191da0 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -350,30 +350,102 @@ static int mctp_getsockopt(struct socket *sock, int level, int optname,
 	return -EINVAL;
 }
 
-static int mctp_ioctl_alloctag(struct mctp_sock *msk, unsigned long arg)
+/* helpers for reading/writing the tag ioc, handling compatibility across the
+ * two versions, and some basic API error checking
+ */
+static int mctp_ioctl_tag_copy_from_user(unsigned long arg,
+					 struct mctp_ioc_tag_ctl2 *ctl,
+					 bool tagv2)
+{
+	struct mctp_ioc_tag_ctl ctl_compat;
+	unsigned long size;
+	void *ptr;
+	int rc;
+
+	if (tagv2) {
+		size = sizeof(*ctl);
+		ptr = ctl;
+	} else {
+		size = sizeof(ctl_compat);
+		ptr = &ctl_compat;
+	}
+
+	rc = copy_from_user(ptr, (void __user *)arg, size);
+	if (rc)
+		return -EFAULT;
+
+	if (!tagv2) {
+		/* compat, using defaults for new fields */
+		ctl->net = MCTP_INITIAL_DEFAULT_NET;
+		ctl->peer_addr = ctl_compat.peer_addr;
+		ctl->local_addr = MCTP_ADDR_ANY;
+		ctl->flags = ctl_compat.flags;
+		ctl->tag = ctl_compat.tag;
+	}
+
+	if (ctl->flags)
+		return -EINVAL;
+
+	if (ctl->local_addr != MCTP_ADDR_ANY &&
+	    ctl->local_addr != MCTP_ADDR_NULL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mctp_ioctl_tag_copy_to_user(unsigned long arg,
+				       struct mctp_ioc_tag_ctl2 *ctl,
+				       bool tagv2)
+{
+	struct mctp_ioc_tag_ctl ctl_compat;
+	unsigned long size;
+	void *ptr;
+	int rc;
+
+	if (tagv2) {
+		ptr = ctl;
+		size = sizeof(*ctl);
+	} else {
+		ctl_compat.peer_addr = ctl->peer_addr;
+		ctl_compat.tag = ctl->tag;
+		ctl_compat.flags = ctl->flags;
+
+		ptr = &ctl_compat;
+		size = sizeof(ctl_compat);
+	}
+
+	rc = copy_to_user((void __user *)arg, ptr, size);
+	if (rc)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int mctp_ioctl_alloctag(struct mctp_sock *msk, bool tagv2,
+			       unsigned long arg)
 {
 	struct net *net = sock_net(&msk->sk);
 	struct mctp_sk_key *key = NULL;
-	struct mctp_ioc_tag_ctl ctl;
+	struct mctp_ioc_tag_ctl2 ctl;
 	unsigned long flags;
 	u8 tag;
+	int rc;
 
-	if (copy_from_user(&ctl, (void __user *)arg, sizeof(ctl)))
-		return -EFAULT;
+	rc = mctp_ioctl_tag_copy_from_user(arg, &ctl, tagv2);
+	if (rc)
+		return rc;
 
 	if (ctl.tag)
 		return -EINVAL;
 
-	if (ctl.flags)
-		return -EINVAL;
-
-	key = mctp_alloc_local_tag(msk, MCTP_INITIAL_DEFAULT_NET,
-				   MCTP_ADDR_ANY, ctl.peer_addr, true, &tag);
+	key = mctp_alloc_local_tag(msk, ctl.net, MCTP_ADDR_ANY,
+				   ctl.peer_addr, true, &tag);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
 	ctl.tag = tag | MCTP_TAG_OWNER | MCTP_TAG_PREALLOC;
-	if (copy_to_user((void __user *)arg, &ctl, sizeof(ctl))) {
+	rc = mctp_ioctl_tag_copy_to_user(arg, &ctl, tagv2);
+	if (rc) {
 		unsigned long fl2;
 		/* Unwind our key allocation: the keys list lock needs to be
 		 * taken before the individual key locks, and we need a valid
@@ -385,28 +457,27 @@ static int mctp_ioctl_alloctag(struct mctp_sock *msk, unsigned long arg)
 		__mctp_key_remove(key, net, fl2, MCTP_TRACE_KEY_DROPPED);
 		mctp_key_unref(key);
 		spin_unlock_irqrestore(&net->mctp.keys_lock, flags);
-		return -EFAULT;
+		return rc;
 	}
 
 	mctp_key_unref(key);
 	return 0;
 }
 
-static int mctp_ioctl_droptag(struct mctp_sock *msk, unsigned long arg)
+static int mctp_ioctl_droptag(struct mctp_sock *msk, bool tagv2,
+			      unsigned long arg)
 {
 	struct net *net = sock_net(&msk->sk);
-	struct mctp_ioc_tag_ctl ctl;
+	struct mctp_ioc_tag_ctl2 ctl;
 	unsigned long flags, fl2;
 	struct mctp_sk_key *key;
 	struct hlist_node *tmp;
 	int rc;
 	u8 tag;
 
-	if (copy_from_user(&ctl, (void __user *)arg, sizeof(ctl)))
-		return -EFAULT;
-
-	if (ctl.flags)
-		return -EINVAL;
+	rc = mctp_ioctl_tag_copy_from_user(arg, &ctl, tagv2);
+	if (rc)
+		return rc;
 
 	/* Must be a local tag, TO set, preallocated */
 	if ((ctl.tag & ~MCTP_TAG_MASK) != (MCTP_TAG_OWNER | MCTP_TAG_PREALLOC))
@@ -422,6 +493,7 @@ static int mctp_ioctl_droptag(struct mctp_sock *msk, unsigned long arg)
 		 */
 		spin_lock_irqsave(&key->lock, fl2);
 		if (key->manual_alloc &&
+		    ctl.net == key->net &&
 		    ctl.peer_addr == key->peer_addr &&
 		    tag == key->tag) {
 			__mctp_key_remove(key, net, fl2,
@@ -439,12 +511,17 @@ static int mctp_ioctl_droptag(struct mctp_sock *msk, unsigned long arg)
 static int mctp_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct mctp_sock *msk = container_of(sock->sk, struct mctp_sock, sk);
+	bool tagv2 = false;
 
 	switch (cmd) {
+	case SIOCMCTPALLOCTAG2:
 	case SIOCMCTPALLOCTAG:
-		return mctp_ioctl_alloctag(msk, arg);
+		tagv2 = cmd == SIOCMCTPALLOCTAG2;
+		return mctp_ioctl_alloctag(msk, tagv2, arg);
 	case SIOCMCTPDROPTAG:
-		return mctp_ioctl_droptag(msk, arg);
+	case SIOCMCTPDROPTAG2:
+		tagv2 = cmd == SIOCMCTPDROPTAG2;
+		return mctp_ioctl_droptag(msk, tagv2, arg);
 	}
 
 	return -EINVAL;
-- 
2.39.2


