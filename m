Return-Path: <netdev+bounces-234839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A85CC27E1D
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 13:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BA83BFE47
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 12:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525C125C818;
	Sat,  1 Nov 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ued7h9x5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF7B258CDF
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000508; cv=none; b=UdYamrv7b4HTnt7vgK7w/1MCEvoNwag11qx89vKg7ZVQ/HMU91tZ1UG4yV8Mld6hg5Jy1GNQ0l7a7/MOUlhNlIoaMDj6oRQF26pmeNqEzSD60EZjGyrBcbnJZIAA6NCxd1GeHFS4zSQf4Rpu+II7ifdBZbWJJf2uXmWVHGyfb/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000508; c=relaxed/simple;
	bh=5lljvy+eeKPbsrR97UeOzg7UMYKoHcYzDLWKuAQGdYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yg/hT52gGh+g2n1mo7qxh9HEPuj75TiqsIIdaV501woPJBJp0F0Jmb66Gk6m0LaZcSByCsxoQOdimaGl38Iu11c7IgvcGL6VhTYuzfyKVjMKZ6eFxqCjXsOlabyQ6Bt/1n+hFVZxX376ibnvvKjlJbeR+Zwtw9IIlq2WgUK2RzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ued7h9x5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b8b33cdf470so263913a12.0
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762000504; x=1762605304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iow4Uh3JbPUWEJRhV4H6RzrlPY1bk6TBjtSGGBlaN4=;
        b=Ued7h9x5vp0OfEsZWuXKwb9qcb5oLIHTWDDn4AxY+qZkmycD2q3m44JV4+7frRu/UA
         wYyq0oLtY1dNqRwF2SOVVvcruV0ARLln9kOuRJuxiMVSqViyXG5kt5DEDTWR9Psji40A
         g6SlYcW/pWt46sl8AHfdbG2IYlzJcuXhm/rb5mwjV/9uIajQD/xSRbanNOnQwsHc+X+q
         /d1FSnKge3SyE6LJnqbPdWY2o5vc1RAFvWex38Vy08ujVzdqtKrQo2HzrYvbmqClZlQ9
         Z21Yf/Sn+CGkHMZ2iucHUZ2VdqGQ33dZTk0/seAtBGPYHvSPaIOKvn6iI4D1+C5BLnKz
         FIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762000504; x=1762605304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iow4Uh3JbPUWEJRhV4H6RzrlPY1bk6TBjtSGGBlaN4=;
        b=X8qhX4Cnak+TlQcT4fwn7vO5NHSCftuPc39L8ut30ssd8Q7hYaCld4Htklo7hoUXDA
         kEIaCidNB4g7t9juh/nbS+fTnA+g1FT44m5R9q74Ni8Aa0SonxP7bO0BpXjeZwBGJdmm
         /r6JSCxFrGEABjHnGlNZFIPO3fszz+rNOfgTiX/CUhcCU6M1cQ2VRo9jtZIhFjGMU5Dn
         aJNngCqPDOIjOOLyJn8/i/sCg+/I+Q5kvYPyK2upkMqtXU2ibT0zHcM4lj4iL9zK9DwY
         LUw3UZDvJlw1l6PDdgNVHV1FqLer/bkfbRVsyamDK7hfNjw0N6liakATwhxZmLMd8y6m
         q6uw==
X-Gm-Message-State: AOJu0YxLqnvuTcC2TuqYTWxrmcacWsupolpsroELJkzuzAw7yd5OejmJ
	Evf01j1a/5/kSRrxIxrQtlCJ44X9jrVvw7D+1IBtHjG41UZJWUJfWGon
X-Gm-Gg: ASbGncsxRgKPmaM7RvsuHgCeXiyLbZlyoiWGF4PWFTTEfW+ZC/iHjgoF0EE3aR9SKNx
	mVLFAcJVuSVeBpA9CiSNO0WncTjIhp9ynLdHnAAvMle3YtThW6sIuSjg38nHOvlnkw/ElRIvEci
	sXfrmzbXaTX9Eqkp76UoRW5nGrMQy7BAGOj9vEFb8PXE6paLjzdNTPqJ7tJg0h+GA8qV23EWnoU
	fA+oj4K3jESJyVVVHbPuKVf14TblV/QPyBWmDbN57tCsJ9pwgufyDZn23vW/ErR9jHfnR8E5G4P
	XUdX5kzlaM4GfFNu9pJJjl5qc2Cez317Q1N5LlgHFUsVEvi+XCL+n+K3jhZV+bTyzRTlIgc0oXV
	gYCOt9n3hACOZ8CsKyRoYfODyIvrMq4c53J/wzJuzMRA70h8TbuPTm8lkJlM7h1uXAyJXOguqHO
	lpgir6jnYrREuKce6STDXoTDV6M7VHSZyJgz1CiQ9u
X-Google-Smtp-Source: AGHT+IGaymgUrpOcvB4JBLFSPVUyGWWS9X0AS3vOHetSYGMoN5nDwO4YcwN9LuZvJ9JYCEcykcWlKg==
X-Received: by 2002:aa7:88cd:0:b0:7a5:396d:76d3 with SMTP id d2e1a72fcca58-7a7797c005bmr3975673b3a.4.1762000503825;
        Sat, 01 Nov 2025 05:35:03 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:9fcf:a95f:918:2618:d2cf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm5214017b3a.60.2025.11.01.05.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:35:03 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sat, 01 Nov 2025 18:04:48 +0530
Subject: [PATCH v2 2/2] net: sched: act_connmark: zero initialize the
 struct to avoid KMSAN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-infoleak-v2-2-01a501d41c09@gmail.com>
References: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
In-Reply-To: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762000490; l=1124;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=5lljvy+eeKPbsrR97UeOzg7UMYKoHcYzDLWKuAQGdYE=;
 b=bNfAU7fFhFu8TXmm6LrwvsK/5elG10436Ao1RifFc2YEB/o84xMwIUoUqeEcARWUBz37FRUsC
 SgI8FmaDr2wBYAcMsXO0YTdp3BUjZOLvpN3TozwQf8vw5mi/iZdNnGH
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

zero initialize the struct to avoid the infoleak to the userspace.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_connmark.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 3e89927d7116..cf3cdfaaa34b 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -195,13 +195,15 @@ static inline int tcf_connmark_dump(struct sk_buff *skb, struct tc_action *a,
 	const struct tcf_connmark_info *ci = to_connmark(a);
 	unsigned char *b = skb_tail_pointer(skb);
 	const struct tcf_connmark_parms *parms;
-	struct tc_connmark opt = {
-		.index   = ci->tcf_index,
-		.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
-	};
+	struct tc_connmark opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+
+	opt.index   = ci->tcf_index,
+	opt.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
+
 	rcu_read_lock();
 	parms = rcu_dereference(ci->parms);
 

-- 
2.43.0


