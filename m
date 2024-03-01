Return-Path: <netdev+bounces-76755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0586EC9E
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 00:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D979287FB8
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 23:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396865EE7A;
	Fri,  1 Mar 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZxg0Mne"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134353C48C
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709334352; cv=none; b=tkcMOoupZTaDCq9Wpu4Zp2r0QIca4fMLdpdNVQTddw3rjcDQ3d9DZAkxHEIqMGybMGhmfr3op20IL9BWcGgF091ohT2enk6ILNzJJFQ5Dxv5duHHMOf+0OXRiKOM3go8EGHo5555XA+fPbFTvEdGW0vpY2mk0R+1Vm3G8oftMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709334352; c=relaxed/simple;
	bh=go0iCHAUzwcSWi6XnBLDemwVxjy2B9YoD44U0zrbntQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cd/51sIehGEuYQ84C5ZYdMshN0BKt/XhqZdkhZny/JwwymtP+5JNsETZyz1qbBh1BUgetUl2JfoVh36by/0h9NEbVz1x/pGMGIUzkeWmwCBKyJb26pFMh5wbzVm+KQlgH19msuy7QYanr/fN2lfpsGvB8/WhqjIJnKHL1O0k2hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZxg0Mne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64836C433C7;
	Fri,  1 Mar 2024 23:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709334351;
	bh=go0iCHAUzwcSWi6XnBLDemwVxjy2B9YoD44U0zrbntQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jZxg0MnehBUbHbfOE0rk1Igfj2TZfOR8TmeFA4EQ4iLVsou3zagHbVv40jVfIJoZg
	 4EL3yxZlj4f+OQ7LZqsgj19V0U0uSC7A48SRtw2gJB/48B9C3Uy77wG4jnlWomHpYz
	 Gf0EtWqD5WVLWT3m0Ur+3Oux8GzvWNa2Vm/HMB5z2t6KpYpFhO9yrWuRy5tgB928jT
	 Dn9+udgm+6B4CG/uKm9q3qtaywVM6/DCk8oYuQB9XOgPyjqzk2u/EZUEvjDpjFKGv5
	 cI4yugujw7yfolaKOiWVuJtegeu66EOLyALxvsZxcbWdCiizhdjl2FxrMjXHwZ92Vq
	 SGjE5TvI8qPYA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] tools: ynl: add --dbg-small-recv for easier kernel testing
Date: Fri,  1 Mar 2024 15:05:38 -0800
Message-ID: <20240301230542.116823-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing netlink dumps I usually hack some user space up
to constrain its user space buffer size (iproute2, ethtool or ynl).
Netlink will try to fill the messages up, so since these apps use
large buffers by default, the dumps are rarely fragmented.

I was hoping to figure out a way to create a selftest for dump
testing, but so far I have no idea how to do that in a useful
and generic way.

Until someone does that, make manual dump testing easier with YNL.
Create a special option for limiting the buffer size, so I don't
have to make the same edits each time, and maybe others will benefit,
too :)

Example:

  $ ./cli.py [...] --dbg-small-recv >/dev/null
  Recv: read 3712 bytes, 29 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 3968 bytes, 31 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 532 bytes, 5 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
     nl_len = 20 (4) nl_flags = 0x2 nl_type = 3

Now let's make the DONE not fit in the last message:

  $ ./cli.py [...] --dbg-small-recv 4499 >/dev/null
  Recv: read 3712 bytes, 29 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 4480 bytes, 35 messages
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
    [...]
     nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
  Recv: read 20 bytes, 1 messages
     nl_len = 20 (4) nl_flags = 0x2 nl_type = 3


A real test would also have to check the messages are complete
and not duplicated. That part has to be done manually right now.

Note that the first message is always conservatively sized by the kernel.
Still, I think this is good enough to be useful.

Jakub Kicinski (4):
  tools: ynl: move the new line in NlMsg __repr__
  tools: ynl: allow setting recv() size
  tools: ynl: support debug printing messages
  tools: ynl: add --dbg-small-recv for easier kernel testing

 tools/net/ynl/cli.py     |  7 ++++++-
 tools/net/ynl/lib/ynl.py | 42 ++++++++++++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 7 deletions(-)

-- 
2.44.0


