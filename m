Return-Path: <netdev+bounces-249825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FA2D1EB2E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EC40301D693
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40B397AB6;
	Wed, 14 Jan 2026 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Hp4DdpEN"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC339902A
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393112; cv=none; b=gZpWgwP1BVjk+Nelwkljps8sUeCwhKvW5DuD4ZqYpmRfuoqtCOtsmqofSX7JKpyylBB7uuPu3Cl2BjGAHU0ZwsRSHkjmsFCWMwak/t8ci9QuTAUXF0JpXsjewGqJqPwwRFuRGrV4AovG2rp8km4dfVkqJt17UPh0iSA/on1qOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393112; c=relaxed/simple;
	bh=cpjUfqxM7q8UVOLDgL+u/2hnFh9L3jU4XnaqsQ5V7uw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJHejOUieLnIoojXm6inwjCnnIogpKBY8xmn0EZdjkjTMfDIIPDAozN3P/RlVjjD30oMFzVNxQWJrAfaQjNdL4CZtmE7HePkjJQeSO5mmp6z+yDbwWBNuEVsV8oEg+LFy/ozmy1unWmsPqNGqInFOm2LYbTy3VSck7vGtyTN9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Hp4DdpEN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 965E720826;
	Wed, 14 Jan 2026 13:18:22 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5FMfyL_wUDu; Wed, 14 Jan 2026 13:18:22 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1683720839;
	Wed, 14 Jan 2026 13:18:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1683720839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768393102;
	bh=aPZzdHUJidiBXwtxqDkOdE/QNeKnDweT1pgboOKbJAs=;
	h=From:To:CC:Subject:Date:From;
	b=Hp4DdpENr4PXUIp/+PUosFY24LRokCze9EUf9OlRHCNPcs7570OCQA0IzpUqBdYEG
	 xgeC9ETLQK0umqa4vBMulOoXBDAE/wBjZhmaFX2hQgZVu3BTaJDnx1LTp0izil88tK
	 MI2xzLwSrRp1pgOhPlhfz9VCB+YEePNjxj8TBgr5NEVMwvwJYPBlvyxkRCuHGRMNiO
	 ta8ZFauC+ySWXVynOpVwaASkHWnzqLGJvN2XBiLyIyabn5qnbgkkgQGJX9NkHpFsZ8
	 ULL2jfgvLxwv0prYqXOWOMvqTN5aHl4iqhKOXcoC+6tefTWj1OLoPEgK6VAWriO/ZL
	 g4JwMMe8I/Beg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 13:18:21 +0100
Received: (nullmailer pid 1106326 invoked by uid 1000);
	Wed, 14 Jan 2026 12:18:20 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] pull request (net): ipsec 2026-01-14
Date: Wed, 14 Jan 2026 13:18:07 +0100
Message-ID: <20260114121817.1106134-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

1) Fix inner mode lookup in tunnel mode GSO segmentation.
   The protocol was taken from the wrong field.

2) Set ipv4 no_pmtu_disc flag only on output SAs. The
   insertation of input SAs can fail if no_pmtu_disc
   is set.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:

  Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-01-14

for you to fetch changes up to c196def07bbc6e8306d7a274433913444b0db20a:

  xfrm: set ipv4 no_pmtu_disc flag only on output sa when direction is set (2025-12-15 11:06:25 +0100)

----------------------------------------------------------------
ipsec-2026-01-14

----------------------------------------------------------------
Antony Antony (1):
      xfrm: set ipv4 no_pmtu_disc flag only on output sa when direction is set

Jianbo Liu (1):
      xfrm: Fix inner mode lookup in tunnel mode GSO segmentation

 net/ipv4/esp4_offload.c | 4 ++--
 net/ipv6/esp6_offload.c | 4 ++--
 net/xfrm/xfrm_state.c   | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

