Return-Path: <netdev+bounces-42349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28027CE646
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149E51C20AA8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5641221;
	Wed, 18 Oct 2023 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW1vBzhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E943F9C4;
	Wed, 18 Oct 2023 18:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFF5C433C9;
	Wed, 18 Oct 2023 18:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697653442;
	bh=MqbWF9KWr+fDWmDuFscKuEg2a6ksnYydthQmw8YMP5s=;
	h=From:Subject:Date:To:Cc:From;
	b=nW1vBzhRpKtassDHekDkfjI+vv/pSTzuWk2CiSts7XikL1l5NTOqbC75zCZ8YeTH0
	 ap+pxSuITI7ioEFdrkraehPbRZ8AUkqjcBHaL2sSNujqkMz/OZ5SaWOb2wVKGFIkeL
	 wemtcEhXS/S+IukTe2noizSNwiCzdeOIZL1K9aylYoJ1mcisZTb0I/WpgdiYrk+6O8
	 GF8tIQhScJAuvzWbKL1YNbguMJAKuc6bAQ5tL31qjprEdSCmpaXYg/RmFuyGF5fAMW
	 A9CIV8w5LRXBcnEOk0sFuIJNWPfw3ZTLAHnyaZRmQhN/Lf2ISy0fQM8co72NJop2BO
	 pjUad1Z3NBwRA==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net 0/5] mptcp: Fixes for v6.6
Date: Wed, 18 Oct 2023 11:23:51 -0700
Message-Id: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALciMGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA0ML3eLUvBTdvNQSXbhIYrJZkrFFSpqBaaqRElBfQVFqWmYF2MxoJaB
 KpdjaWgAcInu2aAAAAA==
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Davide Caratti <dcaratti@redhat.com>, 
 Christoph Paasch <cpaasch@apple.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org, 
 Geliang Tang <geliang.tang@suse.com>
X-Mailer: b4 0.12.3

Patch 1 corrects the logic for MP_JOIN tests where 0 RSTs are expected.

Patch 2 ensures MPTCP packets are not incorrectly coalesced in the TCP
backlog queue.

Patch 3 avoids a zero-window probe and associated WARN_ON_ONCE() in an
expected MPTCP reinjection scenario.

Patches 4 & 5 allow an initial MPTCP subflow to be closed cleanly
instead of always sending RST. Associated selftest is updated.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Geliang Tang (1):
      mptcp: avoid sending RST when closing the initial subflow

Matthieu Baerts (2):
      selftests: mptcp: join: correctly check for no RST
      selftests: mptcp: join: no RST when rm subflow/addr

Paolo Abeni (2):
      tcp: check mptcp-level constraints for backlog coalescing
      mptcp: more conservative check for zero probes

 net/ipv4/tcp_ipv4.c                             |  1 +
 net/mptcp/protocol.c                            | 36 ++++++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++--
 3 files changed, 43 insertions(+), 15 deletions(-)
---
base-commit: 2915240eddba96b37de4c7e9a3d0ac6f9548454b
change-id: 20231018-send-net-20231018-ac6b38df05e2

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


