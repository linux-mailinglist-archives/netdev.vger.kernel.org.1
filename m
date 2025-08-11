Return-Path: <netdev+bounces-212424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54FB20328
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DC918C192F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FFF2DEA98;
	Mon, 11 Aug 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="iu9cYTq0"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301D2DCC11
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904032; cv=none; b=EPcMiO7ym3o+9x+tsmN82d1pfl1DBBgjhHHG6STJjm/so8ryxpVH4j5enAzEhDcvhwHveU4SmNhBvtTp2zJTYdHxB53x3B5Xj1fvCLYqpob5pI1FxZAUUT6CsGz6KTI6z5KudkP50JQbu+4na9IpXqPCOjqK6NXgOKUt9Tm45vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904032; c=relaxed/simple;
	bh=RP0nMAbhmMqhT+b15D9nwQY8JJQKu5UmzFe58CFja60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=quDg50mR+XGZiwu48gJjiUbvoJH6fEy/7qJE4epB9zzmY8cvKbT7e9oBiswam4mY1saiNn+9SJoYR4Z8gpNuyAu4q0nZ5qXANebWr2FtVYQ/Un5ursnpkdhS8q/r3Lj0OohRUmnry0xnSTy2UBHxk3O2auwr+hzog25eVMBHuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=iu9cYTq0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 46230207FC;
	Mon, 11 Aug 2025 11:20:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dweYxDhFsg6c; Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B9DE6201D3;
	Mon, 11 Aug 2025 11:20:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B9DE6201D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1754904020;
	bh=AExMwnuk/C2ldQj9humzRZW0unjeaQKXjbk6GS6Yabc=;
	h=From:To:CC:Subject:Date:From;
	b=iu9cYTq0ezzykzproe902PGE4sDPELdvBSYG8UlIBQRxm+FnPuufCVBIpNpfqb5d8
	 JcbE3dSIvlyB+dG+VOdqE0AJpQUomqhT7/iSK3B7gilU5fwOaZLkjUkMXaJ2ekYERr
	 Gay+in5oDCqNJGJ1+E/WS77Px2p+C3yOe5vbL9NJB7VmD1fYlh2p99Uz7mDu8qsMHT
	 RKbFlOALibJAPl1Uf1M86itpdbiO7sPvbIPPG4kGJ/wHMtArxQqJe1ZYVDJBmtgv1F
	 LA7pYPOABdW/lDMKnvUKS5foPyVW5HdIQjeb92Ay+A1kMOwp5E0zP/NWJjrfvuNmhw
	 2xuGiH9z6T5/A==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 11 Aug
 2025 11:20:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id EF5933183F80; Mon, 11 Aug 2025 11:20:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/4] pull request (net): ipsec 2025-08-11
Date: Mon, 11 Aug 2025 11:19:28 +0200
Message-ID: <20250811092008.731573-1-steffen.klassert@secunet.com>
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

1) Fix flushing of all states in xfrm_state_fini.
   From Sabrina Dubroca.

2) Fix some IPsec software offload features. These
   got lost with some recent HW offload changes.
   From Sabrina Dubroca.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit d942fe13f72bec92f6c689fbd74c5ec38228c16a:

  net: ti: icssg-prueth: Fix skb handling for XDP_PASS (2025-08-05 18:03:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2025-08-11

for you to fetch changes up to d8369183a01a9f06f08c5d52e2667035e66b9957:

  Merge branch 'xfrm: some fixes for GSO with SW crypto' (2025-08-08 10:44:23 +0200)

----------------------------------------------------------------
ipsec-2025-08-11

----------------------------------------------------------------
Sabrina Dubroca (4):
      xfrm: flush all states in xfrm_state_fini
      xfrm: restore GSO for SW crypto
      xfrm: bring back device check in validate_xmit_xfrm
      udp: also consider secpath when evaluating ipsec use for checksumming

Steffen Klassert (1):
      Merge branch 'xfrm: some fixes for GSO with SW crypto'

 net/ipv4/udp_offload.c  |  2 +-
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/xfrm/xfrm_device.c  | 12 +++++++++---
 net/xfrm/xfrm_state.c   |  2 +-
 4 files changed, 12 insertions(+), 6 deletions(-)

