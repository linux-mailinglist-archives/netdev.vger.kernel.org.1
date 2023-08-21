Return-Path: <netdev+bounces-29454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAA2783592
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 00:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88792280F6D
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 22:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F41ADC3;
	Mon, 21 Aug 2023 22:25:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828411720;
	Mon, 21 Aug 2023 22:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE0FC433C7;
	Mon, 21 Aug 2023 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692656722;
	bh=W1kvItiGYBlF2AnzxBQsqMytiMS8LTkEKOGrpJ6SXhg=;
	h=From:Subject:Date:To:Cc:From;
	b=NLFR7NeAPAgIvfDpIhIUeKFQBcqYETSvfCz2anh+j8I+hvxOh9FirMa3nYP7fygUg
	 Gf4EmKXr1VSpseZWj9JOBDMyli826ZlS6WooFn9eCISSi8naxJVmFHYsxAykoOP2rh
	 teuFsOerng1pVsgLHAiXgk9xtND3/Yo1O11sgHq3+r7Sf5r+YpH7CvMnZ8ZIHglPkK
	 /0ghl4VulsTbb9uPIMXRlBg4h8OrxvLGUGuujSZfPVB8H1y7yTMkWdENJpIvI1DbDW
	 nl7BRHigCDhemuiFKVZylS1KpRyNuYPnq4/xwGhA2zwJdXeJbMMeE+zI6u3FuD8kb1
	 g9bJbAbNc0PkQ==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next 00/10] mptcp: Prepare MPTCP packet scheduler for
 BPF extension
Date: Mon, 21 Aug 2023 15:25:11 -0700
Message-Id: <20230821-upstream-net-next-20230818-v1-0-0c860fb256a8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEfk42QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDC0ML3dKC4pKi1MRc3bzUEiCuKNGFSxmlGBpaWhobmpqYmSoBDSgoSk3
 LrAAbHq0EU64UW1sLAAcdKUt2AAAA
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Geliang Tang <geliang.tang@suse.com>, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

The kernel's MPTCP packet scheduler has, to date, been a one-size-fits
all algorithm that is hard-coded. It attempts to balance latency and
throughput when transmitting data across multiple TCP subflows, and has
some limited tunability through sysctls. It has been a long-term goal of
the Linux MPTCP community to support customizable packet schedulers for
use cases that need to make different trade-offs regarding latency,
throughput, redundancy, and other metrics. BPF is well-suited for
configuring customized, per-packet scheduling decisions without having
to modify the kernel or manage out-of-tree kernel modules.

The first steps toward implementing BPF packet schedulers are to update
the existing MPTCP transmit loops to allow more flexible scheduling
decisions, and to add infrastructure for swappable packet schedulers.
The existing scheduling algorithm remains the default. BPF-related
changes will be in a future patch series.

This code has been in the MPTCP development tree for quite a while,
undergoing testing in our CI and community.

Patches 1 and 2 refactor the transmit code and do some related cleanup.

Patches 3-9 add infrastructure for registering and calling multiple
schedulers.

Patch 10 connects the in-kernel default scheduler to the new
infrastructure.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (10):
      mptcp: refactor push_pending logic
      mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
      mptcp: add struct mptcp_sched_ops
      mptcp: add a new sysctl scheduler
      mptcp: add sched in mptcp_sock
      mptcp: add scheduled in mptcp_subflow_context
      mptcp: add scheduler wrappers
      mptcp: use get_send wrapper
      mptcp: use get_retrans wrapper
      mptcp: register default scheduler

 Documentation/networking/mptcp-sysctl.rst |   8 +
 include/net/mptcp.h                       |  21 +++
 net/mptcp/Makefile                        |   2 +-
 net/mptcp/ctrl.c                          |  14 ++
 net/mptcp/pm.c                            |   9 +-
 net/mptcp/pm_netlink.c                    |   3 -
 net/mptcp/protocol.c                      | 277 +++++++++++++++++-------------
 net/mptcp/protocol.h                      |  18 +-
 net/mptcp/sched.c                         | 173 +++++++++++++++++++
 9 files changed, 393 insertions(+), 132 deletions(-)
---
base-commit: 7eb6deb3f55678216a6a0e956846c04958093ea5
change-id: 20230818-upstream-net-next-20230818-2d1199315465

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


