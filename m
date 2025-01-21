Return-Path: <netdev+bounces-160133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DF2A1879F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 23:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D37188A79F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 22:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC431F4E37;
	Tue, 21 Jan 2025 22:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I66XrGqb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589B752F88
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737497725; cv=none; b=bi8nr9CvEt6rMo1elpadxuc5cbz8yoeiR4bY/Ms+WQBJ7abaL2P6YlbJ3SxrsMwe2aoKfOfGD291acCjBXsePEWrSV8yoeEiKYGoIfL+WC/b5RbBVnK9oQCMr5gqWg4sOWbvd6AAH2uUoVTtAlAeykaVy6BhFQt841AjIo5jFiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737497725; c=relaxed/simple;
	bh=l8k5BQzDuihsWDysn5uUU0rEr+O2YdjyiEf8LxkLRe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBVgr+3o5Tfk6VGg89PBtdrWy6+LoJmrw29AmDf4/uX6oCzR/dNDbc0kpQZtmQtsE+qY3y1rEWLdNxpqyF2VxFs4LG88sNaFHfhxEUR9Vyx8GTloeOB4EXDuR0uEBGUVipZFTjJzc9WGHJdjhI5FyGLdj1Ff06uEPeelm2vTf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I66XrGqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64107C4CEDF;
	Tue, 21 Jan 2025 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737497724;
	bh=l8k5BQzDuihsWDysn5uUU0rEr+O2YdjyiEf8LxkLRe0=;
	h=From:To:Cc:Subject:Date:From;
	b=I66XrGqbCfbEboND4V56JCMXycs90YmnwIK0Or5cV/XA1WzC3j2Gps6P68kzzByLN
	 MDQcFwnFI+u76Qxq+wM/sx908JxhA8TVgu0WBZEBVF/SIW1MbCmnhVamZkMPhlkQlm
	 sKfTor7DhG6nzerPp1QCsMRUC5eIERrsbmlukAdgJW8CFplX/YPvfaaGOJNzRzsuYH
	 NnZb11FndbKzckG7gnoJHgp/WBHTy/tiXzD0WTAu6sN2EVfeAu+ijQOlcyQDV27mrE
	 yM6ht6jh6yeIoE5QIYE2c1l+tlVahWE+kMRnQjG9Mt/GcJyGX7lqeD5YufNVvVBmSq
	 R0sq8nZLFcd4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/7] eth: fix calling napi_enable() in atomic context
Date: Tue, 21 Jan 2025 14:15:12 -0800
Message-ID: <20250121221519.392014-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan has reported I missed a lot of drivers which call napi_enable()
in atomic with the naive coccinelle search for spin locks:
https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain

Fix them. Most of the fixes involve taking the netdev_lock()
before the spin lock. mt76 is special because we can just
move napi_enable() from the BH section.

All patches compile tested only.

Jakub Kicinski (7):
  eth: tg3: fix calling napi_enable() in atomic context
  eth: forcedeth: remove local wrappers for napi enable/disable
  eth: forcedeth: fix calling napi_enable() in atomic context
  eth: 8139too: fix calling napi_enable() in atomic context
  eth: niu: fix calling napi_enable() in atomic context
  eth: via-rhine: fix calling napi_enable() in atomic context
  wifi: mt76: move napi_enable() from under BH

 drivers/net/ethernet/broadcom/tg3.c           | 33 ++++++++++++++++---
 drivers/net/ethernet/nvidia/forcedeth.c       | 32 ++++++------------
 drivers/net/ethernet/realtek/8139too.c        |  4 ++-
 drivers/net/ethernet/sun/niu.c                | 10 +++++-
 drivers/net/ethernet/via/via-rhine.c          |  9 +++++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  9 +++--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  8 +++--
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  8 +++--
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  8 +++--
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  8 +++--
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 17 +++++++---
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  7 ++--
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  7 ++--
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 12 +++----
 17 files changed, 129 insertions(+), 64 deletions(-)

-- 
2.48.1


