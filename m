Return-Path: <netdev+bounces-172886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78DA5667F
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AAF7A138A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FFE217666;
	Fri,  7 Mar 2025 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCI/kFG3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CCB14293;
	Fri,  7 Mar 2025 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346518; cv=none; b=Ve/kByDUGjExI07M28YMBZNGoXgKdPlkqbNpeKYT5mGVkrbkGLZYYLf2SZ94u5iCMqIolt+xxSPikbPCS3TfbSzB1k/RMC8f0dxtoEsjdkcz8DXDlRAQTG4DN6Sk6Ha0oaT/Ua/k36qsv+xcOILf4ZT2W96ipUThbauOofaoHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346518; c=relaxed/simple;
	bh=Cb+NXIH48Kkw11qaZsseHZFKNfSgPOl1/qv/9hLQSZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d4qS2VzNQBfVtBt34kRH0gjxE5G1XXMN06xf9Ed604Li9iL7Gqf+b66kPnCmbA+F/FOsIdIvILha/v+6pLqZ82e+NfrfqkvfgmoSHVkDbFlYsVmDF4YlvuV6d8oOujucXEzHx26PIN+GqZ9nQeT1NVQGEwSNRQRLzeHxSHrKywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCI/kFG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758CBC4CED1;
	Fri,  7 Mar 2025 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741346516;
	bh=Cb+NXIH48Kkw11qaZsseHZFKNfSgPOl1/qv/9hLQSZQ=;
	h=From:Subject:Date:To:Cc:From;
	b=UCI/kFG3C4Gplbr5GAgTimw+9bz1/tOjn9q64TAvoKj8vb3hU4jVjCWRQi5CxHS6C
	 5AUezAGkeW1JTmzd8P20/AHkrVU2UcPuFtzO5HO0+IczwJd9MZgCaPQRAMeSerh8eh
	 0nFwrQuzbfftBJcU77xAB5dq75yFBWBj9W/ed9wai3B5323MY5xt+EbsupCCNo6cCt
	 AtDosWfOA2Auojk9u8D8mlHYi4bbPuI5YA0aIhkpqYQuwvSwzeyRTLFuMIlbhMXyqm
	 cCNujnE5G/3MZiQzWA/26LZGpdd01aNUBxEseBXygt8JGts7joHTJGUS7v1oS2dgGH
	 9DpTZSyXJ6LmA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 00/15] mptcp: pm: code reorganisation
Date: Fri, 07 Mar 2025 12:21:44 +0100
Message-Id: <20250307-net-next-mptcp-pm-reorg-v1-0-abef20ada03b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjWymcC/zWMuwqAMAwAf0UyG6gW8fEr4lBt1AzWkhYpiP9uE
 RxuuOHuhkDCFGAobhC6OPDpslRlActu3EbINjvUqm6UVi06ipkU8fBx8egPFDplw7nt+lXb3mh
 jIddeaOX0nUf4I5ie5wVX6VJ+cwAAAA==
X-Change-ID: 20250307-net-next-mptcp-pm-reorg-b789f3d9a3ad
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4163; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Cb+NXIH48Kkw11qaZsseHZFKNfSgPOl1/qv/9hLQSZQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnytbREyul2FQJyiHPst87h0E3fmMojRij+6/Cu
 Z3q6gURGhiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8rW0QAKCRD2t4JPQmmg
 c4reEACDrXvUaL5SoblPkv+KBsL+et8xJby97ga6CzPdTvbSTD8W9xeX36rBF5BUY4NAeB5M7Np
 jJdqtjY9wjSk3o6B2p4mZaJLzASQgFMrIMeaRypEpqQqIDCwvovYQzgdBbiB1f7C9T66T5T0Aad
 7T05FJJl0RZbacwXZrxrP8+0ELdEpIHffOnjwiHXSJvtaEW2USnPd2SqQgmoyqeNvA7trB8YrlN
 cp7anqrKTuqYX0etpbAcP9eM5RBxl9PVL6/Vnuai3qa6YSCSZhMFkKuvzgHK/rZ/QNKZ2yJwsHP
 m8NLeuX0kNS2syEH4vzC/x12VGMwTu9GvrMT+SzkH8Sx+gZz/brPFXHl5I2T0vYCZa/4mCjQHPW
 uTGICzCv6ZDpmBTAOBLdwVFfpWwUuhLjHKiviNz2YgZQ0IJSzU94IBBJbinzRuOQqDu5l/XkTnV
 wfEvMlxWgKjryuAlKdAiKlR3VCc7VfpMia4I+/ef6k7xBs93c4bLgJ0HaNCk2FZwEF353niszwl
 IiiQU4TBpBZLodwub0tzZAcRA1j7lPKnEq5E99vM08c79hqjI/2/7jMfRAVxbO5JAURsBZua4iA
 SNQ7zCZywMUOTN4U7dfeSOmbq5vzKPbJGdl8OMmMr+JnncHio4zFac05VhVuOVdT74zclXC5ERX
 2ymrS+ciMBoq6/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this series, the PM code was dispersed in different places:

