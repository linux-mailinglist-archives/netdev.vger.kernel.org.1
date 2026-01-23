Return-Path: <netdev+bounces-252715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHM6K7A6c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:09:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749873016
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9A78300360E
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031752773E5;
	Fri, 23 Jan 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dql9vgWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AA158538
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769159340; cv=none; b=lyTk32LtBfS6kAO28fkbNHzuAK++QB+uiUJFvxEK1ej4UMLZ9iyvmmbffJAmWJffgwz0+yvY2czZJhZ97659/8CPkM4XFUicUI39sNENUCy3aUp9FrBugmLy/ZTwWO6s4xCQMfB+Wt6JEZDhFWhCmRX+5J2vD9B7QvpugYJrCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769159340; c=relaxed/simple;
	bh=cjQOg4C2o7wgseI4T2MXCesmRs7FWxyO4kIQ2YIO1QU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ld+8hnd/0wc8SfI63Gc7DcS7LfG1lqu09fKow42kqR2gV9xY9u8LQrNZjE8zag/caNjZBBUojjZmqZyf2g5OJ6fVnHpIm7Zqqhl/ANbOU1+iDpfTmwyX8jOFYYj/iuZoeaW+pTZ5039+s9FyfVLCKriS1OVBjRZAGIcSYC5cMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dql9vgWJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6a0702b86so217476185a.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769159338; x=1769764138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VM0ACAz3JWhvPAFTH54SdYRNt7hzUR2mksXU4gkAt4k=;
        b=dql9vgWJGdUUIPjUYT2CShYv/Z+7Hg7iYUI77rpzX6Fmh9m1+PVrbRM0v0sXqVmwWv
         Y1qd0EWQvN//kJg3YZEAdLnU9F3796ib5bPm0nAR7alMIpa7ngJAOcg+WH1OZsPu+WCc
         97iI9Gbh5w2YnyuWlcitzDaTl+A3AoPiuo3ZTNmkyA9dkResn84TdSLIGU3kS0ko3nRE
         foeuq5YdPrfZQEk6noavWLZ0fS+nBUjHRgMlHCGCZVMGuGXTjLyoMIZM11flTu43rL2l
         BCorR5mY39NMipkhmQK4H7vhwZUjAlQFJv4T+EFNASwCiRTPXgWTXmo9DSLwT+Nf+O3b
         w8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769159338; x=1769764138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM0ACAz3JWhvPAFTH54SdYRNt7hzUR2mksXU4gkAt4k=;
        b=ZxJaVjSEecl+oq+Q2r4p+D/+r9ZoY+PjJI31oBXmXkTNRA47oH98phz+8gbE+w46TY
         /gW7BhD0eboSZBVqsHlba5hXv34PVCGNFe9vSomdCj2nRNQffH7VPST85Ua8c51VicL7
         KpDa7GJ0AOhKd6VoIVzEbdQ5OoWRECBR+KUgNrKLVWxdugPdc22+aZXUqNij8rdZ8eIz
         kjr8Rkp6AMTsNHyuZ+LSJfsOOh57H8e2zGgRUm4YcLVw37ZUZqHsrAY0cQsJJnQpDf0z
         eGgfuyRpVnFPNcrdrhYuJcUkOP7m2BBMP1zkp7I934yoJOCBerwt0vFtOXTKZzQS0WFO
         d5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWJMeeDameOSHCZcobaiDmDYgaG0l84bHCBFrBKmwCvMTqvjvAYKGdkU/aCugDHxlumIY/iET4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+PLGwU8bxPp2F1ukR61ARXWPlDCMNNarjI9N9gbylaj1ewD/
	ocbqg/MLJSfJVGhUF7YWvf5O4c1q3T9QddoM9fIAbQ6kZ6FyXfFClYzW4zrbrw==
