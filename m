Return-Path: <netdev+bounces-115007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE9944E24
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E86282DCE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EA1A487B;
	Thu,  1 Aug 2024 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6FXkcdY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175881A3BC7
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522933; cv=none; b=uX8UnRFIUdvCHhzPzIFkR4mln+IZkFMtcAbZz36YZGL1wq7/vPLJRFSLhai0eH+1KugKUGwjfAslBs6Yxfwu+0uJFF7Rqe8OXaVa0bMKnNGJV7TBA3T0KvQat4+yCwWNt61BDPOnYS+hhjMzFuIXAF/bErnDZHrq65/ASMScmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522933; c=relaxed/simple;
	bh=nMjbwBbCIYqdVOI7ggaz0aXbGvVaFJTrJRsrK3GOZHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WG5+wO3N1SyGLl7/2zs6EKc2R/TEtmRZG8b8TAFQqb27idSGWqxRWz5yIVIEbmx1Tqd3aUX66JrQROZUHNCJUIKqnUMtNOG9OTr83Jwev1hYaI6cnxAo8eMEkL7PxesVuDoP9yLVk2MJ2R6xrKS/mHL3vMSQ9Me7vIKKsoYHGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6FXkcdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484A3C32786;
	Thu,  1 Aug 2024 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522932;
	bh=nMjbwBbCIYqdVOI7ggaz0aXbGvVaFJTrJRsrK3GOZHk=;
	h=From:To:Cc:Subject:Date:From;
	b=b6FXkcdYlCXIH1uZjnECSMoQWblslGICg/I+ov8bL3NhBjJCS2FVQUCk4hLPPt2ED
	 uzYboScHl3vWqRmdspkFbgm2AAsx/7H8cyVZ5gVzF9FA5I+/JBSe1s0VOUg2xxOWLi
	 8lqy0rwsbCj4S2d+euC6rnrV6xfrc6IyB+FxOhVzXXLZCo9qzg1O4QMhiJ/TuNXzVS
	 nWL8uwDrLPRmzfOYZlLvdlFYNWdTKY91ajobFC63Y0HAYmJsLfKWiaIeYOTGCkxYd2
	 gC710673dmLIANy8/4BeeTjg+qUj8o/O0aYMqZZaBspvzQdJaDyDF5JILYDM/sP/wh
	 fth2fPMYUo0dw==
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
Subject: [PATCH v2 net-next 0/8] Add second QDMA support for EN7581 eth controller
Date: Thu,  1 Aug 2024 16:35:02 +0200
Message-ID: <cover.1722522582.git.lorenzo@kernel.org>
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

Changes since v1:
- squash patch 6/9 and 7/9
- move some duplicated code from patch 2/9 in 1/9
- cosmetics

Lorenzo Bianconi (8):
  net: airoha: Introduce airoha_qdma struct
  net: airoha: Move airoha_queues in airoha_qdma
  net: airoha: Move irq_mask in airoha_qdma structure
  net: airoha: Add airoha_qdma pointer in
    airoha_tx_irq_queue/airoha_queue structures
  net: airoha: Use qdma pointer as private structure in
    airoha_irq_handler routine
  net: airoha: Allow mapping IO region for multiple qdma controllers
  net: airoha: Start all qdma NAPIs in airoha_probe()
  net: airoha: Link the gdm port to the selected qdma controller

 drivers/net/ethernet/mediatek/airoha_eth.c | 488 +++++++++++----------
 1 file changed, 263 insertions(+), 225 deletions(-)

-- 
2.45.2


