Return-Path: <netdev+bounces-80099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B487D004
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8BE1C2048B
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4993D0B4;
	Fri, 15 Mar 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKGrE9rp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FF3D542
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515846; cv=none; b=FaMvxpIPyiRgYxvbdtVwzO9vKaA3xZvtaIR2S9dZSynizsOEr0Nay12wCtaEwOTU5cHO0UttGQbHmBtayYyWcFad0n0uxFNKKTXELJFAdr8XWXb0uxmWkLHBC+7BjQkd1n2xESHC+AOBGPVFjg/5M8k1r7e4fheGjyyf3/1daMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515846; c=relaxed/simple;
	bh=02mSvrIwEftRpShrclkIU6aVuENMG5q6CSeuuMn0Mdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIkgw4fQuQlBkDbIXxiv6TG3yKTTZoGU0dGGq2m4RqjUbJaJI7N/rhBwpJHvqDCVJhGNd7TafuyRDBa2+9KC+SUvZcOgm43U301O44aJPptt3oUMiY1O8OlX1p0FL0Y3NpNNwmy37mso680+SHwQcH8i+WaBeMgYM5LPGgDRbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKGrE9rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEABC43390;
	Fri, 15 Mar 2024 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515845;
	bh=02mSvrIwEftRpShrclkIU6aVuENMG5q6CSeuuMn0Mdw=;
	h=From:To:Cc:Subject:Date:From;
	b=LKGrE9rp3k1uV9g57Dv1HsmXIHm6kJjPk0LB1cMoOGRomF5yXmc3LbYqH5ds8xx4Y
	 k4gpzI8mifFK9zC0vy9MJ2Sw8dfELZOp6Cv3FJkByFEkoTqVe3r/8ieIrPpBhZKyBO
	 6BHZnOeKzxnnodxnPP1eKEf7bsK+umINRFowF8Le7Ilu5B7R2bbGOc3i3mCOhVXRhq
	 7Q0NMD2AzGyUEJnqlFksnHH4WH/eXsqFzSsI2b3jAJmfb+kFmmcF2P29iO/oKm0wJo
	 qy58dRjVKeT+/X3IfOTbOaC5ukJvn2jD4eFad2HIXmkWOfnrh0yee8HmXxZDwbC3jl
	 ETJB3trbDJhcw==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	steffen.klassert@secunet.com,
	netdev@vger.kernel.org
Subject: [PATCH net 0/4] gro: various fixes related to UDP tunnels
Date: Fri, 15 Mar 2024 16:17:16 +0100
Message-ID: <20240315151722.119628-1-atenart@kernel.org>
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

Antoine Tenart (4):
  udp: do not accept non-tunnel GSO skbs landing in a tunnel
  gro: fix ownership transfer
  udp: do not transition UDP fraglist to unnecessary checksum
  udp: prevent local UDP tunnel packets from being GROed

 include/linux/udp.h    | 14 ++++++++++++++
 net/core/gro.c         |  3 ++-
 net/ipv4/udp_offload.c | 23 ++++++++++++-----------
 net/ipv6/udp_offload.c |  8 --------
 4 files changed, 28 insertions(+), 20 deletions(-)

-- 
2.44.0


