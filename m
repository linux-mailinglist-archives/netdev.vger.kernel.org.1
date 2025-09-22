Return-Path: <netdev+bounces-225141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B2B8F4E2
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A1F3A9F9A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 07:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF172EE611;
	Mon, 22 Sep 2025 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="O0LGvYvI"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2910815E5D4
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758526525; cv=none; b=NO0p0H7Uesom62Wm6AtjO2VW8BUg+ATaRi4h9MDmcuoq5bgsVtKZmUE1w517PgE5feDfYg5TUFXMyxkeQFTdliJHuWqk/76rNl7xvSt4KTqIozdnsll93JboIPgrHdzxwwMLQfRZIXk1Gz/+mRZdYqpGATOKD1b91qsW41AXXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758526525; c=relaxed/simple;
	bh=NWNEsZUzAYBQmstBgPN9FEMzpJRlY2cdrlRRWy48ggU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UpchkY4HDkjjl5O1UQCMdkUpW03OZW4aMlUBIYPB5DZ12Jrt6dZ+j0R909IdM/v0shpKIdA0pSsFTzcQndrpCbIWrEYFAvtz+CTlj+ukyfewYjDZ8/jhUNaDpGuv476YrO5SqEtp0qi91IeUJ4bxEP5mQxAraJA7lRWh+AeC7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=O0LGvYvI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 511252082E;
	Mon, 22 Sep 2025 09:35:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4fIOoGNNoS4d; Mon, 22 Sep 2025 09:35:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C3919205ED;
	Mon, 22 Sep 2025 09:35:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C3919205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1758526520;
	bh=q2L3tjjchgypDyb2R98Lr4NGsNT2SFN4fUhUnFACKDo=;
	h=From:To:CC:Subject:Date:From;
	b=O0LGvYvI+Z7fH9IWM+xeNeJuqQ2JKGDHGftWL5kvW0SmncYpYWINGrOZRN1rZ/8mK
	 WNq9CLH7pP4LQho7AyRuh/fOHEAES9SW4hkDHNnLn/Tfi8JWGrzdqMAk5HHWgd8kbd
	 VvQNJoWN/EBkkcxNRiJJJkYdGBeb52HcLjgc7F4zsu6fxkOlmXbkEy63gOYjOXu1Yw
	 d0iD0PVNxWAtbk+eZFx30pwMrLSRwqenBLvtDBQ8CvGfjP3A9IUZ4BtwVszhU+Ft8f
	 KX2zvNKMiUvTK+cKFYt7Qm6PvIyVE3B4VJ67h1Uz9sZilXDz+ZfgrJJ8V8ceYHP+Sd
	 lAKmfVXMb8XyQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 22 Sep
 2025 09:35:20 +0200
Received: (nullmailer pid 64928 invoked by uid 1000);
	Mon, 22 Sep 2025 07:35:19 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/2] pull request (net): ipsec 2025-09-22
Date: Mon, 22 Sep 2025 09:34:51 +0200
Message-ID: <20250922073512.62703-1-steffen.klassert@secunet.com>
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

1) Fix 0 assignment for SPIs. 0 is not a valid SPI,
   it means no SPI assigned.

2) Fix offloading for inter address family tunnels.

Both fixes from Sabrina Dubroca.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 52565a935213cd6a8662ddb8efe5b4219343a25d:

  net: kcm: Fix race condition in kcm_unattach() (2025-08-13 18:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2025-09-22

for you to fetch changes up to 91d8a53db2199eefc73ecf3682e0665ea6895696:

  xfrm: fix offloading of cross-family tunnels (2025-09-15 11:35:06 +0200)

----------------------------------------------------------------
ipsec-2025-09-22

----------------------------------------------------------------
Sabrina Dubroca (2):
      xfrm: xfrm_alloc_spi shouldn't use 0 as SPI
      xfrm: fix offloading of cross-family tunnels

 net/xfrm/xfrm_device.c | 2 +-
 net/xfrm/xfrm_state.c  | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

