Return-Path: <netdev+bounces-110982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDEF92F311
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE1561F21B43
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47428391;
	Fri, 12 Jul 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="toZP0vxq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B7C138E
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744406; cv=none; b=SyIZMUR1P6wWJ96WNmiZb/Ja4gjNXAd8FlcQ+HMLCFkLinfPy+IksNRy6ZMmkoOpdkJ+e1M5xzdPyIcxWH2sP4EJm2sfV2qya9rmNkz6ERAklOA/VceJBMTJEenZjVAccFzZccp0PIJJf05KqVFLUGt68J0lpHtZzOO7sUiSp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744406; c=relaxed/simple;
	bh=jwcpODu67vbExhxdXfrRgFMk6AaFm+DG5jjoxlk9vVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3zFgKYHEw1yfTI0MUvfvPygeSNqRkMSHoNm61HlQiWCAa8Jeej0vV6wMOT13L4nRBWkjVg1jd11rKOUgXUvb5Osumoa6QKdqAKq7JOATgHf34ePScgFSm28WG4aGN3r4hWkW0alKowCefME1O83jLW2BLVpsjSZ4XIvlBiC9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=toZP0vxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9605DC116B1;
	Fri, 12 Jul 2024 00:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744405;
	bh=jwcpODu67vbExhxdXfrRgFMk6AaFm+DG5jjoxlk9vVM=;
	h=From:To:Cc:Subject:Date:From;
	b=toZP0vxqhAtyaVxR7gWwM0N6tERw0m0S4Hh3EnYNr/KTTtxERRcUffMsMTKBLw4sF
	 1FO0RIiPlJT3ZCEUp11cP0oLUlFW1lIIKONUcNMfezIbni5yY3Dp/Oe1QoPFTX/WpH
	 AM/OPZt5bkQb2ZW98B+qIfUt07bVGDaVXN2NgoB/7cPVX09J7oDWHzk/yS2LsyVNk8
	 pbDqRSUCGusGsrZnvAtAieicI/2os9naremkEidPB8QsoJsjRywUB31481zCIIvMlW
	 +3024l4M2DS9H8zJvWMHwrGJs/D9Kr69atUcCNharXOY1WjKkdsnP7hnmfZZUpsn5N
	 9ZYXwaLWt0b5w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next V3 0/4] mlx5 misc 2023-07-08 (sf max eq)
Date: Thu, 11 Jul 2024 17:33:06 -0700
Message-ID: <20240712003310.355106-1-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Hi,

This V3 includes only 4 patches out of the original 10 in V2,
since Jakub asked to split the series and fix the commit message
of the first patch.

V2->V3: 
  - Improve commit message of patch #1 (Jakub).

Link: https://patchwork.kernel.org/project/netdevbpf/patch/20240708080025.1593555-2-tariqt@nvidia.com/

Daniel Jurgens (4):
  net/mlx5: IFC updates for SF max IO EQs
  net/mlx5: Set sf_eq_usage for SF max EQs
  net/mlx5: Set default max eqs for SFs
  net/mlx5: Use set number of max EQs

 drivers/net/ethernet/mellanox/mlx5/core/eq.c      |  7 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  3 +++
 .../mellanox/mlx5/core/eswitch_offloads.c         | 15 ++++++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 12 ++++--------
 .../net/ethernet/mellanox/mlx5/core/sf/devlink.c  | 12 ++++++++++++
 include/linux/mlx5/mlx5_ifc.h                     |  4 +++-
 6 files changed, 41 insertions(+), 12 deletions(-)

-- 
2.45.2


