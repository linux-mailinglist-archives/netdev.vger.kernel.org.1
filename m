Return-Path: <netdev+bounces-74193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2B86072B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADEB91F21CBB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8D713BAE1;
	Thu, 22 Feb 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qri91/87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89C7433DF
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646185; cv=none; b=L7+JDSEwJEjXnO50zDOukr/jqlM/NfP2AKfabgAGtVBgjwPWZEb/6cZ1j9Vlxx4NiMgNiaR3zevZ/Efo7AsdENw0dK6TtR1YEVtIEUp3TqpGExCREag4G95RA5CmJ5h7wTrEYYbB+3K2lstj2LnFbvnTW+5U/ZyJAbAMN6acqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646185; c=relaxed/simple;
	bh=yu/qMtteohJ+NIqUtLEuhIplI6YixEJ1RT6BseY3wiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFTChJfvCy1ACtMTo/qmGMg4VnuHN6nadqEChlxMyfrqGjx2ViEp+onebXZ0miJQ1NUwvZL16/IZxELWBUGiLf0WTQ1RvoWOGhGSMxsQgEcb8mVHO1qQ3wEfEDR10cZmUgieaHjb+Q9G8LcSmWomy71XQGERtiqRD2tGs/On/js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qri91/87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AD8C433F1;
	Thu, 22 Feb 2024 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646185;
	bh=yu/qMtteohJ+NIqUtLEuhIplI6YixEJ1RT6BseY3wiI=;
	h=From:To:Cc:Subject:Date:From;
	b=qri91/87kQyjzjw5TPotU1SAT+fM+Wxfktv05HAwlLER2UhiJxsgKWjcjeetDR4ZL
	 laNyIj4MQr7gwe6cQjUMELyIUiSkbGrYssnvr+m7hHmyNSae/Lpz6GxCwllZumQOBQ
	 pAlxHNP6EykG2xea/p3xk0LEQ61CQhuJom+L/Owxw6L/9iDYldGgdhjnl0LJwItmjb
	 b11rNIuzGlz1MBfVEzPMpM1I2kcJOAOrotznq+KzAqwrLqeuAgPmLCyAdo7N+4l6Fy
	 hiyV98sdF/Cd/xoCxU/RFvjRVDSzAGNd52ugKeXdoHlfcWSSf08jrfJv6gY80TuBGG
	 6/XoRpktr+2hQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	sdf@google.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/15] tools: ynl: stop using libmnl
Date: Thu, 22 Feb 2024 15:55:59 -0800
Message-ID: <20240222235614.180876-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no strong reason to stop using libmnl in ynl but there
are a few small ones which add up.

First, we do much more advanced netlink level parsing than libmnl
in ynl so it's hard to say that libmnl abstracts much from us.
The fact that this series, removing the libmnl dependency, only
adds <300 LoC shows that code savings aren't huge.
OTOH when new types are added (e.g. auto-int) we need to add
compatibility to deal with older version of libmnl (in fact,
even tho patches have been sent months ago, auto-ints are still
not supported in libmnl.git).

Second, the dependency makes ynl less self contained, and harder
to vendor in. Whether vendoring libraries into projects is a good
idea is a separate discussion, nonetheless, people want to do it.

Third, there are small annoyances with the libmnl APIs which
are hard to fix in backward-compatible ways.

All in all, libmnl is a great library, but with all the code
generation and structured parsing, ynl is better served by going
its own way.

Jakub Kicinski (15):
  tools: ynl: give up on libmnl for auto-ints
  tools: ynl: create local attribute helpers
  tools: ynl: create local for_each helpers
  tools: ynl: create local nlmsg access helpers
  tools: ynl: create local ARRAY_SIZE() helper
  tools: ynl: make yarg the first member of struct ynl_dump_state
  tools: ynl-gen: remove unused parse code
  tools: ynl: wrap recv() + mnl_cb_run2() into a single helper
  tools: ynl: use ynl_sock_read_msgs() for ACK handling
  tools: ynl: stop using mnl_cb_run2()
  tools: ynl: switch away from mnl_cb_t
  tools: ynl: switch away from MNL_CB_*
  tools: ynl: stop using mnl socket helpers
  tools: ynl: remove the libmnl dependency
  tools: ynl: use MSG_DONTWAIT for getting notifications

 tools/net/ynl/lib/ynl-priv.h   | 352 ++++++++++++++++++++++++++++---
 tools/net/ynl/lib/ynl.c        | 368 +++++++++++++++++----------------
 tools/net/ynl/lib/ynl.h        |   3 +-
 tools/net/ynl/samples/Makefile |   2 +-
 tools/net/ynl/ynl-gen-c.py     | 108 ++++------
 5 files changed, 565 insertions(+), 268 deletions(-)

-- 
2.43.2


