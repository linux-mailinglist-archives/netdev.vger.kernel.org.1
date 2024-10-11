Return-Path: <netdev+bounces-134529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B5999A003
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8B71F226B4
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560E720C497;
	Fri, 11 Oct 2024 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQRtX5LI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AE20A5F0
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638413; cv=none; b=BBbU0WDDLQiGzrlKKaTLWdeouYEsN7+XdTymGqzZaiLdeAs6Gohw5Mv38ixarBj9OABI05plyycA6CAG1sZXiaNoZmv40jPEhkUwh5Q4PLsU7rBY7mB3wwK1GZuAY4j00dpDcORgNp3bqQ/ZG8A/af/NtBi46w0xpf9CxWjEgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638413; c=relaxed/simple;
	bh=sigie1v2liCAQ6DVVNh8AXWnu7avbUikKp5PzT5T6lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MpuPKkYlyaAeZAo5/NJR3XTR4GUxf6mGnYnx1lDDkUM5oWdWqq1nFgH+i+7lTTKYvPHa99xlbtuXfHXlkOXKhlFN4lM/R+jseu8HIr9m5lRQlO+wXt8lT0raTQCXFR76tg9RSdOH/lQOHS7umxk0GLkuebi83HOqzlMKMlabyN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQRtX5LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7B2C4CEC3;
	Fri, 11 Oct 2024 09:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728638412;
	bh=sigie1v2liCAQ6DVVNh8AXWnu7avbUikKp5PzT5T6lo=;
	h=From:Date:Subject:To:Cc:From;
	b=LQRtX5LIF/yiuMCdCdVwJvohG70Iv0HtoRRufr5yzf9BH/hMBp4kSNAVcXWYJx7Ub
	 DxZjcmc4msArmLJcEKHVKNBIhuc7mVKCqTMIEOQftMcWUNO/LXeUJQ6/BDOjXutRnq
	 6TJHdbWzrwNBgUXnlEx4aDM1RAczeCI97+KT3PqaQXJi22FthJtpbXNSEf7clnwYke
	 MRE4OiwSWDfPdk3Vvd9U7rDbHCCNUDoiBxQBsAUQKFi6zTjwz1ZD1iOkjCMQ2DLpU2
	 slhidSpL5y1FxsuEUueEYTtkUkATY+pJxpquEs52su2ty7Bcw76C9LQ7+FtZR5ddg2
	 N3wFkiEB0i03g==
From: Simon Horman <horms@kernel.org>
Date: Fri, 11 Oct 2024 10:20:00 +0100
Subject: [PATCH net-next] net: gianfar: Use __be64 * to store pointers to
 big endian values
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-gianfar-be64-v1-1-a77ebe972176@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL/tCGcC/x3MPQqAMAxA4atIZgPGn6JeRRxqTTVLlFakIN7d4
 vgN7z0QOQhHGIsHAt8S5dAMKgtwu9WNUdZsqKu6pYoIN7HqbcCFTYvOdWQGMk3vV8jJGdhL+nc
 TKF+onC6Y3/cDbXW6EWgAAAA=
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Timestamp values are read using pointers to 64-bit big endian values.
But the type of these pointers is u64 *, host byte order.
Use __be64 * instead.

Flagged by Sparse:

.../gianfar.c:2212:60: warning: cast to restricted __be64
.../gianfar.c:2475:53: warning: cast to restricted __be64

Introduced by
commit cc772ab7cdca ("gianfar: Add hardware RX timestamping support").

Compile tested only.
No functional change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/freescale/gianfar.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 092db6995824..435138f4699d 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -2207,8 +2207,9 @@ static void gfar_clean_tx_ring(struct gfar_priv_tx_q *tx_queue)
 
 		if (unlikely(do_tstamp)) {
 			struct skb_shared_hwtstamps shhwtstamps;
-			u64 *ns = (u64 *)(((uintptr_t)skb->data + 0x10) &
-					  ~0x7UL);
+			__be64 *ns;
+
+			ns = (__be64 *)(((uintptr_t)skb->data + 0x10) & ~0x7UL);
 
 			memset(&shhwtstamps, 0, sizeof(shhwtstamps));
 			shhwtstamps.hwtstamp = ns_to_ktime(be64_to_cpu(*ns));
@@ -2471,7 +2472,7 @@ static void gfar_process_frame(struct net_device *ndev, struct sk_buff *skb)
 	/* Get receive timestamp from the skb */
 	if (priv->hwts_rx_en) {
 		struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
-		u64 *ns = (u64 *) skb->data;
+		__be64 *ns = (__be64 *)skb->data;
 
 		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
 		shhwtstamps->hwtstamp = ns_to_ktime(be64_to_cpu(*ns));


