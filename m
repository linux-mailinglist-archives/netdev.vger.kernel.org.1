Return-Path: <netdev+bounces-218403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A935B3C50A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F5EA65A09
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3282D29DF;
	Fri, 29 Aug 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX0BfFNB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56222D29C8
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507053; cv=none; b=Qtf0eMhUavtRyVbUUFyjzFplwvIJfrRG0u9umoD2jFWP1k9P6przcce2O8XLix0TkaNck2wdAbT2JfhiLWxk8OgVKQj7z+nwdrclJWcdRhCRP8lol/tnDzIu+nJuc1RKRY9AcFea8dXAgK/ThGBB/3Yqx4s+8WZz0LIsPanNqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507053; c=relaxed/simple;
	bh=+D/Q2a75Ub0H8yHxbIqJE3rZhOdCJarRlOv82/PI3uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnQuo3PBiVNrNVb+7LbXpwIoy8gQ2gdIvv7mDMiXdDW77GvdF8dMHyaenFoe0S0SPfa2iVtIEFdzhP3os0uawT9FXuVRFOvGAWRGYvyRVi/R5hg57q4AA0r48jGtOxWR7DB3wk9bGRKSiDtrIGE8BQa8RsmC5ldlVmcrlsvqfNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX0BfFNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221E9C4CEF0;
	Fri, 29 Aug 2025 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756507053;
	bh=+D/Q2a75Ub0H8yHxbIqJE3rZhOdCJarRlOv82/PI3uw=;
	h=From:To:Cc:Subject:Date:From;
	b=AX0BfFNBMLuHu3AMtx3SccQdcEGJXCV0cCE29KqOiB3dFyIE0PjdhpHxU/lB1C3aa
	 QKh8HR/BY/r9sFzjPhmiN4RDlp1VoX1CMx5koaYW5frvk4L5f6NkzEYzyRw2eQXSsl
	 yVRFUnNhpT2lZjLYb4ABts3wum4VhRRB9CanhrFM7w8R4ICiGg+chJnSQkwRigwro4
	 NgSTdMboY0vnDFYj1H3L523FdwOORLk/OYcRwSZyJqd4I5yYjCB1qO3bDQczyIfRXj
	 CLS/CHdTgITuThboN3kwLjNN61t716PLWtdOCaxITNjaiwAj+eQTN2alEK6Wf6Jeb8
	 Lz/JbfH2kDDNA==
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
	mbloch@nvidia.com,
	horms@kernel.org
Subject: [PATCH net-next V3 0/7] E-Switch vport sharing & delegation
Date: Fri, 29 Aug 2025 15:37:15 -0700
Message-ID: <20250829223722.900629-1-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v2->v3:
 - fix error handling, Simon.
 - Remove redundant struct field comment, Simon.
 - Add Reviewed-by: Simon Horman <horms@kernel.org>

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


