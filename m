Return-Path: <netdev+bounces-123772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2F9966788
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 19:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DDFC1C24D27
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 17:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E31B1D7F;
	Fri, 30 Aug 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9YfIu5X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9678B13BAF1
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037315; cv=none; b=ltol1c6/09tntQr6jafmU/2ytkyA4TiA8U+O8roP+ITPNGlbEv54hMcBuGJy35SbnGe6XEdABDRkSKhRGkyFCTCsS9RuOvItrYmrN6O6SPrQ365oZQcNXMJv5NtWVWqmOchgI1RMfC7eVUjNnJvjuPAF8feWfVOp8OdrACh7C9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037315; c=relaxed/simple;
	bh=VIIuPNAgluQgfu+I+PZLBLXI0/+gjKDLjXie6aIIpbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rMdb4+i/hWzyDu4fWpb21asenNis0LptvwuZwLHVyJ6/kGHB6iixKXoPRVm3yN7DvYm5Ld2lKSIBiksCxC42WlTtIwMFS2qSr3AM+RNzN0jNOeWHD79b9nOBMvH0e40+AWF82h+RU7GNquRLd5ssJqkT1cPTgF/OSLDASK17Cps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9YfIu5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D194C4CEC2;
	Fri, 30 Aug 2024 17:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725037315;
	bh=VIIuPNAgluQgfu+I+PZLBLXI0/+gjKDLjXie6aIIpbs=;
	h=From:Date:Subject:To:Cc:From;
	b=G9YfIu5XqakV/vqXzPZXZUQf5MPgqlB5vWOpVFkCa4bvhNN6oEyIp8Gx88zruIzm1
	 yiq8JfDDYLD4qO+MtMinYSx9mMCzAHS/ccqss7pvuih5okrD1bJpOfEECaYoiDLnmg
	 kBbnzUSeT+dtOx8qjG2uo9nTo2aw+aQl8tPHfga7OGAbfrtWqqzzPTZVZn1vvGlBHb
	 in1Q8bvY3/XdERkm5bHELqV28KURpUxucNBtdvb6tZik1W8tCH1PV0N3nzL258LsXw
	 kklS82ItlG0vqWlQwqB99pyaVw2pOxyFe6/5Xgu5CmfXZwFzjhOlYl9df+KWKjFe6B
	 3/VI9sWyokLRQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 30 Aug 2024 18:01:50 +0100
Subject: [PATCH ipsec-next] xfrm: Initialise dir in xfrm_hash_rebuild()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-xfrm_hash_rebuild-dir-v1-1-f75092d07e1b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP360WYC/x3MQQrCQAxA0auUrA3EWqT1KiKlM0k7AR1LojJQe
 vcOLt/i/w1cTMXh1mxg8lPXd644nxqIacqLoHI1tNR21F8Iy2yvMU2eRpPw1Scjq+EQuI8kxNc
 QoLaryazl/72Dri4Rs5QPPPb9ADHuS6RzAAAA
To: Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>
X-Mailer: b4 0.14.0

The cited commit removed the initialisation of dir in one place too
many: it is still used within the loop this patch updates.

Compile tested only.

Fixes: 08c2182cf0b4 ("xfrm: policy: use recently added helper in more places")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/netdev/CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/xfrm/xfrm_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6336baa8a93c..02eb4bd0fde6 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1283,6 +1283,7 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 		if (xfrm_policy_is_dead_or_sk(policy))
 			continue;
 
+		dir = xfrm_policy_id2dir(policy->index);
 		if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
 			if (policy->family == AF_INET) {
 				dbits = rbits4;


