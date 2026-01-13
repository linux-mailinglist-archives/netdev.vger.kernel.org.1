Return-Path: <netdev+bounces-249555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DA418D1AF0D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EEF0300CB43
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260813587DA;
	Tue, 13 Jan 2026 19:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSONDU/1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8C357A41
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331215; cv=none; b=lao9iXchpzPYmdwxyDopADymJgZqqBUL1nkwNOi3HZyPA03tvE5aZzFRidCjcHTpCMQxx5IBnFGl1doYhnLhMCTDic/FPuB26IsZ/UuuR7eAB6VXhRzM818g2QiQ1dylbR9Hk3FZjLZma1tN5kfP0aa1Lj3nkt2CgLXswDvWYU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331215; c=relaxed/simple;
	bh=z6KET0Tt1IvM2lHqBpnJ6Kua0cKAuKyCbQFe97YTvwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MT5tFIhxkT6M9zb8t2g5oVfGYC8mKjz+DpIDkQ0WF4wv0LAGNpIIuKm0EVtiW4aqYxNe1NpK1E/9j1aFVPwqm41udskiJedoRRBBqYkE71XecuWrHQ3A9kjcVbSSX/wirVsseCqL+ORts4R0AUaVEYaR9Z/G4wfz/ULJAPYR26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSONDU/1; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so2188659b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331213; x=1768936013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2Qopw9YS5C/3VXD0wAz4XKrydHU6MWdKMTPT2NjpsE=;
        b=JSONDU/17XMQxyAJuTZUoxccqRrLr2+wYaTGsE5e2r6ILwQhnaepZ3+jGY6970NzWN
         bWUCG/Ht2MOJ10rKHXEWSruK6mVKHlSqaUFC4nuv/3w3pvaSFzZtSBR8Zneo/6Ic1VfN
         slsjp8QHaaS2NTyifKVLj6qDG1Fs6Tm40oLWmRgicAbsAy2ntbtu9MSfrBZAKkLZHp+8
         6DhnJC6Yx/PM/A75QgXwlmD0v00Yppl3spZ+obXsK6gLCQZOJCuqEICZUUjnwVZj4hVf
         fd3PyBt1kTDwnht6ZzxEqD6E4U1etCiGLGlRZieIB/zrrZsR5NNiHT25duQCm0cwdDqa
         V7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331213; x=1768936013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2Qopw9YS5C/3VXD0wAz4XKrydHU6MWdKMTPT2NjpsE=;
        b=MnR2p56xF9zj7z2ZIZqR2CnC5K5xcUEAk/PpAxcFuYq2uj4bvcZjiTGvPcClnNRvs5
         XPybcxhPM1IupUMCpS7E62/Q8ZSLp/SCmtEllfTu45AitkArDpQ80BnxxtE8SyjyZE1W
         zC35UTkYMOk6kiJhHyxyDwdSPs5NjhdLUcNFqhuDbRwQkJi1Ht3Rn2WUNpWdBIQzCvua
         q/w+HD00T1FmER2Oar3RHW8HV0kD9esgxKocENsh4JaN3yCtrLrVrpSRVs1oZbovYLDZ
         j2A11BqpVACMsxNxowriX4u7j2w0IID9dzGVIK24eN2QcNJhiLh1K55BDHeLMQ7HDTrt
         suPg==
X-Gm-Message-State: AOJu0YzC/1VevE15HZmf61a2PAtHgHA2NGsYdFo9CdpNQlrdTLWdYYSi
	haFi/BbDwqSrNca9KEfIVWu4MEf/tMNC4uh9vmGbqQzeKovXBPKj1zkz6qAo7A==
X-Gm-Gg: AY/fxX5qchoxcDxXMqcVhNJdqC2jNjXw1fTI8HbuRgB9aRbnHVToAFU3K4rRrn0Kw7k
	dwCRaTuoktWxasrZvOzVCHt2fWYMtYEpXvXEiYAAoELLnIHGF2rlaeNHKuu7VxNw39+I1oR0HPX
	7bweLfCzpKJT3CGl/Y7VJGrAp59qK09sPTXsJus7+Rvfbx7zS/Rug99if1Y/TQ9VnfU5lx4dzIY
	VSF9V5Oj2MtCA/UamRu1xoes1NvwmUog3ZCqpari99HWFzOEgwX7zs9nlP+nvBQVfX5d5aLm8cd
	MiSEJaENCqmwOgzPlwl/BPXSXG82v9QO2jg/PtrUqXZB+jtmhfOIj+UvKxN9Mag5/ZcnJ2gmnIm
	usEIUQkLpJIaAoj7fwsDPQj89VTFasq3hosUE9EeVVaYPW1REUSonQGZNrysIBD+RLm401dSesP
	Hjs2kuILudyLZqGh2b
X-Google-Smtp-Source: AGHT+IG1/KDzJOsl7+F829bKlgyWI/ymH3MOHdV3sVsJ5qRGZHfcGUiOxkFq57jyDE7gJ6ULq4HJLA==
X-Received: by 2002:a05:6a00:f91:b0:81f:4884:4fed with SMTP id d2e1a72fcca58-81f488454e3mr10059789b3a.7.1768331212816;
        Tue, 13 Jan 2026 11:06:52 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:06:51 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [Patch net v7 1/9] net_sched: Check the return value of qfq_choose_next_agg()
Date: Tue, 13 Jan 2026 11:06:26 -0800
Message-Id: <20260113190634.681734-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qfq_choose_next_agg() could return NULL so its return value should be
properly checked unless NULL is acceptable.

There are two cases we need to deal with:

1) q->in_serv_agg, which is okay with NULL since it is either checked or
   just compared with other pointer without dereferencing. In fact, it
   is even intentionally set to NULL in one of the cases.

2) in_serv_agg, which is a temporary local variable, which is not okay
   with NULL, since it is dereferenced immediately, hence must be checked.

This fix corrects one of the 2nd cases, and leaving the 1st case as they are.

Although this bug is triggered with the netem duplicate change, the root
cause is still within qfq qdisc.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reviewed-by: Xiang Mei <xmei5@asu.edu>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_qfq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index f4013b547438..2fca51ba9446 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1145,6 +1145,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 * choose the new aggregate to serve.
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
+		if (!in_serv_agg)
+			return NULL;
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
 	}
 	if (!skb)
-- 
2.34.1


