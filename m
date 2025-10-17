Return-Path: <netdev+bounces-230330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29984BE6A52
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AF1624CE2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A048323401;
	Fri, 17 Oct 2025 06:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT6cKJFY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B631062D;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681493; cv=none; b=oKqOMOl+sRxVC6p41HZ/Fvibfhm81SdJN4m6wpWNYQIdTOfOZ+DkR6iyklNGoJ8EeoO35e+zaZ+OfFGa4wFEv74HVUM1qDc++6FVmub3gW8bH15R1SbE+6h3IIi1yLIEF6X0UWTGBswNSoxsMUTuOJT9VnPUThL4ITnp64wLk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681493; c=relaxed/simple;
	bh=cErZl+Aef5mADFNSRF/CqGvdSUgsvsLw4QmBcD8g+xk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dn7m3jAGqOEY61KPvf0o/QsNr1BRS74C7ybYowiU7EpzOdQhZYWzXPIOCBaa0HglkeAzsUuPt0uIxrkqZqlIs5uzQx9a8SEG1GjVuAiCHLm1EpiZfCkXnMxWklLWMptO6C3+i3En4z+f6lbaX+mqfNy4jraNenqj0e1gTnqQrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT6cKJFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D742C4CEF9;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760681492;
	bh=cErZl+Aef5mADFNSRF/CqGvdSUgsvsLw4QmBcD8g+xk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MT6cKJFYzJ3pBJEuKuESMxdf7EH9u5wfrYkkU+lKVz8703gzHd+LUzyk5lM7+NmNt
	 f0i1MO+wMJNzdPas6FAmlNm1rPHsYmJxjJpKhz7kOcl/8NHhQtjQbvzyXJZh3sDql1
	 C8gtV7BMUIyjV8suK0sw0PoxdxWFJhmxn6EY+l5JOWgXc1mnbahErLXgOnc2NYqOxi
	 7QuxMVknIysqBGwqOVB0Jaks4is7of1j7INOjcgMv32PvsSXXHFBnm0B9PsX982MkT
	 HvXic2raDBD8IYHdoLEYcNW/5BqMP/s/V+vY8jEgAhSUjgKGjiRcpWFnZVcvsfwpuM
	 FAAusoxikX8ag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4DCCD195;
	Fri, 17 Oct 2025 06:11:32 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Subject: [PATCH net v3 0/3] net: stmmac: Fixes for stmmac Tx VLAN insert
 and EST
Date: Fri, 17 Oct 2025 14:11:18 +0800
Message-Id: <20251017-qbv-fixes-v3-0-d3a42e32646a@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbe8WgC/22MSw7CIBRFt2LeWAzQD8WR+zAOKL21JNoqNETTd
 O8io5o4vJ9zFgrwDoGOu4U8ogtuGlMo9juygxmvYK5LmSSXFddCsGcbWe9eCKw0qMsOTQ0oSv+
 HRx7S/UwjZrqkcnBhnvw7+6PI0x9VFIwzNAK60sr2oj+Z2wxvDna6Z02UW7TaovKLWs1rVbSt6
 sofdF3XD9HhEPXjAAAA
X-Change-ID: 20250911-qbv-fixes-4ae64de86ee7
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <Jose.Abreu@synopsys.com>, 
 Rohan G Thomas <rohan.g.thomas@intel.com>, 
 Boon Khai Ng <boon.khai.ng@altera.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760681491; l=1667;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=cErZl+Aef5mADFNSRF/CqGvdSUgsvsLw4QmBcD8g+xk=;
 b=tRc0k49q8CDclLGLO8HNDIxA1auXJjd1G977SPRKTM0FDT3tlempIlYU7PezAgMqrysJSBVVv
 sqfIJaS6wkUDmvWgknuvKjgJnkl44nHVL3pEswrkq2bEt3YogBF5+rW
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

This patchset includes following fixes for stmmac Tx VLAN insert and
EST implementations:
   1. Disable STAG insertion offloading, as DWMAC IPs doesn't support
      offload of STAG for double VLAN packets and CTAG for single VLAN
      packets when using the same register configuration. The current
      configuration in the driver is undocumented and is adding an
      additional 802.1Q tag with VLAN ID 0 for double VLAN packets.
   2. Consider Tx VLAN offload tag length for maxSDU estimation.
   3. Fix GCL bounds check

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
---
Changes in v3:
- Commit for disabling 802.1AD tag insertion offload is introduced in
  to this patchset
- Add just VLAN_HLEN to sdu_len when 802.1Q tag offload is requested
- Link to v2: https://lore.kernel.org/r/20250915-qbv-fixes-v2-0-ec90673bb7d4@altera.com

Changes in v2:
- Use GENMASK instead of BIT for clarity and consistency
- Link to v1: https://lore.kernel.org/r/20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com

---
Rohan G Thomas (3):
      net: stmmac: vlan: Disable 802.1AD tag insertion offload
      net: stmmac: Consider Tx VLAN offload tag length for maxSDU
      net: stmmac: est: Fix GCL bounds checks

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 37 ++++++++++-------------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   |  4 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c |  2 +-
 3 files changed, 19 insertions(+), 24 deletions(-)
---
base-commit: cb85ca4c0a349e246cd35161088aa3689ae5c580
change-id: 20250911-qbv-fixes-4ae64de86ee7

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



