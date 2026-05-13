Return-Path: <netdev+bounces-287692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO0NIhG5BGplNQIAu9opvQ
	(envelope-from <netdev+bounces-287692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:46:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E32CD538453
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7253213F6A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1336648C8C4;
	Wed, 13 May 2026 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GheIeQYZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA604DA553
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693115; cv=none; b=EW0Dnv7+irOQmqS48+mHxUH5gCCskZCas9pzDGSiYmllPQuMSK6AVmS7pYS2c8huS3RMvazD1jMAPijvBlbFOzbC5KIAbDWHHAvm35WXvpeG82Vj31tCcCXA5nCFL4Nn3OhwYH7Vv0lfV/ySpku7D8MLNzMAk3Ru22FsgNZH6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693115; c=relaxed/simple;
	bh=0l3K1Vx6dDHrT4K/Ky69g1F83Rx5pkBVmYmgs7DnxK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUcqutFBHXmPmPGlf9QGg/GNb3SEukjFJ6RVjg274g1YtJQaXfz92qHnMLRkycldsZWQHAkwkwyBtm0tdO9biPXV17/+4UyzNx06sFLBXj7lj21pLl2KYlJ7tsvEc6ievdXMEhubtKuRO1PfaD1RqvaWdwen2Vwuqn5Z6flhTDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GheIeQYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778693112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P6Gxt0Syx0btkQxNHujdK6tAvcgI3DJpQWuCddcKTlE=;
	b=GheIeQYZ+hfVRK91UZMrOepdDCKfWWXiagHUWYNs400cikqWIxfO2lbInANT3RRC3COcGQ
	0XbQh9g/LJbfFphMD5xUEhGUnVp+ViDHkHyy/mZRTVZQklKlwnbnEom7OYtR0ZsfaBCECm
	LEWsmVmpHoweUlV2YBaI7EYwVdfCBis=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-ajT9Fg5hMFel42STe0JZeg-1; Wed,
 13 May 2026 13:25:08 -0400
X-MC-Unique: ajT9Fg5hMFel42STe0JZeg-1
X-Mimecast-MFC-AGG-ID: ajT9Fg5hMFel42STe0JZeg_1778693107
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B84D1800372;
	Wed, 13 May 2026 17:25:07 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2678F300019F;
	Wed, 13 May 2026 17:25:02 +0000 (UTC)
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
Subject: [PATCH v2] netlink, audit: prevent false ENOBUFS on timeout expiry
Date: Wed, 13 May 2026 14:24:43 -0300
Message-ID: <20260513172443.1128496-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: E32CD538453
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287692-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
the netlink socket. If the wait timeout fully expires (timeo == 0),
netlink mistakenly interprets the zeroed timeout as a non-blocking
request. It then triggers netlink_overrun that drops the event,
completely bypassing the audit subsystem's internal retry queue, and
falsely returns ENOBUFS to user-space, resulting in the following error:

 auditd[]: Error receiving audit netlink packet (No buffer space available)

Fix this by detecting when a blocking sender's timeout has expired
(timeo == 0 && !nonblock) in netlink_unicast(). In this case, instead
of retrying with timeo=0 (which would incorrectly trigger netlink_overrun
on the next iteration), safely free the skb and return -EAGAIN, allowing
the audit subsystem to gracefully enqueue the pending event into its
internal backlog.

Suggested-by: Steve Grubb <sgrubb@redhat.com>
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
Changes in v2:
- Use the simple check (timeo == 0 && !nonblock) to detect
  expired timeout, avoiding adding a new NETLINK flag.

 net/netlink/af_netlink.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2aeb0680807d..fdc3db74b178 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1351,8 +1351,18 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	}
 
 	err = netlink_attachskb(sk, skb, &timeo, ssk);
-	if (err == 1)
+	if (err == 1) {
+		/* timeo may have been zeroed by schedule_timeout inside
+		 * netlink_attachskb. If the caller is a timed-blocking sender
+		 * (not genuinely nonblocking), don't re-enter with timeo=0 as
+		 * that would misfire netlink_overrun on the next iteration.
+		 */
+		if (timeo == 0 && !nonblock) {
+			kfree_skb(skb);
+			return -EAGAIN;
+		}
 		goto retry;
+	}
 	if (err)
 		return err;
 
-- 
2.53.0


