Return-Path: <netdev+bounces-141237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CFD9BA261
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 21:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8B0282A03
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 20:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E011AB52F;
	Sat,  2 Nov 2024 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZbXZWma"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5709F13BAF1;
	Sat,  2 Nov 2024 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730578110; cv=none; b=j7dEDTw9+T585OkITpN9CflRoeXJ+Hoxonv46IWmjmYmLU3bGsx3i6o0OWEN9Fx55HPTSGHWrnzc5N8qwYxX0CIcRKIhp99PJxf8O9wOc5KuXeLHbuUIXHsN5u/FZEEBYp1cUCUwZX3YsAB1wCoSLfTI3n6gKMmhAnhBqVygxg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730578110; c=relaxed/simple;
	bh=f7MqDWVyhosz9cevqy6RwU/qNdpL8bdIob8pXzUX+GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMM9irPo+PGcLHruWwiWsNlGutA9KtJ99GfGrK9Y1/OUxSng9S9J2VPnoJGSvi45WWDPbNbRxVmBwxnk8tn4y1oqfbSnlbFpv9lOHLaU6Rc8KA3JgsyI/Rjyd5VNNdAyyU1hIjA3RR5CFOmcpVc+vihO0wf8pXroc4nMLY5uCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZbXZWma; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-720be2b27acso2331741b3a.0;
        Sat, 02 Nov 2024 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730578108; x=1731182908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIx9Jx7Ry0yT75bCDHqE8DPM/4OB/SFj89jRIIIj2R4=;
        b=IZbXZWmaoIHYSTWBJCV3OmVf1EvVeyyU+YO4M1gob+P5RjbV+dbXuIFA7lmCYfi5xU
         9gQP0Hzd8qxVwCusfEzdqs2aSJeazYX+Xc3Fuzqo0eG1ZnFTIVVGe1Eb7xMOPsGWZfx+
         wtk+e5wW6RNQXPbQUWktshAil3Ye4InbilKlDKRMtP4i+soCIXY74pkVDgLJLanBFDtD
         RYkNbiZYd036jtxpb1K+3sqpVWRK6kL+2m1L+p7nL2IEMt55RvndTTLzI8IpgoYNXwSU
         kGfCR+veimBpArHwsjiNJcyP1VfS9QA4AFjDYrl9dhx1jInvnWWN5eBwGyo4hb5cGp9i
         Iw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730578108; x=1731182908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIx9Jx7Ry0yT75bCDHqE8DPM/4OB/SFj89jRIIIj2R4=;
        b=VxFMj8aa2NYTDbXTQGzlaiv7swd9Ypnbyq/gU0Yc4u+pNmiwRshrvrEmKth1YgYa1/
         IyHZv4EWdetm7JPdnlxnEAbkx0una5W2OsIY44X+m3t0Dg3+aDHo3OedI3a+5XalDFGS
         sqNWeFtftVjKdGcLwyKEKRD87dMANlQWbbYKYre8YKOdSwGuYmH2n1q/E3qobLToyeQM
         sclKOFIpFZPUpzDTDjIZLtjf/H833mMBx9zU/F9e2WusJppDu6r5qWzLWkE3YO1ia/jJ
         WaD6XHdG2n4Mk5CpbkZtx3wVv6+7ZEU05bwxBm8TxETSodJnx994kEDVlnUOGgkwbBLE
         ngXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP6+lEhtaXwYf7tXAIKeCnrrA3WYR5R5xmrE5frPON6Co840ccna8Q5b4pLn3gZrkVose/5cpQ@vger.kernel.org, AJvYcCXyY9Z3RreDEiWltbaLWDL5VptN5eU+eJzGqIDOAprkqcmoTz4Ud4dxepBjbVMFdizZ/AA42hAG8nPqTQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyySii6fZy6h1lT6VZd8kUp1gamLva3JzedIWSlZGOYOV3ZDEWL
	T4n/COuEVg65NUMfF5sBEJnDL4VSFGYGwCDQ27RadOVJUiGiOLFtTIW5KpOknoJXhA==
X-Google-Smtp-Source: AGHT+IGUG5+Krz1IQiWBieU+4Vxekv7aSBW37q6c5L/WGRgJNouLTqurr4I/yDtJ7D2EojJr2/z9ow==
X-Received: by 2002:a05:6a00:2d18:b0:720:aa27:2e45 with SMTP id d2e1a72fcca58-720b9c2907dmr14899650b3a.14.1730578108404;
        Sat, 02 Nov 2024 13:08:28 -0700 (PDT)
Received: from localhost.localdomain ([240c:c701:2:805:409b:a7ac:813b:68b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720c6a39a53sm3927105b3a.178.2024.11.02.13.08.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 02 Nov 2024 13:08:27 -0700 (PDT)
From: Yi Zou <03zouyi09.25@gmail.com>
To: davem@davemloft.net
Cc: 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	dsahern@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Markus.Elfring@web.de,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yi Zou <03zouyi09.25@gmail.com>
Subject: [PATCH] ipv6: ip6_fib: fix null-pointer dereference in ipv6_route_native_seq_show()
Date: Sun,  3 Nov 2024 04:08:20 +0800
Message-ID: <20241102200820.1423-1-03zouyi09.25@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if fib6_nh is non-NULL before accessing fib6_nh->fib_nh_gw_family
in ipv6_route_native_seq_show() to prevent a null-pointer dereference.
Assign dev as dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL to ensure safe
handling when nexthop_fib6_nh(rt->nh) returns NULL.

Fixes: 0379e8e6a9ef ("ipv6: ip6_fib: avoid NPD in ipv6_route_native_seq_show()")

Signed-off-by: Yi Zou <03zouyi09.25@gmail.com>
---
 net/ipv6/ip6_fib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index eb111d20615c..6632ab65d206 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -2555,14 +2555,14 @@ static int ipv6_route_native_seq_show(struct seq_file *seq, void *v)
 #else
 	seq_puts(seq, "00000000000000000000000000000000 00 ");
 #endif
-	if (fib6_nh->fib_nh_gw_family) {
+	if (fib6_nh && fib6_nh->fib_nh_gw_family) {
 		flags |= RTF_GATEWAY;
 		seq_printf(seq, "%pi6", &fib6_nh->fib_nh_gw6);
 	} else {
 		seq_puts(seq, "00000000000000000000000000000000");
 	}
 
-	dev = fib6_nh->fib_nh_dev;
+	dev = fib6_nh ? fib6_nh->fib_nh_dev : NULL;
 	seq_printf(seq, " %08x %08x %08x %08x %8s\n",
 		   rt->fib6_metric, refcount_read(&rt->fib6_ref), 0,
 		   flags, dev ? dev->name : "");
-- 
2.44.0


