Return-Path: <netdev+bounces-85493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848B89B014
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 11:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF051F212DF
	for <lists+netdev@lfdr.de>; Sun,  7 Apr 2024 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0D13AF9;
	Sun,  7 Apr 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iL7QDBzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1223D107A8
	for <netdev@vger.kernel.org>; Sun,  7 Apr 2024 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712482410; cv=none; b=D8kZ+TV2f4sPXUWs02aSUeDTOUcP4srLB2q5V6PMa0AHjmRtLXQvxpvHzQjhFf7U4tTWdG0R+ierGKH/8OKv5BNzWNkfffYltOhEc1o3ZkcwCUs495LUEkBwpkjlijywk6vLKsF/QhPuvtti8LAdN91q/oAtMf3GjYwcfiKPemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712482410; c=relaxed/simple;
	bh=WHEM/GgC/BWwxDhreaSn/efowbUFcIbm6CieXUDGRAE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=elJKwXZRWHGttrsFM/1DSi6os6+YYHZPh7gJEZ2GLRru9VlR4lUdUXgAbzEvQDqeteoXNYx2jKnmrqCB0EmQFwWPGmkmJs23xcKypaGsV8FMX40vSBd0ru6AxPkwYJHq560F0dP+tqDvglt68dL4fswfihhMvs8G4dRpBe9V27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iL7QDBzN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so4541860276.3
        for <netdev@vger.kernel.org>; Sun, 07 Apr 2024 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712482408; x=1713087208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GsfbyJaiO3b+uQOk0EL3Ne4j48eIKP12k9tfUQp1tuI=;
        b=iL7QDBzNFfk/1cXEUR9eB2f5TX6QXIt0fWNoY7brbuvehud4ncfN9KH2+2t6AV8X37
         muwwbg39luUAXK3lcMora8QucfYFcxNo2GK+CZ59hMfBmWtdO+0N9lF0MoWQFihjFKYx
         VFSzew4snm/eJKNOnbX1So+uM5Ekl3k5tM8nFXE175g037EMMscN4W+Hx+/1fJtUWIBe
         c6ZHNutK/EJ1iM+DITGG2h89czOArRcZiRtUj/rKnPDZbGqXrInw9ZTiSg5mfyjE4GAi
         qs6YNNPWjpRErFwA64BMtGcgsH1lr1jU3YVj2izMHfKzwV+SyPUsESPFsK++cDD5sfj9
         U7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712482408; x=1713087208;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GsfbyJaiO3b+uQOk0EL3Ne4j48eIKP12k9tfUQp1tuI=;
        b=EV80U0g1xZo9QYknadlU2hVE3wlWOuwe+gN/qt0vV/dTH1W+TpSBJMvuTcPDyM3747
         s9NSZZrrZgJWoFmpWeY22CvwP2or34nelvp0lQPlkF5uVb47TE0Lh3N5L6nt5ipGLSK7
         kBARxht8Yht91dXUxwYSAjftBfxzdX1cQd3UpoNm18hfUdqSsG8TvB1laAKpjOhAnwbX
         868VB4J7yjLkuKtiIRytN/Ni2BfuPb7yQfQy97UjiBDySh2z7/LOVnP7mh5PW3fPyttD
         2hSph1M4njfR4JxykOjml18buhzNEPy36WuCmQxoyfmkU7ZOlB0TFhhW4aZB6BlXT0F0
         FIWw==
X-Forwarded-Encrypted: i=1; AJvYcCWKb6nnqkd7ZQKGUHnGk8nEIOjeHk576o2VBkbnpObUodY/DVxpTNql9lyXVUxyVKBspF/VCLoErYutBrCsXR9w0yQJpnfe
X-Gm-Message-State: AOJu0YwtP2xFCN1c3SJuxv5sF7JhSC9ePTNvWM79EI9pkenhwU5qBDr0
	TLVeJMpYtb6SEbF6gOGLEGyc1sLnqLDMy6EXdPhaF3y+Jcy1tWSYTG6eCVCw37Ubv6e0a+jGosv
	Wk+uhzUBZcg==
X-Google-Smtp-Source: AGHT+IGleRRQxYEPyRe6LrPpZieehh8I1LhzTjVI9OskmiK4B9Ua8AKw54unNrxfR5URxYzqFWA5jLrfQGtIVg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:f88:b0:dc2:5273:53f9 with SMTP
 id ft8-20020a0569020f8800b00dc2527353f9mr483087ybb.1.1712482408102; Sun, 07
 Apr 2024 02:33:28 -0700 (PDT)
Date: Sun,  7 Apr 2024 09:33:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240407093322.3172088-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: fix ISN selection in TIMEWAIT -> SYN_RECV
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP can transform a TIMEWAIT socket into a SYN_RECV one from
a SYN packet, and the ISN of the SYNACK packet is normally
generated using TIMEWAIT tw_snd_nxt.

This SYN packet also bypasses normal checks against listen queue
being full or not.

Unfortunately this has been broken almost one decade ago.

This series fixes the issue, in two patches.

First patch refactors code to add tcp_tw_isn as a parameter
to ->route_req(), to make the second patch smaller.

Second patch fixes the issue, by no longer using TCP_SKB_CB(skb)
to store the tcp_tw_isn.

Following packetdrill test passes after this series:

// Set up a server listening socket.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
   +0 bind(3, ..., ...) = 0
   +0 listen(3, 1) = 0

// Establish connection
   +0 < S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK>
   +0 > S. 0:0(0) ack 1    <mss 1460,nop,nop,sackOK>
 +.01 < . 1:1(0) ack 1 win 32792

   +0 accept(3, ..., ...) = 4

// We close(), send a FIN, and get an ACK and FIN, in order to get into TIME_WAIT.

 +.01 close(4) = 0
   +0 > F. 1:1(0) ack 1
 +.01 < F. 1:1(0) ack 2 win 32792
   +0 > . 2:2(0) ack 2

// SYN hitting a TIME_WAIT -> should use an ISN based on TIMEWAIT tw_snd_nxt

 +.01 < S 1000:1000(0) win 65535 <mss 1460,nop,nop,sackOK>
   +0 > S. 65539:65539(0) ack 1001 <mss 1460,nop,nop,sackOK>


Eric Dumazet (2):
  tcp: propagate tcp_tw_isn via an extra parameter to ->route_req()
  tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field

 include/net/tcp.h        | 13 +++++++------
 net/ipv4/tcp.c           |  3 +++
 net/ipv4/tcp_input.c     | 28 +++++++++++++++++-----------
 net/ipv4/tcp_ipv4.c      |  8 +++++---
 net/ipv4/tcp_minisocks.c |  4 ++--
 net/ipv6/tcp_ipv6.c      | 15 +++++++++------
 net/mptcp/subflow.c      | 10 ++++++----
 7 files changed, 49 insertions(+), 32 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


