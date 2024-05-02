Return-Path: <netdev+bounces-92954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EF8B96CE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A88B23FBE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F6754660;
	Thu,  2 May 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xt47fcOT"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B747772
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639732; cv=none; b=RFM+EKm8hDjNTdRREjroucIdXuJLYbvKDH+VnDhFWbrylFZ64/ohhMdkhPTVD0p/zeBmrr8pWkWKPja7yYA2GoaNg0RQilZIfAvfZVW6wfjJ+4HFabann3yl9+rJA2Gix3PlNzeyLrW0UzPVWtfk/ANEMvQYIZmgjDMqWojSee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639732; c=relaxed/simple;
	bh=Jgp6kj/LkSnhzMzKfLQhp3zCudz7QHRIxVj9bgvyWik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QGk5toxfVKdKy1MMryc6XsleK7F4EzhJI65V1ho6GA3315BeYmZ1BY0LVauluznPrZTmbHn7+pHc2Yr9AT2BuRGpjJUN68oLuP/T9r07CX95pcGg/HHNs3x6Ow4ngWBHJzZofowHr1WwOlSx2yKEHffnI3a7ZO82hab5cL4PZJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xt47fcOT; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 13420207AC;
	Thu,  2 May 2024 10:48:47 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YwovxB9F_Cxu; Thu,  2 May 2024 10:48:46 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 888B82076B;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 888B82076B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714639726;
	bh=SXB5giEVnr6pWPv49ecR7XkMv09MOieW3zQC/5g8xuI=;
	h=From:To:CC:Subject:Date:From;
	b=xt47fcOTgpVlRgqYCoq8me4oDqsQ/M2wN3Y8aZd4yB00fngJnAXAxs1vKbfg6EVbk
	 N8Uob1PGVXnk7HZXDZ0mBZMBd4q3DwJLr+UeVqwfOOFyIttCk9LxgyjYEUus7eIwfx
	 VyqZwUoIPyMtvwrd3rZyHlql1coGIkuTaSW2lZEhJjq4fOGX8ggdk3NpgQ/ejhKKwI
	 ldvc/gu09JfWGSraQ3Qc0epeOOqW18fDBann9DOsTe91Zkpg/AUWcjXd0cl/FIMM6T
	 rarizapxZS4MOVFO9bcGj9mfpI141w2OB3mj+vXcd5kwTTNmxY0kEX+RbIVgKYyqEp
	 +re0AYoAP2feA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 7BFC080004A;
	Thu,  2 May 2024 10:48:46 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 2 May 2024 10:48:46 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 May
 2024 10:48:45 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A24D53182B5F; Thu,  2 May 2024 10:48:45 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/3] pull request (net): ipsec 2024-05-02
Date: Thu, 2 May 2024 10:48:35 +0200
Message-ID: <20240502084838.2269355-1-steffen.klassert@secunet.com>
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

1) Fix an error pointer dereference in xfrm_in_fwd_icmp.
   From Antony Antony.

2) Preserve vlan tags for ESP transport mode software GRO.
   From Paul Davey.

3) Fix a spelling mistake in an uapi xfrm.h comment.
   From Anotny Antony.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit bccb798e07f8bb8b91212fe8ed1e421685449076:

  octeontx2-pf: Fix transmit scheduler resource leak (2024-04-07 15:45:56 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2024-05-02

for you to fetch changes up to b6d2e438e16c7d4dbde08cfb2b95b0f3f325ba40:

  xfrm: Correct spelling mistake in xfrm.h comment (2024-04-29 07:52:40 +0200)

----------------------------------------------------------------
ipsec-2024-05-02

----------------------------------------------------------------
Antony Antony (2):
      xfrm: fix possible derferencing in error path
      xfrm: Correct spelling mistake in xfrm.h comment

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

 include/linux/skbuff.h    | 15 +++++++++++++++
 include/net/xfrm.h        |  3 +++
 include/uapi/linux/xfrm.h |  2 +-
 net/ipv4/xfrm4_input.c    |  6 +++++-
 net/ipv6/xfrm6_input.c    |  6 +++++-
 net/xfrm/xfrm_input.c     |  8 ++++++++
 net/xfrm/xfrm_policy.c    |  2 ++
 7 files changed, 39 insertions(+), 3 deletions(-)

