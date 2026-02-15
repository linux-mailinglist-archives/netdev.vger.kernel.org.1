Return-Path: <netdev+bounces-258777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNk2AqfakWlpnQEAu9opvQ
	(envelope-from <netdev+bounces-258777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBB13EE1A
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CB043026174
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBEB2D46A1;
	Sun, 15 Feb 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htA4oSSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8D2EC0AD
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166312; cv=none; b=JR2Hwm+M1pIoPjgZp1vpU9rIh8AvLPGIO77KguB/hPuOywqt6RUPe2z6IgS2AAVamqA+uVtR0WFQmEwFlp/fqKcSIFXXjc1dbxXALDhA6YQR8jrWFnknmgKLRNcJGuTxsWEeHqJgtvbwDA2BetmYIFb7d3q7LOyutrDKCtTnsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166312; c=relaxed/simple;
	bh=D48F4HtJrW7L96GQuGaPD7vSUOWO6V6myLWy7EeGv8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WZCfLjRgidW8ItexWQX+uRwF/HX/80wIx2hH/TWQlMKZXlP++dugENkYFc8FjX42cEfDCiGibnSnrGG/xe6FtY4VIiiRSpncyY8qsB8GHoii4ohsR7AEmSqlvjj7lBE4Q4f9ArdDXE2ecwyBD6XJL4uc/sEf0HSaIWyPKtRm8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htA4oSSs; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb42f56c4aso1251430485a.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771166311; x=1771771111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FDTFHsC+uQMZksPQ9dQ36S1JDSWDCL6N9Ceex/OgFw=;
        b=htA4oSSsD82wlqIXdRoeODL3CYTAnjVJVHSOoIcUBqCtKuthogo7O00oz8muIjeQRU
         hrfHGGqkWZdPO208b7uNNI1bFAsC8bMEinhTJdxNbnSJPg5GzVsQYAVaKfgyR7VifZVE
         3OrX2U5TRopU1EA47P7v7NYI5cokHzhbFUwzi1vzV4GsmOLjmJUjt/Ncauz87NGJXQ0+
         i9TEOPV5f5KGGydu1AYRdJv+T+uoYcHmKKMCD5gSKRxR5UKuH51K0hwl1xUEkzPWOzPQ
         8meUVtJELoH6p55ERIUDbnYALEi7lnN81H4eElpTJpd9LgwRWkm+OrjLmYJQ0za+zoPl
         ebdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771166311; x=1771771111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FDTFHsC+uQMZksPQ9dQ36S1JDSWDCL6N9Ceex/OgFw=;
        b=BJFvVU1cVl6x8D+0mVnCQNeTIgKuoXVv3e7rF+gC1UBVSQgHwjdXRP/Z3yI/SNKmx+
         3roxCPRSMEqFL8d/K96Rc6M1U3wogz3jNey45RBLumWHpPqTDZcl8OHunGMaYTLJD43V
         tLdBPDwOy+Ksnn7Y/wrV9A1sOdX5y9LJtu6zPaxEO0YJNAE6JF7wRGQFfAEUVYEVAeB/
         h09syxepw6LqGQNKXiEwqRWV1zL6Q1cLZpr1/NfzXAbpGW7hgNzAD87YHlbtQnM7PM+j
         0GLfXx9rKDGfHUsAlyw0HACG5N3TOJJAI9KxHdwBD5ybb1C7wg+25/LYUcAFiy3Ywv1x
         DuBg==
X-Forwarded-Encrypted: i=1; AJvYcCVKvc9/+SNRFSrdBo/Y+xkOFf4vTii8iP5BVnhXgQvH5nEo9h33XvS9pzc7TnwNBtC7N1Q95Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKOl8ky+bPCuY9lNES8mmw9V13HRd6/gjj+PMNGvpeOXIHAxa
	bhwopvWi9fUY8MRFw4NxYYEmZYY6LDGZLjV0WaUqiWRgNEHRIAAUZ/B91L5ZM/e63dnwaA042nN
	saoA+1mWStjSTJw==
X-Received: from qkjx27.prod.google.com ([2002:a05:620a:14bb:b0:8c2:3ee9:f2c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:19a4:b0:8c9:ea6f:6a4a with SMTP id af79cd13be357-8cb424b36ebmr880800685a.78.1771166310570;
 Sun, 15 Feb 2026 06:38:30 -0800 (PST)
Date: Sun, 15 Feb 2026 14:38:20 +0000
In-Reply-To: <20260215143821.2330791-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215143821.2330791-5-edumazet@google.com>
Subject: [PATCH net 4/5] ipv4: icmp: icmpv4_xrlim_allow() optimization if
 net.ipv4.icmp_ratelimit is zero
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 63EBB13EE1A
X-Rspamd-Action: no action

If net.ipv4.icmp_ratelimit is zero, we do not have to call
inet_getpeer_v4() and inet_peer_xrlim_allow().

Both can be very expensive under DDOS.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index eff8487c0aba8df0d1e515b9ac6ff7f9ac1de436..a62b4c4033ccbaa5f6de1345ab33f89b4096b691 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -316,23 +316,29 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
 	struct net_device *dev;
+	int peer_timeout;
 	bool rc = true;
 
 	if (!apply_ratelimit)
 		return true;
 
+	peer_timeout = READ_ONCE(net->ipv4.sysctl_icmp_ratelimit);
+	if (!peer_timeout)
+		goto out;
+
 	/* No rate limit on loopback */
 	rcu_read_lock();
 	dev = dst_dev_rcu(dst);
 	if (dev && (dev->flags & IFF_LOOPBACK))
-		goto out;
+		goto out_unlock;
 
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
 			       l3mdev_master_ifindex_rcu(dev));
-	rc = inet_peer_xrlim_allow(peer,
-				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-out:
+	rc = inet_peer_xrlim_allow(peer, peer_timeout);
+
+out_unlock:
 	rcu_read_unlock();
+out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
 	else
-- 
2.53.0.310.g728cabbaf7-goog


