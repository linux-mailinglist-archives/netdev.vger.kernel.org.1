Return-Path: <netdev+bounces-126479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB89714B1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D48282285
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 10:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3491B3F29;
	Mon,  9 Sep 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fBhH0kFv"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6D31B2519
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876220; cv=none; b=dpPV7WXWHDS9f2r5kzVcUwm1EtT/i7PduFY6RZvpprYxjhC4XBtsX0PG9YMf9u7XPb7kaln5y6L2Gfy/7ie+LTLpUFclnk0s7kto52ITGvNISau6Ad5f8dTeKWNBx/fTjrDqdp3klYCp+H08a2Sk+M9fMyeWJreTIOMKwcB4ggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876220; c=relaxed/simple;
	bh=A8ogJ+ZwACsjZ89+WM638Qq4rglf5p3rGl8TqfghcQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kDp2K0FtXB8wDcPkyHHhGF1Aha+k3qF0vMPgPvWDh3SIECulTiQyrptPH7RjGd+3BdlR8lmqG3fSF1we8EhW3JnOiISl3esdRz0aFrFOHEiz1qHfzHHQSIZOY+ZQ2ZI5BbGj3Ek9X0IHkwBzYX5aa6tNZosnRHJpn4NrVjLS7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fBhH0kFv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id AD71E20872;
	Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJ1OZOp4RoG2; Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 02B802083E;
	Mon,  9 Sep 2024 12:03:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 02B802083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725876215;
	bh=efnvwcR0lq7RRryxUvoNPEAEvBl7pmwQAg2hUyTAd20=;
	h=From:To:CC:Subject:Date:From;
	b=fBhH0kFvccTtpsGbqRlYQds49j61POG6a6vjDfHbCUh60JVQ8nlNi5/XWI8pUB3Bt
	 4DD6SBBoJ+M/GfpAiMCnHSewUrp6+ZgHBqd/5N8pEcADCMPBpIUAFzz+bdEdbuGaB5
	 VxCrE77S9S7wIBHSb1QZB2CF4TGQymPP33hAkP5H+SZL8mGuFfzytkaOEBFoA7P4fe
	 Bg+KSM5HQ/jt31EYkiC+UYe4s5KBcPcsU5jO9Y2JC5xlSRQ/M/o04tgNETCRquNyOW
	 6qMnZ5aDRDtAdsWaDgx7CipYGtXaLpuDRjw8EMkByS1uXaJL0dSxxtTujxBGBi3aVt
	 lUbGAPMkU7jrg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 12:03:34 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 12:03:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2056B318297D; Mon,  9 Sep 2024 12:03:34 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/11] pull request (net-next): ipsec-next 2024-09-09
Date: Mon, 9 Sep 2024 12:03:17 +0200
Message-ID: <20240909100328.1838963-1-steffen.klassert@secunet.com>
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

1) Remove an unneeded WARN_ON on packet offload.
   From Patrisious Haddad.

2) Add a copy from skb_seq_state to buffer function.
   This is needed for the upcomming IPTFS patchset.
   From Christian Hopps.

3) Spelling fix in xfrm.h.
   From Simon Horman.

4) Speed up xfrm policy insertions.
   From Florian Westphal.

5) Add and revert a patch to support xfrm interfaces
   for packet offload. This patch was just half coocked.

6) Extend usage of the new xfrm_policy_is_dead_or_sk helper.
   From Florian Westphal.

7) Update comments on sdb and xfrm_policy.
   From Florian Westphal.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 8e0c0ec9b7dc2aec84f141c26c501e24906ff765:

  Merge branch 'ethernet-convert-from-tasklet-to-bh-workqueue' (2024-07-31 19:05:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2024-09-09

for you to fetch changes up to 69716a3babe1165a9ab1b3770b55d303d5bb5fa3:

  Revert "xfrm: add SA information to the offloaded packet" (2024-09-09 11:43:39 +0200)

----------------------------------------------------------------
ipsec-next-2024-09-09

----------------------------------------------------------------
Christian Hopps (1):
      net: add copy from skb_seq_state to buffer function

Florian Westphal (6):
      selftests: add xfrm policy insertion speed test script
      xfrm: policy: don't iterate inexact policies twice at insert time
      xfrm: switch migrate to xfrm_policy_lookup_bytype
      xfrm: policy: remove remaining use of inexact list
      xfrm: policy: use recently added helper in more places
      xfrm: minor update to sdb and xfrm_policy comments

Patrisious Haddad (1):
      xfrm: Remove documentation WARN_ON to limit return values for offloaded SA

Simon Horman (1):
      xfrm: Correct spelling in xfrm.h

Steffen Klassert (2):
      Merge branch 'xfrm: speed up policy insertions'
      Revert "xfrm: add SA information to the offloaded packet"

wangfe (1):
      xfrm: add SA information to the offloaded packet

 include/linux/skbuff.h                             |   1 +
 include/net/xfrm.h                                 |  45 ++++-
 net/core/skbuff.c                                  |  35 ++++
 net/xfrm/xfrm_device.c                             |   6 +-
 net/xfrm/xfrm_policy.c                             | 220 +++++++++------------
 tools/testing/selftests/net/Makefile               |   2 +-
 .../testing/selftests/net/xfrm_policy_add_speed.sh |  83 ++++++++
 7 files changed, 256 insertions(+), 136 deletions(-)
 create mode 100755 tools/testing/selftests/net/xfrm_policy_add_speed.sh

