Return-Path: <netdev+bounces-137805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB629A9E64
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3DC281CED
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB3A19885B;
	Tue, 22 Oct 2024 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="eYcj3lFu"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A01494CA
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588990; cv=none; b=eLyPaXtspRQHS5WVid8BR6U60TihjyUil/tWTpd7DQY2LahN5I38Ty9qdUSczgIEokNWngLySGU2DPmDRMHXQMr+XWyKdNCX2tKH6VPWdYhfCZzOp7h8oI6aMB9l0TC6lLPj3FDP9FJLdWvjhE9ENVxJ7NJqK0eedNT70jGZOD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588990; c=relaxed/simple;
	bh=iQw3YGm6GSjRhjlvwQyiid7hdggoSRH2JXYVbt0ZQFg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2K/8OkRev2ZqjmC/47u638+edaLlWq1rPYuc0b4ZXZ4rqiG+qSkF0/6ZqvmopWujuudlMerXDs6C3XROH9EA45udoLt0elg1nK6FRdB5wJ9XHCqj1pwxBDzTt0cdIp1SsfZsSq1Lm29RqOE0f/Wtr0KheKUAGhF96Kue3yqMR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eYcj3lFu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 613D52087D;
	Tue, 22 Oct 2024 11:23:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UZAIEnqHKqb2; Tue, 22 Oct 2024 11:23:00 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DB7332083E;
	Tue, 22 Oct 2024 11:22:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DB7332083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729588979;
	bh=T8JYjKQRvunTW/OMcEcY9HBmCVyz6p7UZEsaMK1sNH8=;
	h=From:To:CC:Subject:Date:From;
	b=eYcj3lFuwaAhOlWz3Q1Uy2N69kRV/tnltyuvuwAduDKmFEipguwQ2P2r6t/89pZnM
	 n7G3WnZaHsBepd8xFgV2zgOSf6G22/x9XFzlJ7faTb7MY61H6bEgHu96JEwXlkqFih
	 JKe5bgb9pIMcAm+cwiG5u4gbpvebIXyGcaB65vtSZLOF2blmX0a+0N04za0fbRjZU2
	 HYpI89gjM1wk/4QrYWwQIYUvF1W3JtLH8toQNDIuOneTqZ4tNMozwsnNR1Cdu3w3qM
	 BqBSr8YpPhd9v8ct9r0lDyFqngeeN4HecbDGRq/qM07SWST/+dnf0qQDrFN7ocOZVI
	 wt3zjHpIgb3Yw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 11:22:29 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 11:22:29 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 08B4A3184BFB; Tue, 22 Oct 2024 11:22:29 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/5] pull request (net): ipsec 2024-10-22
Date: Tue, 22 Oct 2024 11:22:21 +0200
Message-ID: <20241022092226.654370-1-steffen.klassert@secunet.com>
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

1) Fix routing behavior that relies on L4 information
   for xfrm encapsulated packets.
   From Eyal Birger.

2) Remove leftovers of pernet policy_inexact lists.
   From Florian Westphal.

3) Validate new SA's prefixlen when the selector family is
   not set from userspace.
   From Sabrina Dubroca.

4) Fix a kernel-infoleak when dumping an auth algorithm.
   From Petr Vaganov.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 7ebf44c910690a7097442d4dd68f12315569b2f4:

  MAINTAINERS: adjust file entry of the oa_tc6 header (2024-09-22 19:55:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2024-10-22

for you to fetch changes up to 6889cd2a93e1e3606b3f6e958aa0924e836de4d2:

  xfrm: fix one more kernel-infoleak in algo dumping (2024-10-11 09:00:03 +0200)

----------------------------------------------------------------
ipsec-2024-10-22

----------------------------------------------------------------
Eyal Birger (2):
      xfrm: extract dst lookup parameters into a struct
      xfrm: respect ip protocols rules criteria when performing dst lookups

Florian Westphal (1):
      xfrm: policy: remove last remnants of pernet inexact list

Petr Vaganov (1):
      xfrm: fix one more kernel-infoleak in algo dumping

Sabrina Dubroca (1):
      xfrm: validate new SA's prefixlen using SA family when sel.family is unset

 include/net/netns/xfrm.h |  1 -
 include/net/xfrm.h       | 28 +++++++++++++------------
 net/ipv4/xfrm4_policy.c  | 40 ++++++++++++++++--------------------
 net/ipv6/xfrm6_policy.c  | 31 ++++++++++++++--------------
 net/xfrm/xfrm_device.c   | 11 +++++++---
 net/xfrm/xfrm_policy.c   | 53 ++++++++++++++++++++++++++++++++++--------------
 net/xfrm/xfrm_user.c     | 10 +++++++--
 7 files changed, 103 insertions(+), 71 deletions(-)

