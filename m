Return-Path: <netdev+bounces-72869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E7285A042
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C687F1C20DBB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32624A19;
	Mon, 19 Feb 2024 09:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="JC8XCzSV"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639E28DA0
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336437; cv=none; b=cnFBQBeUQnKj9J7ORzXijoWKq1TE6KDzutJ87UFx42GkTb7FcmWt2qCIZvSb7exCjCVtH+ijZZX8gelcDeF/cvjKHKKAfDLPN04xbWmKCyX+8KyHav8B+roRmPFEZAF0Z0GYr8BxJN95Ut5HdIP9H/+Syv+Tz3o9+wzabuPSHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336437; c=relaxed/simple;
	bh=5stRCZViPzAYVAYsCHKxKF6fXpOyt7/u9ofGMpIw6Pc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYjnxKYFS5mUJ1s4vYUelc2gO0lmZE4d1YTRVEYonkZX+AOiJWpXC3yNACO8Im7rDmTuB4DrwE5kkRB01iXDSUbPcli8c0jlHfV0IQ5GWk6tUXs/xYOGZX/bJHsSvaWJGCGqhiqQjkSlgelkcCgAS0OwKHARpugUB86NCxKguWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=JC8XCzSV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 961B2200E0; Mon, 19 Feb 2024 17:53:53 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336433;
	bh=oqJcJ9H3wWqvx8QKPoSk3O5yWhsIVmp59RHcFcMOFpA=;
	h=From:To:Cc:Subject:Date;
	b=JC8XCzSVUQseMCT/n8JiQ64CVW07KBpEf8Wwp6+Kt/ZePO1kD3Q2jq9bvhhpXTnJz
	 bXS5NreWMQJtvIpmsab6oOXqxyKobCKAKfMIrgwdfDO0gAnlQaiOhQAXOVHv50VUZg
	 D/wxCGR91o3E3fPtd02t0Uc6DfeI/durdqDdA42BkTPaJWp/KZzDOt+Uw+HWWBAe7Q
	 Sm4mhOFRRjRbbkJ2e5wK3AcyH0gtY14Bhs5S7HhG4V2JI2OTHdqG8ybbExO3Hh8VqL
	 NLoj/KYtNakU0YD162X2p4XQMDt9E2p+PqeqGFt17JlW8RPllS3HZHcm2ioSJNunnF
	 57++Bi6LZxvxg==
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
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 00/11] MCTP core protocol updates, minor fixes & tests
Date: Mon, 19 Feb 2024 17:51:45 +0800
Message-Id: <cover.1708335994.git.jk@codeconstruct.com.au>
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

---
v2:
 - [06/11] fix forwards-compat check on local_peer, based on feedback
   from Dan Carpenter <dan.carpenter@linaro.org>
 - [10/11] don't skip the flow tests for a kunit all-tests run, based on
   feedback from Jakub Kicinski <kuba@kernel.org>

---
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

 include/net/mctp.h                           |   6 +-
 include/uapi/linux/mctp.h                    |  32 ++
 net/core/skbuff.c                            |   8 +
 net/mctp/Kconfig                             |   1 +
 net/mctp/af_mctp.c                           | 117 +++++-
 net/mctp/route.c                             | 105 ++++-
 net/mctp/test/route-test.c                   | 413 ++++++++++++++++++-
 net/mctp/test/utils.c                        |   2 +
 tools/testing/kunit/configs/all_tests.config |   1 +
 9 files changed, 630 insertions(+), 55 deletions(-)

-- 
2.39.2


