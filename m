Return-Path: <netdev+bounces-71173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D568528F0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586621F213E4
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97113FED;
	Tue, 13 Feb 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0INXvfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5D11723
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805794; cv=none; b=aOhZIF70EQzpVKReqcsyTzIl4w8cSUHn+sNmEPY7zjA6KGt5VAaREYbguiUyRqPB9ou2rbIB7Pqm9ClRvTKB4TznQ/sFOYEPq4k5JnLvK/24Ufb1diR6cURMpGVFGQfCegsvQTJ9FYJcBZmUtGccplPsOMuIlPbA7/krUuRE/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805794; c=relaxed/simple;
	bh=OVYoedj6AxQarOE1TgkeGtegiltOTBuFylGxQhfY94A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V9zl4glgljkm3JUbRpMkiYQ6kNaMwR7hbVyz0HPWDEuK6bas15QT7O4IqeWBRuKmGehEQ5F+p87BWlMx/07fWfyViURs8trAepJ0orS+EOoupxdZIxnTdMqMfM1uT6CtmbWj83c7T7J7w+i/CrNDFPy1N8NIe61FVQEFA2I4/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0INXvfz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6077f931442so9941567b3.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707805792; x=1708410592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvMP7AV3mcUP0fTrcfhDw7tDbAZvyTP/9kBbocObyLI=;
        b=J0INXvfzmYAEcqrL+ahJbC8HMEV9sdCGtdOiTH4ekK7VtEbZm24hPw3ixSN8wodXAH
         7DSVPpY40kpkwx0rg2V5bmmVqXsZh0uUFnbdkLWFFQfoIJJVU+5qKhS9gnmL9zk2txgv
         vDgmD30tUQyM6HwuIQSKN/CDc5E98cvB6doNl9d66idyfxYbOHZXCtOYARcGpWEJRLi3
         cpRQ8P/Cy4AAUQejYx8BkYVsw3We/DBafBr9SkjkfXEJDzFY03+WPhdy+Wp5Lk2Ljpyz
         GjzJ3wqiGm3tN2iU3fa9w/cl00tZZiJ2soIHKX6yFU4xSbW2lyHyjxO8KkS7tD6wvDLa
         xIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805792; x=1708410592;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvMP7AV3mcUP0fTrcfhDw7tDbAZvyTP/9kBbocObyLI=;
        b=stdi+K1rvtu+HA3dGUhIt+MWitiuHgomHYP15ZqVSlCapQ4GvvTT6mHQwwWPzmK2nY
         ddcopWRG9bN98X/mYMCiref432G6FKRmT7/NjSuJ5Nderp2aRWXTE3lPbloFvOhaVkSy
         vQH5vpzUVFpa9V2N5gyDdPBHhlrseCQoU5Dp8exDQ21882ook/Dd9tolVXHB8jZs5zA3
         y2XIibI6bWMyUOikM1vYNnMuHl5W1tVy8rbV9alvVsDqUxSGs6FoqiWrkeA0N8vJG7BZ
         Lr4ltHipZio0265Tiu4PLIlRk+YGQKTgXPAREOLkzNhLaVSdl+dONtLLFjyAwdhgOL0O
         GV8w==
X-Gm-Message-State: AOJu0YyZsczccUSfr9rFaZvvAjOjBbTiWGYjx2ll1QUkX2ARnyPFGQP2
	DlQDhDual565rMQ1ff9SBLnbe+GKgOsC0FbuObIU7t/uxu09XodvlXNpodxUwTwO7u0iYMqVmYn
	fLl5wm7KTOw==
X-Google-Smtp-Source: AGHT+IGDkz+bqWXWAOorxY1BuPQ8LSnx+Yh/wuXKI+QffWKpxbc8TMKXSYGtnmSVQg5nzDXGujMXk2qQzhH/5g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:e84d:0:b0:607:7c03:c240 with SMTP id
 r74-20020a0de84d000000b006077c03c240mr559115ywe.8.1707805791910; Mon, 12 Feb
 2024 22:29:51 -0800 (PST)
Date: Tue, 13 Feb 2024 06:29:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213062950.3603891-1-edumazet@google.com>
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


