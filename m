Return-Path: <netdev+bounces-52932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443A8800CAD
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E37B1C209C8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA093BB49;
	Fri,  1 Dec 2023 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/RE8CeW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D83B2B5
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 13:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76398C433C9;
	Fri,  1 Dec 2023 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701439088;
	bh=bmKt3T6VK+xPRY0AP3gFwp5PeiaEoaKCxMLlbdXdQv8=;
	h=From:To:Cc:Subject:Date:From;
	b=s/RE8CeWHkQ2J8TT7L78h229S7RYcj/IKdqtqENR9fuQ1WJ0LV2gn0O47SrTSkzAR
	 k2QJfsCEdvYEzPgppZfZ3fzvRazdxZ1wDgk4+3JKixNJxoUXecK81++YQPsta+1DI9
	 i18/yiZ/n+QcYOua23dM+MCTqchFd1fXcr9L6kBOszy+cFSGJ1cDWSqxPDnPNHpIE1
	 iDxb7b7fq4IhqEWw02cut0xr+fY7Egi55I1fqTUNh6Lz75njzczH/WsHiGS3gNolke
	 BDA2NAHVmucR2GZJjyz0M8vmqyP4rDoJoGoklJIz3lIy8DCP/gOJ3HS3P6P4IG3Yps
	 MvUgXbsy1RQQg==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH v7 net-next 0/8] net: ethernet: am65-cpsw: Add mqprio, frame pre-emption & coalescing
Date: Fri,  1 Dec 2023 15:57:54 +0200
Message-Id: <20231201135802.28139-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series adds mqprio qdisc offload in channel mode,
Frame Pre-emption MAC merge support and RX/TX coalesing
for AM65 CPSW driver.

In v7 all kselftest issues with ethtool_mm have been resolved.

Changelog information in each patch file.

cheers,
-roger

Grygorii Strashko (2):
  net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
  net: ethernet: ti: am65-cpsw: add sw tx/rx irq coalescing based on
    hrtimers

Roger Quadros (5):
  net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
  net: ethernet: am65-cpsw: cleanup TAPRIO handling
  net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
  net: ethernet: am65-cpsw: Move register definitions to header file
  net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge
    support

Vladimir Oltean (1):
  selftests: forwarding: ethtool_mm: support devices with higher
    rx-min-frag-size

 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c   | 236 ++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  64 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.h      |   9 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c       | 705 +++++++++++++-----
 drivers/net/ethernet/ti/am65-cpsw-qos.h       | 183 +++++
 .../selftests/net/forwarding/ethtool_mm.sh    |  37 +-
 7 files changed, 1057 insertions(+), 180 deletions(-)


base-commit: 15bc81212f593fbd7bda787598418b931842dc14
-- 
2.34.1


