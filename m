Return-Path: <netdev+bounces-111233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67C893051E
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AA9283648
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090727344A;
	Sat, 13 Jul 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hvgGXAan"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9669D2B
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866270; cv=none; b=ErT5SLH0dHDH3XDXLvU2RpNmib7hxftwOWvrfCF+ihbODPGA8HWtpN6Jf4tTMvO3Mse9TNgQ4YZMak7z75llqM7IzCV0X9dh7dJJDsqaFwfPbtDcR7+ZfKlMfCNkiS1Jq3SijGxgxr40HsV3UHB1yx3TwmJ9aeYBn9mTjZTtOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866270; c=relaxed/simple;
	bh=L0xqgZ57jEXmPs5BxkicGauoRf+kebFyM572VEBlHO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p3lfjdGgqx5EhyiKXewBCGJt2jDMwvsDNeszr7EkmKPX3uDp066DVpkReC0kRsBSKAP4kxL6OaaqHhQpDYn16O1dSMGgpJVRYHT3qRaBaoeTsx1UaX+/i5RyfsPQB1ERS4qe3v3PqvLEIvdvmmih6mv8gLeA1nmKStLb7z29rk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hvgGXAan; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 474AC2087D;
	Sat, 13 Jul 2024 12:24:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wR3mj8tnyDQC; Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7030620872;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7030620872
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720866265;
	bh=MINrrlYF1IhQRCcUUJ3CRTHK9FmLlLHBfCx3z4JyMrc=;
	h=From:To:CC:Subject:Date:From;
	b=hvgGXAanbGHMeyeHeQCeMjf02U2RHmm8QmfBwoi0yMwIlaXkATpPyDoVCMIo3/ulR
	 HXmGfuUfgdGr7fJClHhvnvvYflekEDfqEuhvs0lh9ftEjsrC01lKCzchHUkTnbLZn/
	 BAsIg+j10+e8XyyW6IMvzgFwCddKg/E1VJ4BjOUivRWz6FlAmsZKGoCkfJ4sg0humx
	 qeDOZxvr91YmkfnuffHdJGhN/LwM+obXDip+LjPN8cqqCbCr51KfPv3f66C1AFhOnf
	 pO38mERG0IN6EYdMdESlLKD3mmRieoBEQJexlKMtbCb9PyrKEL0lEYxbKxeCX2dz3X
	 chqLCBZK1b2wA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 608C080004A;
	Sat, 13 Jul 2024 12:24:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 13 Jul 2024 12:24:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 13 Jul
 2024 12:24:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 483713182D21; Sat, 13 Jul 2024 12:24:24 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/5] pull request (net-next): ipsec-next 2024-07-13
Date: Sat, 13 Jul 2024 12:24:11 +0200
Message-ID: <20240713102416.3272997-1-steffen.klassert@secunet.com>
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

1) Support sending NAT keepalives in ESP in UDP states.
   Userspace IKE daemon had to do this before, but the
   kernel can better keep track of it.
   From Eyal Birger.

2) Support IPsec crypto offload for IPv6 ESP and IPv4 UDP-encapsulated
   ESP data paths. Currently, IPsec crypto offload is enabled for GRO
   code path only. This patchset support UDP encapsulation for the non
   GRO path. From Mike Yu.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 5233a55a5254ea38dcdd8d836a0f9ee886c3df51:

  mISDN: remove unused struct 'bf_ctx' (2024-05-27 16:48:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2024-07-13

for you to fetch changes up to d5b60c6517d227b044674718a993caae19080f7b:

  Merge  branch 'Support IPsec crypto offload for IPv6 ESP and IPv4 UDP-encapsulated ESP data paths' (2024-07-13 11:14:04 +0200)

----------------------------------------------------------------
ipsec-next-2024-07-13

----------------------------------------------------------------
Eyal Birger (1):
      xfrm: support sending NAT keepalives in ESP in UDP states

Mike Yu (4):
      xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO path
      xfrm: Allow UDP encapsulation in crypto offload control path
      xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP packet
      xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP packet

Steffen Klassert (1):
      Merge  branch 'Support IPsec crypto offload for IPv6 ESP and IPv4 UDP-encapsulated ESP data paths'

 include/net/ipv6_stubs.h      |   3 +
 include/net/netns/xfrm.h      |   1 +
 include/net/xfrm.h            |  10 ++
 include/uapi/linux/xfrm.h     |   1 +
 net/ipv4/esp4.c               |   8 +-
 net/ipv4/esp4_offload.c       |  17 ++-
 net/ipv6/af_inet6.c           |   1 +
 net/ipv6/xfrm6_policy.c       |   7 +
 net/xfrm/Makefile             |   3 +-
 net/xfrm/xfrm_compat.c        |   6 +-
 net/xfrm/xfrm_device.c        |   6 +-
 net/xfrm/xfrm_input.c         |   3 +-
 net/xfrm/xfrm_nat_keepalive.c | 292 ++++++++++++++++++++++++++++++++++++++++++
 net/xfrm/xfrm_policy.c        |  13 +-
 net/xfrm/xfrm_state.c         |  17 +++
 net/xfrm/xfrm_user.c          |  15 +++
 16 files changed, 393 insertions(+), 10 deletions(-)
 create mode 100644 net/xfrm/xfrm_nat_keepalive.c

