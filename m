Return-Path: <netdev+bounces-224807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E812AB8AC3F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16694E5F38
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A22322A03;
	Fri, 19 Sep 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4Cl3pj9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23C25EF90
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303027; cv=none; b=l1F5GiD49dabN43fU278hFm+rRFBOFyprSm1AA7sKzQAkcSidyeJhvg4S7KQTWdbVGR781jQXmVTNV7HuevLj1jW3UOw7YqHyE6JHvdrGGqN6zYV0dZ+zbP/RlN2b4esIydm0D4qUskIV3qNM1zSMdcEEBCy5Fj+r1L0sK79kfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303027; c=relaxed/simple;
	bh=JZj9auJ7JYGycI9LrR62D2gYRthD2d4QaIrDPfu4Mqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtwUXy197oSWK4Rl703Q3nRRhtSjuc6r8Q7xCOzzJsYFSi4Dn+GqmhCH5VRuYcO6FXFYyCf7yAlYX0fspyZ2isyO5efG5n2AI9ETgnTnwEcdWRyF8QIYG9xixsQN0IoObVaWJt9vse1Jj5HDwrFUUOcP0J0Wei3v1LgU9WM/7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4Cl3pj9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806df50so20128225ad.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758303025; x=1758907825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=O4Cl3pj94Y74HTI235JeXeAuHXdQRYeQsydVKpBRkTj1lkDJZ24cUdjOAz9XLuu6lA
         mWCNpygvRP0OCCBSuzarLOkUmE+6fho3SCB4zy4O88di1zviUXC/VkTqJCqLXUxHmLWt
         4LGAS1OQnlPUEysmxw4Pol2r69+SVjfuCLH0/ND2KBuQkc70x0EgRIvjtaJ/MDZVlNKV
         SFdhK6CzpI5nl6A6pG2ZzoxbcK7PK4VrkcIhn4wHfMSQEobNzZfU+AuXckqAk8B7cLyP
         /hDwsz/F+7kGpPm0xUUlNDiVxqXyyTtldDqaoN4fnzQAmWvoK7rmSJzdx4VrbNWBwl/X
         lw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758303025; x=1758907825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szAE+bPsPINah1q0UtkV9PIi4Hs5RhSjEz/DHr/a1dA=;
        b=Pl7V1lLz5+s1saF2Jy0ONkCpLr1EDQdXOCcieZiXcg3KpGT22f59b34+WruvBpcrvO
         GJ8hPS16aHVEbYgCR5o7IiIptd17PWi7evph6WRpq+SS0AVLLVz0pchMXs0bbDG2vKyr
         kORnusO+fbDzkTIWw05R99JzMv+B8p6QFJpzzK5SiAfiTQTK1Ko8wUoK1Qa8TFWpb9d/
         6T0I/GMGxlGdL4o21Lsmr1bgql8UrKPi5mYBu99ifTPu0SGy9/T7qScg42abvIEgUJwG
         5bxki138wL1CC9O3l1V7V533RoZlRgQ9AzOnO6Ft79ohw6dQ6gbMojR9PgdJLQcgwr8V
         0Kfg==
X-Gm-Message-State: AOJu0YwFwI66hVnsOmH99G2ovT1Dn0utYkzq3Rdeu8XwK6EBl943EEmO
	YHRQyr/HL0bdK/e0RHzRQ6gzfMjJ4JtreqlpQyAfuJBssklZr8vDye/z
X-Gm-Gg: ASbGnct4IndvNDz0mDRF7e4/Uf+8znPqBDJrmi1Fu/Wy1CHr9F0HE0P7MLjb1IaxhXM
	kNQ3lrHCR4tcyJ+PP0lSQtLpF3JGK0YuCJFidwFtTxoD5Uh4woa3RrgEuJmDHbvyMPVr7cpQ9ZD
	d5242r9O3dCYlmpuwB58Jv1Lchgj0wiyFDZJZOnAeu38yvaz1Se/9JGoBhRaD8o6Fjfw+urm1bT
	s/Z21D82woahCDNdFhQYwVKlBjEniBCk8PTdqWIpmDtvEZ5CNPkvStdwzQQZBEn55ZdwYkdoaoF
	PuVXg4PrE1ef1jzkGjqheG1FRmivFz+W8jswWLRLk/oS/A7owiIBD7sUeKbedEOH0Ip57kwGtyx
	y+oqINzh+JmfGI4XULUsoY4DFpT1JVuYkqvA=
X-Google-Smtp-Source: AGHT+IH4tmDryks4lpWMvZ7RPdjoVOLv7Whjz+fTz4uGIXQE7YrtEn7NauesGMcUefMfTnayFjWwpA==
X-Received: by 2002:a17:902:8bc3:b0:269:b2a5:8827 with SMTP id d9443c01a7336-269ba467eebmr44697195ad.16.1758303025452;
        Fri, 19 Sep 2025 10:30:25 -0700 (PDT)
Received: from localhost.localdomain ([150.109.25.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053ef0sm60865185ad.28.2025.09.19.10.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:30:24 -0700 (PDT)
From: HaiYang Zhong <wokezhong@gmail.com>
X-Google-Original-From: HaiYang Zhong <wokezhong@tencent.com>
To: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wokezhong@tencent.com
Subject: [RFC net v1] net/tcp: fix permanent FIN-WAIT-1 state with continuous zero window packets
Date: Sat, 20 Sep 2025 01:30:15 +0800
Message-ID: <20250919173016.3454395-1-wokezhong@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a TCP connection is in FIN-WAIT-1 state with the FIN packet blocked in
the send buffer, and the peer continuously sends zero-window advertisements,
the current implementation reset the zero-window probe timer while maintaining
the current `icsk->icsk_backoff`, causing the connection to remain permanently
in FIN-WAIT-1 state.

Reproduce conditions:
1. Peer's receive window is full and actively sending continuous zero window
   advertisements.
2. Local FIN packet is blocked in send buffer due to peer's zero-window.
3. Local socket has been closed (entered orphan state).

The root cause lies in the tcp_ack_probe() function: when receiving a zero-window ACK,
- It reset the probe timer while keeping the current `icsk->icsk_backoff`.
- This would result in the condition `icsk->icsk_backoff >= max_probes` false.
- Orphaned socket cannot be set to close.

This patch modifies the tcp_ack_probe() logic: when the socket is dead,
upon receiving a zero-window packet, instead of resetting the probe timer,
we maintain the current timer, ensuring the probe interval grows according
to 'icsk->icsk_backoff', thus causing the zero-window probe timer to eventually
timeout and close the socket.

Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
---
 net/ipv4/tcp_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71b76e98371a..22fc82cb6b73 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3440,6 +3440,8 @@ static void tcp_ack_probe(struct sock *sk)
 	} else {
 		unsigned long when = tcp_probe0_when(sk, tcp_rto_max(sk));
 
+		if (sock_flag(sk, SOCK_DEAD) && icsk->icsk_backoff != 0)
+			return;
 		when = tcp_clamp_probe0_to_user_timeout(sk, when);
 		tcp_reset_xmit_timer(sk, ICSK_TIME_PROBE0, when, true);
 	}
-- 
2.43.7


