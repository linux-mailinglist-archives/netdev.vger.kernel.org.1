Return-Path: <netdev+bounces-113115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D893CAD3
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E911C21736
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106613E8A5;
	Thu, 25 Jul 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS4lu/ir"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4317E9
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946244; cv=none; b=I83L5IyruilLmAekmhB2Tr+WuMfrBnsQD+JeAkp02soTpnbhd0iJw49ya2CzjsvNGrfPGjTB2tOf/c0zAaIVYvcTb2NCPJ8mOqMqzthB7Rd9H+VPTjF7PmwYQfMzTDtMVBeo3NZ7tq8nTy1l4gAvSMUKU47PG6j2yrmxOrzD2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946244; c=relaxed/simple;
	bh=0q7h+3whQUnZ0Q9YK/JGSjF/d8RNup3SVWwMtVpFyuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgemQyT5nuAVa799uCjDd3aEqlGPyPwJluwGkGtamVQ+tkyTfAUBrZjb4z3F0zU1ivoamYkrIY31Ziwsxa0lnKSMznYVAgEYcxfWl/JB8uNfzASeDNyv5hcYGYu+4HrbMZG/5RgYzjk5iGIDggsL4l3dI/zRIC7NJl1mnK6aJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rS4lu/ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272C6C116B1;
	Thu, 25 Jul 2024 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946243;
	bh=0q7h+3whQUnZ0Q9YK/JGSjF/d8RNup3SVWwMtVpFyuM=;
	h=From:To:Cc:Subject:Date:From;
	b=rS4lu/ird1NmxmYiXh+utTY8ZRDJimZYgRRroPYzL4vG98Nbmn5R0uHZGm+f2DJcF
	 RnHP9gNqUgb0qajY+zOkL52SypKM0kECEYjnYzsV0HYZfXrJkdFF8V0oZBz+iIOKeV
	 eCnWq3rADtERAfc3X64KPqNk45Dv8SZ7TOJptp+2O/do2+Hdm+KtgZiOALY4B4b8xg
	 n64ARTXY+ooPiBAwNQlWvz9Tiq421WDGzuVlenItlHUgLc6F/KK/KYMbpp7HrO/wic
	 fPOXoVSToJU8S9ie6hxA2tLnpnM5sHtCVzrJ4yP7tIkci4Q2KVAp+IpKgnBhZ74XHp
	 byFj8FVB9K8uQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/5] ethtool: more RSS fixes
Date: Thu, 25 Jul 2024 15:23:48 -0700
Message-ID: <20240725222353.2993687-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More fixes for RSS setting. First two patches fix my own bugs
in bnxt conversion to the new API. The third patch fixes
what seems to be a 10 year old issue (present since the Linux
RSS API was created). Fourth patch fixes an issue with
the XArray state being out of sync. And then a small test.

Jakub Kicinski (5):
  eth: bnxt: reject unsupported hash functions
  eth: bnxt: populate defaults in the RSS context struct
  ethtool: fix setting key and resetting indir at once
  ethtool: fix the state of additional contexts with old API
  selftests: drv-net: rss_ctx: check for all-zero keys

 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 14 +++++-
 net/ethtool/ioctl.c                           | 43 ++++++++++++++-----
 .../selftests/drivers/net/hw/rss_ctx.py       | 37 ++++++++++++++--
 3 files changed, 79 insertions(+), 15 deletions(-)

-- 
2.45.2


