Return-Path: <netdev+bounces-231848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A25BFDFE1
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B7E188E3DB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42532A3F2;
	Wed, 22 Oct 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe9mta9v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843F32860B
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160637; cv=none; b=OAsBbDU5bqPaxeN80EGpShzRQxlZcmJP7sfx+DXVEujOO6EpTpMjA69Hba3HaleHj2Xxcl2hCcoDfUYwCnk1qyx1mSYKKunEWMQcAZCEFkp/SXomhpI+TglBFWO7oeQnBFOL15OZ1sf3OlWj10osTekIRI15k9/DWctdJqR4hfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160637; c=relaxed/simple;
	bh=a9X0pbkHIsKsJCwPaKQgVXDkb5RtA6GrXmDnL4jrNtE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EdA2fkGmakLyfxMcXtps3rRb1R9XtV2Qp1T8BfwyMeb1XFOsxylLEi7tTkOfjGBwYKjIjJWoaj+KqIeehMlpA3FWdU3DpHZrel+23MHQYyGfz36z23j7PKOFyXDRMJSfg2zPuTkUBiL6ldxzy5tcsSr7wnZEysPiVbNlu1vg+DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe9mta9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B694DC4CEE7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160636;
	bh=a9X0pbkHIsKsJCwPaKQgVXDkb5RtA6GrXmDnL4jrNtE=;
	h=From:To:Subject:Date:From;
	b=oe9mta9vwOhMjHLUYZucGrPj8E6nnHluSE9lIxQDeKlWibXXmpsUL17ARJAa00qU+
	 byfPhZwdfddNudoOk+fnKolNkmiM43PFTp8By9m3wJNunKxoerTCR/fCAWzzUDhatq
	 i2R8Qmnx9YDheWlDmZZFNtdFV7hzoAoa3lACoRG1M48/zOAiKbtwmQBZHl4CtJz44i
	 BRH4nHxjMS7lRafvaqhXq9rvXaQePZ7Db580nS/xydrfqypnZ2Itd/Jl8drF4VP3eD
	 BhgLc80bKKTuQ0i+9pALXeiwtUMKmHPjuV82jeHnNDxiGcd8bpPKE5H2nKOC2KjHGc
	 YWdGhxtpt4Tdg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 00/15] net/rds: RDS-TCP bug fix collection
Date: Wed, 22 Oct 2025 12:17:00 -0700
Message-ID: <20251022191715.157755-1-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

Hi all,

This set is a collection of  bug-fixes we've been working on for RDS.

This series was last seen in April, but further testing turned up
additional bugs that we thought best to address as part of the same
effort. So the series has grown a bit, and I’ve restarted versioning
since the set sent last spring. Many of the April patches are retained
here though.

To refresh: under stress testing, RDS has shown dropped or
out-of-sequence message issues. These patches address those problems,
together with a bit of work queue refactoring.

Since the April posting, patches 2, 3, 6 and 10–16 are new. To ease
reviewing, I was thinking we could split the set into smaller logical
subsets.  Maybe something like this:

Workqueue scalability (subset 1)
net/rds: Add per cp work queue
net/rds: Give each connection its own workqueue

Bug fixes (subset 2)
net/rds: Change return code from rds_send_xmit() when lock is taken
net/rds: No shortcut out of RDS_CONN_ERROR
net/rds: rds_tcp_accept_one ought to not discard messages

Protocol/extension fixes (subset 3)
net/rds: new extension header: rdma bytes
net/rds: Encode cp_index in TCP source port
net/rds: rds_tcp_conn_path_shutdown must not discard messages
net/rds: Kick-start TCP receiver after accept
net/rds: Clear reconnect pending bit
net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives
net/rds: Trigger rds_send_hs_ping() more than once

Send path and fan-out fixes (subset 4)
net/rds: Delegate fan-out to a background worker
net/rds: Use proper peer port number even when not connected
net/rds: rds_sendmsg should not discard payload_len

If this breakdown seems useful, we can start with just the first set
and I'll keep with a branch with the full set available for those who
want to look ahead.  Otherwise I’ll keep the full set together.  Let me
know what would be most helpful.

Questions, comments, flames appreciated!
Thanks,
Allison


Allison Henderson (2):
  net/rds: Add per cp work queue
  net/rds: rds_sendmsg should not discard payload_len

Gerd Rausch (8):
  net/rds: No shortcut out of RDS_CONN_ERROR
  net/rds: rds_tcp_accept_one ought to not discard messages
  net/rds: Encode cp_index in TCP source port
  net/rds: rds_tcp_conn_path_shutdown must not discard messages
  net/rds: Kick-start TCP receiver after accept
  net/rds: Use the first lane until RDS_EXTHDR_NPATHS arrives
  net/rds: Trigger rds_send_ping() more than once
  net/rds: Delegate fan-out to a background worker

Greg Jumper (1):
  net/rds: Use proper peer port number even when not connected

Håkon Bugge (3):
  net/rds: Give each connection its own workqueue
  net/rds: Change return code from rds_send_xmit() when lock is taken
  net/rds: Clear reconnect pending bit

Shamir Rabinovitch (1):
  net/rds: new extension header: rdma bytes

 net/rds/connection.c  |  25 ++++-
 net/rds/ib.c          |   5 +
 net/rds/ib_recv.c     |   2 +-
 net/rds/ib_send.c     |  21 +++-
 net/rds/message.c     |  66 +++++++++---
 net/rds/rds.h         |  97 +++++++++++------
 net/rds/recv.c        |  39 ++++++-
 net/rds/send.c        | 136 +++++++++++++++---------
 net/rds/stats.c       |   1 +
 net/rds/tcp.c         |  31 +++---
 net/rds/tcp.h         |  34 ++++--
 net/rds/tcp_connect.c |  70 +++++++++++-
 net/rds/tcp_listen.c  | 240 +++++++++++++++++++++++++++++++++++-------
 net/rds/tcp_recv.c    |   6 +-
 net/rds/tcp_send.c    |   4 +-
 net/rds/threads.c     |  17 +--
 16 files changed, 618 insertions(+), 176 deletions(-)

-- 
2.43.0


