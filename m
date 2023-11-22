Return-Path: <netdev+bounces-50131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78217F4AB3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AB01C20BD3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9554CE0A;
	Wed, 22 Nov 2023 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T65cXr0t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A854CE19
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 15:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A737FC433A9;
	Wed, 22 Nov 2023 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700667327;
	bh=DXWQiyLgU9KG5vqLf7rRBTiYef9MWXIIeD0Uae/lM+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T65cXr0tw+uBzYhd1PLclUPniUCavkXl9Vgm0VvNs2UWwWi06bXP5MT78IPcfb4sU
	 F89ouQqL963tjvvXjPVL3ebBLo3rLCT3gaCoWJ3LaSCB7T0JCrafQsxPaxDEnGdRY+
	 JlXpxvsFEch57zD6ALwf/YmWk5SXRITLAHh9R9M/7Qx/q86G/sVKn/gGquoZhrr9H9
	 uD8Ox6sqLj75cHuqHuTlh1zObDlsgDylyRtIVFiCOmLCsJhwDByIhJDqKoehpiO77X
	 VNlN5olF1+IzgXRfOdlAA22Z2WFirR8uZ7+hoiV0cgNhKtQ3bZl3bggCttIVAeLAoh
	 /rTN6tSQrzRpA==
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
Subject: [PATCH AUTOSEL 5.15 5/7] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Wed, 22 Nov 2023 10:35:05 -0500
Message-ID: <20231122153512.853015-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153512.853015-1-sashal@kernel.org>
References: <20231122153512.853015-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.139
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
index 946b4decac0ce..fc487a6f050a2 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7880,8 +7880,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.42.0


