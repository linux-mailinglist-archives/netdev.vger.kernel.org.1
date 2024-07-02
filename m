Return-Path: <netdev+bounces-108627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29237924C52
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 01:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D681C215BC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 23:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537A156F39;
	Tue,  2 Jul 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkebBm5A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D271DA312
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964100; cv=none; b=jDpvoiuS9NEDXhJb7YV+jd0mqFJqLoiKz4LPulUA9RxXiYa7Uksk+N9T5RuE1zKe+3/xTkEVUHnTl0ZqY3CFQS6LuYkXRxOD1h4bYiDM+CRPfti5FgTGamgMm9KIwerkLJHzBxtaZgy2XXd+K/JdZCBUIYNqiulcPiHIuYc85HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964100; c=relaxed/simple;
	bh=Y9u/Tuwuq85Le62pMyuBRSsIIBQ+SeIn+1hg6iDPA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iPRwPiT+Q2+H5EfHqTimoE+P5ZAuvXnQU2laARDZkZhHU23hFkWsQ5DW27QEOOs/jRrsEOsabQwaXQOXsRYPvOg2WjcRpMBiJ/0LAVEy9C3m9S3aC7s0BXT/kOERcnK8zjO3ZHJ6XVjwaLBK4ahc5cKZGVWV6iUzKKvHl8l43F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkebBm5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E05C116B1;
	Tue,  2 Jul 2024 23:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964100;
	bh=Y9u/Tuwuq85Le62pMyuBRSsIIBQ+SeIn+1hg6iDPA8g=;
	h=From:To:Cc:Subject:Date:From;
	b=VkebBm5AshI+TD9vXzjcX8xLZJfxJmFWObBdt4N29IEOPUsv8SbwvQIXV5DTzujB0
	 ZbkQrzHDtFBbCuMLAIfADAJ2MFaxWzH3nwkWb3fLELSWpQggisy5sqCnWVRwmQw1A5
	 4uZ01KVQAPKvfJy4KpuHP+CXgDTKfEc0j3ooH7IxeHdPVSkad5EtWRXs3L5RWuWM/f
	 9qzy1N5EZMMft9qi1ouEGIWXQNFAAh9DvyVo9ODih0o0QQopgQzXZ5PEKupTrbvOdc
	 JluSttFqNQyeAKjPv5JZJDP2OUPulLd8SqrRctRL1hRQrIGw2nJVojb1sGmKeIRbod
	 FLzxNGSD20UlQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/11] eth: bnxt: use the new RSS API
Date: Tue,  2 Jul 2024 16:47:45 -0700
Message-ID: <20240702234757.4188344-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert bnxt from using the set_rxfh API to separate create/modify/remove
callbacks.

Two small extensions to the core APIs are necessary:
 - the ability to discard contexts if for some catastrophic reasons
   device can no longer provide them;
 - the ability to reserve space in the context for RSS table growth.

The driver is adjusted to store indirection tables on u32 to make
it easier to use core structs directly.

With that out of the way the conversion is fairly straightforward.

Jakub Kicinski (11):
  net: ethtool: let drivers remove lost RSS contexts
  net: ethtool: let drivers declare max size of RSS indir table and key
  eth: bnxt: allow deleting RSS contexts when the device is down
  eth: bnxt: move from .set_rxfh to .create_rxfh_context and friends
  eth: bnxt: remove rss_ctx_bmap
  eth: bnxt: depend on core cleaning up RSS contexts
  eth: bnxt: use context priv for struct bnxt_rss_ctx
  eth: bnxt: use the RSS context XArray instead of the local list
  eth: bnxt: bump the entry size in indir tables to u32
  eth: bnxt: use the indir table from ethtool context
  eth: bnxt: pad out the correct indirection table

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 115 +++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  14 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 159 ++++++++++--------
 include/linux/ethtool.h                       |  25 +--
 net/ethtool/ioctl.c                           |  46 +++--
 net/ethtool/rss.c                             |  14 ++
 6 files changed, 201 insertions(+), 172 deletions(-)

-- 
2.45.2


