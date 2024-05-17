Return-Path: <netdev+bounces-96911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9578C82BD
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 10:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679E7282B6B
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A222BDF60;
	Fri, 17 May 2024 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYVUxcoX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA8D535
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935841; cv=none; b=dnOq6JlVXZfCFprmvTSUGIFmcBXL3J4VuZ4C2o/Ja6JWsdz3PaAJaxNObaa/govV2/A3J2ezYFAQQ90gpUpTWy1o+1epidmKfjg7rgFC+ZMudOxA0t84l156OBh8TjJh+B2u8F751BQpTCUVh8zahdNWTY/eH1SNIAwyZZ774JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935841; c=relaxed/simple;
	bh=gWNhGoZIjQG05E6BXLqFQFpVBz4vSO79tzA4lTKIk1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f6ubHez42cVYwAEkSU+mcvKiDsYgU4p0dljIwPD26fkU5+3DK1JGiUSDmb0WgSQUGXbwhxqLyrqlAxWk/hVgpOWewFc3ZjZCQiAxwcDXXv4ZiWm4YOp6swoMACeDZU20e1XHHtNqT2sViKQ3r3mqkUd2YxAtjA4z6lmgkQMCqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYVUxcoX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f447260f9dso977783b3a.0
        for <netdev@vger.kernel.org>; Fri, 17 May 2024 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715935839; x=1716540639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nS63FTLdJ0neRQPQJj5PMles/jWoV6nNyU28OeSEDLY=;
        b=EYVUxcoXy75tnCvFgSUyohY6QS4oWsmxbsISdYdLKAXWZAYcYYRJkae9zmB+sulIaV
         3wC1oo++LQgd9g7mqWGeJuh8wSmL2D1R1iZudSkKFOm6MKPRSYGejKpeUI9Cv50zPl3Q
         lvNMC9GVqjH91z+ylE5uwK9RZ8v2OCUp1wslWirZvREoytdbQn4V524Roc3Jg37OuNr/
         +MYErFuKKzti9KymQTkNntt4qK6h1sKwTwl192O7nRFc3SNYmgNRZUa4rF1N6lESLNso
         J1ozwONGnau8ywJNkumcmUT1BitzMuuEq9vE251dfi6myI41GzrxFNLAZLOJ5cOKai+V
         jGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715935839; x=1716540639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nS63FTLdJ0neRQPQJj5PMles/jWoV6nNyU28OeSEDLY=;
        b=r1pFThMtd/1OhIW7WtgnKkGScJBcuz/TfaC4QNrpT/A1iR1umnqdVbit/4J6iEuNKK
         eETTXRl5MOty9r1XfuS1F+ICr3OImeMXFJC2L+7oJv1IiqAdRKXYKUjjxs116lLcNd0H
         uZwcz2aqqqitKlRrd+aGCAgzZNouc7EX6/Bnoa67z2O7zv4ZyS9Tn1s7AtQiHLBre7Z2
         HSOHA7oU2TRA5FlF2RNEmah9pyEvJZY68ap1hYUdCX3AFE0DU+HgPPZ4cKZg+oPSQ8XO
         47ivLSxBhK+jn6foC72fHAJvn3ehf6/zMQ+uBWNb86hiIL+Pke2ndlfipullO8vuWgvH
         NvnA==
X-Gm-Message-State: AOJu0Yyt1Q8efG6dLH+vPX767zBjmANTjIixShPHWFw+T1KIj6dIrFd1
	3eUPrE74wPvBn/yyxA++x3DRZwFcM2klgbvn1s+L/gnElJXywcQj
X-Google-Smtp-Source: AGHT+IEJWZNmaWP5xcKxTapklKv/6xXXHG8gwXT9mACreEes4r5KjTYvPzERgeMzYBvfxZvUUYNr3Q==
X-Received: by 2002:a05:6a20:9747:b0:1af:cf63:3742 with SMTP id adf61e73a8af0-1afde1b0193mr19569115637.42.1715935839257;
        Fri, 17 May 2024 01:50:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c036135sm151603035ad.205.2024.05.17.01.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 01:50:38 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [RFC PATCH net-next] tcp: break the limitation of initial receive window
Date: Fri, 17 May 2024 16:50:31 +0800
Message-Id: <20240517085031.18896-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Since in 2018 one commit a337531b942b ("tcp: up initial rmem to 128KB and
SYN rwin to around 64KB") limited received window within 65535, most CDN
team would not benefit from this change because they cannot have a large
window to receive a big packet one time especially in long RTT.

According to RFC 7323, it says:
  "The maximum receive window, and therefore the scale factor, is
   determined by the maximum receive buffer space."

So we can get rid of this 64k limitation and let the window be tunable if
the user wants to do it within the control of buffer space. Then many
companies, I believe, can have the same behaviour as old days. Besides,
there are many papers conducting various interesting experiments which
have something to do with this window and show good outputs in some cases.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 95caf8aaa8be..95618d0e78e4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -232,7 +232,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_workaround_signed_windows))
 		(*rcv_wnd) = min(space, MAX_TCP_WINDOW);
 	else
-		(*rcv_wnd) = min_t(u32, space, U16_MAX);
+		(*rcv_wnd) = space;
 
 	if (init_rcv_wnd)
 		*rcv_wnd = min(*rcv_wnd, init_rcv_wnd * mss);
-- 
2.37.3


