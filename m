Return-Path: <netdev+bounces-140707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0723E9B7B00
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390761C21BE1
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1119CC07;
	Thu, 31 Oct 2024 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZJgskhNk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE81BDE6;
	Thu, 31 Oct 2024 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378758; cv=none; b=cD8BJo/PAkUpMGqEYJLoL4G5Q4sqG8Yc2nPfASJSxBVnSPtcvs/8aFmbwHGJaaY4KOZoaRDlEripgK4wk5EJcCpIIqPHRvqQ8FK4ZxKUPVjboOT2x9htWqfu9NVLAUXfSLKAIPGlG2LH1SBWBVGmiCdZuOvpu2DnGwZB0k0go74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378758; c=relaxed/simple;
	bh=oCSW+fnf1tBoO4JBt7aamesAWxB2jxgKf52NRz3PZi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HhZEfsWKYWv80J/MO7bnfhZGLpsgmKrs5kmHny80hwQitX2cUAWZZYBknQgSNChpZCOiWgNlhZOLXlTuiwiPLs9wd1O5P5k0yS1gJhinCHJ4zvo9Vtu453G1o/HaZ8apNOYEzcOyV9amIpl+eAqQLvMU3Juz4VYHqijqDYV2WLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZJgskhNk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730378751; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=HAL37HaqXwJg22LBMQXI5TlK1NaJ8gkqtn8IwlD9Xuk=;
	b=ZJgskhNkszASReMS2DmK2PbVpcXHtIG5YrsFZUgqWfNCgHkZMkHN0ngnQ+x4rcnxSzqOi8BxnJIjKZTiLvn26gnYNTa8ywXclYpbeoLccsyfFXxOTLdXYYEFT/m2WzT3TFWM0DnsIC6EqxMsbalzQdBpg3ENrS12iLYxKeTF2JY=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WIIdMws_1730378750 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 20:45:51 +0800
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
Subject: [PATCH v6 net-next 0/4] udp: Add 4-tuple hash for connected sockets
Date: Thu, 31 Oct 2024 20:45:46 +0800
Message-Id: <20241031124550.20227-1-lulie@linux.alibaba.com>
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
 include/net/udp.h   | 133 +++++++++++++++++++++++--
 net/ipv4/udp.c      | 231 +++++++++++++++++++++++++++++++++++++++-----
 net/ipv6/udp.c      | 111 ++++++++++++++++++---
 4 files changed, 445 insertions(+), 41 deletions(-)

--
2.32.0.3.g01195cf9f


