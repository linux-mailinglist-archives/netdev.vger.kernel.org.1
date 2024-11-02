Return-Path: <netdev+bounces-141216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AF19BA104
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EBA1C20DB3
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CBD15A856;
	Sat,  2 Nov 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ILMDv8K7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80E13C3F2;
	Sat,  2 Nov 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560584; cv=none; b=LK1Hdavr9+W/s8dev/1Hz829sW7SSn1v/yvCxHhe2ZxCAE6ayqlOo54BEie8H6IfoI2IM8JA1pNiq7/xlbgaPl79WU5eArJQ9ApekZF5Go47hBAaxzQmO6niCwsw6m49FrrcnQZgUOROX6jJgpzhG0ZELAoZLOhS7BaASIkAOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560584; c=relaxed/simple;
	bh=RD4CygWNNxfZV776KjJNKv+iIwMyqM6JcTwNPJ5S1cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JT7qeyZwKR8P2AohxCAFx/brqGvuQFMDXtqtdYla4mx6USnfAjykrGfKitHLsr3XqymVEeDYT2kpO41cf7ns9/T1yqT9IaH7jdtlVnbuSt/KDrO1L+WDE18VVzxj9rZUgK63A3WhwlxcVGTDK9mFukmxFmiTOZKl6eC0A9j2rBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ILMDv8K7; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=tA0qG6/JUmBJfEBgo2MeNrVwm2mR+qRR0xVnPXKIYHo=; b=ILMDv8K7Tl4XMQYz
	A+fRl6hTVnaJi4nn34ar1efgGL7Cug0C6zjCF6YL4CJEDEIVswu3aXfZqvwZ2vQk0T7S4/h2MwhOi
	maMKPzPZ69ard0Tmbn8+mADHxHVK9nAMn9eXrlJAqumAv03Vn39uXQL8HutStN9NJjDx9uXiOgStq
	9wz9ivFg7D6mhldpZXUONjL1+50b98vg3nRB+6DPZrT8tMtAVzzeWVmJQdaHKjuFsNNDovq5pJRn1
	Zi4bqrH7JxfgQ/eViYh+j9kfbpAgyuWEO0qlAj9t0Z7oacuxbH0Kn2y9qSGl/Vl9TH2QnuMljUshp
	z8i2lFB2HDWm6yI1TA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7FrJ-00F6Vf-2f;
	Sat, 02 Nov 2024 15:16:13 +0000
From: linux@treblig.org
To: ecree.xilinx@gmail.com,
	habetsm.xilinx@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next 0/4] A pile of sfc deadcode
Date: Sat,  2 Nov 2024 15:16:11 +0000
Message-ID: <20241102151611.39504-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

This is a collection of deadcode removal in the sfc
drivers;  the split is vaguely where I found them in
the tree, with some left over.

This has been build tested and booted on an x86 VM,
but I fon't have the hardware to test; however
it's all full function removal.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (4):
  sfc: Remove falcon deadcode
  sfc: Remove unused efx_mae_mport_vf
  sfc: Remove unused mcdi functions
  sfc: Remove more unused functions

 drivers/net/ethernet/sfc/efx.c          |  8 ---
 drivers/net/ethernet/sfc/efx.h          |  1 -
 drivers/net/ethernet/sfc/efx_common.c   | 16 ------
 drivers/net/ethernet/sfc/efx_common.h   |  1 -
 drivers/net/ethernet/sfc/falcon/efx.c   |  8 ---
 drivers/net/ethernet/sfc/falcon/efx.h   |  1 -
 drivers/net/ethernet/sfc/falcon/farch.c | 22 -------
 drivers/net/ethernet/sfc/falcon/nic.c   | 11 ----
 drivers/net/ethernet/sfc/falcon/nic.h   |  5 --
 drivers/net/ethernet/sfc/falcon/tx.c    |  8 ---
 drivers/net/ethernet/sfc/falcon/tx.h    |  3 -
 drivers/net/ethernet/sfc/mae.c          | 11 ----
 drivers/net/ethernet/sfc/mae.h          |  1 -
 drivers/net/ethernet/sfc/mcdi.c         | 76 -------------------------
 drivers/net/ethernet/sfc/mcdi.h         | 10 ----
 drivers/net/ethernet/sfc/ptp.c          |  5 --
 drivers/net/ethernet/sfc/ptp.h          |  1 -
 drivers/net/ethernet/sfc/tx.c           |  8 ---
 drivers/net/ethernet/sfc/tx.h           |  3 -
 19 files changed, 199 deletions(-)

-- 
2.47.0


