Return-Path: <netdev+bounces-276716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k8lgEbXN1mnjIggAu9opvQ
	(envelope-from <netdev+bounces-276716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A01763C42E5
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DEF4301D305
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3AE37F75B;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RffA7Ve7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578A326FA5B;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=LzMhcVM28h1CZWgG+hnOsCF446N1trLZCPJYP72LxlQ8JLvJqwqwTxegYRGAt9A/sBc1W0DhhBs5BY71SLnheqpOoGFSbbGN9idZdeZY+NwwobaGzPHkPdAEKs/YA6HSdV1Q9+o05wVyn0AYNu1jPv5gszLIWzXt0Jh8CIAno7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=bfuY5pXT/09Tmj0/Sfi1Tla4mOzK5VYAftWHOpXhLbo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tVfrgZ8SSmbV2Mn9mc2NDxbzYyPID8kfTFPDCOfebKhjaMzNOyBsEf9pKmIQGAAMHYZM9R821os4KeOiFMeLUbD2zsW6uVnme+fx+1lpQJMj2xv8II7w5VhjuHocbcJl/HiWjcqZ7E8wXZuVqNuY7hmhTjFkqQ1RxLDqvCXV6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RffA7Ve7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A1A9C19421;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=bfuY5pXT/09Tmj0/Sfi1Tla4mOzK5VYAftWHOpXhLbo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RffA7Ve7pBJyAp5RpxOGVVJA+6bKEV4jIFKAI3DFyOcRff/3wxqNMWvmwQ0ceKjUI
	 URChQt0gA+G4KKpWotLRsHU1zwN0b3TqJxmmzD0f25FvkrNWttszLjTxh7eU7B2ehU
	 m3CU2mFQIsTKysT+2fgS6O3AKoYeDX2LOJMxRTrPMXFSXdEMZO3Hk44pecDWbX7+Eu
	 ugsB8YS5Wg1GNfb4CK9LQDYiFRDs+VDVGyme/D2D6XqcSTja/z6Y1x1Kfnu+mr5fu6
	 WvyVB5YWLu4vyF29qsziESU8nQEvjylBx2cZkPQZemTZGQKtQkQoxhFh4SnzqbZaiD
	 TvY0XlzHPGHGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E719D10FC44E;
	Wed,  8 Apr 2026 21:50:41 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Subject: [PATCH net-next 0/7] tcp: restrict rcv_wnd and window_clamp to
 representable window
Date: Wed, 08 Apr 2026 23:50:01 +0200
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MUQrCMAwA0KuMfFvoanXqVURCSaMGNJa2zMLY3
 Vf2+X7eAoWzcIHbsEDmWYr8tGM8DEDvoC82ErvBWXe23jpTKWGmGbkFqkif8E0YNOJfo/Fuipf
 TkSd/HaEPKfNT2r7fQbka5Vbhsa4bOVUUjncAAAA=
X-Change-ID: 20260402-tcp_rcv_exact_clamp_and_wnd-427d853e7491
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=3225;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=bfuY5pXT/09Tmj0/Sfi1Tla4mOzK5VYAftWHOpXhLbo=;
 b=X/L7cDWkWfstOARedCaNVrM3czxQSs2EBZ8+lQc5h3mMA/OC1YzQ6XJn5iGm4oU4XHQsWqAKK
 8lLUtgCiwCbAAxU3dBg6LND9Ta+95/17SBoIH3Mw6FbOu7aT3g5JGGV
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276716-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A01763C42E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

this series ensures that rcv_wnd and window_clamp do not exceed the
maximum window size representable for the connection's window scale
factor.

This is most visible when TCP window scaling is not used for a
connection. In that case, the advertised window is limited to 65535
bytes, but rcv_wnd or window_clamp can still grow beyond 65535 when
large receive buffers are used. The resulting mismatch breaks
calculations that depend on the advertised window, such as the ACK
decision in __tcp_ack_snd_check(), and can prevent immediate ACKs.

Similar effects may also occur when window scaling is in use, e.g. if
the application dynamically adjusts SO_RCVBUF in unusual ways or when
the rmem sysctl parameters change during a connection’s lifetime.

Summary:

- Patch 1 keeps rcv_wnd capped by the (window scale-limited)
  window_clamp at connection start.
- Patch 3 and 6 ensure that window_clamp is limited to the
  representable window when it is updated.
- The other patches add packetdrill tests to verify the new behavior.

A simple iperf test on a virtme-ng VM (Intel i5-7500, 4 cores,
loopback) shows a noticeable improvement with window scaling disabled:

Fixed receive buffer:

- sysctl net.ipv4.tcp_window_scaling=0
- Server: iperf -l 256K -w 256K -s
- Client: iperf -l 256K -w 256K -c 127.0.0.1 -t 30
- net-next: ~47 Gbit/sec
- with this series: ~62 Gbit/sec

Receive buffer autotuning (net.ipv4.tcp_rmem = 4096 131072 7813888):

- sysctl net.ipv4.tcp_window_scaling=0
- Server: iperf -s
- Client: iperf -c 127.0.0.1 -t 30
- net-next: ~48 Gbit/sec
- with this series: ~60 Gbit/sec

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
Simon Baatz (7):
      tcp: keep rcv_wnd/rcv_ssthresh clamped by window_clamp if no scaling in use
      selftests/net: packetdrill: verify non-scaled rcv_wnd initialization
      tcp: Ensure window_clamp is limited to representable window
      selftests/net: packetdrill: add tcp_rcv_wnd_snd_ack_no_scaling.pkt
      selftests/net: packetdrill: add TCP_WINDOW_CLAMP test
      tcp: use tcp_set_window_clamp() for SO_RCVLOWAT
      selftests/net: packetdrill: add test for SO_RCVLOWAT window clamp

 net/ipv4/tcp.c                                     |  6 +++-
 net/ipv4/tcp_input.c                               | 13 ++++++--
 net/ipv4/tcp_minisocks.c                           |  8 +++--
 net/ipv4/tcp_output.c                              |  5 +--
 .../net/packetdrill/tcp_rcv_sockopt_lowat.pkt      | 24 ++++++++++++++
 .../net/packetdrill/tcp_rcv_sockopt_wnd_clamp.pkt  | 28 ++++++++++++++++
 .../packetdrill/tcp_rcv_wnd_active_no_scaling.pkt  | 27 ++++++++++++++++
 .../tcp_rcv_wnd_active_peer_no_scaling.pkt         | 26 +++++++++++++++
 .../packetdrill/tcp_rcv_wnd_passive_no_scaling.pkt | 30 ++++++++++++++++++
 .../tcp_rcv_wnd_passive_peer_no_scaling.pkt        | 29 +++++++++++++++++
 .../packetdrill/tcp_rcv_wnd_snd_ack_no_scaling.pkt | 37 ++++++++++++++++++++++
 11 files changed, 225 insertions(+), 8 deletions(-)
---
base-commit: b3e69fc3196fc421e26196e7792f17b0463edc6f
change-id: 20260402-tcp_rcv_exact_clamp_and_wnd-427d853e7491

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



