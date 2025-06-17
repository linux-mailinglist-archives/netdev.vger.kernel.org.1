Return-Path: <netdev+bounces-198374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F852ADBE9A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDBA3ACD6A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756A918E025;
	Tue, 17 Jun 2025 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe+bOmRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B233993
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124397; cv=none; b=pQxIhWlkIPZUrq70uT7gIhBeUijXNVIeGN8JgVWS1oebfvJRnr+QnpYEoxhlhSG6u7Ogkc8MXcxDW0CsIDs7Rl7tw7DCIoVteYyKQJiYiVnFRZV0GhPc4LFilDHyFphI0T94U0s/+tcavBDr6Qgcse2PVUFo1/iMyVizmLyu5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124397; c=relaxed/simple;
	bh=1olH4n+uWFCMMqqo7FDstbBmN+whvo7bHLAujFXW8WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YleZVij/rwe42YlvXIHEACZcUgB0udSpnpXSFmZxftSU9ez8x8OnF1P4uDIjFtWQLHBzl64FI5/7GpD1TFmfQuFnzGvvn3vUw45GYmRg0cYdldFusCPusAeVav2N2tg21sjBGv4xCC9BU9q0RXKxyZKWAqVS7Pv/EGPEeaSgg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe+bOmRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC4AC4CEEA;
	Tue, 17 Jun 2025 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124396;
	bh=1olH4n+uWFCMMqqo7FDstbBmN+whvo7bHLAujFXW8WI=;
	h=From:To:Cc:Subject:Date:From;
	b=pe+bOmRq4UN4/iVq8UKM35VkgvEvjZeo79S29cBh+5WQxY3rEHqWEuRbceM4o3vds
	 0i8AeCdCbj/Yw7LzRZzkN8rh5ur/Ft0JYn9b6JS83VywFMHPkilct9c0y+1b6NS5oh
	 xDb9koFJ13Qm/7he4R5k6d5BVkPaMpgZ7vcweaG5gTpSQPrQ8hq3e0FO8pjMse0bvz
	 HWc8f1tbfGQO9sTVd2WtTibVuIBNPdTGqt7NJu11ps4pwy5mt44CJ8rL6gs+U3lzpe
	 kb2fdDC+HEFZCkW+HsYR6VfyAYiKpn9Sh/mQjcFmlydDtpRSUbeSreOXHnywABbnfn
	 BpP4fDjcmJomg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] eth: sfc: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:39:51 -0700
Message-ID: <20250617013954.427411-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate AMD/Solarflare drivers to the recently added dedicated
.get_rxfh_fields ethtool callback.

Jakub Kicinski (3):
  eth: sfc: falcon: migrate to new RXFH callbacks
  eth: sfc: sienna: migrate to new RXFH callbacks
  eth: sfc: migrate to new RXFH callbacks

 drivers/net/ethernet/sfc/ethtool_common.h     |   2 +
 .../net/ethernet/sfc/siena/ethtool_common.h   |   2 +
 drivers/net/ethernet/sfc/ethtool.c            |   1 +
 drivers/net/ethernet/sfc/ethtool_common.c     | 104 +++++++++---------
 drivers/net/ethernet/sfc/falcon/ethtool.c     |  51 +++++----
 drivers/net/ethernet/sfc/siena/ethtool.c      |   1 +
 .../net/ethernet/sfc/siena/ethtool_common.c   |  78 ++++++-------
 7 files changed, 130 insertions(+), 109 deletions(-)

-- 
2.49.0


