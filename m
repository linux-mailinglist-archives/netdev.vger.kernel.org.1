Return-Path: <netdev+bounces-70250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F384E2D3
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAB091F26715
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEB76908;
	Thu,  8 Feb 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKhXKCbu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9D77F33
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401519; cv=none; b=RumXbZUbpZY6b4nNQIyOKRjsrikHpSGWI1Odav8TwqkcDkpNplpwA0hV7vdkAYHPVkfz4ezUueRLQbRAiMDkdQHwm69G/7muKXyzr56Zz5h/akROyXrTPUXSyZZtLTItraGk473vZ4pnlgI+fg1hDwhafQMvVAPQ+LBHzien7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401519; c=relaxed/simple;
	bh=0IwbaLfjps2di16XOh2pihzHsh3SN87l5AXCKBVwFsA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cTe8flDmTmebreCTqwT9FxsZyS+E+7IyIbXzgimGC/sEQ2fFdmsgM/BYDfOAc7ckqI/8QCU3ISlJkW7t7sO+y1Zmr5ijL0NQKcwNiPHZXgOhfzJLpWeTt9wPtwTw9URsEWFelSsuj1egoMvJPwR1xeYTHT7kEwZ0CeSwzk8Ya18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nKhXKCbu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so117327276.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707401517; x=1708006317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gS/FWemkxQ4qk9kClEiLdskhnNHoXxGWi1tasYBCtfg=;
        b=nKhXKCbu7IvzDgqAYi7+DJZLO4dLevrAMndEtmGRgX5UluB2CAuQ/AypAopGNeYfNN
         keYM/LwC+b+pTjwN5h+5Y4sbd18Ac+J4w0X5MTdSGq3C65t3iBiwMYBDrOJh7kkhvqLW
         YiPM6UQ0oqEJzZLbMKOSp0lekN5TAzVRH0112OsR97K4dmEkctQ4ux6RsXzEq4mjIAz0
         QMYYCop6YeumzTzWMzPQWiTRL8KvecXHXwmGrSyrbzavpInuDKWOi0C2DScpflsmPOYf
         Cozgi6tb9dMpH1mGuSyDBugYKhu9mypb9pKmPigxPVy3kVNAJR9qqeH3Eos4BUdRhI3T
         GSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707401517; x=1708006317;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gS/FWemkxQ4qk9kClEiLdskhnNHoXxGWi1tasYBCtfg=;
        b=EI8ollCLid9NDa7UK4hbPZXOBiO1jMfpqaAMDM3C46lUSLXtDFtkJeTSDjaI/qU+m0
         TGmVhtpBdQ02Y4MwUWNFgGZixybAM+ddjN7fYpkL0ogvH8IAohoML5lvC8MLhmh3WnkT
         +R8IWbMZaY3HTXDK9Cb98KJmF6sxssubH2yi068MC58HvL9avZ921dUgyr/CP1UVrCxP
         Uq5oWOM7krJMzcZVt6lOg8by7PiSts988daY2XSAaWWp3y8tpBJqlTrrliW9il0OCIRm
         5Wl8uPQnhXyTvoAETxBNRVuHzS7eLRdjRSnBJHm/iSYDkz1WM9Vh9dQK29a+R/0W6uL1
         8FHQ==
X-Gm-Message-State: AOJu0Yy+VAf17XitVVoyGG83SXdJjPnPrrIASOq1MT4Fy0NxTMDEfG/x
	RpcwQpYQWvZdptVbDxbNirut/C7R8WG7Xc/J2QaLp7HK+eAXzdx+kF90Qk4+9F9O5rpU5jrhwjU
	UASssw77ZCw==
X-Google-Smtp-Source: AGHT+IFrmF9blJX0aWTr9OAxYdilWXGF3UkfbbHtjHOFwk3mNrijKnZf0OaGl7QCZl5lxACqpvLBNg/KwaKXvw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2787:b0:dc6:e647:3fae with SMTP
 id eb7-20020a056902278700b00dc6e6473faemr323077ybb.2.1707401517277; Thu, 08
 Feb 2024 06:11:57 -0800 (PST)
Date: Thu,  8 Feb 2024 14:11:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208141154.1131622-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/13] net: complete dev_base_lock removal
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

v2: dev->reg_state must be a standard enum, some arches
    do not support cmpxchg() on u8.

Eric Dumazet (13):
  net: annotate data-races around dev->name_assign_type
  ip_tunnel: annotate data-races around t->parms.link
  dev: annotate accesses to dev->link
  net: convert dev->reg_state to standard enum
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
 net/core/link_watch.c                       |  8 +--
 net/core/net-sysfs.c                        | 39 ++++++-----
 net/core/rtnetlink.c                        | 26 +++++---
 net/hsr/hsr_device.c                        | 28 +++-----
 net/ipv4/ip_tunnel.c                        | 27 ++++----
 net/ipv6/addrconf.c                         |  2 +-
 16 files changed, 108 insertions(+), 142 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


