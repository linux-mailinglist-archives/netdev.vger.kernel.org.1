Return-Path: <netdev+bounces-292432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLpyNGlEF2ov/AcAu9opvQ
	(envelope-from <netdev+bounces-292432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E235E9775
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB47830331AF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257F37474A;
	Wed, 27 May 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffHGlQNa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D4371877
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909727; cv=none; b=mW79RG/9eplJCPK1AqoFNq/mNncqhkugHQoGgn3ddtUOhgtX5ZPv77iVCg4izg41uQ82rjYYHBWpUfhH2xjitnwTbdc7kamgMtWIdO6PC6BJQlKzL1gsaDHSpk5FX8C9TxBCawqOfYVpetiHy0668KEgGRGlDpLzSRcMvodZWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909727; c=relaxed/simple;
	bh=rxq7vV/lcaK5E8W7W2VfRB3sKjcdFzJ8GfMCOCQqy8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ieeSibGklvIdppKGgXj/Oj2Q3SKi7xv21t80oUPVbgF/xsSi+8WPCER+oSm1e2QWxuWt+8NGuZs7rzrXIFf43PiVCiS2vdhOeVoamURGjLQAqNPN9o0gl116d9ld4UprRlq2GA11HgLwxtPwYiasSe47Ugod8xjeMypGechUg34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffHGlQNa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779909725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fwcxL7DaYuCI6WBqbALUoDBpnAZ/JLQFJt7BfUd1Yes=;
	b=ffHGlQNa9+/brRGoIfAT1LjwvZje0mlZBiImFHgbVSmS708Zon0dmMrIhwkPXmqH0VwnAz
	H+lErdPIAhokFZbyDoWgDPZW5a3IbinCefwl+kgkKhkRoo6imveNgxi3STXgypVsbsFfeT
	1UtuoXK/X+SjHonWEX2e0AAGaIuFNz8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-y5q4ui6RPjiaUDZkuEN2YQ-1; Wed,
 27 May 2026 15:22:01 -0400
X-MC-Unique: y5q4ui6RPjiaUDZkuEN2YQ-1
X-Mimecast-MFC-AGG-ID: y5q4ui6RPjiaUDZkuEN2YQ_1779909720
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1E1319560B5;
	Wed, 27 May 2026 19:21:59 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.77])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 465F519560AB;
	Wed, 27 May 2026 19:21:55 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Ricardo Robaina <rrobaina@redhat.com>,
	Steve Grubb <sgrubb@redhat.com>
Subject: [PATCH v3] netlink, audit: prevent false ENOBUFS on timeout expiry
Date: Wed, 27 May 2026 16:21:50 -0300
Message-ID: <20260527192150.949400-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292432-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrobaina@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76E235E9775
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks
on the netlink socket wait queue (nlk->wait). If the wait timeout
fully expires (timeo == 0), netlink mistakenly interprets the zeroed
timeout as a non-blocking request on its next retry iteration. It
then triggers netlink_overrun that drops the event and poisons the
socket with ENOBUFS. This bypasses the audit subsystem's internal
retry backlog and falsely returns an error to user-space:

 auditd[]: Error receiving audit netlink packet (No buffer space available)

Unlike standard netlink users, the audit subsystem has a hard
requirement to never silently drop security records. It uses a short
finite socket timeout (sk_sndtimeo = HZ/10) to escape a stalled
auditd and safely requeue the message internally. However, once
netlink_overrun() executes, the ENOBUFS state is set on the
receiving socket, and the audit subsystem has no mechanism to
intercept or clear this from the outside.

Furthermore, kauditd does not hold the socket lock during slow I/O;
the sleep in netlink_attachskb utilizes schedule_timeout on the
wait queue, meaning this process does not abuse the socket lock.

To fix this without impacting other subsystems, introduce an
explicit NETLINK_UNICAST_TIMED (2) constant. When a caller opts
into this contract and exhausts its timeout budget, netlink
intercepts the zeroed timeo state, safely frees the skb, and
returns -EAGAIN.

This approach leaves standard blocking (0) and non-blocking (1 or
MSG_DONTWAIT) behaviors strictly untouched, ensuring that subsystems
using default timeouts (like RDMA/IWPM) are insulated from this
change and will not experience silent packet drops.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v3:
- Reintroduced explicit NETLINK_UNICAST_TIMED from v1,
  but using discrete value (2) instead.

