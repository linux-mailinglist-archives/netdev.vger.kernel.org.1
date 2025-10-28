Return-Path: <netdev+bounces-233499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E708BC147BC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 982714E30D1
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088A3164D6;
	Tue, 28 Oct 2025 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm3opNR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3D315D33;
	Tue, 28 Oct 2025 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652693; cv=none; b=kWBYSdmxx5V3PhkEjdPw/G93eNhgez1HmRiKLA+/tmZZG2RCZIQ0tFFtVhKcfV0jA8pcJjNKVIRtgpQv22qbXA0Bz79Y2oENUE+tSfvfGXFiSLYzU4+s06UdoSoLvaUwfSJZptNMqn1zCwJeVJhmRW2ALJqxQufmsNgwrkCW22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652693; c=relaxed/simple;
	bh=sHoW21+AGDUkdQ6DaRFEDfNq+q5/ZNLb3IRxX1Wvf1o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ONc6zzfzg/U2yuTO1WViw6Hs68paT+upA6F+EU+hh7PxTEBV0gxfW/GKrmoGoYKx0VJ5Sv3AAtGJtbtazZaFgOlT7BSJ4PIZEL2TLw9+ciIr+OT/A0UPKg6oq97r6mitMN85lUUE936epJNG3efFrz5KJfkBsQ99j5Sab5sfOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm3opNR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520C9C4CEE7;
	Tue, 28 Oct 2025 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652693;
	bh=sHoW21+AGDUkdQ6DaRFEDfNq+q5/ZNLb3IRxX1Wvf1o=;
	h=From:Subject:Date:To:Cc:From;
	b=bm3opNR4FmbN8/IlfdmxaVn4h4U5MyZLRy24F+L843qoyev2W3J84KXOhdwJnfTW4
	 oNaQGBMtKADHYPL2tjavuzdcxPd0DoS89/wHKYz71kXEbSRXEDZ1xyLA35yLiw8GsD
	 xlBkOPGh7M9bSpXFiYYBuuad/8Iav1ZBBn2rhO1yvLf9nTTtzya06VF4ib9h0ALeSb
	 jBCTDUKn+pNxRYNcj6qM4RVEV00RVWS039Y0Cu7LyIO5WWhES8VD0kRnn5j0q8yzkR
	 X7i84cqFBi5ifqXnz7WA0/+T0mx1g8FuL5ekYJ+J2+FOXBQwhfzDImUHIdPMuzcfAa
	 t6QrlLf8Ck8+w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v3 0/4] tcp: fix receive autotune again
Date: Tue, 28 Oct 2025 12:57:58 +0100
Message-Id: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMevAGkC/02MQQ6DIBAAv2L23DWAVbCn/qPpgcCKJBUMoGlq/
 HtJTz3OJDMHZEqeMtyaAxLtPvsYKnSXBsysgyP0tjIIJnrOhMJABYtZMZHZUW8lli0Q9koOdrC
 qt0pDbddEk3//vg+oCTyrnFJcsMyJ9P9SMtkpNraCc3EdFXIkuy36Q+XuYnQvak1c4Dy/lkfHN
 6sAAAA=
X-Change-ID: 20251028-net-tcp-recv-autotune-5876d6d85d8a
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2128; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=sHoW21+AGDUkdQ6DaRFEDfNq+q5/ZNLb3IRxX1Wvf1o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZ1p9p/SB23j+pccOqsMUttZtDTAr/bHvgu3D9e6eVu
 VEC5o+6O0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbyToSR4ZSI1dnLTOFX9knz
 3F2wZLGUdMnbX2qnbnz+/qzsCucy5l+MDO9e7Xn85Lz5u0teNhzRS+coSSo6aJay5zvo2f8P/Xc
 ngREA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Neal Cardwell found that recent kernels were having RWIN limited
issues, even when net.ipv4.tcp_rmem[2] was set to a very big value like
512MB.

He suspected that tcp_stream default buffer size (64KB) was triggering
heuristic added in ea33537d8292 ("tcp: add receive queue awareness
in tcp_rcv_space_adjust()").

After more testing, it turns out the bug was added earlier
with commit 65c5287892e9 ("tcp: fix sk_rcvbuf overshoot").

I forgot once again that DRS has one RTT latency.

MPTCP also got the same issue.

This series :

- Prevent calling tcp_rcvbuf_grow() on some MPTCP subflows.
- adds rcv_ssthresh, window_clamp and rcv_wnd to trace_tcp_rcvbuf_grow().
- Refactors code in a patch with no functional changes.
- Fixes the issue in the final patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
[ Added patch 1/4. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v3:
- Fix warnings at build time by moving 'oldval' declaration (Matthieu)
- Prevent possible divide by zero issue in mptcp_rcv_space_adjust() (Paolo)
- Note: this v3 is not being sent by Eric because he is unavailable.
- Link to v2: https://patch.msgid.link/20251027073809.2112498-1-edumazet@google.com
Changes in v2:
- Rebased to net tree
- Changed mptcp_rcvbuf_grow() to read/write msk->rcvq_space.space (Paolo)
- Link to v1: https://patch.msgid.link/20251024075027.3178786-1-edumazet@google.com

---
Eric Dumazet (3):
      trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
      tcp: add newval parameter to tcp_rcvbuf_grow()
      tcp: fix too slow tcp_rcvbuf_grow() action

Paolo Abeni (1):
      mptcp: fix subflow rcvbuf adjust

 include/net/tcp.h          |  2 +-
 include/trace/events/tcp.h |  9 +++++++++
 net/ipv4/tcp_input.c       | 21 ++++++++++++++-------
 net/mptcp/protocol.c       | 26 +++++++++++++++++---------
 4 files changed, 41 insertions(+), 17 deletions(-)
---
base-commit: 210b35d6a7ea415494ce75490c4b43b4e717d935
change-id: 20251028-net-tcp-recv-autotune-5876d6d85d8a

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


