Return-Path: <netdev+bounces-29312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0D4782A31
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700E61C20856
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B31E746A;
	Mon, 21 Aug 2023 13:12:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4E7469
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:12:49 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE75E2;
	Mon, 21 Aug 2023 06:12:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D560206BB;
	Mon, 21 Aug 2023 13:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1692623560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ygFItYv4UPWMxUQ84MTzacJm6/mP4OKH60KlGPWpQvs=;
	b=iV4bUQwfe5rl5u4DX+tNGpQ3JeRu1BL8v+f/PHnKrle8lkdZflf0xu5gVQiJBWeXOjq1HK
	AXHfW3gwq3zHS0opudGclT6x//eWVEOVhDS6m2Gx9cTStsVqgfN+vVobUUk3Eg11bKpxJQ
	DjAEi6i70liSsxBNAgVhDG97KjaKxZA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B1AE13421;
	Mon, 21 Aug 2023 13:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6FbZAchi42QUVgAAMHmgww
	(envelope-from <petr.pavlu@suse.com>); Mon, 21 Aug 2023 13:12:40 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: tariqt@nvidia.com,
	yishaih@nvidia.com,
	leon@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jgg@ziepe.ca,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH net-next v3 00/11] Convert mlx4 to use auxiliary bus
Date: Mon, 21 Aug 2023 15:12:14 +0200
Message-Id: <20230821131225.11290-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series converts the mlx4 drivers to use auxiliary bus, similarly to
how mlx5 was converted [1]. The first 6 patches are preparatory changes,
the remaining 4 are the final conversion.

Initial motivation for this change was to address a problem related to
loading mlx4_en/mlx4_ib by mlx4_core using request_module_nowait(). When
doing such a load in initrd, the operation is asynchronous to any init
control and can get unexpectedly affected/interrupted by an eventual
root switch. Using an auxiliary bus leaves these module loads to udevd
which better integrates with systemd processing. [2]

General benefit is to get rid of custom interface logic and instead use
a common facility available for this task. An obvious risk is that some
new bug is introduced by the conversion.

Leon Romanovsky was kind enough to check for me that the series passes
their verification tests.

Changes since v2 [3]:
* Use 'void *' as the event param of mlx4_dispatch_event().

Changes since v1 [4]:
* Fix a missing definition of the err variable in mlx4_en_add().
* Remove not needed comments about the event type in mlx4_en_event()
  and mlx4_ib_event().

[1] https://lore.kernel.org/netdev/20201101201542.2027568-1-leon@kernel.org/
[2] https://lore.kernel.org/netdev/0a361ac2-c6bd-2b18-4841-b1b991f0635e@suse.com/
[3] https://lore.kernel.org/netdev/20230813145127.10653-1-petr.pavlu@suse.com/
[4] https://lore.kernel.org/netdev/20230804150527.6117-1-petr.pavlu@suse.com/

Petr Pavlu (11):
  mlx4: Get rid of the mlx4_interface.get_dev callback
  mlx4: Rename member mlx4_en_dev.nb to netdev_nb
  mlx4: Use 'void *' as the event param of mlx4_dispatch_event()
  mlx4: Replace the mlx4_interface.event callback with a notifier
  mlx4: Get rid of the mlx4_interface.activate callback
  mlx4: Move the bond work to the core driver
  mlx4: Avoid resetting MLX4_INTFF_BONDING per driver
  mlx4: Register mlx4 devices to an auxiliary virtual bus
  mlx4: Connect the ethernet part to the auxiliary bus
  mlx4: Connect the infiniband part to the auxiliary bus
  mlx4: Delete custom device management logic

 drivers/infiniband/hw/mlx4/main.c             | 218 ++++++-----
 drivers/infiniband/hw/mlx4/mlx4_ib.h          |   2 +
 drivers/net/ethernet/mellanox/mlx4/Kconfig    |   1 +
 drivers/net/ethernet/mellanox/mlx4/catas.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c      |   4 +-
 drivers/net/ethernet/mellanox/mlx4/en_main.c  | 155 +++++---
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  64 +--
 drivers/net/ethernet/mellanox/mlx4/eq.c       |  15 +-
 drivers/net/ethernet/mellanox/mlx4/intf.c     | 363 ++++++++++++------
 drivers/net/ethernet/mellanox/mlx4/main.c     | 110 ++++--
 drivers/net/ethernet/mellanox/mlx4/mlx4.h     |  18 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
 include/linux/mlx4/device.h                   |  20 +
 include/linux/mlx4/driver.h                   |  42 +-
 14 files changed, 606 insertions(+), 412 deletions(-)


base-commit: cb39c35783f26892bb1a72b1115c94fa2e77f4c5
-- 
2.35.3


