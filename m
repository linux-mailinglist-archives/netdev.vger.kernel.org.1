Return-Path: <netdev+bounces-75099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042148682DC
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 22:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE62887C5
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4181130E5E;
	Mon, 26 Feb 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX71Fzo+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE692130AF9
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982428; cv=none; b=UpCBY2SS+9BWPB+7FyyvGzxoEAjJy1z9klnazAGZAZbGATj5BDNWItxjFp0PBq/Dp9Jl36ntWkwzVP438wnaUY53M/cZ2ac6WsKfTRONon35fwWQyJHXMMpJumeO8RaZ26Rz8Up73Pt1TrE2clut+yIyhuvY4gjXcR6G4Jps2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982428; c=relaxed/simple;
	bh=QL+RhLrzgBFVMZfXMiOu25PpnEhTjsOnjifPK4qRes4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DFnTgQDTtsVHfdf5H9I64wWzFlz4EMylxxeP0LItiI/+frkQUHIW0QD9z89vLhpkh25+pvjHrPkXg4rJvkkr96tux2+eVqWTn1smovCVOugYYqCo3gSPfOBPz3hyDbT87YmTWDmiX7AdlPlu6q6i2aoFOKVVmni8d3cUIynwz5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX71Fzo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016BBC433C7;
	Mon, 26 Feb 2024 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982428;
	bh=QL+RhLrzgBFVMZfXMiOu25PpnEhTjsOnjifPK4qRes4=;
	h=From:To:Cc:Subject:Date:From;
	b=AX71Fzo+1gu0ykZxlp2AjD4lNX5zFOoCUc14+5jGbVyvXeHkunR0giXe7/5vSpz0M
	 m61gEkrbN86hcDofn8baEk7YmIl2LekAqYy4eRDMbTe12eS6Oj8bVPHvCVk9Eg1Jjp
	 5ZHEPGlGCUKzeD98AUu4SGhtcZ00Ka4yHevG9rB6wDgYxMocX+EtrwxSQhkyjzmml5
	 he8dmlqc0TsWun6HoojrCzt2tuXt+eb2FfxmrQb5aQWrXvLX9+55AlLiGvKwELNZy6
	 AG0HQvr/CyLS90P7PbUbJUubiAtVZYjen+HHCrnOQSHQpVaiLJfuDXVjIh5SU5FiW7
	 GGVulN3GqfkBA==
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
Subject: [PATCH net-next v2 00/15] tools: ynl: stop using libmnl
Date: Mon, 26 Feb 2024 13:20:06 -0800
Message-ID: <20240226212021.1247379-1-kuba@kernel.org>
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

 tools/net/ynl/lib/ynl-priv.h   | 345 ++++++++++++++++++++++++++++---
 tools/net/ynl/lib/ynl.c        | 365 +++++++++++++++++----------------
 tools/net/ynl/lib/ynl.h        |   3 +-
 tools/net/ynl/samples/Makefile |   2 +-
 tools/net/ynl/ynl-gen-c.py     | 110 ++++------
 5 files changed, 556 insertions(+), 269 deletions(-)

-- 
2.43.2


