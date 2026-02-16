Return-Path: <netdev+bounces-258900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ21JK0pk2kI2AEAu9opvQ
	(envelope-from <netdev+bounces-258900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:29:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7978144AB7
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DD573004045
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A261311C05;
	Mon, 16 Feb 2026 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEQR7OKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E414B31195B
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252127; cv=none; b=E8MOUEYugBTMSmxbkNNc8TSKOwjitMAGWLFZy1T8msjCMCDj2AgzWneCV+fH+vAKB78GH+gbvIA8Y+hSB4y0VoswidsnUd6hlkZ4vcJ2llq1SSNJmvKBW730om7uo7HsDJIYaXKFO2518VJyG1FqMT1MYYgMV90Bw8pamFl0GPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252127; c=relaxed/simple;
	bh=HRQUdjNHcx45JM5FV/QnOASISlDMoH0fxf7DDrcl0mg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HXUPGTepINWZs5FU2AN1gtao2foeIY2jugGDef0UthlMOBGooVSXzaizOYgu/CXWw0I/wrlxuvS1cREdZNGfvq0AoL1EGvVN7RkU15E4v8VPwsN54Ol/QxtUiSvoEQu6ZFyqMsP3aJ0+Cc+Ncbkg7m+c0d7PtU5qAkPvBLdswOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEQR7OKw; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89718626897so270903556d6.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771252125; x=1771856925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzU6nx/oBVaaUM6MYagj9F9aD46n6bFr5nZ3eoCS0fg=;
        b=yEQR7OKwHWyyxDPjWYMSa5wox8TF9rzBaKTSaDQjONVvyDAb8bFsUmx95L67FOJ0XS
         E9bu2NJnzoTlAs8yLKHQYkCSfenBq1LV4KRdAk+0rPhwLuxu3818H8g3bySoy/3MXsvC
         ADkAAzXG5/rs4WlMe/eHfHM2iqbAJdBfLQU2cTVr7lb12ySYhniSKdl6sGk+Q8UVFUQ9
         aXsg+z2+EcR8Kx3mZfz8UJ1k+WQaIhZX0RiITVFbjqVIxpGq0xy/sV9UOdrXrScnH035
         8twFhIF380o+U8QYuY2zvIboZX5tsvpmQfHAFAm3u+FS2RqPvSh8hRpwAE+D4bxl3osv
         Jd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252125; x=1771856925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzU6nx/oBVaaUM6MYagj9F9aD46n6bFr5nZ3eoCS0fg=;
        b=YDco/nP6fFhNP0YvWDktQQJFlQsrgk7h7sDTTQRs/z1K3BgTekffH6KTy4Ul9HnLa2
         OXh4UW2PXf8AbbIb69fj3hEJ6I1eZxoh6rRrLLIJ6HCEJVAINOIcgdu5iTW+bOhB3kFD
         SeYABbkh2RFXsZ2gdaMznOOZaRvsX+ji17782P9Zmxz6nULKMPHz5qmetrVJysj4WUHT
         1Z40mpmSfzdWtc5j4VLIRbmX5vLA2E7W9qy9PNfy/Sfhy0+So3iQqzi8OF2m671JXIme
         TMgpP6xWpL3YNugAhS+WqWkjEuR4+iiLvNJouuCzz8bnPp9c86QHVa0FhZI88L4un+7G
         Uq3g==
X-Forwarded-Encrypted: i=1; AJvYcCU2D+41ov++0IRdsmCElLSGyULJ3t7P0qE/4j5FjveOq4y66s0u+QyfO1Qbz7qzCqV6dtNgeo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMlJag7UCpcRqUxeV5GOzkvFMkk5lP2xWMPCS82xv/0EuLhNg
	rs4IzC6D8UTYGYSIs7909YX9jleuvKOV4NTCxY8IHaMSW4LZMnEE7neNLGfjONR6aErIr2jVGUv
	9z8FzHVnq45z5Tg==
X-Received: from qvdg11.prod.google.com ([2002:a05:6214:1ccb:b0:895:4b04:aea])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1c48:b0:895:46e:e8ec with SMTP id 6a1803df08f44-897402d45eemr124526016d6.14.1771252124459;
 Mon, 16 Feb 2026 06:28:44 -0800 (PST)
Date: Mon, 16 Feb 2026 14:28:31 +0000
In-Reply-To: <20260216142832.3834174-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216142832.3834174-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216142832.3834174-5-edumazet@google.com>
Subject: [PATCH v2 net 4/5] ipv4: icmp: icmpv4_xrlim_allow() optimization if
 net.ipv4.icmp_ratelimit is zero
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258900-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7978144AB7
X-Rspamd-Action: no action

If net.ipv4.icmp_ratelimit is zero, we do not have to call
inet_getpeer_v4() and inet_peer_xrlim_allow().

Both can be very expensive under DDOS.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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


