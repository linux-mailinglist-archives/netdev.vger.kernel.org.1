Return-Path: <netdev+bounces-303725-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UShgLzI4RWot8woAu9opvQ
	(envelope-from <netdev+bounces-303725-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:54:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAA16EF674
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:54:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=FM0gB+gV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303725-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303725-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AAB63018779
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C593546EB;
	Wed,  1 Jul 2026 15:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8274423E320
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 15:51:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921098; cv=none; b=rZ4vD+vMsij+GdtMwSy4urOG1w0Cd6A/0rLy+/njGnbPlbZ6CPA4ua4Fu4oV6RHCu7Vq3WI7vLmnX9iwUzFShyA4drTUmqSCyWJ5hWPZkitlueRSyZVlDDEfQRWJ/hVHz92xkc0dYYMFJKo2NWlFkkQG2N3Qc0vvXdZNAAlbubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921098; c=relaxed/simple;
	bh=dGid6PXHO3hOR6QgwgOjlIXXUJe2yfg+/djlVaYVisI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P31jsM6ppDF4tTlYDTjqPDkDGsXhMWy1FfoyfFl9ICvwCUrAqyuWZo/+jiVQw9hSbh/bm7D07OfN23APKdv48ajXHMa7tsf2EENG4MiIKOdYmxSTsqUq5+ZMcjO4YNS1FaovWTgj24pt4oZsTdc704ukRSejzavD7RjXi2hMvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FM0gB+gV; arc=none smtp.client-ip=209.85.128.202
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-80ce4bbf86cso15409957b3.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782921096; x=1783525896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0g8zwxyZ4v+ToOgiFZnjfEuzRIaK7m2HYPcUswcg5Ik=;
        b=FM0gB+gVZnCGy49fNZ1sOhnUhhx2bh+K9q8/xBlLYyC+o1u+SgxtOw9ZyHpnFMR8Uy
         5x4+mIzWHzfkSL7kyoJTLusfTIR7oTDfENbi+MxYTqWtk2ZldSl424W2BSNjTPvuvoMo
         Vp8x0ZmEzNTh7Drq+/reG/YXyEAZG9GoRkLd+xl9Dvk+u3Tz6xAxhC9ytRX74ZsgHAqa
         qYLAku24dwltaVbRO/9BUek/AHjhbdxSnsDzPE2hkNJI7gJx7iUH8q0JKT2n6QaViHYf
         8dwOChy/Fzyv6PPFkCLoQ8njnlD8qaxcGfGwb70WGqlX8HsQumg9BUWnxRoS2NiMVj4K
         QhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921096; x=1783525896;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0g8zwxyZ4v+ToOgiFZnjfEuzRIaK7m2HYPcUswcg5Ik=;
        b=N7/QZeFQ1Wc4Rq+c70biXhnqGAa8nGFv4XLlF9VAlwoqgZhkN8rmQBuAJuoHjs3MCC
         /y99tLxUVE0hdXg9SotkD8+dQFf4F78z3G5TQjiKdWR6PssP0wik4wpRTl3oVRnlU1FM
         r2jUPsdAXN2m9by3Bb3dMLqA2WrOXC/gYudMWFbr4EbVFiEeLV1nkQ/b7VqmhQ+62Xk4
         wNhV+4ajAAB33H+L8KtP24RpmPNhA+T24Yn0pWsOS+hItbagwvOW0ZJnyK0kxKarA/ya
         71DBH0RFajCSrbDJ+GU2bE/shZL+ETxz1yrr+gWPOhKkDK1jbyvHpv1bjsgEOOjYkSNt
         na3Q==
X-Forwarded-Encrypted: i=1; AHgh+RpwoYxNxvZ0M7b6JPb8A2lHekF2nKeSCU7b+cyg+/z5NtlEERmkSK1sJr7b4fhbrBIf/Iuc22s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/E3vEzba2/6HHzO6HlBag56QH+SUPRBGKBVoYYCf00vum1VSA
	vceLuD+I8XkPwc7lBUYnQzKDqcl2d/Zp3p465qlElEkaLt99+GyAXahbXpMiJ6q0QztjQ5cwOeU
	MmHjP1uAD4uMXcg==
X-Received: from ywb9.prod.google.com ([2002:a05:690c:9509:b0:809:f6a9:17bb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6c8f:b0:7e8:6d46:a15e with SMTP id 00721157ae682-81383915817mr15678657b3.20.1782921096307;
 Wed, 01 Jul 2026 08:51:36 -0700 (PDT)
Date: Wed,  1 Jul 2026 15:51:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701155135.3962058-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] sit: prepare for RTNL-less link dumping
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303725-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFAA16EF674

This series prepares the SIT tunnel driver for RTNL-less link info dumping.

To do so, we need to ensure that configuration reads in ipip6_fill_info()
can run safely concurrently with configuration updates
(via netlink changelink or ioctls).

First patch fixes a long-standing bug in the shared
ip_tunnel_encap_setup() helper (used by SIT and other IPv4 tunnels),
which cleared the encapsulation configuration even if the setup failed,
and adds WRITE_ONCE() annotations to protect concurrent readers.

Second patch updates SIT's fill_info() to use READ_ONCE()
for lockless reads, and updates the write paths to use WRITE_ONCE().

Eric Dumazet (2):
  ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
  sit: no longer rely on RTNL in ipip6_fill_info()

 net/ipv4/ip_tunnel.c | 14 ++++-----
 net/ipv6/sit.c       | 70 +++++++++++++++++++++++++-------------------
 2 files changed, 46 insertions(+), 38 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


