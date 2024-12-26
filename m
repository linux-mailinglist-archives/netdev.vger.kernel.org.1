Return-Path: <netdev+bounces-154304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463A9FCBF5
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 17:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8C17A12F9
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9503EA83;
	Thu, 26 Dec 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="UR/oysPA"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FABEC5;
	Thu, 26 Dec 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735231951; cv=none; b=U0KYVK92hrdJOiEcJirSaTRk4X1W3XvqJjTxSqqX5UGcAf1cgFqfLVK5MswqpMtTn6+CNEIaAtvQuCruuwOdNaKyhDWu0PNw9ZCm6tVxwkhrE6je8+kmP1VIrWNP6LiDba4RWyuw4XTCNtidmbkUUbTx8iJzHWpRWMGVsht7ytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735231951; c=relaxed/simple;
	bh=HSY1AiLdk/ey539mU7A4xqBvBoQr05GSVrlAXkB3a30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMWzn9PaV5Tmn0meOARvdgTD8HSD5Q0Mi2qJi1OpI+MVtpC6+yUjpn78phFMOLt8bUbYj6NQVYgzQIs++6KuNtYqDwOb6jx85lIp78vGMnIXS+dL0JbxJRHqEiNdvyJECCh5lDrzw6nCKOKq/dLMwRV2409dgYRKmPWOdPeGs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=UR/oysPA; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=9jo07Tlrz15w/TzMuCB5HC/3DxkFQ4oE8Ex5RRlirs8=; b=UR/oysPAE8heoXk6
	9/DG9m7b+qm2z0mhSU4Rgd5g70V+0UyCkJxjkwBM6bE4xDZnGnaTfes9Ru/hVq2Xm42lCjjwAG8Gb
	LAimq3nAzMkzIDtwnXwweCs3GrBu5E9PIyF7NEMnM2vEl2IUUPSPBScepa5Dws5/BRmO1Npjl6+2h
	AZGWiNv1xBIFmb2WZaefueNoLzgmYfXHLqJM8PlvIEWvfNGdsPFNgixw+AgiOBHCQbI9PL4xn8LBb
	RyswABDZUQz1NR97o3nmyA12o/idSvsB2pVuE3JucIOnPgwAskQXJo/aSQfZMNS8WCY0/30Ul3m31
	SEt5EO3zNZKkD+qrfw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tQr5s-007IaP-1J;
	Thu, 26 Dec 2024 16:52:16 +0000
From: linux@treblig.org
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC net-next 0/3] igc deadcoding
Date: Thu, 26 Dec 2024 16:52:12 +0000
Message-ID: <20241226165215.105092-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  This set removes some functions that are entirely unused
and have been since ~2018.

Build tested.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (3):
  igc: Remove unused igc_acquire/release_nvm
  igc: Remove unused igc_read/write_pci_cfg wrappers
  igc: Remove unused igc_read/write_pcie_cap_reg

 drivers/net/ethernet/intel/igc/igc_hw.h   |  5 ---
 drivers/net/ethernet/intel/igc/igc_main.c | 39 ------------------
 drivers/net/ethernet/intel/igc/igc_nvm.c  | 50 -----------------------
 drivers/net/ethernet/intel/igc/igc_nvm.h  |  2 -
 4 files changed, 96 deletions(-)

-- 
2.47.1


