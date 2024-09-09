Return-Path: <netdev+bounces-126586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9473971ECA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65BA2B230C3
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1C139D09;
	Mon,  9 Sep 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fnbTlbuK"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2D13633B
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898226; cv=none; b=AIQXzjBZfVsU1HnXPt3xCWM0gAEFvD37C7r7mYbWNd4zQWTygTsdQQEDzUQYFCz3CaSljmmLYDka1VyEU6j9gNelNGiaQ2FohuQAo/RAASbOrKFZ+GLgfTtE1Xs/ys6NSQ6BwYIlOqucXP5ZM642zQBjEeT1OPEwDX38wELXQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898226; c=relaxed/simple;
	bh=PQzZ4d2AG83bKDInojdJyb61GdlNM19EsZjpsF3Ac/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKNww4D7XQZhBubZNDCCC7Nb0L4j1pHuTmd1YqOtT8FJGGm+55Lk5/vsM5W3hNL9vzP/5TlaxxxVCEMaIWTNjBgeNtVFsPeczEjrz3hh9eo/i8oEuWOPj+9KJmA9RqK4LilwqhCZrb6hGn17BFzdEVMTj6kJnNFBa5eg9Z1NGqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fnbTlbuK; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725898222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iMoMrQAD2bQyRfK0PZ7GSOB8Wm8K4cC6VgqvR/L06YM=;
	b=fnbTlbuKGPJnu+bsgtinf1u6jOc25xKKdp4bUzYxbyRdH83KNBRTiZ3tnhrOzTEGH9fMe3
	ogGU7eA1oGP4BvkPPo7n1vCAyPq15I8INH9CVSW2zU6uUeRpn3kdB88EfXN5JnIiUYve4u
	mNMXrWgPtEerliyel/1yRbORpYgQHto=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2 0/4] net: xilinx: axienet: Partial checksum offload improvements
Date: Mon,  9 Sep 2024 12:10:12 -0400
Message-Id: <20240909161016.1149119-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Partial checksum offload is not always used when it could be. Enable it
in more cases.

Changes in v2:
- Set RXCSUM in features
- Expand commit message with testing methodology

Sean Anderson (4):
  net: xilinx: axienet: Remove unused checksum variables
  net: xilinx: axienet: Enable NETIF_F_HW_CSUM for partial tx
    checksumming
  net: xilinx: axienet: Set RXCSUM in features
  net: xilinx: axienet: Relax partial rx checksum checks

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  5 -----
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 22 +++++--------------
 2 files changed, 5 insertions(+), 22 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