Changes in v2:
- Use the simple check (timeo == 0 && !nonblock) to detect
  expired timeout, avoiding adding a new NETLINK flag.

 include/linux/netlink.h  | 11 +++++++++++
 kernel/audit.c           | 14 ++++++++------
 net/netlink/af_netlink.c | 18 ++++++++++++++++--
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 882e9c1b6c1d..26df738db644 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -226,6 +226,17 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 int netlink_has_listeners(struct sock *sk, unsigned int group);
 bool netlink_strict_get_check(struct sk_buff *skb);
 
+/*
+ * netlink_unicast() 'nonblock' argument:
+ *   0              - blocking with default sk_sndtimeo (may be infinite)
+ *   MSG_DONTWAIT   - nonblocking, immediate -EAGAIN if socket is congested
+ *   NETLINK_UNICAST_TIMED - blocking with finite sk_sndtimeo; if the timeout
+ *                   expires mid-wait, return -EAGAIN without triggering
+ *                   netlink_overrun() on retry.  For callers that manage
+ *                   their own retry/backlog policy (e.g. audit).
+ */
+#define NETLINK_UNICAST_TIMED 2
+
 int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
 int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
 		      __u32 group, gfp_t allocation);
diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..a20cced03a73 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -753,7 +753,7 @@ static int auditd_send_unicast_skb(struct sk_buff *skb)
 	portid = ac->portid;
 	rcu_read_unlock();
 
-	rc = netlink_unicast(sk, skb, portid, 0);
+	rc = netlink_unicast(sk, skb, portid, NETLINK_UNICAST_TIMED);
 	put_net(net);
 	if (rc < 0)
 		goto err;
@@ -811,7 +811,7 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
 retry:
 		/* grab an extra skb reference in case of error */
 		skb_get(skb);
-		rc = netlink_unicast(sk, skb, portid, 0);
+		rc = netlink_unicast(sk, skb, portid, NETLINK_UNICAST_TIMED);
 		if (rc < 0) {
 			/* send failed - try a few times unless fatal error */
 			if (++failed >= retry_limit ||
@@ -967,7 +967,7 @@ int audit_send_list_thread(void *_dest)
 	audit_ctl_unlock();
 
 	while ((skb = __skb_dequeue(&dest->q)) != NULL)
-		netlink_unicast(sk, skb, dest->portid, 0);
+		netlink_unicast(sk, skb, dest->portid, NETLINK_UNICAST_TIMED);
 
 	put_net(dest->net);
 	kfree(dest);
@@ -1018,9 +1018,11 @@ static int audit_send_reply_thread(void *arg)
 	audit_ctl_lock();
 	audit_ctl_unlock();
 
-	/* Ignore failure. It'll only happen if the sender goes away,
-	   because our timeout is set to infinite. */
-	netlink_unicast(audit_get_sk(reply->net), reply->skb, reply->portid, 0);
+	/*
+	 * Failure here means the sender went away or the finite
+	 * sk_sndtimeo expired; either way the reply is best-effort.
+	 */
+	netlink_unicast(audit_get_sk(reply->net), reply->skb, reply->portid, NETLINK_UNICAST_TIMED);
 	reply->skb = NULL;
 	audit_free_reply(reply);
 	return 0;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d..b1cdd21f410d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1333,7 +1333,11 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 
 	skb = netlink_trim(skb, gfp_any());
 
-	timeo = sock_sndtimeo(ssk, nonblock);
+	if (nonblock == NETLINK_UNICAST_TIMED)
+		timeo = ssk->sk_sndtimeo;
+	else
+		timeo = sock_sndtimeo(ssk, !!nonblock);
+
 retry:
 	sk = netlink_getsockbyportid(ssk, portid);
 	if (IS_ERR(sk)) {
@@ -1351,8 +1355,18 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	}
 
 	err = netlink_attachskb(sk, skb, &timeo, ssk);
-	if (err == 1)
+	if (err == 1) {
+		/* timeo may have been zeroed by schedule_timeout inside
+		 * netlink_attachskb. If the caller opted into timed-blocking
+		 * (NETLINK_UNICAST_TIMED), don't re-enter with timeo=0 as
+		 * that would misfire netlink_overrun on the next iteration.
+		 */
+		if (timeo == 0 && nonblock == NETLINK_UNICAST_TIMED) {
+			kfree_skb(skb);
+			return -EAGAIN;
+		}
 		goto retry;
+	}
 	if (err)
 		return err;
 
-- 
2.53.0


