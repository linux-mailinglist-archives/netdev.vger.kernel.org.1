Return-Path: <netdev+bounces-165241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D599A313CE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3067A0F47
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380E1E3793;
	Tue, 11 Feb 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX2fQoJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4227261593
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297642; cv=none; b=B4beBHEFlMRjHCZyVivUmcz+YTAU+sjMiylXYwQe2C+ycbWRctV1HsuKy+3ELFXVMCKaw7MdwJFrjjL1iUrHGgeL8WYUugU+ybZwyqnsvEDjLU5B+CIar9ShOAiZB0jo++g7/lFpEZEc37/zRlp+ZVzQSC7rGLAhHg2UQEAZE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297642; c=relaxed/simple;
	bh=lTdXUi/gs6nCqWHaPtyimuwgqhiDTgdiKRw9C5UV3sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4Z6x6z0SjxJQ9HfdozTN08tEYa6uzcSdSl5Xh0CPDUhrbZGBT/XltPU5DVqa7YX/12BM6DH6nFZ6z9IO4DWDQktwnNdMpdnVI53l8ZZWx127D3FLgj2m+3Y+K9ntwOB/f8Fn8ap750U/CKDRASZlnGwLIQM5slftfw59QAiabk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX2fQoJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBEBC4CEDD;
	Tue, 11 Feb 2025 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297641;
	bh=lTdXUi/gs6nCqWHaPtyimuwgqhiDTgdiKRw9C5UV3sE=;
	h=From:To:Cc:Subject:Date:From;
	b=AX2fQoJwMGvw92F91jbatYLG3QbypszFrRFhE3SybW6u6J0flq6j73UukXSes+awK
	 YS/ceirOWszAf7K4yqxqDKuc6iw0eRwrVY8E2QRF2MPnBz3QHm1722DA5JrR/MW4a/
	 VElqu2OJPalolpBUDle/iBUd6BqrWtbZ1v9/LqDMlgE8L6Mv14S4Gm65DuB1XK7ouS
	 DbB9M1K65Yi1ur48nTiwPS0UJj3Ge1tz3nrJr10c0fqHVIa4Y5Jzn5re5lDBqqVoa2
	 +rlft94qqbge/prbXMHi9x9col84efFmBTgtMtz4fOWZXYjNn4sWuIX75SNzULhTfn
	 R5u+a74n68PnQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: alexanderduyck@fb.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] eth: fbnic: report software queue stats
Date: Tue, 11 Feb 2025 10:13:51 -0800
Message-ID: <20250211181356.580800-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill in typical software queue stats.

  # ./pyynl/cli.py --spec netlink/specs/netdev.yaml --dump qstats-get 
  [{'ifindex': 2,
    'rx-alloc-fail': 0,
    'rx-bytes': 398064076,
    'rx-csum-complete': 271,
    'rx-csum-none': 0,
    'rx-packets': 276044,
    'tx-bytes': 7223770,
    'tx-needs-csum': 28148,
    'tx-packets': 28449,
    'tx-stop': 0,
    'tx-wake': 0}]

Note that we don't collect csum-unnecessary, just the uncommon
cases (and unnecessary is all the rest of the packets). There
is no programatic use for these stats AFAIK, just manual debug.

Jakub Kicinski (5):
  net: report csum_complete via qstats
  eth: fbnic: wrap tx queue stats in a struct
  eth: fbnic: report software Rx queue stats
  eth: fbnic: report software Tx queue stats
  eth: fbnic: re-sort the objects in the Makefile

 drivers/net/ethernet/meta/fbnic/Makefile      |  3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  | 16 +++-
 include/net/netdev_queues.h                   |  1 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  8 +-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 22 +++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 74 +++++++++++++++----
 net/core/netdev-genl.c                        |  1 +
 7 files changed, 102 insertions(+), 23 deletions(-)

-- 
2.48.1


