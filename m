Return-Path: <netdev+bounces-194247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D2BAC8084
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE78B1BC34B5
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25E622B8D4;
	Thu, 29 May 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCV2Z42y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E6193062
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533975; cv=none; b=Ml8QzkGXUvqP6H4DfrYAr6dk1kqArFf4NnrRyu/lLsTcYnmW39mEdWw+8N2cBJoCoUAdfvko/BXClQ1LR7LkMQOAXM1aKKQ9SBAvph5u/aV7PYuHYkSM6R4Cwd0Jo3gt3Nh2ZPdo+k6f27sREk4f5NmG6NSpf0tD4NC+19EHLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533975; c=relaxed/simple;
	bh=hl2EGsrGA6DGqbMtlfQBtSfBMc1FbsIADq0RXh96ZlM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cJwjZVzw5ms7yscpWoXZW/maKEGTFIawAtFQy2wjw5MaIdYSNMCW01gbC8IAHbumDyk5+PEfZE36tGot4gCLdq1kbhSi5MZtlpywhNCRz84BU3D6CowLw6sqBJjFu+DEnBbWcVeGetkWztLJXmCqi/yLuEciEieoh0pz+8o7m04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCV2Z42y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AC8C4CEE7;
	Thu, 29 May 2025 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748533975;
	bh=hl2EGsrGA6DGqbMtlfQBtSfBMc1FbsIADq0RXh96ZlM=;
	h=From:Subject:Date:To:Cc:From;
	b=kCV2Z42yGt0npy4Ex2G+oPRP+thc3Fkcwhd8enV06PV5M8H2VwCiYZesrJFsBUQQT
	 qgL9LkWnJfGIJMZRbuXBJixkUSLqwMDDV/T3tTKZEMwKleSgfTuCFTWRUOLVtkO5Lp
	 WA/SDlmfskrmgbGIQYBcBMEoYiCcF+i5PNz6yiduLgHy4oJBvZ+VpXg2wmHUAmOIRm
	 LttEO5uOCgA8Qe/7PwyCSEJ8/wBb07GbWbGkODIAGVCbARJ9zhhNe3wwFu0JedvdCA
	 58CWZMz01/lvXOjYEd85XmjNIxFQV7KThwR5bvqc8vJJsVs8nf/vb4FH152iRoFLXw
	 jlRuFHa9LKWaw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net 0/2] net: airoha: Fix IPv6 hw acceleration
Date: Thu, 29 May 2025 17:52:36 +0200
Message-Id: <20250529-airoha-flowtable-ipv6-fix-v1-0-7c7e53ae0854@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSCOGgC/x2MSwqAMAwFryJZG6gF6+cq4iJqqgGx0ooK4t0NL
 ucNbx5IHIUTtNkDkU9JEjaFIs9gXGibGWVSBmtsaUrbIEkMC6Ffw3XQsKrfT4debmwqR8XIteF
 qAv3vkXX+213/vh9poXh1awAAAA==
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
Lorenzo Bianconi (2):
      net: airoha: Initialize PPE UPDMEM source-mac table
      net: airoha: Fix IPv6 hw acceleration in bridge mode

 drivers/net/ethernet/airoha/airoha_eth.c  |  2 ++
 drivers/net/ethernet/airoha/airoha_eth.h  |  1 +
 drivers/net/ethernet/airoha/airoha_ppe.c  | 52 ++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_regs.h | 10 ++++++
 4 files changed, 53 insertions(+), 12 deletions(-)
---
base-commit: 27eab4c644236a9324084a70fe79e511cbd07393
change-id: 20250529-airoha-flowtable-ipv6-fix-976a1ce80e7d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


