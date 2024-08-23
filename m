Return-Path: <netdev+bounces-121544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A795D957
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 488D1B23544
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3311C8FB3;
	Fri, 23 Aug 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZL+L7+Vv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28491C8FA0
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453355; cv=none; b=OOt3XtKooDQ4OitHEKpuXieAsllFgUZ/VjJoRlg0QYxZ149Hu8Gf+Ftpi+u3xgCJvDsurFJN5h9T701xrCiskS/hql/HRzjqcq2lLoyC/bKo6AzHwsylN/51FmuM8UYB+7kDSMHtpk1vngVctUgj4lCAj0EX1NJ54qa924QmI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453355; c=relaxed/simple;
	bh=SzDj+IkGBfuySC+NrBulaW1DN1GTdQvr1XyfZJPo5B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=paCxEuFfrZ5+KZ4c1IdJAxrBPpwtRTmzOqLUaa8EM2E2/mUmgV0ppUocHCqfbPdvQt61NnaAZFaRGOKF1997yrNhSYri1DkWVQV47C0LedpIFn3a+jC+qT3eFbeEb8k0sQUV8kgmUxJ2tthk2PbHTEzYx8RtNuSeAIaULqvsiT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZL+L7+Vv; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5cbe88f70so1727210eaf.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 15:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724453352; x=1725058152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSsxgZw8dqBytHdweXJL0wdTMnZGer2GW0z20BVV72A=;
        b=ZL+L7+VvZY6Ymkc5s6RmtLaF1IQYn7sKT6zJWWNoY18mumgBYGCptUqedrmOkCGY5o
         cGIdOU+1kPVUJKJVyed6WYAixayT5H6eGk79ZbtwqlJoMMjRBwHzi1yzLkxWrfq6yZlJ
         Dc4ij+Qhu6smrlgRb2LKQ0hs1UMyZ+cjV1o9LjW8U5u289qlT7Djrf/4xcgvOueeR3mj
         iagKgwxYxIojpXXFtr2QBCMHWPiKiUHwcYDN6gzvmz2e2m0qt9wgIh4iM4wsqScLyZwq
         01HR/+nvc+8IBF83RJ8a2fBoRG3fiYnm/Qwe9xLC2TtpooGqetDepq0PK7BfC6KvxQ4Z
         IWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724453352; x=1725058152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSsxgZw8dqBytHdweXJL0wdTMnZGer2GW0z20BVV72A=;
        b=DVs0ShQRIdy2eQV7VIqOD6TCCS4wkCXQNz5afOz8r9i2lwhtcWR05JOCWQDEniyXiH
         mWXwjn7/Y5jA46APTX8pj//haJ58/Vu9ECmnKxAWHHPEwPFQXBeV3Y2KMoFz0MqrTkaA
         N1hlWQjJr6Gqyp0wY7yDIea+h//owL357gTkibxKmMJmINd/etgsbfs2uosv2QJhjfLe
         fn2lJbPKxaicxS6bUpiBCvfeGwij0YkHO4fIEeoNoyfHfNcVcdxNOniJlb6CVgEzAZPu
         jAEjk/9Cl9hnBeIgntCF/9rM5ycqw1s07Gws6pPzkH72WTBG97Hs4UwWJG6Z6Q0xXB+G
         B5/g==
X-Gm-Message-State: AOJu0YwlW8gcIwjdfYJglIBDJ8/ps7kM/HXe9ZlT9i6/F3JxI53lX/Lz
	shee5w36cU5cXISm5EkCq6NvETBjOSXvwVP+uFHT7k/KDkQPL6V3A/yeKQBDYyTVWt+PuENNzCn
	1Knc=
X-Google-Smtp-Source: AGHT+IFz6X86N/Ecqrbxjnbu0qCSWogUBUFTiZGz2RkQB9Cbeov/xBFVFslHsqwORCGxaI62m7Tbvg==
X-Received: by 2002:a05:6358:720f:b0:1aa:c71e:2b5d with SMTP id e5c5f4694b2df-1b5c3b0f806mr438452555d.23.1724453352451;
        Fri, 23 Aug 2024 15:49:12 -0700 (PDT)
Received: from localhost ([130.44.212.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fb45csm221505185a.114.2024.08.23.15.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 15:49:12 -0700 (PDT)
From: Yaxin Chen <yaxin.chen1@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Yaxin Chen <yaxin.chen1@bytedance.com>,
	Cong Wang <cong.wang@bytedance.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: [Patch net-next] tcp_bpf: remove an unused parameter for bpf_tcp_ingress()
Date: Fri, 23 Aug 2024 15:48:43 -0700
Message-Id: <20240823224843.1985277-1-yaxin.chen1@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parameter flags is not used in bpf_tcp_ingress().

Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Yaxin Chen <yaxin.chen1@bytedance.com>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 53b0d62fd2c2..57a1614c55f9 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -30,7 +30,7 @@ void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
 }
 
 static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
-			   struct sk_msg *msg, u32 apply_bytes, int flags)
+			   struct sk_msg *msg, u32 apply_bytes)
 {
 	bool apply = apply_bytes;
 	struct scatterlist *sge;
@@ -167,7 +167,7 @@ int tcp_bpf_sendmsg_redir(struct sock *sk, bool ingress,
 	if (unlikely(!psock))
 		return -EPIPE;
 
-	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes, flags) :
+	ret = ingress ? bpf_tcp_ingress(sk, psock, msg, bytes) :
 			tcp_bpf_push_locked(sk, msg, bytes, flags, false);
 	sk_psock_put(sk, psock);
 	return ret;
-- 
2.20.1


