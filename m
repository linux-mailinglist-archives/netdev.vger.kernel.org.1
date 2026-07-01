Return-Path: <netdev+bounces-303726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SNAkL0o4RWou8woAu9opvQ
	(envelope-from <netdev+bounces-303726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:54:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1B6EF677
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:54:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SXWw2Vi8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303726-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303726-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B209D304C7EC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2C023E320;
	Wed,  1 Jul 2026 15:51:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DE3B6356
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:51:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921100; cv=none; b=JIG03U3FmihAEb8NCoyfnsUKFhjtL/mRgZIvNj94GaL7XAqyvmuAxc5gTBR9bQPQbQ3O14BT27Wxg1u/yD5OUQ/N91fVZSEJOHWxCra8OKhDbqnEsG61B2r2tPwOWVetvWDFwdlnuKziYwEoU3MamWaBdlD6/XXyYQdcX+OIB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921100; c=relaxed/simple;
	bh=4q3tM/MB3NGkckWK7946pBhSKl1rM1isvRXO8B1mqQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ITrxK9xae77dsSgHdovDRdBdUCWn2smiyKMPAmkEusa8H5Xf3EFK+sfEME6GJIu+KvVKgwYfzc5COCSJXs2IsNBA2J6RL4oojiJXvLEV/8/cDyAoJeR75vG6ZEQBLtEPOd2dzpETmsO/5npUrv1jaT8JHHwWDnJbyRYDG6UcEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXWw2Vi8; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8e86066fc53so10988176d6.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782921098; x=1783525898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOnv67qb55xaEKIoEANfQ7AmQq9cW7Spoo4vpdER+v0=;
        b=SXWw2Vi81y30Dl+g37YV+3kgGtXQpxEBQr5rWGRyVbVNrd7q4/H9S2DRxJYXGXblSz
         Y3wYr2rO9GEqT520rzPmXg1eysXSkdk1aJ5mc65WVdq4sqLnW2sRKvpploqGr4WlyNb8
         ArzwdsacAJMfhtB/zDEG6no0ZviJcU6++564Jyas83paurpwVkSlcUcKkzZzzc8CAlYI
         zPDB1RG29NuGpQ0MVt5R4ULbmF4SHbjfw0tY0wQlogWQl47DnWoNx4O3hQszyTzeSdPZ
         Rda52Oo1PXAIBtZ2sUiu3oWqELVcqWat6ML5P+r9OpslgpzUYy0ySU9nhnJCjkZmxulc
         Hn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921098; x=1783525898;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOnv67qb55xaEKIoEANfQ7AmQq9cW7Spoo4vpdER+v0=;
        b=VMvqmuKYxZsNnpAMzh56glL+zEtroaNPJNTF8c32XtrurCyUXgzEgfYorhu4DpdkNt
         CXGRoykbPTYUgiNHbhlz1XjqsWsg6nLEkeox670max8P+lSS5YeGn7zbYOiFZJJhTG7F
         mARIm7ceRyoCNfMHlz34A8AtW7mlwAMeifsjjcOVcc3D2pHdbag8bvuH31w/2LA0J+J3
         8s1+psAz5zoQewfGhgHRkx45p33BIkYYQQ6ZPOIp2ebBfqqXDSHnfRZQGACh9axTfUWu
         hrjf04lUaXRRJXFgGl+Uc3elykWVUcCs8EGWOaoH0vc05YYVk4cyY7D/ulnZ/rWlAdQs
         YLfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqU1/m9IvbLfbqDdkt14APiWpWTJRSRqOMP0vvqdJVUWlp+uHSzfYq79XgdsgO16n1ssL8weiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiuiX+ZAXnoq0MU1Q1avblXTwFwMQcbMWOoQauVgnm97/zdRZ
	whsMeZsCNCZVeb7XY3xQLX0RjDOEO45wSMRpNjq5QSb9CO6uexwnD3UjxPPuQVnKnWGuZ3hP9dp
	3Yuqd8uGu+Na8ZQ==
X-Received: from qvbdn15.prod.google.com ([2002:a05:6214:94f:b0:8eb:6e3c:2cdf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3c98:b0:8f0:7950:a2c4 with SMTP id 6a1803df08f44-8f3be2768b5mr31616716d6.17.1782921098031;
 Wed, 01 Jul 2026 08:51:38 -0700 (PDT)
Date: Wed,  1 Jul 2026 15:51:34 +0000
In-Reply-To: <20260701155135.3962058-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701155135.3962058-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701155135.3962058-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303726-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CB1B6EF677

Update ip_tunnel_encap_setup() to use WRITE_ONCE() when writing
to encap fields (type, sport, dport, flags) and hlen fields.
This ensures that concurrent lockless readers (like fill_info)
do not see torn writes.

Also remove the unsafe memset() on t->encap which could cause
concurrent readers to transiently see zeroed fields.
Removing it also fixes a bug where t->encap was left cleared
even if ip_encap_hlen() failed, resulting in partial configuration.

Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp encapsulation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_tunnel.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f928b0ab46ef3007e456692d82b497..f7bbdd1bd323b1973ec1ea1d93f0ed6ab703bcd3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -491,19 +491,17 @@ int ip_tunnel_encap_setup(struct ip_tunnel *t,
 {
 	int hlen;
 
-	memset(&t->encap, 0, sizeof(t->encap));
-
 	hlen = ip_encap_hlen(ipencap);
 	if (hlen < 0)
 		return hlen;
 
-	t->encap.type = ipencap->type;
-	t->encap.sport = ipencap->sport;
-	t->encap.dport = ipencap->dport;
-	t->encap.flags = ipencap->flags;
+	WRITE_ONCE(t->encap.type, ipencap->type);
+	WRITE_ONCE(t->encap.sport, ipencap->sport);
+	WRITE_ONCE(t->encap.dport, ipencap->dport);
+	WRITE_ONCE(t->encap.flags, ipencap->flags);
 
-	t->encap_hlen = hlen;
-	t->hlen = t->encap_hlen + t->tun_hlen;
+	WRITE_ONCE(t->encap_hlen, hlen);
+	WRITE_ONCE(t->hlen, hlen + t->tun_hlen);
 
 	return 0;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


