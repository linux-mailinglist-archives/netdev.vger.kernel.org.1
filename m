Return-Path: <netdev+bounces-20236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060C075E7F8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 03:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4476281554
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B7811;
	Mon, 24 Jul 2023 01:37:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD25C7FA
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DA6C433C9;
	Mon, 24 Jul 2023 01:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690162621;
	bh=rSjN3IcZbqFDf3fYlmZAU3hQZGUDuAwj/Ce5GEIWCXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0/IF8/BkXojGwD8oAcZMRCN0ttdMXANQoaVOY32jqIl/BBRLP+ZSWuBqjQ0rbHDl
	 4FM3U0O8RXEyWnC9xYPc7NKpnwCrnyI2d2czKz+Z2hJXZpoGo9lw0HsypLM3R4Ojcp
	 J0YwsY+77rOOR6NeCY0/fs0Q4eNtIbwJeFeByrbErUydzpHne1C2TxEYJiHdy4T9/p
	 9JCCn3dywjT7BGpu/wHDChCFSLqQC+f6YtMWEIbnH1zmLqd4aEMsG/u+edIFVhNKa5
	 2L8eBCvu3Yx2oNLLinJ4s17HI5d0Eui6wFYpPFqE5MY3t5g+RyL3HejBCe04MQlwKm
	 8mdcE1D8mrS5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhengping Jiang <jiangzp@google.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 7/9] Bluetooth: L2CAP: Fix use-after-free
Date: Sun, 23 Jul 2023 21:35:49 -0400
Message-Id: <20230724013554.2334965-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013554.2334965-1-sashal@kernel.org>
References: <20230724013554.2334965-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.320
Content-Transfer-Encoding: 8bit

From: Zhengping Jiang <jiangzp@google.com>

[ Upstream commit f752a0b334bb95fe9b42ecb511e0864e2768046f ]

Fix potential use-after-free in l2cap_le_command_rej.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 25d88b8cfae97..6bae68b5d439c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5705,9 +5705,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
-- 
2.39.2


