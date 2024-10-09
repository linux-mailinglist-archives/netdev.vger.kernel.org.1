Return-Path: <netdev+bounces-133869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03831997510
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ED41C21455
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6861E0E08;
	Wed,  9 Oct 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNwkVOpb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56B1714A4
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499449; cv=none; b=l9ewYGfHwcHHCurPxI1wZfrNsQBQSpDme33XVW1EoxY+TU3I1xMY8CZEqWB4lLsy44FysnUp0twRHpYTDPSu5f2jfUBTICPQKtJqfzcBFK6u0c2Tv9zJapJY1i0Ef2I3clhf1BO0ca4eNrtIdw7TvIRS+joo/ze5dc+2ceuCOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499449; c=relaxed/simple;
	bh=U9XmZ41KAGpphDo1pvF8/0Dbujio6GqEc46ZlxALGus=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PJmSNSBxVZppzdYcqB9MF2l41tO3d0/y3LseJdTDLhn6FwdJQkAxHQZ74crQut1B+dwKRl7VvWJtVDPqi01IxRLriGJK0yvQnvPbBGaFkUA2C0hsEsI2EMVtCwsVHG8wIBp/wPT3OxVg1drarUfCo8Hh3dIKonuRrFsJnrjCpQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNwkVOpb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e315a5b199so5180857b3.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728499446; x=1729104246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=36SGObO+qrGKZfdPmRD/vTRCEknKF9n9s371VP2o5bI=;
        b=qNwkVOpbHgxKIw6lAsuOUVCIXJ2WYaSWW6gqoX1sJjStPXYDserZ7yI7xWbhp803UY
         6gIm1U3GKEsljOhKKMah+G/wx9ipp32cU06HSJDm2v+D379/45INRdofBnc5eOBtEOAT
         m+icZhFcH3uGvLJ6Q8YQNC9XA8I3DBsLc5EPR8sMZd8TSE59gXAisos+s1LEFxCKUG7X
         0SZbmOGtRhhVzKebyd/BpqYpmGpGnjMT43fYQUOLy5ROntyRpI/8LxfKRiqzJNKbI+Z4
         gwfiMu89EDaNXB0zpkI4SqqTW8EqSrReH/CEX/SJG12gRxcViwkQmFU97IZPhOEvOkvt
         jSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499446; x=1729104246;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36SGObO+qrGKZfdPmRD/vTRCEknKF9n9s371VP2o5bI=;
        b=f8DguKBUwaxO5G+DvP4preL8KPVxGnbP8qfB6RtVxZPmanPkhOW7lIxBlTxVJOaZfg
         l7SbvhI68rh4ibj8/5WyzbaZFWzB8KYYVilribA8iRvNKH3wB2PC7zC8GJuWRY3HQ/Hj
         dMc/h+oRtx00TJLTQcyM3d33OU8IRenRd3hWeusdWc53NMSDr1eHPoUtDPZoI0DmWaPG
         BwOM0bE+bvKcAnFCHSU8GWZJwShPdirky8wArdgY2noI+/0bbjrtmPFS6Gxi9zwp8RKh
         gTHAJUQHtNgdHVfZpEweDxG/fFODwhgfQL5m5g64m4As48j2LxCf4PL7atD76Z1p4//I
         IW5g==
X-Forwarded-Encrypted: i=1; AJvYcCXZ7ctRqwosyNVyw4kmq2dDSW9B13TF62A1Go0r1C1AJdf0t46GbT3bPx+5xEoO4LTfGP842v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfnfDCvV+b8QXJM+ohaJC2G6G5vu8PNmRvUorukgPhdOnfcPPi
	C6E6KxzX5IjHoBw3MoArxTB/q6PPAdJpx1mVxhVWFuIWns5l2XyRD2DZpFS1Tvr2GTpZF0tV03D
	SLx4Do0LlRg==
X-Google-Smtp-Source: AGHT+IHFBYRhgp7jawwKSsdrFooiTvTwPLdnXLnbhtJOmFnc3+PrhI3QRJdfKzfSwN4BLn3d5O2hsSaqvyAohQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:3406:b0:6b2:6cd4:7f9a with SMTP
 id 00721157ae682-6e3224f5266mr147377b3.8.1728499446395; Wed, 09 Oct 2024
 11:44:06 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:44:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009184405.3752829-1-edumazet@google.com>
Subject: [PATCH net-next 0/5] net: remove RTNL from fib_seq_sum()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is inspired by a syzbot report showing
rtnl contention and one thread blocked in:

7 locks held by syz-executor/10835:
  #0: ffff888033390420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline] 
  #0: ffff888033390420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
  #1: ffff88806df6bc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
  #2: ffff888026fcf3c8 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
  #3: ffffffff8f56f848 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
  #4: ffff88805e0140e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline] 
  #4: ffff88805e0140e8 (&dev->mutex){....}-{3:3}, at: __device_attach+0x8e/0x520 drivers/base/dd.c:1005
  #5: ffff88805c5fb250 (&devlink->lock_key#55){+.+.}-{3:3}, at: nsim_drv_probe+0xcb/0xb80 drivers/net/netdevsim/dev.c:1534
  #6: ffffffff8fcd1748 (rtnl_mutex){+.+.}-{3:3}, at: fib_seq_sum+0x31/0x290 net/core/fib_notifier.c:46

This is not a bug fix, unless I am mistaken, thus targeting net-next.


Eric Dumazet (5):
  fib: rules: use READ_ONCE()/WRITE_ONCE() on ops->fib_rules_seq
  ipv4: use READ_ONCE()/WRITE_ONCE() on net->ipv4.fib_seq
  ipv6: use READ_ONCE()/WRITE_ONCE() on fib6_table->fib_seq
  ipmr: use READ_ONCE() to read net->ipv[46].ipmr_seq
  net: do not acquire rtnl in fib_seq_sum()

 include/net/fib_notifier.h |  2 +-
 include/net/fib_rules.h    |  2 +-
 include/net/ip6_fib.h      |  8 ++++----
 include/net/ip_fib.h       |  4 ++--
 include/net/netns/ipv4.h   |  2 +-
 net/core/fib_notifier.c    |  2 --
 net/core/fib_rules.c       | 14 ++++++++------
 net/ipv4/fib_notifier.c    | 10 +++++-----
 net/ipv4/fib_rules.c       |  2 +-
 net/ipv4/ipmr.c            | 10 ++++------
 net/ipv6/fib6_notifier.c   |  2 +-
 net/ipv6/fib6_rules.c      |  2 +-
 net/ipv6/ip6_fib.c         | 14 +++++++-------
 net/ipv6/ip6mr.c           | 10 ++++------
 14 files changed, 40 insertions(+), 44 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


