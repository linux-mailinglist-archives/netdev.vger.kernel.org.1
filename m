Return-Path: <netdev+bounces-217142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9030B37934
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D2668511C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 04:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7661F560B;
	Wed, 27 Aug 2025 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeDruA/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782E25557
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756269927; cv=none; b=WqppiyioPAWfhVcLzGlNI90UlQ/EyCHLdlOLvdnVq5RvxsUi5UluTvQtGzh914qJ6Prw+f9Y2bubCiIzoOn5C5RpCcik1LLOBYnohnHaVwut3OLFJVPWyk5XI4y9TF8npB+zoOcq0Lh6a8Z8KedNAAdQb+M5wH0k04TpA5ea+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756269927; c=relaxed/simple;
	bh=DVKE5txmBRxRC438YchfOWX93hU/m1WNzh3VxAHL19E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ANUVRcujJyY+VoGUjJ/QGq72L4Eu+tnxQ9dTwoILue8z9V1YuTg9hxoZnP7+e8O2m+uB13SOLsKQWquTywUwk2ktLtqRp+BADQvWmDkMfpsdXYk4jpiN3OutM5SYGobHLhAXnTZfKLgCpqlU2i6IV0xXCvANGEBmDM9XPy0ewQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeDruA/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FD2C4CEEB;
	Wed, 27 Aug 2025 04:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756269926;
	bh=DVKE5txmBRxRC438YchfOWX93hU/m1WNzh3VxAHL19E=;
	h=From:To:Cc:Subject:Date:From;
	b=WeDruA/KWQ+bsNx0ONbPArjUDXKjSOcUZCIjcXkTc7S16co/LPskgOrBrSGarNiOb
	 UtpHV1bNDT1QI7LrPs3GHV8JhCV9NutNV5fFktq8DF75RTM0FwWd155M1+jWNfsD1L
	 C2pdmHQ0UVJn8qfbbGGK6jNUSdSXH4uo310l1b6q77bDWO8L+4VXT03OGmsn77suF2
	 cAkrlZtGL8tmRyR9dbcuyvuJOsq975ZmZcC6iwpW3GC//+AeAbNReaxpu7ymbWlFMF
	 Ib9QAoQZRW0Va40HC4SUuHCdMChIbpkgkN0qvxYStDCom5GPJTsf9x/aQ3rWXZUBFU
	 8yNHDaMsq3RRA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	mbloch@nvidia.com
Subject: [PATCH net-next V2 0/7] E-Switch vport sharing & delegation
Date: Tue, 26 Aug 2025 21:45:09 -0700
Message-ID: <20250827044516.275267-1-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v1->v2:
 - rename goto labels after targets. Jakub.

An mlx5 E-Switch FDB table can manage vports belonging to other sibling
physical functions, such as ECPF (ARM embedded cores) and Host PF (x86).
This enables a single source of truth for SDN software to manage network
pipelines from one host. While such functionality already exists in mlx5,
it is currently limited by static vport allocation,
meaning the number of vports shared between multi-host functions
must be known pre-boot.

This patchset enables delegated/external vports to be discovered
dynamically when switchdev mode is enabled, leveraging new firmware
capabilities for dynamic vport creation.

Adjacent functions that delegate their SR-IOV VFs to sibling PFs, can be
dynamically discovered on the sibling PF's switchdev mode enabling,
after sriov was enabled on the originating PF, allowing for more
flexible and scalable management in multi-host and ECPF-to-host
scenarios.

The patchset consists of the following changes:

- Refactoring of ACL root namespace handling: The storage of vport ACL root
  namespaces is converted from a linear array to an xarray, allowing dynamic
  creation of ACLs per individual vport.
- Improvements for vhca_id to vport mapping.
- Dynamic querying and creation of delegated functions/vports.


Adithya Jayachandran (2):
  net/mlx5: E-Switch, Add support for adjacent functions vports
    discovery
  net/mlx5: E-switch, Set representor attributes for adjacent VFs

Saeed Mahameed (5):
  net/mlx5: FS, Convert vport acls root namespaces to xarray
  net/mlx5: E-Switch, Move vport acls root namespaces creation to
    eswitch
  net/mlx5: E-Switch, Create acls root namespace for adjacent vports
  net/mlx5: E-Switch, Register representors for adjacent vports
  net/mlx5: {DR,HWS}, Use the cached vhca_id for this device

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../mellanox/mlx5/core/esw/adj_vport.c        | 209 ++++++++++++++++++
 .../mellanox/mlx5/core/esw/devlink_port.c     |  11 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 131 ++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  17 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     |  37 +++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 183 ++++++++-------
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  18 +-
 .../mellanox/mlx5/core/steering/hws/cmd.c     |  34 +--
 .../mellanox/mlx5/core/steering/sws/dr_cmd.c  |  34 +--
 10 files changed, 500 insertions(+), 176 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c

-- 
2.50.1


