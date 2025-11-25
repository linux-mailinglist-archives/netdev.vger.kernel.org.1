Return-Path: <netdev+bounces-241407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198ECC8390E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477763B063B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501D32F5A2E;
	Tue, 25 Nov 2025 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YuvmlWgc"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF92EBB83
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764053359; cv=none; b=Mg/aDyr/hZnfXZ7noqUrRg4pkcnEw8bw7nl4zaBqVWldutsYNyvFdocKy/0OiZgr+nstC7ELZ3jzkRAzNSVeOs5u7jnamKV4i9Fh0RmD48YEgUyy+FzfIoxluv/usDVvAl6DMTlSaSmKCo3YJXhdyv+m3PzSNJ7mCgs+hxf/30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764053359; c=relaxed/simple;
	bh=bMRrZur/OxY19me+DNNbcmU48OTTfpcj+R0NE4jU+7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FFfcAm057w9juX3a/eN8ZO5nyLY4zycmckc1nvJQsUw1oc0PEAJP4OyJYCzqOSCUgMMoFIV6P2CglPsQBdQpdHAY9wBitIXtB+J6kScd/qf1eq+FjYJR8CnEZOtlMJ7e3HGxsAeoFFiQVnb7tFCy1Z7hZAURQKtRcAOzr5Fm8zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YuvmlWgc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764053349;
	bh=x61iqyNjO85OU/w57wF92pofzSKWznQSUlEKDChu45U=;
	h=From:Date:Subject:To:Cc;
	b=YuvmlWgc+Q5iZyNuX9surVenqrEbfOXSq2epRM9WAH825CiA5B18K6g/cJI8zZu1u
	 aPIR1m1a01AybUUDsbukqOijwzz2uxdQVFLm/Z4FcyYvWV/8ySTbyNlmRFttTr4+xT
	 HuyNJpr2MYo+txSSrF+qJKG5GwwwH629V3jj99nE4SW/LzjnmaAoksWZM1bMx6c7pX
	 LYABeCp52bM99lhJIISANBKLDPowqztyxm5ibnyoAdxis3oJd+69iKoryWz4SElOXs
	 oFsgHwzmZJ3MZoEYLVKx6wAaCu8+aRi0l59jtC62ZZfuuQ1KGLtVnbDocCOiGwghep
	 mEXYes4l7Lc4A==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7E9CE7BE7A; Tue, 25 Nov 2025 14:49:09 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 25 Nov 2025 14:48:54 +0800
Subject: [PATCH net] net: mctp: unconditionally set skb->dev on dst output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-dev-forward-v1-1-54ecffcd0616@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAFVRJWkC/x3MQQqAIBBA0avErBN0wqKuEi1Ep5qNxhgWRHdPW
 r7F/w9kEqYMU/OAUOHMKVaYtgG/u7iR4lANqNEag1YFKmpNcjkJauzQa90H8gNCLQ6hle//NkO
 kE5b3/QDHEu6GYgAAAA==
X-Change-ID: 20251125-dev-forward-932c006dec72
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Vince Chang <vince_chang@aspeedtech.com>
X-Mailer: b4 0.14.2

On transmit, we are currently relying on skb->dev being set by
mctp_local_output() when we first set up the skb destination fields.
However, forwarded skbs do not use the local_output path, so will retain
their incoming netdev as their ->dev on tx. This does not work when
we're forwarding between interfaces.

Set skb->dev unconditionally in the transmit path, to allow for proper
forwarding.

We keep the skb->dev initialisation in mctp_local_output(), as we use it
for fragmentation.

Fixes: 269936db5eb3 ("net: mctp: separate routing database from routing operations")
Suggested-by: Vince Chang <vince_chang@aspeedtech.com>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 4d314e062ba9c4137f196482880660be67a71b11..2ac4011a953fffe9e01f3bfe0f571b3727b3e903 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -623,6 +623,7 @@ static int mctp_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 
 	skb->protocol = htons(ETH_P_MCTP);
 	skb->pkt_type = PACKET_OUTGOING;
+	skb->dev = dst->dev->dev;
 
 	if (skb->len > dst->mtu) {
 		kfree_skb(skb);

---
base-commit: 4c19c4fa8dabb945a017c1910605ab2616725c6c
change-id: 20251125-dev-forward-932c006dec72

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


