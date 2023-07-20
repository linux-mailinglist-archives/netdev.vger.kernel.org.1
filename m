Return-Path: <netdev+bounces-19302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A575A3B8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FC91C2123B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 01:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279EE642;
	Thu, 20 Jul 2023 01:04:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F2621
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2A3C433C7;
	Thu, 20 Jul 2023 01:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689815055;
	bh=0iZLUrddtorlJ3xYa9bTeAxGilbcLWvuQsScg+GCdgU=;
	h=From:To:Cc:Subject:Date:From;
	b=IaN26gar+DigODnE0oc7VpH1OOdvkzHUhzbEx8frvnL1Et/JqBtm5atrcnGIn42kW
	 FpQaNyRZu0qzXV1d02+TVJKTMNcNXwHKTfTD8mWlq+mEjFS357runw5zZbC+pfTMQf
	 TF8E95LbXBPeB6+r2zSpSNCQnkSctDZhr31nmDYlYDcnx3bt2BdNDZSszNCjsWemfW
	 ydWD5GhaEv/nrL4cob90EDGHQNKdxQUQebuQzDMmCoT3AxbQnBKR9XIogwCqVqavW2
	 kcB5b3WVPHAqiIy2vBMLKcIrN5sR4uWuUIPhq+JhV8zProDrjzmiUUdH859538ME1P
	 6+Yx5iaUAdsdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] net: page_pool: remove page_pool_release_page()
Date: Wed, 19 Jul 2023 18:04:05 -0700
Message-ID: <20230720010409.1967072-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_pool_return_page() is a historic artefact from before
recycling of pages attached to skbs was supported. Theoretical
uses for it may be thought up but in practice all existing
users can be converted to use skb_mark_for_recycle() instead.

This code was previously posted as part of the memory provider RFC.

Jakub Kicinski (4):
  eth: tsnep: let page recycling happen with skbs
  eth: stmmac: let page recycling happen with skbs
  net: page_pool: hide page_pool_release_page()
  net: page_pool: merge page_pool_release_page() with
    page_pool_return_page()

 Documentation/networking/page_pool.rst            | 11 ++++-------
 drivers/net/ethernet/engleder/tsnep_main.c        |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  4 ++--
 include/net/page_pool.h                           | 10 ++--------
 net/core/page_pool.c                              | 13 ++-----------
 5 files changed, 11 insertions(+), 29 deletions(-)

-- 
2.41.0


