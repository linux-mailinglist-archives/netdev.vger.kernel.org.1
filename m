Return-Path: <netdev+bounces-172694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6577A55B8B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEDF189B2A6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F220F611E;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8wUFWOq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B23D6D;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306371; cv=none; b=lDdWcmSdIHVdDeTIYOXWXXQhAeyC4zUClNN7PaibI6wQxz5plcFnlA9yiIx920txGoCvlDvS9UYgrpcVnS2h7ulimrA+Wuc6lqdZylKLtSk47breoHekGrzh6e+HHehYHilN6p85ngbCtLlby0KlkoIn9GmNGHm/odtoCDXcvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306371; c=relaxed/simple;
	bh=oMm/im6g2Yvfce+8abOgBvZ5Ddw906iLXRtF4jDWO64=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EqIDxTYikIDBaX/c0CaoI0ppG52GZwRMUXFEtU1QB4mttMhKrbANHrk/Z3GSqVvlVy/vBKNB7kEoCzpDO/kDoLTh9iEJJCzabp5a64QpDlEnpFcFUKfRWTOATfmvaAB6eAoW2tGnLn2z/UjfaQc+C3NXUer0j1vVfQF/JxTOY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8wUFWOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D253C4CEE0;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741306371;
	bh=oMm/im6g2Yvfce+8abOgBvZ5Ddw906iLXRtF4jDWO64=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D8wUFWOqHhG6XsWFwxSj97N81Ez/lf2x75+lYfHXN551OUauXAdjoY7hWpFb5n2QQ
	 +z3qsnoAknKdqknBwAnTABacFSONYvkUwkrYSMb7aAQExU6EKGXNC2IE1mGgYQRV4Z
	 NU6X3zWO5+jMm4wthg5oZ2Ux9T0rjzVzOne2gqTSUJyReT/wWqqcGmUWJlULGTSx4K
	 RWcLEJlikQQYQVz8dWEa+Sw9qeqSWJawYp40NEL5OY7+4pPu+DxQ5bJvEOJ5QnIx5j
	 oLtaQFfzSTNg1lB8nRK+nY5mBLUSKVB17LYxouhSCX3Mu9nOUEHNLQqAut/K30oKbi
	 hfSiYQbq5OkcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1514BC282EC;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Subject: [PATCH net-next v3 0/8] enic: enable 32, 64 byte cqes and get max
 rx/tx ring size from hw
Date: Thu, 06 Mar 2025 19:15:21 -0500
Message-Id: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJk6ymcC/3XNyw7CIBAF0F9pWIsB+kJX/ocxhMfUkihUqKSm6
 b9LcKEblzd37pkVRQgWIjpWKwqQbLTe5VDvKqRH6a6ArckZMcJawijH4KwW+gbSPSchnRGwzEI
 /8JDLjitlgPQor6cAg12KfEYOZuzyIbrkZrRx9uFVXiZa+o/O+r96ophgXdNmOLScMqVO2kbt9
 9rfi5nY16lJ899h2eEtJw3raiMN/3W2bXsD3TGw6hABAAA=
X-Change-ID: 20250218-enic_cleanup_and_ext_cq-f21868bbde07
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741306525; l=2637;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=oMm/im6g2Yvfce+8abOgBvZ5Ddw906iLXRtF4jDWO64=;
 b=wHygnFa9kJOQE+tEfDwwUdI4pFBTj3RodmqhwOh85poUiK+DCVsBbccAsj9bjwyi6pBDsSvnA
 AH3zHPjqcRUArdsYL73ltsLFgRoXBcSm7p6dUanAhilkGrKoZ6tSJjO
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
Changes in v3:
- Minor: commit message header reformat for some commits
- Link to v2: https://lore.kernel.org/r/20250304-enic_cleanup_and_ext_cq-v2-0-85804263dad8@cisco.com

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
      enic: remove unused function cq_enet_wq_desc_dec
      enic: added enic_wq.c and enic_wq.h
      enic: cleanup of enic wq request completion path
      enic: get max rq & wq entries supported by hw, 16K queues

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



