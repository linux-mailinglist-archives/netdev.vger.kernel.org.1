Return-Path: <netdev+bounces-211186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2BEB1714D
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B1C7B28BE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DE78F5E;
	Thu, 31 Jul 2025 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTflUkqh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3535947;
	Thu, 31 Jul 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753965198; cv=none; b=M1OIBH0pi/NdnSfRYQeiEkKgl1MvNE7hEZSKr07BVj6zzwv/OWmjN9peoPVBFMs2swroDElh8mEauQRSu+3THHc1r0U+my3nSVhbI7uNjBJmFISASHnWir4W3A5+Jd/DJktb1T72wYj6jwjXwOS9tb8hhYt6LmoUlZUToyLalJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753965198; c=relaxed/simple;
	bh=pKQpv4mBRCSizQ3IOrUUmufLAwilKGjREvGRMA/U4Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKVWVZyavBgNw2AHRigObdZswyP1SWzmSqdNno7iNR/9DWaXpRJR2gVeeH3bjBGGeavKISxL+XZEiHFzBK5g8cJR+IPo8WlrmCx9cdaQHpNo4S90JuNjhpTmBdww5X2yUyOXoCn7gUnDzIDO5hN9ICC2vAb414iAEiqo9UzmaGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTflUkqh; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso919495a91.1;
        Thu, 31 Jul 2025 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753965196; x=1754569996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClUK06yBBk38woAmuvMsPWyYWzBche2E5s4S41KC+GM=;
        b=JTflUkqhIvWqsCURa5q8+j9KIJoQACuZXSDM8oR+Ccx06udBZbRIybTQYM5OwG/gU1
         ZukyDAYo+8G/orRhRyH4lZzUrOn/YWy1oOAq8txc1oE81ruvpyubCVGd+/kMrX6wCxHx
         01huuDH/jYBvdIkodqon/ZizQEtl5b8uGbJ9TuX+8dZLzWUGRVh9tYuoMxViF4EAIPJM
         zCQu3ih2M6vWqKPtB0GrMeBzdFtLgq+ucvY41smGLTEyJUInVA6piKQEkvED5tQGVQTA
         Ia3BRQu3XPicjFePIUAs/oDpBYywJC2I/GgBWl4cd8QV3GQJxm/do7CAvdQL1jS4kF2r
         8cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753965196; x=1754569996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClUK06yBBk38woAmuvMsPWyYWzBche2E5s4S41KC+GM=;
        b=GM0aSsFZBbHJhxl9dgIk4VwgZ11dF6/0T+wtlrfVECxTaOzMrqAqZ6r8gfOQv8Z7im
         dBfFMViEwGvVh2JFdh2jQylhQq10ksM99qGDv4nYeeRkHZPJjer4kU2lEnKgQ/PDlEaP
         UOj0LkBnGwkgzozo+Z+jHKgbwro4c5fhhadfD0lpKsv/k1tVuVsT55aMJpV31q3faJFl
         tO4CWswx8EvsMhg1HU/9TdGwbhdGFiSbs3RN+yyG79+WaRVMdXegOhHxMTlOOL8r9JkK
         UJq4Ulc9C0wWS4uHC0vvL0xRWJBbc9fp/rWGg4ywxhDCscSvRuTTUA/3O6O/JjMbgxp7
         5TKg==
X-Forwarded-Encrypted: i=1; AJvYcCV1BIjG6IFYddcpJlkxg9uM37WqX17UDmyiSFFcU6PXCdqpg464ooo/ZfvTP7Xp0NBILbfj4lDq9VHGnG8=@vger.kernel.org, AJvYcCWEVwNQj/vVPNs1rNHww4a52D7d62Nq79vRfLB6QiBPEbzPnpzns1w8z0ESX3P6NqR2UjdsVPoG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71DCL+LAVMRmG7mtFHEubr4RI0+hpIfTwXDCi3O8JMNC/242q
	RSSqs7s9qnju/XT8wDM4/C0s1bVpfzg0Eb/5di1WJvGEhYA9h4gWHOb7
