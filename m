Return-Path: <netdev+bounces-75094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EE868265
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDB31C24564
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA8130E46;
	Mon, 26 Feb 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbL54hKE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6298C1DFCD
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981826; cv=none; b=sBs6DZdTOe2iKnz1E+BlLUwzJjD2xLLbafguvqwTlB7HkpspjF5fUpV7IO3tgmxc5oLhw+EIl/IGA7UqufXXDYrFNzgVRy5kc6fTEn2w5Xrd8ZQ+guPiN8bVYdwvF1mDg3aTTKr/i9k+cwGYNwVc70rrNDDfQCd5BWqIBtj6rTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981826; c=relaxed/simple;
	bh=WzYn7Ij9BHwq0tf1BbKTVTlP6MpF1Vtu3UCxxzsx7WE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A231k22Gc3E3SOxAowXiYZJJwSGBA5xn/GI/ZlFritk0PmWwOrcQLn1tRycX1pbcsWF2ucOvK9dVLPRGutuWOkyjyZI/nF5TBONQ8AR1sfZpKUWmOp5J32KrEfp9pOHNUD0OCiEAFjZVxUHbkhldIGnUIFjtxPqarYc+Z9egMfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbL54hKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EA0C433C7;
	Mon, 26 Feb 2024 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708981826;
	bh=WzYn7Ij9BHwq0tf1BbKTVTlP6MpF1Vtu3UCxxzsx7WE=;
	h=From:To:Cc:Subject:Date:From;
	b=HbL54hKEWQdhwTOTD6cnSy5vAcXIPbxlXa89FXpePkL2IHe50RZ6p0Wg91L0yaUtC
	 O8G0bZ/70YlKrcxNIPWUTaOXzJYMSwcH2+wpSWkr/wDMFARevsMg5i3uKm3LD1Othf
	 gHzxtQA48a+HMDSEs0WY1RB5tfxPy6blOlGz+zXnWMDHS0iLmbrglPSIQ13eFY76S/
	 MCAkp0rLGRMmGBssu4+uVhxNI236s2qWz6uBbm8diukKjRNL6OumlbEu0kVKd3IHaI
	 eHkljF8Wbuj8rfjo4oaWFIi827zM9Xw95gTV2SgeR0F6CKFEQDEaCx44pDk7JkFQdh
	 GebeyABbwOG1w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	amritha.nambiar@intel.com,
	danielj@nvidia.com,
	mst@redhat.com,
	michael.chan@broadcom.com,
	sdf@google.com,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] netdev: add per-queue statistics
Date: Mon, 26 Feb 2024 13:10:12 -0800
Message-ID: <20240226211015.1244807-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Per queue stats keep coming up, so it's about time someone laid
the foundation. This series adds the uAPI, a handful of stats
and a sample support for bnxt. It's not very comprehensive in
terms of stat types or driver support. The expectation is that
the support will grow organically. If we have the basic pieces
in place it will be easy for reviewers to request new stats,
or use of the API in place of ethtool -S.

See patch 3 for sample output.

v1:
 - rename projection -> scope
 - turn projection/scope into flags
rfc: https://lore.kernel.org/all/20240222223629.158254-1-kuba@kernel.org/

Jakub Kicinski (3):
  netdev: add per-queue statistics
  netdev: add queue stat for alloc failures
  eth: bnxt: support per-queue statistics

 Documentation/netlink/specs/netdev.yaml   |  91 +++++++++
 Documentation/networking/statistics.rst   |  17 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  63 +++++++
 include/linux/netdevice.h                 |   3 +
 include/net/netdev_queues.h               |  56 ++++++
 include/uapi/linux/netdev.h               |  20 ++
 net/core/netdev-genl-gen.c                |  12 ++
 net/core/netdev-genl-gen.h                |   2 +
 net/core/netdev-genl.c                    | 218 ++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |  20 ++
 10 files changed, 501 insertions(+), 1 deletion(-)

-- 
2.43.2