X-Gm-Gg: AZuq6aIcuDq+Qyu2INFdPUE7y2+3okDthaCRQir37kLFRFqG5hVFBPZ+C8nuYobTvHL
	SjflzOyF7thszX7gYVPLXeeXEZguNGUD2pF9AV6YKR4XTrfvlyCZjLv6SedRSet298ShsnfMOhw
	vX7F16KVpe9NGbrBXOzxSslvdVHpXx7cRPeIa1YegPY8mNOtq/rwu9/ivAIoKf9G8yMFtiNH2kD
	nNwO3esPOvlFwMOkvKhLFbtzXpAriJ65+qRYSQ7P+U3ADXdOPExK6odf9ftM8pluQ5n1s13oH4T
	kqbHi9HDovKxWq8i9Ah33vOBucJFNgtFskfyZpCJZgX9onPVagH24pXVAJFr4o33QAOQD6g1Hip
	QbQI2zgTW4np1kGuLI0CJq97sPcCtR2SRjeGqxoiNhFo0IflkJH9JNcAOkjC1DqE9wUnEJV7cb6
	L8n8GwsNFDiD3Q/xw1Kp+1saBk8w==
X-Received: by 2002:a05:6a20:a128:b0:38e:5535:bb4a with SMTP id adf61e73a8af0-38e6f6aa952mr2246172637.11.1769152609898;
        Thu, 22 Jan 2026 23:16:49 -0800 (PST)
Received: from fedora ([49.200.119.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a424cf9sm1149029a12.28.2026.01.22.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:16:49 -0800 (PST)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] ipv4: ipmr: add socket type checks to ipmr_ioctl()
Date: Fri, 23 Jan 2026 12:46:35 +0530
Message-ID: <20260123071635.16976-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252715-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suchitkarunakaran@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5749873016
X-Rspamd-Action: no action

This is the IPv4 counterpart to commit ("ipv6: ip6mr: add socket type
checks to ip6mr_ioctl()") [1].

Similar to the IPv6 issue, ipmr_ioctl() and ipmr_compat_ioctl() access
raw_sk(sk)->ipmr_table without first verifying that the socket is a raw
socket with IPPROTO_IGMP protocol.

This allows a permission bypass where a user with CAP_NET_RAW can create
a non-IGMP raw socket (e.g., IPPROTO_UDP, IPPROTO_TCP, or any other
protocol) and use SIOCGETVIFCNT or SIOCGETSGCNT ioctls to query IPv4
multicast routing statistics. This bypasses the access control that
restricts mroute operations to IGMP sockets only.

Add socket type and protocol checks at the beginning of both
ipmr_ioctl() and ipmr_compat_ioctl() to ensure only IGMP raw sockets
can access multicast routing ioctls.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

[1] https://lore.kernel.org/all/20260123011444.2044-2-qikeyu2017@gmail.com/
---
 net/ipv4/ipmr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index ca9eaee4c2ef..eae03a1b8f66 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1643,6 +1643,10 @@ int ipmr_ioctl(struct sock *sk, int cmd, void *arg)
 	struct sioc_sg_req *sr;
 	struct mr_table *mrt;
 
+	if (sk->sk_type != SOCK_RAW ||
+	    inet_sk(sk)->inet_num != IPPROTO_IGMP)
+		return -EOPNOTSUPP;
+
 	mrt = ipmr_get_table(net, raw_sk(sk)->ipmr_table ? : RT_TABLE_DEFAULT);
 	if (!mrt)
 		return -ENOENT;
@@ -1711,6 +1715,10 @@ int ipmr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
 	struct net *net = sock_net(sk);
 	struct mr_table *mrt;
 
+	if (sk->sk_type != SOCK_RAW ||
+	    inet_sk(sk)->inet_num != IPPROTO_IGMP)
+		return -EOPNOTSUPP;
+
 	mrt = ipmr_get_table(net, raw_sk(sk)->ipmr_table ? : RT_TABLE_DEFAULT);
 	if (!mrt)
 		return -ENOENT;
-- 
2.52.0


