Return-Path: <netdev+bounces-286799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WENGD4ojAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:44:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016E514957
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32A9A300690B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7384BCAAA;
	Mon, 11 May 2026 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLkIgD5S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE404ADD9C
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525037; cv=none; b=LGWdQzc7CbRMxXWjO22tpeEm5bhx3AhfAP9+QTst+ZpstHtAM9GaZm66ACNIFc4qmMzpHbuayJKc5cVtvIDYqED2ShgmQVt3YJps4EtTugpXcQmnZ455i9n2e3Dt7tYgX2V+Zv6thzTSuM6NJ2QnEEcXfzxi987IKUM6uCdsSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525037; c=relaxed/simple;
	bh=uHbYBiaVX6StCVS3mjmgpdx/r0kZ5jpDITVdz4K5N0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uHMmvD0k83xV927YmMpGUgkxqlFVX26UwuSD0ivou5peSle1GgLsLslK1aIO1qWxBP9EnBtuuMX9ULkaa2Ct6TGw86gdAwHjcPTsQu1F1wcIZr4//I/fQspP7p7TSOFhf3zjDJXMC5hD1DIH2u0rrh5scJHsytsjUE0mxhSlIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLkIgD5S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778525034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KVNlHnyH6Pi2wnbn/0P75oyyCBRiJQi88SIInmQq+gA=;
	b=TLkIgD5SZX4SD5UFPEDMtC15ZdowqRKBx+kIBAakAUddIeuaoWNUFO4sldBjFpQzMmc8vn
	OCPeqXKVDeiwMjvavAHORI//weziTb6FGvi08RiUdjuykUsIixboJgpS3EpHHFhIKJltMd
	6+LhqHnew5F2NYIIj4OuhaneT8Prblo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-LUXBaevYOlu4Gt4qEaKMjQ-1; Mon,
 11 May 2026 14:43:50 -0400
X-MC-Unique: LUXBaevYOlu4Gt4qEaKMjQ-1
X-Mimecast-MFC-AGG-ID: LUXBaevYOlu4Gt4qEaKMjQ_1778525029
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FA991800371;
	Mon, 11 May 2026 18:43:49 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.165])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03EA518004A3;
	Mon, 11 May 2026 18:43:45 +0000 (UTC)
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
Subject: [PATCH] netlink, audit: prevent false ENOBUFS on timeout expiry
Date: Mon, 11 May 2026 15:43:38 -0300
Message-ID: <20260511184338.392420-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 4016E514957
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286799-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrobaina@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
the netlink socket. If the wait timeout fully expires (timeo == 0),
netlink mistakenly interprets the zeroed timeout as a non-blocking
request. It then triggers netlink_overrun that drops the event,
completely bypassing the audit subsystem's internal retry queue, and
falsely returns ENOBUFS to user-space, resulting in the following error:

 auditd[]: Error receiving audit netlink packet (No buffer space available)

Convert the `nonblock` argument in netlink_unicast() into a `flags`
bitmask and introduce NETLINK_UNICAST_TIMED. When a caller specifies
this flag and exhausts its timeout budget, netlink intercepts the
zeroed timeo state. Instead of defaulting to an overrun condition, it
safely frees the skb and returns -EAGAIN, allowing the audit subsystem
to gracefully enqueue the pending event into its internal backlog.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 include/linux/netlink.h  |  5 ++++-
 kernel/audit.c           |  8 ++++----
 net/netlink/af_netlink.c | 17 +++++++++++++++--
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/netlink.h b/include/linux/netlink.h
index 882e9c1b6c1d..1888c8ee416a 100644
--- a/include/linux/netlink.h
+++ b/include/linux/netlink.h
@@ -226,7 +226,10 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 int netlink_has_listeners(struct sock *sk, unsigned int group);
 bool netlink_strict_get_check(struct sk_buff *skb);
 
-int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int nonblock);
+/* Internal flags for netlink_unicast (do not overlap with MSG_* flags) */
+#define NETLINK_UNICAST_TIMED 0x80000
+
+int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 portid, int flags);
 int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 portid,
 		      __u32 group, gfp_t allocation);
 
diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..005bfd9dc7a4 100644
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
@@ -1020,7 +1020,7 @@ static int audit_send_reply_thread(void *arg)
 
 	/* Ignore failure. It'll only happen if the sender goes away,
 	   because our timeout is set to infinite. */
-	netlink_unicast(audit_get_sk(reply->net), reply->skb, reply->portid, 0);
+	netlink_unicast(audit_get_sk(reply->net), reply->skb, reply->portid, NETLINK_UNICAST_TIMED);
 	reply->skb = NULL;
 	audit_free_reply(reply);
 	return 0;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d..acaa96695981 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1325,14 +1325,17 @@ static int netlink_unicast_kernel(struct sock *sk, struct sk_buff *skb,
 }
 
 int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
-		    u32 portid, int nonblock)
+		    u32 portid, int flags)
 {
 	struct sock *sk;
 	int err;
 	long timeo;
+	int nonblock;
 
 	skb = netlink_trim(skb, gfp_any());
 
+	/* Extract blocking mode: strip internal flags, preserve MSG_DONTWAIT */
+	nonblock = flags & ~NETLINK_UNICAST_TIMED;
 	timeo = sock_sndtimeo(ssk, nonblock);
 retry:
 	sk = netlink_getsockbyportid(ssk, portid);
@@ -1351,8 +1354,18 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	}
 
 	err = netlink_attachskb(sk, skb, &timeo, ssk);
-	if (err == 1)
+	if (err == 1) {
+		/* timeo may have been zeroed by schedule_timeout inside
+		 * netlink_attachskb. If the caller is a timed-blocking sender
+		 * (not genuinely nonblocking), don't re-enter with timeo=0 as
+		 * that would misfire netlink_overrun on the next iteration.
+		 */
+		if (!timeo && (flags & NETLINK_UNICAST_TIMED)) {
+			kfree_skb(skb);
+			return -EAGAIN;
+		}
 		goto retry;
+	}
 	if (err)
 		return err;
 
-- 
2.53.0


