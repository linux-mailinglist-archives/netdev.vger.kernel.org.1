Return-Path: <netdev+bounces-107428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B227191AF5B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E631C209A2
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB319A28B;
	Thu, 27 Jun 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCuQ9QUl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89AE22F1C
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514504; cv=none; b=B1uZOr7okCeFFFx0nGC1KpYjEfRWauceVTlgoszEJVu99HsE2wNXtCGm2SPRy4A4Ml+W3Jbqhndr0+53K7vgmwK8oPDyHwwRm+jLgqB/LlxrdHdoeWG/y/4JJB04xWveakbbY4sOL3X4cw3SvI3H7gFKIRGJY+hShqrQFixiXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514504; c=relaxed/simple;
	bh=rQ+uWBlxQCIcR/1pjmh4K7+b0rOFTSIBzNZlL9uE4Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HX8krqUzcgQ6yg6h9LGPVy5r5JeaqFsfggaxXvXCjxyYgJPts3Jb9oZfhw+IWDFdJ52xICE1xaWXKAIIW3/LAXTtrsCnr1+U8HR6vO1piqyr6ZFnhYPwdSFLE6BatWOwSDP2LhVS3A7Soxtcmxj7YPhMjUr9wRwGDEOhnYAmFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCuQ9QUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259E1C2BBFC;
	Thu, 27 Jun 2024 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719514504;
	bh=rQ+uWBlxQCIcR/1pjmh4K7+b0rOFTSIBzNZlL9uE4Wk=;
	h=From:To:Cc:Subject:Date:From;
	b=VCuQ9QUlJ69oc2JxEwqtJH6Xw78lvZlpiLe/2wnMcStxJ4CE779yjnnhRPWc5k4wy
	 grLXHFg3mAgxcYw4npbxGess36MSeq2epMM76Zd6d0tKtLVHtTcq9R2kpBC35XcB08
	 XvEeeu4mJQhf6Uk7ObfxVsvk85yFFzW8KSvzagUaaqYXGbdAw1MT7im3vEZHlRtpuD
	 q3vq3TWJgwHfKEMTCZ5QPKZb6fvmc3EH6cLEFIxjuXTIBtROETWKBrGC6zCCB1XHZ3
	 KAyhL7apzAYd4vP9BHu3Hp7kP2sDZm+oh1scmXud6w69KtKkjMoTTq+7f/kiIh02mI
	 G6EG2Y/OBfKNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] selftests: drv-net: add ability to schedule cleanup with defer()
Date: Thu, 27 Jun 2024 11:54:59 -0700
Message-ID: <20240627185502.3069139-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a defer / cleanup mechanism for driver selftests.
More detailed info in the second patch.

Jakub Kicinski (3):
  selftests: net: ksft: avoid continue when handling results
  selftests: drv-net: add ability to schedule cleanup with defer()
  selftests: drv-net: rss_ctx: convert to defer()

 .../selftests/drivers/net/hw/rss_ctx.py       | 225 ++++++++----------
 tools/testing/selftests/net/lib/py/ksft.py    |  49 ++--
 tools/testing/selftests/net/lib/py/utils.py   |  34 +++
 3 files changed, 167 insertions(+), 141 deletions(-)

-- 
2.45.2


