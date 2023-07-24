Return-Path: <netdev+bounces-20225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E67B75E7B2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 03:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1686F1C209A4
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 01:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1BC7FA;
	Mon, 24 Jul 2023 01:33:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8CEA5
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4765FC433CB;
	Mon, 24 Jul 2023 01:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690162384;
	bh=UyHxfqUl9MQg/GfcFVN8UXFu7u8PfUUqHYukYbKHR6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxOwL+CKPl5X8G4AW0/9V54vK2SljDsxckKu5qACOogdasoPGVEUUDzOJHB8Ao0Qh
	 TAmhkwVtRTGAsvhMkBflgJ/fm0q9CbvkB5ZG4RfE+sNWcOXhfkMaMvKnE8YasQBCLM
	 c+mmrkqeNG9nRc1f+YGYJbR7SCWc8Ef0xxqfwkpCvrM1Oo+t0CkEUBuoyTbHjoe60s
	 t0ZXlkrI/4ZBDWGEZIW4N9pZCLc2/SlM4kFKQvXL+SBvvjbgiNVPTtHGeeo3rJVAnu
	 SgNLnyEGzfs2LXxWSPXeXKGhIslvczlpwQgBC7bGMUzquPkeZs7ejmDtKfaldLFlmn
	 xz6Rk5BvQxxiw==
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
Subject: [PATCH AUTOSEL 6.1 19/34] Bluetooth: L2CAP: Fix use-after-free
Date: Sun, 23 Jul 2023 21:32:22 -0400
Message-Id: <20230724013238.2329166-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013238.2329166-1-sashal@kernel.org>
References: <20230724013238.2329166-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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
index 02fc9961464cf..a7899857aee5d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6375,9 +6375,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
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


