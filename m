Return-Path: <netdev+bounces-296666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jD1rK3IAJ2r0pQIAu9opvQ
	(envelope-from <netdev+bounces-296666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:48:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0B659632
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:48:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="o6W/4mmJ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296666-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296666-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F1F3206066
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965083D331A;
	Mon,  8 Jun 2026 16:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AB3D3002
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:46:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937182; cv=none; b=uET0U7NIl4UhqHjz8y4CE/lZsoN7+kSgMlXeOptJJvmPxwFF6JRO+0X8f6g/9oRgPXILFv3rUMN3D9m63EmW5nP/zNQG6uoSI6oGnl2gQdumF/fg/dcmeb7tb2Q5d7i8+sezH8edfEfhGAYCKmdg2qMnlaqoS9YWRUGxbIeWv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937182; c=relaxed/simple;
	bh=T9Q/W6S4nDjyrLHQInjBqyNJ+/pEqaPwGuGOGm03/uE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GpHmF5GEc4s5/mEysGvwa4h1tes1SCJ7O7RbK2re9OvrJ0+pMAFMnr587sYBY3QJszrv2txeiZ+dwJ7NUxyZlQkh679RpMItIWJRORkCUbs6fo0BgB0cG3ekiwTrPOOB2q8/dzUJYO+K8UfNO+pHBMqfz2FySzDJR0nBodxydC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6W/4mmJ; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8cecf8bb835so59374966d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780937175; x=1781541975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYeQh5he5QFDLKe/VfKWZrLhJFCMpCh7Exgo1nUTer4=;
        b=o6W/4mmJ2Sh4fSZppYsqVo3Dhdd9TZiAbyTSAe+2CHrHeri7jR2E8C0J0cU1TNLCUW
         3HgIzGNLmuPaCUMTc86+SRfQagD9/VUu3XrYE2/aM21IZc+boDIzA5xf1nyTyT1VGhif
         npln1+xybSVpLjkDni18KWeIoRWVtlx7uq92RkuxMJGDJgmfz8miyoNssxvkFZK5sQ+3
         fnO1nxT56G2lnvAwy/knL+LQnQvVgTArm920O9K43N0MHJMfmuplfMO/8kmEYPlD3W+t
         rvYfk/jXNbfo6yaytwirVCI+SPebZlu3wz893wtll3GuP3vPN/+PVErmTogeRQzOZpGS
         D8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937175; x=1781541975;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cYeQh5he5QFDLKe/VfKWZrLhJFCMpCh7Exgo1nUTer4=;
        b=cSIICNskU7WUOlKTOV+F12DkZ7wcUTEsZcLjMd2dXr1RYnxA/hCuw+H0xlcguPmLUb
         v4PbTJQbzBYCKsIhjQE/uYiZ3gWpVZiHTRCh32JuE/wF9jtFVXyTNQvXHJYhBhQUenMa
         SRCBOMDkApbpxHaWDXg0kRfdzQYsA02mcEd2sjipuGhYBopni5Ahn9fH+o6Nqb90QP13
         wPNQepiYjRoNsr6OptNycVphwPUuFBlkRlR5lF78Zrn+SWjJukd/q9mRxufx08fFcEEQ
         tcS/kpCLmalQmHsM0rXWxcHQaL/nRNlSe57Nv2k0qifrhSaERrkvipXN55UXST4SUGAx
         lh7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zzNrRy2Yabt5oquOq87TkF9dKfwuk8OcEctPmk185ynd2p/6/zN7WmKu7nqmkMPESrdhymiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2um+TO5JIpWS2gDh751pT3FaWi39whRpIqaFwGVotvBV1jO64
	HXrD7GX9ioltX+6J7mSbvDwjIjXSqbrSwEejQ5QJQu1uA+IqNQMnET+GHLIkuOM0oVTiW6c7diF
	+q5SOzsPKjiPKEw==
X-Received: from qvbmh18.prod.google.com ([2002:a05:6214:5652:b0:8cc:c97:1de3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:560e:0:b0:8cc:f88e:2703 with SMTP id 6a1803df08f44-8cee5fe4e31mr7960956d6.12.1780937175224;
 Mon, 08 Jun 2026 09:46:15 -0700 (PDT)
Date: Mon,  8 Jun 2026 16:46:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260608164613.933023-1-edumazet@google.com>
Subject: [PATCH net] ip6_vti: fix incorrect tunnel matching in vti6_tnl_lookup()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296666-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:steffen.klassert@secunet.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com,secunet.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22F0B659632

In vti6_tnl_lookup(), when an exact match for a tunnel fails,
the code falls back to searching for wildcard tunnels:

- Tunnels matching the packet's local address, with any remote address
  wildcard remote).

- Tunnels matching the packet's remote address, with any local address
  (wildcard local).

However, vti6 stores all these different types of tunnels in the same
hash table (ip6n->tnls_r_l) prone to hash collisions.

The bug is that the fallback search loops in vti6_tnl_lookup() were
missing checks to ensure that the candidate tunnel actually has
a wildcard address.

Fixes: fbe68ee87522 ("vti6: Add a lookup method for tunnels with wildcard endpoints.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/ip6_vti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index df793c8bfffb0a26ea7f54933b88bccc9b1aa495..8b2c59c8eb27ea659615c8894d8f5e37e7298870 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -106,6 +106,7 @@ vti6_tnl_lookup(struct net *net, const struct in6_addr *remote,
 	hash = HASH(&any, local);
 	for_each_vti6_tunnel_rcu(ip6n->tnls_r_l[hash]) {
 		if (ipv6_addr_equal(local, &t->parms.laddr) &&
+		    ipv6_addr_any(&t->parms.raddr) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
@@ -113,6 +114,7 @@ vti6_tnl_lookup(struct net *net, const struct in6_addr *remote,
 	hash = HASH(remote, &any);
 	for_each_vti6_tunnel_rcu(ip6n->tnls_r_l[hash]) {
 		if (ipv6_addr_equal(remote, &t->parms.raddr) &&
+		    ipv6_addr_any(&t->parms.laddr) &&
 		    (t->dev->flags & IFF_UP))
 			return t;
 	}
-- 
2.54.0.1064.gd145956f57-goog


