Return-Path: <netdev+bounces-132543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F2B99212B
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BBEB211AE
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD8118B473;
	Sun,  6 Oct 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNT3BCZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C8189F3F
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246753; cv=none; b=Z/gGGTDJyijYIgTUKyQQMUL1/WdsGmn7iuBESURya3N5hktrbYliIp3LD4DmZZpDMAprptZ//kHdLw1ec7aYY1oOJRTAT4nFfKgsLJnbguo5b5Kjn1KxWMJU8xbnoF92livZ7FfGHtV/zSyuEXfv3XJKvSBPv5aVmP/znxENy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246753; c=relaxed/simple;
	bh=rp97oEAEhfFwX5H4/HTVqnKTKJCEfwfMWzoZIAYnl78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oXA2eL7+KJwugFz/lgE1rFbUQVH2sUmGRdJRkBdy8klnMfqjeMIAh84egyYKFwtiIPinVsh78xiTZW5CbAes045Q24FL1SZzCeUteVY+Y0FNlSmEKvwfTjjziE49kzfdrnkZjMFbyWUKpQFVLJH20fMDLdSf9djuQrQFq+GRimM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNT3BCZx; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-45826823bb0so68107881cf.1
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728246751; x=1728851551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AaWYQlRHCcSGLjzJ6feV2xB2bsNtVl5raNu/3DnomOA=;
        b=kNT3BCZxLaYuRlKJa+XwySiOB50rvjHGqfkGD/7DQ2QRy19z7p3KmuVM+Hftf+YSPT
         7TtGtxldkaBLD+zjV3lV9c/u03NczunVCq1ExwAmoJvaw5gnuvgdy6vS7TsS+XG94p8R
         AQJ8qfFH42SbLdAsLuOlUeplikEgZhhTqUPWxGMOaWNGlZ/O7uG5l1UT01nYUxKvyujO
         IEIE87fC9hbzJzYTxIhpV28UwjjLUhyFYu9zYJn3BsNvFUg73XvY3tNl49Dtkq8J1m/v
         AEe09otR3w1+1RBwOOVwbUr0736Hi26XCkx2ba918Rqtj46ktClX/V6AA1o41QtxdC9U
         8TfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246751; x=1728851551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaWYQlRHCcSGLjzJ6feV2xB2bsNtVl5raNu/3DnomOA=;
        b=hDz/GSChFMyqiJw6eWaQwoYj0/9R4t19V0dc7u7HBW1+QoPe+qWQA4TXsZb0fUJrxy
         PK4oKOd0jdTJpaDLjMNJNmxLf4Q6R3a9oMws3xcWh54McS213F4d4m2UVwsPwulOKHrJ
         QcCBaJ50EHqDhPZCOQZiIxQYqb8mMz/DgX/S6Abrktw2CwwNL5PlDuXeIifemIk1vhtP
         ljFZWVbjPCh3dPUV7bmCHs+VdZw8Jx0n4JLZ47HBRkvWbuXTwk9X1Gth5sgfyX4EBG9p
         r6J/1EbX0n0tWutBAnnEl8H6bYlVls+U6SuNgng0PxZ5sqAmBuWcnwYpVA+XxPaUqH8X
         ceRQ==
X-Gm-Message-State: AOJu0YxhQMIlsSl669+0HuTKtx+UfZPe6D2GRxtkO1q/UP8WmWVlXCMt
	P1Clf3EWTAcotTl3R9I2CNDR5k3eEOMbtreYgaWBUIrveh720hxP2TzjF/fl/WqR/K+qDAhnpfz
	Q1aPsmfXNvg==
X-Google-Smtp-Source: AGHT+IG9n9/t6TEjbNtdpfIWnE/fT+avYBhvKT4QLPdXtgvqhAlcUYfgx62W4DFuyP89aoN0m5ftAxe4K3aCBw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:ac8:4a17:0:b0:458:493a:4995 with SMTP id
 d75a77b69052e-45d9bb187e9mr74441cf.11.1728246751092; Sun, 06 Oct 2024
 13:32:31 -0700 (PDT)
Date: Sun,  6 Oct 2024 20:32:21 +0000
In-Reply-To: <20241006203224.1404384-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241006203224.1404384-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241006203224.1404384-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/5] net_sched: sch_fq: prepare for TIME_WAIT sockets
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP stack is not attaching skb to TIME_WAIT sockets yet,
but we would like to allow this in the future.

Add sk_listener_or_tw() helper to detect the three states
that FQ needs to take care.

Like NEW_SYN_RECV, TIME_WAIT are not full sockets and
do not contain sk->sk_pacing_status, sk->sk_pacing_rate.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 10 ++++++++++
 net/sched/sch_fq.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index e282127092aba205c038046e1e8078cf2582c075..562bb47bf3d8a58f31576a66811ffb25dfed1a8b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2800,6 +2800,16 @@ static inline bool sk_listener(const struct sock *sk)
 	return (1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV);
 }
 
+/* This helper checks if a socket is a LISTEN or NEW_SYN_RECV or TIME_WAIT
+ * TCP SYNACK messages can be attached to LISTEN or NEW_SYN_RECV (depending on SYNCOOKIE)
+ * TCP RST and ACK can be attached to TIME_WAIT.
+ */
+static inline bool sk_listener_or_tw(const struct sock *sk)
+{
+	return (1 << READ_ONCE(sk->sk_state)) &
+	       (TCPF_LISTEN | TCPF_NEW_SYN_RECV | TCPF_TIME_WAIT);
+}
+
 void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
 int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int len, int level,
 		       int type);
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index aeabf45c9200c4aea75fb6c63986e37eddfea5f9..a97638bef6da5be8a84cc572bf2372551f4b7f96 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -362,8 +362,9 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
 	 * 3) We do not want to rate limit them (eg SYNFLOOD attack),
 	 *    especially if the listener set SO_MAX_PACING_RATE
 	 * 4) We pretend they are orphaned
+	 * TCP can also associate TIME_WAIT sockets with RST or ACK packets.
 	 */
-	if (!sk || sk_listener(sk)) {
+	if (!sk || sk_listener_or_tw(sk)) {
 		unsigned long hash = skb_get_hash(skb) & q->orphan_mask;
 
 		/* By forcing low order bit to 1, we make sure to not
-- 
2.47.0.rc0.187.ge670bccf7e-goog


