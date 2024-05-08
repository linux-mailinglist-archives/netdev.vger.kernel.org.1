Return-Path: <netdev+bounces-94633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D4F8C004E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D620628A97E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BAF86659;
	Wed,  8 May 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="XNGGDpS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2E8625F;
	Wed,  8 May 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179393; cv=none; b=Vx/gJGvgCXSxUllV9geCWfb7It1wcRO9iTal28IoDgzOmkY5KPyU9g3J3CZaXYdQqnvGTbDpuB0oKMcz/vc43WwBCx6uHaJMcwufcJ//YsXD/hyf3pVDLZbPMjEYJslGHnFTNcS/KS/jFrp7A/c0xNwdVk8tChgq8yROYD1qcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179393; c=relaxed/simple;
	bh=hRQM6pa4uOlYJlXbLpb90EuOE7VS+21UzKU3uMNSqcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/9OqIQowo0jghQYu5ji14qhWr7Xe4Ybvci3TKBufsOiArATIlLfUQwhBWUxXHiFbCpJdRP0yNgPnyQWZZbjvYz8VnebT64oIsY0mMzdkVnlgQGOhjSew5xtBNeCgGHHlUZ6u5l62R6L1bNdqKTfpBBHd19c3zD8lcYH3KuZVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=XNGGDpS0; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EBFE6600A2;
	Wed,  8 May 2024 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1715178866;
	bh=hRQM6pa4uOlYJlXbLpb90EuOE7VS+21UzKU3uMNSqcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNGGDpS0ikIorNWcFCAqFXZFSoEZobaoZZSuxKak2Ye1Lj3zeTwprjOGPhG6NumDJ
	 ieUduAKpyFrteW8F7aWi/Clx84pVPFoN75sP1xSEiIUFjmmuTxCmD7PWyXe6bry8aQ
	 kh5eobe2q0x4a/RIY6pCVsjNWGW4nPoYWg49547603FleV+AldkaZ+uRdEChz7xRfw
	 Dm7pMGKYV/tnrfzTPRxnbQifaTifRYZ9EHW1Bf3RJ3NeOlHxPsyzHMbKUM06xO+yjB
	 wzVQ7buMdNKkkbPGG7p4wJ2a9OMaynN0xlcgVHEhMkyXSdQ1g/f6ju7xQFLZzzNhMX
	 thvhYwE9hJuoA==
Received: by x201s (Postfix, from userid 1000)
	id 8F1AC20916D; Wed, 08 May 2024 14:34:07 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 14/14] net: qede: use extack in qede_parse_actions()
Date: Wed,  8 May 2024 14:34:02 +0000
Message-ID: <20240508143404.95901-15-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
References: <20240508143404.95901-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert DP_NOTICE/DP_INFO to NL_SET_ERR_MSG_MOD.

Keep edev around for use with QEDE_RSS_COUNT().

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index e616855d8891..9c72febc6a42 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -1671,7 +1671,7 @@ static int qede_parse_actions(struct qede_dev *edev,
 	int i;
 
 	if (!flow_action_has_entries(flow_action)) {
-		DP_NOTICE(edev, "No actions received\n");
+		NL_SET_ERR_MSG_MOD(extack, "No actions received");
 		return -EINVAL;
 	}
 
@@ -1687,7 +1687,8 @@ static int qede_parse_actions(struct qede_dev *edev,
 				break;
 
 			if (act->queue.index >= QEDE_RSS_COUNT(edev)) {
-				DP_INFO(edev, "Queue out-of-bounds\n");
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Queue out-of-bounds");
 				return -EINVAL;
 			}
 			break;
-- 
2.43.0


