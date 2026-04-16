Return-Path: <netdev+bounces-279115-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CrkMhEx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279115-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:57:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA883413E83
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 910683010737
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA9A330D29;
	Thu, 16 Apr 2026 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr82lqfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A62773EC
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365836; cv=none; b=YkXnKRMczQjHpCruCJr657bojSG9Gj+0E0yB1HWQCozsLxV941p1xuTv3IlRsi4bYopunMrHLuMujNkfy7yGDS7TkOfB+y9ZtvRR+KF6tBVbo5H+d2QtTkDNGEwNYcIlFEVoTNi5M569fOoANU/Q8kTO/mhKkCbHbkYPatcSsKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365836; c=relaxed/simple;
	bh=XoTHeSbYuWYIoaYtV6ti1uR5kYTkGmDUVyKSIRu7ciE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7fjbQL5jcyjILFPH27J3D3PtqmSHCKKmUazlwC8ILiy9diNiM9MiwOuhXl9AKePNb1GAa9ETi9lx44/kxRbPnw2KytB+zOMYq9ltx5Kx3GjrCTZ1cGr1tPmM+E7VikblwbbYcBJ9g18Bt+BFTNcyvFR7NUnQpjZmBk/RQdTBc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jr82lqfa; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so4228682a34.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365834; x=1776970634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RGQ3xyuG4WVU77b1nBnpqJ0oxnVlGQ5clCyu2pcQZ3I=;
        b=jr82lqfa8FiKemRVx6rXaQFVfJQHJ8e/K68NgnPxkqIDIBGTRak1f4jsUOvDOQ5Y3c
         JxfY0hRurC+XM4JBb3PGCTqo2szV5fv6GFZdOeoiTI2a9YI51LGc3Kx/TYFaRsr+INQs
         zhWuq4Xk19XYd680zy5Oersrk8l+wZWeyj3hIK8eCJ6WLwTlVL8IJ7YbZ6+nNdquofhq
         kYPXXevFraCDxdGPhEf92yuQ49rUt/qRL1ohi1EQMK2fAnnEOy7Nbn5dlWGphW2WN62I
         06gkbfUtk802NLY2lcUXHgC6C2r402jnHVfQZCa0A+4/I0MsRqmPLt2fQZvh62jTdeOp
         jIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365834; x=1776970634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGQ3xyuG4WVU77b1nBnpqJ0oxnVlGQ5clCyu2pcQZ3I=;
        b=lR7x2YGg6gHhB1feJwSH8NiFgM1wgh2/iZZDRJ4ahwxMCuvIy3tHV7XVAoZE3oISmn
         tLdGo2Gyt8LxvfrysTVXB5L0qGqqCiykKE9xqYOS1E3D0ApKgzP2A4rd1s2zj5Oj3mGZ
         ECj6puEdq3zT021oQWPBrdOygzQ2vU0YvYVn8v9eiOgNrs5saTonfG4bDD18eEAzWoEE
         vP99umrpUl0s4Y/BXeo9NzMgqnon3XlmeOOhzwzR7LyBPPBF16fW/M1EFIaZbhpsMNEL
         HkbJOJk+HGhf7yHDFmFCmiLbU/z/zsGkwp0Z7V5ePExccpv0JW0pvHHTpTyhaH7WO3Gy
         YYWg==
X-Gm-Message-State: AOJu0Ywt4kWyaBJQ0Pe7gawR6uKHCMRirJXat2TOCTctahVrYCg3awVC
	EO4D8CfkKRMii5iNgsfkwegRyO8KUgoL5ysr2tqcjeU1L+V87id4z0XyO80Bp7zA
X-Gm-Gg: AeBDievCfoPY2N/ECCNBop4c6fKrc81w+k5X4AT0D+FrfrOUATX9dbznczZLYe3dsYj
	2KAChEBhz3dyDztuyWLS+f09amwsiEhYTzWrCWo2KKFera8k8mhUYUz24n4EpHd3B/2NRbn8Qwo
	haW5Sm0y5M8tQPaE3FarEoJdsVou86nNZvgi6ogvamZKjvvsC5Hd9x7taEwsd/g4sZbbhiS8OgO
	eX2Fhn8OS9zPcDMZhGndXcuKzkQ6xZ1YpXot72ElcheAFtsnbgFyqRv+gNVpAVYfGO9dKf7Yv2G
	cA4GfnacYPIKi+tLVlLjizDQmxi6Y06j4Hkt2peeA1Md8vuWVhlR3HbgIChZfu8h7lvRh81fWfU
	sP0jeKFMfn309TZ0WVGJz0vr4kc9va0SrlQXt6Ldoh+SRRieO3CIW9QCVPl+obuJnnzP4o+fGZq
	5n6vGvdoXbT0P7m3qCcyOr7miLRCw=
X-Received: by 2002:a05:6830:6ada:b0:7d8:b269:e99b with SMTP id 46e09a7af769-7dc9269c620mr354715a34.17.1776365833705;
        Thu, 16 Apr 2026 11:57:13 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc90c11f6bsm486764a34.17.2026.04.16.11.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:13 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v8 00/15] net: sleepable ndo_set_rx_mode
Date: Thu, 16 Apr 2026 11:56:57 -0700
Message-ID: <20260416185712.2155425-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279115-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA883413E83
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

v8:
- fix netdev tracker release, similar approach to linkwatch (Jakub)

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
 net/core/dev_addr_lists.c                     | 385 ++++++++++++++++-
 net/core/dev_addr_lists_test.c                | 387 +++++++++++++++++-
 net/core/dev_api.c                            |   3 +
 net/core/dev_ioctl.c                          |   6 +-
 net/core/rtnetlink.c                          |   1 +
 .../selftests/drivers/net/bonding/lag_lib.sh  |  17 +-
 .../drivers/net/team/dev_addr_lists.sh        |   2 -
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 ++
 25 files changed, 992 insertions(+), 140 deletions(-)

-- 
2.52.0


