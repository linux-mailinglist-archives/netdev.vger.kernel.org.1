Return-Path: <netdev+bounces-222943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A61C8B572A9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4661898647
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1B2EA736;
	Mon, 15 Sep 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV9RqtAc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA72D5932;
	Mon, 15 Sep 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924241; cv=none; b=RDccq8nxWOsjAith+JgkuBuCA7k8QdmsECbKEslmIo2aCLgvwMBWGDhAaqwoaZWbNGoS6WI45toc6xR6risBka2BZj/VB5CcLizeuDN+CxMnUi6IhrSIE/r8sfGPdVnUjINzS36+nx00wM1nzFtIuPb5cOSBvuEf8uw8vZ0m+6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924241; c=relaxed/simple;
	bh=F/X+TtZHooGZVCVdoXlX23gyuHCMQDwSSkVtX3di3Hg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NDT+PTlM9+UFmaoP5bA0vwkrW99bikpvpIrOsyf44a4RSW8qz/tm0IR8A3Ffr0ni+x+lefzEKnsVKrsCQ39rOGpWEVjxjKi1PT1CRC/cmJnyK4uKQHLtzSkNqg7VV3wD/UQZNE/TOBFybWHV8s5KXU7MLlY/6BPNknd4bQCTEKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV9RqtAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B48C4CEF1;
	Mon, 15 Sep 2025 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757924241;
	bh=F/X+TtZHooGZVCVdoXlX23gyuHCMQDwSSkVtX3di3Hg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GV9RqtAc3SB8pgtHReS7bf1ET/E5vlZUVbYsXHtspijXoI45Txf5P71bCW1PTgJV3
	 ex0yceO9ZS+ovvANqgyEHfA2Qj+1iAM6DXHZrjU8MczOnLdaRHjSKBj3K0rKEz9GQf
	 9krMvdrr8vcMowZZT9Xs7F9IjBlFcNkDW3gwqB4SFlOCoN9qAT5g1NjZfrSVeRdYQx
	 icJL5z60ZHfKeJvQCTjkAo4G5K2VGF+x8qlXmdPuyibktjmqLtE1A3WkITAL3lOGzw
	 QH/EkozVXDMET64a3VJSdExZenU+NQYYtSE6NT693CXgaTgUqea8BcXoX8GKS4+pVr
	 4CPy9LxgzY7IA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E10ACAC597;
	Mon, 15 Sep 2025 08:17:21 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net v2 0/2] net: stmmac: Minor fixes for stmmac EST
 implementation
Date: Mon, 15 Sep 2025 16:17:17 +0800
Message-Id: <20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI7Lx2gC/22Myw7CIBQFf6W5azG9pC9c+R+mC2xPLYlCBUI0D
 f8u6drlnJmcnQK8QaBLtZNHMsE4W0CeKppWbR8QZi5MspZtrZjF+57EYj4IotHomhlDB/RU+s3
 jECW/kUWksYyrCdH57/Gf+FB/rhKLWmBgqFb108LLVT8jvD5P7kVjzvkHWuVGd6gAAAA=
X-Change-ID: 20250911-qbv-fixes-4ae64de86ee7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Rohan G Thomas <rohan.g.thomas@intel.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757924239; l=899;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=F/X+TtZHooGZVCVdoXlX23gyuHCMQDwSSkVtX3di3Hg=;
 b=bi6AtS44Cm+PAB1TLYBv/5mE8nemeFtjJHyyt2gUpKfTRwLORFKt6gXA8FrQeXWPi9muVBfYJ
 Lh5o/Pnal8SCzk2Xrv11tNs0rwrZbC5HqjijLT6SOGWlDtKX5riau4o
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

This patchset includes following minor fixes for stmmac EST
implementation:
   1. Fix GCL bounds checks
   2. Consider Tx VLAN offload tag length for maxSDU

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
Changes in v2:
- Use GENMASK instead of BIT for clarity and consistency
- Link to v1: https://lore.kernel.org/r/20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com

---
Rohan G Thomas (2):
      net: stmmac: est: Fix GCL bounds checks
      net: stmmac: Consider Tx VLAN offload tag length for maxSDU

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 25 ++++++++++++++++-------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   |  4 ++--
 2 files changed, 20 insertions(+), 9 deletions(-)
---
base-commit: 5b5ba63a54cc7cb050fa734dbf495ffd63f9cbf7
change-id: 20250911-qbv-fixes-4ae64de86ee7

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



