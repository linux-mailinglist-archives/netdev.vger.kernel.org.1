Return-Path: <netdev+bounces-197412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C4FAD8958
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECE916C75C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9AA2D29C5;
	Fri, 13 Jun 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AP8dYg4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2922C3253
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749810041; cv=none; b=VncBqKnlPLtX4ujAl0UkhFi5OERH3WIjih8g4P2YOw/VElC/hwRePnc5U+Sn29hGU3YkNrSyufdmAZE9q78kAuYKqt4tY2f8OU8ci988HQaajYYTXawN7EbmFnpQLicGysCGT7Ip25nLq4fxWPWCmEQ45hqtqMqBwQ8K0ArGioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749810041; c=relaxed/simple;
	bh=eWmogYyF6BR0pB/vtQAb/50StEIt8m85cxiJ2C0zPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgN3x1tFAHq6JBS+sb0jtIREiqpHDXmXlHBHA0OS3U8B503jV5oTnBgnUqBLCYZhA4wBnx5R68Ho6mU5AQdM96TrwzCcM0Mwyy3yRrmPZg4loSKIJDVn+IxKmBmHNFKFR6A+pLkco2qPa/PLdp+hsC47u6wXWQG3OMnzXo/esJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AP8dYg4I; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5faaa717cfbso277361a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749810037; x=1750414837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkwIwMnAdWBOffUiivU29CEqPbHaLRq/epKBsq5mAyA=;
        b=AP8dYg4Ide+TlCUz/qh0evJF9k3vuXiADWQGbLJ4bTdx7FqCdJ1JI3E1LUvgitko3N
         w7TcKaaDe7ShWm3C1AkmdNeMoVk8//jqUfIpfJ9K1jnMGN62FnyKU+/2DLiTdITxFcDZ
         RMyzhIyb8CBzSXP+aTHgp/58Mvl/lxBIC7Y7OYUqMuO4GzN7TDMtOC8UuMHuhoEj+rmP
         vbJkFguPA/W52y3OueLHSyf6EBKcMI2CYecYBQA/P7YshmH0+y0PUQc0IIjmqqy7/TIc
         zbHzyeiXPCMiEdAn8DjFCkAdcsl0XoDqIDs1BLXuHdhBizZu+RF6FzJCpOAivRG280vH
         UO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749810037; x=1750414837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkwIwMnAdWBOffUiivU29CEqPbHaLRq/epKBsq5mAyA=;
        b=lVzZ6PsvfYMCP+3wJ1Xb17X7+qCNG/WBBhJPyqaai3XtM/48/cLBaUHmzzrbiCaIsN
         FN312K4fGa7ogcvabvasLPlJkSldDNNsTSycrD1jDfJ184s/rNg5jUYK/YpqRv0HTJau
         lQHQwACCrMeGS1tincepeXzi7o/U1KsSVXi4l5Z2gr5eh7MnoxpM8SPl5MQezYI+p+us
         WlrgHzmfFzV84FZOPIPv9GiNFlNZ/yHr3kuTEgv5qKZavBhSomqnDY10JsB+Xb2ArUVD
         FdNO1Z6YGeZjLGhweaCaO+GflQgRSUduo2aU9cAlvuu60LegAUoGf2QdlzpWwr3EDnmu
         tDIg==
X-Forwarded-Encrypted: i=1; AJvYcCXwoBrjNom8Ca23aRRbVw2RfdIfP/VTBEeXwa5EBanepWyKSP67G7w6uTvq54EkzkNAgVAtbsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9lIfZX80dq/7Vil3LZ0Qxm7CD00cR+6cbHCQPS6yoOxxB0JIt
	2G6+Sj4lk638fjXITNqNJZD9c6UAOHri3LqECJMjQJgBSo8MTPBA423xXJVqcC0NDRA=
X-Gm-Gg: ASbGncvst/chjMUs+JqcJHspc1yC9EuasmILhETWbLt8ef/Hq7fmmptX2YBuys3w+8+
	rkXWuJpBjIoNq/E9JW0AghEV1j57J5/Jm3utKWtmlRAMmaUgMJTUNPTMOxxl1hIosH9MRHzkG50
	9mECjOTA95YruxGjMv6Lr/7myRT173mPB6jlgPSZB3Phx7LZBq4YCMOQs4X2uvnyE6jqdYGjojm
	DphldsEPbDo3u0v5EM7Ls7N4GZMxnGhLHXvj8nru8keI3Io/L3P/Dx5pK0/aVuIsNZU345vRXjx
	QB1XpKGWIfqNjqCBDWcRnwWuQxg+xOLDW1m1PyTklb2FuLKVh6GhEV6mRZlW0YEr6nvPRWkHjgH
	ifQzUb2/PvAYmVEEdHzcNwGBG2CGd/u45ukOWRl/Ao18x9UeXx+AE
X-Google-Smtp-Source: AGHT+IHrXTZARRY8MkGg/fQ94LWTE1yEeuw9ck2Mt1QfxwwvcPD1Lp9pKEwFLJkfrD9X8UgSnAQYAQ==
X-Received: by 2002:a17:907:7214:b0:ad8:89c7:61e2 with SMTP id a640c23a62f3a-adec555fe4fmr80510066b.8.1749810037143;
        Fri, 13 Jun 2025 03:20:37 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec88ff265sm105300066b.95.2025.06.13.03.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:20:36 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org (open list:NETWORKING [TCP])
Cc: David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH net 1/2] tcp_metrics: set maximum cwnd from the dst entry
Date: Fri, 13 Jun 2025 12:20:11 +0200
Message-ID: <20250613102012.724405-2-ptesarik@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613102012.724405-1-ptesarik@suse.com>
References: <20250613102012.724405-1-ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Always initialize tp->snd_cwnd_clamp from the corresponding dst entry.
There are two issues with setting it from the TCP metrics:

1. If the cwnd option is changed in the routing table, the new value is not
   used as long as there is a cached TCP metric for the destination.

2. After evicting the cached TCP metric entry, the next connection will use
   the default value (i.e. no limit). Only after this connection is
   finished, a new entry is created, and this entry gets the locked value
   from the routing table.

As a result, the following shenanigan is required to set a new locked cwnd
value:

- update the route (``ip route replace ... cwnd lock $value``)
- flush any existing TCP metric entry (``ip tcp_metrics flush $dest``)
- create and finish a dummy connection to the destination to create a TCP
  metric entry with the new value
- *next* connection to this destination will use the new value

It does not seem to be intentional.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 net/ipv4/tcp_metrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 4251670e328c8..dd8f3457bd72e 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -477,6 +477,9 @@ void tcp_init_metrics(struct sock *sk)
 	if (!dst)
 		goto reset;
 
+	if (dst_metric_locked(dst, RTAX_CWND))
+		tp->snd_cwnd_clamp = dst_metric(dst, RTAX_CWND);
+
 	rcu_read_lock();
 	tm = tcp_get_metrics(sk, dst, false);
 	if (!tm) {
@@ -484,9 +487,6 @@ void tcp_init_metrics(struct sock *sk)
 		goto reset;
 	}
 
-	if (tcp_metric_locked(tm, TCP_METRIC_CWND))
-		tp->snd_cwnd_clamp = tcp_metric_get(tm, TCP_METRIC_CWND);
-
 	val = READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) ?
 	      0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
 	if (val) {
-- 
2.49.0


