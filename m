Return-Path: <netdev+bounces-194592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDEEACACD4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFB819607B5
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552CE20A5E1;
	Mon,  2 Jun 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPuWMH/z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD06207DFD
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 10:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861756; cv=none; b=UylsCLoznWO1OozQGA9gChkEG9NYyT6tlIvFbMBHJE4xeRc8Pc0yEyo06m0j0CKsSe8ZfBnW/WKLjP6rZIm5yvR8LSDhkAQTYNm0vuxUa4BX+XRx2BFBoGRmhDnYBg5tq1yrmlLaIm7WqN2VMdY2LkdOk8nmfcopfYL++f7D2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861756; c=relaxed/simple;
	bh=CNEuqINln8xoGOt137lfp3l1+JiSb5Impr5Rqb39m34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GVC0bRLAodaVyYZpI4FiZ98vgiNgYq1vkhk/WniFN8m+G9GMl51gfSABUmKwGR2Cs6vQ7Qibw0UUPpHea0xNh5G9ICpIcaDt9iVCnS79vBTX5KMr/BeB8dceLzco9u97yw9pYmgai1RzAff5pNzqmiOxrhdf5ql1pdi8Mjv3rRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPuWMH/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37ACC4CEF1;
	Mon,  2 Jun 2025 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748861756;
	bh=CNEuqINln8xoGOt137lfp3l1+JiSb5Impr5Rqb39m34=;
	h=From:Subject:Date:To:Cc:From;
	b=pPuWMH/ztPzZjmTHRmB9cntwUBLPXObLyPRCaE58XESTgG2SsVymcgOdcDVeqdvpI
	 IH6KWlt8Z8mhBTzRdEM+dOseRpNfyB5RexRmwOxPdAnuSFXil2dgt/XTy9tWpcuUXm
	 QFWg6/vI/MZSQTZNGf0npGy7ZKP1Z4J1yHm3gvOkn7U8NiTI0EjjdsUP9NcxKu+qx1
	 f1jh4juiXrPZJ4NggIM32ttWIzauftSdi4E6mTpsNZuN1v9OWEux/ax77GemyD7Xyj
	 uGMtR2OSH2gcWdzeY62XtFKi8Zqd5BhEG+T4iPoE4QWWN/UVaiys4acjHyl/ko+S19
	 jQiERfNeivDqA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v2 0/3] net: airoha: Fix IPv6 hw acceleration
Date: Mon, 02 Jun 2025 12:55:36 +0200
Message-Id: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACiDPWgC/42NQQ6CMBBFr0Jm7ZhSLQVW3sOwqDDARELJlFQN4
 e5WTuDyvZ///waBhClAnW0gFDmwnxPoUwbt6OaBkLvEoJU2yugKHYsfHfaTf63uMaV8iQX2/Mb
 KFi5vqVRkO0j9RSjpY/veJB45rF4+x1XMf/af1ZijQttaMhdHqjTX25NkpunsZYBm3/cv6m3CK
 8MAAAA=
X-Change-ID: 20250529-airoha-flowtable-ipv6-fix-976a1ce80e7d
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Fix IPv6 hw acceleration in bridge mode resolving ib2 and
airoha_foe_mac_info_common overwrite in
airoha_ppe_foe_commit_subflow_entry routine.
Introduce UPDMEM source-mac table used to set source mac address for
L3 IPv6 hw accelerated traffic.

---
Changes in v2:
- improve commit logs
- move smac_id configuration for L2 mode in a dedicated patch
- Link to v1: https://lore.kernel.org/r/20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: Initialize PPE UPDMEM source-mac table
      net: airoha: Fix IPv6 hw acceleration in bridge mode
      net: airoha: Fix smac_id configuration in bridge mode

 drivers/net/ethernet/airoha/airoha_eth.c  |  2 ++
 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_ppe.c  | 54 ++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_regs.h | 10 ++++++
 4 files changed, 55 insertions(+), 12 deletions(-)
---
base-commit: 558428921eddbd5083fe8116e31b8af460712f44
change-id: 20250529-airoha-flowtable-ipv6-fix-976a1ce80e7d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


