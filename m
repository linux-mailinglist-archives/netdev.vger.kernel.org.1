Return-Path: <netdev+bounces-87264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038F28A261F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A01C22DEF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD91CD04;
	Fri, 12 Apr 2024 06:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NAm0fhS+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860B1C6A6
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901966; cv=none; b=k+uNa0qHPWXAxlCBZjO0SjB+iYrdXZe41zYl4BxhYKZfb/Qvmy7d3xlA0QZVReCAz8BiPXDbVQ2sn18jD3EICGgDa0bw56Xpqfep60IPcsQaX7eefU/JMpcrHhktLAO0xWaLoD4muPQezAndbzDirXnaSPuhYCUn7n98o1O9V00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901966; c=relaxed/simple;
	bh=W/va3kmdy59AesSiOs91jJ8hmJqXEFaAcMEDxK/rGSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h9xsbLSs8SGwGpNPqmf7QKQu5u/QA6ef2+Qovlt3s8V/DJQtlXOpr7ThKDahLI4XoJemPIx1hhPB+44dPckxu2fslNEe9SgM+e2remLVrMBHEgFeZGYLx/eim3sVNcexFsIOettr9y8TY5bUJbXSfAGvYVstVpmZVCwuGgB8zSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NAm0fhS+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 930AB2088F;
	Fri, 12 Apr 2024 08:06:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hcM1NKj85dmM; Fri, 12 Apr 2024 08:06:00 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C57552085A;
	Fri, 12 Apr 2024 08:06:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C57552085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712901960;
	bh=C/f8mLGJiFnw2Q8p3xOYmlvNJTnr5dZR3bFgMr5qL+k=;
	h=From:To:CC:Subject:Date:From;
	b=NAm0fhS+lFSmb2mKUPdccRImrXk28yrmo5uJiwEewfyaar1w/XGbj5YqLCnxYub2+
	 aMDBn6O4Wn/0y2FfSYswuvO+TWJKkXAqHgedXxy6mqemKEkurKaYPMXyydJG3zeP/T
	 O77D3KAb3aDiPUeQc8ygt3nuoUzK8TDH0V5WTTb9ManjojxtfiT7RYVAuBzC3SLvfD
	 hTPxYl1u/oCwJVB0lPKK9iSjCD4FVGxBarDncUXhAIyVtPlNcuYpc4n4pwD9EODbeb
	 ea9L2cnshI24vKYLt/o2SsY8/p9RaWhHvd0CcU/SIYcca4+V5YUzIFcIajvZVgqsem
	 BzQ1gLgOnGK5Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id B949F80004A;
	Fri, 12 Apr 2024 08:06:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 08:06:00 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 12 Apr
 2024 08:06:00 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CDBB73181AB6; Fri, 12 Apr 2024 08:05:59 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Paul Wouters
	<paul@nohats.ca>, Antony Antony <antony.antony@secunet.com>, Tobias Brunner
	<tobias@strongswan.org>, Daniel Xu <dxu@dxuuu.xyz>
CC: Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH ipsec-next 0/3] Add support for per cpu xfrm states.
Date: Fri, 12 Apr 2024 08:05:50 +0200
Message-ID: <20240412060553.3483630-1-steffen.klassert@secunet.com>
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
 mbx-essen-01.secunet.de (10.53.40.197)

Add support for per cpu xfrm states.

This patchset implements the xfrm part of per cpu SAs as specified in:

https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/

Patch 1 adds the cpu as a lookup key and config option to to generate
acquire messages for each cpu.

Patch 2 caches outbound states at the policy.

Patch 3 caches inbound states on a new percpu state cache.

Please review and test.

Thanks!

----------------------------------------------------------------
Steffen Klassert (3):
      xfrm: Add support for per cpu xfrm state handling.
      xfrm: Cache used outbound xfrm states at the policy.
      xfrm: Add an inbound percpu state cache.

 include/net/netns/xfrm.h  |   1 +
 include/net/xfrm.h        |  13 +++-
 include/uapi/linux/xfrm.h |   2 +
 net/ipv4/esp4_offload.c   |   6 +-
 net/ipv6/esp6_offload.c   |   6 +-
 net/key/af_key.c          |   7 +-
 net/xfrm/xfrm_input.c     |   2 +-
 net/xfrm/xfrm_policy.c    |  12 ++++
 net/xfrm/xfrm_state.c     | 160 ++++++++++++++++++++++++++++++++++++++++++----
 net/xfrm/xfrm_user.c      |  43 ++++++++++++-
 10 files changed, 227 insertions(+), 25 deletions(-)