X-Gm-Gg: ASbGncupkVPQ2EUiNk1wm6mlyb4J3rBfKkklU5RXcZl06KPB9SUj9S1p4P24r+YkIs5
	qOcVM/e0v7RLviCxdAqWNVv45OiT718luoTbpIP9nL0aaTryWmnpgOOVU0CFtm52dTRNW6O6e7V
	FhOIi4I9loj3mu4U4wQpcZaai2KgBajK1dPzv4HiyvMjXctUZGEA+TwDhm9sKO6FlkFZmrVbW2J
	+vfS+OMLeUHqhWnpC/SxHca3YyRFtzrUg8BqWy70z0vg7PjQ3LJ7HdViZooOH5dhdNsr20EscZX
	RQL85n6l//DtpOTQ5SAAk6paNUjPVsVPNlEaRLV1BnalS7aA0lEjJ95e5v1DkocaXc4mhZISg/E
	teELLh1/WReE9W/8NcHU=
X-Google-Smtp-Source: AGHT+IHlm0wyDhGLshRzUedVczQxXaCz+Wx5N5RSFeJMgsRMIpnGGs9S2XWpHCWEAHLMzXMl3EBSgw==
X-Received: by 2002:a17:90b:1fcf:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-31f5de7b78cmr9604120a91.30.1753965196211;
        Thu, 31 Jul 2025 05:33:16 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0cc41sm4589633a91.32.2025.07.31.05.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:33:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
Cc: ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ip: lookup the best matched listen socket
Date: Thu, 31 Jul 2025 20:33:09 +0800
Message-ID: <20250731123309.184496-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the socket lookup will terminate if the socket is reuse port in
inet_lhash2_lookup(), which makes the socket is not the best match.

For example, we have socket1 and socket2 both listen on "0.0.0.0:1234",
but socket1 bind on "eth0". We create socket1 first, and then socket2.
Then, all connections will goto socket2, which is not expected, as socket1
has higher priority.

This can cause unexpected behavior if TCP MD5 keys is used, as described
in Documentation/networking/vrf.rst -> Applications.

Therefor, we lookup the best matched socket first, and then do the reuse
port logic. This can increase some overhead if there are many reuse port
socket :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 net/ipv4/inet_hashtables.c  | 13 +++++++------
 net/ipv6/inet6_hashtables.c | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ceeeec9b7290..51751337f394 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -389,17 +389,18 @@ static struct sock *inet_lhash2_lookup(const struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = inet_lookup_reuseport(net, sk, skb, doff,
-						       saddr, sport, daddr, hnum, inet_ehashfn);
-			if (result)
-				return result;
-
 			result = sk;
 			hiscore = score;
 		}
 	}
 
-	return result;
+	if (!result)
+		return NULL;
+
+	sk = inet_lookup_reuseport(net, result, skb, doff,
+				   saddr, sport, daddr, hnum, inet_ehashfn);
+
+	return sk ? sk : result;
 }
 
 struct sock *inet_lookup_run_sk_lookup(const struct net *net,
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 76ee521189eb..2554f26d6c20 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -161,17 +161,18 @@ static struct sock *inet6_lhash2_lookup(const struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = inet6_lookup_reuseport(net, sk, skb, doff,
-							saddr, sport, daddr, hnum, inet6_ehashfn);
-			if (result)
-				return result;
-
 			result = sk;
 			hiscore = score;
 		}
 	}
 
-	return result;
+	if (!result)
+		return NULL;
+
+	sk = inet6_lookup_reuseport(net, result, skb, doff,
+				    saddr, sport, daddr, hnum, inet6_ehashfn);
+
+	return sk ? sk : result;
 }
 
 struct sock *inet6_lookup_run_sk_lookup(const struct net *net,
-- 
2.50.1


