Return-Path: <netdev+bounces-113700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F3693F99F
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AD81C22100
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948B15B111;
	Mon, 29 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="LZSKDu6M"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6441823A9
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267498; cv=none; b=g6jS3chiGk3dNM5XIA4VGgU04rc2qT/GFTw6iTZdZ+DyDNwb+eC18oonNkV2ERDfQwTCmfNLifRKkIPOEDM6xu+hHN4U3T3vZEuvqbo4GezKHW0HHdR+dvge3j+eRcVdW94qayaNWNX+Qekar5whJGsQp2wEroxzJn0MaHthi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267498; c=relaxed/simple;
	bh=oJjZh5GjagpbHn4iOY8xAaEfKzSzYKMP40wSi+8uNV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OO2DacN4u1E7XJv4FcTVcqBl+7A2dUkSz3ZlVxVB6+BAPYAJGIS7x6rbc6DtxXUXYHXlDblQ+nfoTkDYzosf0UjzklBHDnkHV5CRCt2vHlDK6ud26+//ZN9TzAhyIAf4orESWBFbyZ2665w+vuOwkg79jEzBqF+f+LUdWyPhaJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=LZSKDu6M; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id CB65E7DA37;
	Mon, 29 Jul 2024 16:38:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=oJjZh5GjagpbHn4iOY8xAaEfKzSzYKMP40wSi+8uNV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2000/15]=20l2tp:=20simplify=20tunnel=20and=20session=20cle
	 anup|Date:=20Mon,=2029=20Jul=202024=2016:37:59=20+0100|Message-Id:
	 =20<cover.1722265212.git.jchapman@katalix.com>|MIME-Version:=201.0
	 ;
	b=LZSKDu6MRxLxxU/VezHXKRaPTG7VjceEwXig0WdamK9Umd2aHIQdUyJFPgWXpJTH7
	 Vy2HGfregwMk1X481BgiHJWBApzXLzZKGgVCSp0oxoHnE5VTpAwCcaS/yJya472gra
	 Gd/+dkG97U36G+rwaC82BtuJHiIMAWdETd9XGRcIJYvTm6XrStxUbQWXlERoJRU2Fz
	 HxG8IXSVN16h5FZgXqMt0GIv8cUtVnoQBOuw3bgMf9kTinXSRcXjQW/yY4N8yEtGNK
	 LgUEksIeEkuif7heR6ggJva3e27h2FtLSo5LzSQkyFG9j2YLT7PcNVdTK6UIcBhM7Z
	 DmkabQKqpOY+A==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 00/15] l2tp: simplify tunnel and session cleanup
Date: Mon, 29 Jul 2024 16:37:59 +0100
Message-Id: <cover.1722265212.git.jchapman@katalix.com>
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

 * refactor l2tp_ppp pppox socket / session relationship to have the
   session keep the socket alive, not the other way around. Previously
   the pppox socket held a ref on the session, which complicated
   session delete by having to go through the pppox socket destructor.

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


