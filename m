Return-Path: <netdev+bounces-46415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188337E3BE3
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C991C20AC8
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B338C2E407;
	Tue,  7 Nov 2023 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctTGF9cu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832802E405
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABF9C433CB;
	Tue,  7 Nov 2023 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359040;
	bh=8PrEx8iYK9pYZ/QS5uRSL96JvWUQTeSTEVgUMjOE2p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctTGF9cuEZTSI0i0r+o+LiAOiqJgoTwrJ+K3ede1uuIq2VsRWPw5Hg29j2LzcdG6l
	 RUsb4h92x4T5d4uXHQymid6wDknp3GWJZrD0/t98x2MdBqhZVO9QOPBVT/M4OS18hJ
	 rhmKy+2X9lb7GxQTx9e5OXXFigFJagRZyiApbDiU2gPbQ40FXE+Xiaax7g6gXTsLI4
	 hR7XKUqqzLRJfKvgI4hPTll9P1QGiEQyGXzqgj615YlWITIYDEqAO4TcrqOSiH3dCZ
	 rZ6Bh2HUKJJcVMoQsBer9Rm0eEGD6bPG+EsuBsUw++CQZ/RsC516CLbH/uRRNvf+ln
	 CTXhlQmkDnz4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
	kernel test robot <lkp@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	hawk@kernel.org,
	alexanderduyck@fb.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 26/30] tsnep: Fix tsnep_request_irq() format-overflow warning
Date: Tue,  7 Nov 2023 07:08:41 -0500
Message-ID: <20231107120922.3757126-26-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit

From: Gerhard Engleder <gerhard@engleder-embedded.com>

[ Upstream commit 00e984cb986b31e9313745e51daceaa1e1eb7351 ]

Compiler warns about a possible format-overflow in tsnep_request_irq():
drivers/net/ethernet/engleder/tsnep_main.c:884:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
                         sprintf(queue->name, "%s-rx-%d", name,
                                                       ^
drivers/net/ethernet/engleder/tsnep_main.c:881:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
                         sprintf(queue->name, "%s-tx-%d", name,
                                                       ^
drivers/net/ethernet/engleder/tsnep_main.c:878:49: warning: '-txrx-' directive writing 6 bytes into a region of size between 5 and 25 [-Wformat-overflow=]
                         sprintf(queue->name, "%s-txrx-%d", name,
                                                 ^~~~~~

Actually overflow cannot happen. Name is limited to IFNAMSIZ, because
netdev_name() is called during ndo_open(). queue_index is single char,
because less than 10 queues are supported.

Fix warning with snprintf(). Additionally increase buffer to 32 bytes,
because those 7 additional bytes were unused anyway.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310182028.vmDthIUa-lkp@intel.com/
Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://lore.kernel.org/r/20231023183856.58373-1-gerhard@engleder-embedded.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/engleder/tsnep.h      |  2 +-
 drivers/net/ethernet/engleder/tsnep_main.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
index 11b29f56aaf9c..b91abe9efb517 100644
--- a/drivers/net/ethernet/engleder/tsnep.h
+++ b/drivers/net/ethernet/engleder/tsnep.h
@@ -142,7 +142,7 @@ struct tsnep_rx {
 
 struct tsnep_queue {
 	struct tsnep_adapter *adapter;
-	char name[IFNAMSIZ + 9];
+	char name[IFNAMSIZ + 16];
 
 	struct tsnep_tx *tx;
 	struct tsnep_rx *rx;
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 479156576bc8a..e3fc894fa3f6f 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -1778,14 +1778,14 @@ static int tsnep_request_irq(struct tsnep_queue *queue, bool first)
 		dev = queue->adapter;
 	} else {
 		if (queue->tx && queue->rx)
-			sprintf(queue->name, "%s-txrx-%d", name,
-				queue->rx->queue_index);
+			snprintf(queue->name, sizeof(queue->name), "%s-txrx-%d",
+				 name, queue->rx->queue_index);
 		else if (queue->tx)
-			sprintf(queue->name, "%s-tx-%d", name,
-				queue->tx->queue_index);
+			snprintf(queue->name, sizeof(queue->name), "%s-tx-%d",
+				 name, queue->tx->queue_index);
 		else
-			sprintf(queue->name, "%s-rx-%d", name,
-				queue->rx->queue_index);
+			snprintf(queue->name, sizeof(queue->name), "%s-rx-%d",
+				 name, queue->rx->queue_index);
 		handler = tsnep_irq_txrx;
 		dev = queue;
 	}
-- 
2.42.0


