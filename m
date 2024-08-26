Return-Path: <netdev+bounces-121817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2666895ED0C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2835D1C21457
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757721411F9;
	Mon, 26 Aug 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DU8yJYB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD14EAFA
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664432; cv=none; b=FE4hv/VH3XRk/+DZvm/zMWl+CyYXKEgVq2bbsmoEjlNWp2ItIgUUFxgiZbN3nc6UmqrYWnOFWfNoHhfymMHd7wgAkPF0PQJqTtBGfSHWV3zv5tj7B5bmaOtg2Myco489bH22YX/1jsKyt8sTLCT2ZyWm0Go97XOV2R0zvOTTnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664432; c=relaxed/simple;
	bh=NjMn1gyqpmOvPuJPrP3LZ7pMHvoWkgH0exoRBK3ZSFQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OYKaO9uY15372UoMFNZcZCSBGFOx3Ej1DvIhXCaXubw3aWdOWLxWYVTqUTduW3sA4ss4OiRa3ibNablIEhRurXO+HfSpsqb9f/63y8H2mghBfS83RtGrpxdTy303+Tbconhasw8Ah6lDTAeSDziEyrGOLAJSPF0T6NQtvxqW0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DU8yJYB9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b1adbdbec9so80112107b3.0
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724664430; x=1725269230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=roDHgEGzl1utCYXkzAU/0s849ff2ET1U6Oi21qTKh0E=;
        b=DU8yJYB9YHdtKi1mVmP3ibYPixc4kCG9GOdxrczPe1QQs2fzBICGIuWAseY4SC2cTC
         CnjZiQR3OzNhTRGwHM1xEcLCGTukHPHjz2MDZDdM/4o4KB8wTtBugFiYH82+1hHHL97L
         YpaY03QcpjuJJqIeidsMXoIzVJUOjxpDS4oAKjP8UkPoG9jm64Lh7UTQpGel0R0ZCDE+
         zr5UPfeb93iBuyuO1VHIgFP9Fh3aWn/LIUq6s9PQNtlpmg4rD+u2YsLvMbVudszKI9pm
         d8KLeuSUAHuETdbWgAcyimL09ywXNVlfa9r5c+mbTI2aRDs7m7njqiQMWCrLl+62OF3N
         4EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724664430; x=1725269230;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=roDHgEGzl1utCYXkzAU/0s849ff2ET1U6Oi21qTKh0E=;
        b=R0jHs44FnOtqjJRVy7a+5/2OGfv213j7p8dxvdLUgj44gJ5ErgTg8zkCb2uoTokcA4
         ujfrDmtspehvkFDLN1weRXciBz4/wvjLQXVLLF+6sWy6eWModVy6JdSFAb31XmpkwFzs
         6fc+rkMrRuNz4FKcpkx3/s9dw1qYtGW+R5t/z9JND/juONUlU828oappu1vPA1ZJ+Q46
         9Zhu1HBKhyCsOXhTpzA8H9v7KycjGhXYjk/SONn6FTFo7u0wZsRUafhz1oq/XQUF4TqS
         /NDDiclqWdB2mxTHyLQgiokhDADl/VlemxstCVdnULMnCK5w0bZp28lrXDaydy1ujSGg
         J3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVYPTrf5mD2Wa3BSp884CxVDVkc2bV42h7+XQl+s8ct8mE4W47UPVZplW2r3Uxaw1l32Sccpf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys0fVSQEfBG/K4ndYh+GWxqEK6ITFapwJ2ksathFeZClAzmoKi
	h5qyXTau9tGAjGyAMHg/Wp5DAdiQKOPZdFs9SWoCbeuyHH7gz3JMaM0lk7UmYOYq4wOG34wQ3s0
	p/Ovqs9e/zw==
