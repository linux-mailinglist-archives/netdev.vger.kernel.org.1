Return-Path: <netdev+bounces-86895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058388A0B1C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD4B1F22330
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ABB13BC35;
	Thu, 11 Apr 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgtPFucr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9026ACC
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712823934; cv=none; b=ncWZHAFP5IUp1cHXFExy3UeKbco0kNJkGn7VpSsSctphyHHv59RS7vL8WSIjmnwF03Di4OghPr3o3/lroT9pc0LB8dZwmsrk/QAKUbHfNmN2mdIl6mUMCboOQqFzLG/dHyvCQ7mgdnfCyqOj5jEvdOpS8zfAAegf026vq8BLqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712823934; c=relaxed/simple;
	bh=WS/JyUAt9W3sGXMbireDpkEvp9F3pzJjbSbBUGOCU/M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Pdm1i0rZyOAC/57mjPoKWU/6RhVxpGCsnANOtlD2O7Ol1ngHK1fR2mmDvi50h4U+5203S+4i4/KUjwcH+aLo6UwiMUxUqfisQMnXOEOfwdv6ksuFoFEybyMIUILrCMMrgJQVVaJSCuPcPAbeD24s+ROudAZxj0Q1cjfYXdkW0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgtPFucr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-618596c23b4so16776877b3.0
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 01:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712823932; x=1713428732; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xbCTb+A7Xqyd6NusDGrG+IA5K7wN9VOqDMdQwhoVsFA=;
        b=LgtPFucrbgveRuNagrHGVItn6GpLS8aO7enxhJjGljwOFgWxtxybYxmBllI8St1VyW
         hSrlbbLpCEkH7Q7BMPqvsW0ZqX8r2fHAXMJ4xk6h6EUcTcI/Zqdwyuh2QZeB0uatJSN1
         0ccg6mlznHXHzqL0kfGvPReegwktsOwgp0wkM90ix5m4eDQTATF+NL/SDbA2pIBoUxkC
         Ye6mdIh96iIf4DaJxa94wOS/xrczDzpHiTofxAMpmnAZTo9X/ECPrK02n7HOYZEkAVwM
         KnUqz4Xf9IiD+j72OIGEfO/IMCa7S273qnvl/LOr03XAr3wNLtEE/iEVdWHcd5CluIPe
         LK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712823932; x=1713428732;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbCTb+A7Xqyd6NusDGrG+IA5K7wN9VOqDMdQwhoVsFA=;
        b=t4yUJdbspkRl9TRi96JjYJMpE62/B8Rkn8EolpzrrfsxyjrIogrBR30fBmh2uKGDR/
         Sv3aMkcFjmiGzl7xrw/i4RhWrlQBY2+dmHQd+y6MUW2ztWpWqeXBn0zkaGnmQmcglq/K
         NZS1mOeWBWR4pnA8sbAXJQVBZ8i2WUhbYoJhjLLTU8YuQz6glARypxSQtECb0wfOh+6+
         41WcgZuBkrlJhSGwBUb11ULfreYScOVbV9rprQ/ZLWbl5lsHx/n/xRRB3RBft3UKiZ2o
         r/KXFbzs2NNZyDKmDotYqbaKhbVNh90s3BPgAomuHlDQzhIfcY6CnWdoVHdcgDXOoFSJ
         z0rQ==
X-Gm-Message-State: AOJu0YzSYunEx+ut3Jan6oLnbwjxm/fstEwMhmoYrFaMgyzJ2RD5milW
	kpnP51Dg6GWzNGvsELeN0LeLLX/36aMnQC69le+l1lAwwZddfjqM4Xq5qqpYgdlxQgFB06T+CJT
	5w7dbxiRCXQ==
X-Google-Smtp-Source: AGHT+IGWKrFgHFhMTGaMyVeni9E3X0jdwLZ8kLhJJ9al8Nbg3ZG+4TJweWA84otPMZzY0ycMl/MUslkrSAyScQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:72b:b0:dcd:59a5:7545 with SMTP
 id l11-20020a056902072b00b00dcd59a57545mr422658ybt.10.1712823931767; Thu, 11
 Apr 2024 01:25:31 -0700 (PDT)
Date: Thu, 11 Apr 2024 08:25:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240411082530.907113-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: small optimization when TCP_TW_SYN is processed
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"

When TCP_TW_SYN is processed, we perform a lookup to find
a listener and jump back in tcp_v6_rcv() and tcp_v4_rcv()

Paolo suggested that we do not have to check if the
found socket is a TIME_WAIT or NEW_SYN_RECV one.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/netdev/68085c8a84538cacaac991415e4ccc72f45e76c2.camel@redhat.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 net/ipv6/tcp_ipv6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e650ec71d2fe5198b9dad9e6ea9c5eaf868277f..88c83ac4212957f19efad0f967952d2502bdbc7f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2205,7 +2205,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!sk)
 		goto no_tcp_socket;
 
-process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
 
@@ -2285,6 +2284,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 	}
 
+process:
 	if (static_branch_unlikely(&ip4_min_ttl)) {
 		/* min_ttl can be changed concurrently from do_ip_setsockopt() */
 		if (unlikely(iph->ttl < READ_ONCE(inet_sk(sk)->min_ttl))) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3aa9da5c9a669d2754b421cfb704ad28def5a748..bb7c3caf4f8536dabdcb3dbe7c90aff9c8985c90 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1794,7 +1794,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	if (!sk)
 		goto no_tcp_socket;
 
-process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
 
@@ -1871,6 +1870,7 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		}
 	}
 
+process:
 	if (static_branch_unlikely(&ip6_min_hopcount)) {
 		/* min_hopcount can be changed concurrently from do_ipv6_setsockopt() */
 		if (unlikely(hdr->hop_limit < READ_ONCE(tcp_inet6_sk(sk)->min_hopcount))) {
-- 
2.44.0.478.gd926399ef9-goog


