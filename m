Return-Path: <netdev+bounces-110029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FBA92AB56
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0CC28365F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6314B959;
	Mon,  8 Jul 2024 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjW0uVaa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049A145B06
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474597; cv=none; b=NiECQKQmqHmT7Kl26gX2Xs9w0sMDHhbT3auQPm0rSjIhpoJLs+kKcX6O0UVVqkGncFdRFzZpqcQyAGZkRQ4Z9zun2w2/OFWKaPvAEf2bylQjOUl7qMc9qSZzAI3RYHj8lbFkAO70BzWBrWbrREWDSyyPFa8jVpSxNI1JHW+G+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474597; c=relaxed/simple;
	bh=VKYpMsEuhXmCd1sFghCMjwDgaH8qFFl9pQ2ZXpTMna4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRCFybGh4MAV+YlUPBI8QYFMQw0RpxfwrkDUfrv22s0RegXNxe/Kpfxt4hqnJNrnWM8IfjszFZRm2XRXagXo9JaV9FVDH0nU4n0vpxuc9UQqeu6W+kKhqA66BkRZGHHRX9xolu+xjxL0i5SA1XyLUy1kmIwiOx1LS8daVNUNIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjW0uVaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63443C116B1;
	Mon,  8 Jul 2024 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720474596;
	bh=VKYpMsEuhXmCd1sFghCMjwDgaH8qFFl9pQ2ZXpTMna4=;
	h=From:To:Cc:Subject:Date:From;
	b=gjW0uVaas+JpZAujqdYoFoAhOCm4a3RpoJe/JL1Vva7H3bXDFiclf55c/W+FU9x74
	 OsC1xS6qTEOyg2TCbscGXolaetcbJ3ImhnXAefnMjGRijAlf8OxNV1Mgx+n+o8BDsM
	 JwtB4EsmjYaeJePG6U1tpLV7zI+3E0cjO82t7hG5ftBqn+X9kOWMyDLMPz+BL8Ms2F
	 6iesxhziykIFP5q4KQr1dP/QIIVM+9x4ui07QDUqC2Hq03eCOovSIU5VVZ33jeZGs0
	 PcQc1ZJfXH4El5rcsZhImLWvxAZ2NSkWoAUR92szrPxKwG1GPKKCv7zmrBUJqrqWkr
	 h2KO+CTpYfuFQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/5] selftests: drv-net: rss_ctx: more tests
Date: Mon,  8 Jul 2024 14:36:22 -0700
Message-ID: <20240708213627.226025-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a few more tests for RSS.

v2:
 - update the commit messages
 - add a comment in patch 2
v1: https://lore.kernel.org/all/20240705015725.680275-1-kuba@kernel.org/

Jakub Kicinski (5):
  selftests: drv-net: rss_ctx: fix cleanup in the basic test
  selftests: drv-net: rss_ctx: factor out send traffic and check
  selftests: drv-net: rss_ctx: test queue changes vs user RSS config
  selftests: drv-net: rss_ctx: check behavior of indirection table
    resizing
  selftests: drv-net: rss_ctx: test flow rehashing without impacting
    traffic

 .../selftests/drivers/net/hw/rss_ctx.py       | 214 ++++++++++++++++--
 1 file changed, 189 insertions(+), 25 deletions(-)

-- 
2.45.2


