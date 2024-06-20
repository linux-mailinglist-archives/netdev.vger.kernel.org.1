Return-Path: <netdev+bounces-105219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444E910287
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1442A283958
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1301AB8F6;
	Thu, 20 Jun 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="XZetCqS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0BE1A8C1D
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883042; cv=none; b=VIfUDAb5NAGszS9ceazQnmGDBxeXLLn94owjs44wPt0BwvVNDcGyn4AONuZftD5/tWrHC6TwbYbdfoqABFkMPRW5xz87vmf1i2W2lVNeZ3G11bzlWMNCG2cmy6wGscx7xt515ewPerLqWOJlaYEmB7YN9kFV0Q703mRoLpZSgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883042; c=relaxed/simple;
	bh=QJyJ0bQzC5MGuUivX7e61SWdHW0ZwXMM3oNTUF53vws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JclKskoEjdq2+gx68f+q5cVDVhvwLiz65ulKldWCldqdi9Gc8wTSILcDpF9qw3QpqgX0MYK7U+rogBBxmNh0ldM030Hn1Kse1TSSO9qHLkT0qoqrfjRQ5UhteamGcQFkc9YjSNsz2DnCoJdscMOxpA/i5kYt3ePNuPVEmRQZ2P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=XZetCqS9; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id F24D37D853;
	Thu, 20 Jun 2024 12:22:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882565; bh=QJyJ0bQzC5MGuUivX7e61SWdHW0ZwXMM3oNTUF53vws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=200/8]=20l2tp:=20don't=20use=20the=20tunnel=20socke
	 t's=20sk_user_data=20in=20datapath|Date:=20Thu,=2020=20Jun=202024=
	 2012:22:36=20+0100|Message-Id:=20<cover.1718877398.git.jchapman@ka
	 talix.com>|MIME-Version:=201.0;
	b=XZetCqS9n6UDWgAOXT1jj2mT49b/4N9DlsnjFZ2RqA9IiqDJ4lp/QjT8aPcCal5UA
	 GktCa6287OrKt7T9nUGJtIhe20IuRELKDOSe+e2+36/qZ1hDc2MQTzyvU+kIT/21YH
	 inwXh/I/sCAnvBtq5xgV8sqmTMblBpGWYf6mRpRqn0wqNw7D5CE1DL3HPgWVOB6Kj5
	 zr2mZ9SK7txVslI1GR5gMzjlhwglJ02kEHTCkkG0OxrmHcQyDd0TdaMi7NsiMLpOnp
	 +jcWIm4nBHbDFunM6SyYjJT6fAmc93lVGyDj2v9R07Y19n5nl3sOyW3s/FghuglcEe
	 dJjrPODpf0evw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 0/8] l2tp: don't use the tunnel socket's sk_user_data in datapath
Date: Thu, 20 Jun 2024 12:22:36 +0100
Message-Id: <cover.1718877398.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors l2tp to not use the tunnel socket's sk_user_data
in the datapath. The main reasons for doing this are

 * to allow for simplifying internal socket cleanup code (to be done
   in a later series)
 * to support multiple L2TPv3 UDP tunnels using the same 5-tuple
   address

When handling received UDP frames, l2tp's current approach is to look
up a session in a per-tunnel list. l2tp uses the tunnel socket's
sk_user_data to derive the tunnel context from the receiving socket.

But this results in the socket and tunnel lifetimes being very tightly
coupled and the tunnel/socket cleanup paths being complicated. The
latter has historically been a source of l2tp bugs and makes the code
more difficult to maintain. Also, if sockets are aliased, we can't
trust that the socket's sk_user_data references the right tunnel
anyway. Hence the desire to not use sk_user_data in the datapath.

The new approach is to lookup sessions in a per-net session list
without first deriving the tunnel:

 * For L2TPv2, the l2tp header has separate tunnel ID and session ID
   fields which can be trivially combined to make a unique 32-bit key
   for per-net session lookup.

 * For L2TPv3, there is no tunnel ID in the packet header, only a
   session ID, which should be unique over all tunnels so can be used
   as a key for per-net session lookup. However, this only works when
   the L2TPv3 session ID really is unique over all tunnels. At least
   one L2TPv3 application is known to use the same session ID in
   different L2TPv3 UDP tunnels, relying on UDP address/ports to
   distinguish them. This worked previously because sessions in UDP
   tunnels were kept in a per-tunnel list. To retain support for this,
   L2TPv3 session ID collisions are managed using a separate per-net
   session hlist, keyed by ID and sk. When looking up a session by ID,
   if there's more than one match, sk is used to find the right one.

L2TPv3 sessions in IP-encap tunnels are already looked up by session
ID in a per-net list. This work has UDP sessions also use the per-net
session list, while allowing for session ID collisions. The existing
per-tunnel hlist becomes a plain list since it is used only in
management and cleanup paths to walk a list of sessions in a given
tunnel.

For better performance, the per-net session lists use IDR. Separate
IDRs are used for L2TPv2 and L2TPv3 sessions to avoid potential key
collisions.

These changes pass l2tp regression tests and improve data forwarding
performance by about 10% in some of my test setups.

James Chapman (8):
  l2tp: remove unused list_head member in l2tp_tunnel
  l2tp: store l2tpv3 sessions in per-net IDR
  l2tp: store l2tpv2 sessions in per-net IDR
  l2tp: refactor udp recv to lookup to not use sk_user_data
  l2tp: don't use sk_user_data in l2tp_udp_encap_err_recv
  l2tp: use IDR for all session lookups
  l2tp: drop the now unused l2tp_tunnel_get_session
  l2tp: replace hlist with simple list for per-tunnel session list

 net/l2tp/l2tp_core.c    | 501 ++++++++++++++++++++++------------------
 net/l2tp/l2tp_core.h    |  43 ++--
 net/l2tp/l2tp_debugfs.c |  13 +-
 net/l2tp/l2tp_ip.c      |   2 +-
 net/l2tp/l2tp_ip6.c     |   2 +-
 net/l2tp/l2tp_netlink.c |   6 +-
 net/l2tp/l2tp_ppp.c     |   6 +-
 7 files changed, 308 insertions(+), 265 deletions(-)

-- 
2.34.1


