Return-Path: <netdev+bounces-145803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BA69D0FBA
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C7BB2C27B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEF8199E84;
	Mon, 18 Nov 2024 11:15:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF4F1991B4;
	Mon, 18 Nov 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928533; cv=none; b=ohjUqsPM6X6kX28WY7BSiftNmj7/kqIq7Ta5saSk+k/lPVg9A/TT04l+Kr2HqUnPgusd77VDxSHCc+81n8MhJ/11ea0enPeoXNaqR+wY91uh201pF3fFhK1lSifUKbo3RV/5H3jUbGeEw/Gm3E/cD9V2y9BF1f2irUeF+dEIzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928533; c=relaxed/simple;
	bh=hUbpOBQHTbtfdvzsAVtzCs3iUvadK6+usE3uQvkGxv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lw6l7I/EHnMO5hVctNU/GCTcVXLAx5lgkqbDBCJ66GA0fOSj1QYZ1L3d14EI4iN/viHpS+DctcYNiIdqVFE+2x0M3j6SULbr2JOmLQ/CZm7DQ/+7bEMPeb/m4UqQS8+jZe7Fh8taWDbnL45Gz3cqlicD0RHCTVtgZP3rotD7ZbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so5039774a12.3;
        Mon, 18 Nov 2024 03:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928530; x=1732533330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3C9Cy2PwedyMGVk1Gq1bLlgXzPcOJtWC+YvaIz1Ms8=;
        b=u5bZI/so4vs+cYrhyAoXLeRMn/ul/LLtWdq2aGnUVb+LQq6uf+WA9C5s6WYnkzqdg/
         wnRPT9nV4hI+ybc8HLLYaPGmjBgkxw1GwqIJlNdu9Lal19iSH/Em/C2cRE7TvvK+A5OF
         +Yd6h1kfZQNW9LNhdB7XNt14YFqx64Zbyg864OZAbLfll4nFjb7eApk7h/T/kd5/CIi9
         CKVLxc2NkIdz9OZQAMlKR8XNSTlrncu2WKqr+xFkv2odKHzFSuU9LYw6J3NAhOM6/LiS
         GC8H8zqqNCC6sJMzMV/2CRl2MQMnM+8HtgvvsBlhHX+2rqsaIRXeQCUlXsoXvsRv9ufA
         PIjw==
X-Forwarded-Encrypted: i=1; AJvYcCVFeEskmRJi/fg7XF+HlKkOQNHHgQto7AdxtNDJHSn96PNrXVD4wVFA9c+ng8JarB9ymiD9ghMxinI3AhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEnaZQy3hndDyP0ACAKVmMcGm74MXVXYUVykdB/a+4YjidMrPt
	4lvPv/zSnzqE0Oer4jGBTWgNHfeZDWgm75XsjO/5OA+6WksONe/JQnKAAw==
X-Google-Smtp-Source: AGHT+IHhuT4e7nJTiIMuLfo2GRFHi1xzjE+zELwDWhWuKtbRoqVQJmGQ2pY2YOXBt8oeBKlouvlEdQ==
X-Received: by 2002:a05:6402:5216:b0:5cf:ca7d:1749 with SMTP id 4fb4d7f45d1cf-5cfca7d1997mr2680176a12.7.1731928530058;
        Mon, 18 Nov 2024 03:15:30 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c0ac9asm4635073a12.54.2024.11.18.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:15:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 18 Nov 2024 03:15:18 -0800
Subject: [PATCH net 2/2] netpoll: Use rcu_access_pointer() in
 netpoll_poll_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-netpoll_rcu-v1-2-a1888dcb4a02@debian.org>
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
In-Reply-To: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, paulmck@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=leitao@debian.org;
 h=from:subject:message-id; bh=hUbpOBQHTbtfdvzsAVtzCs3iUvadK6+usE3uQvkGxv8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnOyHMlCafKKthXqBntVibaGf1uz4y/4D80gRH3
 k37dRLf9O+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzshzAAKCRA1o5Of/Hh3
 bbYFD/0Vo+BPaX6InTTjgGQyg4mGLnf2pl48EkWZC9mU8JH2LdbvETj2gQK6+CB8ZVEcW4ceZwz
 18QegFwVo8QXRehEpzeyPtxKXAVHER9RcFQxegc51OQUzCH0jzf+eWCDABB8buFuhPMW++LMRzQ
 405n5zdzjgtD/bF8llyQPdiM30+CIwb74TMh3XRyCm+avodYFxmvH1u0EYDWfJncaq2yvxdGTk0
 BtjCw6i72FUN9zaWqIPA3971ncQlKosD7xM38TolxJMUw4fDJzbcNuXBlIUehrasvoGqJ1ZQH1p
 YWXRY+4Ka1Ep8korWvfS3DQRhAFUzrpEZEICuCcAs6huna7zCXxWp1F9uEEBlBpYsUJn/iLpYSu
 BoWz+ed+FdGyZ39Xsj4aTGW11/AyszbqNbtvsCOsrWnq2eVkSCpm884nAXS9pjomYzgA4xLM0Gi
 0HjSFTtfd/ewY3sjd4ZE4X86OT39qVsPvD26K583vPbu6d7shkO00zaB/hijDemQr8CM8K4IX6S
 nQM1Zli76fcoD3JKwPVgTcg48bah7SsDQeX/2b2478MdtAn/SYt30BjtEaRUuAINpMw66Vf3YNm
 WaigrwgiEN8oNrsRLQ2XR4KK+zkdY61UZ9T63U0AaFikJ9QObWqVAFlyRt/94sd2B5P1qsgfNUU
 pRJ3nny3cSPRgXQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The ndev->npinfo pointer in netpoll_poll_lock() is RCU-protected but is
being accessed directly for a NULL check. While no RCU read lock is held
in this context, we should still use proper RCU primitives for
consistency and correctness.

Replace the direct NULL check with rcu_access_pointer(), which is the
appropriate primitive when only checking for NULL without dereferencing
the pointer. This function provides the necessary ordering guarantees
without requiring RCU read-side protection.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")
---
 include/linux/netpoll.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index cd4e28db0cbd77572a579aff2067b5864d1a904a..959a4daacea1f2f76536e309d198bc14407942a4 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -72,7 +72,7 @@ static inline void *netpoll_poll_lock(struct napi_struct *napi)
 {
 	struct net_device *dev = napi->dev;
 
-	if (dev && dev->npinfo) {
+	if (dev && rcu_access_pointer(dev->npinfo)) {
 		int owner = smp_processor_id();
 
 		while (cmpxchg(&napi->poll_owner, -1, owner) != -1)

-- 
2.43.5


