Return-Path: <netdev+bounces-198382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C043ADBEC8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09FBB3B6E7B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1C62AD0D;
	Tue, 17 Jun 2025 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqXr+0Uu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE7647
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124761; cv=none; b=Jis+OBSPxZ0EPg58ARtN7ZG0EA9Ki7l9iIwiLy2vdiDOrEytPnlcJLHfjcw7Wza5AJOcoW6jBcUlZREPjQKTjGZ3vZWmgYaiEeggG/iSgXcCcTN7Ue0PVABbWcJM9pwFFPnaiwSaGa9SwI7erbfqnDfvtEC94wr+Vc7Rz+CX+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124761; c=relaxed/simple;
	bh=eCb5h2nC3xMJByO+qw1OCQYi/btW2p1P6H5pzPCQ+50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gk87LW+duw75xM36MPlno7K9ARHRqC93WL3++vEtN5ro4DdabYcZ5oZEQp5nh+EkJV042ZflgXgmYdc2TBjHHpY8mrzXFpCUmFf9nshEa3e3ppIDzNwvpm0HveA0f3YW9/OJ6k+ve0zquDmodDDy/r+sYWa9zqlWbHpfgvMef4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqXr+0Uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D9DC4CEEA;
	Tue, 17 Jun 2025 01:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124760;
	bh=eCb5h2nC3xMJByO+qw1OCQYi/btW2p1P6H5pzPCQ+50=;
	h=From:To:Cc:Subject:Date:From;
	b=MqXr+0UuGDXkeMVMRmYKcK8oiAPWP7DeK9SBKuuD7OfOlxH7NmWGZ4xbys3Iwl49M
	 KOMR3kkVwl0QaDiF4XrzRvvMc/qmSQqFjDDG/EEtw0GBoaFO1IWrlymrQoCjW6Xby5
	 5eef7v1q27ebUacQctNxUdPaEjd8n/VkH9wa5nPFlVwWOyGjyEp3GfqdabTh/QOSz0
	 MnrgUlxA/7PDjPpyWXybRAI93qh9g7TBWfkkyCjMc4rVTOc6eJjMiCWiqvfcMiKDDT
	 Dgy0rQUOzfwQD9v+fW+twlw4IRYGbkBKsUISUEG6rgI1ju5eXlXDySfK1ueP24hk+G
	 FvKLwNEi4CspA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shayagr@amazon.com,
	akiyano@amazon.com,
	darinzon@amazon.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] eth: migrate some drivers to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:45:50 -0700
Message-ID: <20250617014555.434790-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate a batch of drivers to the recently added dedicated
.get_rxfh_fields and .set_rxfh_fields ethtool callbacks.

Jakub Kicinski (5):
  eth: bnx2x: migrate to new RXFH callbacks
  eth: bnxt: migrate to new RXFH callbacks
  eth: ena: migrate to new RXFH callbacks
  eth: thunder: migrate to new RXFH callbacks
  eth: otx2: migrate to new RXFH callbacks

 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 40 ++++++-------------
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   | 33 ++++++---------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 24 ++++++-----
 .../ethernet/cavium/thunder/nicvf_ethtool.c   | 37 +++++++----------
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 31 ++++++++------
 5 files changed, 71 insertions(+), 94 deletions(-)

-- 
2.49.0


