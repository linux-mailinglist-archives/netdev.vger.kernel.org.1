Return-Path: <netdev+bounces-69838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194084CCA8
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA668B21158
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571B7C095;
	Wed,  7 Feb 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGNkPh/J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D3917BBD
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315997; cv=none; b=J5mOP7dDUR6/Ao3ucWY4uEgNgof8yC/RvqCtWKB5+ZUvMEME2bEJvTkETYeUcdLdFo8oFKXhse6igNB0y90GPeCrF2GChCNVmxkLe2jKA0ozKVf30wRbBO0dO5devK/51GLx98MC1OIloUchP455PhIRBjjeF3JKOvhiL9QDYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315997; c=relaxed/simple;
	bh=u5ugZ/vBSdh0QiN1AcbM6ZTs8oQBRpTdIpu7RuOvtTA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=O+EXJ+BKd7vtz83UNQ4za8UiFc3h1yQ73i5CqmWYKIdtsKizuv4W2urnFarjrSJsWm5upC5MdD0x/AC6DtBOK8b5z6kGoLUrkA6KO8n8eZi7gOMz4nVPGtWVpZQFLcSGc1FR5R1hezqXIcocLCG7PxRqXhXESOlQBo/s4bJMrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGNkPh/J; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-78407a01a83so85791285a.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 06:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707315994; x=1707920794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L07MMglSqaXX5RLrtEqyDnYAl/cClo2FDopYm2lg434=;
        b=wGNkPh/JYT3n3tVnrNIXapizdiotSJ+ObT1CT+KoCQbtvXyujwJD+vLHLPdON8fU/G
         VeuJupRBRv3HdXoyJZUasfCbYFN9hm8W/5yXD9w2vnPUvLHKekZn6fZ0FyPnPsroaEcF
         pgqkKKYKFPBQNWshHGv98iRE16PvZgasSGDXzZvv9+9YFxD2gu39M/44tOS+OemFauAV
         lnhO3mlJqZLmUFEqgzzsgA1ZbMx+Cn+BMPLpFon01qo+2h08oJl7pFKV8Wv9sVC9AssJ
         UD05Nbrqag8/LAGaMHLbiPaa4yQE0rYE6f/G8cA1LvRQSSEXjobeNvJlUwXuggqk4H0B
         OMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315994; x=1707920794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L07MMglSqaXX5RLrtEqyDnYAl/cClo2FDopYm2lg434=;
        b=RGdfjabdsg/lq3RxxWmXTsvFPwQAFErkWsP47U4RWluSDi3HdGWlQRSYqBrkMlMjJZ
         NaeUua5jMkYMEwGHPu0XtDxSzsFLUASgMHmZmJP0Z0Fn1ChwERsdwe0NHSQ499ag7sso
         NNUi0fcwzM4JHmpcMIthyR8OUJpFmu73qFd7zl+VvZEB50hElmJ0k1fOqHy393ZsHGvp
         I849gMPuuJLx+pOtrD3kC6M0K4Ju/rvpG7JnFJzwR4kJraAZXiZkhj32lVdckukSnieq
         VzugwAPt15cxhlAhk+1lI8vT20kIMKpZ33qKKikyFWzzRv3sVM/XBiQ0+EtdgMnvzueR
         VE9g==
X-Gm-Message-State: AOJu0YyuQ8TlO/8YkREZFfXalOBrFMrbw+PZlSDuTLKYlbwx7uQEtdIJ
	+z530mE40LtjwpHeo7cXvGjQhKrUKtIMVadZc0Au7CPbd7ig69hx+rqjHI+zH+6ixTH+Wyv29E3
	7CEEw0yAbPA==
X-Google-Smtp-Source: AGHT+IHNseRyfYaAyf45eQEVDte5GYIVH/UF8d6/uV/JyrlmekJyHZEj3y4Z/x9Nm17L2ghEbyqwQ9AwiCvnVA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:4010:b0:785:8eb2:9308 with SMTP
 id h16-20020a05620a401000b007858eb29308mr17881qko.9.1707315994225; Wed, 07
 Feb 2024 06:26:34 -0800 (PST)
Date: Wed,  7 Feb 2024 14:26:16 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240207142629.3456570-1-edumazet@google.com>
Subject: [PATCH net-next 00/13] net: complete dev_base_lock removal
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
 include/linux/netdevice.h                   | 26 ++++----
 include/linux/rtnetlink.h                   |  2 +
 net/bridge/br_netlink.c                     |  3 +-
 net/core/dev.c                              | 71 +++++----------------
 net/core/link_watch.c                       |  8 +--
 net/core/net-sysfs.c                        | 39 ++++++-----
 net/core/rtnetlink.c                        | 26 +++++---
 net/hsr/hsr_device.c                        | 28 +++-----
 net/ipv4/ip_tunnel.c                        | 27 ++++----
 net/ipv6/addrconf.c                         |  2 +-
 16 files changed, 107 insertions(+), 141 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