- pm.c had common code for all PMs.

- pm_netlink.c was initially only about the in-kernel PM, but ended up
  also getting exported common helpers, callbacks used by the different
  PMs, NL events for PM userspace daemon, etc. quite confusing.

- pm_userspace.c had userspace PM only code, but it was using "specific"
  in-kernel PM helpers according to their names.

To clarify the code, a reorganisation is suggested here, only by moving
code around, and small helper renaming to avoid confusions:

- pm_netlink.c now only contains common PM generic Netlink code:
  - PM events: this code was already there
  - shared helpers around Netlink code that were already there as well
  - shared Netlink commands code from pm.c

- pm_kernel.c now contains only code that is specific to the in-kernel
  PM. Now all functions are either called from:
  - pm.c: events coming from the core, when this PM is being used
  - pm_netlink.c: for shared Netlink commands
  - mptcp_pm_gen.c: for Netlink commands specific to the in-kernel PM
  - sockopt.c: for the exported counters per netns

- pm.c got many code from pm_netlink.c:
  - helpers used from both PMs and not linked to Netlink
  - callbacks used by different PMs, e.g. ADD_ADDR management
  - some helpers have been renamed to remove the '_nl' prefix, and some
    have been marked as 'static'.

- protocol.h has been updated accordingly:
  - some helpers no longer need to be exported
  - new ones needed to be exported: they have been prefixed if needed.

The code around the PM is now less confusing, which should help for the
maintenance in the long term, and the introduction of a PM Ops.

This will certainly impact future backports, but because other cleanups
have already done recently, and more are coming to ease the addition of
a new path-manager controlled with BPF (struct_ops), doing that now
seems to be a good time. Also, many issues around the PM have been fixed
a few months ago while increasing the code coverage in the selftests, so
such big reorganisation can be done with more confidence now.

Note that checkpatch, when used with --max-line-length=80, will complain
 about lines being over the 80 limits, but these warnings were already
there before moving the code around.

Also, patch 1 is not directly related to the code reorganisation, but it
was a remaining cleanup that we didn't upstream before, because it was
conflicting with another patch that has been sent for inclusion to the
net tree.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Geliang Tang (1):
      mptcp: pm: use addr entry for get_local_id

Matthieu Baerts (NGI0) (14):
      mptcp: pm: remove '_nl' from mptcp_pm_nl_addr_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_mp_prio_send_ack
      mptcp: pm: remove '_nl' from mptcp_pm_nl_work
      mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received
      mptcp: pm: remove '_nl' from mptcp_pm_nl_subflow_chk_stale()
      mptcp: pm: remove '_nl' from mptcp_pm_nl_is_init_remote_addr
      mptcp: pm: kernel: add '_pm' to mptcp_nl_set_flags
      mptcp: pm: avoid calling PM specific code from core
      mptcp: pm: worker: split in-kernel and common tasks
      mptcp: pm: export mptcp_remote_address
      mptcp: pm: move generic helper at the top
      mptcp: pm: move generic PM helpers to pm.c
      mptcp: pm: split in-kernel PM specific code
      mptcp: pm: move Netlink PM helpers to pm_netlink.c

 net/mptcp/Makefile       |    2 +-
 net/mptcp/pm.c           |  653 ++++++++++++----
 net/mptcp/pm_kernel.c    | 1410 +++++++++++++++++++++++++++++++++
 net/mptcp/pm_netlink.c   | 1937 ++--------------------------------------------
 net/mptcp/pm_userspace.c |   28 +-
 net/mptcp/protocol.c     |    5 +-
 net/mptcp/protocol.h     |   42 +-
 7 files changed, 2045 insertions(+), 2032 deletions(-)
---
base-commit: 865eddcf0afbcd54f79b81e6327ea40c997714c7
change-id: 20250307-net-next-mptcp-pm-reorg-b789f3d9a3ad

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


