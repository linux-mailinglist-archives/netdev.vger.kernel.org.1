Return-Path: <netdev+bounces-204637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48DAFB84C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E64422B2C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 16:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA4F21B9FE;
	Mon,  7 Jul 2025 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sr0HqWeS"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBF2225A5B;
	Mon,  7 Jul 2025 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904354; cv=none; b=OOUSrdKA00leckfcFUQTtHluqPg9LU6A+MVWzADRr2g2GFP4ByddbEHReFnnYatmA+EfdiP1hjpf6T53dDcYhzLZBAKJTYSsylP/48GuN5N//ytu35wjtlke9egUVPBXwh9RzBFoRJmVTt3yh5x7zAQ1wAx7///vP3k4Vc4rmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904354; c=relaxed/simple;
	bh=7+F/8Z+sos27/lZyHVZY96P6qXDO5dzJeLbCcUBiX9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1/3RAHaOLbVA0uOoRQK2NL1nLxV5HrxCYGyUDghhlYYpH1sqL/xWFRTBbVjrhJsUVEAJbLcfkyFOwb2fbvGzyv8LPFNviUU5GvIuAGLp9IDhIulhFyJi7C9cepFUYyXIJxE7Av+L9PEVIeYuB4IyTuCWFx7ZhAmsQOSrsv5wCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sr0HqWeS; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wx
	Vdpvg7FeWQxkIMif3XMYiXYJJQ4LWlvR78pfeDiE0=; b=Sr0HqWeSroYdLh7VtF
	7Oz9uPLf8S10XbTfNA1l/POCAdraR3f3VaxzCEfFwaNT6p7psn+vQJVeiEvaGSf+
	Hz4hkPihNprS9MmacFVIaimxJpu7PH5qrOH7mLzaxSWOrApqr+fkxnvt70Ar0Mbf
	acL1N+sWopf6L4kA+ahuFuG8g=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3d+Uw8Gto+_41DQ--.4123S4;
	Tue, 08 Jul 2025 00:05:05 +0800 (CST)
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
Subject: [PATCH v2] af_key: Add check for the return value of pfkey_sadb2xfrm_user_sec_ctx()
Date: Tue,  8 Jul 2025 00:05:03 +0800
Message-Id: <20250707160503.2834390-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d+Uw8Gto+_41DQ--.4123S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7GFWrWrWDKFyDZryfGw1fXrb_yoW8JrWDpF
	48G3sFgr4UZr15ta4xta1DuF4Fgr1rXrWqgFWSyw1agrn8Jw18G3yfKFWj9F1rZrZxJFWx
	JFW5urZYka45XrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pis2-rUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBEg+Dbmhr7XlD-AAAsY

Add check for the return value of pfkey_sadb2xfrm_user_sec_ctx()
in pfkey_compile_policy(), and set proper error flag.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- Set error flag '*dir' properly.
- Hi, Steffen! I know that inside pfkey_sadb2xfrm_user_sec_ctx(), null
value check has been done. This patch does the null value check after
pfkey_sadb2xfrm_user_sec_ctx() being called in pfkey_compile_policy().
Also, set proper error flag if pfkey_sadb2xfrm_user_sec_ctx() returns
null. This patch code is similar to [1]. Thanks, Steffen!

[1]https://github.com/torvalds/linux/blob/master/net/key/af_key.c#L2404
---
 net/key/af_key.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index efc2a91f4c48..9cd14a31a427 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3335,6 +3335,11 @@ static struct xfrm_policy *pfkey_compile_policy(struct sock *sk, int opt,
 		if ((*dir = verify_sec_ctx_len(p)))
 			goto out;
 		uctx = pfkey_sadb2xfrm_user_sec_ctx(sec_ctx, GFP_ATOMIC);
+		if (!uctx) {
+			*dir = -ENOMEM;
+			goto out;
+		}
+
 		*dir = security_xfrm_policy_alloc(&xp->security, uctx, GFP_ATOMIC);
 		kfree(uctx);
 
-- 
2.25.1


