Return-Path: <netdev+bounces-44313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B47D78AD
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C441281DF9
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E105637CB6;
	Wed, 25 Oct 2023 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHx2IQSs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6337CAD;
	Wed, 25 Oct 2023 23:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F83C433CC;
	Wed, 25 Oct 2023 23:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698277032;
	bh=FSAtE+zTZHOTHK+nbnYCG0cPYtBr9fiZYXPBuLJCWXg=;
	h=From:Subject:Date:To:Cc:From;
	b=gHx2IQSsCfscN2H0LDbAUTDY3Z26HwWwJooRc1L78El1Meb+mUwcIpSFRXwgMEzve
	 u+k5hy4P6Fmi/lXr/8YSJzVeCejhg0SUWqbZ2QXUYs9ayMxRrXVZipzJA0nyv4fc0b
	 kKwoOCNO5j2xPXDBLT5XatCcr2rcCmgzjOBWUvKKU9xwpXPQPg+LvRJ1vBZzptVqX/
	 60PhWaaPuna//1x1AVlG587JshjkP+w3wlXMf7Lbpx9MceSjkrT/WBRMPnAmPIzrly
	 NAb6/ILLuVYFnE0T6x5PnR5qfMRGPAMyYcGLmiU07d/CP1Vw6KYKJFP5xj0mfLlchE
	 h5XJLzrWDCgZA==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next 00/10] mptcp: Fixes and cleanup for v6.7
Date: Wed, 25 Oct 2023 16:37:01 -0700
Message-Id: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2mOWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNT3eLUvBTdvNQSIK4o0YULmyWlGKSmGqVYpJinKAE1FxSlpmVWgA2
 OVoIpV4qtrQUA+M7qI3IAAAA=
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geliang Tang <geliang.tang@suse.com>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4

This series includes three initial patches that we had queued in our
mptcp-net branch, but given the likely timing of net/net-next syncs this
week, the need to avoid introducing branch conflicts, and another batch
of net-next patches pending in the mptcp tree, the most practical route
is to send everything for net-next.

Patches 1 & 2 fix some intermittent selftest failures by adjusting timing.

Patch 3 removes an unneccessary userspace path manager restriction on
the removal of subflows with subflow ID 0.

The remainder of the patches are all cleanup or selftest changes:

Patches 4-8 clean up kernel code by removing unused parameters, making
more consistent use of existing helper functions, and reducing extra
casting of socket pointers.

Patch 9 removes an unused variable in a selftest script.

Patch 10 adds a little more detail to some mptcp_join test output.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (10):
      selftests: mptcp: run userspace pm tests slower
      selftests: mptcp: fix wait_rm_addr/sf parameters
      mptcp: userspace pm send RM_ADDR for ID 0
      mptcp: drop useless ssk in pm_subflow_check_next
      mptcp: use mptcp_check_fallback helper
      mptcp: use mptcp_get_ext helper
      mptcp: move sk assignment statement ahead
      mptcp: define more local variables sk
      selftests: mptcp: sockopt: drop mptcp_connect var
      selftests: mptcp: display simult in extra_msg

 net/mptcp/pm.c                                     |  2 +-
 net/mptcp/pm_userspace.c                           | 81 +++++++++++++++++-----
 net/mptcp/protocol.c                               |  6 +-
 net/mptcp/protocol.h                               |  4 +-
 net/mptcp/sockopt.c                                |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 23 ++++--
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  1 -
 7 files changed, 88 insertions(+), 31 deletions(-)
---
base-commit: 8846f9a04b10b7f61214425409838d764df7080d
change-id: 20231025-send-net-next-20231025-6bd0ee2d8d7d

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


