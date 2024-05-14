Return-Path: <netdev+bounces-96224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D98C4AC7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7189D1F22F4F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58617C2;
	Tue, 14 May 2024 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1umBCQ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F64B1370;
	Tue, 14 May 2024 01:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649221; cv=none; b=OBypplT+075f+xPQdpogGfuQE3aKkJkfpnUMHUZVLxiCqOZztDugKn/Rg5F+9HRgUHZKlKVz0ea6SzfSzZK+eFJ1QmlQx7RsmnmlapRKBkC88RozrHYpfmB57MpXz1l6pnJIikwFzWNQleesFe3kdg/NRh4VO3ph9wsKltw6iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649221; c=relaxed/simple;
	bh=aasZvWkODEWjN+l+JIrTwlnPD99FUSWRDgFhstM7p9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqOXcqaPM21cJAoa53M92YLCwsY+2+BmwVxkySI4fsTSo0xFf684W2SwgQWv27wH2q1RpLWX8cmHXgxVW0KMFwPl4wuLgGO7ApxREIJvKYIk0FLtYoLfKgdB1T1Z4QEbsXKoJuPxdL7bwlRxM1/JI+yxHqL3Rgf86FmXzGNTMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1umBCQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7217C113CC;
	Tue, 14 May 2024 01:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649221;
	bh=aasZvWkODEWjN+l+JIrTwlnPD99FUSWRDgFhstM7p9c=;
	h=From:To:Cc:Subject:Date:From;
	b=n1umBCQ1TNbm6r5JTQvTMQLWXQdrtk+YWjcq+Q4BIaChXzMAhFzL8Fv3AleYgpvQY
	 BIU/vi9ol8BvrCN+GuXfRpzt+YWiSkU3N9xcmE2XqPAUjwQPi4nJCHJO6rPifO27v1
	 HCXWYmGL/UqqorKfW83upuloZO0BbzTaY58H9NZqGACEYu6HlMUY4x13Ny10Hlkwpw
	 1nSNO4OP7+lLaWEB4oryEkfvEpj3VRRw3Jye7O7h1NL0z54Z1VSV3E3S8C60GvhO0e
	 sgMnHofsBCtvOQYLrCp4hrDbTCvUWyI4fA6i3teaI3FO3YF5r5EXLKBplff+IDp9et
	 f8qHbXYuyE50Q==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: Mat Martineau <martineau@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/8] mptcp: small improvements, fix and clean-ups
Date: Mon, 13 May 2024 18:13:24 -0700
Message-ID: <20240514011335.176158-1-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contain mostly unrelated patches:

- The two first patches can be seen as "fixes". They are part of this
  series for -next because it looks like the last batch of fixes for
  v6.9 has already been sent. These fixes are not urgent, so they can
  wait if an unlikely v6.9-rc8 is published. About the two patches:
    - Patch 1 fixes getsockopt(SO_KEEPALIVE) support on MPTCP sockets
    - Patch 2 makes sure the full TCP keep-alive feature is supported,
      not just SO_KEEPALIVE.

- Patch 3 is a small optimisation when getsockopt(MPTCP_INFO) is used
  without buffer, just to check if MPTCP is still being used: no
  fallback to TCP.

- Patch 4 adds net.mptcp.available_schedulers sysctl knob to list packet
  schedulers, similar to net.ipv4.tcp_available_congestion_control.

- Patch 5 and 6 fix CheckPatch warnings: "prefer strscpy over strcpy"
  and "else is not generally useful after a break or return".

- Patch 7 and 8 remove and add header includes to avoid unused ones, and
  add missing ones to be self-contained.

v2: Rebased

Gregory Detal (1):
  mptcp: add net.mptcp.available_schedulers

Matthieu Baerts (NGI0) (7):
  mptcp: SO_KEEPALIVE: fix getsockopt support
  mptcp: fix full TCP keep-alive support
  mptcp: sockopt: info: stop early if no buffer
  mptcp: prefer strscpy over strcpy
  mptcp: remove unnecessary else statements
  mptcp: move mptcp_pm_gen.h's include
  mptcp: include inet_common in mib.h

 include/net/mptcp.h      |  3 ++
 net/mptcp/ctrl.c         | 29 ++++++++++++++++--
 net/mptcp/mib.h          |  2 ++
 net/mptcp/pm_netlink.c   |  1 +
 net/mptcp/pm_userspace.c |  1 +
 net/mptcp/protocol.c     |  5 +--
 net/mptcp/protocol.h     |  6 ++--
 net/mptcp/sched.c        | 22 ++++++++++++++
 net/mptcp/sockopt.c      | 66 ++++++++++++++++++++++++++++++++++++++--
 net/mptcp/subflow.c      | 32 ++++++++++---------
 10 files changed, 143 insertions(+), 24 deletions(-)

-- 
2.45.0


