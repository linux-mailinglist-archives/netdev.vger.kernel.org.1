Return-Path: <netdev+bounces-124691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B996A74C
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5B9B20998
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A69518EFC5;
	Tue,  3 Sep 2024 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TkH6RSzB"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFF1D5CC6
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391536; cv=none; b=LF+hOAZoZxhSqrGbfo5klfV067v/qMCev2gqNcTAf5xBzHKI68eqUYQ6sDooDwbOz57KbJ5LtexkYknUTCzfBH/8CUwNQ2YX48OwlfZXzY+7Uwdc/hNcRy7UjggoWvFx9SmOnFhJWC5Bq9W7Bf36u8vqIxSQ97H3PJQ6nwYaVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391536; c=relaxed/simple;
	bh=ykCWykWpqVTMRvC3YPz6AH99OxBvDavSRS0ceXi2Zrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DEUornYA4l/k9qPKgh8pptn+Y+qYoUYaBr5AkIq0M1o1YBA/wfj26OMX33pUDyXNxI1XJ+8LsKq8CAk2z3YTWXnBmeVw3KGly7cyJ0rtRdVPO/TtybdhM43xsXGPc+NNuouUSr4uLOcJJqpta3RehBRy64fi4Phs27r66tNvUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TkH6RSzB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725391531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QF360K14VcVg7z2XyE8+/3/eZAXYC2hLsD6VFynELLc=;
	b=TkH6RSzBANNSz9eMRL4aH1xDpt+94KF6D3b99fh83OcYt65v9F58AnMqcnx1zqkdQhMdGD
	6qdScVDA1xOw5SUsCacyH4LihW5/0G8vWk8vdOhhvSZLup6kaNQODxPYQQx9AWF3LsMvbC
	f2a0rTOpUvfhwqYvCV9C61uIV+4mpmA=
From: Sean Anderson <sean.anderson@linux.dev>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Heng Qi <hengqi@linux.alibaba.com>
Subject: [PATCH net-next 0/2] net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM
Date: Tue,  3 Sep 2024 15:25:22 -0400
Message-Id: <20240903192524.4158713-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To improve performance without sacrificing latency under low load,
enable DIM. While I appreciate not having to write the library myself, I
do think there are many unusual aspects to DIM, as detailed in the last
patch.

This series depends on [1].

[1] https://lore.kernel.org/netdev/20240903180059.4134461-1-sean.anderson@linux.dev/


Sean Anderson (2):
  net: xilinx: axienet: Support adjusting coalesce settings while
    running
  net: xilinx: axienet: Enable adaptive IRQ coalescing with DIM

 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  18 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 254 ++++++++++++++----
 3 files changed, 220 insertions(+), 53 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


