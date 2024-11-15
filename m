Return-Path: <netdev+bounces-145198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2084E9CDA98
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D71283A59
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750B18C322;
	Fri, 15 Nov 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="q3jfhc+5"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1918BC19
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659638; cv=none; b=uaTrxMCQw0vfvhANJ2WbTfkRvh0NyK7YrglAsmNh3LVL8oppsDYww8wzq2snjyMirs2Kcr5ec4J9Ju/MYDmxj8QoGDzeID3D/btgFr1X+gSpUVdY8NIuHb9hOGkWJvBaJd0NBl2bd8cE2Sq7QQiRGqCzlRREORIR3+ABozYJ7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659638; c=relaxed/simple;
	bh=M1c7TDAOfR9WutiShhajPHQl4I9LNCENaJoRMw7m+TI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q175gs7D0pztRPVwxclMqLGW+yy1lqQmLheHqLknpuGmBVqB9OqGQKcnWzNCryjQroQRuznqHPfRmEki5F2tIM+T7WrRdXIiuFAzje6lvbH8g2YaHmioL0kGkPJh0j1muZPiLlyvXeZAHWrFPio4AjbdZ2dvjXhCrdvUUZXWqGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=q3jfhc+5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E5265201A0;
	Fri, 15 Nov 2024 09:33:54 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YkNgio-ImPS6; Fri, 15 Nov 2024 09:33:54 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AD67E205CF;
	Fri, 15 Nov 2024 09:33:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AD67E205CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731659633;
	bh=dBTIiockHmN0iKZvSPScfk+kaqoE1oRqQYyxxoEeSYc=;
	h=From:To:CC:Subject:Date:From;
	b=q3jfhc+5zt+Yz5UP5dZ0gtjFw5U6te217EyQeppXuhISPJMg/fPU4wKWcLQpEcXfg
	 Uea9lNntKGpJDEK2QdEOGJoF4pR9C8I97QgHah5TWYwG14Y1OXL4W4L182j6fr2ncF
	 3mT5KpK6kiXGEV45k59yWjBwYS+kJRhE3aYz+S9Sk43/doZdueNseg73PR7rdkvl71
	 s7OMPoNWtkVRuCCszWZhDsk/T72nkNeUOhX/AZuS/u0mIG9CwqnRxVLlGz/ab7Czmc
	 ghM0OPQBu/ppNYPv3TxyO48xMPp6PPT3hVXvU/0lyHFs6HgRY2qoggYBLb+/f/Dvjk
	 XJ+nssf7Yv/iw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 09:33:53 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 09:33:52 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A77C631843D6; Fri, 15 Nov 2024 09:33:52 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/11] pull request (net-next): ipsec-next 2024-11-15
Date: Fri, 15 Nov 2024 09:33:32 +0100
Message-ID: <20241115083343.2340827-1-steffen.klassert@secunet.com>
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

1) Add support for RFC 9611 per cpu xfrm state handling.

2) Add inbound and outbound xfrm state caches to speed up
   state lookups.

3) Convert xfrm to dscp_t. From Guillaume Nault.

4) Fix error handling in build_aevent.
   From Everest K.C.

5) Replace strncpy with strscpy_pad in copy_to_user_auth.
   From Daniel Yang.

6) Fix an uninitialized symbol during acquire state insertion.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit ab101c553bc1f76a839163d1dc0d1e715ad6bb4e:

  neighbour: use kvzalloc()/kvfree() (2024-10-28 18:12:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2024-11-15

for you to fetch changes up to a35672819f8d85e2ae38b80d40b923e3ef81e4ea:

  xfrm: Fix acquire state insertion. (2024-11-15 07:25:14 +0100)

----------------------------------------------------------------
ipsec-next-2024-11-15

----------------------------------------------------------------
Daniel Yang (1):
      xfrm: replace deprecated strncpy with strscpy_pad

Everest K.C (1):
      xfrm: Add error handling when nla_put_u32() returns an error

Guillaume Nault (4):
      xfrm: Convert xfrm_get_tos() to dscp_t.
      xfrm: Convert xfrm_bundle_create() to dscp_t.
      xfrm: Convert xfrm_dst_lookup() to dscp_t.
      xfrm: Convert struct xfrm_dst_lookup_params -> tos to dscp_t.

Steffen Klassert (6):
      xfrm: Add support for per cpu xfrm state handling.
      xfrm: Cache used outbound xfrm states at the policy.
      xfrm: Add an inbound percpu state cache.
      xfrm: Restrict percpu SA attribute to specific netlink message types
      Merge branch 'xfrm: Convert __xfrm4_dst_lookup() and its callers to dscp_t.'
      xfrm: Fix acquire state insertion.

 include/net/netns/xfrm.h  |   1 +
 include/net/xfrm.h        |  17 ++++-
 include/uapi/linux/xfrm.h |   2 +
 net/ipv4/esp4_offload.c   |   6 +-
 net/ipv4/xfrm4_policy.c   |   3 +-
 net/ipv6/esp6_offload.c   |   6 +-
 net/key/af_key.c          |   7 +-
 net/xfrm/xfrm_compat.c    |   6 +-
 net/xfrm/xfrm_input.c     |   2 +-
 net/xfrm/xfrm_policy.c    |  28 +++++---
 net/xfrm/xfrm_state.c     | 171 +++++++++++++++++++++++++++++++++++++++++++---
 net/xfrm/xfrm_user.c      |  75 ++++++++++++++++++--
 12 files changed, 284 insertions(+), 40 deletions(-)

