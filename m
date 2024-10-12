Return-Path: <netdev+bounces-134752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD199AFD9
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 03:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA61F222FB
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A984C8FE;
	Sat, 12 Oct 2024 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mVnDzKWb"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D888BFF;
	Sat, 12 Oct 2024 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728696564; cv=none; b=m7qkXgQiWJBg8bE/dXOyAIoX1urat02qbJecnmTZem9t9x1H3r2amAdX6OIoLYi/An3xkF3EKkI2ah/dI/WzTS2NzO/AFHaFqbmhJkxpe7OGJgsXdI4QAJIK9w+rJ+g8Z0ycZyxj8CvhXpy5QPsf25xCoQrEfyPBW9QJLsihwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728696564; c=relaxed/simple;
	bh=7jiG/fRSq+U0LXUDMEXvtQSAhZnssKsRloLNU2HqGsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mUrh4Bx7YHl4UCANomJgnQyBK1iQqo9v+XJAYu+YKizKvs4Sj1ANE9Kpziar0lgojO7R0GGlon9J3gQMvOFdOrBmdUe1kxMOWy0U/bWd+aUQFDPBIIol57ku+9xVgVmkE1TYRk/FGUzdKdOy8qTMuhgCvdqW4iLD3R2kD6SYbao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mVnDzKWb; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728696559; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rRBgRPQ2Lla6nmMzz8VSrz5pG+Gi6fjFSiGQej3I8gk=;
	b=mVnDzKWbdCdHacvQOjkb95Kro9AWs9eIsdjr2lVgEkYwrdjGc6/YH6B+ttOjGWNxMsZiwIcNqx5K90CQNrsJ5bYMgZoEIous1pIO8WCnaI6lAsy/xpiV8T2GOrRrStR7ti6H5fQ2LXrEE2eNLxUOsVZxpKppt7cS8USqRoXk1Q4=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WGt8qkA_1728696558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 12 Oct 2024 09:29:18 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	antony.antony@secunet.com,
	steffen.klassert@secunet.com,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	jakub@cloudflare.com,
	fred.cc@alibaba-inc.com,
	yubing.qiuyubing@alibaba-inc.com
Subject: [PATCH v4 net-next 0/3] udp: Add 4-tuple hash for connected sockets
Date: Sat, 12 Oct 2024 09:29:15 +0800
Message-Id: <20241012012918.70888-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces 4-tuple hash for connected udp sockets, to make
connected udp lookup faster.

Patch1: Add a new counter for hslot2 named hash4_cnt, to avoid cache line
        miss when lookup.
Patch2 and 3: Implement 4-tuple hash for ipv4.
(That for ipv6 is in progress.)

The detailed motivation is described in Patch 3.

AFAICS the patchset can be further improved by:
(a) Better interact with hash2/reuseport. Now hash4 hardly affects other
mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
unnecessary.
(b) Support early demux and ipv6.

changelogs:
v3 -> v4:
- fix mistakes in udp_pernet_table_alloc() (Willem de Bruijn)

RFCv2 -> v3 (Gur Stavi):
- minor fix in udp_hashslot2() and udp_table_init()
- add rcu sync in rehash4()

RFCv1 -> RFCv2:
- add a new struct for hslot2
- remove the sockopt UDP_HASH4 because it has little side effect for
  unconnected sockets
- add rehash in connect()
- re-organize the patch into 3 smaller ones
- other minor fix

v3:
https://lore.kernel.org/all/20241010090351.79698-1-lulie@linux.alibaba.com/
RFCv2:
https://lore.kernel.org/all/20240924110414.52618-1-lulie@linux.alibaba.com/
RFCv1:
https://lore.kernel.org/all/20240913100941.8565-1-lulie@linux.alibaba.com/

Philo Lu (3):
  net/udp: Add a new struct for hash2 slot
  net/udp: Add 4-tuple hash list basis
  ipv4/udp: Add 4-tuple hash for connected socket

 include/linux/udp.h |   7 ++
 include/net/udp.h   |  44 ++++++++--
 net/ipv4/udp.c      | 197 ++++++++++++++++++++++++++++++++++++++------
 net/ipv6/udp.c      |  17 ++--
 4 files changed, 225 insertions(+), 40 deletions(-)

--
2.32.0.3.g01195cf9f


