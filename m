Return-Path: <netdev+bounces-69506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA34B84B825
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4A51C20E92
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D6E111BD;
	Tue,  6 Feb 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJKsxSB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9902579
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230600; cv=none; b=JhhBBI2cfHmxqPoqDytvFso3vEotijwN8zJMcM5dnLll/cDvYw0b0hU8QWo4Fa+pnbj4MhCsD9VXY7/fuqoCAMq/FlVDbsXnt+VtxiUQucUHVsHbSM5/+d4e7DUfsmHjNj00UUykyaDYcLeGQna0+SMsxMTkE0KEU8QccGlE720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230600; c=relaxed/simple;
	bh=Dyet3jmLMPCZ8dvKY/ao0Wu360/kLhlQ4OAzVJH1lHM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LgKVwu1x0fLXl6KwIRyHuLDoSv6bA/pnRicaG0UlOCZpimgK41neTENPc0FJhj2QAMRtUv+5zmV4wq8UL5yBEQQjPq2egftQ3ta4raY47eDa6eTm1lRckID5gh+LEaoDlaoiLW3s2KZbEQJWT4r9MB0GjlWC/N1rlYXrPn1apDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJKsxSB5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6464399276.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230597; x=1707835397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lPqCGBhxULzCta/AhuXBGnK8Oqb1Aaso5fVFOZjcRRQ=;
        b=MJKsxSB5hD/1AMrLox/teIKfI/jw3Cf1s/7m84IiVufmW+rvVlUJ84TqqQySRwM8Je
         YwG4jRVJuPPoCgWGR8d/x/FqKQaHi51YO7bDDvJqvgaG+NL/RG7PzMCyvY/reO49VrDd
         HDHKFka1TsfjBmskpeaBXunDXpFyTQrafuPFey30sTHARS/oiS6B/Sfn+GTx1A0AADzZ
         8KSNdTfVLpgtCEhgK9d8z83W66CfVxJpbDwlklXxRdewfkrVZbByNhlkP+yD+xMkbRtj
         6NRXHrU45Nt8Gp5gT20/4YW/97QoAJ0ltEv5yhYnvEEp4GSlU2xQnnzCQkjlIEvr4WKr
         swIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230597; x=1707835397;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPqCGBhxULzCta/AhuXBGnK8Oqb1Aaso5fVFOZjcRRQ=;
        b=ruldnMCN3ycEZG+f9ERrp3BTLklSpi9+Bw/5NjClqAB4MVT7RwG/gmc8tOPxfs1VIO
         hpdM0FLD6zkHyVnut7flxnTkSTAl3IBySLSxtJ4jr8HAcGv9C+Edm62p5RMEkjUmxVi1
         uc8y7+4Bk4cTl8YvV0w8i6GGToNMuLTVboLvFkhdPvDULmVs7EgoWvdlVGlCv6RgiBC5
         QIg+0ADxj+SVeN8rHfp6zHCf+Sqvk3VzGxlKBctF1BODnIDbnbXFyUU5paA8LZ+QOaAT
         t2+kOAxqgCupWv24ZjDKp2JQhTvM7fDolKmlq6TO7qoRY5SFVG+EIf3GNH4FI3NP+9Af
         y1hg==
X-Gm-Message-State: AOJu0Ywbir+vwH+KGFD1ngBCMwUpsN27TupIfB6sXlfbBqhsX5P9Z1mW
	zvCAQDEauHz2bvehr0MIUSA06u5Ib0t3FU5SWbLUWMtjWZbwdFvU3Fh9vkFA6nZKmy6JWET6JTt
	BraR2ezJ3Og==
X-Google-Smtp-Source: AGHT+IGaavHI434tGdPaIn98vaJSEYFv+jydkuE5og0Sy8ovtKoZJfjNZxNXul2r6uFaXOFp9st0fo5oOKRrAg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:118f:b0:dc6:c623:ce6f with SMTP
 id m15-20020a056902118f00b00dc6c623ce6fmr47616ybu.13.1707230597484; Tue, 06
 Feb 2024 06:43:17 -0800 (PST)
Date: Tue,  6 Feb 2024 14:42:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-1-edumazet@google.com>
Subject: [PATCH v4 net-next 00/15] net: more factorization in cleanup_net() paths
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is inspired by recent syzbot reports hinting to RTNL and
workqueue abuses.

rtnl_lock() is unfair to (single threaded) cleanup_net(), because
many threads can cause contention on it.

This series adds a new (struct pernet_operations) method,
so that cleanup_net() can hold RTNL longer once it finally
acquires it.

It also factorizes unregister_netdevice_many(), to further
reduce stalls in cleanup_net().

v4: Changed geneve patch (Antoine Tenart feedback)
    Changed vxlan patch (Paolo Abeni feedback)
    Link: https://lore.kernel.org/netdev/CANn89iLJrrJs+6Vc==Un4rVKcpV0Eof4F_4w1_wQGxUCE2FWAg@mail.gmail.com/T/#u

v3: Dropped "net: convert default_device_exit_batch() to exit_batch_rtnl method"
    Jakub (and KASAN) reported issues with bridge, but the root cause was with this patch.
    default_device_exit_batch() is the catch-all method, it includes "lo" device dismantle.

v2: Antoine Tenart feedback in
      https://lore.kernel.org/netdev/170688415193.5216.10499830272732622816@kwain/
    - Added bond_net_pre_exit() method to make sure bond_destroy_sysfs()
      is called before we unregister the devices in bond_net_exit_batch_rtnl()


Eric Dumazet (15):
  net: add exit_batch_rtnl() method
  nexthop: convert nexthop_net_exit_batch to exit_batch_rtnl method
  bareudp: use exit_batch_rtnl() method
  bonding: use exit_batch_rtnl() method
  geneve: use exit_batch_rtnl() method
  gtp: use exit_batch_rtnl() method
  ipv4: add __unregister_nexthop_notifier()
  vxlan: use exit_batch_rtnl() method
  ip6_gre: use exit_batch_rtnl() method
  ip6_tunnel: use exit_batch_rtnl() method
  ip6_vti: use exit_batch_rtnl() method
  sit: use exit_batch_rtnl() method
  ip_tunnel: use exit_batch_rtnl() method
  bridge: use exit_batch_rtnl() method
  xfrm: interface: use exit_batch_rtnl() method

 drivers/net/bareudp.c           | 13 +++------
 drivers/net/bonding/bond_main.c | 37 ++++++++++++++++--------
 drivers/net/geneve.c            | 23 +++++++--------
 drivers/net/gtp.c               | 20 ++++++-------
 drivers/net/vxlan/vxlan_core.c  | 50 +++++++++++++--------------------
 include/net/ip_tunnels.h        |  3 +-
 include/net/net_namespace.h     |  3 ++
 include/net/nexthop.h           |  1 +
 net/bridge/br.c                 | 15 ++++------
 net/core/net_namespace.c        | 31 +++++++++++++++++++-
 net/ipv4/ip_gre.c               | 24 ++++++++++------
 net/ipv4/ip_tunnel.c            | 10 +++----
 net/ipv4/ip_vti.c               |  8 ++++--
 net/ipv4/ipip.c                 |  8 ++++--
 net/ipv4/nexthop.c              | 38 ++++++++++++++++---------
 net/ipv6/ip6_gre.c              | 12 ++++----
 net/ipv6/ip6_tunnel.c           | 12 ++++----
 net/ipv6/ip6_vti.c              | 12 ++++----
 net/ipv6/sit.c                  | 13 ++++-----
 net/xfrm/xfrm_interface_core.c  | 14 ++++-----
 20 files changed, 190 insertions(+), 157 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


