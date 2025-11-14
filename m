Return-Path: <netdev+bounces-238676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00678C5D6F5
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC81E4215DC
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A5531A7EA;
	Fri, 14 Nov 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Msb0e0qK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF031A553
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128305; cv=none; b=rVjr4yaATFXHs4PdbvjC4rBu+lsS6vIcZohKgydeY8H1ZtSpfKWB/BoAq6imBIgA8B/9DhkCVMigRwmJAl1FkS8UoYYaj4jmnaB0ZGgle5iDson91xJupMAs7zMwBqThhTUHo2LpV8/U6r4KkW82CuoHKjqrGxJWVZkLiCZoHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128305; c=relaxed/simple;
	bh=sJoCOb59lek2MtBa9ms3bGQWiJQ+5zr3mMwP0lE+I9A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XYMNr9t2Y7/VkbuwDSw6gWEqIyODs+Vq213qP7G1xJlmfGworjnCCm9nvqgN1WQAfELLJbp7TOHZ9uoWeC4XttPPyvlRSCbwfoatqZyj++gtbz8Owo4oZQVzLYoxYA0XswXgmvlS4ckt521UZbRIqtsUXwA9dc7G/vXfEPuJDU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Msb0e0qK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-89090e340bfso449665085a.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 05:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763128303; x=1763733103; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8fX7j3pxh3AWoBREo0gN87yLz1wqkWYDWnfHdqYzH+Y=;
        b=Msb0e0qKVyFaT+NLHssxiXpbY7lFnupTo3N/lEYx0Jt6chilKVyeaX6kjxQfxmMRZp
         itwRBGgfHbZxUlH4cztbOTzJFLd+zQfamoq9laMT8jAW45gVknX4f6RareKySuP9FHZH
         S1iOglVMWlaqUpl5UKXhPFyJKa9FzYcwybqvBVE/SLsEANeIrzsctzeQ1F7hoaWa5aQV
         q94tsoAtnDkb8H7keyXJYlNg2NOB6eCtYxf/FDp5QeJNFbRgtHjeVt5hf2qNYtmD6H9/
         8IBBT+S+bZ+OdLlJPriTBKu5qnFayqvAMzuh99sQ9lufGOKEELn3ZduAvatHV4pRdlit
         nffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763128303; x=1763733103;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fX7j3pxh3AWoBREo0gN87yLz1wqkWYDWnfHdqYzH+Y=;
        b=ssj76kQzHF0zllzgp3XCXVFCRQNsUOR3m3+lFGU22vir/EaZEebK282Ygdcg0xPC9U
         KFDaDYNAEj9wTWLbDn/A/LYURsZK4UWnyYeO080rSVa5mKC+/nEMs194U6pDQQXt+x4g
         /kcIq55/d5kNKB8k5b5VSD0WvDuM5K/F8oKQrDPzK3QoGTVeYf/WX7vMRldVdq3i+lIM
         yBI5HGuoij/JGsaCOcSTp35mvLsU8KrRZofXEcgNzPCoXrOk8mOKo3CbYXXit+NrDJam
         SAArIImJpAmMhaxh3sDnkUA/JwV05OiSBl5nXK29QeQgYTWdNp/eC0odHipg18ilvCQx
         xMwg==
X-Forwarded-Encrypted: i=1; AJvYcCV1djkSPp3sy+7xTzNwBkjM62hVi6ygwgztjNWJPlH5IJZck5BU6HELeLNffbyej05B9WcGDvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMhdwPgXkeQTTj1har/E/HIdshXvPj+h2iaCFp2GwhRnUH7LC
	T4e/QYgxi1pCXkbS/z9ZwcKwyBhh6KOfitJQY0qHiq1x/8dX2ymtqOM2RWVfKURGCdDFMWrAPhy
	TF0dbGoVBT6BgBw==
X-Google-Smtp-Source: AGHT+IH/bGLaBYGJmvGcff6xjJOqDbAniO1UK6/H7NPkITktEOjBWMrxzylwrCD0ob9MI71MPEnK/9NJIF7EFg==
X-Received: from qkay13.prod.google.com ([2002:a05:620a:a08d:b0:8b2:bc65:3f17])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:710a:b0:8b2:6ac5:bcb1 with SMTP id af79cd13be357-8b2c315e7a5mr389180685a.31.1763128303193;
 Fri, 14 Nov 2025 05:51:43 -0800 (PST)
Date: Fri, 14 Nov 2025 13:51:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114135141.3810964-1-edumazet@google.com>
Subject: [PATCH net] tcp: reduce tcp_comp_sack_slack_ns default value to 10 usec
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

net.ipv4.tcp_comp_sack_slack_ns current default value is too high.

When a flow has many drops (1 % or more), and small RTT, adding 100 usec
before sending SACK stalls the sender relying on getting SACK
fast enough to keep the pipe busy.

Decrease the default to 10 usec.

This is orthogonal to Congestion Control heuristics to determine
if drops are caused by congestion or not.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst | 3 ++-
 net/ipv4/tcp_ipv4.c                    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 2bae61be18593a8111a83d9f034517e4646eb653..f4ad739a6b532914e4091c425828b329ee342bc6 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -875,8 +875,9 @@ tcp_comp_sack_slack_ns - LONG INTEGER
 	timer used by SACK compression. This gives extra time
 	for small RTT flows, and reduces system overhead by allowing
 	opportunistic reduction of timer interrupts.
+	Too big values might reduce goodput.
 
-	Default : 100,000 ns (100 us)
+	Default : 10,000 ns (10 us)
 
 tcp_comp_sack_nr - INTEGER
 	Max number of SACK that can be compressed.
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a7d9fec2950b915e24f0586b2cb964e0e68866ed..6fcaecb67284ecade97b623d955dbbe2cd02a831 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3593,7 +3593,7 @@ static int __net_init tcp_sk_init(struct net *net)
 		       sizeof(init_net.ipv4.sysctl_tcp_wmem));
 	}
 	net->ipv4.sysctl_tcp_comp_sack_delay_ns = NSEC_PER_MSEC;
-	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 100 * NSEC_PER_USEC;
+	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 10 * NSEC_PER_USEC;
 	net->ipv4.sysctl_tcp_comp_sack_nr = 44;
 	net->ipv4.sysctl_tcp_comp_sack_rtt_percent = 33;
 	net->ipv4.sysctl_tcp_backlog_ack_defer = 1;
-- 
2.52.0.rc1.455.g30608eb744-goog


