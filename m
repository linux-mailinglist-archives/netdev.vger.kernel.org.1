Return-Path: <netdev+bounces-129518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1B984421
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C331C22E63
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524621A4E9B;
	Tue, 24 Sep 2024 11:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UYcozizA"
X-Original-To: netdev@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D01F5FF;
	Tue, 24 Sep 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175862; cv=none; b=hLG6y6MYsP6Xb4o3kBl0BK/EpKK73PP7J8FonvoGtAYKCwC/qHRkmyU+nj1m/W6ltd/DOd4h8ErjxZF4GFeRIvaPtHwTmfQuJhmEll12/FtuNjTF2tieUtBNaemm6FmRnupVsV7GLP850EHw2irOVkpMZwf5HMK/B8N7cLuk0+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175862; c=relaxed/simple;
	bh=1UzmaVwFDGIYfjRUdTy1AagijVC+WnAQiYfabGlH8bI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EQa1dFcLITQLRbSK5hrMRNAoCvVQN5kU8nd+qmJqs2YclSF9FXISVU0dIw7tp1PNiGCZKUC1d84WHspZYNJ07QAj77uJ3Zumh6EZs0mxppUs72LZJZCW7XcyftdlTQso2UGDPN6x3xry3o9QBrqTOlJZKv0Gb1JOZFnD9iD1rYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UYcozizA; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727175856; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4UXSF5iwt13McipWWCzjfRnIpDyc91GNs8UcvMTxxVs=;
	b=UYcozizAgmeNsU0n24jLyDs0K09ZLrB/DgiM/QyTT0Io9jYhfJCs4dpla0nl4G/7PHFvwxMRJupzf7yDQuAmsBBAVpuaDf9jQ6nzgXNs6iL3q9Onri75b+MpqHFUf90QKHmO4bqazdOKtZkuiW+jeieSujklfxO2HjByUOogA2g=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFgCs8F_1727175854)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 19:04:15 +0800
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
Subject: [RFC PATCHv2 net-next 0/3] udp: Add 4-tuple hash for connected sockets
Date: Tue, 24 Sep 2024 19:04:11 +0800
Message-Id: <20240924110414.52618-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC patchset introduces 4-tuple hash for connected udp sockets, to
make connected udp lookup faster. It is a tentative proposal and any
comment is welcome.

Patch1: Add a new counter for hslot2 named hash4_cnt, to avoid cache line
        miss when lookup.
Patch2 and 3: Implement 4-tuple hash for ipv4.

The detailed motivation is described in Patch 3.

AFAICT the patchset can be further improved by:
(a) Better interact with hash2/reuseport. Now hash4 hardly affects other
mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
unnecessary.
(b) Support early demux and ipv6.

changelogs:
RFCv1 -> RFCv2:
- add a new struct for hslot2
- remove the sockopt UDP_HASH4 because it has little side effect for
  unconnected sockets
- add rehash in connect()
- re-organize the patch into 3 smaller ones
- other minor fix

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
 4 files changed, 223 insertions(+), 42 deletions(-)

--
2.32.0.3.g01195cf9f


