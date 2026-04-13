Return-Path: <netdev+bounces-278138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MfVEUUl3WlcaQkAu9opvQ
	(envelope-from <netdev+bounces-278138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6753F1207
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DF273035A6F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6757233C536;
	Mon, 13 Apr 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4KYWxqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A6632570D
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100295; cv=none; b=nsbF8qw3n7/RoU6Cy96EhprDgUTMGM6YOaGkkxnU08BJO1wqytxVkzDEf2TEegPDmtOcHyDgRA2ofzvYITvIDoSCpryI2UxmJZixamyPx+dNwl3azl3jzb2Uc9NeeRKY18d8tXL4rjiGbvcrCk3yLkcLAui/iAVo+HuKlzlosYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100295; c=relaxed/simple;
	bh=QFfXQdYraBMgxF2YL51WifepTgi61lv5Bs3U70u2Geo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H/P27oiXGfKovM5OvvRsfJrf51rSNYDV5Q2caYmx8ohRAeZJILh8pm0To+liGPznxi6XN7o9mfxOhBD8BeI7c9dS6qfYUkTxchrouUNMtywm8qgQSdfHl8TqJRT7H7ntBpUw6T0inGaDN+3qxhKv9yzGVi+a+K7L2TmWEeHkaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4KYWxqK; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dbca22dbfeso2457300a34.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100293; x=1776705093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ArxValEzTg+tM9wLOLHIzVhZaHWsNTd1P3p2VjA1beo=;
        b=a4KYWxqKJbomHMc6s+SRO+pFAP+kyaC1KHlo+VsbZqnMGaYXxQrx6lImJ/xH2MNDdd
         yswA7Ptq4bUEjomIhZjwUARyrDD+MBbDzfs+sinxdKbICQPCed4G5jHcITaMlzmtwZ25
         j0Jg6RQAAvFSXL6MXmT+0DEYlrQ6p3WnJyz31LBvXR1PLY9GRqEXyfee8U+Zeg42o+Kg
         IhdkEz3gty4jdOHbG3TistIc4tgFx9Bfi7i+RHzcSI/puZO/JGIjDTG2VsearqjI9DHm
         LcisnaeBgl1Q7kCZB1Ju0v1ceN7aLA++ig3FghkoYBZFX+7+bOGVjeAN+dcgCzEIck0Q
         13KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100293; x=1776705093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArxValEzTg+tM9wLOLHIzVhZaHWsNTd1P3p2VjA1beo=;
        b=kBbwhxp9vPoYwSkexO7GVvSM6ELOJpOlN7zbK354Ybyi69NQ+n3YFzUXXbpm3KFaRc
         aPHHaMuesctQ/5gQZiq1BFYNyhA4lPrlxJUPl23Kd6qq9aI4vPfjcCJhzmD/M22AJyGy
         TBALSvcK/FAyVW4jT9xrb1kyQXaXHoPyZDmeDZu5rydLX4vkXbZjmFs1v9lDtlAmDDOR
         msyRdaqqCzaD8i4Yce7fqnT5nLDMdNys3vYzEtzmwjSoEhok46hu3LrQgcKFbhVOoZM6
         CN5KXHNNWXftksiZfmAm+4m5sGrOexhCvMYyoc/+N7zJxi81NbU2SzzEqX97Kon268IV
         fBAw==
X-Gm-Message-State: AOJu0Yy8mANNguclq4FxcJ7kSACMAi6ovc0I7EydhalAtLvQ7RmqS7ul
	JDDovhANPLz9joqc/UHN50MBa+avLwFsrvlJB0YH4RJUFPwvenCI/ZpnHvBdyjuK
X-Gm-Gg: AeBDieu+FmjxvjeU0/oeTOoF1IXWEkzx3VhvpHK8twA36WnQ+Ore+KH9CgF6XcGU4wX
	b3j2nLZtUZm1ks6p8dUVP6p+dM+e4MG8R0qi0PH/a+gzSdqDKq4z4iJzQA6+dYjwDqgeTU+7wlk
	+0QAK/3QOhOhfP1OrVD4YT7QHi4bqtX71H4cxsM1GPuMZ4RWp8VwseNCGQaYfEXi1v0mOFQ1Kdb
	+4nnGnolqm6mEoWc7JPDg9lFpP3THJEXkie2YpKFaU6D7N/Ze32m73ysM/P2kuURqFLjryJrtNh
	vaDnltVt7BMRg/xU/pmUEyjDJMmhCyoOOU1R8mQlHDjkszL8Wroc3rvyXaXOLRd/2hX4YVpjQER
	NMMvKJGfjGKeMd2npPhbWG7x2rAcyP6Hmd1yMBkqDwZfmVLGTTKBH/jiXGGwqkviSKHgs8Qucl7
	iIWWJl209e3XdI04Sm
X-Received: by 2002:a05:6820:f09:b0:68e:7e21:2245 with SMTP id 006d021491bc7-68e7e213a4cmr3587918eaf.19.1776100292679;
        Mon, 13 Apr 2026 10:11:32 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc7dfa196sm6284711eaf.2.2026.04.13.10.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:32 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v7 00/15] net: sleepable ndo_set_rx_mode
