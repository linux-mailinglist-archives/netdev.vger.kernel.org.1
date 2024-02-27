Return-Path: <netdev+bounces-75486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ED186A279
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755981C22039
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A224135884;
	Tue, 27 Feb 2024 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPaClsdD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8121DFEB
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073044; cv=none; b=peegxue5Lj7aPbY1GKtAyGSqivQPH9hxlE5Y+5oyZN0sTDwoVCyac2LOxHoOmBnPHqhXer6igmb9+7ZvSfUt5lWZ9w/DQwifFwKftHyIbgzBat205st3ILXXgB/YbE6kv5VdsZJL074UVTp2nQopP+1q8Zasos5CWh611X4qBwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073044; c=relaxed/simple;
	bh=EjhO7iBnn8JXvl52g8AYAj5H+t+/gNiCOOzXBTln37I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbSLZ+1DMFLCoAEbA2f0NZ+ZuvHxBQv2PJzgzxEThXxDGCjipBRogMf0s77eZ++8zABIoaUFBFguUUkPV6r3mkjMUgzcAWwEFwQjBoRiOklsCh5IUbjYoFIHZeaaDm9Djan8owxAhmIm/C3GWS4rTQrtCAJcDklsieauNIUh8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPaClsdD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917B3C433F1;
	Tue, 27 Feb 2024 22:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709073044;
	bh=EjhO7iBnn8JXvl52g8AYAj5H+t+/gNiCOOzXBTln37I=;
	h=From:To:Cc:Subject:Date:From;
	b=PPaClsdDrfbugjLgxtJPT4lvS5czLcksD7sfd9vnVPnp1D+R35LmsOR1X6TthkahN
	 Mj0/L5d0H0D2gioa7P+d8L2AG+Wv6FnrFNUzbzSu4i/d3bShZudSKbMiVShhtAmBmX
	 ZNLfOMnfy4iVpTEuazSGhCYoLZJPIxW895Cw3Q3KBKIxa3jT0soSPD5JFI0SFG3gGW
	 WF4Q9rN6zwXi91f9ahUlZwtdWNxpwd6hk3/HfBJgDlmiyN0+2hpZbv1c+6VHMlhyJl
	 p9hze2x2GhOOw6m3uknA2aQ2NfC/UKwXIcQ/UHaa7l6sEvB40HyaNyEDvyFs2ylLrg
	 gUd4rrfyOihtA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	donald.hunter@gmail.com,
	jiri@resnulli.us,
	sdf@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/15] tools: ynl: stop using libmnl
Date: Tue, 27 Feb 2024 14:30:17 -0800
Message-ID: <20240227223032.1835527-1-kuba@kernel.org>
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

First (as I remembered immediately after hitting send on v1),
C++ compilers do not like the libmnl for_each macros.
I haven't tried it myself, but having all the code directly
in YNL makes it easier for folks porting to C++ to modify them
and/or make YNL more C++ friendly.

Second, we do much more advanced netlink level parsing in ynl
than libmnl so it's hard to say that libmnl abstracts much from us.
The fact that this series, removing the libmnl dependency, only
adds <300 LoC shows that code savings aren't huge.
OTOH when new types are added (e.g. auto-int) we need to add
compatibility to deal with older version of libmnl (in fact,
even tho patches have been sent months ago, auto-ints are still
not supported in libmnl.git).

Thrid, the dependency makes ynl less self contained, and harder
to vendor in. Whether vendoring libraries into projects is a good
idea is a separate discussion, nonetheless, people want to do it.

Fourth, there are small annoyances with the libmnl APIs which
are hard to fix in backward-compatible ways. See the last patch
for example.

All in all, libmnl is a great library, but with all the code
generation and structured parsing, ynl is better served by going
its own way.

v3:
 patch 2:
     - assume 4B alignment for {s,u}{16,32} getters
v2:
 patch 2:
     - NLA_ALIGN(sizeof(struct nlattr)) -> NLA_HDRLEN;
     - ...put_strz() -> ...put_str()
     - use ynl_attr_data() in ynl_attr_get_{str,s8,u8}()
     - use signed helpers in signed auto-ints
     - use ynl_attr_get_str() instead of ynl_attr_data() in ynl.c
 patch 8:
     - extend commit message
 patch 10:
     - fold NLMSG_NEXT(nlh, rem) into the for () statement

v1: https://lore.kernel.org/all/20240222235614.180876-1-kuba@kernel.org/

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

 tools/net/ynl/lib/ynl-priv.h   | 333 +++++++++++++++++++++++++++---
 tools/net/ynl/lib/ynl.c        | 365 +++++++++++++++++----------------
 tools/net/ynl/lib/ynl.h        |   3 +-
 tools/net/ynl/samples/Makefile |   2 +-
 tools/net/ynl/ynl-gen-c.py     | 110 ++++------
 5 files changed, 544 insertions(+), 269 deletions(-)

-- 
2.43.2


