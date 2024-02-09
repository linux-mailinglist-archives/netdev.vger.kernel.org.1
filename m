Return-Path: <netdev+bounces-70631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93E84FDA6
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009041F2563E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E453A7;
	Fri,  9 Feb 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQZvuad2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB9A23
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510897; cv=none; b=C5762a76J8CIrZEESYeGGrKKXs5kpd7n9HZLqXoMhcGCMkIjkcnPeX87sRPiQ8LBjv+Tq9l5NZNazZyTBf+H6H1BGWXwH01qtaxU+4lB1gFnlCg/18HbFvOTsJ6aFLjnDp27tqkiVn7Yve5qwtEyLBMaIgQestxo51fD+MLHRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510897; c=relaxed/simple;
	bh=FjdK2KUfIImxRXB7QHTEHVSz+EukvoDv2iQ7aEzvdOA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ohlbcM9eH83n/H62F9T7xL34eGz4lGZFwlfBZthVIlRmC3Hby1vld5TjLrieOfU+mLjCNMIzrNidfC6kxlEjE+S3tZrkSsk3CE9yDrQJW9x9bC5BmO4dQ78qKzuhb9Pi38jilNNOn3EFPDiKaKJOdmL4F5I1xP6whJ3NhHqicXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQZvuad2; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-680b2c9b0ccso20368266d6.1
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510895; x=1708115695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vLtxURuyfPsucgOWlgwG1VvMMBCuPW+2fQz0/+JlQLw=;
        b=fQZvuad2QjOpFXqkMIFz0qu80bzAn8eBLS6V84YrMX2Z2/sg58eZnaGRzdcsykGWXn
         n1loJAi4sp6ZiY8d3FxFea/yePTQUj8ax7wCo7D6MTVCab5OHedjcBFO8IvCU4lu3+BO
         jhe4H2AuNmI8tIs7+SCJLW20om3FDiZrIMIoJTwKIgA3yozTnX/OaybhP9uo0cCghrIz
         tHB/nhx5zNJMzIHnOK5rFAN3EGsux1RtyWTMM7qHk9m6KD/9SewovmLUr9CljvK/lqDf
         gNrZaX+Vv5iCGyr1P/LJ9b1HuYtYj2WxVHf4yvPw19mVjrYhfnFJgDhmgbccW8yPP+Ga
         K82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510895; x=1708115695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLtxURuyfPsucgOWlgwG1VvMMBCuPW+2fQz0/+JlQLw=;
        b=ANTRL+8hxKI0VUeDTLER06OqvYH0eBD9XHG2fwBhUqMXIWVe3teSk0Pu5ENjGUG0AX
         rSMQmm4VEK9GpVAaa0Xjxnn84cLCW6UHe6IhbxNkkInOvr4+M6ZArmye11760U5L0PxK
         F9fGJBM9OOsiR2oNtVO+8rwIdwtlQWXf2B9YRP8LImpMXqqaVJmWP+dEXJ+7Zz5M++Im
         p9kxneY85ticyUblJXGmJWdtb4UCm36f1EQjjfkc8CJMgURHZ9Mx66FfajjuR8Bmroqn
         Mu4KRw+v6Wvny4ZFtY1cp6NhaQCXPnWbQRnWxZoW7TXVzSRuK235dpxe13TQiD//tH6o
         NjcQ==
X-Gm-Message-State: AOJu0YyCSKkOxRC8rhX1wkmR2wgINSKvEXQ5MLtK2JeeBwFp8BzCH93u
	aOFwT7yo0zpVBcXRn/2MmApfEUmNaRm0pvUKXyHGvsRiB1pZ9uadbOd1TUDXhFe5SmFp0YX/nfy
	5LWPl4CXWHQ==
X-Google-Smtp-Source: AGHT+IEub8kVej+1VorIPqXw1zH/Hs823R6h8DSn1gcDm7rJNvsaYBx6s5hPr7KFuG6yQEc1PRYDbdVrECF+Wg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:194c:b0:68c:930d:d527 with SMTP
 id q12-20020a056214194c00b0068c930dd527mr557qvk.8.1707510895152; Fri, 09 Feb
 2024 12:34:55 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-1-edumazet@google.com>
Subject: [PATCH v3 net-next 00/13] net: complete dev_base_lock removal
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
 include/linux/netdevice.h                   | 28 ++++----
 include/linux/rtnetlink.h                   |  2 +
 net/bridge/br_netlink.c                     |  3 +-
 net/core/dev.c                              | 71 +++++----------------
 net/core/link_watch.c                       | 13 ++--
 net/core/net-sysfs.c                        | 39 ++++++-----
 net/core/rtnetlink.c                        | 26 +++++---
 net/hsr/hsr_device.c                        | 28 +++-----
 net/ipv4/ip_tunnel.c                        | 27 ++++----
 net/ipv6/addrconf.c                         |  2 +-
 16 files changed, 110 insertions(+), 145 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


