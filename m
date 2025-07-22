Return-Path: <netdev+bounces-209048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF432B0E192
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F12AC3B7D
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B74327D770;
	Tue, 22 Jul 2025 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+mZyrR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF127CCF0
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201186; cv=none; b=LyNh2XfkfTY/vy7CI6dT1D6Pohv7pD2GuJAPB3Ttom8CbqeEOEfvXct7js6m23fOpu/GUos5AmV1GQ4d2rM/WdLt6qZ7rojJzX2jkDZckNvowwDjfyitVe4qAPiCUonEhZ13Et9rnNuUbehzRKPAMuPoFviYnaqONmrV5yUAmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201186; c=relaxed/simple;
	bh=HRZyTqKOfu0Y6EMvDz/Bt1o9jYdrBjKCXHx+vaKWAMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Au1g9rIRhPGSiGcr47JjYWRI1KotVn2SA94nORE6fJOowK4ewuK3rGJlzPNgfU5fxorhBSpWGZj2MnvmjaqQGkTgOZmxnxhCUCuQx7AiOC6Ve+AKc7wepTgXOomoAV1V8kJgHsSgW+uRsgUjU1MZGO8K+x0foWp9Z5AefYdke+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+mZyrR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34932C4CEEB;
	Tue, 22 Jul 2025 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753201184;
	bh=HRZyTqKOfu0Y6EMvDz/Bt1o9jYdrBjKCXHx+vaKWAMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+mZyrR4VL6l2uP2AX7PtsNmdVc5VV5DxbXXgND4IFZvbiJ9STzSIZJGD8jNVzcLI
	 pg8SkgwXMT0JCrm7rTU3XGVOXKZW1k123Y78eSFbOJ1UHCYifBMhNRnOyN3XWFXoUG
	 H4v0hGljAguzaXHoKBFvn4im0CA4MsoadIErOJN0bpt9mCGYOR4+lbD67VTwEULjaM
	 caJ93P2NOslhIJ9LPAmxfO2sW0GVmBlnDFIa3KyHe0IrZVofKgFlqT1ptgtqpdftwB
	 MeDZ3pLmxG+u8VSEVI3dKc3n/nIHqwqP6YNhDhoMpasLixzbENTP9k9V5WBaQlNpSj
	 8pt8VBH95DkQw==
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
Subject: [PATCH net-next 5/5] selftests: drv-net: devmem: use new mattr ynl helpers
Date: Tue, 22 Jul 2025 09:19:27 -0700
Message-ID: <20250722161927.3489203-6-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722161927.3489203-1-kuba@kernel.org>
References: <20250722161927.3489203-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the just-added YNL helpers instead of manually setting
"_present" bits in the queue attrs. Compile tested only.

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


