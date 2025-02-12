Return-Path: <netdev+bounces-165418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14EBA31F3D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552F0188C452
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1DF1FCF4F;
	Wed, 12 Feb 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Luud9pZm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341B1FC114
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342548; cv=none; b=OY12kGHupm1M0ujCO/IZ32SVoSl/1pBMiVVoR35+hy3oPQx7Jtb610K3ng2eRUhQrHXAYrjzydhOtgt2kS43/FfRijTsSrjA4KDwz2wWKudJfs791nNk7MSn+ZpuWc/zndHX6FdSldi9jH4Qgdb9ymcOJDfmYpbNlUamABWhgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342548; c=relaxed/simple;
	bh=fnNW6bOisEG233d9nvyp1AttvKM4+bJNAwN/n2MfVHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=szND0Xk+dXE8J5SLz/UFUgToNk2fgbx2LaXPYB74zUd8WFT8ScwLcEu9ealU4xoKBAVNHCtHO+KxjO5Gd1V9kM9WVdSH0BGWAxODGRIrlF4Xx8IOH+memoeOcEJJbT0XkXNWEXQxS6XkXbmoN6p94NSkvPj9+x7YiX2mPLRkhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Luud9pZm; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739342547; x=1770878547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jL3JrYPivToC4/XcN4RTV1bApa9ixZZXsbc1+iiv4Ok=;
  b=Luud9pZmjtYz84drn8sjJxhIRm7wa4lu2mEFnXwNsDsTDumDlXW67KGm
   ONwdunVFUZI00nJ7boUGnO2yTeUAMBrOuXj2zMU481vIGOYHAFEwE/EGv
   d3I/vskyAHVQt+Up6pohMCx0Ef2qQuh2/0xMnSU9rQT8QrcFJX6dmqYM9
   U=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="493191814"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:42:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:3159]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.65:2525] with esmtp (Farcaster)
 id d5848b8d-475f-4b30-bee9-2e6bfbe782d1; Wed, 12 Feb 2025 06:42:20 +0000 (UTC)
X-Farcaster-Flow-ID: d5848b8d-475f-4b30-bee9-2e6bfbe782d1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 06:42:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 06:42:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net 0/3] net: Fix race of rtnl_net_lock(dev_net(dev)).
Date: Wed, 12 Feb 2025 15:42:03 +0900
Message-ID: <20250212064206.18159-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Yael Chemla reported that commit 7fb1073300a2 ("net: Hold rtnl_net_lock()
in (un)?register_netdevice_notifier_dev_net().") started to trigger KASAN's
use-after-free splat.

The problem is that dev_net(dev) fetched before rtnl_net_lock() might be
different after rtnl_net_lock().

The patch 2 fixes the issue by checking dev_net(dev) after rtnl_net_lock(),
and the patch 3 fixes the same potential issue that would emerge once RTNL
is removed.


Changes:
  v4:
    * Add patch 1
    * Fix build failure for !CONFIG_NET_NS in patch 2

  v3:
    * Bump net->passive instead of maybe_get_net()
    * Remove msleep(1) loop
    * Use rcu_access_pointer() instead of rcu_read_lock().

  v2:
    * Use dev_net_rcu()
    * Use msleep(1) instead of cond_resched() after maybe_get_net()
    * Remove cond_resched() after net_eq() check

  v1: https://lore.kernel.org/netdev/20250130232435.43622-1-kuniyu@amazon.com/


Kuniyuki Iwashima (3):
  net: Add net_passive_inc() and net_passive_dec().
  net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
  dev: Use rtnl_net_dev_lock() in unregister_netdev().

 include/net/net_namespace.h | 11 ++++++++
 net/core/dev.c              | 51 +++++++++++++++++++++++++++++++------
 net/core/net_namespace.c    |  8 +++---
 3 files changed, 58 insertions(+), 12 deletions(-)

-- 
2.39.5 (Apple Git-154)


