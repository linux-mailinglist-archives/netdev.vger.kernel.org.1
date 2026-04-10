Return-Path: <netdev+bounces-277576-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ARwLfJo2Wn5pQgAu9opvQ
	(envelope-from <netdev+bounces-277576-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:17:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5963DCCE9
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 23:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 149383027312
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379D3AA4ED;
	Fri, 10 Apr 2026 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCe6eB8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A673A9DAD
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855853; cv=none; b=lEV54M274mzGzOfsAAaqrTWUBaxxsQuhhQ7Ki8UfGkTvvIQHlgLPjFEPBMrJe62EUlVAHlq25gT4RvE4sucbnyOtAmBJ7ZtniG93V6vzfs8uqJbn/eUS/1y6o1giJqBPGMYJnXBNbbA8HrFrgNLy1VEWEhaFZIOB8hVLd1vhbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855853; c=relaxed/simple;
	bh=aeWmmosZ1USWPw1WSVhdxFbSHPny7TepTpkOYChqp3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dDMqW3n1QBN9tJx+cMcrknnM6PFSCZScct5l6cdQu3VV5LSoEpr2+E2TH7LeAgwsco8eAwdQPeCAQeT26XCf2AfAptUR3bNRgmfIdvlw4okD0bsZHGyb+VqPdVGOf4ASJbMUyZvsLgwqWg8QW5HIWdXAM7+UpregSnfWuFsAovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCe6eB8b; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cf8dcd079so1546234b3a.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775855852; x=1776460652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqU5vPpFaFLP4eWm/lD5s8nrZKqwMvu8+yGo4wihask=;
        b=KCe6eB8bwvzLxbaeVDNxarVj957G5jbPMgBfmzs7Aa8asSpRNtXLgUsPmW0alpatgi
         USu1Ysx0kCV1pv5x1g7x/lCD1+gNTCeo/MuAG0AcOThXXIiB1zLg82xN8HUB6BZAuFb1
         bkfLnBu8LWk41NeiGUQrKUnLY63Mx3Lp/+rAoONRDrgT3nwzXs3xdc9k2HBuXae7gms0
         ExiN3qaJNaM9NeECvUlUViKRExhaYDcqBt1phkSYK+1LBJJ29iEIQeRviGmFzJ0FEqaP
         dXhByDUWA59dwFbyPOGSL8S86+mcA02/Fl4yxs90sl0l4SHJhV8xA38dZGUEchcx8Bp8
         tRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855852; x=1776460652;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GqU5vPpFaFLP4eWm/lD5s8nrZKqwMvu8+yGo4wihask=;
        b=Jam5Q5gRw3jLw6I5g2CIH+xlaEBeJGnBDnNBHzMPv1H/HzycbhZ/f1NebzRzM8HGec
         Tltyxit4aLoGpU5evv/eVZXxy3agpfp8LjZnGJWFORZoqVDbrNYS0EYQeLEIxzwfVMJ4
         Wj8VhcLmOaiVKY1ENBBk4B2IbUz9xsnKqt9m+1++GAvTjR+w69Y0kYSzqxEFffhmqpTK
         PKaiJgNXZ7qPbqZEumFZmHkBkUET1bT0YBc5dwnvskGqzmF/QAkonKzv9ARgtaq65WE8
         tRX8M9sZpBAcmFu6C1F5BFhJZFwjBM0bcJaJF+uRyw4EY3+Rwb7JOnoSgMZDFVnl+tCo
         rBYw==
X-Forwarded-Encrypted: i=1; AJvYcCVUCxIUOodE7rjs/5ol+NeBXcOffU4ZaovLIeHOs24POqTsqsSIlP0lMu+6wZemul2Bl1fOXGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ECmN44cfEa68j8ZWqb8GKFm8bBIFa91zpYE+czK5lI7MwFI2
	HqVfXj3+SNk11nFGm78hT/zdWzyP44Ab/6yIXSemhLfQ/7OM1MxZT6jmDMrezx80xyEW4sHECwi
	ewbn2Rw==
X-Received: from pfar2.prod.google.com ([2002:a05:6a00:a902:b0:81f:7391:1ea6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4196:b0:82a:fc5:fb84
 with SMTP id d2e1a72fcca58-82f0c221ad9mr5713539b3a.27.1775855851474; Fri, 10
 Apr 2026 14:17:31 -0700 (PDT)
Date: Fri, 10 Apr 2026 21:16:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410211726.1668756-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR rtnetlink.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277576-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A5963DCCE9
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

Patch 2 - 6 converts RTM_GETROUTE handlers to RCU.

Patch 7 removes struct fib_dump_filter.rtnl_held.

Patch 8 - 9 use RCU for mr_table for CONFIG_IP_MROUTE_MULTIPLE_TABLES=n
 and CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=n for ->exit_rtnl().

Patch 10 - 12 converts ->exit_batch() to ->exit_rtnl() to
 save one RTNL in cleanup_net().

Patch 13 - 14 removes unnecessary RTNL during setup_net()
 failure.

Patch 15 drops RTNL for MRT6_(ADD|DEL)_MFC(_PROXY)?.


Changes:
  v2:
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
  ipmr: Free mr_table after RCU grace period.
  ip6mr: Free mr_table after RCU grace period.
  ip6mr: Move unregister_netdevice_many() out of mroute_clean_tables().
  ip6mr: Move unregister_netdevice_many() out of ip6mr_free_table().
  ip6mr: Convert ip6mr_net_exit_batch() to ->exit_rtnl().
  ip6mr: Remove RTNL in ip6mr_rules_init() and ip6mr_net_init().
  ip6mr: Call fib_rules_unregister() without RTNL.
  ip6mr: Replace RTNL with a dedicated mutex for MFC.

 include/linux/mroute_base.h                   |   2 +
 include/net/ip_fib.h                          |   1 -
 include/net/netns/ipv6.h                      |   1 +
 net/ipv4/fib_frontend.c                       |  19 +-
 net/ipv4/ipmr.c                               |  55 +++--
 net/ipv6/ip6_fib.c                            |   1 -
 net/ipv6/ip6mr.c                              | 233 +++++++++++-------
 net/mpls/af_mpls.c                            |   6 +-
 tools/testing/selftests/net/forwarding/ipmr.c | 163 ++++++++----
 9 files changed, 289 insertions(+), 192 deletions(-)

-- 
2.53.0.1213.gd9a14994de-goog


