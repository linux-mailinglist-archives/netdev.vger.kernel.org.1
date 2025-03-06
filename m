Return-Path: <netdev+bounces-172471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C46EAA54E40
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 15:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE8D7A35D5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3A817C224;
	Thu,  6 Mar 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8xptich"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63A316DEB3
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272715; cv=none; b=fPiY8quYhDpuBAzpTersRCEBjViLROJGjZyq6gSnX0p4TyrH/tgvZL3iVX4IxcRZ7iG6ZYitVp+ZC0WT5MLNazFnEjusG9E6ff+VelthGn9jMF78Gjc5rzreMwHMh5RwEo/DnScocvs3Gz1DnclNEcjuf4Du6P8f0VV4zUDzduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272715; c=relaxed/simple;
	bh=edpNopC4bkjF0yRq3sDwRvxEyUukOzkHniNXyMaTy7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlwqhQ2cWhkJ0YF1Y2fokHCRjOUUB1SszcYsF+0rs34RynYvViJbYsihA8ALeXFmGqwmy3/VWPEzMrVFS3Q+ehRExUHQxZDZOVlHXfwyiDen7U5OSMSMJxcPGuwNBnDzXDXkgOhalasOAHaudZJgXkuM0t5LWUG272XYn+5VdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8xptich; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD1DC4CEE0;
	Thu,  6 Mar 2025 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741272715;
	bh=edpNopC4bkjF0yRq3sDwRvxEyUukOzkHniNXyMaTy7E=;
	h=From:To:Cc:Subject:Date:From;
	b=P8xptichmsSX/I6InPITOtiRldcO7jWOSa8NNYjmC2/gx3DoheKdvmlQCHJrEEBe0
	 FNSTZMzNNFkO7Ov/yHLmBzDKSfmCQpLsjoiqIwZgTtHxapvdG4pjVa1hIaIQzQ1uST
	 8vkghVj7NSJqjKz+bEeSNFHdm8qqgMwVMk55oLw+ouEzH5QHESKzyL21ONhjeG83RV
	 7oBVlc6APgwrUyMiWIymYcnZHjm+w9Htd2hm8zcwu+AKBsRFVc0LlrxWjeBKBRSOxG
	 J3q3MtR2sJgbhLzKeGe0PhvLN+s56/RdEN49iSqrWEs3BuyXVcqybPt0Kv0mFPJg6p
	 IIMFuIYzHCXKg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] eth: fbnic: support ring size configuration
Date: Thu,  6 Mar 2025 06:51:47 -0800
Message-ID: <20250306145150.1757263-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support ethtool -g / -G and a couple other small tweaks.

Jakub Kicinski (3):
  eth: fbnic: link NAPIs to page pools
  eth: fbnic: fix typo in compile assert
  eth: fbnic: support ring size configuration

 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  13 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 109 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   6 +-
 3 files changed, 126 insertions(+), 2 deletions(-)

-- 
2.48.1


