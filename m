Return-Path: <netdev+bounces-161063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 522ACA1D0D1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 07:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09387A33A2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6511C1FC7F3;
	Mon, 27 Jan 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="voOonaOB"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F615C13A
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958087; cv=none; b=DHn7gJRR+FshAPD6MvYMCsPbM3whmKna482OjAkR9ETo5Q2Io4E+IYkoJXfS3bhAw43xI1eUsb8ALZApTDX/EC+4VXM5BUh+5zvA7H/HizR+1j1P2/Toh5QhmUDC0Bxvx5vCI4vcA9yl0KoWMDt88SMdcSayOBRtolTTR6IXC+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958087; c=relaxed/simple;
	bh=lXQ51tKKhR7BNwhn8ASJ+7YNtA/DKLP6LOLLma5kZow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nkaKKQGIzQtcLivViqD3QzkFEp06LJ568vkUB+pgBylRA3GD4mhz5l6r1YtDYxIcsqJA31HMeCV8WonBYWk1LcvqjPYsd1MSS7C8xDUfSoG8ZO9RguGXH3Hhi0XYbIWRgpWl+5d+Nad33cG4h+PsTY2+LTqloIjClX+FUqvOqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=voOonaOB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 29DEF2074F;
	Mon, 27 Jan 2025 07:08:03 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SbqEpdhwsqDQ; Mon, 27 Jan 2025 07:08:02 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 110F8207B2;
	Mon, 27 Jan 2025 07:08:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 110F8207B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737958081;
	bh=2nIEm+ym58VpH7EgQQg1KPaQcWk0KzYEeqmePv792Yc=;
	h=From:To:CC:Subject:Date:From;
	b=voOonaOBBMfnp61XEBXtwOjh3cfU/7gwxik8QEpMnkNfIgAzkxut82XWMgCPNQp+Z
	 LgERTqqA8SxLX+5dmlLfpDsuniV7wp4gnoLmE05LpOdds8mLe70usDSE3+dB5uED9g
	 oDeLoqhaTkiNdC4J1CGinErUaCXGvMAOeoUkw1EFt2kTPAdeCfG8raFCs4X+YrxJI4
	 FhAQdjt2feODmEzGuA4sTX7ViKQBBQjrfjXNMOqWr5WS5CrsYh9lcA5mCi0b6ApNWI
	 HAa5/Ktnazp5GxyZF+WOey4B4KGLGKDvR8yznUuTdzoiynyRB+XQB+22ctd1kggKBC
	 71JlrI+Rx65eg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 Jan 2025 07:08:00 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 07:08:00 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id C51613183BF2; Mon, 27 Jan 2025 07:07:59 +0100 (CET)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/5] pull request (net): ipsec 2025-01-27
Date: Mon, 27 Jan 2025 07:07:52 +0100
Message-ID: <20250127060757.3946314-1-steffen.klassert@secunet.com>
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

1) Fix incrementing the upper 32 bit sequence numbers for GSO skbs.
   From Jianbo Liu.

2) Fix an out-of-bounds read on xfrm state lookup.
   From Florian Westphal.

3) Fix secpath handling on packet offload mode.
   From Alexandre Cassen.

4) Fix the usage of skb->sk in the xfrm layer.

5) Don't disable preemption while looking up cache state
   to fix PREEMPT_RT.
   From Sebastian Sewior.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 9bb88c659673003453fd42e0ddf95c9628409094:

  selftests: net: test extacks in netlink dumps (2024-11-24 17:00:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2025-01-27

for you to fetch changes up to 6c9b7db96db62ee9ad8d359d90ff468d462518c4:

  xfrm: Don't disable preemption while looking up cache state. (2025-01-24 07:46:11 +0100)

----------------------------------------------------------------
ipsec-2025-01-27

----------------------------------------------------------------
Alexandre Cassen (1):
      xfrm: delete intermediate secpath entry in packet offload mode

Florian Westphal (1):
      xfrm: state: fix out-of-bounds read during lookup

Jianbo Liu (1):
      xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO

Sebastian Sewior (1):
      xfrm: Don't disable preemption while looking up cache state.

Steffen Klassert (1):
      xfrm: Fix the usage of skb->sk

 include/net/xfrm.h             | 16 ++++++--
 net/ipv4/esp4.c                |  2 +-
 net/ipv6/esp6.c                |  2 +-
 net/ipv6/xfrm6_output.c        |  4 +-
 net/xfrm/xfrm_interface_core.c |  2 +-
 net/xfrm/xfrm_output.c         |  7 ++--
 net/xfrm/xfrm_policy.c         |  2 +-
 net/xfrm/xfrm_replay.c         | 10 +++--
 net/xfrm/xfrm_state.c          | 93 ++++++++++++++++++++++++++++++++----------
 9 files changed, 100 insertions(+), 38 deletions(-)

