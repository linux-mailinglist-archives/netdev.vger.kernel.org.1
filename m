Return-Path: <netdev+bounces-141953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F89BCC6B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126071F23256
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E814C1D5143;
	Tue,  5 Nov 2024 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="auV0FI6c"
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD51420A8;
	Tue,  5 Nov 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808752; cv=none; b=FFEK+IUgfewgeJkroD0oAWLDK1JS4v3bFuLckqhXFry1qLF71Wu8pGPknzPwFSgJP7M37md70s/WWik2sOB4o4vao5yKsSP/GKnBVpTh0o7Djif2zJpQRJ+8epQFKwDnu9pDeMdOZ3yuYJzpROb6FVLzLlaEHWK/06KgLQxzk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808752; c=relaxed/simple;
	bh=dx5Uzu/K7lRZLazhG5uabV3QNjy5CjBhQEZFr4k/jrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfmpXbQgfgNfLcMrljIPtN26WoMztfXcAw9H9Zl+40S6eDbkAJKItC3+f86vYMEEjddB7zhT8GiYOHOILe+QmXEq/PiuH5vK3IyrEGuT/9+SyHr4NTSU+R1hALXd8J8Ap3vsdUCHKaf5edtR7PdnoSFZ2ldV9dFVxnMylOIBryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=auV0FI6c; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730808747; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Aw7cKbR7rHQWvHVFw+MGM3hfuFW9+t1ddKaNLpn9ENI=;
	b=auV0FI6cvm6+iRAHqSxVK/UA9B3IB03SlpuuKCZl1IIqJsAenMJScz9FcPVffCsM/dER7OVmQkEvDEiR/XpbBiqBnjQhJJnshAuzQSwkoHC8510HkzcspXMJx32UqFbbu4lv4cfEUCEfx8nO93J4iJEQk5tUjRkmPm+XzRKbP9k=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WImrjsa_1730808745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 20:12:26 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	antony.antony@secunet.com,
	steffen.klassert@secunet.com,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	jakub@cloudflare.com,
	fred.cc@alibaba-inc.com,
	yubing.qiuyubing@alibaba-inc.com
Subject: [PATCH v7 net-next 0/4] udp: Add 4-tuple hash for connected sockets
Date: Tue,  5 Nov 2024 20:12:21 +0800
Message-Id: <20241105121225.12513-1-lulie@linux.alibaba.com>
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

Stress test results (with 1 cpu fully used) are shown below, in pps:
(1) _un-connected_ socket as server
    [a] w/o hash4: 1,825176
    [b] w/  hash4: 1,831750 (+0.36%)

(2) 500 _connected_ sockets as server
    [c] w/o hash4:   290860 (only 16% of [a])
    [d] w/  hash4: 1,889658 (+3.1% compared with [b])
With hash4, compute_score is skipped when lookup, so [d] is slightly
better than [b].

Patch1: Add a new counter for hslot2 named hash4_cnt, to avoid cache line
        miss when lookup.
Patch2: Add hslot/hlist_nulls for 4-tuple hash.
Patch3 and 4: Implement 4-tuple hash for ipv4 and ipv6.

The detailed motivation is described in Patch 3.

The 4-tuple hash increases the size of udp_sock and udp_hslot. Thus add it
with CONFIG_BASE_SMALL, i.e., it's a no op with CONFIG_BASE_SMALL.

changelogs:
v6 -> v7 (Kuniyuki Iwashima):
- export udp_ehashfn to be used by udpv6 rehash

v5 -> v6 (Paolo Abeni):
- move udp_table_hash4_init from patch2 to patch1
- use hlist_nulls for lookup-rehash race
- add test results in commit log
- add more comment, e.g., for rehash4 used in hash4
- add ipv6 support (Patch4), and refactor some functions for better
  sharing, without functionality change

v4 -> v5 (Paolo Abeni):
- add CONFIG_BASE_SMALL with which udp hash4 does nothing

v3 -> v4 (Willem de Bruijn):
- fix mistakes in udp_pernet_table_alloc()

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

v6:
https://lore.kernel.org/all/20241031124550.20227-1-lulie@linux.alibaba.com/
v5:
https://lore.kernel.org/all/20241018114535.35712-1-lulie@linux.alibaba.com/
v4:
https://lore.kernel.org/all/20241012012918.70888-1-lulie@linux.alibaba.com/
v3:
https://lore.kernel.org/all/20241010090351.79698-1-lulie@linux.alibaba.com/
RFCv2:
https://lore.kernel.org/all/20240924110414.52618-1-lulie@linux.alibaba.com/
RFCv1:
https://lore.kernel.org/all/20240913100941.8565-1-lulie@linux.alibaba.com/

Philo Lu (4):
  net/udp: Add a new struct for hash2 slot
  net/udp: Add 4-tuple hash list basis
  ipv4/udp: Add 4-tuple hash for connected socket
  ipv6/udp: Add 4-tuple hash for connected socket

 include/linux/udp.h |  11 +++
 include/net/udp.h   | 135 ++++++++++++++++++++++++--
 net/ipv4/udp.c      | 232 +++++++++++++++++++++++++++++++++++++++-----
 net/ipv6/udp.c      | 111 ++++++++++++++++++---
 4 files changed, 447 insertions(+), 42 deletions(-)

--
2.32.0.3.g01195cf9f


