Return-Path: <netdev+bounces-203730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DDAF6E66
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7411886F7E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5352D46B5;
	Thu,  3 Jul 2025 09:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BozjETpJ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C47220F36;
	Thu,  3 Jul 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534348; cv=none; b=NoCgTI0qTu4S5zHOA3CR0S+oUOfzq5xAo506XR/UdbRHa39hxlfE+IE5k+FZPuxUYy7MiSLGymvKrxl9yrWhkkQOimra3+96A0ivhWGvUARKAlLPzxWuX3Lcg7+J3PcKSpmznlr7XHp2qBwECJ5WroAoj1Dj/fFYDHmDgK/f2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534348; c=relaxed/simple;
	bh=mudUgVynJuJafwVX5xamx0csOLRV0MYSKdUkzB/pXp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ELaDwbNd1jE60UCpFRRMA2yzPpK/zhKn8VdyxLRSIvf9W7F+qQ1iRb6rFT2eJhuMnMBz1x7dTm7S0S90qwYvRAFTvHpNN7+S6kXRrm7CTVRSO1EU6N9aFShqn3MAt46won3XLE2g7gjPWrqyjRLHX+QtwUdQktiy0C+23LIHlVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BozjETpJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vp
	QhnFt17a1wgpLJCNic/2Fw7OSARgJos+DEJHnUG9Q=; b=BozjETpJpjQP86pLcv
	oGfCF4To8YRHgz2RKhBJ3Y6+jTJmXa7gIERvlHczzKp06vHzTAbx2ZseAUAHbcDT
	WQNOGacvYRzcCMpEYetsGGj3UOyfkKx0xsbW8FmfxNvc1vHxiT4G3VGX8+aMARPb
	ScRe6FNjPPkqBQmo3NgAYy410=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3H7SJSmZoX54YCQ--.21258S4;
	Thu, 03 Jul 2025 17:16:58 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] af_key: Add check for the return value of pfkey_sadb2xfrm_user_sec_ctx()
Date: Thu,  3 Jul 2025 17:16:46 +0800
Message-Id: <20250703091646.2533337-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H7SJSmZoX54YCQ--.21258S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4UuF1DXFyDAFWUuFW3Wrg_yoWxtFX_CF
	y0v3Z5Jr45tr9akr4qy3WfZr98X3yrGwsYga9Iqr95J3yDtr48KrWkuFn3GrW3WryUZF4U
	XF93Xa90vrn8JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtVyI7UUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkBt-bmhmRMHOMwAAss

Add check for the return value of pfkey_sadb2xfrm_user_sec_ctx()
to prevent potential errors.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 net/key/af_key.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index efc2a91f4c48..e7318cea1f3a 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3335,6 +3335,9 @@ static struct xfrm_policy *pfkey_compile_policy(struct sock *sk, int opt,
 		if ((*dir = verify_sec_ctx_len(p)))
 			goto out;
 		uctx = pfkey_sadb2xfrm_user_sec_ctx(sec_ctx, GFP_ATOMIC);
+		if (!uctx)
+			goto out;
+
 		*dir = security_xfrm_policy_alloc(&xp->security, uctx, GFP_ATOMIC);
 		kfree(uctx);
 
-- 
2.25.1


