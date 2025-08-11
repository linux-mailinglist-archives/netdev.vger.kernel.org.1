Return-Path: <netdev+bounces-212540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F34B21262
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F03ABEC8
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D3296BBB;
	Mon, 11 Aug 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="de/EJevO"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7911DFDAB
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930468; cv=none; b=sxunkkkQ3T1tLA7A4U4UZNdabhjypx89kkXjbTJF0VBYn1gRRFPys0Vq3+S6dYqn5g1Ak8UBsU2/I/kcTg93oUxpMOsHLYi4uFSqzIKiBYI8HcE5H26YZZm7H/IQUlRZcXUb06bI82FefBYrTSnUoQivIeIaE72sBwJMzbJhvHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930468; c=relaxed/simple;
	bh=lrErPlSj13yeFJFUN8Q+kC49+CUkgmgYn8aKCHsxA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWeYoXzKkHdkfh5mc7jUC7ut82PMKelJFonk+DW3C4m9GSsQJhK0hhipUhVvghazcwlN6qPQjHs2Vc/LkjU8je9rSVFdeP3hNoMxKGyr+1SqwMauAC64ZT4imq8heJWGLlkUerJ6h8WPLlVyl/IcffeVenwjhZSy+NKheVWNHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=de/EJevO; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754930454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KNDajDqdLKrAEXDEBtkk4JWlF60OExIU365++ZNVha8=;
	b=de/EJevOJMu6noS+TC2khMQmxZEZYD++D2WCoMRVnIueEVBjT0eZ6IshQFPcxYsTu1XC2h
	myv7TLHmSR0Q6XtSIwxxAvLiMaHgW0VFUj3HVH20Wc7QOmVYvmWXLXHO0cROKYrFoHkXHf
	uG7WNFN/xX7JluXTCIUpBo+d901c0ZM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/sched: Remove redundant memset(0) call in reset_policy()
Date: Mon, 11 Aug 2025 18:40:38 +0200
Message-ID: <20250811164039.43250-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The call to nla_strscpy() already zero-pads the tail of the destination
buffer which makes the additional memset(0) call redundant. Remove it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/sched/act_simple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index f3abe0545989..8e69a919b4fe 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -72,7 +72,6 @@ static int reset_policy(struct tc_action *a, const struct nlattr *defdata,
 	d = to_defact(a);
 	spin_lock_bh(&d->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(a, p->action, goto_ch);
-	memset(d->tcfd_defdata, 0, SIMP_MAX_DATA);
 	nla_strscpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
 	spin_unlock_bh(&d->tcf_lock);
 	if (goto_ch)
-- 
2.50.1


