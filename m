Return-Path: <netdev+bounces-265111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHoIHnbuq2mYiAEAu9opvQ
	(envelope-from <netdev+bounces-265111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 10:23:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22522AE08
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 10:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A185A303B7DE
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BC38757F;
	Sat,  7 Mar 2026 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4eeIcNEM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11D30595B
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772875339; cv=none; b=oKH8C4ZgLS5ycF4hS6dMIQB8gd9iG6rYhl3B9/dbuNdu814vmJlDBV7WLhdn8Z5zv6OjJzDT/mwJAYSpujcoXjLYmnpdlWHJd1bnTwxI8Z0qFFT6HWuvU5zk11pbndLnAzb2hTyejJKf8/ivfxWsRNW/jcL5nWC/qjZmpC3u3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772875339; c=relaxed/simple;
	bh=RLuf0BWPmBmgE3OCwKI148eNby71BqdruVzZ8uESdto=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jizDJrKKj1Mhe3LbLdqxMvlXWIePE0xDAfNH2lXD00b71+7obk163uMmpEy/Uqi61U74MObAkIYV0ibRxxsqLAH8+9VDJJaC1g403yWNw/v8Oa7pk86h9CDzDAy14DdHknP1nCkOJneqvZIJTCoeL2jBiDFhQWtOUpBo33Kcn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4eeIcNEM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-79881805767so117174557b3.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 01:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772875337; x=1773480137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=boljEDKAW+CRCitfA07JSzymSe3HqQTSV5hrgqY/gb8=;
        b=4eeIcNEMbz5cbXKtV4hsNgSMOF8nVV6UP7wODJNgE0LFSu41yNQLOnLUbpsWTEElFd
         tNM6G9Hr/2rObgpQe+VI5wADuutaMewDLOy6v8VjwZqxaK4Oix0TyzTjc0Dpzcfn5U4i
         HxjLWoeg2WzbOK44MA+eS9Fd4/C/tzy1a5QdZ+HJNO784v2IHsjn46Hy9mqFnMXHdJgC
         r+rh7VQfywOcpbfmGeLKdTni2krtvLvok/CtvQFbJh0BtpopYT0lKNKLYE1LDcwcVUmP
         VztMNGs03VQgtysipD9jv5UNGf0xewZvmQH1eJhG18yoqlHDA/ZHPd9zfknq/MTV6pgT
         cufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772875337; x=1773480137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=boljEDKAW+CRCitfA07JSzymSe3HqQTSV5hrgqY/gb8=;
        b=HAGs19u1YaDnDXRAeJExgM4RY/RyRtN9vBgLj1s0QHS+WazO4T+qVbULpF8o3dC8kc
         E4lk379Xsi07aG9PUWriPNLTJRNzV5uIp+NeYMYpIffCM3bl4GXD54kW0RDqHM3N4fkj
         zMP+QLCLI7cyePyakBobwuV2/pAWIKwgVGd3JDDGDpxUfIznpa+C3OUM9YuJWOpOUxT6
         6f3LbjROgqwsYZbRz13iGVhHt0uF+TgokFnJgMphc3Z6rexTKJFPrhbkTfwhWwBnBC5N
         PSZNGILAZg+o+jgxAWhCj6uSPk3p6dGSYaS5C4Re3lbQxSc1KRBIjtvom285Y4L1gFRP
         lfZg==
X-Forwarded-Encrypted: i=1; AJvYcCVEAvulF1M/JOXB3gmFpRgjq5sP7IFfP3OdLP17+UVgPXNdX1PeQeNEjTJr6dyu2+XP4OO21Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSo37BIny0hwQ6lWQ+QqoQ0xsY5luLfop2U5MZ+jm4YhuBYD1F
	15cR2azRHL46dWwHGwHrDfcNASKt9brCZ6Oe77n78KV/vuZsIRvPEWbFyvSq5YpmsdkTR1VT5XM
	H26g9DHvjedwDaQ==
X-Received: from ywah17.prod.google.com ([2002:a05:690c:c011:b0:798:6b80:4165])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6e86:b0:797:d37d:d5a1 with SMTP id 00721157ae682-798dd7c6bb0mr45157047b3.61.1772875336648;
 Sat, 07 Mar 2026 01:22:16 -0800 (PST)
Date: Sat,  7 Mar 2026 09:22:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307092214.2433548-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move sysctl_tcp_shrink_window to
 netns_ipv4_read_txrx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DB22522AE08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265111-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Commit 18fd64d25422 ("netns-ipv4: reorganize netns_ipv4 fast path
variables") missed that __tcp_select_window() is reading
net->ipv4.sysctl_tcp_shrink_window.

Move this field to netns_ipv4_read_txrx group, as __tcp_select_window()
is used both in tx and rx paths.

Saves a potential cache line miss.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/netns/ipv4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4c249aeaf7f12f8237232a6f3d3f3ed56d0a53d4..38624beff9b34161327d7549fcd0f041c9c91679 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -74,6 +74,7 @@ struct netns_ipv4 {
 
 	/* TXRX readonly hotpath cache lines */
 	__cacheline_group_begin(netns_ipv4_read_txrx);
+	u8		sysctl_tcp_shrink_window;
 	__cacheline_group_end(netns_ipv4_read_txrx);
 
 	/* RX readonly hotpath cache line */
@@ -122,7 +123,6 @@ struct netns_ipv4 {
 #endif
 	bool			fib_has_custom_local_routes;
 	bool			fib_offload_disabled;
-	u8			sysctl_tcp_shrink_window;
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	atomic_t		fib_num_tclassid_users;
 #endif
-- 
2.53.0.473.g4a7958ca14-goog