X-Google-Smtp-Source: AGHT+IGnVKIaE9mqLH5hajV+0cyXxbpRz/zQD3uESApcU1z/B4c5RLJ/8lmFPDBi4x7+azVe+suppIivucdlgA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:86:0:b0:e03:3683:e67f with SMTP id
 3f1490d57ef6-e17a83caf9amr17669276.5.1724664429639; Mon, 26 Aug 2024 02:27:09
 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:27:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240826092707.2661435-1-edumazet@google.com>
Subject: [PATCH net] tcp_cubic: switch ca->last_time to usec resolution
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Mingrui Zhang <mrzhang97@gmail.com>, Lisong Xu <xu@unl.edu>
Content-Type: text/plain; charset="UTF-8"

bictcp_update() uses ca->last_time as a timestamp
to decide of several heuristics.

Historically this timestamp has been fed with jiffies,
which has too coarse resolution, some distros are
still using CONFIG_HZ_250=y

It is time to switch to usec resolution, now TCP stack
already caches in tp->tcp_mstamp the high resolution time.

Also remove the 'inline' qualifier, this helper is used
once and compilers are smarts.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/20240817163400.2616134-1-mrzhang97@gmail.com/T/#mb6a64c9e2309eb98eaeeeb4b085c4a2270b6789d
Cc: Mingrui Zhang <mrzhang97@gmail.com>
Cc: Lisong Xu <xu@unl.edu>
---
 net/ipv4/tcp_cubic.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178257df8d2ccd1c8690a10bdbaf56a..3b1845103ee1866a316926a130c212e6f5e78ef0 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -87,7 +87,7 @@ struct bictcp {
 	u32	cnt;		/* increase cwnd by 1 after ACKs */
 	u32	last_max_cwnd;	/* last maximum snd_cwnd */
 	u32	last_cwnd;	/* the last snd_cwnd */
-	u32	last_time;	/* time when updated last_cwnd */
+	u32	last_time;	/* time when updated last_cwnd (usec) */
 	u32	bic_origin_point;/* origin point of bic function */
 	u32	bic_K;		/* time to origin point
 				   from the beginning of the current epoch */
@@ -211,26 +211,28 @@ static u32 cubic_root(u64 a)
 /*
  * Compute congestion window to use.
  */
-static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
+static void bictcp_update(struct sock *sk, u32 cwnd, u32 acked)
 {
+	const struct tcp_sock *tp = tcp_sk(sk);
+	struct bictcp *ca = inet_csk_ca(sk);
 	u32 delta, bic_target, max_cnt;
 	u64 offs, t;
 
 	ca->ack_cnt += acked;	/* count the number of ACKed packets */
 
-	if (ca->last_cwnd == cwnd &&
-	    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
+	delta = tp->tcp_mstamp - ca->last_time;
+	if (ca->last_cwnd == cwnd && delta <= USEC_PER_SEC / 32)
 		return;
 
-	/* The CUBIC function can update ca->cnt at most once per jiffy.
+	/* The CUBIC function can update ca->cnt at most once per ms.
 	 * On all cwnd reduction events, ca->epoch_start is set to 0,
 	 * which will force a recalculation of ca->cnt.
 	 */
-	if (ca->epoch_start && tcp_jiffies32 == ca->last_time)
+	if (ca->epoch_start && delta < USEC_PER_MSEC)
 		goto tcp_friendliness;
 
 	ca->last_cwnd = cwnd;
-	ca->last_time = tcp_jiffies32;
+	ca->last_time = tp->tcp_mstamp;
 
 	if (ca->epoch_start == 0) {
 		ca->epoch_start = tcp_jiffies32;	/* record beginning */
@@ -334,7 +336,7 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct sock *sk, u32 ack, u32 acked)
 		if (!acked)
 			return;
 	}
-	bictcp_update(ca, tcp_snd_cwnd(tp), acked);
+	bictcp_update(sk, tcp_snd_cwnd(tp), acked);
 	tcp_cong_avoid_ai(tp, ca->cnt, acked);
 }
 
-- 
2.46.0.295.g3b9ea8a38a-goog


