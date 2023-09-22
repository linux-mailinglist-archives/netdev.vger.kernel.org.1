Return-Path: <netdev+bounces-35915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CB37ABB9B
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 00:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 212B5282680
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 22:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196247C73;
	Fri, 22 Sep 2023 22:04:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1E147C7B
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 22:04:03 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F243583
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c081a44afso45863037b3.3
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695420241; x=1696025041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KVNSy8OfBhOXGRydDqdxEWc4BcAxfByqT1u6CyRqwbw=;
        b=at6pCr/GwGgTNlyWbgPDeSTvhVmdtIzWx4WmNO2N+5qnlmI3lOAZ7+zx5H6dL1Y6Wd
         NPkfqm4T0meCStkcyuJ5KnUirM4WsoJ5H3ot/ScArtMMmzHVz2BdugodL5HJ5g0qd2jN
         TtRjUqlRuUaHoSy6Z+hbGJ96iqKoquxOOTCnfsjLk6q9AkUJ/mRqsfFnXCMQ0d09VTMX
         Lb+78WvTw94zqSOPX7BihFL+y8/hLZhuWQ64fd0YmXZ7q3OUhFajX2yz0mW8YazgH+lJ
         Y3hdA3zmiMAxQIlTpK80mmpHjkONZlVyiLs6WTr07wkshpxE8jDYnL8iwLC9gIzU4toc
         r7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695420241; x=1696025041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KVNSy8OfBhOXGRydDqdxEWc4BcAxfByqT1u6CyRqwbw=;
        b=gnnp+CNqz+kJMFkEgI3V0L2ZoRlHkcd+8IPPACFEyG6oiZn087AAUZBhACNGnRcSuo
         VUiw3mZxnpBZJFsa00rXump7nh43ZCCPig3J30Qht0yZJySvQRH+pMdhMwahPV6dw18X
         SyxjlWW2oAF2LJ/wvhckjLsyQG1b4eu0R4SMBKxrqAsXRpsBf1Li3smIif8GCSff5GLP
         ITlm5HzVBJpPtJqP6AWRMmzJ2NlTbSdyanZHMQIy8kgUx2HBtGhQoXYfoilBSs4cyfxw
         hApJjCvojm8u3h6apyp9kGTjH8/tbtqPPz2cl2WEG8Fqa9K9aFvdT4XmdaZjzdKQB+gd
         qTZQ==
X-Gm-Message-State: AOJu0YwY+Obhxsh4rlGKngtJ5azAcOWhODujfL4o10A1PSRS+uD9jSiB
	j8ekVKSQ6uya802PpY49hOObOrSFaJ94SQ==
X-Google-Smtp-Source: AGHT+IElISgk71DN0t+/I5ov8ugtfeLLYwLW8+imAgwftTpkD6R/iF8Cm2mG/FsXVHwAFDCUibN45HaNm1TcCg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4e05:0:b0:d7b:8acc:beb8 with SMTP id
 c5-20020a254e05000000b00d7b8accbeb8mr5803ybb.2.1695420241143; Fri, 22 Sep
 2023 15:04:01 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:03:54 +0000
In-Reply-To: <20230922220356.3739090-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922220356.3739090-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We need to set tp->snd_ssthresh to TCP_INFINITE_SSTHRESH
in the case tcp_get_metrics() fails for some reason.

Fixes: 9ad7c049f0f7 ("tcp: RFC2988bis + taking RTT sample from 3WHS for the passive open side")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 4bfa2fb27de5481ca3d1300d7e7b2c80d1577a31..0c03f564878ff0a0dbefd9b631f54697346c8fa9 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -470,6 +470,10 @@ void tcp_init_metrics(struct sock *sk)
 	u32 val, crtt = 0; /* cached RTT scaled by 8 */
 
 	sk_dst_confirm(sk);
+	/* ssthresh may have been reduced unnecessarily during.
+	 * 3WHS. Restore it back to its initial default.
+	 */
+	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	if (!dst)
 		goto reset;
 
@@ -489,11 +493,6 @@ void tcp_init_metrics(struct sock *sk)
 		tp->snd_ssthresh = val;
 		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
 			tp->snd_ssthresh = tp->snd_cwnd_clamp;
-	} else {
-		/* ssthresh may have been reduced unnecessarily during.
-		 * 3WHS. Restore it back to its initial default.
-		 */
-		tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	}
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
-- 
2.42.0.515.g380fc7ccd1-goog


