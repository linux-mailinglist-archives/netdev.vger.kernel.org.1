Return-Path: <netdev+bounces-128337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F0979004
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C00283E9D
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B41CF5D0;
	Sat, 14 Sep 2024 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EK7LQ/Is"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B21CF2B9
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726309971; cv=none; b=fulpcgl0Qs/t8SfepEDKKeHW6l5CiLQQDVphaDSU0yOr77oVvTfm96k+4dctqngsbT8dac4eUMw+e/71eeq7TsB6yG5e0qoLUJwXsOlJU3ySUmGHVDOYG7/eRNy9S/GRxMw2o9LejvSmo6zX3aNdvjU6H90s2pFfYNbIxGdzbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726309971; c=relaxed/simple;
	bh=s8DsojteGWQbIibiQeeN+V7NoCWk/i240ms0OBizBQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oS24iRWPJ/J6wswuBRfBC5DY/p2MsmnjdMpluFaXXGeaqWlClzv0T9Z8TBMD/G5dOWIA/2xjYraP/tvkUie/i5EMqV69p3e49jjpSLpj3uOkm0cABLbZDNs/B0JuBkr7WbIDD51pQ3AFcDEgdSNE/rPlXoY0atRcBW9gS1Mr+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EK7LQ/Is; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d50e7a3652so2013379a12.3
        for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726309968; x=1726914768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjQqPR/O4cbkW/hD684XD91wFosDYzncY6/VLXc3j6E=;
        b=EK7LQ/IsdjLG9d2TMkz8SfAv2K5yE9ioe5VbSQF8+DBgw8FKj28CpsAtJUh7W50Ezf
         mZyRcNhHMSLpbOhBiCq0F7bkIzQqp/SIEyAooSFgBuOWmTl16WLzEOf1W4v5im31g8rG
         Xll4+71pNd45RcIO6UTQ3lblh7OjGCaGWq3MQ0HMkd5JL0csxtKOlT92AEJi2ltsZ1+2
         TSN7+Ie2zLF/BheM8brRcF5HtF/RxfPqu/5aGxKNWql8j2RBKSYtB8S1BNp19I5zZ8EV
         Sz6WH4Jl0ejC3YUAHvwWxogPl5Wnk0Cavy5cOhjTvHudDmgoLAmR99bQnnaJGnt1//Do
         bGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726309968; x=1726914768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjQqPR/O4cbkW/hD684XD91wFosDYzncY6/VLXc3j6E=;
        b=nxIqRhCEut6waQ15iOrGM/yPzTPOiUTDv/w+3+BynLroNIZJVTUvHNga4fWzASzycD
         +eSXczzjjO4JmoAnPFObQAKEwMkfaq/EoywPnALokGXTTsex5gyMT0Nmk+KkfxDnFVWJ
         dmiqP7VPoRERcEzMgB4aeFyCdI7WNVQWldqcYOv7SVmBNasPxE8cHUnOT35FcR/dkps4
         Osim+SiR7vpFHDGppgRXS5cCWBUi6c++BAb3z8WGUTEnGjgJRDkABleKbipOCdMGxgrx
         QuvFz4hHgDtC/0YYygEwGAIQy2uDho7Y8xQoJYgic8oEoZFyI9vgZ49iK6uNtXV59Gje
         y3NQ==
X-Gm-Message-State: AOJu0Yw4RsGqznmmlWsivCDcOXfI4Y1ISNcklfGoAdI74S7m3FpkVK/r
	9naoToSYKbe4AiAJzVeccZxXWcvs+YUw0IVUzADQ9p22TPk4JBAtPUItdCNpF80=
X-Google-Smtp-Source: AGHT+IE3UauTZ/385KdWRCwcFSIlvJxIZ90AhgKMFaRWwNdUkCqO1ooNd68vWpjxwmGHl3ODnkxKfg==
X-Received: by 2002:a05:6a20:c916:b0:1d0:45c2:8140 with SMTP id adf61e73a8af0-1d045c2821fmr12659050637.18.1726309967883;
        Sat, 14 Sep 2024 03:32:47 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab50cbsm788332b3a.53.2024.09.14.03.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 03:32:47 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mykolal@fb.com,
	shuah@kernel.org,
	alan.maguire@oracle.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v3 1/2] bpf: Fix bpf_get/setsockopt to tos not take effect when TCP over IPv4 via INET6 API
Date: Sat, 14 Sep 2024 18:32:25 +0800
Message-Id: <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
References: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
use ip_queue_xmit, inet_sk(sk)->tos.

Bpf_get/setsockopt use sk_is_inet() helper to fix this case.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/filter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index e4a4454df5f9..90f4dbb8d2b5 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5399,7 +5399,12 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 			  char *optval, int *optlen,
 			  bool getopt)
 {
-	if (sk->sk_family != AF_INET)
+
+	/*
+	 * SOL_IP socket options are available on AF_INET and AF_INET6, for
+	 * example, TCP over IPv4 via INET6 API.
+	 */
+	if (!sk_is_inet(sk))
 		return -EINVAL;
 
 	switch (optname) {
-- 
2.30.2


