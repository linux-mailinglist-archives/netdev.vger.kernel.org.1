Return-Path: <netdev+bounces-250077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C4D23AC6
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79A00305131C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2900F35EDC8;
	Thu, 15 Jan 2026 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xAVsqKCk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EC35EDA7
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470115; cv=none; b=LQG1LqbsVFsnsNzU/QWILviLfR8pwm34XdjjCxRA/h8TfBoYeifjwoc7hhaAvBC+NfC1uWTaBun7H7laoly2rATg/gqFn2NVG1TNHTX9hsPNr4kHaCzlaBVmfcQmGcKmZir0Bh/F4v60xuuRe4pL3RJQfp9uhFopbwHb/sgUEUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470115; c=relaxed/simple;
	bh=X42ohXis8m7ZoB0/WMxSnw55Hz5qSKtrV/Sp0nqq9BQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+N5jSNMs/Vmr7sjL5LhAC2vteiY2n2eiJXFMCToJ+/I8hD8vwI9BmPMj1CHdFtcERisOLvUlnQwN5H/a+0giM7C/lPbdGLi/ymm/5gwZZUSBInA6ImiXG2MLhqZscOEAUpyCFZ3YFtUJJ8Yd1O6y19laQLIPiiZpu72o6fFLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xAVsqKCk; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ed6ff3de05so21058121cf.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768470113; x=1769074913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i1mEg2govCaKZEoJExX3mr/7fUYffVXSX3Bl0iaAvpI=;
        b=xAVsqKCkwXRdufg2Q6ElBNEHVUvxqZ4NYk0lLmiHXMQIQNZSguBnTdV27jHcrnCFUk
         92y7LkDP+TtFlGHI+4mmPBjplN4QgzivwNKt63v+WnQXGXjelvNu80dnajWwD4plH6HG
         LaNA8qOTahIVVzZwyxAThDTrdE7uVy6eNb8oRaBp55vbpX4f1RRhYAJKwzmcR4eVDzLA
         6c8leureUqzs+eCgSZt1EcziFfcts+MqbK1NMuNi27PmrltZHRq1SCbJNH3crWvxJKjx
         iWaNpYYJnPyXUWV1km6q+XOZN4jTbQvkamG2XVGQrnIemZA2QFOhB47QCHOezsVta/q+
         qyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768470113; x=1769074913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1mEg2govCaKZEoJExX3mr/7fUYffVXSX3Bl0iaAvpI=;
        b=lHrMJD94pRPLNe3rI98Q4vZxW9KcDE+kt/eEMUBUROuLbUwgYrFVfOqHyD5jefEn8O
         VB2IBDPq/lXcK9OpjKe88cRI0bYECq6KWKY3BzBDuIxc3xDOTgVUD9QewXG+fsPWZ0hr
         gCfRpml/oqww3kPiIBXfi3SN2y1vz3jrnnG3vruX8Z2bQmJ4Dfigio2fAAH9o5AzrIoW
         0UsTnEipD9pOyiYJ11TdCEDfPK9MCNu6HDHvzEamuJXM92pC84ffNAN64iq4IFLGzMZz
         zDKShaFcTGO+sL7zZlvEIkwJo2uBuEmoJAyF+vFbXjsnKhNUT5pJUXsosU3wNfjroKvt
         GukA==
X-Forwarded-Encrypted: i=1; AJvYcCXrp9AIRlwftCnwnuiyrxM5gMz+K5pc8bob2DTC5E+uPO7g4kYmPuxrdqHWSOXWitXZKE3VpPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWQnTRHms8Qgh7bVIwEaQPNK7dB9hWF/yjn4P44N88BVxrr50
	dsQ3t+Cl5l8+eWo4PpniXkRfYqX3YKbA6QL+yMS+bNl9h5C3dw3w8dTUQJUxJtjSUOFTsjtZ9fH
	4wbeYdIxfDMfeew==
X-Received: from qto23.prod.google.com ([2002:a05:622a:a6d7:b0:4ee:c07:caaf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1aaa:b0:4ed:6b27:1d1a with SMTP id d75a77b69052e-5014822c00bmr76762761cf.32.1768470112808;
 Thu, 15 Jan 2026 01:41:52 -0800 (PST)
Date: Thu, 15 Jan 2026 09:41:38 +0000
In-Reply-To: <20260115094141.3124990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115094141.3124990-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115094141.3124990-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] ipv6: annotate data-races over sysctl.flowlabel_reflect
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add missing READ_ONCE() when reading ipv6.sysctl.flowlabel_reflect,
as its value can be changed under us.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/af_inet6.c | 4 ++--
 net/ipv6/icmp.c     | 3 ++-
 net/ipv6/tcp_ipv6.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index b705751eb73c6b784b74f40ab3d7c0933f8259f0..bd29840659f34b5754a182303d2871c5f884dfce 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -224,8 +224,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	inet6_set_bit(MC6_LOOP, sk);
 	inet6_set_bit(MC6_ALL, sk);
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
-	inet6_assign_bit(REPFLOW, sk, net->ipv6.sysctl.flowlabel_reflect &
-				     FLOWLABEL_REFLECT_ESTABLISHED);
+	inet6_assign_bit(REPFLOW, sk, READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
+				      FLOWLABEL_REFLECT_ESTABLISHED);
 	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
 	sk->sk_txrehash = READ_ONCE(net->core.sysctl_txrehash);
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 5d2f90babaa5f14ea6bd712127e31e891e284130..c72270582d9c507f00464d7dc1c57248f8679f72 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -958,7 +958,8 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	tmp_hdr.icmp6_type = type;
 
 	memset(&fl6, 0, sizeof(fl6));
-	if (net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_ICMPV6_ECHO_REPLIES)
+	if (READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
+	    FLOWLABEL_REFLECT_ICMPV6_ECHO_REPLIES)
 		fl6.flowlabel = ip6_flowlabel(ipv6_hdr(skb));
 
 	fl6.flowi6_proto = IPPROTO_ICMPV6;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 280fe59785598e269183bf90f962ea8d58632b9a..4ae664b05fa9171ed996bf8f3b6e7b2aaa63d5c9 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1085,7 +1085,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb,
 			txhash = inet_twsk(sk)->tw_txhash;
 		}
 	} else {
-		if (net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_TCP_RESET)
+		if (READ_ONCE(net->ipv6.sysctl.flowlabel_reflect) &
+		    FLOWLABEL_REFLECT_TCP_RESET)
 			label = ip6_flowlabel(ipv6h);
 	}
 
-- 
2.52.0.457.g6b5491de43-goog


