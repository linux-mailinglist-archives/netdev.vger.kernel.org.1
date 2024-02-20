Return-Path: <netdev+bounces-73353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1685C0CB
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50811C2313C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F71762F5;
	Tue, 20 Feb 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq25Izjr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5743C762ED
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445478; cv=none; b=BbM8knttNOB0qPnwkdUzgPFFwdBr6BXYJD41svrumHHJuZe3lwz5+Jc5YWhZbH2xtlL94FeVUeHLixlvMyLNx3CFlkMVgFvemc4PeSDo+tJBtQfOI7AGQHLMK1hW4pOYcIkVwMiDArAupZhewiMEHZcedsbFrJr8SgAPoeed2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445478; c=relaxed/simple;
	bh=FLBsyzuiSWvkc4ONGdPa4cw2aU0MjxbHp/ZNKXVK2n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gjHwkXnbbhKKbHYn/oW819zgWfIgEwi8pUfnpaduHAhm+m2kpJobiJ53lX+YaZ4F9aFegFjhZJO765OugAOHT31dqCc6cMV/Y6e2YPZHpa4oQNqRT/r7xuMfuPdiEn0y5b4kqmwUx7ItvFlMZwxTzjQVCRpNN7SDjCjjtyPJbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq25Izjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76035C433F1;
	Tue, 20 Feb 2024 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708445477;
	bh=FLBsyzuiSWvkc4ONGdPa4cw2aU0MjxbHp/ZNKXVK2n0=;
	h=From:To:Cc:Subject:Date:From;
	b=Hq25IzjrnqLkEoCj+IQjtfFGC6j5w2ZAUNf2hXbdGCbD+cMZtk12PQI/vrZyTVcbP
	 XPM0EPdhU0UoYhNrs28Ufq3sEtYup8cNiZA/LPSxlraCpshVRDE1oKKIuEiNBWO2eA
	 wkkdxN+pyPvmpFKGiRmxKDcmr2dPnhICByh97AAlokwaE9NvhFTonXmHKH9KCPFRI5
	 yplt2T31BfBjddE22eVM09p69Y1Sk/1ussKmrhQxxmN6y1TwlDfU27EAGZ3+ILeRx6
	 EJgZE4uj1bb4Ru4czXiE5inED0Uco8Nu3Tx0VEKGjxVWgBEfiSZwyVisE5P8YYJIKR
	 wJuk43txjl+Wg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	chuck.lever@oracle.com,
	jiri@resnulli.us,
	nicolas.dichtel@6wind.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/2] tools: ynl: fix impossible errors
Date: Tue, 20 Feb 2024 08:11:10 -0800
Message-ID: <20240220161112.2735195-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix bugs discovered while I was hacking in low level stuff in YNL
and kept breaking the socket, exercising the "impossible" error paths.

v2:
 - drop the first patch, the bad header guards only exist in net-next
v1: https://lore.kernel.org/all/20240217001742.2466993-1-kuba@kernel.org/

Jakub Kicinski (2):
  tools: ynl: make sure we always pass yarg to mnl_cb_run
  tools: ynl: don't leak mcast_groups on init error

 tools/net/ynl/lib/ynl.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

-- 
2.43.0


