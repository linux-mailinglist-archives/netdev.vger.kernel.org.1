Return-Path: <netdev+bounces-77591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1C8723A1
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCC51C218FA
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9344212B170;
	Tue,  5 Mar 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1xlMR8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12528128805
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654693; cv=none; b=YmON66WLhs7+BaQpKUfQvLeMmrA9xPDwU2HMnaCMzez5UcJKEJ9wEDGPuDZ/QNeYDkr2r0GcfhnMb604AScFxBgLqF+L8XtZmrAZKw/ZaeOXPBhXuKVWhV06jleJhhASQ2OApV8TmM6tWBHCwtpxg6D4Qe8knJ43R4odGPFSLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654693; c=relaxed/simple;
	bh=e0+PLrT73nEBv75eicC4a+8lpbZ9f7PeNh5w4yzgsKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PJFC1Vo08Xu1eqcYtk1D/MJWB8sEOrydNxt2JhUTYlPJrKSVDQ4SG9F+qCzIESfp0zdpu9Ce5iZ7ipC4BkmTqQDoTNmKOxmKuWFj+6UpoLACVQ2dvv2gFbGRRsHL4Q5Hg+S+SwMHM+qShHbShO/vlbbVvFzhsP+UdPeac9DxqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1xlMR8b; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78825e47824so201372685a.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654677; x=1710259477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ2xzFYq3fEPMpr/MUwgp+HG/Vy0UXwzCdvLWEnfl/o=;
        b=X1xlMR8b8EsV4A9PS7+F4GVrVkY8SO8hf8PeXzTC0NK6jFKFh2fPqRYqPlrtQm4ieM
         OKD+85MI8ym/9rEg/ZR4WqDgeoDrRgunKrgiH23tWLUOlyQANU+s7a79RNP49Ip4Y8OX
         +zUGF0mOdI86A2ldoVBMDoCSAq0xdY06AphIqYBAZPIGPJ1hk3OwvEYGIc4pdyNayR1W
         ggo7gQj4iLisGVp+vl8pg7hFdfIJW63tMxEoGaLlzis6v/1StpSQvDkqsK5tWgKo2LSj
         n12lbL3JrFQMWZ+03IzQL9BkoPBYBSB1U3xdVz8q87HR62Zo6+3X0edmbT6oKYljiFvK
         T3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654677; x=1710259477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZ2xzFYq3fEPMpr/MUwgp+HG/Vy0UXwzCdvLWEnfl/o=;
        b=DPEWlQBi9gLj/1ci8kwxe0bnO0BpGmIZPfq1W/ZMEoBSGOqhTVorjj2qSFL3scc2Yz
         yTIeA7D9zD+LoNxcGP9SR3rVdmzizo1BXwSbPjgpJxDPqyXb5HRAOCa7suEKn6hYiBDk
         P5maXaQ40O5oAHjvll0TMeJhCFSgqXMZztbFGZVVN+80xyWAiLl6CsppIWe3cYbN3pSP
         FNQZl6bfnmycxvq4dl7ZF7GHlBMiNu5C71Lr6vnFOL2aLBMcB3dVui3g/9sriPqqOm2r
         1hUGW6ayfCdpBMOJqYV4podHGy/fuUPM0lNhNdQ8Gl/mb78srHWcmNHDrLMJSMJasU6G
         n/lg==
X-Gm-Message-State: AOJu0YzmIScF1BVPW4poFrCRziEh/OYnDCooT9egOrEPbRo+LT6guPzt
	hWtZV1W+PuNp3n+Ime1rXrriNCEsWiEy401C4BGy+GruDCP/ST0DeFrNGggW/4AJjkJVEAEoInS
	1uwc8fLLcNg==
X-Google-Smtp-Source: AGHT+IGxJI2wAtvikhj+WpuERa04vwzy+AKZ+7ZxJrtW2zxWF2lTVgBoTQA2b5+vzKcHQKBHzEAVsfgOXFd1ew==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:1a04:b0:788:13c3:dad7 with SMTP
 id bk4-20020a05620a1a0400b0078813c3dad7mr148662qkb.8.1709654677177; Tue, 05
 Mar 2024 08:04:37 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:09 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-15-edumazet@google.com>
Subject: [PATCH net-next 14/18] inet: move inet_ehash_secret and
 udp_ehash_secret into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

"struct net_protocol" has a 32bit hole in 32bit arches.

Use it to store the 32bit secret used by UDP and TCP,
to increase cache locality in rx path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h      | 3 +++
 include/net/protocol.h     | 1 +
 net/ipv4/inet_hashtables.c | 3 +--
 net/ipv4/udp.c             | 2 --
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 4d1cb3c29d4edfbc18cf56c370a1e04e5fcb1cbd..4dd86be99116ff83f2524461a006565b2ade2241 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -36,6 +36,9 @@ struct net_hotdata {
 	int			dev_rx_weight;
 };
 
+#define inet_ehash_secret	net_hotdata.tcp_protocol.secret
+#define udp_ehash_secret	net_hotdata.udp_protocol.secret
+
 extern struct net_hotdata net_hotdata;
 
 #endif /* _NET_HOTDATA_H */
diff --git a/include/net/protocol.h b/include/net/protocol.h
index 6aef8cb11cc8c409e5f7a2519f5e747be584c8d5..3ff26e66735cec98b08eadb1c3f129e011923cb0 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -46,6 +46,7 @@ struct net_protocol {
 				 * socket lookup?
 				 */
 				icmp_strict_tag_validation:1;
+	u32			secret;
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 308ff34002ea6b5e0620004f65ffd833087afbc1..7498af3201647fd937bf8177f04c200bea178a79 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -24,6 +24,7 @@
 #include <net/inet6_hashtables.h>
 #endif
 #include <net/secure_seq.h>
+#include <net/hotdata.h>
 #include <net/ip.h>
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
@@ -32,8 +33,6 @@ u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 		 const __u16 lport, const __be32 faddr,
 		 const __be16 fport)
 {
-	static u32 inet_ehash_secret __read_mostly;
-
 	net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secret));
 
 	return __inet_ehashfn(laddr, lport, faddr, fport,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a8acea17b4e5344d022ae8f8eb674d1a36f8035a..2beabf5b2d8628f1fed69a0212c57bd3cd638483 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -411,8 +411,6 @@ INDIRECT_CALLABLE_SCOPE
 u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 		const __be32 faddr, const __be16 fport)
 {
-	static u32 udp_ehash_secret __read_mostly;
-
 	net_get_random_once(&udp_ehash_secret, sizeof(udp_ehash_secret));
 
 	return __inet_ehashfn(laddr, lport, faddr, fport,
-- 
2.44.0.278.ge034bb2e1d-goog


