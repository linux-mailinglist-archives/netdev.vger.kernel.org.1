Return-Path: <netdev+bounces-170470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0BA48D5E
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68BF1891316
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0FB224F0;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT1Njw4a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35D1E4A9;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702542; cv=none; b=EkyfZD8OHjTOpZhEWFZVnmovfgojk0dKpSdyFwpIJt6p8dWtO7G1q385aEEwzzvYBskzvWZaZWR6NG85cd5Q7GHtQ/VWUI2OTKKnpZwsgjttA/VAUFOChL6nUCMbyx2ZpXKtyP+/uzN3Z08L6PXWiypR5l2FXw8xN/vhs2zD85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702542; c=relaxed/simple;
	bh=PZwKPZNIwsktgfTRcNnaJkTyo3RuC268bylz7yQgfOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=maUc9LZZz3Rlc3t+7MDACppUQ7edGbOW4Fou6LbZtEtkbJPVH5Q95/+l+rPhM9jy1FE5qnhXX9ua49ekBwvXPrKU43qs3OflcYER/p0Y1ep5GVYpGMYcfK0x42GGdlV1WLWjKjnyFN2ESyBPt1/IAHqRu0BnZDDXVgxAoJPhWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT1Njw4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E89A9C4CEDD;
	Fri, 28 Feb 2025 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740702542;
	bh=PZwKPZNIwsktgfTRcNnaJkTyo3RuC268bylz7yQgfOg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NT1Njw4a7TLcIdmJxA2L4kWc1bXxqs9bRDkSx9q5Fya4HE9Jj0Wi2r+qXbYHu3unq
	 3dKe3kZCh614k0OXca8FmrTZEV1LmeSXEqESjCMmgpGDdcWrPkj2bDvR1DD9xgGniG
	 sep/iZotgdxHv1c5Cw96BGjWhBZVNomxiCcIVxvth33/PNci3l5nR5FqFMTfexPtVJ
	 /Dds1XUpkzZpA1z/XUw2lQRF6/d9AISQeWOutM5CmTdTkEmTc6D6gjPoCbk1gMZqDl
	 GLIZGxcFFJkP4audyF3WQ00NNAn9jjgd9A2ngOxmbkdu5rGap3yWxwdT+eoaPx3WE7
	 bQzjrmfE1mYxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD9BC282C5;
	Fri, 28 Feb 2025 00:29:01 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH 0/8] enic:enable 32, 64 byte cqes and get max rx/tx ring
 size from hw
Date: Thu, 27 Feb 2025 19:30:43 -0500
Message-Id: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALMDwWcC/x2MUQqEMBDFriLzbaEW1hWvIlJq+1wHZNRWRRDvv
 sXPEJKbEiIjUVvcFHFy4kUyVGVBfnLyg+KQmYw2H22qRkHYWz/DybFaJ8Hi2q3f1Jhl3QxDgP5
 SrteIka/33PXP8wfd6BOGaQAAAA==
X-Change-ID: 20250218-enic_cleanup_and_ext_cq-f21868bbde07
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740702696; l=2108;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=PZwKPZNIwsktgfTRcNnaJkTyo3RuC268bylz7yQgfOg=;
 b=yXTfvSBP6ouKK/vCk+TWVcKFz+0RU/rWTHyrOcd+XmLM35vplEhXCZAtmN57zTtOTeWRnScLv
 Q6iADyGlfTaCwGwWh0oN+/HQJK8ToB8K3upPjVizE3TwlN+vcHh3vCE
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

This series enables using the max rx and tx ring sizes read from hw.
For newer hw that can be up to 16k entries. This requires bigger
completion entries for rx queues. This series enables the use of the
32 and 64 byte completion queues entries for enic rx queues on
supported hw versions. This is in addition to the exiting (default)
16 byte rx cqes.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
Satish Kharat (8):
      enic: Move function from header file to c file
      enic: enic rq code reorg
      enic: enic rq extended cq defines
      enic: enable rq extended cq support
      enic : remove unused function cq_enet_wq_desc_dec
      enic : added enic_wq.c and enic_wq.h
      enic : cleanup of enic wq request completion path
      enic : get max rq & wq entries supported by hw, 16K queues

 drivers/net/ethernet/cisco/enic/Makefile       |   2 +-
 drivers/net/ethernet/cisco/enic/cq_desc.h      |  25 +--
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h | 142 ++++++--------
 drivers/net/ethernet/cisco/enic/enic.h         |  13 ++
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |  12 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    |  69 +------
 drivers/net/ethernet/cisco/enic/enic_res.c     |  87 +++++++--
 drivers/net/ethernet/cisco/enic/enic_res.h     |  11 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c      | 246 ++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_rq.h      |   6 +-
 drivers/net/ethernet/cisco/enic/enic_wq.c      | 121 ++++++++++++
 drivers/net/ethernet/cisco/enic/enic_wq.h      |   6 +
 drivers/net/ethernet/cisco/enic/vnic_cq.h      |  41 -----
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h  |  19 ++
 drivers/net/ethernet/cisco/enic/vnic_enet.h    |   5 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h      |   2 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.h      |   2 +-
 17 files changed, 545 insertions(+), 264 deletions(-)
---
base-commit: de7a88b639d488607352a270ef2e052c4442b1b3
change-id: 20250218-enic_cleanup_and_ext_cq-f21868bbde07

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



