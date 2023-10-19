Return-Path: <netdev+bounces-42597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450407CF7D7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A12B2131B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690321DFDC;
	Thu, 19 Oct 2023 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ICciGBf5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7D1DFF4
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:00:56 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0290132
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6be0277c05bso3579801b3a.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697716854; x=1698321654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkvXWDkzUdqkRQ+D3sDYU4OvGGZLi1kyLlJlX/MPCKc=;
        b=ICciGBf5r9JZGnS2VRdr67YntpMrbbQZFCvDQFj++1wwui82x6N7cop+vhyKLrX3SS
         G8r+oGcoZGB6kkwMA76NnVTh3V47wgkROcLDOyojU9SbeTUNecRT8RdBxFzJW9o0DiSQ
         YcQcUnzfDPCIR2hTVSy7wb9sIT8th7aTOS62Cvm6IqbIdR49He9cOZpPA5xVbRbmgxId
         gE/d/k6KY1pGXdLbvregAbe6O4WqyebGQFjx/neRlhERcTujD1ipKMqd2UFyXX8dFYmW
         rFlrDQTtZ8GqLp70BdbBjiyxNPQ3Na1YGYacPFnb6qVFXen7AsRBzYbJGWR9CGf7qx4/
         o8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716854; x=1698321654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkvXWDkzUdqkRQ+D3sDYU4OvGGZLi1kyLlJlX/MPCKc=;
        b=hdeD8c4BATag4rnluwiqK7Y9gqvxRE/ZknP0YQGO4ftxZUuLTHhZ1gor2qqBzAcsFF
         3w0kMkJr4CbMTzLKJ967+q5Pv14a2+y0SLquQbwhb0zZafKtzPXbhxyV6QDwHdu0FgwL
         vAq9h3o/aqiMaGrSRJNu9OfpnXhaIT/DKuMytVO0gXfOV5yNCYFALi1UEtI57/RvioaP
         Rk26bGYl63trP9NTKTUDIo+BIJLkBAr95WMh6pC1W4nomQJyDvB7VCItowIe9Vckv3ru
         fSqsAR1NeBAnnNfbDW2FsZArmxz07DQoo7RIr9TiD8npEW8tCgnvVBvbnXIcVsP4PyGp
         lIxQ==
X-Gm-Message-State: AOJu0YzYAk4GrQvwbiGUYSnNoKGKT09QV3rcV7ymViCTT3E8nybuQ6Cj
	fynIspwyCjr/TeK9iqWLjYAWkA==
X-Google-Smtp-Source: AGHT+IHvyW0QSlMwAWAA0xidP7Zv3fC3Zs9hQWuI1QW0RwfCBEES+98tXPWRsWP1awV9zWwmh3MYTw==
X-Received: by 2002:a05:6a21:1509:b0:13d:1d14:6693 with SMTP id nq9-20020a056a21150900b0013d1d146693mr1867657pzb.45.1697716854436;
        Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001c727d3ea6bsm1785646plb.74.2023.10.19.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when raising allocated
Date: Thu, 19 Oct 2023 20:00:26 +0800
Message-Id: <20231019120026.42215-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231019120026.42215-1-wuyun.abel@bytedance.com>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before sockets became aware of net-memcg's memory pressure since
commit e1aab161e013 ("socket: initial cgroup code."), the memory
usage would be granted to raise if below average even when under
protocol's pressure. This provides fairness among the sockets of
same protocol.

That commit changes this because the heuristic will also be
effective when only memcg is under pressure which makes no sense.
So revert that behavior.

After reverting, __sk_mem_raise_allocated() no longer considers
memcg's pressure. As memcgs are isolated from each other w.r.t.
memory accounting, consuming one's budget won't affect others.
So except the places where buffer sizes are needed to be tuned,
allow workloads to use the memory they are provisioned.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/sock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 45841a5689b6..0ec3f5d70715 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3037,7 +3037,13 @@ EXPORT_SYMBOL(sk_wait_data);
  *	@amt: pages to allocate
  *	@kind: allocation type
  *
- *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc
+ *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc.
+ *
+ *	Unlike the globally shared limits among the sockets under same protocol,
+ *	consuming the budget of a memcg won't have direct effect on other ones.
+ *	So be optimistic about memcg's tolerance, and leave the callers to decide
+ *	whether or not to raise allocated through sk_under_memory_pressure() or
+ *	its variants.
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
@@ -3095,7 +3101,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		/* The following 'average' heuristic is within the
+		 * scope of global accounting, so it only makes
+		 * sense for global memory pressure.
+		 */
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
 
 		/* Try to be fair among all the sockets under global
-- 
2.37.3


