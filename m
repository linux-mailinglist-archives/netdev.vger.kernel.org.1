Return-Path: <netdev+bounces-178026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36EA740B7
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 23:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83EFD3BAF9A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68B71DE883;
	Thu, 27 Mar 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFkgnKK2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93188136358
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114203; cv=none; b=HH46xffMJv6gw5keyg82dZnx29NFambW8hWrkAIyDR86mi3rdRzFGfqAfHAJcNjl4P1fksSjWFrXT4gOv7l8lHK+SyBz6DylhLAAS7QGcv0LJXfaBceNXIy13yOyotZBLO9nR26INu+t/LcpVmzmEJ4s/Qa0gFAcxew+I+RNr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114203; c=relaxed/simple;
	bh=VoS66EE8NIhT3f+pRm2dGo7d3ohKlYne4lc80gLkDjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlKlN1Ujdx39PJU8PkujpFHLr0MWskOetZIcn3WIDBxleEK0oczIPwcgDGY3mMQleIBPHuXEGkMkWOTFiolyNwOuG6iKEwJtcJBZ2gEcCqXESz+yFGgjlAYKk7J+cBS5ztcoMWrLRLBF4QCVj/3F3Broi5GtDM9s8jzUvYUi5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFkgnKK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E5BC4CEDD;
	Thu, 27 Mar 2025 22:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743114202;
	bh=VoS66EE8NIhT3f+pRm2dGo7d3ohKlYne4lc80gLkDjs=;
	h=From:To:Cc:Subject:Date:From;
	b=kFkgnKK2UNcgu9x3sDlr2w9mJRpG34K74uS/380+FQ1Y8vDpgwW8t2QJ2GQZXXbFx
	 8r2yZoi7wg/tAD+UG2e6XffB3jMHongLtu9kMCy+lIzPJI9EyqWd9FGKo2KajaLG8H
	 fezMtdGfp0yw0blbuP5YDrV4F42DvQfPUi1q1oQ+FgiA+5Z5camXesA6lWAGt5pq25
	 d+Nxe4Q4QdIpgXirIrKsrzKVU5BC77Wz+goHV3ykbs7gigTPoGE2nKj/MItXhbicQM
	 jd73M27t6yp7CGC6LXU0SdPejOfjTO0Bv7gFBe7KjTIPowXt+qs1aij/6uAi0uxBx5
	 cWDcC41mwOMMQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v3 0/3] selftests: drv-net: replace the rpath helper with Path objects
Date: Thu, 27 Mar 2025 15:23:12 -0700
Message-ID: <20250327222315.1098596-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trying to change the env.rpath() helper during the development
cycle was causing a lot of conflicts between net and net-next.
Let's get it converted now that the trees are converged.

v2: https://lore.kernel.org/20250306171158.1836674-1-kuba@kernel.org

Jakub Kicinski (3):
  selftests: drv-net: replace the rpath helper with Path objects
  selftests: net: use the dummy bpf from net/lib
  selftests: net: use Path helpers in ping

 .../selftests/drivers/net/hw/xdp_dummy.bpf.c  | 13 ------------
 tools/testing/selftests/net/xdp_dummy.bpf.c   | 13 ------------
 tools/testing/selftests/drivers/net/hds.py    |  2 +-
 .../testing/selftests/drivers/net/hw/csum.py  |  2 +-
 tools/testing/selftests/drivers/net/hw/irq.py |  2 +-
 .../selftests/drivers/net/lib/py/env.py       | 21 +++++++------------
 tools/testing/selftests/drivers/net/ping.py   | 15 +++++--------
 tools/testing/selftests/drivers/net/queues.py |  4 ++--
 tools/testing/selftests/net/udpgro_bench.sh   |  2 +-
 tools/testing/selftests/net/udpgro_frglist.sh |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
 tools/testing/selftests/net/veth.sh           |  2 +-
 12 files changed, 22 insertions(+), 58 deletions(-)
 delete mode 100644 tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c
 delete mode 100644 tools/testing/selftests/net/xdp_dummy.bpf.c

-- 
2.49.0


