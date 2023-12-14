Return-Path: <netdev+bounces-57350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E673812EB6
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF843282648
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986E0405C8;
	Thu, 14 Dec 2023 11:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="tlzVTivK"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6AB12A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:37:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B43A9206B1;
	Thu, 14 Dec 2023 12:36:59 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpfq-ITOelul; Thu, 14 Dec 2023 12:36:59 +0100 (CET)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CE56A20890;
	Thu, 14 Dec 2023 12:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CE56A20890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1702553816;
	bh=QwSUSQtfugA+6cCuTqIzDR3Jc3wd+5yqQ4wqk+s2eW0=;
	h=From:To:CC:Subject:Date:From;
	b=tlzVTivKU8akVF+geT4OvOojZ5konD93GmYqTO0S32yZL48wMou/aW/EIHu25zIIQ
	 bNDPLsAIBHzvIXhSZU2+JQgrpO2KbFSfAb3hG2EcIegKIUPS1y+LtrnIMm1V8JyP2T
	 l1D/askfYVSD/S1EUMuUAdfAf1Gx3b0socjM6ck1sh/PEAzm2i6coTLVRzoCDjuROc
	 p3MSyp/z4RZfEKbV+WHhHodHzkA2sJHXYoiymitrAQqy0I5TOzdmH0sfh4N7eNdAP7
	 7CVxWmqgyZf5dAdFyHXZgpJ0s18THrNHKSlwSZKtecgy0gKOAFYhlRXrcS2Ai1GpQC
	 kE9bv0d/gmezw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id CA55B80004A;
	Thu, 14 Dec 2023 12:36:56 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 12:36:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 12:36:55 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 632C73180DE2; Thu, 14 Dec 2023 12:36:55 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH RFC ipsec-next 0/3] Add support for per cpu xfrm states.
Date: Thu, 14 Dec 2023 12:36:42 +0100
Message-ID: <20231214113645.2416005-1-steffen.klassert@secunet.com>
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
 include/net/xfrm.h        |  13 +++++--
 include/uapi/linux/xfrm.h |   2 ++
 net/ipv4/esp4_offload.c   |   6 ++--
 net/ipv6/esp6_offload.c   |   6 ++--
 net/key/af_key.c          |   6 ++--
 net/xfrm/xfrm_input.c     |   2 +-
 net/xfrm/xfrm_policy.c    |  12 +++++++
 net/xfrm/xfrm_state.c     | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 net/xfrm/xfrm_user.c      |  43 ++++++++++++++++++++--
 10 files changed, 225 insertions(+), 25 deletions(-)


