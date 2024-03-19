Return-Path: <netdev+bounces-80526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0887FABB
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87790B21469
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF07CF29;
	Tue, 19 Mar 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKfGfVGt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D251C28
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840704; cv=none; b=iQnfcu5zekTjzCeeVsJ/22+jypZ1RPgZPK3ev5G4DM6fUUXqAA3nG3nihMrrTSHMHChU5/o08HyG/7rFef/oOf3jCocjqSYy8wBBu/GDoZt25WYqb+Lqg91mVWZO5uWAi9lFYV3Jqwy5qfbE+EPshRSMZ8Gso2iZvlrFfHMmj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840704; c=relaxed/simple;
	bh=06DDQt3csnEpW39mwgcIgrv6oQ/K/Y7HrFBITF81aUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gz/MA5mWzNwAGhGJKojfinRvDQoHkFl/lWGeZSxe9NICS9M8RRKcexkoaCTrg3/SKSQUuhsUCopS63kCPitT0p43QnQkEZQbkGOsURfiK6bfABnIMXVnfExmEss6yFUbaO0dRBdPCR3MnU4eUNGvm0inTE2YOFkQILzYITs9vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKfGfVGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EBDC43390;
	Tue, 19 Mar 2024 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710840703;
	bh=06DDQt3csnEpW39mwgcIgrv6oQ/K/Y7HrFBITF81aUQ=;
	h=From:To:Cc:Subject:Date:From;
	b=NKfGfVGt4hUCGUOUJrVXhSkYMmSFNuVEh0FcWt0tWoe4QZthTU5EkemWWcTBGWv3X
	 T/oq0H/AERtDNyJjj1FlqaJXiwellkilrVUhYEZfQn+HgYQ80ogztSNo/YZwttKf1I
	 hj2NlEiBXJiSVlLSPGGnODV9ovJXr/rIWcX23IkauwnPIdut4ZH/sPJjtakNSZjNPt
	 KLPiTEDxDv897t8YvH7vwar6EyiEp8SQOAw/m0fA8rEQytUQ9zyvhtOoUgisGaX7ry
	 2YtGUkeYdkVI1lhRI34xLu71alHgb7owQbRgrNUdmyqB9nL5va/cAYBLv3l6WrQSlb
	 0HigL58wPMcnA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v2 0/4] gro: various fixes related to UDP tunnels
Date: Tue, 19 Mar 2024 10:31:35 +0100
Message-ID: <20240319093140.499123-1-atenart@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

We found issues when a UDP tunnel endpoint is in a different netns than
where UDP GRO happens. This kind of setup is actually quite diverse,
from having one leg of the tunnel on a remove host, to having a tunnel
between netns (eg. being bridged in another one or on the host). In our
case that UDP tunnel was geneve.

UDP tunnel packets should not be GROed at the UDP level. The fundamental
issue here is such packet can't be detected in a foolproof way: we can't
know by looking at a packet alone and the current logic of looking up
UDP sockets is fragile (socket could be in another netns, packet could
be modified in between, etc). Because there is no way to make the GRO
code to correctly handle those packets in all cases, this series aims at
two things: making the net stack to correctly behave (as in, no crash
and no invalid packet) when such thing happens, and in some cases to
prevent this "early GRO" from happening.

First three patches fix issues when an "UDP tunneled" packet is being
GROed too early by rx-udp-gro-forwarding or rx-gro-list.

Last patch is preventing locally generated UDP tunnel packets from being
GROed. This turns out to be more complex than this patch alone as it
relies on skb->encapsulation which is currently untrusty in some cases
(see iptunnel_handle_offloads); but that should fix things in practice
and is acceptable for a fix. Future work is required to improve things
(prevent all locally generated UDP tunnel packets from being GROed),
such as fixing the misuse of skb->encapsulation in drivers; but that
would be net-next material.

Thanks!
Antoine

Since v1:
  - Fixed a build issue with IPv6 disabled in patch 1.
  - Reworked commit log in patch 2 (Willem de Bruijn feedback).
  - Added Reviewed-by tags on patches 1 & 4 (Willem de Bruijn feeback).

Antoine Tenart (4):
  udp: do not accept non-tunnel GSO skbs landing in a tunnel
  gro: fix ownership transfer
  udp: do not transition UDP fraglist to unnecessary checksum
  udp: prevent local UDP tunnel packets from being GROed

 include/linux/udp.h    | 28 ++++++++++++++++++++++++++++
 net/core/gro.c         |  3 ++-
 net/ipv4/udp_offload.c | 23 ++++++++++++-----------
 net/ipv6/udp_offload.c |  8 --------
 4 files changed, 42 insertions(+), 20 deletions(-)

-- 
2.44.0


