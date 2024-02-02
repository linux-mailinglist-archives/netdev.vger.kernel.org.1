Return-Path: <netdev+bounces-68613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85E6847655
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91BD1C2243B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656014C588;
	Fri,  2 Feb 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cmTXcUZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9913B14AD3A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895610; cv=none; b=Yzyzg2YcfqnbF28TJhPEyns1R/nDJBCd9Vq48OEDQCe6QIUr2Grm5P8Of6bE2yS9QkjtBTiYcvQgWZXtswBtSCZNyGPY8XHiDWWDaYNGHUiPnTKV5WQIxTcApt7pWRrzVIV0U0VBvseFUxl5vNKdg6TVfDg46dvi4l4QwDQRm1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895610; c=relaxed/simple;
	bh=Qo63+pfPE3EA6jDqpPsYWBFd1/u9CVzQzCxwuizSGtk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jr4Q/DAWCJu8R/UOUwPVqN1f9Oc3HkJDU2wpaq3024tblH6APiR823cN1LrTVXeQxDkaJ4GIDQbH9Sb9LcbURheRtH42fg3elYYzyIAhMQCnDJOc5vv8hKEJ09OxMT39jGBjB7L4jHd3z6AllKus/2OkY2UepVgQlN9v21GrmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cmTXcUZd; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-429841cf378so27467771cf.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895607; x=1707500407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wc4SP/fgW2t/NrlmW96cuIacW5bkRhZO+zf2CseBccc=;
        b=cmTXcUZd74dYiti0w+/SeodVSIEkZyoZi4jggOvzwzw+PITiXZtKHP2z/YsWBvsYj9
         HQwJlXEPet1Ipg50kyxGDaXXwxcBZxQicm8UorZn/DZkibm1LDUrxjWQkyN9uLaKwn90
         C+3DiBo9oKUR9gkrdAImbBz4khhsmx2AIjG1i3ryF77qYw06M1Wsrb7dfBP4+W4BsXBi
         2gpSG0GhJEybb/MBjziD6GbfUaXeR/BUtQTB4pKGrc78PpqotZirWLE8V+p6XgK15wmb
         vtYzaqXmvcqQvZFYUoaWaWOhhJJ0zdzbtrmReCuI0OCwVFSwXmg1XSsCIBTiAhB91LZq
         6GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895607; x=1707500407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wc4SP/fgW2t/NrlmW96cuIacW5bkRhZO+zf2CseBccc=;
        b=cKsaLdMYSJmlaGFl/r6ly4iowRsc6V1w3Ipy0pg8ktggGUO3n54io1N3HRPQou+oUQ
         IIaFkhk3JSuzL+CIrgzXY+jtOxUFq7H8F0VOokzpgIE2oj6GMRQd9e+k+SfemBxbHbhz
         QmBZiEjrMXbE4zC6Mi7VuIG4qZJuKUwpb6GKAEVpPvxvr8RTswnea5scRfOSsCjCTdi4
         QjikyWVrrpGxDfyjYfuMUo6ECQ20fzaTauBBcg1lJDAouMt6WfzO4PHG5TkIQQSwHz1/
         jOn6Cs2r3BkObUaiKcDBiuKNDuT9EXNK+HeDP9ntnDbq/ec7lIV77fafvdE7v8qlsR17
         4ymg==
X-Gm-Message-State: AOJu0YyORoptdEQwKKYkiBw4QbqoJ0T3n1beCvVHJuC3mJg154xDYtrA
	9ql2Wv3fhJNaL2CJonfkulZz7bPd9NI+OP2XAvj4ZcKlRjp1FZbt6/vvynpi3d2UPd7fc7lR5uV
	mTZTGiPRk7w==
X-Google-Smtp-Source: AGHT+IHk1JecrwKt3ut+7HAUPczJ2JFJwUzyWGe/w+uH0KXRk9l6PymrWWRXGOt+nqr0a6c3qmcfGFMrpMxWGw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:59c4:0:b0:42a:b64b:b328 with SMTP id
 f4-20020ac859c4000000b0042ab64bb328mr74396qtf.0.1706895607597; Fri, 02 Feb
 2024 09:40:07 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/16] net: more factorization in cleanup_net() paths
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

v2: Antoine Tenart feedback in
      https://lore.kernel.org/netdev/170688415193.5216.10499830272732622816@kwain/
    - Added bond_net_pre_exit() method to make sure bond_destroy_sysfs()
      is called before we unregister the devices in bond_net_exit_batch_rtnl()

Eric Dumazet (16):
  net: add exit_batch_rtnl() method
  nexthop: convert nexthop_net_exit_batch to exit_batch_rtnl method
  net: convert default_device_exit_batch() to exit_batch_rtnl method
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
 net/core/dev.c                  | 13 +++++------
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
 21 files changed, 182 insertions(+), 139 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


