Return-Path: <netdev+bounces-71383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA9853225
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC282830D2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A6C56748;
	Tue, 13 Feb 2024 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFoIPTJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303F5647D
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831772; cv=none; b=IzxLbalIPEXOGy+IczmwasmX8Om7H9HgTn3mP8rAxvyV49YAtjN0pK7CfQaXl/GmlHli235f0hYQ18Sziip/5/tnMTlC8fqRMHk0DuqyE9SlZxtLBInDDGWjzbc/2xsjNHhGjQAnAzI+mtKiOBpZ+6XVlYUGgTuZAHrP4o+WWg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831772; c=relaxed/simple;
	bh=eYcG00HxId5qCSyCPor9f11Ao0XyPy9N2cF4K2RNvrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpdVeoKthH7iIjo0T9UwVge5d7dJty1YUFFe5zoxQ16S4FY2sGYfc2xlEHieWNtpldq3l9u04OXygr+toRur/ZO0NswzVt/An9EybZouFsgzVVk9BovW4eqaDRJmTWnN8tfkTH1CSj1X6t0f9h9Vs2//+rZLUPaRyAI2Q2e4g/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFoIPTJf; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e104a8e3f7so98966b3a.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 05:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707831771; x=1708436571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrkG6KKFmZqUyW8+kFpwqVtyXKxWI4aCH2q1MB9xVcU=;
        b=EFoIPTJfjVcFg4f3+giaZy1pHAbIhOukDFUUPQ5SBbPGDiJ5zTQoGzZMd1NAEmgfuY
         YVPjwyKxQo3FsOB9R9PxANZqXrWZlvH0BYgoPu99Wy0qaL2jQcLgLWo9GJIdDFzg0As0
         jXgzRrbNouuRca9zNgNk/hva5oxd3w5To67mwyTqRgU7xV3/f9b0PtBe8Bz7O4hpAGkh
         0vkqXDmXniqv2QJwb1L0h0VWG4v3FhwAnv5BAes9CFHyW10bjrH5cbdVG1mJGX535T5W
         PFEE1BfIcQRtm/Wvqa1DS+BnI3jpjjjPkuFth2wHMMp+Koe/gdiJ9SzUnAUJybOOVgz/
         J9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707831771; x=1708436571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrkG6KKFmZqUyW8+kFpwqVtyXKxWI4aCH2q1MB9xVcU=;
        b=ZZ73O4GEtnOyCKGhDe2ZIeJM8wkPsF2GqCQgeebaID+udJTusCNuSTejg8EUlNDkC6
         5FgQSZ5Fy+Q7FfIMFYTABPci3XTjq8IkaPF+fJtNxWw/pmnz10LsXEvSiGu10+UXlC/n
         7hp9pQYHqesW0e+5T0djaMswZJe5modCcQcsf0nyv9dDDQED3YvQXeMYwPyCpebw4Q95
         7zm6wGsQOZZ6TU+26DVqM5qWCm+8OKFykqBC2DNTui9BXoNbqz7tkv5UVCdSO850NwN4
         C8/n8PJK+HkzQBx0jZwG8b4xWCWHvf+2kY744EEXzMwV+KneOj1luT3UnGj04667R/At
         8h2A==
X-Gm-Message-State: AOJu0YzBGt27rn7c1XjkFJYoJ13qyTNxCQHu5DthAjPoDynKZZtE/81M
	jqUxv/w0m/UdKNjvxjuzxFoW3NKFcMJF4H/KEU7+mfeNKgy1IAi4
X-Google-Smtp-Source: AGHT+IGfGSAQA8fQBr3tk+yI6SHsYMnloJi+62+yFZo78NX9/+NGeK36WEP5z0ttonQQ5Aczom5lcw==
X-Received: by 2002:a05:6a00:b4e:b0:6e0:4717:7a0d with SMTP id p14-20020a056a000b4e00b006e047177a0dmr12842688pfo.5.1707831770778;
        Tue, 13 Feb 2024 05:42:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7pheFsA5tRaDABZWbzMaxkgM777Zq6oG4Ms0XCmtLFOcFFnnXit9XPuLlkc8D7wdwgXvrEKXK+1yXxeCn7sW98pFPnQDnW3CK35fkz3EUClY3UeCL+0HxWYfjJw3GN0megEN59PhpkQD2H3ePt+UksajPkhhhn4KGrqPPjsipoAeTyd/8xcf3ugslO7TFLTgWSHwGK3xTpCyYuoTX1TV92yTOxaaXRFxHA0eIc2kRpR6b5cHqw8pVOGFASzj4D0Dn
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id fa3-20020a056a002d0300b006e042e15589sm7323041pfb.133.2024.02.13.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:42:49 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v4 4/5] tcp: directly drop skb in cookie check for ipv6
Date: Tue, 13 Feb 2024 21:42:04 +0800
Message-Id: <20240213134205.8705-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240213134205.8705-1-kerneljasonxing@gmail.com>
References: <20240213134205.8705-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like previous patch does, only moving skb drop logical code to
cookie_v6_check() for later refinement.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv6/syncookies.c | 4 ++++
 net/ipv6/tcp_ipv6.c   | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 6b9c69278819..ea0d9954a29f 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -177,6 +177,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	struct sock *ret = sk;
 	__u8 rcv_wscale;
 	int full_space;
+	SKB_DR(reason);
 
 	if (!READ_ONCE(net->ipv4.sysctl_tcp_syncookies) ||
 	    !th->ack || th->rst)
@@ -256,10 +257,13 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
+	if (!ret)
+		goto out_drop;
 out:
 	return ret;
 out_free:
 	reqsk_free(req);
 out_drop:
+	kfree_skb_reason(skb, reason);
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 57b25b1fc9d9..27639ffcae2f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1653,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (sk->sk_state == TCP_LISTEN) {
 		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
 
-		if (!nsk)
-			goto discard;
+		if (!nsk) {
+			if (opt_skb)
+				__kfree_skb(opt_skb);
+			return 0;
+		}
 
 		if (nsk != sk) {
 			if (tcp_child_process(sk, nsk, skb))
-- 
2.37.3