Date: Mon, 13 Apr 2026 10:11:16 -0700
Message-ID: <20260413171131.550126-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278138-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid]
X-Rspamd-Queue-Id: AF6753F1207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds a new ndo_set_rx_mode_async callback that enables
drivers to handle address list updates in a sleepable context. The
current ndo_set_rx_mode is called under the netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. This is
problematic for ops-locked drivers that need to sleep.

The approach:
1. Add snapshot/reconcile infrastructure for address lists
2. Introduce dev_rx_mode_work that takes snapshots under the lock,
   drops the lock, calls the driver, then reconciles changes back
3. Move promiscuity handling into the scheduled work as well
4. Convert existing ops-locked drivers to ndo_set_rx_mode_async
5. Add a warning for ops-locked drivers still using ndo_set_rx_mode
6. Add a selftest exercising the team+bridge+macvlan topology that
   triggers the addr_lock -> ops_lock ordering issue

v7:
- rebase and address netkit warning in a separate patch (Jakub)
- keep only CONFIG_NET_TEAM=y in selftest (Breno)

v6:
- relink ref_ha in __hw_addr_list_reconcile (AI Review)
- set real_ha->sync_cnt to delta, not 1 (AI Review)
- s/KUNIT_ASSERT_EQ/KUNIT_EXPECT_EQ/ (AI Review)
- drop netif_rx_mode_clean from free_netdev (AI Review)
- clarify deep hierarchy flush in commit message (AI Review)
- use dev trackers (AI Review)
- drop mc argument from bnxt_cfg_rx_mode (AI Review)
- keep uc_update, but as an argument in bnxt (AI Review)
- add BNXT_STATE_OPEN check after re-lock in bnxt (AI Review)
- add addr lock around iavf_set_rx_mode (AI Review)

v5:
- resolve 32 bit failure (Jakub)

v4:
- rebase on https://lore.kernel.org/netdev/20260319005456.82745-1-saeed@kernel.org/T/#u (Cosmin)
- reword ndo_set_rx_mode_async kdoc (Jakub)
- s/EXPORT_SYMBOL/EXPORT_SYMBOL_IF_KUNIT/ (Jakub)
- remove netif_up_and_present (Jakub)
- netif_addr_lists_snapshot + netif_addr_lists_reconcile to better
  explain mix-and-match between
  ndo_set_rx_mode/ndo_set_rx_mode_async/ndo_change_rx_flags (Jakub)
- s/cancel_work_sync/flush_work/ (Jakub)
- separate commit to cache snapshot entries (Jakub)
- add dev_addr_test_snapshot_benchmark (Jakub)
  - dev_addr_test_snapshot_benchmark: 1024 addrs x 1000 snapshots: 89872802 ns total, 89872 ns/iter
- remove redundant bnxt_uc_list_updated (Michael)
- switch to linkwatch-like work stealing (Jakub)

v3:
- module_export(__rtnl_unlock) (nipa)
- s/netdev_uc_count/netdev_hw_addr_list_count/ in bnxt (Aleksandr)

v2:
- wifi: cfg80211: use __rtnl_unlock in nl80211_pre_doit (syzbot)
- simplify mlx5e_sync_netdev_addr for !uc (Cosmin)
- switch to snapshot in bnxt_cfg_rx_mode (Michael)
- add team to net/config (Jakub)

Stanislav Fomichev (15):
  net: add address list snapshot and reconciliation infrastructure
  net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work
  net: cache snapshot entries for ndo_set_rx_mode_async
  net: move promiscuity handling into netdev_rx_mode_work
  fbnic: convert to ndo_set_rx_mode_async
  mlx5: convert to ndo_set_rx_mode_async
  bnxt: convert to ndo_set_rx_mode_async
  bnxt: use snapshot in bnxt_cfg_rx_mode
  iavf: convert to ndo_set_rx_mode_async
  netdevsim: convert to ndo_set_rx_mode_async
  dummy: convert to ndo_set_rx_mode_async
  netkit: convert to ndo_set_rx_mode_async
  net: warn ops-locked drivers still using ndo_set_rx_mode
  selftests: net: add team_bridge_macvlan rx_mode test
  selftests: net: use ip commands instead of teamd in team rx_mode test

 Documentation/networking/netdevices.rst       |  13 +
 drivers/net/dummy.c                           |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  58 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  16 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  32 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  13 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  20 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |   2 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 drivers/net/netkit.c                          |   6 +-
 include/linux/netdevice.h                     |  28 ++
 net/core/dev.c                                |  67 +--
 net/core/dev.h                                |   4 +
 net/core/dev_addr_lists.c                     | 370 ++++++++++++++++-
 net/core/dev_addr_lists_test.c                | 387 +++++++++++++++++-
 net/core/dev_api.c                            |   3 +
 net/core/dev_ioctl.c                          |   6 +-
 net/core/rtnetlink.c                          |   1 +
 .../selftests/drivers/net/bonding/lag_lib.sh  |  17 +-
 .../drivers/net/team/dev_addr_lists.sh        |   2 -
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 ++
 25 files changed, 977 insertions(+), 140 deletions(-)

-- 
2.52.0


