Return-Path: <netdev+bounces-296651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uYA9K0nuJmoNngIAu9opvQ
	(envelope-from <netdev+bounces-296651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:31:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB5658BAD
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:31:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=skhYtAnH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296651-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296651-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C5D03053569
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66874325494;
	Mon,  8 Jun 2026 15:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565B3101A6
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 15:59:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934363; cv=none; b=JaAsRAlXVCB8ZlKCiSdFhFia6ci6YLkepID/VTgLQnG+s6ceRsRQqnsjzWHiv+YLLTn6hmU4pcAhAuM3FBXd3R/HzQCZJBS4dfd+08AG5Uu5JbePyE6XoQ/h7Hz6X4q0+6oY5YYmp8EM6INSpdvAy+5U9DX3iQMJ+r1dgF2Ljq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934363; c=relaxed/simple;
	bh=y1xHQSuJzF2UqRnyKwDq1kPH5W0soyshMDEbBGJOlc4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m+0CjlWSrkiUssZzmFUAScO4f72BLDeRcBwm4SIcRWKP1Wg4Eix6kUeaQd4aSWaIGC29t3qXFNAwoDC3uNT8Azsbo7de/1v/Osov7fEQG0WYB0CPfDBphR/aYBIh+zfnQeIDsRt3gCkw1pknul06Z/q4aTbmHGmYRWQtp5QtpMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skhYtAnH; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-9157116b988so1133801685a.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 08:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780934361; x=1781539161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XJUOBELYHUBB25CfUsQ2Rqlqd/XV17NtWpT3OVe+uGw=;
        b=skhYtAnHswgxurdBP4O/zpNQjsOdtCSxCs5k4Oogo9wFjt2ygOOLbYGEhfDktDuN+2
         0iyf+8seqHREab5CmULslbP+5Hf8GD6sql5eHwBlyQoPy62oXqeSgo0IAWlwgjBCCOhI
         U+zHSEZrTix50HBl9HJ9ZCW1lgM80ssNboxGdQLiCJX07Okln3F7bKw4i3FsJBP9d4lI
         8D2b0E8XOcDum+5ySsRvAou26Lsd8D63kXf3MLOV5PzxRhoEPFFSidlXALy/GIXffph0
         tRYICzLmS9YqsJEp8MMvGA1yRxVEx83PnampD6YSHIgcqckKtYsUi5h4e+Tl0bpIxjy1
         uzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934361; x=1781539161;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJUOBELYHUBB25CfUsQ2Rqlqd/XV17NtWpT3OVe+uGw=;
        b=Ldk+EWjWLY0KbiU+BGXWV7TUozvB5fwJs2fAXWtPduxTWjpB8LVBbcTN5X8bSWV2JK
         uOsKgofh6NPWiYFII5wTCG55IhBWRUEfBaIGvvT4fmNRdlflhmuCk6swYWwrqrweJBWr
         TZI7vUdaq7TpZmLHOJhBcQK/t/pN+vRWo7/zY5NpQUwqsr30J81MJZn62tnkByTUIraY
         Voilc61LhST50C83jwrjog8qqz7MFPg6igu4KMoUyNDwRt/rLAoTa9O/rJ0mqaCoNDG3
         rVKP9/zI4+5xbWfcgr8TaW6eEwhDZifdXrg+Y/eh7iuGMYCQT3iLMivPF7Tz3JNi4tir
         FHTg==
X-Forwarded-Encrypted: i=1; AFNElJ8yo1wKigZ1SUq4avU4oZ6vuJ2R8RQtZeu+SHwj4ZC1dPxmX1O8Psr1jih7N1IdKA1i2qT1coY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qwmaNHh+IZC1SYFeYuvQZIKd4Xhz9wq6cvi3hbpQhlP39tP/
	iUZIb+xhZ8x4AgGM+0Shd7kegd/82zWZ/coyRD3Ya5UqNX8a0RFjhJs88bDUCg604/L6kT3xKcN
	NaiOV75nY9VAVew==
X-Received: from qknre15.prod.google.com ([2002:a05:620a:8e0f:b0:915:8a6c:892d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:f10:b0:915:9bb4:9989 with SMTP id af79cd13be357-915a9c4bfb2mr2618246885a.1.1780934360672;
 Mon, 08 Jun 2026 08:59:20 -0700 (PDT)
Date: Mon,  8 Jun 2026 15:59:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260608155918.787644-1-edumazet@google.com>
Subject: [PATCH net] ip6_vti: set netns_immutable on the fallback device.
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Noam Rathaus <noamr@ssd-disclosure.com>, 
	Nicolas Dichtel <nicolas.dichtel@6wind.com>, Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,ssd-disclosure.com,6wind.com,secunet.com];
	TAGGED_FROM(0.00)[bounces-296651-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:noamr@ssd-disclosure.com,m:nicolas.dichtel@6wind.com,m:steffen.klassert@secunet.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EBB5658BAD

john1988 and Noam Rathaus reported that vti6_init_net() does not set the
netns_immutable flag on the per-netns fallback tunnel device (ip6_vti0).

Other similar tunnel drivers (like ip6_tunnel, sit, ip6_gre, and ip_tunnel)
correctly set this flag during their fallback device initialization to
prevent them from being moved to another network namespace.

Fixes: 61220ab34948 ("vti6: Enable namespace changing")
Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/ip6_vti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index df793c8bfffb0a26ea7f54933b88bccc9b1aa495..d2b74a6f2cf62dbb752d8842e1a4d33fc8392d41 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1159,6 +1159,7 @@ static int __net_init vti6_init_net(struct net *net)
 		goto err_alloc_dev;
 	dev_net_set(ip6n->fb_tnl_dev, net);
 	ip6n->fb_tnl_dev->rtnl_link_ops = &vti6_link_ops;
+	ip6n->fb_tnl_dev->netns_immutable = true;
 
 	err = vti6_fb_tnl_dev_init(ip6n->fb_tnl_dev);
 	if (err < 0)
-- 
2.54.0.1032.g2f8565e1d1-goog


