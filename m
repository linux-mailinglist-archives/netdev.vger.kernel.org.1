Return-Path: <netdev+bounces-215828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97274B308B9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 23:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54976A2221C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8D62E9EAC;
	Thu, 21 Aug 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNnZrjyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C5F393DDD
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813532; cv=none; b=lnRdJqjYtKAqXp+oRpSh6mLSumGf4uGhQDQlTOV7fXCBRXbNwy+Gv8V9fgHMZ/2pdfT3eF8bvMuIWAbGsYr8s3DrhzXpMCMYt2c/IwHREz2ldjjMXugLtxmPOy3/7O+5ffrSooXa2jIiGxEF86wkEi703aNvyMAgkuzqMc23mJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813532; c=relaxed/simple;
	bh=jgXPxJfFaSaBlgVXCqXFl9efZx6iDRQHCzEJKFwWYKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3kyaOYqjsmJjyRWDOXylyRELeBxAV4Z9ugtvbGQqMflctdj0lrRP1fZyUcm6WTHtDGWijM8x/0Y6ypjPWBfupDZpKX1bmW/iSotcgfNuhXa8LvF0ubLADrn9EQFZFXwFuuJvlbBoVj1ItT3S9+KY6/hAWLvCFI2C+RX796iusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNnZrjyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EA1C4CEEB;
	Thu, 21 Aug 2025 21:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755813532;
	bh=jgXPxJfFaSaBlgVXCqXFl9efZx6iDRQHCzEJKFwWYKc=;
	h=From:To:Cc:Subject:Date:From;
	b=NNnZrjyVPLy2Ibkge+1BkiPj3z8LtWcGptxOnpjecAkrN+TPd/Lx4/dph/Nw8hEaD
	 rx6yZlYwpgX9B6qMUM23XbmP+XQ2R7nbJ3Lw4B3PjF2YUcsCODkwwrwnrUbVhx2rzd
	 kXjXoNYlYsWKR15dChwbKLyyMHmCx8VB2iUKd+dAeaJc/5/kMufp9U/QKZoQzhDpYt
	 XfzuEipmLFWIXT/0Uy4rvP/yyRy0OwWIFBEy4stOBbVugihvLJky1S25ww8JfqmVec
	 2LuIHdie/FCvIOD4NXh54XVYC3TXMNWQuWsDx6SMtV95T/1yJlZJyPKP071011VppA
	 7dTRQntRW3q0g==
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
	Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: [PATCH net-next 0/7] E-Switch vport sharing & delegation
Date: Thu, 21 Aug 2025 14:58:32 -0700
Message-ID: <20250821215839.280364-1-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

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
 .../net/ethernet/mellanox/mlx5/core/fs_core.c | 185 ++++++++--------
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  18 +-
 .../mellanox/mlx5/core/steering/hws/cmd.c     |  34 +--
 .../mellanox/mlx5/core/steering/sws/dr_cmd.c  |  34 +--
 10 files changed, 501 insertions(+), 177 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/adj_vport.c

-- 
2.50.1


