Return-Path: <netdev+bounces-149153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C249E47AE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0844B188035A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F6199FA4;
	Wed,  4 Dec 2024 22:18:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83063171CD
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350688; cv=none; b=j3h25LEqLqqqj3HwklN43D0c7YmLBiXmOvndwcCqhppwRO3zJIIQlz7iCO4MWcs8oiZ2ms9k/HfXIOyS5zhtFE0EFAl1fZnPEL8gKQfscdfhfFm+Hk85MCFL5F6WA/iooQMhE3GU9HqvSXYYHbAiL/uFle3ANi4ctyTtgyHd3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350688; c=relaxed/simple;
	bh=zcvbYn4KUK0Gg4vJfjt5PsCBsDpPY3OlhNA8CYr9Kfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6Y12jTACLN7eMytb6X6BKTCF0Eh7OQMg+NWd9Lke9+HyfUtI0BhYAneX4Hop9y2zS1ndOjbfiUAIUyCXlb7nlZoXxrgkqlIJ0RA/2/Xtmn5ovtop/AwHPmztDXocUbDOwYikWN2wfIp8moRTppqN/swOVMOY7BaiP/JmyxUBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 233355A061F; Wed, 04 Dec 2024 23:12:54 +0100 (CET)
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mike Manning <mvrmanning@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paul Holzinger <pholzing@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Cambda Zhu <cambda@linux.alibaba.com>,
	Fred Chen <fred.cc@alibaba-inc.com>,
	Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
Subject: [PATCH net-next 0/2] Fix race between datagram socket address change and rehash
Date: Wed,  4 Dec 2024 23:12:52 +0100
Message-ID: <20241204221254.3537932-1-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 2/2 fixes a race condition in the lookup of datagram sockets
between address change (triggered by connect()) and rehashing. The
issue occurs regardless of the type of hash, that is, it happens with
updates to the secondary hash as well as to the newly introduced
four-tuple hash.

Patch 1/2 is a small optimisation to simplify 2/2.

This is essentially a rebase onto current net-next of the RFC I
originally posted against 'net', before the 6.13 merge window,
at:

  https://lore.kernel.org/netdev/20241114215414.3357873-1-sbrivio@redhat.com/

with a couple of minor changes described in the single patch messages.

The rebase is not trivial as four-tuple hashes were introduced
meanwhile, with commits 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for
connected socket"), 78c91ae2c6de ("ipv4/udp: Add 4-tuple hash for
connected socket"), and their dependencies, but the race condition,
described in detail in the commit message for 1/2, is exactly the same
as before.

Stefano Brivio (2):
  datagram: Rehash sockets only if local address changed for their
    family
  datagram, udp: Set local address and rehash socket atomically against
    lookup

 include/net/inet_hashtables.h | 13 ++++++
 include/net/sock.h            |  2 +-
 include/net/udp.h             |  3 +-
 net/core/sock.c               | 12 ++++-
 net/ipv4/datagram.c           |  7 +--
 net/ipv4/inet_hashtables.c    | 13 ------
 net/ipv4/udp.c                | 84 +++++++++++++++++++++++------------
 net/ipv4/udp_impl.h           |  2 +-
 net/ipv4/udplite.c            |  2 +-
 net/ipv6/datagram.c           | 30 +++++++++----
 net/ipv6/udp.c                | 31 +++++++------
 net/ipv6/udp_impl.h           |  2 +-
 net/ipv6/udplite.c            |  2 +-
 13 files changed, 130 insertions(+), 73 deletions(-)

-- 
2.40.1


