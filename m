Return-Path: <netdev+bounces-237104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A664BC451CB
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 07:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D244188E696
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E074E2E8B95;
	Mon, 10 Nov 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="OV0QTbla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC8238C2F;
	Mon, 10 Nov 2025 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756903; cv=none; b=fCbIenirFsMZ69VhuBz8mdjdSS9eXp6yP0yaBLFMJx5uM5cDtXFMCQMNuYm206k1E8OfPXWtx09r6IMGGwmgd8HHkPmFjrfpr/wNmCZwY5kXvngJkak5m3sTqJIxtzNXewQEqHlsTsxYr7V1ibECSHbRtLOqbtgxWY/WQK/4MdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756903; c=relaxed/simple;
	bh=XvInWD4YDIsbjQg0CufQQIeLJBWyvGpg4CPfSDljVCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tuSF8zwrBJGt/g9tWW8vnG9tYvtMoeczcf1NW3E0K2YSvC07N5kKmQMZ+JLgMUx6PAYXImW9ZFdQYqV2RDlfm+bEaq7D+xKe0dJeaR60MxCScmHn5ovWAOFSy53KW01oXRWMDyyuPVSFwEuId6GCYqPAf0Zs6gkfCWE3xZnOjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=OV0QTbla; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28ffac50d;
	Mon, 10 Nov 2025 14:41:29 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH v2] xfrm: fix memory leak in xfrm_add_acquire()
Date: Mon, 10 Nov 2025 06:41:25 +0000
Message-Id: <20251110064125.593311-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a6c7f893603a1kunmd83e9b74a470ac
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSEhJVkNISh5MTh9LGBpNT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=OV0QTblaJYocRxIrfHICh09eF7WQzLcaO2Wa7tHqxKnoYw988xd8tAxzsCrHBrEal6aQ08HkeiIQgy/Re0NLkkJe13k8VHKICyzvoKJAc6LCHbFEeELZ15fN4li9US9Opa8ptFlpzrszSm2zoRKduhUaDa6LQh9QcmbdKmHLxtE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=bnkrxG6S1dEm57sCj5qfB+0gdHrttimcVXVzZ43XaOQ=;
	h=date:mime-version:subject:message-id:from;

The xfrm_add_acquire() function constructs an xfrm policy by calling
xfrm_policy_construct(). This allocates the policy structure and
potentially associates a security context and a device policy with it.

However, at the end of the function, the policy object is freed using
only kfree() . This skips the necessary cleanup for the security context
and device policy, leading to a memory leak.

To fix this, invoke the proper cleanup functions xfrm_dev_policy_delete(),
xfrm_dev_policy_free(), and security_xfrm_policy_free() before freeing the
policy object. This approach mirrors the error handling path in
xfrm_add_policy(), ensuring that all associated resources are correctly
released.

Fixes: 980ebd25794f ("[IPSEC]: Sync series - acquire insert")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
Changes in v2:
- Use the correct cleanup functions as per xfrm_add_policy().
---
 net/xfrm/xfrm_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 010c9e6638c0..441d5fa319f4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3035,6 +3035,9 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	}
 
 	xfrm_state_free(x);
+	xfrm_dev_policy_delete(xp);
+	xfrm_dev_policy_free(xp);
+	security_xfrm_policy_free(xp->security);
 	kfree(xp);
 
 	return 0;
-- 
2.34.1


