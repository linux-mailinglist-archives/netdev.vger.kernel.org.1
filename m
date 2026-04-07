Return-Path: <netdev+bounces-276163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG70HOh11WlC6gcAu9opvQ
	(envelope-from <netdev+bounces-276163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:23:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B13B5002
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 23:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87C7F3004C7B
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 21:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC43750C4;
	Tue,  7 Apr 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KOTvSu2J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D88253F05
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596806; cv=none; b=HmvDucM6zTQgOQAWl9fs63ZpR1GOSq02pVJwlPeMVsMMBxV5j9jrxwap/XQLU2kSusX0ukPK5kDHys97R9Um1T+mhnoS16Akxas2vv0wMDHtNdyx1IfcH+VN9UwqzDT6Z5vp5GM53Em0CC3rmnaseTTN745F9eiOO2UqLv/jAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596806; c=relaxed/simple;
	bh=OV84db14e02xsWwKu3XDB2umeRHlpxXKWOb25CGuETs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=STJ9tZK+qglc6ydE9RUZbELEIsrp4Cou+oP+IFxKlukVNLE+RbzmF70eYk5cToUv5vr6jAwGJpiTJsl2tYf4+6Fy4lUT2FWsTKY8NVPnpZ00xnThidMe2H4DMLIU+qwPP6m7iG2aVVGIN8Hm/4kkwVBKMRGgQLSmqcjXwL3fI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KOTvSu2J; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c649dc145so3345087b3a.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775596804; x=1776201604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=13/e8QRKJhxkHlopxevZBlaQoBeQhrJbh0a8w86ccsM=;
        b=KOTvSu2JzHlxQ8aKatDpsLx+fIJ/+5dJwLXF68UnG4EiSQns4gu73xeJ8XClM9RsQE
         giRe703n1Q9naDvf/aWppknJPGOU+YfG6dPIWhAqRVBC1YF6T4ElCHzWL3ovSKrbOpQG
         ogXyHiCs1CITzeaWaavvo7DuuX64DpoTE6dpUrDkErku2SEvkKWdUB7Pr9JLRsUqmfAx
         EKuzSLew0mus3RQJx+GEMwt3egsiL6h3fk1oBk/3vGwKqOZ04V+xOMpa0GTbyag/N60n
         1H0hipJozxMlaL0kJzWZyW+pEtGcrANLlWM4fTS2td7yEAIXXWpcGN0RAjrr5Uxaufr+
         haLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775596804; x=1776201604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13/e8QRKJhxkHlopxevZBlaQoBeQhrJbh0a8w86ccsM=;
        b=VwpOQ7W8OBENB1SIg2Fr/Mm9g2RNcteDwBEmkV5zmic3uMBzC0HijqfzhlMvh9n2jd
         u1JbiunGhbsePW8yjKd5S6cduipGFkrxi9EeFM7BGob+qh5GdWsia7uR4wzyo3tRGBaY
         NkWY+8OkO3C9qf5goI5P0ud3gmg0bNmcckXiX+tXD2kjLeD0WNzrc+zzhVgq7oM5EJb6
         oFD22tQVjI21jYxuubMbj7FH/kZIfORyuweNGMLreQaPQMLxo3U32LUT3GDJWCjxZbyl
         7HUYCYlGezpWeEobWLx5JTdM+c9EouxoBH4XlY9LGakan8ijYbdBPpRuvBr6tZEKydht
         O2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuSqBv55uVZHLgJ3Kjjcp/q/kY+/O7zh3vYjUPq+kAYyRvA53fNmiG8yhedTZ2thSBL+bcsx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeX4637ZqACYuzNgf2/KtuGVKLKikFoLNntp/FhIQ3FTOjR7or
	5sYDNca6EGDcxxcDJLgWTI6SVuYpTlLjFM2Ew2/kEehrEDNU6HLQu4nlM16L3X4A1uQLJR2XfU8
	F4ogNdg==
X-Received: from pfbfb9.prod.google.com ([2002:a05:6a00:2d89:b0:829:7ce4:7fcc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14ca:b0:81f:3eda:9d69
 with SMTP id d2e1a72fcca58-82d0da99cfemr18011041b3a.22.1775596803804; Tue, 07
 Apr 2026 14:20:03 -0700 (PDT)
Date: Tue,  7 Apr 2026 21:19:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407212001.2368593-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR rtnetlink.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276163-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C62B13B5002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series is the IPv6 version of

  https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@google.com/

and removes RTNL from ip6mr rtnetlink handlers.

After this series, there are a few RTNL left in net/ipv6/ipmr.c
and such users will be converted to per-netns RTNL in another
series.

Patch 1 extends the ipmr selftest to exercise most of the RTNL
 paths in net/ipv6/ipmr.c

Patch 2 is misc cleanup.

Patch 3 - 7 converts RTM_GETROUTE handlers to RCU.

Patch 8 removes struct fib_dump_filter.rtnl_held.

Patch 9 - 11 converts ->exit_batch() to ->exit_rtnl() to
 save one RTNL in cleanup_net().

Patch 12 - 13 removes unnecessary RTNL during setup_net()
 failure.

Patch 14 is cleanup.

Patch 15 drops RTNL for MRT6_(ADD|DEL)_MFC(_PROXY)?.


Kuniyuki Iwashima (15):
  selftest: net: Extend ipmr.c for IP6MR.
  ipmr: Convert mr_table.cache_resolve_queue_len to u32.
  ip6mr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
  ip6mr: Use MAXMIFS in mr6_msgsize().
  ip6mr: Allocate skb earlier in ip6mr_rtm_getroute().
  ip6mr: Convert ip6mr_rtm_getroute() to RCU.
  ip6mr: Convert ip6mr_rtm_dumproute() to RCU.
  net: Remove rtnl_held of struct fib_dump_filter.
  ip6mr: Move unregister_netdevice_many() out of mroute_clean_tables().
  ip6mr: Move unregister_netdevice_many() out of ip6mr_free_table().
  ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
  ip6mr: Remove RTNL in ip6mr_rules_init() and ip6mr_net_init().
  ip6mr: Call fib_rules_unregister() without RTNL.
  ip6mr: Define net->ipv6.{ip6mr_notifier_ops,ipmr_seq} under
    CONFIG_IP_MROUTE.
  ip6mr: Replace RTNL with a dedicated mutex for MFC.

 include/linux/mroute_base.h                   |   2 +-
 include/net/ip_fib.h                          |   1 -
 include/net/netns/ipv6.h                      |   5 +-
 net/ipv4/fib_frontend.c                       |  19 +-
 net/ipv4/ipmr.c                               |  22 +-
 net/ipv6/ip6_fib.c                            |   1 -
 net/ipv6/ip6mr.c                              | 195 +++++++++++-------
 net/mpls/af_mpls.c                            |   6 +-
 tools/testing/selftests/net/forwarding/ipmr.c | 163 ++++++++++-----
 9 files changed, 252 insertions(+), 162 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


