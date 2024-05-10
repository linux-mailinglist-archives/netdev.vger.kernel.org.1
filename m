Return-Path: <netdev+bounces-95410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD08C22F5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328451C2100E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F9616D4D6;
	Fri, 10 May 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOVv8Xv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001031649CF;
	Fri, 10 May 2024 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339936; cv=none; b=XRW76Vp07F4spGbhb/6IkFlmvDVl4KfJ4iYXfzHabRxfo5x09T/rKGjz83i70X6e53kc+OiT+HGtm5iOSnRChpFjU6edeMZwu4ONXrI35UxqYq6tSF9XLHxU+2xo3Aje6058Mob6UllH/SUQEZA7TMBvB0tHqgdFXBUlq9hEM6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339936; c=relaxed/simple;
	bh=ToKtFZmWWfuV2kB4dgliCIRKJEwH1p0nGQ2UWd5XBY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rdPd6Cc18nRFprjjFjGSX+z1X8AtedVA2uGzdryjMzV0ci4xIlygu2xHaRj9X4acE6JdStxY4YnVn6gBGZMc5x7IzgsD5/+Uww/WkCEjHgpUC9rsNe1ZHrfCAoQR2oSWFGGZwzWBu8A2SIuhxmqFUVI33pxy0TI6q7O6VqGqjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOVv8Xv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED82C32781;
	Fri, 10 May 2024 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339935;
	bh=ToKtFZmWWfuV2kB4dgliCIRKJEwH1p0nGQ2UWd5XBY8=;
	h=From:Subject:Date:To:Cc:From;
	b=VOVv8Xv6x4AizlMth+HSrzcMq+nwcXrZFNHpXjfzCiasb3vPhHH/jpYqQjOB1semh
	 4bCf4cTeLY2LbOPNq0pW9gIvJ1JVpOidMwqmkBgG5JYCAp4w4jrBFDJVzPSxyOyZrl
	 a6yTdv/1RKJ+9sH+i+ZyKd8+VlegT6eVSiQYfsgOZ8qmwTu2ZeUDYk8JaZXJIh+uj7
	 aKwWnVQcPUsJEVObmnC1AYpGo+N8l1ZRfoc5YjqHgJmCLTl71oz86jKTqC91SpAk9q
	 5zhnb6Tkov1GflbscAlRs1ZjxU+QKxWU7DgsLSAeJoiw3qjnc3XFrls4YMdpcUmPVy
	 0tHmU8REydFpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/8] mptcp: small improvements, fix and clean-ups
Date: Fri, 10 May 2024 13:18:30 +0200
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIYCPmYC/z2NQQqDMBBFryKz7kA0UbRXKV1YO+osEsNMFEG8e
 4NQF3/x+PDeAUrCpPAsDhDaWHkJGcpHAcPch4mQv5mhMpUztelwjZqEeo+BUt6e8L4864Dsoyw
 beQpJsXUf69qutM1oISuj0Mj7lXvBXwDv8/wB5SXhP4gAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ToKtFZmWWfuV2kB4dgliCIRKJEwH1p0nGQ2UWd5XBY8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKb40RMvXAQbuIZdUe5MCpWgEaHtuMhc+kNi
 27sWrPX59+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CmwAKCRD2t4JPQmmg
 c39eD/wIOKzgRhEkfB7BQnj6iiGzb250Jqy05mJkKTGrj8M2azzTr8ImQ7eER8FRAWn9dgWRRhO
 TmLr6iQvrUdiSwgg3sq5NY9Nn2jP8ORJJ/xMYxv1Ji1yh4dA7KS8kKa9NCJUwGTiKkYnrzmiP5y
 XM9Bx3lvDYVoUQX9fl6dq7OhNeRgxhT+7nsODS8T/VfKp4Pi4ai5zyXKmTdyi5SvZJINRpfhO98
 ycd2PoYXlvtR8JpsgjzMly7/TVuBM1vVhj3aELddw077gphEEBDn/jZge+DcvAydMotQXx+IHAb
 PzGJ9zG3cLb1D9DJbOskmScdGRSk8ucGSnsf4lb643z1A91L3OIYz04fecqTe28gA/axaezpNYu
 ZGeJkTXGUdBHg06W6pKra/An/t7le3/cr5XUM4N6h8+iXV8+mQf0rI1sgPJ/sQ/lOuit8yMzBVk
 LTBxx5ttHS99Ic5dYChE2q4g5Pgjy8BIHs3IC76CPZ4gU/01UfHcJsicSRNzfQwoMGSbRvauhJ8
 VkUCmWws7CH29ucp5TZUhazB2CskDzW+kqpTXw072TIhPI6vnK6LNvACSCX0XbsZddK7ITqn6w/
 Q0YiUQxWnNFJj6vXmfw3zIrEdC+E3VZh7PPKUgY7nxB9pDckYxSA0U7FElIoX0q1Bw4Bkx+ujsn
 biqrIU2MldtIX0g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

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

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
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

 include/net/mptcp.h      |  3 +++
 net/mptcp/ctrl.c         | 29 +++++++++++++++++++--
 net/mptcp/mib.h          |  2 ++
 net/mptcp/pm_netlink.c   |  1 +
 net/mptcp/pm_userspace.c |  1 +
 net/mptcp/protocol.c     |  5 ++--
 net/mptcp/protocol.h     |  6 +++--
 net/mptcp/sched.c        | 22 ++++++++++++++++
 net/mptcp/sockopt.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/subflow.c      | 32 ++++++++++++-----------
 10 files changed, 143 insertions(+), 24 deletions(-)
---
base-commit: 383eed2de529287337d9153a5084d4291a7c69f2
change-id: 20240509-upstream-net-next-20240509-misc-improvements-84b3489136f3

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


