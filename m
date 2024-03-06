Return-Path: <netdev+bounces-77855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE37873381
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506351C20E36
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E25F543;
	Wed,  6 Mar 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="D5EEIrnm"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65045DF29
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719495; cv=none; b=CmZDP0ySVXC20OxObiTmaYyGCL5QZf6Xxgf1rUjpuJH8ixRgGNNKjJdkt6WBWrWkhqJ+Nz750f+IOOU8DCclNLbP+wz1dy3RSO9QYPIONrxn7RPWASzvKJ/49Caeyo+ODf9NYtalsB9cSC/XTSRyoHMAwlnhhwvzAkIGNRqO5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719495; c=relaxed/simple;
	bh=fPrFgHDB57bVd2uzXhApsTIQsBk7AW5rtnOhmQ8SCFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TrRAZ3YrZ0u4GM5Ds0S+edp7HpVr5GTqsunh9rT2xhwuRgKaPGSmEseiTfNoH7RqRL04qCGkLpaV4ZqEi+Fk5Sr0JD3MdfupwOZwE8l1o6h4/aLQkU4g3EitV0y+WxN/D3m0zcf/WCsnqVTipahcjOLQJHMLNsR4Ii2AyfDtWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=D5EEIrnm; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9FF6020758;
	Wed,  6 Mar 2024 11:04:50 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNn_I9nZ9O-g; Wed,  6 Mar 2024 11:04:49 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 749FE205CD;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 749FE205CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709719484;
	bh=lay+/YoSJcMbKToB6vhHyjCR7UEx4IYOl5KcCuo7QSQ=;
	h=From:To:CC:Subject:Date:From;
	b=D5EEIrnm0ONI1/biUwOA/yL9d4Tx/9upqyc+jQNfAEMm/W20ECH2DEHqUrx2QtJsy
	 z5LuQir9q79H0UkdNp85Q3WesUMDeiMWFpWS1GWXdOONm5i4SWHMFGMyjB9bRNKtNO
	 hjyjHotdYz99J/LGej5rdzOryOODQOrNlpf/qFIEcZXYpmB7cO4YZnxyEIqY3couUV
	 o6olB6ClXqH0i5ZrroLZcONHSMUVPdJxmu1/awz5PxuCGW8xmWEKetHcMIIGDSlHZE
	 6R6wup3ft6j6UbVLBBHmNLq63WpQ2j+zWxG0A4/D5aTUaKYnZCpu15ZQfWE1BN2mbX
	 AFk6mhEWMKD4A==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 66A3B80004A;
	Wed,  6 Mar 2024 11:04:44 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:04:44 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:04:44 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C6FDC3180750; Wed,  6 Mar 2024 11:04:43 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/5] pull request (net): ipsec 2024-03-06
Date: Wed, 6 Mar 2024 11:04:33 +0100
Message-ID: <20240306100438.3953516-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

1) Clear the ECN bits flowi4_tos in decode_session4().
   This was already fixed but the bug was reintroduced
   when decode_session4() switched to us the flow dissector.
   From Guillaume Nault.

2) Fix UDP encapsulation in the TX path with packet offload mode.
   From Leon Romanovsky,

3) Avoid clang fortify warning in copy_to_user_tmpl().
   From Nathan Chancellor.

4) Fix inter address family tunnel in packet offload mode.
   From Mike Yu.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit e327b2372bc0f18c30433ac40be07741b59231c5:

  net: ravb: Fix dma_addr_t truncation in error case (2024-01-14 16:41:51 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2024-03-06

for you to fetch changes up to 2ce0eae694cfa8d0f5e4fa396015fc68c5958e8d:

  Merge branch 'Improve packet offload for dual stack' (2024-03-06 10:33:24 +0100)

----------------------------------------------------------------
ipsec-2024-03-06

----------------------------------------------------------------
Guillaume Nault (1):
      xfrm: Clear low order bits of ->flowi4_tos in decode_session4().

Leon Romanovsky (1):
      xfrm: Pass UDP encapsulation in TX packet offload

Mike Yu (2):
      xfrm: fix xfrm child route lookup for packet offload
      xfrm: set skb control buffer based on packet offload as well

Nathan Chancellor (1):
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()

Steffen Klassert (1):
      Merge branch 'Improve packet offload for dual stack'

 net/xfrm/xfrm_device.c | 2 +-
 net/xfrm/xfrm_output.c | 6 +++++-
 net/xfrm/xfrm_policy.c | 6 ++++--
 net/xfrm/xfrm_user.c   | 3 +++
 4 files changed, 13 insertions(+), 4 deletions(-)

