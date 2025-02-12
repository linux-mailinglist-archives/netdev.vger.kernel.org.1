Return-Path: <netdev+bounces-165628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B8A32DD6
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D85F3A267A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16925D553;
	Wed, 12 Feb 2025 17:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF025C6E2;
	Wed, 12 Feb 2025 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382464; cv=none; b=tOeTwc27QAN40VjdSxneD2qEBvIJYgFCepP42SZsIC648uCq8lGPvhw05GOPAalOUjg+F6CuZGQLdurxuYUfM5CTgtYF6XHkiC283LfwYBC0tGnp80LMfC6KxHuzb97T8kna4xLmCysjAKrwxybmT02nujyzSjIJMkk2wHz8k3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382464; c=relaxed/simple;
	bh=TeA4rNuL5OilOfZvcur4gi/G5KqrL8dSVvG7Yj3C6lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pb3n5GACzhDYROyLmNNCckzAFkNMBuJNZvqXxSTzSAYQ6KL4vccLaDrM61Qgf5Yh+TBEOxWHratBDUcTp0otAl3Vy0DrwHc2y3VOHfeFjEuvvQ23K8sZaGjCiEqXrNfOFmfxXlcrg2puJEzazjf+tOQnU4NB85LWHOSh1Iq+buA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de3c29e9b3so10261718a12.3;
        Wed, 12 Feb 2025 09:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382460; x=1739987260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PlI7Euhz3cVYOptWlk1i3+8t3ZB9LyqCsQJyf6fbRE=;
        b=LwOppqdneMGIsh9v//xK7Q+TDJdaWagsMrliiFxL8ZdOHmVjcF/dB4hpHbk/IH0n08
         8eBMv/YjT0Cdbyd8T16WXlpZRZYBkJ9Tkps3nCDOziIMUksmRLJb0aOqz2tF955zbr4q
         gqgX0gnzPrnlvWzQK8mpa+7yp3CgOmTFfJz8Xe8pP7wlzmNHYYXHjKfY3wC2XHe8eNMN
         ZtBVzUv2jxiI5dnCH+BwMyZqxT2dGkAWuByeU9nFqbukpvAdFb3HnfD1LlfDrPDbtAeB
         C/TfM9wqxu5/P4cwhiCGteSCSFdXYXFYCkf8gWLz2YXWXdODWlibKUtJL/Y+pkgiJLh9
         tqPw==
X-Forwarded-Encrypted: i=1; AJvYcCWpMIchfDn+zevm4Fsh6LHK0woEhcWEwCtjNxIu5/NV+FuoMW0elfFfYhSCDlIRw41SZcA6los=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXP1Y/ctWpOjIRmY0Sh2giW4TXF4ZeaYlca1awHNBEH0LM01Ue
	yz5tSl7pTHOUOLKLl7M5d+8/nWD/zVuMfRIcP7XYhGOIzA5ZTNxdYGAPWg==
X-Gm-Gg: ASbGnctYu3lGHPVHPAYuFLKid14PcoDd7YzRNoTtN2Bf/zFIc/Pa2YRg6XoxZlYAZX8
	J+DHjMtfGmmBoWWkrn9AdYnXsD28adHntfMvg8CbjDLx7J+fsLm5KPr6/e/qnsIIBNSiUEOwAuP
	I9U6IVmpQXoNfjsfq41BoWIJAsfdjctpKDqAwmt7VjhsumwbICcpzNDIzKrTNxdcSLHkYG5ecbg
	bYdSL2RM4p1GwOffEESuTXnJnDehN6W0K5febicYP7lcImLDBfocCvlUTOxTqgn/4cT3Qk9rMzP
	M4zSCA==
X-Google-Smtp-Source: AGHT+IFQ6AXnCUzQg+LgZ3Efwdyng6Ds2X9cEWDrALy2Ek+L2XpuZ/lsaMLczjpCTWPastKX78OrHg==
X-Received: by 2002:a17:906:fe02:b0:aa6:84c3:70e2 with SMTP id a640c23a62f3a-aba4ebbcdc5mr4066566b.20.1739382459695;
        Wed, 12 Feb 2025 09:47:39 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b32a8953sm794068566b.97.2025.02.12.09.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:47:39 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Feb 2025 09:47:24 -0800
Subject: [PATCH net-next v3 1/3] net: document return value of
 dev_getbyhwaddr_rcu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm_fix_selftest-v3-1-72596cb77e44@debian.org>
References: <20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org>
In-Reply-To: <20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kuniyu@amazon.co.jp, 
 ushankar@purestorage.com, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=leitao@debian.org;
 h=from:subject:message-id; bh=TeA4rNuL5OilOfZvcur4gi/G5KqrL8dSVvG7Yj3C6lo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrN64uIDIAhvtuQXtaG22KtbAaQbnZ2sNS0y8W
 xA7EXf4sS6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6zeuAAKCRA1o5Of/Hh3
 bVfDD/9r3XSIuSjHh5TI1VxCYT8uN8LZxD3WwQxKy5zUfnU45UmhS8EdTey0LWlMJy4/c3k3qGk
 aiZYPWGtAM3j8WA7B56kEqAzPHTtLsbGnnqe/ygPWe0fM4ZHmHd6x0+kjN7XkhTIl/43nS8U23+
 uDWxpx7p3w+ZHuNgZ+iiElquV3ouba2u3Nn4KsW3qAOpTsVJZNbRQk5FaPMKOD18aA5qTq48a0c
 kxMt6RfD2eveMQdeeqYqHkp/QjHFk/kCfkO4tP3ABcz39QTk/j9WrRGolGnVeqy9V63Hv/jyT5m
 eT8iaDbd0ES7M1G4eXwC84re0krWbK0bcpNgb1DEMd5RT0kj3LWbNtnGlYEQqZI5m8uWYcPk9dS
 Nf2C/FeMg5+ZjJHAmgXjSlqoMIdhKHbfYy5WqQ0npnwapkTcvvvtCiKIwC2Pel7MGmAcqfWNoRZ
 baNqZQAyFAcHzSdo+YymTQZFLAs0NcTUmaWFqIhmzbkf8f9fhfsCN0V2Gy4DhWTV5YwQPRzvGvA
 MPhaGjCAqAFnDWS/RSkem7AnUsKcBIIBrPtQpn0F3IVnZ+pSjFy9WR4AQXJdsaSuPYpXPVa2ty1
 RxFccu9iQ7XcYFkYEgwsmOwvqlRcXBC9B5un+Nw/Ku7z/utBlpWsOocQtMTtrJ/0NPcFpEOXVJ3
 A3YuiZWbtPfCb1g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add missing return value documentation in the kernel-doc comment for
dev_getbyhwaddr_rcu(), clarifying that it returns either a pointer to
net_device or NULL if no matching device is found.

This fix a warning found in NIPA[1]:

	net/core/dev.c:1141: warning: No description found for return value of 'dev_getbyhwaddr_rcu'

Link: https://netdev.bots.linux.dev/static/nipa/931564/13964899/kdoc/summary [1]
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..0b3480a125fcaa6f036ddf219c29fa362ea0cb29 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1134,8 +1134,8 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
+ *	Return: pointer to the net_device, or NULL if not found
  */
-
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *ha)
 {

-- 
2.43.5


