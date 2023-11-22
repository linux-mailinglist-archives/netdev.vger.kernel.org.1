Return-Path: <netdev+bounces-50142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6657F4AE9
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2AEB20FD3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE34EB4E;
	Wed, 22 Nov 2023 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIL2eT65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B44CDE2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB460C116B0;
	Wed, 22 Nov 2023 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700667424;
	bh=8R4ieF89QwLamS+6SQ0FPiopWLe1sv6oGljgg/xL5Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIL2eT65JKzi5yZWDQnwqNeeKZn+YxR7lQch9eDM6T5a3ONO7vPQTE5vz5w0Wbjfn
	 9XfP0q/LhYjejGt7fu24srdIPXKlX/EMgRVY4XGGcBMdY0R3Pjzhwoh2KKxHeBZUG9
	 m3a1JjFJjegF8HIN8TTmf7PsEpjPpajdG4M1tLfMozs2U2cD22KaKCba57Z7pmL1G/
	 q0+vj7+X7srISlUDFpoEZkgamyeinLbFa6YbXQ1eIRLHAg89gm5glWBCVfO9f8UqqQ
	 kQpOi4ik8it4qGMFuA7m+BJlLcWtCC+7zyNO7FAGy0zysQ2OLIWhpbPQ888XnJyTH1
	 h3WtVEPj7vx0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Pakhunov <alexey.pakhunov@spacex.com>,
	Vincent Wong <vincent.wong2@spacex.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mchan@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 2/3] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Wed, 22 Nov 2023 10:36:54 -0500
Message-ID: <20231122153658.853640-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153658.853640-1-sashal@kernel.org>
References: <20231122153658.853640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.330
Content-Transfer-Encoding: 8bit

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

[ Upstream commit 17dd5efe5f36a96bd78012594fabe21efb01186b ]

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremented accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://lore.kernel.org/r/20231113182350.37472-2-alexey.pakhunov@spacex.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 96c7a452a4a97..dc27c81ad5129 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7872,8 +7872,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	do {
 		nskb = segs;
-- 
2.42.0


