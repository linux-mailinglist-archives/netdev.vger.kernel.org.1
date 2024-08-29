Return-Path: <netdev+bounces-123419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AAD964D20
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74F301C21305
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC21B78E0;
	Thu, 29 Aug 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDhkFIdQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E91B5EC9
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953425; cv=none; b=hOmwanJRVvRPbHLp1zbB0JluyZvRKuQjGfmWwbvHbMHwQQfUwsVHQ6w2bW9b7zIlgUU8klZaPw/DVRVTCvLCkMn2LXIYxShLqf7jSgFmleB7bBLitIJDawjA62zF7t73y7xsTpC2+xyqo1m3ZI4nniN5Sr0pTKeLTMrOBUVYP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953425; c=relaxed/simple;
	bh=YtAVGgmc3cYAyLF3AdkXqD0qM9L1beFagu1rfGApN3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYxQ9Cx/QOD5HPVektGEkS+XCU7e3ztQyr6wmeabNlnNYuWW3cTNtc3Bk9zvvMhEB8HE9FtgDM9YIUFFU2dxCj5rIUrx47B5mSWFP77+somnBmw3HEwcpswAiBIAX2QjdeTOYwMS0irQHVOsQz9MKmgMDVAXnnj7i/P0e2LqDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDhkFIdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83CDC4CEC1;
	Thu, 29 Aug 2024 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953425;
	bh=YtAVGgmc3cYAyLF3AdkXqD0qM9L1beFagu1rfGApN3c=;
	h=From:To:Cc:Subject:Date:From;
	b=ZDhkFIdQ4Ll+Q2AShIsuZixg3rowx+estC1730hDA1mW/4PxWNI3fEALGMtyIADGS
	 4zahUHb1EBuBG/KmEo1kqX1ps+0oCPmfW+MPUOdhDDgSNdeqkZHVoKiJXkidAw8k7B
	 hTtWB3pf8x5pzt37JKwWnRRIpXcBYVWGfm67SCjPwbq6OKYecPhXWAZGYwQMVUgrAq
	 ibbTchUqWVD06Yup5kCRyy/jsgPH0l5dCD9b3kP9u9zPWBZgn1CuLtmmuj/KGEDV/Q
	 AUh83MgubUwHxODwPmnL4qvPO2raexDBU1iocF8aVaO9A4sZrc3Ojr3oOCeLdYyqBz
	 3YP37XFWqv5ZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 0/2] net: ethtool: add phy(dev) specific stats over netlink
Date: Thu, 29 Aug 2024 10:43:40 -0700
Message-ID: <20240829174342.3255168-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are the half-baked patches I promised in:
https://lore.kernel.org/r/20240828133428.4988b44f@kernel.org/

I'm hoping Oleksij will take these over / forward.

Jakub Kicinski (2):
  net: ethtool: plumb PHY stats to PHY drivers
  net: ethtool: add phy(dev) specific stats over netlink

 Documentation/networking/ethtool-netlink.rst |  1 +
 include/linux/ethtool.h                      | 15 +++++
 include/linux/phy.h                          | 11 ++++
 include/uapi/linux/ethtool.h                 |  2 +
 include/uapi/linux/ethtool_netlink.h         | 15 +++++
 net/ethtool/linkstate.c                      | 25 ++++++++-
 net/ethtool/netlink.h                        |  1 +
 net/ethtool/stats.c                          | 58 ++++++++++++++++++++
 net/ethtool/strset.c                         |  5 ++
 9 files changed, 130 insertions(+), 3 deletions(-)

-- 
2.46.0


