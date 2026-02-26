Return-Path: <netdev+bounces-261123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGqUAtOxn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DE1A0239
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDEE3300A750
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BE37757E;
	Thu, 26 Feb 2026 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtgLophP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0B33A9EB
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073402; cv=none; b=K9LeipQzsJX0AFGVpfrp2fbw5GOgiVuzyk1KBE7CNNbnedeCtrZi2PmDBIjA/nw/urNTHIJjuvUP+rYcTpkjiDxIbIkKZBmnqW4skkGbNuLghXdIrDOUALL58amHAptLYpNx1LtX6srKDb6yuQC1/95EfJ08ljv6Ho/Andc8CUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073402; c=relaxed/simple;
	bh=F6JrlEUA/ex16vgomKUWvsE41UicPaiHRhZ0UNj0y14=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CLRHtZd58/jBaIdnKEGD3pgQjQ9B3VRf68/kcoIuh4Obsva9XdAj9BSctJsaRLmum0+fk7NZdEA+srzGddjdePWcKtXU+8HQEyrOZUg9qeY/Szu3eSQUc4N/npLHtnFbeMoJNXq9N9OFVEvQ9hmCOt/nMcWKiv44kdjyUE9zKW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtgLophP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358e79b4ca6so193928a91.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772073400; x=1772678200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9LWcr88rL6Xx3Q4WbGZrFQtWtigw101MW2rZpRS6HY=;
        b=mtgLophP4f2gQdz8jNEmILuYwh3kun5U2R7bffilf6Je4SJ+oZNppGJVjmBc9DXMdY
         xXG8BPMKyLjGjFTPxCN9NF6vYuYoNl9n0PlUbXqxz3kmkmCnYJTWDkJiqpyyBs6Lgw0e
         +XMUcKsOrXYbconsk5LbgbByHK8L2S7Oo/CEcXddLIjGN8NvR6YeGzQDU8ziuvN544Xy
         ORTps+xY65YI9Ae/ffROVNqDM7ykzISiVKUfqEoFb8j0o0XNzH7mKOJyn0jJ7haYtujv
         amOX1j+npHYY1DnGpsJjwYx+mofyZIi1+MXcEFXgO8y9E6Fpy4yofGu/FTI5i5unmqSQ
         2oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073400; x=1772678200;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9LWcr88rL6Xx3Q4WbGZrFQtWtigw101MW2rZpRS6HY=;
        b=fJGg7Q4JM0wBL3l95MYHCWo9/erSlOrztWLdRo6omAqUtfjtropepYTssG5mqfSBML
         BF723MK6TVMS/iBjBVF7bCHJ8zWw3OXOXw9QXBawIclJMfsbRIlgKXY19AIdrqIXeKjP
         mYSgw4sjxFgZ6iFPDyAdL5B161MhaxZVE38NwO0iAWA+9dxJ6jqf3/yrGVSQZzXSCND4
         L9GmNC9PUKsceE5s57rrXzxmYV61eDgbxT6lM8voNXV1Ze9eo1645lAfjgZvIi3c6twv
         DDF+zgwbnZvwbKOaargmflHNrtO+lU/dujLCMJrHm2CFmyxRx6/WQJSdAAAdzQfyoDZB
         ZXcw==
X-Forwarded-Encrypted: i=1; AJvYcCWWX87XiCHTCgBmyvQop6ZJ2y4Hit2Kx9JL4aUNU8wX30xRBmjRbVqDMGgkYp9IM6SHdq9ZOzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmfrTc+ItcajPD7/dsiFRqnfWy4C/LID5/nxyXWIyAAIJlp4d
	gh84w4K14vmGEFuqyvQf0XUcSgyIj10uzUJZHlZRyeX5+cy4qm2e/y0M0cno7NaOfmcy8zfnoq9
	oKD4E4Q==
X-Received: from pjblx14.prod.google.com ([2002:a17:90b:4b0e:b0:34a:c039:1428])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39cc:b0:33b:a906:e40
 with SMTP id 98e67ed59e1d1-35928a38a51mr2281058a91.2.1772073400348; Wed, 25
 Feb 2026 18:36:40 -0800 (PST)
Date: Thu, 26 Feb 2026 02:35:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226023637.1335854-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 00/15] ipmr: No RTNL for RTNL_FAMILY_IPMR rtnetlink.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261123-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 697DE1A0239
X-Rspamd-Action: no action

This series removes RTNL from ipmr rtnetlink handlers.

After this series, there are a few RTNL left in net/ipv4/ipmr.c
and such users will be converted to per-netns RTNL in another
series.

Patch 1 adds a selftest to exercise most? of the RTNL paths
 in net/ipv4/ipmr.c

Patch 2 - 6 converts RTM_GETLINK / RTM_GETROUTE handlers
 to RCU.

Patch 7 - 9 converts ->exit_batch() to ->exit_rtnl() to
 save one RTNL in cleanup_net().

Patch 10 - 11 removes unnecessary RTNL during setup_net()
 failure.

Patch 12 is a random cleanup.

Patch 13 - 15 drops RTNL for RTM_NEWROUTE and RTM_DELROUTE.


Kuniyuki Iwashima (15):
  selftest: net: Add basic functionality tests for ipmr.
  ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
  ipmr: Convert ipmr_rtm_dumplink() to RCU.
  ipmr: Use MAXVIFS in mroute_msgsize().
  ipmr: Convert ipmr_rtm_getroute() to RCU.
  ipmr: Convert ipmr_rtm_dumproute() to RCU.
  ipmr: Move unregister_netdevice_many() out of mroute_clean_tables().
  ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
  ipmr: Convert ipmr_net_exit_batch() to ->exit_rtnl().
  ipmr: Remove RTNL in ipmr_rules_init() and ipmr_net_init().
  ipmr: Call fib_rules_unregister() without RTNL.
  ipmr: Define net->ipv4.{ipmr_notifier_ops,ipmr_seq} under
    CONFIG_IP_MROUTE.
  ipmr/ip6mr: Convert net->ipv[46].ipmr_seq to atomic_t.
  ipmr: Add dedicated mutex for mrt->{mfc_hash,mfc_cache_list}.
  ipmr: Don't hold RTNL for ipmr_rtm_route().

 include/linux/mroute_base.h                   |   9 +-
 include/net/netns/ipv4.h                      |   6 +-
 include/net/netns/ipv6.h                      |   2 +-
 net/ipv4/ipmr.c                               | 257 ++++++----
 net/ipv4/ipmr_base.c                          |   4 +-
 net/ipv6/ip6mr.c                              |   4 +-
 .../testing/selftests/net/forwarding/Makefile |   4 +
 tools/testing/selftests/net/forwarding/ipmr.c | 455 ++++++++++++++++++
 8 files changed, 630 insertions(+), 111 deletions(-)
 create mode 100644 tools/testing/selftests/net/forwarding/ipmr.c

-- 
2.53.0.414.gf7e9f6c205-goog


