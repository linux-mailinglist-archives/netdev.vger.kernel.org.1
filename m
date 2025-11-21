Return-Path: <netdev+bounces-240823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934FC7AF86
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460C83A3395
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80002F1FD3;
	Fri, 21 Nov 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zkr4R4wo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097C285C88;
	Fri, 21 Nov 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744548; cv=none; b=nzYVThKADxcrUlC+mY3blmaMovATLD7V+09jTUQuRfVwaHfTP3qWL5X3r+ZT0SRACNvXSsSsfessv4+lKaWkiGZt4i2Vx6L92+aWyr7DCFVa2car0V0xYjo9JieTjz2l8IkoMoezkoIx67jGvjIT21kY0+1mL9Zz8CmxEt/ffLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744548; c=relaxed/simple;
	bh=ioKhLSro9ujBAyOSRclCwpexaEBcrzxMjz6Lfns2rkM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QEF1qn9Q9+Cn4E7veH9cL9wy2j7uqjJaMp+ZF0gbawjjvO6/yWgkPouyBIyDhD6N6EsQ2N77cd7L18gNc7zJb7idsNenESd48u5+tDmqiVQOZ2e4Sdzpvm84ugiFX3PBwT5aK2uXlC29a8BfGr6c08CQ1qVJOd6bYM43klTDGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zkr4R4wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E13C4CEF1;
	Fri, 21 Nov 2025 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744548;
	bh=ioKhLSro9ujBAyOSRclCwpexaEBcrzxMjz6Lfns2rkM=;
	h=From:Subject:Date:To:Cc:From;
	b=Zkr4R4wof6nc2vPCO3lr9fJP1NMyyVHqb67wBWJz9rNc1AwRkpxP+UgsFkuZKfqlt
	 Kul8SZqqdwxHxCePCzYt3d/Egfp4gri+VVZgPBYY/aPqwwA4IWmk6p9wbbFcl4s06M
	 H1nxc+1Im4gLQiJL0JI/4TX29/ASZT4zFZcxPFeNzb7IqoXIFC0+gOG+yJrpE4bo4T
	 mUwA4BYFdEeF//3CI1XJGtBR21joi5iWbOwOqtfXvaF3+kyE7buQqtF9oXjS+A/rPZ
	 DeCKzSE6hyJB6ecLTNm69yg3TVg6EVMHKuAobknAxyzb4jvpahVwlHIBcLdrdesa8+
	 7InVDL8zNlTdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/14] mptcp: memcg accounting for passive sockets
 & backlog processing
Date: Fri, 21 Nov 2025 18:01:59 +0100
Message-Id: <20251121-net-next-mptcp-memcg-backlog-imp-v1-0-1f34b6c1e0b1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAebIGkC/zWNQQqDMBBFryKz7kASq2ivUlzYcYyDTQxJEEG8e
 0PBxVu8xfv/hMRROMGrOiHyLkk2X0Q/KqBl9JZRpuJglGm0Nho958KR0YVMAR07svgZaf1uFsU
 FrOum7ahVveqfUGZC5FmO/8Ub7hqG6/oBviN0qnwAAAA=
X-Change-ID: 20251121-net-next-mptcp-memcg-backlog-imp-33568c609094
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ioKhLSro9ujBAyOSRclCwpexaEBcrzxMjz6Lfns2rkM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIVZvN/4li+ZMaPQsZ1t1NuTUsoVrgxfR9DOH9z4cTNE
 o/bBIsMO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYyo5Lhn3rnzvo1d5WU8gO2
 KKhsXWtwTZRBpGieoJmizp8/bLIbFzH8j6j/unC5Tlb4hhuM+VZvjgZXb5z7Ib9vjajZZulrHJt
 fMQAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This series is split in two: the 4 first patches are linked to memcg
accounting for passive sockets, and the rest introduce the backlog
processing. They are sent together, because the first one appeared to be
needed to get the second one fully working.

The second part includes RX path improvement built around backlog
processing. The main goals are improving the RX performances _and_
increase the long term maintainability.

- Patches 1-3: preparation work to ease the introduction of the next
  patch.

- Patch 4: fix memcg accounting for passive sockets. Note that this is a
  (non-urgent) fix, but it depends on material that is currently only in
  net-next, e.g. commit 4a997d49d92a ("tcp: Save lock_sock() for memcg
  in inet_csk_accept().").

- Patches 5-6: preparation of the stack for backlog processing, removing
  assumptions that will not hold true any more after the backlog
  introduction.

- Patches 7,8,10,11,12 are more cleanups that will make the backlog
  patch a little less huge.

- Patch 9: somewhat an unrelated cleanup, included here not to forget
  about it.

- Patches 13-14: The real work is done by them. Patch 13 introduces the
  helpers needed to manipulate the msk-level backlog, and the data
  struct itself, without any actual functional change. Patch 14 finally
  uses the backlog for RX skb processing. Note that MPTCP can't use the
  sk_backlog, as the MPTCP release callback can also release and
  re-acquire the msk-level spinlock and core backlog processing works
  under the assumption that such event is not possible.
  A relevant point is memory accounts for skbs in the backlog. It's
  somewhat "original" due to MPTCP constraints. Such skbs use space from
  the incoming subflow receive buffer, do not use explicitly any forward
  allocated memory, as we can't update the msk fwd mem while enqueuing,
  nor we want to acquire again the ssk socket lock while processing the
  skbs. Instead the msk borrows memory from the subflow and reserve it
  for the backlog, see patch 5 and 14 for the gory details.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (14):
      net: factor-out _sk_charge() helper
      mptcp: factor-out cgroup data inherit helper
      mptcp: grafting MPJ subflow earlier
      mptcp: fix memcg accounting for passive sockets
      mptcp: cleanup fallback data fin reception
      mptcp: cleanup fallback dummy mapping generation
      mptcp: ensure the kernel PM does not take action too late
      mptcp: do not miss early first subflow close event notification
      mptcp: make mptcp_destroy_common() static
      mptcp: drop the __mptcp_data_ready() helper
      mptcp: handle first subflow closing consistently
      mptcp: borrow forward memory from subflow
      mptcp: introduce mptcp-level backlog
      mptcp: leverage the backlog for RX packet processing

 include/net/sock.h     |   2 +
 net/core/sock.c        |  18 +++
 net/ipv4/af_inet.c     |  17 +-
 net/mptcp/fastopen.c   |   4 +-
 net/mptcp/mib.c        |   1 -
 net/mptcp/mib.h        |   1 -
 net/mptcp/mptcp_diag.c |   3 +-
 net/mptcp/pm.c         |   4 +-
 net/mptcp/pm_kernel.c  |   2 +
 net/mptcp/protocol.c   | 428 +++++++++++++++++++++++++++++++++++--------------
 net/mptcp/protocol.h   |  51 +++++-
 net/mptcp/subflow.c    |  42 +++--
 12 files changed, 417 insertions(+), 156 deletions(-)
---
base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
change-id: 20251121-net-next-mptcp-memcg-backlog-imp-33568c609094

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


