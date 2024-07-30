Return-Path: <netdev+bounces-114218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB30E94197F
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FBDB2B35D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1A18801C;
	Tue, 30 Jul 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIml3llT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15411A6166
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356587; cv=none; b=ez749I5YBMjOc9/oY4GTp7ktTIuskTAGSw3gvzAnITN/dhyTRR/yNPC6UyUiI0hm4F84YDx2AX3+egsidgzYxlxGFiTGrJjgAyPwnFRRnZmD/Mtd6Gw1pG+ZGjo9zRsg4eraNhwi+loMl9dHGNUmXE+5g4J976tpOvJ4ZXizhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356587; c=relaxed/simple;
	bh=QHGM8c0biz9j8NZkjSJPK1CNM5EDL9bSLyOBBl3d/fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6zzy5MH9zspSH53MQWe4yW7HpdM/2/9zgsB8gOrXEKJ24P32iMQOgGGZdNI5o/5HU01T1rtysUgkx1Jjx0Q2mXfUYmaZuVJUgdmokLI5qxr4gtuESld3ESAgB25kb1gP8NUXeMQr1XE/a4jKTG5bdXBL9TrBNZfZYJZ/aTMYE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIml3llT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351CAC4AF0A;
	Tue, 30 Jul 2024 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356587;
	bh=QHGM8c0biz9j8NZkjSJPK1CNM5EDL9bSLyOBBl3d/fY=;
	h=From:To:Cc:Subject:Date:From;
	b=cIml3llTwhPi9rG5DVOvyXm//oCy9MWTFahUn+lkrT517tw60qjuQX3eRGOCCGkrR
	 At62aoQR8mU2zJxEKrvnGOyMSOleiiIz+Dzu4BVPlnKpElOdHtEEsTTP/dmMWjHhbD
	 frL4RKRwHy6LncEOqmu+lAA/IZJffo+LX6Eu6aY7w3csl/wYVT3F87/cVT2r3En/Lp
	 gamYopMs1G/7JDCe7FWq70Cleo4R1ch8BJzcSEdLhL3RQzY/s98+WM2gOgFGk90+4w
	 4gpTatxwLBfrnFoqIxCLcySUqMGPy6pO4aEqFDi//aDHuB4YieEpWpShv5eRwaU87y
	 XP5XDXAOcZ+xQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo.bianconi83@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	rkannoth@marvell.com,
	sgoutham@marvell.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	horms@kernel.org
Subject: [PATCH net-next 0/9] Add second QDMA support for EN7581 eth controller
Date: Tue, 30 Jul 2024 18:22:39 +0200
Message-ID: <cover.1722356015.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EN7581 SoC supports two independent QDMA controllers to connect the
Ethernet Frame Engine (FE) to the CPU. Introduce support for the second
QDMA controller. This is a preliminary series to support multiple FE ports
(e.g. connected to a second PHY controller).

Lorenzo Bianconi (9):
  net: airoha: Introduce airoha_qdma struct
  net: airoha: Move airoha_queues in airoha_qdma
  net: airoha: Move irq_mask in airoha_qdma structure
  net: airoha: Add airoha_qdma pointer in
    airoha_tx_irq_queue/airoha_queue structures
  net: airoha: Use qdma pointer as private structure in
    airoha_irq_handler routine
  net: airoha: Allow mapping IO region for multiple qdma controllers
  net: airoha: Clean-up all qdma controllers running airoha_hw_cleanup()
  net: airoha: Start all qdma NAPIs in airoha_probe()
  net: airoha: Link the gdm port to the selected qdma controller

 drivers/net/ethernet/mediatek/airoha_eth.c | 491 +++++++++++----------
 1 file changed, 266 insertions(+), 225 deletions(-)

-- 
2.45.2


