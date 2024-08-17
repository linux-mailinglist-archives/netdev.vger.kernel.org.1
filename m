Return-Path: <netdev+bounces-119427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9AF9558FB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB9328272D
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7A1553A6;
	Sat, 17 Aug 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOMb5NMe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD21286A8
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912523; cv=none; b=gV4Kp2vSYOkmd/CeFmWBjK+w2al7VDtjJciujJbJM/aheIFJKVQf2JjowInUD7J/bOGUEeIIo3plRP5lqxN7jqt53M906642R7a5H+RYJxw8oFcgvITwVwgq/SZxtSO38WnzZxYnbvOu8x2DiWh6cYG5B+4ByonH4ShzRMQIJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912523; c=relaxed/simple;
	bh=vLIl8GE+gzXEacY/YHU67fNJq7szOq7C7NEdSXnOVt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8NlbfIrch0L2YRPjMMDE8WQC9cA3qXSPobMWWOXSh5SZbJCa6nCnm25Jg7fUh4fSeOmZUN23EZI/wfU4m9OLyEQZM0186ZErQ17l1ToqYpbam9Fzfr5k9utYhW2DPUn9PYVqBHE+bqg2yGq7Hdo1IRJsYvY9Bo03xaVgOIfD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOMb5NMe; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b78c980981so15862536d6.2
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723912521; x=1724517321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY99jyEwDoh9G30LO2IWPeonxw6+Zj+rZoZ5Mtx/s8E=;
        b=XOMb5NMeNGjFmLn5IR41/Ia2NYuWQY3s0F38mHlsAjKTeVFhCJHCYmLgwvnSFQKkjV
         JLyWiSMXVRTw9FI4vgI96oTb68WJOEfwFJN8SBgguDHoiAb0Hb2v0voHnTABOh/SJJDw
         FeMW/Btf1aNggYxljMeOU6JcUIBorviUWa7NyGJE0Am5JSQBk2lxo8uLl4JzOnf+fcb+
         klxqfrYNoBLeiKP0C2JaWkp2qk4Po+4Wqi3hxmWI84EJEnjA/oP2jf85azr/FwJRoW1i
         AfjFxetjXAUWpRsEwSbj6CcesukMWNIgsyrhsBqO+HBqe5DSDCbNWV2YbHg5NtUYbgZJ
         ioOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912521; x=1724517321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RY99jyEwDoh9G30LO2IWPeonxw6+Zj+rZoZ5Mtx/s8E=;
        b=gzR3Sg+8PCFkFx3NYv47fCQKulNMjTgb9/KpboqgRe8uodO4TnuOACoxXNBs5UF73C
         DwCe3UZ3NuJAbsfiBMEWrcNwih+EdSZjDBEVnzaniBj0jzzR+ZuM5RZo91k7NspjARPF
         rJWI/as5AzQgeYAOj/CIqlGAvetlS9jltlJOOLwxld1ozjSt9Qev+Rg47bifIoYuiMyW
         6Qhryh8idqX/SNDLvc4DJxgoaFze0jf56M9CJap/3ZbuVCoOikeyBNTbuyqC6awqIbG9
         t14Wqj4A83m1T0WyH1irmWsTIWUvr39FSXMlJIk1h5OzWgvdxsIcJ9hy/AzfrhxwLIgr
         sQzw==
X-Forwarded-Encrypted: i=1; AJvYcCXUk2pCtgRxgEcG+kxxx/2/YB94eLmi4SE+EJUgD1C+7gvQEfDXDO2IoSBf5j9qF00iSXb86xdbAqPtt+98bxe1KlmGhm2u
X-Gm-Message-State: AOJu0YzK8rI7vVCbU9+qSuPIBOMCR/q5LTTfQhPkpREOlX69aRlRzDSv
	sMwe2jveiTW8y6uUtFKA3klKiEXiagTOz85Y4Oh7FaMjyXAxvqdVnhD9SbwE
X-Google-Smtp-Source: AGHT+IGIyJaezjhyUTom/w6tUGyfbMAG84Y/H3tYbwkotS7/mouJ6QiJqag0WdQMC/HI+BUC7ss1dA==
X-Received: by 2002:a05:6214:5d0b:b0:6bf:69c2:1d39 with SMTP id 6a1803df08f44-6bf7cdca1ecmr126175296d6.7.1723912520820;
        Sat, 17 Aug 2024 09:35:20 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef242esm28319406d6.118.2024.08.17.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 09:35:20 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v4 2/3] tcp_cubic: fix to match Reno additive increment
Date: Sat, 17 Aug 2024 11:33:59 -0500
Message-Id: <20240817163400.2616134-3-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240817163400.2616134-1-mrzhang97@gmail.com>
References: <20240817163400.2616134-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The original code follows RFC 8312 (obsoleted CUBIC RFC).

The patched code follows RFC 9438 (new CUBIC RFC):
"Once _W_est_ has grown to reach the _cwnd_ at the time of most
recently setting _ssthresh_ -- that is, _W_est_ >= _cwnd_prior_ --
the sender SHOULD set α__cubic_ to 1 to ensure that it can achieve
the same congestion window increment rate as Reno, which uses AIMD
(1,0.5)."

Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event

Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>
---
v2->v3: Correct the "Fixes:" footer content
v1->v2: Add new field 'cwnd_prior' in bictcp to hold cwnd before a loss event
v1->v2: Separate patches

 net/ipv4/tcp_cubic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 00da7d592032..03cfbad37dab 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -102,6 +102,7 @@ struct bictcp {
 	u32	end_seq;	/* end_seq of the round */
 	u32	last_ack;	/* last time when the ACK spacing is close */
 	u32	curr_rtt;	/* the minimum rtt of current round */
+	u32	cwnd_prior;	/* cwnd before a loss event */
 };
 
 static inline void bictcp_reset(struct bictcp *ca)
@@ -305,7 +306,10 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 	if (tcp_friendliness) {
 		u32 scale = beta_scale;
 
-		delta = (cwnd * scale) >> 3;
+		if (cwnd < ca->cwnd_prior)
+			delta = (cwnd * scale) >> 3;	/* CUBIC additive increment */
+		else
+			delta = cwnd;			/* Reno additive increment */
 		while (ca->ack_cnt > delta) {		/* update tcp cwnd */
 			ca->ack_cnt -= delta;
 			ca->tcp_cwnd++;
@@ -355,6 +359,7 @@ __bpf_kfunc static u32 cubictcp_recalc_ssthresh(struct sock *sk)
 			/ (2 * BICTCP_BETA_SCALE);
 	else
 		ca->last_max_cwnd = tcp_snd_cwnd(tp);
+	ca->cwnd_prior = tcp_snd_cwnd(tp);
 
 	return max((tcp_snd_cwnd(tp) * beta) / BICTCP_BETA_SCALE, 2U);
 }
-- 
2.34.1


