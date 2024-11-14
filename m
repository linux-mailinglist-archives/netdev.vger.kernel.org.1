Return-Path: <netdev+bounces-145076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B86E19C94ED
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471FF284E37
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BCC1AED5C;
	Thu, 14 Nov 2024 22:02:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42DEEDE
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731621762; cv=none; b=JpccR7//Fx8coativ33f1vBUo24i6rKQ0m9ZgLJ4c0eNdPweL2s7z/JGdIRK2WLe3tiJ1RJ/G5mWI8XKsT3UC9HyxLjOpw6794NaU4GzjYaZNySIWKr8HlRw0bRUlheVSrtg5D+kvmQQoWkB1b8dGfuJK+c+BTtG90Tg6TfxWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731621762; c=relaxed/simple;
	bh=+FWR5JVjF5zxrFyAQNHR3sNtAd5ZYY9+FHl406wtlxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwqM1aL3K5xDGjIPyNChTuTU6PLjjGtFxikP6fg5+Tjavzr4+Yp3LLU5SxakZyUkWcqtAnrg5QM0+dfh3Bd6BpdmDwC8v/hYPjhDNTLKk182En/wxfPbAFmkD/9PfknsbRHIQTgFmG5VDuiz/cVjFR/VHdtZnM151DSfuY10aYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id 3F7595A0625; Thu, 14 Nov 2024 22:54:14 +0100 (CET)
From: Stefano Brivio <sbrivio@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Mike Manning <mmanning@vyatta.att-mail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Ed Santiago <santiago@redhat.com>,
	Paul Holzinger <pholzing@redhat.com>
Subject: [PATCH RFC net 0/2] Fix race between datagram socket address change and rehash
Date: Thu, 14 Nov 2024 22:54:12 +0100
Message-ID: <20241114215414.3357873-1-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 2/2 fixes a race condition in the lookup of datagram sockets
between address change (triggered by connect()) and rehashing.

Patch 1/2 is a small optimisation to simplify 2/2.

Stefano Brivio (2):
  datagram: Rehash sockets only if local address changed for their
    family
  datagram, udp: Set local address and rehash socket atomically against
    lookup

 include/net/sock.h  |  2 +-
 include/net/udp.h   |  3 +-
 net/core/sock.c     | 13 ++++++--
 net/ipv4/datagram.c |  7 +++--
 net/ipv4/udp.c      | 76 +++++++++++++++++++++++++++++++--------------
 net/ipv4/udp_impl.h |  2 +-
 net/ipv4/udplite.c  |  2 +-
 net/ipv6/datagram.c | 30 +++++++++++++-----
 net/ipv6/udp.c      | 17 ++++++----
 net/ipv6/udp_impl.h |  2 +-
 net/ipv6/udplite.c  |  2 +-
 11 files changed, 108 insertions(+), 48 deletions(-)

-- 
2.40.1


