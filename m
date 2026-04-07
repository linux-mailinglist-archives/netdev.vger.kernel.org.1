Return-Path: <netdev+bounces-276043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHbxB4Yk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:36:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB0F3B11ED
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAC0430DDEB3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9664A3BF665;
	Tue,  7 Apr 2026 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spUajTG5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6E398915
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575873; cv=none; b=iHf2mhppJaK78oIWxp6PoCB2Vy+92CIYztiyfIWXKB5MMN7ZG1+3CkIRGxwowfy3Ywq/PIqnqYaC+YK6b+tEV3MPQPQCb79rLK+D6fUY2V6DRyhTBP6l/442GpSQsxlz5OaJ4MYq7JUM5pC2UOq8ps+8+A/AtBhWgJjh2X1p/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575873; c=relaxed/simple;
	bh=nI7sFu9iwbbXqJoEmIx+zq9Cr7uAlji65NpgAZZfTMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EdznPY2yC2RtIIY9m+OxNf8zSW31cBTzdc9vBuSAUzNGaizk4YOCto2pS183cXhYBrSmUeuy1314EVNBmr63Uh5woOhQ27Oi2HskCQbOzWkpLW2nSN3d0FoPiOdNnncIte0TQWyOcx4uj0g3nM3ZEFBgYrGjaa9UhG78pa9bDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spUajTG5; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-415c8a4d2e6so2232493fac.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575866; x=1776180666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CH3vdPVGyUH3EZZlCGoXeiHTjcYkZTY9lZ88FtFslHM=;
        b=spUajTG5Mpojt+NMzf+/4YVUruhmlUqZY29zjrTTdSXNaa03Zjha9HsgAnwKuZ4SX7
         g+8s3vFxNymSjp0vDzZE8S342La84H01+hrR3xdPgh5hlvjs0vSh/m0/YGvo5bcf4W0D
         38FYEkogPdFanL/2YHQNtIobgDXtxsWp3gMr/BfN5d5bFEYmyHR7/Tf/uZv2WiBkkO5f
         9cOZh3dSJVUHyMZj8AxPQ5POUQ0MCTBdm4+LsMCERhxt5rlYosfWF63PlFryv5ZWuCFD
         o7ytpzI9U2JqMUTyl3Thfr+5xlSEhN81hFs71SST6PgDGp/HxkkkiOuMIdrX3WsvvFHJ
         jcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575866; x=1776180666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH3vdPVGyUH3EZZlCGoXeiHTjcYkZTY9lZ88FtFslHM=;
        b=K2Xwbqz/nJ9/hX6E0C7Ylqweo1MrnB4PH8vYV8rtYHE4x8IY6cIuBmPcyAADDvbXIz
         yJIiD/jGcJsrI5J71qdsCMwbjlhE/sUWp0vXvLvIr+DYjSMtR50b0NCot2OPY+lbK6z2
         8q25cEXLk+DJOXz0NxcSvWM7KZqkGgBkWlLGvGXk2RKIsb6y+SUQM7oNOQ6tWVjVGH04
         h6cZ16Ij+5dUrXKq6uPYDrZ/FZKVsRpHJstFwLR/28L0kRM9R1uPdsdh7TFSPuMVyl7Z
         Z1YGTfh04YV7c6xkNgo4u3IT8j98FlHRX3yMm8D+awi13xuaqoUUWfyIlpyQfQG3Y7ti
         A/PQ==
X-Gm-Message-State: AOJu0YyTXXB1n0ywEUnBG3IxAoOV2idAPklXWb4gH8raRfk8D+fWF8dy
	xdown3i2zzLkXl9KRn+GRz+C1Ba9ORNpHbNv9P6DAm7qcIol0DskOs9+xQM/8pVye5c=
X-Gm-Gg: AeBDievghHT3RwBR5UurF/r3ergAKQkx/1Xs+poIa+SI6nayy2uOBnfD9/TSE04cJy+
	oUsGsi+/ic+kEhSpHEBX9xT1RP2CU7aJIkDuRQOSD+hcYE4L8yfvJlDxykRm4gk7zE+Lnmi3sK4
	f55Hx6oJo/OmPlI81qI8x2M+sg/o14socj9tSXisXk7zw3paYlxYumSdqJZ2zULFjjzvrJ+oqJ5
	KXvifwRGbS1bNpFg+TJ+8hRc3EUA/sMffI3wlm9k70aPWJDEmruGhvnPovMDDIjGFkfpNxjDOMx
	Nf3AeDF07sjlLZhU62skRjALjhpqQ33P0cY07gCIMGBo+a12GBxk3vLzICo53zUooMhUSNOTFkM
	TNd+7Sye8NodfktJOSuDUWCvLLGOlIT9W2TT39ASNETn8YdBYz7uNmNjphDau5T5i/jqdVXZubs
	BrxNKPAFXrPrkTSdONYUngasW6l7IJ
X-Received: by 2002:a05:6870:7889:b0:423:44dd:351e with SMTP id 586e51a60fabf-42344dd3fe3mr6780472fac.35.1775575862712;
        Tue, 07 Apr 2026 08:31:02 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaed6647sm14738194fac.2.2026.04.07.08.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:02 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v6 00/14] net: sleepable ndo_set_rx_mode
Date: Tue,  7 Apr 2026 08:30:47 -0700
Message-ID: <20260407153101.3694714-1-sdf@fomichev.me>
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
	TAGGED_FROM(0.00)[bounces-276043-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[fomichev.me:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DB0F3B11ED
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

Stanislav Fomichev (14):
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
 tools/testing/selftests/net/config            |   3 +
 tools/testing/selftests/net/rtnetlink.sh      |  44 ++
 24 files changed, 975 insertions(+), 138 deletions(-)

-- 
2.52.0


