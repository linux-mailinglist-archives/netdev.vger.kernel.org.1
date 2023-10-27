Return-Path: <netdev+bounces-44905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9037DA3D5
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3782B21307
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C401F405DA;
	Fri, 27 Oct 2023 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHTGf6Da"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231D3FB2C;
	Fri, 27 Oct 2023 22:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE5CC433C7;
	Fri, 27 Oct 2023 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698447439;
	bh=XaI4lrRhA6Xj8x4ul0wvyppQxvgfjXwL7be1kn++4HY=;
	h=From:Subject:Date:To:Cc:From;
	b=mHTGf6DabSa1CL6yq29/VLIrpW4wc0maqD/c3Z+R1/XRpK6189R++UiaPR+ReT8o5
	 GSF9A6n4j9xH1SjK7B2ghA70XxnXzdnmrPitRjeqv7qnouQqAaAsyNUTuR8CE0ydkg
	 pDe1gltKTllPP2jwP8KsV15jh49AQY2Igqh0mKRwKYbZd1dKbm6N2omGN7nrjMbUhz
	 xlTPNTk+WquUFOzjRFwhooHYQ6JcRzK4gLBWsMcphCX2Gdv//D1iWGdmtq0XfRPpzn
	 c+9cKEKNTg2EhsR3hBEawl5quNuqBYa7bT330g6S7A1LIzItn0fJIgXOn/S0yKHkU2
	 HIoqpVxLAgflw==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next 00/15] mptcp: More selftest coverage and code
 cleanup for net-next
Date: Fri, 27 Oct 2023 15:57:01 -0700
Message-Id: <20231027-send-net-next-2023107-v1-0-03eff9452957@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD1APGUC/zWMwQqAIBBEf0X23IIaZPYr0UFsq71YaIQg/XtSd
 JjDG95MgUSRKcEgCkS6OPEeKqhGgN9cWAl5rgxa6lZJbTBRmDHQWZNP/GqDVi/Od6a3Riqo2yP
 Swvn9HeG3YbrvB4uZA7pxAAAA
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.4

Patches 1-5 and 7-8 add selftest coverage (and an associated subflow
counter in the kernel) to validate the recently-updated handling of
subflows with ID 0.

Patch 6 renames a label in the userspace path manager for clarity.

Patches 9-11 and 13-15 factor out common selftest code by moving certain
functions to mptcp_lib.sh

Patch 12 makes sure the random data file generated for selftest
payloads has the intended size.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (15):
      mptcp: add mptcpi_subflows_total counter
      selftests: mptcp: add evts_get_info helper
      selftests: mptcp: add chk_subflows_total helper
      selftests: mptcp: update userspace pm test helpers
      selftests: mptcp: userspace pm create id 0 subflow
      mptcp: userspace pm rename remove_err to out
      selftests: mptcp: userspace pm remove initial subflow
      selftests: mptcp: userspace pm send RM_ADDR for ID 0
      selftests: mptcp: add mptcp_lib_kill_wait
      selftests: mptcp: add mptcp_lib_is_v6
      selftests: mptcp: add mptcp_lib_get_counter
      selftests: mptcp: add missing oflag=append
      selftests: mptcp: add mptcp_lib_make_file
      selftests: mptcp: add mptcp_lib_check_transfer
      selftests: mptcp: add mptcp_lib_wait_local_port_listen

 include/uapi/linux/mptcp.h                         |   1 +
 net/mptcp/pm_userspace.c                           |   8 +-
 net/mptcp/protocol.h                               |   9 +
 net/mptcp/sockopt.c                                |   2 +
 tools/testing/selftests/net/mptcp/diag.sh          |  23 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 110 ++----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 375 ++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  92 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  39 +--
 tools/testing/selftests/net/mptcp/simult_flows.sh  |  19 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 129 +++----
 11 files changed, 401 insertions(+), 406 deletions(-)
---
base-commit: 3a04927f8d4b7a4f008f04af41e31173002eb1ea
change-id: 20231027-send-net-next-2023107-92fac6789701

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


