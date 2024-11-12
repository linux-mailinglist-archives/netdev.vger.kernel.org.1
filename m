Return-Path: <netdev+bounces-144072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B39C575B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A070A2817BF
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470AD1CD1F4;
	Tue, 12 Nov 2024 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3QIRZ4s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145C1B5829
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413442; cv=none; b=ncwU32Kbi5a9onEIowrznL6cFlS5LA3JI8TCgwfzH+E+hHCwlIYKQLA05r+002nFQiaIV4Jx9lvy70NimJ0fR9TOHW+UYsBqv/t9hTbFBNGUpqCyMjXDJbGMBP8+p1eG1hrNPz+vh1rPrX8Rvh/gT3A4aO4y845hjPPo1VcV4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413442; c=relaxed/simple;
	bh=XAFeeHvR7krZggvmBjTC1i8xIBK11kPMsA8audiCo+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgYtemL1TBPpShLQ5t60KIynX6uCVHbpAFrOqCk61Qb6OQDpoVNRlTFA5OVfrqwFnQ6Iv+z92FnQxghPRmm1USHBWfq7/rZkBCIUfm7CtTqtPdYFMIwYj3w+WP1gA0WrvxP5vCfxi+1TH9B53Ut0WPtAZSbO/aQDsjVQkfBHdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3QIRZ4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0365C4CECD;
	Tue, 12 Nov 2024 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731413441;
	bh=XAFeeHvR7krZggvmBjTC1i8xIBK11kPMsA8audiCo+s=;
	h=From:To:Cc:Subject:Date:From;
	b=u3QIRZ4shkvP2F9M7n/ArBY/kjl+z5DeZHYYJxGOBsft3shbyTp+J6gCgOOXRo+hd
	 grQH0RcVbkzJfxtzsniR0KiyceeGC48Pj2rRRoeXBy7Q1/xg/Pa3xffPYt+GIJCiFh
	 Z6MMFHsgBojkQDHZorlSGRBRm4xuDKY9cyocGzDk/k1ifdIe7ev5PFQd/IKQngrru7
	 UcaHaPj/npw9HAwM5vefPvglZilo/KkywTHct3Z2zlSQFNSNqCMd+mFk9XrYnL7VZN
	 X784IJVLXmRTyZFoeAfdtN04ptdR6fxtB1trGQBHXdmFPsTIOcjzJ6EWeqpnq5VxOR
	 ohNcKbIISxJ9Q==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Christian Langrock <christian.langrock@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH ipsec-rc] xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO
Date: Tue, 12 Nov 2024 14:10:31 +0200
Message-ID: <d364e4f9c5f04ed83b777b96e6e1b48f11cb34cf.1731413249.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

When skb needs GSO and wrap around happens, if xo->seq.low (seqno of
the first skb segment) is before the last seq number but oseq (seqno
of the last segment) is after it, xo->seq.low is still bigger than
replay_esn->oseq while oseq is smaller than it, so the update of
replay_esn->oseq_hi is missed for this case wrap around because of
the change in the cited commit.

For example, if sending a packet with gso_segs=3 while old
replay_esn->oseq=0xfffffffe, we calculate:
    xo->seq.low = 0xfffffffe + 1 = 0x0xffffffff
    oseq = 0xfffffffe + 3 = 0x1
(oseq < replay_esn->oseq) is true, but (xo->seq.low <
replay_esn->oseq) is false, so replay_esn->oseq_hi is not incremented.

To fix this issue, change the outer checking back for the update of
replay_esn->oseq_hi. And add new checking inside for the update of
packet's oseq_hi.

Fixes: 4b549ccce941 ("xfrm: replay: Fix ESN wrap around for GSO")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_replay.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index bc56c6305725..235bbefc2aba 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -714,10 +714,12 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
 			oseq += skb_shinfo(skb)->gso_segs;
 		}
 
-		if (unlikely(xo->seq.low < replay_esn->oseq)) {
-			XFRM_SKB_CB(skb)->seq.output.hi = ++oseq_hi;
-			xo->seq.hi = oseq_hi;
-			replay_esn->oseq_hi = oseq_hi;
+		if (unlikely(oseq < replay_esn->oseq)) {
+			replay_esn->oseq_hi = ++oseq_hi;
+			if (xo->seq.low < replay_esn->oseq) {
+				XFRM_SKB_CB(skb)->seq.output.hi = oseq_hi;
+				xo->seq.hi = oseq_hi;
+			}
 			if (replay_esn->oseq_hi == 0) {
 				replay_esn->oseq--;
 				replay_esn->oseq_hi--;
-- 
2.47.0


