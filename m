Return-Path: <netdev+bounces-139016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C07BF9AFD02
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D3CB207D0
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E11D1319;
	Fri, 25 Oct 2024 08:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from wangsu.com (mail.wangsu.com [180.101.34.75])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38011B6CE3
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.34.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846065; cv=none; b=snPh+W5OT5Ts/vughm4y8g+kWGFH4JZvMzCawY9X2FROiFveuCxegersdYu9TrrgCsfl1rkzCS9cmSAfsfUGmDYiCzI9HNEFp9GCUwCRHPCWOyKYXb9v7btoI80Fj3a8i6IsfThCPe1Yhm76hMlondDoBqsw56KvStK6IOu3s7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846065; c=relaxed/simple;
	bh=+6Bwjda0TJz5AjujTOOe1v4bab2GaanKwAUR1Opb6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MMer9OwPZgXwiOGffY0d8+5XH6yxu9buo3jirq+qELMEan/vHpkyYNun2NVOvGNtCRkBVTQz80ubS3bTHfSr4FzPE3iSp2vM+4kftAjY6wxnfrbmiEjw3Gul+HCNYgaag0yxNnqxrOtCoxblRS4LwYBg/m5plrkIIdWkZ/pKrJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com; spf=pass smtp.mailfrom=wangsu.com; arc=none smtp.client-ip=180.101.34.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wangsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wangsu.com
Received: from 102.wangsu.com (unknown [59.61.78.234])
	by app2 (Coremail) with SMTP id SyJltAD3_pbfWhtnSjVdAQ--.125S2;
	Fri, 25 Oct 2024 16:46:24 +0800 (CST)
From: Pengcheng Yang <yangpc@wangsu.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Pengcheng Yang <yangpc@wangsu.com>
Subject: [PATCH net-next] tcp: only release congestion control if it has been initialized
Date: Fri, 25 Oct 2024 16:45:44 +0800
Message-Id: <1729845944-6003-1-git-send-email-yangpc@wangsu.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID:SyJltAD3_pbfWhtnSjVdAQ--.125S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8Xry8Zw1xGry7GF17ZFb_yoW8Ww4Dpa
	97twsrGw1UAryqka48XFy8Xr1fu3ykKF9rWr48Cw4fC3srWr1qqF1rKw45AayjgF4FyrZx
	XFZFv343JFn8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8JwAv7VCjz48v1sIE
	Y20_Gr4lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y4
	8IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7VU1WCJPUUUUU==
X-CM-SenderInfo: p1dqw1nf6zt0xjvxhudrp/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Currently, when cleaning up congestion control, we always call the
release regardless of whether it has been initialized. There is no
need to release when closing TCP_LISTEN and TCP_CLOSE (close
immediately after socket()).

In this case, tcp_cdg calls kfree(NULL) in release without causing
an exception, but for some customized ca, this could lead to
unexpected exceptions. We need to ensure that init and release are
called in pairs.

Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
---
 net/ipv4/tcp.c      | 2 +-
 net/ipv4/tcp_cong.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4f77bd862e95..71005daf9102 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3335,7 +3335,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
-	if (icsk->icsk_ca_ops->release)
+	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	icsk->icsk_ca_initialized = 0;
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 0306d257fa64..df758adbb445 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -270,8 +270,9 @@ void tcp_cleanup_congestion_control(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
-	if (icsk->icsk_ca_ops->release)
+	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
+	icsk->icsk_ca_initialized = 0;
 	bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);
 }
 
-- 
2.38.1


