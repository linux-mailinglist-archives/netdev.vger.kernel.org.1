Return-Path: <netdev+bounces-82001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40D588C0CE
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017371C3670E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B3476047;
	Tue, 26 Mar 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKAuRnIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3278658205
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452847; cv=none; b=o/n3UR5ayxyF4kO1dUSOjGC0z16pKy8y/nOhDT/s8+Z7KXs2EzJMZ1lhvog1a8RlXe3ig+4y+Jq08Pk7n/npdLzIYYO5dMfU5YywsBl8oetV/XZ49IK2IYiLfCJbaRbTlof2R6cdyBYAyqZkM9c1nDsFwY2vjirTsCQlP0OYSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452847; c=relaxed/simple;
	bh=S7EqxVktKtaOn2Nfok92MLk7D6p3oHosGgcOUuPrNxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IkS5cRwteVUAbkfXsT9bsGT2EbT0vLpNBAhrGuRfDAPaf12/2JtI85rxizVSoiMD9iYvWFG7Pa3kNFE3ugshu7NP9TgXKJTYD5ZLALXga4DGKRToK3WHvhVceEK61SUDPoky8tWzNCAz5/kCvoiX3dLzaDZEMzVJd/lUweCeZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKAuRnIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27668C433F1;
	Tue, 26 Mar 2024 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452846;
	bh=S7EqxVktKtaOn2Nfok92MLk7D6p3oHosGgcOUuPrNxA=;
	h=From:To:Cc:Subject:Date:From;
	b=XKAuRnIB6TB/mOYqcxd2zYW+rhD3cenYrdWDUrB++4rMvZd1UO8CY1PUI72CE9jAe
	 3J+zszqGtXvR2zFfsPOi8HK9b0SbkARONd4I3W2iIYPgjVQp6tHuKeX9SrAHpqBJk1
	 0dKbQPxcVRNF6d9Dsjqwca5ZZi0CvlUUADx9oXwKGaZAg71tnf1zWGIz6YVVHR7Bvw
	 m+Gd08zenY4UpLLIR+OhGOk/flOIs1f/4xtGQmt9sVdRPkW3CcKYupu9jAq3uFXpSY
	 /zKqDaPIAng4iuedREIrjnPTS1so55B/yAi2HqLlQPJxsTpHLUWHQte4+Vdpv89ZE3
	 32oN3ikuLS3Qw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v4 0/5] gro: various fixes related to UDP tunnels
Date: Tue, 26 Mar 2024 12:33:57 +0100
Message-ID: <20240326113403.397786-1-atenart@kernel.org>
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

Since v3:
  - Fixed the udpgro_fwd selftest in patch 5 (Jakub Kicinski feedback).
  - Improved commit message on patch 3 (Willem de Bruijn feeback).

Since v2:
  - Fixed a build issue with IPv6=m in patch 1 (Jakub Kicinski
    feedback).
  - Fixed typo in patch 1 (Nikolay Aleksandrov feedback).
  - Added Reviewed-by tag on patch 2 (Willem de Bruijn feeback).
  - Added back conversion to CHECKSUM_UNNECESSARY but only from non
    CHECKSUM_PARTIAL in patch 3 (Paolo Abeni & Willem de Bruijn
    feeback).
  - Reworded patch 3 commit msg.

Since v1:
  - Fixed a build issue with IPv6 disabled in patch 1.
  - Reworked commit log in patch 2 (Willem de Bruijn feedback).
  - Added Reviewed-by tags on patches 1 & 4 (Willem de Bruijn feeback).

Antoine Tenart (5):
  udp: do not accept non-tunnel GSO skbs landing in a tunnel
  gro: fix ownership transfer
  udp: do not transition UDP GRO fraglist partial checksums to
    unnecessary
  udp: prevent local UDP tunnel packets from being GROed
  selftests: net: gro fwd: update vxlan GRO test expectations

 include/linux/udp.h                       | 28 +++++++++++++++++++++++
 net/core/gro.c                            |  3 ++-
 net/ipv4/udp.c                            |  7 ++++++
 net/ipv4/udp_offload.c                    | 23 +++++++++++--------
 net/ipv6/udp.c                            |  2 +-
 net/ipv6/udp_offload.c                    |  8 +------
 tools/testing/selftests/net/udpgro_fwd.sh | 10 ++------
 7 files changed, 54 insertions(+), 27 deletions(-)

-- 
2.44.0


