Return-Path: <netdev+bounces-112594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6037A93A1FD
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A50128254B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA35153835;
	Tue, 23 Jul 2024 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="HGaSfKFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A6413775B
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742713; cv=none; b=Hsh0SY7wvsrz2j7QUaXZn3OgghbJn7/wdLvbOHVpLhSKvbq265K+thN4q6to7uQ22dSfy0DhISeDEJRavp6+tvbfeaP23nAaFbpNlN+SmkKsUswvakj1LMnnKmm2dXfkAnlDGqnMHFvVz9KI4YoeFV/JAuN3or/ze11qoUEr7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742713; c=relaxed/simple;
	bh=5PpD4uMZRDrWNla/OzKQoLgiKqSAt+MZKT9ZNQZXr3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bvdti0hkZwcLlYfs+4pWt57BMrFn5CPFVGBpvr6xoMuxljcmuSEK2u2GqvvkY8JQIt+nCVQA7FDO1BT4wggw3YVSG6RD+AKD7GMKVS56s7Lh4dKZfU9MWUUTRWiHbGRPPfQY9R5jd5nbTwAHFkXz4IuqJnQbydIfyn/CqwxjNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=HGaSfKFF; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id CE4267DA3E;
	Tue, 23 Jul 2024 14:51:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742705; bh=5PpD4uMZRDrWNla/OzKQoLgiKqSAt+MZKT9ZNQZXr3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2000/15]=20l2tp:=20simplify=20tunnel=20and=20session=20cleanup|
	 Date:=20Tue,=2023=20Jul=202024=2014:51:28=20+0100|Message-Id:=20<c
	 over.1721733730.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=HGaSfKFFHqv3mIgdFRrhWIbv7WXAFmQXay30ZVQTUEIyAbPuF0rdBQCcfft8kc5pY
	 e1v3xUg9iptokeE+JrOhuEabGoP7pwhO/JLJsQ2MCY8tHKbjP/Q0kulz0cWaFBMxwn
	 I0Gh4oqizcmV9NjUIzI1K/Y4/mdagUQZez+bMMUiNkNyZpmo5asIUX2FUjZF2m1itg
	 YxzE3J9ZgPzRSscbUlJpt07T96Bpx77tCqIVlNd+Kfz6yORVd+3E/2QdbdOw2z0d2a
	 ouWrYt/fXc9Qm7zSBlPFfQQRweU13s2tb9vmYex2hxPD2ovnQUgo1Xz6G3gR8ds2ZW
	 kNB5ImxRXEnBA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 00/15] l2tp: simplify tunnel and session cleanup
Date: Tue, 23 Jul 2024 14:51:28 +0100
Message-Id: <cover.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series simplifies and improves l2tp tunnel and session cleanup.

 * refactor l2tp management code to not use the tunnel socket's
   sk_user_data. This allows the tunnel and its socket to be closed
   and freed without sequencing the two using the socket's sk_destruct
   hook.

 * export ip_flush_pending_frames and use it when closing l2tp_ip
   sockets.

 * move the work of closing all sessions in the tunnel to the work
   queue so that sessions are deleted using the same codepath whether
   they are closed by user API request or their parent tunnel is
   closing.

 * refactor l2tp_ppp to have session lifetimes managed by the
   session's refcount such that the session holds a ref on its pppox
   socket while it references it. Previously the pppox socket held a
   ref on the session, which complicated session delete by having to
   go through the socket destructor.

 * free sessions and pppox sockets by rcu.

 * fix a possible tunnel refcount underflow.

 * avoid using rcu_barrier in net exit handler.

James Chapman (15):
  l2tp: lookup tunnel from socket without using sk_user_data
  ipv4: export ip_flush_pending_frames
  l2tp: have l2tp_ip_destroy_sock use ip_flush_pending_frames
  l2tp: don't use tunnel socket sk_user_data in ppp procfs output
  l2tp: don't set sk_user_data in tunnel socket
  l2tp: remove unused tunnel magic field
  l2tp: simplify tunnel and socket cleanup
  l2tp: delete sessions using work queue
  l2tp: free sessions using rcu
  l2tp: refactor ppp socket/session relationship
  l2tp: prevent possible tunnel refcount underflow
  l2tp: use rcu list add/del when updating lists
  l2tp: add idr consistency check in session_register
  l2tp: cleanup eth/ppp pseudowire setup code
  l2tp: use pre_exit pernet hook to avoid rcu_barrier

 net/ipv4/ip_output.c    |   1 +
 net/l2tp/l2tp_core.c    | 199 ++++++++++++++++++++++------------------
 net/l2tp/l2tp_core.h    |  14 +--
 net/l2tp/l2tp_eth.c     |   2 +-
 net/l2tp/l2tp_ip.c      |  13 ++-
 net/l2tp/l2tp_ip6.c     |   7 +-
 net/l2tp/l2tp_netlink.c |   4 +-
 net/l2tp/l2tp_ppp.c     | 107 ++++++++++-----------
 8 files changed, 179 insertions(+), 168 deletions(-)

-- 
2.34.1


