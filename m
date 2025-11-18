Return-Path: <netdev+bounces-239431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6AAC68621
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79D5E3496C7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37932C94A;
	Tue, 18 Nov 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="GgdG+E/b"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E432C929
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456041; cv=none; b=u0RsaPYRwQ5KC39YEcw8ROznBVPLrnQKw7D/W5mWanu48PaH9Wxylpg4UX1ZvyVTrh9ws69RAb7Wq94yIPoOCLFcu+9pSrroqufQ4dClwFZe8dUqrY+tVE6jzElAEoY63SDMxiBNqTbNg8TeHLcGWFptbkHX1cUy6bjASmU00U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456041; c=relaxed/simple;
	bh=h0RldeimSSbr6n/VR0HuDWjtpxoN6nm+YrGt8fcbn0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lSYmd0n1SJUnNsdEp4tkRyfyNt4MCcDWqZ9CJWK0ClMRuqY71l1YwMF2Ut2wl7ZNAyQptr6kpoonrjD7pnM+FehXpwMW4N+B+1bohkcaItz90lj/Iqwuqf9AOduwVSweQDEtSgZn58X9FOnjpVPXLepdLvlywnZwtuEiKzJ797A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=GgdG+E/b; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3D72920799;
	Tue, 18 Nov 2025 09:53:50 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W6Wtde4DZzxs; Tue, 18 Nov 2025 09:53:49 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A202120743;
	Tue, 18 Nov 2025 09:53:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A202120743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763456029;
	bh=RHhbGPKYMXYYQevDXofSueeAKwTledQ3kkAGfczPP6Y=;
	h=From:To:CC:Subject:Date:From;
	b=GgdG+E/b9f9/93BPLE/P+NRuIiFAQJJpaL7coVrcOwgA0IwT67+c/tLnAU26h2PuK
	 XOrEqbxz38l2OVI0n8zKWKP8HkX//zX+YyiVFHCzToB0SAapQKkKhQliPYKHHSc92V
	 YnLTzsd1JbL//SJUd2X7bOyf4DdUFXXR4bSQFwU9vkxM3SrdnIicGucGbi+UFr+PO8
	 VIReN1PU5C6daok8CThYjSHipWANJoT811KearB8EdszBtUfOkxL55YjerpxvRJNPY
	 NE3P6Y8xAqdVD3FTy59CuQbbiq5IpJk314vq75BjRIJKNX5rxmxJeHi1n4qXocy0ar
	 QyO5jD6rRoTow==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 09:53:49 +0100
Received: (nullmailer pid 2200642 invoked by uid 1000);
	Tue, 18 Nov 2025 08:53:48 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/10] pull request (net): ipsec 2025-11-18
Date: Tue, 18 Nov 2025 09:52:33 +0100
Message-ID: <20251118085344.2199815-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

1) Misc fixes for xfrm_state creation/modification/deletion.
   Patchset from Sabrina Dubroca.

2) Fix inner packet family determination for xfrm offloads.
   From Jianbo Liu.

3) Don't push locally generated packets directly to L2 tunnel
   mode offloading, they still need processing from the standard
   xfrm path. From Jianbo Liu.

4) Fix memory leaks in xfrm_add_acquire for policy offloads and policy
   security contexts. From Zilin Guan.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit f584239a9ed25057496bf397c370cc5163dde419:

  net/smc: fix general protection fault in __smc_diag_dump (2025-10-20 17:46:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2025-11-18

for you to fetch changes up to a55ef3bff84f11ee8c84a1ae29b071ffd4ccbbd9:

  xfrm: fix memory leak in xfrm_add_acquire() (2025-11-14 10:12:36 +0100)

----------------------------------------------------------------
ipsec-2025-11-18

----------------------------------------------------------------
Jianbo Liu (3):
      xfrm: Check inner packet family directly from skb_dst
      xfrm: Determine inner GSO type from packet inner protocol
      xfrm: Prevent locally generated packets from direct output in tunnel mode

Sabrina Dubroca (6):
      xfrm: drop SA reference in xfrm_state_update if dir doesn't match
      xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
      xfrm: make state as DEAD before final put when migrate fails
      xfrm: call xfrm_dev_state_delete when xfrm_state_migrate fails to add the state
      xfrm: set err and extack on failure to create pcpu SA
      xfrm: check all hash buckets for leftover states during netns deletion

Zilin Guan (1):
      xfrm: fix memory leak in xfrm_add_acquire()

 include/net/xfrm.h      |  3 ++-
 net/ipv4/esp4_offload.c |  6 ++++--
 net/ipv6/esp6_offload.c |  6 ++++--
 net/xfrm/xfrm_device.c  |  2 +-
 net/xfrm/xfrm_output.c  |  8 ++++++--
 net/xfrm/xfrm_state.c   | 30 ++++++++++++++++++++++--------
 net/xfrm/xfrm_user.c    |  8 +++++++-
 7 files changed, 46 insertions(+), 17 deletions(-)

