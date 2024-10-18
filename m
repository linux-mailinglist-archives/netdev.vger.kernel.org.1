Return-Path: <netdev+bounces-136981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3019A3D73
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCE81C21F04
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6617C61;
	Fri, 18 Oct 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LmqLmzuP"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090EC53AC;
	Fri, 18 Oct 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729251948; cv=none; b=XoxocmkVEj/wpjT7rHHG8wyzz5M3Bd8lghaBUrHb0LPthW+DVc/D1kW925HF+362DfeI5yq1sp3GpycP8C5CI4Uvm19Y312EXn+pPv+dgip6lpgtcMYW4ZmueFeSjPMvCkTasI5sNkzDwwFAAcIFW24F5b5bNjvlkytI6tAQU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729251948; c=relaxed/simple;
	bh=m+X5tGW60K4ToKsc6kC1i+2nKbRszs4xZ9HwqAkYk+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pVNz0HYpXgSabRFA9RAOca4mazrNMbdsdkBr+J6jDsu2KUeduron0mLpED/XM0E+Y8YXHPqZetcW9bIv2ek6Spxr1JXlC40ZuY4cIQIHjVXjNhNNO53JPc1S3FNADAIz28JTXZBnhUwIJhjirOlwRcns+zCzAdrHFGIf91ge7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LmqLmzuP; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729251937; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/M61x1cvogaG/HfRQ2l+U5zBrnsMrNgQXXlKMlMABF8=;
	b=LmqLmzuPogTqsaLbOcHEiRRtiueb1pRRYzbfG0IVG9OUpjSKSzzoJ9edu5fzNNKnE++fa0TJi3mGUbeFWoAG9R14oaMKVlklWDPGz0NWPR6ypn2gvceI5U+v/T5UGlZLEtQddS7f8eP4eQyMoItq6rEr73xERjZ3AT4vltnqtns=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WHO1lIZ_1729251935 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Oct 2024 19:45:36 +0800
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
Subject: [PATCH v5 net-next 0/3] udp: Add 4-tuple hash for connected sockets
Date: Fri, 18 Oct 2024 19:45:32 +0800
Message-Id: <20241018114535.35712-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces 4-tuple hash for connected udp sockets, to make
connected udp lookup faster. Test using udpgso_bench_tx/rx shows no
obvious difference w/ and w/o this patchset for unconnected socket
receiving (see v4 thread).

Patch1: Add a new counter for hslot2 named hash4_cnt, to avoid cache line
        miss when lookup.
Patch2 and 3: Implement 4-tuple hash for ipv4.
(That for ipv6 is in progress.)

The detailed motivation is described in Patch 3.

The 4-tuple hash increases the size of udp_sock and udp_hslot. Thus add it
with CONFIG_BASE_SMALL check, i.e., it's a no op with CONFIG_BASE_SMALL.

AFAICS the patchset can be further improved by:
(a) Better interact with hash2/reuseport. Now hash4 hardly affects other
mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
unnecessary.
(b) Support early demux and ipv6.

changelogs:
v4 -> v5 (Paolo Abeni):
- Add CONFIG_BASE_SMALL with which udp hash4 does nothing

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

v4:
https://lore.kernel.org/all/20241012012918.70888-1-lulie@linux.alibaba.com/
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

 include/linux/udp.h |  11 +++
 include/net/udp.h   | 111 +++++++++++++++++++++-
 net/ipv4/udp.c      | 217 +++++++++++++++++++++++++++++++++++++++-----
 net/ipv6/udp.c      |  17 ++--
 4 files changed, 317 insertions(+), 39 deletions(-)

--
2.32.0.3.g01195cf9f


