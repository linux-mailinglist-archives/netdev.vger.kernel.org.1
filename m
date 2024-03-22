Return-Path: <netdev+bounces-81238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B63886B77
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF95286381
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E663F9C8;
	Fri, 22 Mar 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1A9Hfki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2E224FA
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107987; cv=none; b=pEH6/Qaw6I4yUG1vitKmIbcEFYgbIIYFasuiLDGgBt5TUL2pSVwEY4x1GY/8kq7KVLQFSZ98BMggfZqVex5RdXsYQq2AZxcGAIDfLOD3Xz/ag+0aDxGAZOzhKHFNffx24osVqw2w0tppxqkqEggIW1KAQUQEvynSKeOIhxeXOXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107987; c=relaxed/simple;
	bh=Jev9LO8SZ+wIObDraFp0tjQAgAwXgLYNJ1aXBdGAo9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=luEG7ePBEVSDMTKqziqWmqHFcKytL+WfHsLrTWcdV8hu2R5Da6+9r+iHvrIO++rEIoKAKfQUkef+Cv0FkpThSiQPWHs2m62bHXBMnZAuVeZnenmXdrJxEEo+DxmYp+qCoINBfZthe8istMzsT07h9YDD8nEMm5EwEuhcYN93NE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1A9Hfki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D77CC433F1;
	Fri, 22 Mar 2024 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711107987;
	bh=Jev9LO8SZ+wIObDraFp0tjQAgAwXgLYNJ1aXBdGAo9U=;
	h=From:To:Cc:Subject:Date:From;
	b=D1A9Hfki+vIPb7SQ5z6szJWnnnKLGWHwWAAtdlaESvxkUXGtOaDD/0ptYeVhZI05y
	 czyiA6xy4RfDCjNQZ7TqRU8mo2RMMMAVIoIv++DBDIRWliQLHq0aBdnNwmfa5sdZZ2
	 8flj1mx4gUe4XGmoVvVF6ELB4HQT7oBAafj8SQ82MI9k7de5NXItwY/6hdFhNukxW9
	 E2oNCloE/8swvA9ThQS2tCtBpNqrE9wAMaFLlBL0QN+e/hUOPLuL2kki1jDUWzlDTR
	 W26esmwUB8xrWtBVyY88JIF4hx1frcMOzcPkQyHvNj8JhsdOYRYlBqmxVlJV7VC/Dh
	 f+C5axvKeSDwA==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH net v3 0/4] gro: various fixes related to UDP tunnels
Date: Fri, 22 Mar 2024 12:46:19 +0100
Message-ID: <20240322114624.160306-1-atenart@kernel.org>
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

Antoine Tenart (4):
  udp: do not accept non-tunnel GSO skbs landing in a tunnel
  gro: fix ownership transfer
  udp: do not transition UDP GRO fraglist partial checksums to
    unnecessary
  udp: prevent local UDP tunnel packets from being GROed

 include/linux/udp.h    | 28 ++++++++++++++++++++++++++++
 net/core/gro.c         |  3 ++-
 net/ipv4/udp.c         |  7 +++++++
 net/ipv4/udp_offload.c | 23 +++++++++++++----------
 net/ipv6/udp.c         |  2 +-
 net/ipv6/udp_offload.c |  8 +-------
 6 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.44.0


