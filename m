Return-Path: <netdev+bounces-272128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKBTEGNZxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:05:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B5B3381CE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53DC8304B5ED
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8438734D;
	Thu, 26 Mar 2026 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akl7Rcfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C473FE34F
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540303; cv=none; b=RstFX7SU1i48+hHF7CNEKKtwpwLKw1woJmhw9HZhGK5NDR+ehdR31JBXJnnWlwuKGuTAmRwGNVoF/75Wl+CRCNlsXbM1nsArLjEAjAF10QP4RU1x44ocF/NaU9z18Xdu6yIMjTRbjdcGMATDCy7Pts4FG2Yx5nbpkrTi5mjg6JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540303; c=relaxed/simple;
	bh=9qxNSmjmmwx5hARRcvi9vM7Jjk1tgqqzAXn1qFN9kV0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HW0lemVd4xS7PB3PRRNTMfSJMYFIJfp9VYLZuaAZIq0iLQzi2+KTqouBAjrpaFm0DfLfx83QpXRXb7k5LjeEF9ctJUnFOf/SGzFNOUOngqym37liBN4uomI0SW1nqYD62L5SUfPC8yr86Z3Tt/6iUQQPo/DDZlKpzuTtB7FlkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akl7Rcfy; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-509044f54aaso34949631cf.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774540301; x=1775145101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uJxiyNB1GFRgzCoGMWokYIzWiU1euw82rZPXBr5G14Y=;
        b=akl7RcfyXCO4Emlm4r2XcljSqXvKo+2hx9+zui98c/a7qUU01hKhSNAnuBUzuLMN+V
         qxIgt2riQ879q4ihYvNUkgX1uSEOfRxjD3AdiVa0YDc4lMUMEnwkJs2nSLu2iFfNTi+s
         rY5aFLHSYYbiE6YhicgOzMi5tyxoYPFX79P6jJNJxGWEx4rK+/ceryDPgdbVQ4PiuKEq
         vfJEIGuy3ozBo7sseD5AamI8ES2HvwH4Qv34biZKq56uxdMOKd3az2C1UBwICR/c8JIg
         sr9u0em8TnZLYsiPNej4AGSxEYNeMf/XH0xvSPu9TUAWcmA0s2wL+gsf9AKb9H4OU3lr
         3Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774540301; x=1775145101;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJxiyNB1GFRgzCoGMWokYIzWiU1euw82rZPXBr5G14Y=;
        b=AbVmXvYYqN4Aj2edYUiFA5gu5AQ4wusQoDXMahy8wJqwRZnnbBzqD8emIdDNqjdPSQ
         w5+FnL23BUDmwUV1YlmVc233t1a8Hoa/RqahSwgLglVSlOZGLkwAyZN2uJb9w5MqBps9
         RJew/mkJgeY6Cdvc7jiCPGC3PnCz4lVZLIlvXErUnrjp1vhm1O0CEEim6GGS2yx+Yl7z
         7xMZK6QXTr1FCmLSWXuPr8olav1xQYWjBrlmQ1ELj7w3zz87+UFlnnIrQfb9OPPquIPy
         WB0B3LHzgnOTQIToZEp8ZpyR7I46D8ywd1C1R5nuq1PHR4U2U4g86/njTrI0sqgXUkXP
         0E4A==
X-Forwarded-Encrypted: i=1; AJvYcCVDmJRnVzUaFFZZP1wFwnT/4MF3JCPUFT4dkEjK/bLUAHZkMy4X5zXxRBS8i1p5gb0eM9e+IYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfes3G6ejiSw4G2kBolKW2A5SFpL9cdux7L01hvDO5wFG9j+M
	/7kl5RO1iqB4Iy6n7m8fZFvGZ3jxfyNSMtUbP15KDAQMoaAtG/Tubpdq2sAnSeilfB4J9ei/otB
	NjdoCNrkR5cM/2A==
X-Received: from qtwy9.prod.google.com ([2002:a05:622a:49:b0:50b:7d38:9450])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5888:0:b0:50b:444c:e268 with SMTP id d75a77b69052e-50b80d2c161mr111055611cf.19.1774540299691;
 Thu, 26 Mar 2026 08:51:39 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:51:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326155138.2429480-1-edumazet@google.com>
Subject: [PATCH v2 net] ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Oskar Kjos <oskar.kjos@hotmail.com>, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,hotmail.com,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272128-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: A7B5B3381CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Oskar Kjos reported the following problem.

ip4ip6_err() calls icmp_send() on a cloned skb whose cb[] was written
by the IPv6 receive path as struct inet6_skb_parm. icmp_send() passes
IPCB(skb2) to __ip_options_echo(), which interprets that cb[] region
as struct inet_skb_parm (IPv4). The layouts differ: inet6_skb_parm.nhoff
at offset 14 overlaps inet_skb_parm.opt.rr, producing a non-zero rr
value. __ip_options_echo() then reads optlen from attacker-controlled
packet data at sptr[rr+1] and copies that many bytes into dopt->__data,
a fixed 40-byte stack buffer (IP_OPTIONS_DATA_FIXED_SIZE).

To fix this we clear skb2->cb[], as suggested by Oskar Kjos.

Also add minimal IPv4 header validation (version == 4, ihl >= 5).

Fixes: c4d3efafcc93 ("[IPV6] IP6TUNNEL: Add support to IPv4 over IPv6 tunnel.")
Reported-by: Oskar Kjos <oskar.kjos@hotmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
v2: dot not even try to take care of IP options.

 net/ipv6/ip6_tunnel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 4c29aa94e86eb9439458e4b23426bfda8b3b8922..0b53488a922900270903cc55840014436bd946f9 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -601,11 +601,16 @@ ip4ip6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	if (!skb2)
 		return 0;
 
+	/* Remove debris left by IPv6 stack. */
+	memset(IPCB(skb2), 0, sizeof(*IPCB(skb2)));
+
 	skb_dst_drop(skb2);
 
 	skb_pull(skb2, offset);
 	skb_reset_network_header(skb2);
 	eiph = ip_hdr(skb2);
+	if (eiph->version != 4 || eiph->ihl < 5)
+		goto out;
 
 	/* Try to guess incoming interface */
 	rt = ip_route_output_ports(dev_net(skb->dev), &fl4, NULL, eiph->saddr,
-- 
2.53.0.1018.g2bb0e51243-goog


