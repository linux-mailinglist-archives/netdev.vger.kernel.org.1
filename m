Return-Path: <netdev+bounces-160438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D87FA19BE1
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 01:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285A7188B74F
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE24C6D;
	Thu, 23 Jan 2025 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7dIVqKz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8928746B8
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593124; cv=none; b=lkqTTDRKqZ152Fpu7aIcIyMxuZJZnBUn/RaGoGR+C7zk8myMqySWQ9jRtRM0C1QxdW+lTVFd5odMDMHJXS0lnyDRX8zRyQEyLWStP0b4mlJ+qluGygn67W+buyq0QR0PMKhyuVd3QHDW0iS+muUiGOYDjQNwz9QXGqxX+Exv+hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593124; c=relaxed/simple;
	bh=VEuzaTQf6fczz5nMhzIxRdr9jlJDslcTvJgwsLqbS+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5CzDaljFTFDjtGFDFM8aPyoQ3zeEBLNjEJBmp+tnaJP6NsRAPDIPTEkIDi/6cIUgW8lZGxuEW+nsdFmCbCuQUK2Vc2yOnBiVkZNQ2Kpq2CL1sP/mMivFoBx8PcZ14cuT0CSvW2hYXWEAmXF46v4Z/1n7Spgvq7UCZZbaiqCvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7dIVqKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC21C4CED2;
	Thu, 23 Jan 2025 00:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737593124;
	bh=VEuzaTQf6fczz5nMhzIxRdr9jlJDslcTvJgwsLqbS+o=;
	h=From:To:Cc:Subject:Date:From;
	b=V7dIVqKzQLX+p8h7eBrGwV+rcBDjwB9Y7td8h4OID1l/ncodFRN0pj8yARI9Jvo+L
	 I73KPw2nFs3jZNLqUD/mSZdRsiWhksiTCdED/F0Z3QqoNWs9o6sdD4g5b1XIemVL4L
	 lKZ7PBw8iY0/TqGUF2cTndaCejkcxgfnswEAZPgY8lDM2IsndtiPqPl/oqhOv038D2
	 Rn4BuzLPPl6eq0FBIAoGJMIBvYu3K/8sqGxmO8bzbeE4pmi1Byg8mq/A39emPNPdDd
	 QbPBlCBOz3x1bnR8Y0zn8eH/W1jtL6YktOx3jAs/w3iK+0afQTC95RXj3JjeSwy4F7
	 gXLWeAOrSSBoA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dan.carpenter@linaro.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/7] eth: fix calling napi_enable() in atomic context
Date: Wed, 22 Jan 2025 16:45:13 -0800
Message-ID: <20250123004520.806855-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dan has reported that I missed a lot of drivers which call napi_enable()
in atomic with the naive coccinelle search for spin locks:
https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanley.mountain

Fix them. Most of the fixes involve taking the netdev_lock()
before the spin lock. mt76 is special because we can just
move napi_enable() from the BH section.

All patches compile tested only.

v2:
 - [patch 1] correct commit msg (can't sleep -> needs to sleep)
 - [patch 1] add re-locking annotation to tg3_irq_quiesce()
 - [patch 6] actually switch to napi_enable_locked()
 - [patch 7] reword the commit msg slightly
v1: https://lore.kernel.org/20250121221519.392014-1-kuba@kernel.org 

Jakub Kicinski (7):
  eth: tg3: fix calling napi_enable() in atomic context
  eth: forcedeth: remove local wrappers for napi enable/disable
  eth: forcedeth: fix calling napi_enable() in atomic context
  eth: 8139too: fix calling napi_enable() in atomic context
  eth: niu: fix calling napi_enable() in atomic context
  eth: via-rhine: fix calling napi_enable() in atomic context
  wifi: mt76: move napi_enable() from under BH

 drivers/net/ethernet/broadcom/tg3.c           | 35 ++++++++++++++++---
 drivers/net/ethernet/nvidia/forcedeth.c       | 32 ++++++-----------
 drivers/net/ethernet/realtek/8139too.c        |  4 ++-
 drivers/net/ethernet/sun/niu.c                | 10 +++++-
 drivers/net/ethernet/via/via-rhine.c          | 11 +++++-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  9 +++--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  8 +++--
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  8 +++--
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  8 +++--
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  8 +++--
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 17 ++++++---
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  7 ++--
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  7 ++--
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 12 +++----
 17 files changed, 132 insertions(+), 65 deletions(-)

-- 
2.48.1


