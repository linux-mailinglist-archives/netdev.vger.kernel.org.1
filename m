Return-Path: <netdev+bounces-72293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D2A857789
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0421C21139
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DAB1BC39;
	Fri, 16 Feb 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HZFkTeAD"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1101C69F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071581; cv=none; b=MJci5MyOLBL7H1vkaZVe3RbjVliJa1eWTZQpDsdKlMnIp7DSdJ1boAvLzZNPmur437JIbi+wBd3wS4Jaw8CjME4TCT+qNUQa188Y22jiJ0+hQ984Z1yzdKzy/OQ3d6jxr0uSkde85zH3K1bxfK3YnP8UGhX+R1h3sr/FOmX3fGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071581; c=relaxed/simple;
	bh=9hgz5+EFxfUIpB+WnRkb79eXsnxvdlyUvB3WaEPxiUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CEhBftiVmj5sLOpXZCGfP4MynMNx80qv6V1YFaa4nx7UXp4LQX2W/vKSrUqQUnLMYlDi9Z5TYV4PIqCFVI7Jf+uG1IzQF48/PRYS19SFiEf4QZf5UiEL6/lj/xtGZc9cucM+L9AQfdw3ZKgt/zdrsEALITxAJIoPRRritROT6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HZFkTeAD; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id D19142014A; Fri, 16 Feb 2024 16:19:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071571;
	bh=bXPLzqTSwCC6KKTJNk6uKWBVqPZ8x5kT8VRXK4ya3FM=;
	h=From:To:Cc:Subject:Date;
	b=HZFkTeADko5VBMPa2OqP3jzCzmxFSHQk/t/siCFhGei9zW2MBm4qGSxuTk0W8pFkL
	 MndyQLA+VenD/XYJZ0vcQ9PGLadtRcibNdo09I89XWi45jP+DeBmiNICyeY81MVUS3
	 WZNJ5amIXJG5DXMyx+uW4q/UbjIcZ0Sp1mgvC8a8RIzpemE6QusiqPa+QFmUN87sxo
	 K0DZ1mlqn1bUADpltnKpTb2hMRfbO1LZcKXY6LYplE+tKXIEQUX8Ce82zaQeVuirxs
	 Em3vLhIHV5eNtRN7qA3BsWOSVOFizURyC7r8QyYBXDP0bJO3Zzhi+TKKTtMcRl6jLh
	 P5peBkOOyS0kw==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 00/11] MCTP core protocol updates, minor fixes & tests
Date: Fri, 16 Feb 2024 16:19:10 +0800
Message-Id: <cover.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements some procotol improvements for AF_MCTP,
particularly for systems with multiple MCTP networks defined. For those,
we need to add the network ID to the tag lookups, which then suggests an
updated version of the tag allocate / drop ioctl to allow the net ID to
be specified there too.

The ioctl change affects uabi, so might warrant some extra attention.

There are also a couple of new kunit tests for multiple-net
configurations.

We have a fix for populating the flow data when fragmenting, and a
testcase for that too.

Of course, any queries/comments/etc., please let me know!

Cheers,


Jeremy


Jeremy Kerr (11):
  net: mctp: avoid confusion over local/peer dest/source addresses
  net: mctp: Add some detail on the key allocation implementation
  net: mctp: make key lookups match the ANY address on either local or
    peer
  net: mctp: tests: create test skbs with the correct net and device
  net: mctp: separate key correlation across nets
  net: mctp: provide a more specific tag allocation ioctl
  net: mctp: tests: Add netid argument to __mctp_route_test_init
  net: mctp: tests: Add MCTP net isolation tests
  net: mctp: copy skb ext data when fragmenting
  net: mctp: tests: Test that outgoing skbs have flow data populated
  net: mctp: tests: Add a test for proper tag creation on local output

 include/net/mctp.h         |   6 +-
 include/uapi/linux/mctp.h  |  32 +++
 net/core/skbuff.c          |   8 +
 net/mctp/af_mctp.c         | 117 +++++++++--
 net/mctp/route.c           | 105 ++++++++--
 net/mctp/test/route-test.c | 413 +++++++++++++++++++++++++++++++++++--
 net/mctp/test/utils.c      |   2 +
 7 files changed, 628 insertions(+), 55 deletions(-)

-- 
2.39.2


