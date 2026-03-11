Return-Path: <netdev+bounces-266471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLbcHtb7sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 193DE25C5F0
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669CF317EF7D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4865E3101C0;
	Wed, 11 Mar 2026 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0gnp6f1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD7E32AABF
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206438; cv=none; b=RXDSHRYYRw3EYUYOqhKtyahA/Gwk1H+Q+LSI2NG1x7LwQaxTbkNUUIRtph+G8ZLjQlat9rVzp7t6VQX4PJdMNvt82JlczrjQG+zwBXl85u3wab74/P7RU9CSvK4u6ylrNBMttbrO4AnDsEvmB9/6/7QHoKdswVXbjpER+mswAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206438; c=relaxed/simple;
	bh=lmPpYSlPcQNZpTQXLMEyB3rxC3XM040jCc/+2R5k/b0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0FFzqzQVGn42rluDbwcxFoJC7u0HVCfzbxkjTEQSrI0fQ93Pi9E1daPpYyt6Z2atWztjuUByXcWl8ix8747/rCQkA15hOTHGoKDGWHysT/fOwGXM22BJLavbJOq9h6g4d+k97KTbo2vjKHwgYs4aFcPvMaeCTaF8PFXE4f7CL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0gnp6f1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829ad81b132so13483024b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206436; x=1773811236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82HY+Ox5JF0vwG5eIoCl0bQkH1ycg7BDvsoRBp0gXg=;
        b=R0gnp6f1gOltq3j9L2+MtAENcu4iK0WGejYPGIqDP5CHN+C5kYWVwbkjzgiKufJZtE
         fSq7KbjpEryl4h6v3zfPNd2U81AwthhrIQMav6DAxdpxE/t0wdAKjCCWgKXIVCvyKeCY
         jRwCDkWs5VUmLEp0UgWIpqQPKPUcewd57phTSQMis+6Z0dvS8gBIvyozq6x2mLMuY2tH
         n1Z6KobG9fZhyC0HerzWGNhRWGIikEjmp0F+FvXAX8m3A50Dnb9na7oj7usqa3BFKTwb
         57q3OlE4KgpMsuygJFb1Hexn5uI0A+YP03T64FkzFWbs5thnkZNv78R8mc4PQXmE3RUj
         8MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206436; x=1773811236;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q82HY+Ox5JF0vwG5eIoCl0bQkH1ycg7BDvsoRBp0gXg=;
        b=fJQQyJhmkJSJlRnRdoRCOdEIscuVhN/pC6TviR9GjxHNn1+pdwRGi7ucaxB11raIMP
         5P0lpD3peKALtqXIQol7lHN08pmBcIFVvc6rtgirSo6BZ6XSAtYU4VbpbuOlIZGJXp9P
         sPGC/367QlgtCFPV3KMUAKgmfKfz73gk/N/H5MimhY3II/ZDkgg3gqblaUwNRvlbcMKM
         1ywHO9aCAFRjHJU50+sY3IHX21S3VHIJ6ZyUcaJwyYMzFfvYsZluYbEo+WvSeYb26L5B
         /Opc5+6pBJZ2cywqgDcAGsrI3p0e0/m1P71vco5RA1qtJUhVgB0p+Ok5cyxwB2zqlZqM
         0c/g==
X-Forwarded-Encrypted: i=1; AJvYcCXySXsIDMxmh6gDeJihNQwGgedVEhl1SulrAemcmhyx/SOv0WVKRH3NFoLfTh0SttPychWSHpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvazMI61Bag42UaFogtEd/e56sr2uwd0nsznrchYixljb7HLvK
	ZO9GzzoVbfoIXtx40kn/OASaw1+h4ScLip+UrldD+d6Mb14/GSAdoI7AQZovjfDY9v9G3qjw96Y
	x4T+SmA==
X-Received: from pfbdi8.prod.google.com ([2002:a05:6a00:4808:b0:829:7841:17b5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440d:b0:829:bd4d:3817
 with SMTP id d2e1a72fcca58-829f70462b4mr1340501b3a.28.1773206436051; Tue, 10
 Mar 2026 22:20:36 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:19:53 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-7-kuniyu@google.com>
Subject: [PATCH v3 net-next 06/15] smack: Remove IPPROTO_UDPLITE support in security_sock_rcv_skb().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 193DE25C5F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266471-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org,schaufler-ca.com,paul-moore.com,namei.org,hallyn.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

smack_socket_sock_rcv_skb() is registered as socket_sock_rcv_skb,
which is called as security_sock_rcv_skb() in sk_filter_trim_cap().

Now that UDP-Lite is gone, let's remove the IPPROTO_UDPLITE support
in smack_socket_sock_rcv_skb().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/smack/smack_lsm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 98af9d7b9434..e581d6465946 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4176,7 +4176,6 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
 			sip->sin6_port = th->source;
 		break;
 	case IPPROTO_UDP:
-	case IPPROTO_UDPLITE:
 		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
 		if (uh != NULL)
 			sip->sin6_port = uh->source;
@@ -4301,8 +4300,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 #if IS_ENABLED(CONFIG_IPV6)
 	case PF_INET6:
 		proto = smk_skb_to_addr_ipv6(skb, &sadd);
-		if (proto != IPPROTO_UDP && proto != IPPROTO_UDPLITE &&
-		    proto != IPPROTO_TCP)
+		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
 			break;
 #ifdef SMACK_IPV6_SECMARK_LABELING
 		skp = smack_from_skb(skb);
-- 
2.53.0.473.g4a7958ca14-goog


