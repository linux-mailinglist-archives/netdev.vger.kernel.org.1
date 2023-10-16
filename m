Return-Path: <netdev+bounces-41203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D7B7CA3D1
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFF3B20CEE
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356A71C285;
	Mon, 16 Oct 2023 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj5Vmh5D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4B1548F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C3EC433C7;
	Mon, 16 Oct 2023 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697447722;
	bh=nAEB00lWpXmD0sby7jz9CcDhj0KypBQSR4BqnMIm3rU=;
	h=From:To:Cc:Subject:Date:From;
	b=lj5Vmh5D3ZM83L/Gd2AGsr7JJPp5F++y3e/P7uTbwdgk8T8taLIPY5+9IsqLVND3j
	 2IznjNwmguSd5z3xkd828A+/SABqOSTopgZ2Yj3VT0ohXC0YGBrvF+oO6g6U1CJD2W
	 XEVR/TYjnG9zm3CJ11ZUzjHyg8YYACepu4nJD0V5LiOGTM1InEqt2BbFOp6KSFi1tO
	 hkrmyQ7BUb2+wQ9xonH0WoVUJTb6/PHfyOx5sDQ/4RvYRRqYB8ZZzUYia0k5KF29zh
	 2e+EHFdiDHHED0a/EnBbrIq8eKVIXx+EyYpjPxxtuGOSbn/28MDw/hI58TxJhZ044A
	 /LraByfuTIL7w==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH xfrm-next 0/9] mlx5 IPsec replay window enhancement and XFRM core statistics
Date: Mon, 16 Oct 2023 12:15:08 +0300
Message-ID: <cover.1697444728.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series does two things at the same time, but they are connected together:
 * Rewrite and fix mlx5 IPsec replay window implementation.
 * Connect XFRM statistics with offloaded counters to report replay window
   reason statistics.

First two patches are XFRM core changes to allow reuse of already existing
callback to fill all statistics.

Next two patches are fixes to replay window and sequence packet number
misconfiguration. They are not urgent and can go to -next.

Rest of the patches are rewrite of mlx5 replay window implementation.

As an example, the end result, after simulating replay window attack with 5 packets:
[leonro@c ~]$ grep XfrmInStateSeqError /proc/net/xfrm_stat
XfrmInStateSeqError     	5
[leonro@c ~]$ sudo ip -s x s
<...>
	stats:
	  replay-window 0 replay 5 failed 0

Thanks

Leon Romanovsky (7):
  xfrm: generalize xdo_dev_state_update_curlft to allow statistics
    update
  xfrm: get global statistics from the offloaded device
  net/mlx5e: Honor user choice of IPsec replay window size
  net/mlx5e: Ensure that IPsec sequence packet number starts from 1
  net/mlx5e: Remove exposure of IPsec RX flow steering struct
  net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
  net/mlx5e: Delete obsolete IPsec code

Patrisious Haddad (2):
  net/mlx5e: Unify esw and normal IPsec status table
    creation/destruction
  net/mlx5e: Add IPsec and ASO syndromes check in HW

 Documentation/networking/xfrm_device.rst      |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  57 ++-
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  23 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 410 +++++++++++++++---
 .../mlx5/core/en_accel/ipsec_offload.c        |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   1 -
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |   1 -
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 160 +------
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  15 -
 include/linux/mlx5/mlx5_ifc.h                 |   7 +
 include/linux/netdevice.h                     |   2 +-
 include/net/xfrm.h                            |  14 +-
 net/xfrm/xfrm_proc.c                          |   1 +
 net/xfrm/xfrm_state.c                         |  17 +-
 net/xfrm/xfrm_user.c                          |   2 +-
 16 files changed, 459 insertions(+), 282 deletions(-)

-- 
2.41.0


