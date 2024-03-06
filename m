Return-Path: <netdev+bounces-77864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E687346C
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43963B2FADA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D45EE84;
	Wed,  6 Mar 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nfaXNt+K"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B275F848
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720670; cv=none; b=p6HTYC/wDesbDUap3HkNf8+a5++t0YJLMXFfWTaiUA4n279G5EaaWrqZKQ8DU3e30hx3AKEk0hImL4dbIsB9SoddWoOHEOiiSgFNE3H470+sgBsfqnERbv+7FTY+3aXP22Fywr6+qbe2jpm9RL+SFUHMT3pzfmQoVt5EoRZepRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720670; c=relaxed/simple;
	bh=k1ct+qX/iKfLal7H651WrarNiwysCxI7xs6/o9hOjUo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Db7Wg9Wvo3F9OSF5f5b+osgHfMKgiuDDvxXD/2/FAFeHlbJUAuX9ErHSs9z5uxiexdPPcANMwK4QOTSQEvENXra1880C4Q4JsGA21dg+dukQKZ1e1WcQ9oCAyH365H6Djzj5VVt5oR1JwoxF/sBmEgYBnADLDzjqRCAiNHBAtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nfaXNt+K; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5765F2080B;
	Wed,  6 Mar 2024 11:24:26 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yMFd3wClcOt1; Wed,  6 Mar 2024 11:24:25 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C2689201E4;
	Wed,  6 Mar 2024 11:24:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C2689201E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1709720665;
	bh=SQhpux2q04r+E+NqMb4/A+/QtuJWbiJiPR5T+sEqSLw=;
	h=From:To:CC:Subject:Date:From;
	b=nfaXNt+KB1FI0sYaSODKw4jqEzwQ8UawYfwaDsZfnSvE3Ev/lX8CYYqDOf9D/TtnO
	 K/h5NFmI6u2acH7LbZEsDCsxyutgQnOiKQiA6zwHDJKalGYodkmaa5VXMTXhxjC6+e
	 6kP1bgF+7//6aGY6046X6OPPwgi26jhkranNErgaYtuDfoRRBNCD1c31q7vJGogxdB
	 DNDoYGwnf/uUiym+WUoWYXkFfhoSy9XP5+ekfAi/Q8TPNCuybVyriuPRBqhzomnbE0
	 cOAxRSfZo77Km2Mm3rh0soBgVz3fUgEHyRi9oux05Q5snshPuL84oHQWTzTCTuY1+5
	 SZJcB6MVg/4qg==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id B465480004A;
	Wed,  6 Mar 2024 11:24:25 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 11:24:25 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:24:25 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2E38C3181583; Wed,  6 Mar 2024 11:24:25 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/4] pull request (net-next): ipsec-next 2024-03-06
Date: Wed, 6 Mar 2024 11:24:17 +0100
Message-ID: <20240306102421.3963212-1-steffen.klassert@secunet.com>
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

1) Introduce forwarding of ICMP Error messages. That is specified
   in RFC 4301 but was never implemented. From Antony Antony.

2) Use KMEM_CACHE instead of kmem_cache_create in xfrm6_tunnel_init()
   and xfrm_policy_init(). From Kunwu Chan.

3) Do not allocate stats in the xfrm interface driver, this can be done
   on net core now. From Breno Leitao.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 5ca1a5153a28dc8bcfeeafa983915b76af457929:

  tipc: node: remove Excess struct member kernel-doc warnings (2024-01-24 17:48:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2024-03-06

for you to fetch changes up to aceb147b20a2eda9a10bdd4b5650718f731ef3e1:

  xfrm: Do not allocate stats in the driver (2024-02-27 11:33:20 +0100)

----------------------------------------------------------------
ipsec-next-2024-03-06

----------------------------------------------------------------
Antony Antony (1):
      xfrm: introduce forwarding of ICMP Error messages

Breno Leitao (1):
      xfrm: Do not allocate stats in the driver

Kunwu Chan (2):
      xfrm6_tunnel: Use KMEM_CACHE instead of kmem_cache_create
      xfrm: Simplify the allocation of slab caches in xfrm_policy_init

 net/ipv6/xfrm6_tunnel.c        |   5 +-
 net/xfrm/xfrm_interface_core.c |  10 +--
 net/xfrm/xfrm_policy.c         | 147 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 144 insertions(+), 18 deletions(-)

