Return-Path: <netdev+bounces-295451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KcN4BHcAImreRQEAu9opvQ
	(envelope-from <netdev+bounces-295451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D37643D9D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:47:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=EsMFVQcW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295451-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295451-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B1D93022937
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25D129E117;
	Thu,  4 Jun 2026 22:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB24235C01
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613236; cv=none; b=KyXo6S7v4SKlz7WHm7nDRk3afe4/JCB0gdX+4odgZhBx2EFCTEy9OTYJgL16JXtmhswJFaPo7lBi5r292W2XBIf31vS2ACYH+iqupiLxrmHNnxo0lZu0hCgyuTA+8AKrSpvy7u4DtuChuXH+ek8AZPoztqx6QrypOilpK/CfU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613236; c=relaxed/simple;
	bh=nGHxuSLaj5PZagx+diw2C0PVZD+D6jDeG21FiEyfYUg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C55ZKKlJA54/rITOfKGrLcxBO6zA04SW9mdfd1dNmwPPNANCwk+FvdY2G20S/5cnCV+pinu9mLCNWN7YXdxd0gIIKndv8mCrm1pkGyhKYRkt1yYHPZjs7h2yvkdsGRiQTIDf0pWhcClEuLcCTghKarMw7b7ElcHJ3413SNIUYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsMFVQcW; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d6389bbf4so1134913a91.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613235; x=1781218035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJiWu+o71oPNLE5PyJyZFCP865ju6FGM/GBubt1te5Q=;
        b=EsMFVQcWPLHJv+jUDs97rsPPa0HUiuBtCB7LiVLF/oMgc84qlPy52cLwbMS57WGA9K
         CKu6aNG8aeTbXHOh+5Lt8VOxzTtUJuwAGEnmWo5Jhi6cGHS3ZZuxb9vEqIk8wDGYaVJd
         /Eou3r5LJ7jEI88lf+jpbtQwK2iyhCe/6RUG8uJib0uYI/mdjwHK3Lnz12ik61l3ecPA
         AW0wyHlUmRIlvctYpOrFJBMEh644SMaQB58VhwFUsV681fMfqE+isjlCEGnx2sZAy1Bq
         1/AzSvNl343RS5xgEF7jJfrrRcmlXUmzvVdLy8QxUssn4dI0N2FvY1UvVlUvnCBhi2+D
         vNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613235; x=1781218035;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJiWu+o71oPNLE5PyJyZFCP865ju6FGM/GBubt1te5Q=;
        b=rGy767IFSwT9n/SfyKhPAKpm5d/YQ7QtKzWCvCJqur1yxJwLkDz7JsW3dk02xG045K
         UK6gDZpf5yHGpzf0zRwDbgNxJwuPaVlSfP0pckWvxZkLANYbeGly1/zkIBf6Gad3RJmm
         KlLsqmVHSOBg/M9t2umQctXcQUrPVOKT/A77CXtKV3P/pbxUoFXofwzrrMlc2h2laDk0
         Itf4E+tTlOrsTMfZwZUWMwPhXdXa3GccyhwGR9hK5Tdkfzj/d7BFgdRP/eVABWDpojVc
         Zgk32k1cZGizjKKIUHiwIWOOE1eTPvgyD21NOpTz20xJQNBUWmHw/cfkl1FCap8fTQ/i
         /Vgw==
X-Forwarded-Encrypted: i=1; AFNElJ+mrT7smmpuqqTJHY5lmVlg0FB540EeiX33U/QQgWB3aMBcOa6sfvwYuaRXmOV0S9JNk7Wsaeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7vXViCBeHz2Da/9Mf3JrFfumtYAUq6eEi7JjuDUCaCr+6Nbm
	eLefiSy9lP7KveMKzG6oZIjMAeZ05SwHNgAK4m73pi7uE107WljQ5Rz6cNyvETBITp4PkjtE3Z3
	xl54IOg==
X-Received: from pjyf13.prod.google.com ([2002:a17:90a:ec8d:b0:369:3e28:9233])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d606:b0:36d:ee3b:fcae
 with SMTP id 98e67ed59e1d1-370ee447899mr824245a91.6.1780613234513; Thu, 04
 Jun 2026 15:47:14 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR rtnetlink.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295451-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78D37643D9D

This series is the IPv6 version of

  https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@google.com/

and removes RTNL from ip6mr rtnetlink handlers.

After this series, there are a few RTNL left in net/ipv6/ip6mr.c
and such users will be converted to per-netns RTNL in another
series.


Patch 1 extends the ipmr selftest to exercise most of the RTNL
 paths in net/ipv6/ipmr.c

Patch 2 - 6 converts RTM_GETROUTE handlers to RCU.

Patch 7 removes struct fib_dump_filter.rtnl_held.

Patch 8 use RCU for mr_table for CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=n
 for ->exit_rtnl().

Patch 9 move fib_rules_unregister() to ->exit()

Patch 10 - 12 converts ->exit_batch() to ->exit_rtnl() to
 save one RTNL in cleanup_net().

Patch 13 removes unnecessary RTNL during setup_net() failure.

Patch 14 drops RTNL for MRT6_(ADD|DEL)_MFC(_PROXY)?.

Patch 15 misc clean up


Changes:
  v3:
    Patch 1 : Use XFAIL_ADD()

  v2: https://lore.kernel.org/netdev/20260410211726.1668756-1-kuniyu@google.com/
    Add patch 8 & 9 for ->exit_rtnl() conversion and
     drop 2 trivial patches (patch 2 & 14 in v1)

  v1: https://lore.kernel.org/netdev/20260407212001.2368593-1-kuniyu@google.com/


Kuniyuki Iwashima (15):
  selftest: net: Extend ipmr.c for IP6MR.
  ip6mr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
  ip6mr: Use MAXMIFS in mr6_msgsize().
  ip6mr: Allocate skb earlier in ip6mr_rtm_getroute().
  ip6mr: Convert ip6mr_rtm_getroute() to RCU.
  ip6mr: Convert ip6mr_rtm_dumproute() to RCU.
  net: Remove rtnl_held of struct fib_dump_filter.
  ip6mr: Free mr_table after RCU grace period.
  ip6mr: Call fib_rules_unregister() without RTNL.
  ip6mr: Move unregister_netdevice_many() out of mroute_clean_tables().
  ip6mr: Move unregister_netdevice_many() out of ip6mr_free_table().
  ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
  ip6mr: Remove RTNL in ip6mr_rules_init() and ip6mr_net_init().
  ip6mr: Replace RTNL with a dedicated mutex for MFC.
  ip6mr: Define net->ipv6.{ip6mr_notifier_ops,ipmr_seq} under
    CONFIG_IPV6_MROUTE.

 include/net/ip_fib.h                          |   1 -
 include/net/netns/ipv6.h                      |   5 +-
 net/ipv4/fib_frontend.c                       |  19 +-
 net/ipv4/ipmr.c                               |   4 +-
 net/ipv6/ip6_fib.c                            |   1 -
 net/ipv6/ip6mr.c                              | 299 +++++++++++-------
 net/mpls/af_mpls.c                            |   6 +-
 tools/testing/selftests/net/forwarding/ipmr.c | 189 +++++++----
 8 files changed, 312 insertions(+), 212 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog


