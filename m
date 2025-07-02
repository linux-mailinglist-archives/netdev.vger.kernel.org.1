Return-Path: <netdev+bounces-203550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494B9AF65C0
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A605E7AFAAF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3249324679A;
	Wed,  2 Jul 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSK5qoTj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0332DE70A
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497338; cv=none; b=uVMjm9z1YrDbU+caQyGuBCfttZ2DWrHfjAzepZ18Ll5MTzPLO2wg6aUU+1GbmXlYKOgyPGc6Bnsy9yyRlmoQd4VhXNj8AApZw8E5vk3SK66cjy2iOw0lxldbb3ZaQlfhprqUpgiQTeU7cjlxKuOQKk5qf0w3UKfdxnUJQBdIIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497338; c=relaxed/simple;
	bh=sBRQvh6mWyNp1y7S/XR7TC3yawapzPXgUQSb7CNDOOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esmf7Av/l/fY69u9/XvD+YC/W9073XeXl4OK5U2oRtD6IAfAqYAaiEOJIiyp+xBoTXmzmB1CXJ70aJH85l6PZ+R3zr1JpOBtSQbIL7CH3+sp1chmXI1QqvV9w1uXm+qib1Wn+8VXR/XRJ0FaPfpNpMDeRiXLhHKpSo1m++sOqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSK5qoTj; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31e076f714so357901a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497335; x=1752102135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=63cqeJEriKEgnD/W853xJc59FtKGXLf+1TdEZGG0ZJI=;
        b=GSK5qoTjt6G1n1Yc/yv2sUJjaPF0xcISV3nBBpPuTdDM3bo7czzByiQNIl+mM7vKa7
         AoilCRiQJQ15s4785E6buZYBJIZGsY40g0MqpmjAI8Tg5gk8cy8EbMMynXFlRFHnyVTN
         xYC5AeZlm8yTj8QR88/PbA9nIloMMb58zZ1edFbfeHxPiM02hHTJCzS8RgXRmmML/p6b
         H2GG8DUIV5HXJtDm5ycGEw0ROJnxpwKug0niOhxKoMLyzG8rmyPoeIlDk+XUzz8BGAe6
         PwdjBuJrCxVG84KLkAq4n8PuU5o8l0TqJQ+UAV2oCpgPI9m4tXENutpGCwEZIUa/x8j/
         C+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497335; x=1752102135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63cqeJEriKEgnD/W853xJc59FtKGXLf+1TdEZGG0ZJI=;
        b=LI6rGjM8oIchf9ePV/E40dJeRwFgTEftgZsq1ScrweXVCdVqICztUvdlaHS5DaYD0t
         nbRKzk2uMGjJzIS1QAsXMutZBuYBKrxOVGUFMgT2SX9XdYCMZwt1llwOWZpciE3fKSY7
         KKXvGrMj49irU5tpmNcvkEDUGS4MS1HlEZvrsDM4eH8A3U5sXYbKyO67S6dh1CUTcss+
         oUQ4Kg+ra4taDwWUSWOPLaA8LOLAHMhn3B0mNvUxnN9kwrvFm7nk08nCNXYgRWxWWOuM
         wIwOMddRrAArTUihAPAj2B721GquD0wx69B/fVfpv4GwmaDySeCE1UDE61GNfR8TMheu
         oS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWafLyMt+IkRnUZ7Deif7EWnX7KKMOiV3LPT/NCaD/Kzj6UBq4RmEUcLPE25NA3MWHHSjfIE9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7M/kktK8Z7ex2befVM9hLHe6SFyzN99WNkMCsjjWv+lIl+sGY
	yNWwWr/r1pVA+GzTrTnPr+hHyyJOPVvEN5sJEpqJ/EaxueS4PiHEKA4=
X-Gm-Gg: ASbGnctfBGampvkZgZjuJS4pLKlhwcBvTd9SblmC/vSWO8Lte3KsEdiKyBe6Yek+TYx
	5Kra0QhSLZamF/zl7oJqVFcWxPVtLj/hK2+UmFwN24cGGC+y1dN4U+51eL3/LHoiQH76+LcFVco
	37J4s9Mc6KxvpuTN/gTS8V43GALDkRj1cCQnZgbJy9zCj0+PYIt9MXuoR25tN4QkZj4WgMKa6N2
	84x+d/9QMajj9StRMRxQhHBcmnq6heeJNApJdVoGSgb7uPCsKKuhXBermDHXB/h5T/XqOELjkXI
	zXS0UErdCm+HzLxF9VyUqRMEjFCoKPz+rJG8LFs=
X-Google-Smtp-Source: AGHT+IFbNRpi2urhL+MjVisqkHU5NOOaEBvVQTP/pH3/FXinvGUHlqR+2nNQ0oxhnKE67G3QfefX9g==
X-Received: by 2002:a17:90b:33c6:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-31a9f5001c3mr33003a91.6.1751497334798;
        Wed, 02 Jul 2025 16:02:14 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::a408])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc70a17sm727071a91.26.2025.07.02.16.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:02:14 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v3 net-next 00/15] ipv6: Drop RTNL from mcast.c and anycast.c
Date: Wed,  2 Jul 2025 16:01:17 -0700
Message-ID: <20250702230210.3115355-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
multicast code.

Currently, IPv6 multicast code is protected by lock_sock() and
inet6_dev->mc_lock, and RTNL is not actually needed.

In addition, anycast code is also in the same situation and does not
need RTNL at all.

This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finally
removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().


Changes:
  v3:
    * Add Eric's tag for Patch 2 ~ 15
    * Patch 1: Return the retval of ipv6_dev_mc_inc()
    * Patch 6, 9, 14: Use dst_dev() for rt->dst.dev
    * Patch 13: Use READ_ONCE() for net->ipv6.devconf_all->forwarding
      and idev->conf.forwarding

  v2: https://lore.kernel.org/netdev/20250624202616.526600-1-kuni1840@gmail.com/
    * Patch 2: Clarify which function doesn't need assertion
    * Patch 6, 9, 14: Call rt6_lookup() and dev_hold() under RCU

  v1: https://lore.kernel.org/netdev/20250616233417.1153427-1-kuni1840@gmail.com/


Kuniyuki Iwashima (15):
  ipv6: ndisc: Remove __in6_dev_get() in
    pndisc_{constructor,destructor}().
  ipv6: mcast: Replace locking comments with lockdep annotations.
  ipv6: mcast: Check inet6_dev->dead under idev->mc_lock in
    __ipv6_dev_mc_inc().
  ipv6: mcast: Remove mca_get().
  ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().
  ipv6: mcast: Don't hold RTNL for IPV6_ADD_MEMBERSHIP and
    MCAST_JOIN_GROUP.
  ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP and
    MCAST_LEAVE_GROUP.
  ipv6: mcast: Don't hold RTNL in ipv6_sock_mc_close().
  ipv6: mcast: Don't hold RTNL for MCAST_ socket options.
  ipv6: mcast: Remove unnecessary ASSERT_RTNL and comment.
  ipv6: anycast: Don't use rtnl_dereference().
  ipv6: anycast: Don't hold RTNL for IPV6_LEAVE_ANYCAST and
    IPV6_ADDRFORM.
  ipv6: anycast: Unify two error paths in ipv6_sock_ac_join().
  ipv6: anycast: Don't hold RTNL for IPV6_JOIN_ANYCAST.
  ipv6: Remove setsockopt_needs_rtnl().

 include/linux/netdevice.h |   4 +-
 net/core/dev.c            |  38 +++--
 net/ipv6/addrconf.c       |  12 +-
 net/ipv6/anycast.c        | 100 +++++++-----
 net/ipv6/ipv6_sockglue.c  |  28 +---
 net/ipv6/mcast.c          | 332 +++++++++++++++++++-------------------
 net/ipv6/ndisc.c          |  13 +-
 7 files changed, 260 insertions(+), 267 deletions(-)

-- 
2.49.0


