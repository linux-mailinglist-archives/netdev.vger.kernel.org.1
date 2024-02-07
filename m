Return-Path: <netdev+bounces-69667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D351A84C1D0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E991F2265F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD0DDA7;
	Wed,  7 Feb 2024 01:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSrlzwp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D623FF515
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268748; cv=none; b=Jud3K+Cy4MGLYs0r2pxqnYlXxXBvgFxFsJjMAQP/xSTX/GATFcCMxaJvSzwx93HsakBlKTUUBVkgC+PDuk3HUtvXaeFx3Y4TUIVAO/vH9KvKG4xe9MuDGzTNSUGi8oVBaqs4kx591GyAcFHcfsNr46bkk9zKEOcyYW9lEe6N+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268748; c=relaxed/simple;
	bh=Hn7M+gCNHAwT2ZLvh6V2W8JdKJvn1FMCXXww+lcCBPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2Tay1D3O7ryGh8hDQVh71KzMWipsz4rzkIg8OwXClARoowc7etRQgVFEDLL0j6P5YpxJQ4av+ClJYJw2JVN1prm5a0ha/WRGjxfSiBPnFn9mNtuA74fRRwhtN0Dmd28rmHZHKvtdVRh0ehWHJxdqGhglmvpkrSty1Y2DZFrX8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSrlzwp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7B6C433A6;
	Wed,  7 Feb 2024 01:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268748;
	bh=Hn7M+gCNHAwT2ZLvh6V2W8JdKJvn1FMCXXww+lcCBPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSrlzwp81LlIuW2kyh1tAdES3mSL4DPXkO81SigYYlBi6dnlJerdJ9LplI612y5nC
	 rMQy2q4S1WS9vj8XPPUDoHzrwCLMBfqh5lg9hHvAHuqHkwU5TOTRrFOaVNdqdzQqO7
	 ogfTdGObKk3aYGu9mSVjTgtjJoZApWlbVGpa2VqcB/D8x+t2Is382D0jzxSkjACjuR
	 CKqv4Uz6/dlGCN8OO9Dpbk6ahYKSfpF5cbAtDiXT5suBTs2PYB0seM/Hz3RaVdSJXN
	 epc4M8ifOyuPRbSq1PAbsBhFK9uh1QRtwwYaP95TigBu92coBJvtEBV5vXaO07tjT3
	 XMKKVw88yI9MQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	horms@kernel.org
Subject: [PATCH net 7/7] net: tls: fix returned read length with async decrypt
Date: Tue,  6 Feb 2024 17:18:24 -0800
Message-ID: <20240207011824.2609030-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011824.2609030-1-kuba@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We double count async, non-zc rx data. The previous fix was
lucky because if we fully zc async_copy_bytes is 0 so we add 0.
Decrypted already has all the bytes we handled, in all cases.
We don't have to adjust anything, delete the erroneous line.

Fixes: 4d42cd6bc2ac ("tls: rx: fix return value for async crypto")
Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
CC: horms@kernel.org
---
 net/tls/tls_sw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a6eff21ade23..9fbc70200cd0 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2132,7 +2132,6 @@ int tls_sw_recvmsg(struct sock *sk,
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
 					      async_copy_bytes, is_peek);
-		decrypted += max(err, 0);
 	}
 
 	copied += decrypted;
-- 
2.43.0


