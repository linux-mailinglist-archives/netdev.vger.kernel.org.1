Return-Path: <netdev+bounces-75989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D591E86BE07
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 02:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129FB1C230AB
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECD20335;
	Thu, 29 Feb 2024 01:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPa6nekU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3C57875
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168569; cv=none; b=TohqirS3G/t9XxlD5J3vUuQYMF1pawOgPA6Q6ZqW+EPZ6NEW4+mJD2VYIh2C+yuva3agefuZL1HH6rUV6ju2eguHF3TX18sU53F91m3xCKfWsEJlRKZfTWn+GNu/aLxz9wTmXQA3GRRj4vJ9Ywma+ZB5Apf3c7BDRv1gK62euJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168569; c=relaxed/simple;
	bh=HLhRST1R6UgMefi+QxgsvhoHO03X3X9khmxh+AEsZdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQ6Cv7CfCaNbNdxTsIV/ofMP77SaDU3EtWMWRcIY1rO8sDm4EjFWaA9epoTfop08ujZP8Ra721GiGtVid5aR7xZqJ42GTQRdajxGziE1ZL5vYMNWwRUpgGIRceT5inLQG5RgCUoteKf5kdcxdu5havMw5Gq3iLBvTuE1jjyUVz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPa6nekU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2717EC433F1;
	Thu, 29 Feb 2024 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168568;
	bh=HLhRST1R6UgMefi+QxgsvhoHO03X3X9khmxh+AEsZdQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LPa6nekUu1LSZTXijjZt9ajsBod42bxfRzuTCSfWwRJJWq1QwlldzMIwkKSow7D5N
	 F+YgvXRgNY5oYXL+cW6ZJCbn6Dgl+oIWcDTqwAhMz03Zccx04QdbmM/b1MW9qc6u3Z
	 8sSMhiI0RNOodd8QFCu5jc0/n0mxhvvt0iS6t+S/R0ES1BqAkPV6V7qC9Ym0MAmsih
	 3ygBKWUpQjLRPywLqm3V4YDaE+B0v27hwQDcCglbRgq9etvTvmcf8dJzJP6Jx/y5FU
	 zQ0TgSojcxrc9j0vuNpHO2ytMD8lLzRHX5ECSy3Tibmy/JCXNjYGVQ1IKVxA7DNvzu
	 BPUXVliq3P8MA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	amritha.nambiar@intel.com,
	danielj@nvidia.com,
	mst@redhat.com,
	michael.chan@broadcom.com,
	sdf@google.com,
	vadim.fedorenko@linux.dev,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] netdev: add per-queue statistics
Date: Wed, 28 Feb 2024 17:02:18 -0800
Message-ID: <20240229010221.2408413-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Per queue stats keep coming up, so it's about time someone laid
the foundation. This series adds the uAPI, a handful of stats
and a sample support for bnxt. It's not very comprehensive in
terms of stat types or driver support. The expectation is that
the support will grow organically. If we have the basic pieces
in place it will be easy for reviewers to request new stats,
or use of the API in place of ethtool -S.

See patch 3 for sample output.

v2:
 - un-wrap short lines
 - s/stats/qstats/
v1: https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
 - rename projection -> scope
 - turn projection/scope into flags
 - remove the "netdev" scope since it's always implied
rfc: https://lore.kernel.org/all/20240222223629.158254-1-kuba@kernel.org/

Jakub Kicinski (3):
  netdev: add per-queue statistics
  netdev: add queue stat for alloc failures
  eth: bnxt: support per-queue statistics

 Documentation/netlink/specs/netdev.yaml   |  91 +++++++++
 Documentation/networking/statistics.rst   |  15 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  63 +++++++
 include/linux/netdevice.h                 |   3 +
 include/net/netdev_queues.h               |  56 ++++++
 include/uapi/linux/netdev.h               |  20 ++
 net/core/netdev-genl-gen.c                |  12 ++
 net/core/netdev-genl-gen.h                |   2 +
 net/core/netdev-genl.c                    | 217 ++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |  20 ++
 10 files changed, 499 insertions(+)

-- 
2.43.2


