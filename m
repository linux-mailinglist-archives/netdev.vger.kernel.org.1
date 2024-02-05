Return-Path: <netdev+bounces-69118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C0849AFD
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FA61C220F0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616E71C6A3;
	Mon,  5 Feb 2024 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGM2sPmW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AC82C68E
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137282; cv=none; b=Uls9y7Y3Oo2ji8mMfsCLuMv6dDdcHV2hLSTZhz0N0HsJRxLB2rdovV0YbiRJgzfc6lwcE7rQhglDjEMNl5VlSTTsyOVIsklXI8/iCMh/SqED6Ahy5u54PPcluNywv4II2Usf5YnouSBKIRTvWR/C9KA3mv9NsbAJuVoD/ACpgF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137282; c=relaxed/simple;
	bh=yj0j2tlPLhE0FlCv9Ea1rNLcOW6Oyva8mow49n03F1o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M3x2orpTj7I9bnTXUZVGjPgLUX2QvVrDR5VFBWzOxwTUWT9X0j6X1rvtYe/p5XSrGpDjpq7ZhM2k7T3LhA/QY15VVxgQEf5KdVupeZnZGbTzITGNZ1Dvz6bD1vJ+k6o12W1kFD/CEQz/04Gr7nvRIyA0k2GR5QT11FdcKEDWQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGM2sPmW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6041bb56dbfso59681947b3.2
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137279; x=1707742079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P5Ke7KTgDt/x5VtlVt6zyXGu0e+siKTy0wa0DqbWsLU=;
        b=nGM2sPmWj7vmEUYepSsrC03JQvs6iK7HZ/iX8beGGMri0lRG1sOn4pD5JYXqo4u3dj
         doRJsEamQvYnjapl8O5GfPsoTVAzI5uwAsFhzJagxaNoH82f3EROOOy52gxc9nnyNPwo
         gMxU/za+UNrHrQpwkQptt8udo5ju2qGjJNcYImuSj3D2uE9iGhAH+uo425zcoc2asrnS
         kBSFC7ZA/2Vveb6ZBP5j37pVwn8tOaq6LmBCW21hChwF+J9FzinFr9DOyBv4h7Z9DLri
         DKdR4PgYUYUoTH7C/adNLbVHyvtNkFvCI+YWed69sFwMqcfgU6Z8gCogujgZ5FcSXBcV
         /ffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137279; x=1707742079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5Ke7KTgDt/x5VtlVt6zyXGu0e+siKTy0wa0DqbWsLU=;
        b=DJ4meA7gWQDMCXlkTzvcrWxw9js0cwr/GEx0gg8jOWTipWIDxTmoLPMXfams3hi7Yn
         grqDL0TJJ1przEEEFUTktkBs7dJQt3PUfR1LUPhrYI8UHK1L6lIal1wf7uDLalVCvylo
         59FuA7KUgOCtouweKmo2NWkHEvCHSKdJp1rku4hZoG8hZLXxtPMotZoajuL3ZH2gGWO2
         gWPduaH1dTRbGmJllMEnm5au2UAR9snGDLqTy6cRVdxTORNCWjkwayYryV/tJv6qDuoh
         EnOiaXADRgnrwMdl6jnJzPV5CpIYEsGiohw+OBQEwOpK1WvzgVnjxdflhZv2SoDGw5zX
         EziA==
X-Gm-Message-State: AOJu0YzQoC9kSlBD/FfMGdyzA/qlj8yXY0WjBo9FtI94ffDbcIpKHi87
	N6M77XkvcWIzEG+FBiTJ+D3+s391rhC8yQIKLNc4uvqyhNm3hWT83+IoBff20/NmX4fHLHkXc2Z
	6/rg2tszIhw==
X-Google-Smtp-Source: AGHT+IEkhibTZRnGs6wzgdr/yij1zIkNgiXmaod0VDM7kDaR6/ZuxBUsDAVoDm+dv7FMmwrTZtnGrx1LkR/o6Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ae0a:0:b0:dc6:dc0a:1ff0 with SMTP id
 a10-20020a25ae0a000000b00dc6dc0a1ff0mr397151ybj.12.1707137279743; Mon, 05 Feb
 2024 04:47:59 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-1-edumazet@google.com>
Subject: [PATCH v3 net-next 00/15]  net: more factorization in cleanup_net() paths
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

 drivers/net/bareudp.c           | 13 ++++-------
 drivers/net/bonding/bond_main.c | 37 ++++++++++++++++++++++----------
 drivers/net/geneve.c            | 13 ++++-------
 drivers/net/gtp.c               | 20 ++++++++---------
 drivers/net/vxlan/vxlan_core.c  | 21 ++++++++++--------
 include/net/ip_tunnels.h        |  3 ++-
 include/net/net_namespace.h     |  3 +++
 include/net/nexthop.h           |  1 +
 net/bridge/br.c                 | 15 +++++--------
 net/core/net_namespace.c        | 31 ++++++++++++++++++++++++++-
 net/ipv4/ip_gre.c               | 24 +++++++++++++--------
 net/ipv4/ip_tunnel.c            | 10 ++++-----
 net/ipv4/ip_vti.c               |  8 ++++---
 net/ipv4/ipip.c                 |  8 ++++---
 net/ipv4/nexthop.c              | 38 ++++++++++++++++++++++-----------
 net/ipv6/ip6_gre.c              | 12 +++++------
 net/ipv6/ip6_tunnel.c           | 12 +++++------
 net/ipv6/ip6_vti.c              | 12 +++++------
 net/ipv6/sit.c                  | 13 +++++------
 net/xfrm/xfrm_interface_core.c  | 14 ++++++------
 20 files changed, 177 insertions(+), 131 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


