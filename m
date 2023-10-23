Return-Path: <netdev+bounces-43639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE097D412D
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DEF1F205A8
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129186AB0;
	Mon, 23 Oct 2023 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4MZE1IX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E81FBB;
	Mon, 23 Oct 2023 20:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C266C433C8;
	Mon, 23 Oct 2023 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698093933;
	bh=I6qeUZCZc7Zo5yjAxQXXXGlrTeKeCGsisH/7JCBB3do=;
	h=From:Subject:Date:To:Cc:From;
	b=h4MZE1IX+jwbhA90ljKG2tuuXd0m6ax5ZMobYHsujxT171QQdnZVjN5JoKkXAn7zk
	 SwOdYMSXZqkN7Zee0QL2FxeL0aGuPS/9dTTcjVDM3K/QdXaNV2nFmOVa4uJvIWt9Ks
	 vO9eBGVVcQ9I/RiYh0IoWeegdWLECBiS6QUOwumKd1B9PAMpJXAbPM0EMTilDTvFue
	 Ru9DzJ22f1oLuhtYD2a3EcFlzbFHCVdNe+DTky5QjFdprgRxeL/EG0aJILQejOrq33
	 7d8FFGitaWDxvwZVEvIR0syFaWRat5xzr1eFMKsMbnH9QEW6ozbP5McCPXGYWEcWil
	 Np7szBF2484jA==
From: Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next 0/9] mptcp: Features and fixes for v6.7
Date: Mon, 23 Oct 2023 13:44:33 -0700
Message-Id: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHbNmUC/z2MQQqAMAwEvyI5G7ARFf2KeFCbai5V2iKC+HeDo
 Ic5zMLsBZGDcIQuuyDwIVE2r2LyDOZ19AujWHWggkqjYGRv0XNSzoT/TNjWs7OOmqliC5rvgZ2
 c73UPXwDDfT+L2R/6dAAAAA==
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.4

Patch 1 adds a configurable timeout for the MPTCP connection when all
subflows are closed, to support break-before-make use cases.

Patch 2 is a fix for a 1-byte error in rx data counters with MPTCP
fastopen connections.

Patch 3 is a minor code cleanup.

Patches 4 & 5 add handling of rcvlowat for MPTCP sockets, with a
prerequisite patch to use a common scaling ratio between TCP and MPTCP.

Patch 6 improves efficiency of memory copying in MPTCP transmit code.

Patch 7 refactors syncing of socket options from the MPTCP socket to
its subflows.

Patches 8 & 9 help the MPTCP packet scheduler perform well by changing
the handling of notsent_lowat in subflows and how available buffer space
is calculated for MPTCP-level sends.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
Paolo Abeni (9):
      mptcp: add a new sysctl for make after break timeout
      mptcp: properly account fastopen data
      mptcp: use plain bool instead of custom binary enum
      tcp: define initial scaling factor value as a macro
      mptcp: give rcvlowat some love
      mptcp: use copy_from_iter helpers on transmit
      mptcp: consolidate sockopt synchronization
      mptcp: ignore notsent_lowat setting at the subflow level
      mptcp: refactor sndbuf auto-tuning

 Documentation/networking/mptcp-sysctl.rst | 11 +++++
 include/net/tcp.h                         | 12 +++--
 net/mptcp/ctrl.c                          | 16 ++++++
 net/mptcp/fastopen.c                      |  1 +
 net/mptcp/protocol.c                      | 69 +++++++++++++++++---------
 net/mptcp/protocol.h                      | 82 ++++++++++++++++++++++++++-----
 net/mptcp/sockopt.c                       | 65 +++++++++++++++++-------
 net/mptcp/subflow.c                       | 45 ++++++++++-------
 8 files changed, 224 insertions(+), 77 deletions(-)
---
base-commit: d6e48462e88fe7efc78b455ecde5b0ca43ec50b7
change-id: 20231023-send-net-next-20231023-2-96cfdf27b5ed

Best regards,
-- 
Mat Martineau <martineau@kernel.org>


