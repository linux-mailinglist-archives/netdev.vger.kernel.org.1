Return-Path: <netdev+bounces-71175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4599F8528FF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB841C23389
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58358BFC;
	Tue, 13 Feb 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNBv2B7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4BA947
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805972; cv=none; b=Bddq0fa2BXj+GuhET9T6TOq2Srz+pNz8oPaLJ8Sq4AT53Uw9t2qt0jggUGaJN/LGpgdSHs+CfTBimZQrXS5ni3okbmn4hLWJYTHBYiOcPTahPR4EYFek4yWcO1yeq+ivvGIhpjVWIlR5t970h90NobSRUJCehIGwwQ7h7dN1EnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805972; c=relaxed/simple;
	bh=OVYoedj6AxQarOE1TgkeGtegiltOTBuFylGxQhfY94A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MrRebteSguspjqUrTJvMT32pQlAUo1W+vzefOCV2ixZAPBMik6zABM9iWTRAdL/90FqBpBgyok6GlMTTC0Dph0lO0Vi3vMhioS7uwDdqHOrIPAOySDs1lIXKBIYUDWMETjOPgLt/YoeoLz3VH50K+zaK0vcvIGeBMZpE/om5Jw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNBv2B7S; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso983186276.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805970; x=1708410770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvMP7AV3mcUP0fTrcfhDw7tDbAZvyTP/9kBbocObyLI=;
        b=CNBv2B7S4+lylqd5Ixwhp0DmSX7e4NZjPtMIuIFOMsdHAD7qNzMhDPcUggb9K5Fcd9
         KYQGOKboENXqkS1g/P8r4cB6RneEoFedZom9VZRrPiWbE4yz2EDzdCNzL1mJaeIISVa/
         pM0o5jgKpHyetB0QOcQxAF/ZrzfFqsR7fmIWhsZpeBMHGCM+uy2D00h3WBjkgVhFp3k1
         IeJdrY71cJBaxhuz04jT+4hzNNOBafOgFMI8TIv7Y/7esLZdhEpi7SqVvKp5aBcC+FoE
         pEnItICs42eamstVC4bBXLFOAtLByAGm9xet8rYikBMzAAhGzxRCRGYm3V3pUnRCITc+
         WW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805970; x=1708410770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvMP7AV3mcUP0fTrcfhDw7tDbAZvyTP/9kBbocObyLI=;
        b=OaniHZgwgNbv1NJzIPUlxW1RrXEl+KVfbYLqXWSt2Ghaz9IWOVtymk4Mr2U6nQKSVC
         e0I/ZOOU0DuE7v3hgRDqc/MfKOfJtNdiAGR5FswxyUgTQ6LwBzOylM1iqztCx9Qcj0Iz
         uDS+3wO1XB3HEKcOBJWO9gR2sfgZ0LvDyYXau35eN/RD49Qbor6eaBxa4EP293LIUtp8
         ycbE9x73p2UgmTZNfQ1X5JioC24/AWfZ3+lvkYwgQXJ3uyfuV0DUWc4qRufx6BlOJoj1
         vS9wOgkOjjGwHtNXwMweS6XG1u3r9eF+YmPKvd8aiJf1JpfsjHaXnbZOJItZqec0Rg1d
         Y3gA==
X-Gm-Message-State: AOJu0Yxa3xwKsmoBMHKmlV0xlBDtcIxUB++Z5j0QDD233U8JYlUu4LJ7
	831kXftTJKshL/QVhKaml/Kej+dQXuKkfUPmj0xq8WfJmJqRRBcrRd5JxNG7UjkKDNSYsEBbwaL
	7B2vhhr3mAg==
X-Google-Smtp-Source: AGHT+IG74IjUEYZkAHU6ESbQ1q8Jc7VOw8L27b+l7bBaCiT5XZKmZz2bMf0Em5TwN7B7kHEJmZvGrMSsq5S7kA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:124a:b0:dbe:d0a9:2be8 with SMTP
 id t10-20020a056902124a00b00dbed0a92be8mr325733ybu.0.1707805970001; Mon, 12
 Feb 2024 22:32:50 -0800 (PST)
Date: Tue, 13 Feb 2024 06:32:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213063245.3605305-1-edumazet@google.com>
Subject: [PATCH v4 net-next 00/13] net: complete dev_base_lock removal
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Back in 2009 we started an effort to get rid of dev_base_lock
in favor of RCU.

It is time to finish this work.

Say goodbye to dev_base_lock !

v4: rebase, and move dev_addr_sem to net/core/dev.h in patch 06/13 (Jakub)

v3: I misread kbot reports, the issue was with dev->operstate (patch 10/13)
    So dev->reg_state is back to u8, and dev->operstate becomes an u32.
    Sorry for the noise.

v2: dev->reg_state must be a standard enum, some arches
    do not support cmpxchg() on u8.


Eric Dumazet (13):
  net: annotate data-races around dev->name_assign_type
  ip_tunnel: annotate data-races around t->parms.link
  dev: annotate accesses to dev->link
  net: convert dev->reg_state to u8
  net-sysfs: convert netdev_show() to RCU
  net-sysfs: use dev_addr_sem to remove races in address_show()
  net-sysfs: convert dev->operstate reads to lockless ones
  net-sysfs: convert netstat_show() to RCU
  net: remove stale mentions of dev_base_lock in comments
  net: add netdev_set_operstate() helper
  net: remove dev_base_lock from do_setlink()
  net: remove dev_base_lock from register_netdevice() and friends.
  net: remove dev_base_lock

 Documentation/networking/netdevices.rst     |  4 +-
 drivers/net/ethernet/cisco/enic/enic_main.c |  2 +-
 drivers/net/ethernet/nvidia/forcedeth.c     |  4 +-
 drivers/net/ethernet/sfc/efx_common.c       |  2 +-
 drivers/net/ethernet/sfc/falcon/efx.c       |  2 +-
 drivers/net/ethernet/sfc/siena/efx_common.c |  2 +-
 include/linux/netdevice.h                   | 27 ++++----
 include/linux/rtnetlink.h                   |  2 +
 net/bridge/br_netlink.c                     |  3 +-
 net/core/dev.c                              | 71 +++++----------------
 net/core/dev.h                              |  3 +
 net/core/link_watch.c                       | 13 ++--
 net/core/net-sysfs.c                        | 39 ++++++-----
 net/core/rtnetlink.c                        | 26 +++++---
 net/hsr/hsr_device.c                        | 28 +++-----
 net/ipv4/ip_tunnel.c                        | 27 ++++----
 net/ipv6/addrconf.c                         |  2 +-
 17 files changed, 112 insertions(+), 145 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


