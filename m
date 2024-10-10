Return-Path: <netdev+bounces-134124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A4299818D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F801F20FB3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990B71C1AB3;
	Thu, 10 Oct 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jEezAqkO"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E681BF7F8;
	Thu, 10 Oct 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551043; cv=none; b=biAcLu9SIs5AJnikL9lCsqRG1IUOL8SAFiNx+3FMZrIaMDFR/wsibB8avDcQo5QjY08E1F5kmR7l2JzeeJeDngKT38sdRgkIuAHpME4k4fFNthhmVoMxPB5ALTE1URr1Ww5AQW4LlyOMmPuK5DM6f4AqFNJOjgi4BIHkq/xbWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551043; c=relaxed/simple;
	bh=w3anSwZqw6I9knXSRw9ObkagiR+NpU+WMwxHeVDnJIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hNXZNPAw4FY/zW/BoPIdr1CnTkvqeQtkWM0Hu3Hsh+jvo1MTDVt+mP+Q/EyojeBremrS3MN/WaHBLymDPZ+0AfBctKvyTo39p0wCmy1XcgZYv5T4s8vXNVtaX5ZGyy4sfIXsL+dV+RMngXRzLuz7vv1F+L+bkBy2VI2hpDTT/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jEezAqkO; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728551033; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AGtBVL2YZfCR6bDCz+2Rh0igBSoJdJKqjklo83MwYbc=;
	b=jEezAqkOrJCShC0HQTrJKcwXKqgonenEXX3bfxpqWXF5w/Vjyoek905+gpsT0CW4k4lvrRkj6cDOkIvRMtwTqSR85v3pNzI9F8BhVYh6157LK/Bwi4TczBrJnAWaCzPQ+3QYZNYOx6xozE9k6UQHZXRlPlkDU/qp88PEjALSR0s=
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WGll0IJ_1728551031 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:03:52 +0800
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
Subject: [PATCH v3 net-next 0/3] udp: Add 4-tuple hash for connected sockets
Date: Thu, 10 Oct 2024 17:03:48 +0800
Message-Id: <20241010090351.79698-1-lulie@linux.alibaba.com>
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

The detailed motivation is described in Patch 3.

AFAICS the patchset can be further improved by:
(a) Better interact with hash2/reuseport. Now hash4 hardly affects other
mechanisms, but maintaining sockets in both hash4 and hash2 lists seems
unnecessary.
(b) Support early demux and ipv6.

changelogs:
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
 net/ipv4/udp.c      | 199 ++++++++++++++++++++++++++++++++++++++------
 net/ipv6/udp.c      |  17 ++--
 4 files changed, 225 insertions(+), 42 deletions(-)

--
2.32.0.3.g01195cf9f


