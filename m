Return-Path: <netdev+bounces-177012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52FBA6D41A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 07:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB9F188E3E5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED1318E050;
	Mon, 24 Mar 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gh0sczaX"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9AC13A26D
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797149; cv=none; b=do6zwdJyRfdO7ATA+Hr25lkPRn7+zLT1Lk3zsGtQ6hOUTcAd7t16qU2SpNkOMZGP68TkouK4ZFmmsx39Vxthj4ckLLAtjCllFlonbOGim73rntjC8Z3o+igvym+N5kDOsmG3XG7zRxxEW+bnPPRuB9BT0++asdGViz9ULGHmnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797149; c=relaxed/simple;
	bh=WPfVgUlu27qSIWQm2FViHZyZ3KQmqfqCpubCZEFvcqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YrNWDMF6TEBeKq91onXvsllLxlpimjJNCgrzJthModqfHxeMXNixOIBfx4NjQQPjTzojzLLQmeuYSJJlFsCpKWg8FXozmmaoi2Ts6zkPdhHJD5jSi5DCZBRb9jhPjM22U40fFfryxv9wl2MTkHRMy8aZi1nkyxks6+6M/Uwz+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gh0sczaX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AAE21207B0;
	Mon, 24 Mar 2025 07:19:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mu-0GS0FXnFv; Mon, 24 Mar 2025 07:18:59 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7ADB620764;
	Mon, 24 Mar 2025 07:18:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7ADB620764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1742797138;
	bh=MvCMlHfT7nbz5NaCqH2ZhXMY65JIjNuPVDqFl2NPi8M=;
	h=From:To:CC:Subject:Date:From;
	b=gh0sczaXkfKsy5WNEaVKzp6/ucXQ4S5iq9ONOQRpHUli2iKPYgY08mKzgcCDjJB3r
	 Ijf0ITZOnFasVAvZwYfUiECuJBq8zcGZQjsgc03DDHYjUyrhBDbQW5KAHqDfy0Crj8
	 dEiYlOVxbXdc2+fjUIvfYluOy4Ri16/CXZIPucxDhKI8OkfzskaWPqYuypO1ojOEJn
	 uGxjOs7OeWyFd/8zVceQk0VFJaAV9Zn4TObo0atE3De2pn3CtOcf559nUuXEJKSkdz
	 2dsn6wmRNw2v60Ldm/KaKiuJCgAjpuSJiTOTIO9aOKQ+0TyxZKexDdOO5z9b35Yqku
	 k4W8WRm3urjBQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Mar 2025 07:18:58 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 07:18:57 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 756F63182BF8; Mon, 24 Mar 2025 07:18:57 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/8] pull request (net-next): ipsec-next 2025-03-24
Date: Mon, 24 Mar 2025 07:18:47 +0100
Message-ID: <20250324061855.4116819-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

1) Prevent setting high order sequence number bits input in
   non-ESN mode. From Leon Romanovsky.

2) Support PMTU handling in tunnel mode for packet offload.
   From Leon Romanovsky.

3) Make xfrm_state_lookup_byaddr lockless.
   From Florian Westphal.

4) Remove unnecessary NULL check in xfrm_lookup_with_ifid().
   From Dan Carpenter.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 4e41231249f4083a095085ff86e317e29313c2c3:

  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2025-02-11 19:51:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2025-03-24

for you to fetch changes up to 399e0aae5aab30f911098a0430204e9034ff78bb:

  xfrm: Remove unnecessary NULL check in xfrm_lookup_with_ifid() (2025-03-19 03:13:14 +0100)

----------------------------------------------------------------
ipsec-next-2025-03-24

----------------------------------------------------------------
Dan Carpenter (1):
      xfrm: Remove unnecessary NULL check in xfrm_lookup_with_ifid()

Florian Westphal (1):
      xfrm: state: make xfrm_state_lookup_byaddr lockless

Leon Romanovsky (6):
      xfrm: prevent high SEQ input in non-ESN mode
      xfrm: delay initialization of offload path till its actually requested
      xfrm: simplify SA initialization routine
      xfrm: rely on XFRM offload
      xfrm: provide common xdo_dev_offload_ok callback implementation
      xfrm: check for PMTU in tunnel mode for packet offload

Steffen Klassert (1):
      Merge branch 'Support-PMTU-in-tunnel-mode-for-packet-offload'

 Documentation/networking/xfrm_device.rst           |  3 +-
 drivers/net/bonding/bond_main.c                    | 16 ++-----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    | 21 ---------
 .../chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c    | 16 -------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     | 21 ---------
 drivers/net/ethernet/intel/ixgbevf/ipsec.c         | 21 ---------
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   | 15 ------
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 16 -------
 drivers/net/ethernet/netronome/nfp/crypto/ipsec.c  | 11 -----
 drivers/net/netdevsim/ipsec.c                      | 11 -----
 drivers/net/netdevsim/netdevsim.h                  |  1 -
 include/net/xfrm.h                                 | 21 ++++++++-
 net/xfrm/xfrm_device.c                             | 46 +++++++++++++-----
 net/xfrm/xfrm_output.c                             |  6 ++-
 net/xfrm/xfrm_policy.c                             |  2 +-
 net/xfrm/xfrm_state.c                              | 54 ++++++++++------------
 net/xfrm/xfrm_user.c                               | 14 +++++-
 17 files changed, 102 insertions(+), 193 deletions(-)

