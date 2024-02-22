Return-Path: <netdev+bounces-74178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D88605C5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D8CB20BC2
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 22:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF117C62;
	Thu, 22 Feb 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3PNllXg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D112E40
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641399; cv=none; b=a9gf7h3YOoeEwTkVjKuQTcBMfqf+w8yrabfvfo7JipdyPeLVmYt9huVT4t2o7LJStq4QUt9y8PNE4hB5Z6YJm4gk/GD5q2XjNSrl5kAbvPrEpE7CCoCk08TlZSFxN+BUV/qg7UbLQSPSMRMycxz9hrf2H6Jj8eOawRHUgm3eBDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641399; c=relaxed/simple;
	bh=wmGu+77m/x4IApx65xqy8bhQ2h8S8m160mcgPBE5+aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Df+FxxbSfHq8gFfL3x/my/BaN8HZaSCv86+fW1VoHmRAi0ZeGrzFrVSgGIrY+mx+KJgE9AZT6e+VnvCmf3/ZqdGBqCD3wBK9kRWbXZna4IxuLkQz64w5VtqYD5VOef8RMiKsnq2bptpYxvRxEjjXejYXPFnY2gqVdU0to1krboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3PNllXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF901C433C7;
	Thu, 22 Feb 2024 22:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708641398;
	bh=wmGu+77m/x4IApx65xqy8bhQ2h8S8m160mcgPBE5+aI=;
	h=From:To:Cc:Subject:Date:From;
	b=A3PNllXgE9SXPvqUBuwPr+L1dgxHiE6pp6on/fL0/iRvprBfeaSHfk78lfetTdmi1
	 sh36MQqo782xiiW61raqNxpIVKskhwG4IFnV0xI8nmYKRThRdotmUrwWPKlayJuuWa
	 ZUDCuj6L6xONl40DwSVHB7LpjIWeNtjvbWuxOQi/ZRdBYPlXF1YLT3ko8OMFotADkH
	 DA/CgmuxSAxPrh7ZRVHYUfzzrFfnLfI+XinqEgH638rBn6TEzfExvyk4wHKddMtvGH
	 sr0gMasAQRQdHvGXKa+O/K7zV5MfUegSz9H2mavUootuPPqkQ33Q8tsdGBOG141Wwt
	 HeilfOXtPO3wA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	danielj@nvidia.com,
	mst@redhat.com,
	amritha.nambiar@intel.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 0/3] netdev: add per-queue statistics
Date: Thu, 22 Feb 2024 14:36:26 -0800
Message-ID: <20240222223629.158254-1-kuba@kernel.org>
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

Jakub Kicinski (3):
  netdev: add per-queue statistics
  netdev: add queue stat for alloc failures
  eth: bnxt: support per-queue statistics

 Documentation/netlink/specs/netdev.yaml   |  91 +++++++++
 Documentation/networking/statistics.rst   |  17 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  63 +++++++
 include/linux/netdevice.h                 |   3 +
 include/net/netdev_queues.h               |  56 ++++++
 include/uapi/linux/netdev.h               |  21 +++
 net/core/netdev-genl-gen.c                |  12 ++
 net/core/netdev-genl-gen.h                |   2 +
 net/core/netdev-genl.c                    | 219 ++++++++++++++++++++++
 tools/include/uapi/linux/netdev.h         |  21 +++
 10 files changed, 504 insertions(+), 1 deletion(-)

-- 
2.43.2


