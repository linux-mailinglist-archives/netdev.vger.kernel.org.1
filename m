Return-Path: <netdev+bounces-306090-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lT52DRJfT2qBfQIAu9opvQ
	(envelope-from <netdev+bounces-306090-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:42:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8087472E6B1
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 10:42:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=avHKS5EF;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306090-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306090-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CF430578F8
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28F3F076F;
	Thu,  9 Jul 2026 08:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C93EFFDC
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 08:35:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586124; cv=none; b=ScwvgM82ZBPj2X9Id3+Je8Hdam4TA+M9IA7uMPVh+YMCCEOETJWqToGU6+YmUZXjJ50HhKX4y5LvMGyBG64qXtCYstxDZM1e5mUrHtCSsUkrsVXUGC04hAsaexpIYCNwFf00Rexw7Sf6S2OtQF6rjZN5lZhd+cystpK/eVxzUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586124; c=relaxed/simple;
	bh=EmfGE2fJGvx4uo658fNYnCEeeIbHPJMH4oIWknUOE+k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oQdG/X6kUfth4u/mRK/xTxikRD5VvbZmqgOA6ZTTNAyvAQTLVBlfcrZkgD9b9AthORgFHjEZbE27nyqnRiu72b70cgwhdVBXC5ZA8LJzMWffAFTnySgzi0uTv7ELxDCxodORbBhRwkSMVeO3ANI7BSgQss9p8qoDNvZpVap5Vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avHKS5EF; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso1735343a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783586122; x=1784190922; darn=vger.kernel.org;
        h=mime-version:content-type:message-id:date:subject:cc:to:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=05+LHhpaaEHtiLUM/uJYO+V0R+R9kRnyL/DEaqmQD5k=;
        b=avHKS5EFXaRFtHZNufv0ECXITwvEjsyqkxU01M4l0MXyMKW8pb8uhZ7JjlpordcyAP
         kUw3hWmfL2m8GRTeQIYW9Ts00FBYdG1BG4HXbvVh98Qxx/HNkaY3h8Y3U4IHZfC7r8bA
         Z3QnVPGM+4ZVKyobcDi6lofnBPI1aY/umap4O2fGOXkiLIaScehbTcY3MLeutPI+W/Qx
         btK8/0RO79DnTF6LpLp4D7AzvAZfHnXZxzYmASUTodxtUh+VM4sPl8aSDi2/yT7YXpAZ
         ifZQS05JOzC3Mxn6TOS/s6kUdNPi4Dt1gQ2BLXXYKHvr/41vQU6XO5QKZXQZ4fg7MuSN
         Gpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586122; x=1784190922;
        h=mime-version:content-type:message-id:date:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=05+LHhpaaEHtiLUM/uJYO+V0R+R9kRnyL/DEaqmQD5k=;
        b=A9fLzwsvGXKNlQB3KsEmlRO7RmioGK1NZYxVtISzwM+RyHsKWE7pnDn9H4fb7ULkqU
         TcBrxMd/gaTI/yB61KJNY0KbfA/fe/xUa0kRgNvlcLxMo+0fEmSVQgFKKO7db0+IAhrv
         cVPoovtuW9wL0fIGGJ8ZViLzyopZGmw6vVm9nFkKMeYQYyk4vfAuXkXVYhHCLmvI0hfZ
         GSpGAC/IJezGQdhIsrBZKCUgKFdBI5mp6zoOi9OPQqHhtFVkRmakRTner5os0TTS2FmH
         CvyaqZjAO75xHTusI8DC8ujSmnSGsSiuRAcB4HNpy5Wu7mVg5pW1eBo/Ilt4MP86EphE
         h9qg==
X-Gm-Message-State: AOJu0YzyYHjqO0fvZaF7nluXx4VNJxmPLx99xfiKTmBTl+Rl9yY8lAtk
	/X6KyZhYeHWjq2IT6WB7XsrqqKXbor5X3r77ucje62SEtFqvr7qK02fw2c4KhbaghNc=
X-Gm-Gg: AfdE7cmQsRDVbgzU8SvXcrcQC/ohxKF8gpQjc9pukqWCUhinet/3z8na0I8oxYtjJTY
	S/vDbZJ88LyLYoQDSms8Pslz33uxiN2P9kehhd42rqfPRGapEeMVU0rE5AdyJ4G/QRXOXr4QDn9
	w1gnaDw+KcUPtfaOQIc8SXP4N1cnEXheTxa4UKea47bxhk5Uy5QKbvtw8jkAOl5AiE7iby0WcKT
	FpcYRVqlCDUoO+UtQ0qNdebHrv7l1Qq6nlqhRh7io9iRLAV/yrUEM9nc96uqTQkNl1EiG+Q1f7j
	lzJtgc1ICJpybUB0FhqiB1Fwq6DFJP5jJVWwUbXl8j+CC1IaRObNvcJa2f9WQMhgzQrnQtpK2jo
	SxS8UelzbmMDOolS7nv5eWqPEfm1baYvHSpFbPMhqFeeShcrK7eXcULH0N6hN4y8iODTLUBr6rp
	vs404r1Q==
X-Received: by 2002:a17:90b:4a4f:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-389415edb6fmr6386335a91.10.1783586122340;
        Thu, 09 Jul 2026 01:35:22 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5564f58csm811721a91.8.2026.07.09.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:35:22 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] ipv6: initialize ipcm6_cookie before parsing control messages
Date: Thu, 9 Jul 2026 16:32:30 +0800
Message-ID: <178358611790.128118.11036367713019213946@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306090-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8087472E6B1

ip6_datagram_send_ctl() parses both SOL_IPV6 and SOL_SOCKET control
messages. For SOL_SOCKET messages it passes ipc6->sockc to
__sock_cmsg_send(), which updates fields such as tsflags with
read-modify-write operations.

The IPV6_2292PKTOPTIONS and flowlabel option paths only set ipc6.opt
before calling ip6_datagram_send_ctl(). If a SOL_SOCKET control message
such as SO_TIMESTAMPING_* or SCM_TS_OPT_ID is present, this can read
uninitialized sockc state.

Initialize the ipcm6_cookie with ipcm6_init_sk(), as the normal IPv6
sendmsg paths do, before overriding ->opt with the temporary option
buffer.

Signed-off-by: Wayen Yan <win847@gmail.com>
---
 net/ipv6/ip6_flowlabel.c | 1 +
 net/ipv6/ipv6_sockglue.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1ab5ad0dcf24..5cbfb82710f4 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -405,6 +405,7 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
 		msg.msg_control = (void *)(fl->opt+1);
 		memset(&flowi6, 0, sizeof(flowi6));
 
+		ipcm6_init_sk(&ipc6, sk);
 		ipc6.opt = fl->opt;
 		err = ip6_datagram_send_ctl(net, sk, &msg, &flowi6, &ipc6);
 		if (err)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e..0dcd2c224014 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -839,6 +839,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		msg.msg_controllen = optlen;
 		msg.msg_control_is_user = false;
 		msg.msg_control = (void *)(opt+1);
+		ipcm6_init_sk(&ipc6, sk);
 		ipc6.opt = opt;
 
 		retv = ip6_datagram_send_ctl(net, sk, &msg, &fl6, &ipc6);
-- 
2.51.0



