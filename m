Return-Path: <netdev+bounces-171876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2DFA4F301
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DF27A44BA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3212E824A3;
	Wed,  5 Mar 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="megvsH4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DBF4D8D1;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136049; cv=none; b=o+kHk5m0Q8A8B2za0bYoWrwSfimb1oHLWEJrmUC++FSWYh3AGrZNqycy0wo9M9o45vDh/O4LK6uYe1rWN/nhUcuefw90mNOl8TbecfCbVzT/oJN2jino5ehqQPMmO1NIal93WLiw4+h7VNtywNqhdVuF0Ca1C9uoL/f8uFyOcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136049; c=relaxed/simple;
	bh=tIhOLNOlcINBx0UYhFOL+x8Q07QOhFjHXPWnR8anXHc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eHRaqa/3mmQ6TZQel+azFKoRLffi+BWjPpzUQm8XC+dMNYb7xjEzl3qo/X8y+7DGBVFukVk1M07EWuBjNNiDhueT2E0eLRbKzgRuCVe/eHg2zx+2o0JXIn4sD74Iz7Cfh7INXq3sM9r2mereiT1Rq0677/rhK7tRUV3phROTO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=megvsH4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79100C4CEE5;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741136048;
	bh=tIhOLNOlcINBx0UYhFOL+x8Q07QOhFjHXPWnR8anXHc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=megvsH4nDF0tbmb/hI2xW8hK1FKeG48lIfpOU6BdOMgXZVZW3S72zzM8CWP45Vb6d
	 ucCGPUDa4S9oCP+8GUTMmksFH1hZxR+RRXMKDhO8ZN1hKxpzdgsNu/NdqxY/GV3y/y
	 1s9YcCOzD7SMrhoBl3cpMW7xBbYgf7L021wpH0SRBkOw+Klqq4a+2XNg0NRMm5OJsi
	 JSFgdoSA4Pt85aJp6ukEoi9pp++X36gKHA0bSTP6VnJPJN7bkX8pEPUxdpQjNrz16J
	 Ks9AYlr3UtArAtHD/acu/srL6/oYppecsq8zd37bvMD/AU5okL+ubodrfcEDobVKUb
	 6eDeUQdViwY5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62276C282D0;
	Wed,  5 Mar 2025 00:54:08 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH net-next v2 0/8] enic:enable 32, 64 byte cqes and get max
 rx/tx ring size from hw
Date: Tue, 04 Mar 2025 19:56:36 -0500
Message-Id: <20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEShx2cC/3WNwQ6CMBBEf4Xs2Zq2iqAn/8OQhi6LbKIttpVgC
 P9ug2ePkzfzZoFIgSnCpVgg0MSRvctB7wrAoXV3EtzlDFrqUmpVC3KMBh/UuvdoWtcZmpPBl+g
 zPNXWdiQryOsxUM/zZr6BoyRcLkKTycAx+fDZLie18Z9dV3/tkxJS4EEd+3NZK23tFTmi36N/Q
 rOu6xd4r76syAAAAA==
X-Change-ID: 20250218-enic_cleanup_and_ext_cq-f21868bbde07
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741136202; l=2463;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=tIhOLNOlcINBx0UYhFOL+x8Q07QOhFjHXPWnR8anXHc=;
 b=BZwIfK2gawRr7sIDLP7RnxjDXPXKTC56P8ilZ8yA2qgJ0K6GIEknAIO+BcAeFHSv+uhsU1UT5
 SjBo+UGe2KEC0FrE6MxOGWW1kwoQ37c3tVoYxqtBI4LaAdg4U9VXgPi
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
Changes in v2:
- Added net-next to the subject line.
- Removed inlines from function defs in .c file.
- Fixed function local variable style issues.
- Added couple of helper functions to common code.
- Fixed checkpatch errors and warnings.
- Link to v1: https://lore.kernel.org/r/20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com

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
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h | 142 ++++++---------
 drivers/net/ethernet/cisco/enic/enic.h         |  13 ++
 drivers/net/ethernet/cisco/enic/enic_ethtool.c |  12 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    |  69 ++-----
 drivers/net/ethernet/cisco/enic/enic_res.c     |  87 +++++++--
 drivers/net/ethernet/cisco/enic/enic_res.h     |  11 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c      | 240 ++++++++++++++++++++++---
 drivers/net/ethernet/cisco/enic/enic_rq.h      |   6 +-
 drivers/net/ethernet/cisco/enic/enic_wq.c      | 117 ++++++++++++
 drivers/net/ethernet/cisco/enic/enic_wq.h      |   7 +
 drivers/net/ethernet/cisco/enic/vnic_cq.h      |  45 +----
 drivers/net/ethernet/cisco/enic/vnic_devcmd.h  |  19 ++
 drivers/net/ethernet/cisco/enic/vnic_enet.h    |   5 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h      |   2 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.h      |   2 +-
 17 files changed, 545 insertions(+), 259 deletions(-)
---
base-commit: de7a88b639d488607352a270ef2e052c4442b1b3
change-id: 20250218-enic_cleanup_and_ext_cq-f21868bbde07

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



