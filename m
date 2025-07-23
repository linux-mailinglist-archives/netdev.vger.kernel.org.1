Return-Path: <netdev+bounces-209415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1961B0F8B1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B4B961101
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9BF21B1B9;
	Wed, 23 Jul 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIc4cmvB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619021A449
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290662; cv=none; b=fH8kR8jyrLf+zFo08xUczIjNH4OI7r8vC9f9tf++Nk8g8oMYoGywtTghELW7mmtOkKBUqQLPmuA7Das/f8tdghWCYSZQNvN65lurGeezznFzgkmvUKd9T/eClvOolfsU6aEUGinZKX/fINZvAtikiFd2JV94eOq71HHhFm0mIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290662; c=relaxed/simple;
	bh=A1Aifr4XFIRVPd5ceRxU2ybJYb4ta5nHWp8yVoP9FoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZYPRc8pK8RsGy4CW5ic3945UqDED8Fh88XqO3XCjAzOqO9s8wcQfUxRUwycaMhTeucIUkPmWCw6gIbLaZ7dCTO/3aEA5oPdFFeIBPt4GVYjyxZm2dDgcaeVBReEmUV80ltBRBLUEHH3F0p8X5mBWFWpVZQJnJIP2yJarb9y5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIc4cmvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02693C4CEF6;
	Wed, 23 Jul 2025 17:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753290662;
	bh=A1Aifr4XFIRVPd5ceRxU2ybJYb4ta5nHWp8yVoP9FoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIc4cmvBZtVzlNzivhhLcZ5BVDivH+/2Yig/ltxNPBsAKFl1zw0UiCPldlfTWnh/i
	 EC++o/5yhLTRZdDDM5BbDqIGsCv29LCjpCFSbNz8F6y6/e7hrOquN7fIdMpull2wgj
	 w1knQFF+td0+BH7B7mjvgpLx6M8mcRHpf1cl0a9Yn3h3RfMhAmN1y4uo9wOgHJQp9v
	 dvqqDJ2h770ut5v8BvJRpvaxxZjwhm144znqOlGdY15nnYyv4/4OajsU/y5vKRf3Za
	 E+PhPzq+eX7AlXEGRwDtIiShRp49ksQwtncUpBg+YEA4A74kLFl1xDO0w6F/FtIf41
	 6S3JIUC7gezRw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	almasrymina@google.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 5/5] selftests: drv-net: devmem: use new mattr ynl helpers
Date: Wed, 23 Jul 2025 10:10:46 -0700
Message-ID: <20250723171046.4027470-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723171046.4027470-1-kuba@kernel.org>
References: <20250723171046.4027470-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the just-added YNL helpers instead of manually setting
"_present" bits in the queue attrs. Compile tested only.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index cc9b40d9c5d5..72f828021f83 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -526,12 +526,10 @@ static struct netdev_queue_id *create_queues(void)
 	struct netdev_queue_id *queues;
 	size_t i = 0;
 
-	queues = calloc(num_queues, sizeof(*queues));
+	queues = netdev_queue_id_alloc(num_queues);
 	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
+		netdev_queue_id_set_type(&queues[i], NETDEV_QUEUE_TYPE_RX);
+		netdev_queue_id_set_id(&queues[i], start_queue + i);
 	}
 
 	return queues;
-- 
2.50.1


