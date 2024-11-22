Return-Path: <netdev+bounces-146808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E229D5FA2
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 14:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BABB280F0A
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 13:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F11D2F78;
	Fri, 22 Nov 2024 13:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76C1DA5E;
	Fri, 22 Nov 2024 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281496; cv=none; b=myenhFC6e/UHge6MB1epEnUMLq+enYbO4lcNLxaPGTYdigKuztIUD5jChORe/74EM2apXYKZRzPFbNIi/HnFNZPPm7i8imkvZIvqGUa603SUAbHo79dEu3CpgyrkVE4aq60djArnT9e12qRaAd4EVDLIrwx2k1z47qaerD2b+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281496; c=relaxed/simple;
	bh=DxqIwq+oH+nqBU2D8yq0+FmSGijDfRxecy7jjo+U+N0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NmY8FPFVsakZi0704l50Oqx51eOkce9v1AAT9tGE3N39deBo1ZnAevynrSnsiPbrb6S1BAOOeKsmCEkh9YNHiKy2Prd/lg8gpTXoMKVmjIXfUhgi+M3b3PEjxqyKpctgMOJZ70rSQSwgQrLjTz4kDeqMB2QDciKVQxjFiN9wVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so318292266b.3;
        Fri, 22 Nov 2024 05:18:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732281493; x=1732886293;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAZYwxgHeVKWNocgR47McD1Rtpx8EWp9K1q1L1dVtWg=;
        b=iS0Sso9RPSP7O3e0Pgq3hg3VnSCklPYmf7J2bGNgslLbeRXonc1hsYCpC9tXDV3bTj
         HSnYg1hvq/lw2nFW5rlAHzO2HXivd9BEhkm+0YmXz/mNHFFZAaeYNplC5adEEfvBiYCf
         U6yp4H6vn4WInaT5X/986jq79KKu4MDNtbYV5ysgz2DjQx9VrgpJbfuLMIM1wlQvfHwm
         PuTYDpXQR/nimAXN0ceRE8JSgG1PUJcy4vjV/w9S1EvOL2C8/E6/Pn4u/KLnsv8mTU24
         yUPCVd59HpQfh9tcStGRQ0s/M0oEk2juL5Y5MY2ZqvbfIC5WCShNKbjW5+8ZY1uvASwW
         iVkA==
X-Forwarded-Encrypted: i=1; AJvYcCXDGtib2HpzZUtYeAkc/Y3QziGAzUiWUI7S+1ITHVhlIwrxgEz6xv6ZWIo9gn0s8Ite0KkVuw6sXsMFmDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1nQ3QwNLmMIxKRdgGY/oeXYOjEYIWQdkUrKcAMBYXjGt2AEy
	lEz4L6Wns/veHB4/1AIivaxjyY5PhKx030nPMNYQwjcHIqUXIrFn
X-Gm-Gg: ASbGnctubyhod/NjXb3ZyWge2VdxQIMDqiF6qyITy9VExyqHJ7ihYlZhdGEQEpSD6aI
	c5sflLVElX5XCu9gEC4gcenRHDkl6NWgUj1YYJLzh6O1gZ6iLvdYH0daVnqamHNwFxDyOShiOSR
	ww3HDFUrmCGhR4ZV4LxOD5KrzTogICDzitvU5YsI2Ff7yQX0P8mEP35NbhxpA4r+wCFGoM2ijNs
	XfaBJofsya6kxV/DebhAYlZNfrNgSY08gB5w0ylnHclTVkfFNAX7elsbhBnyd7lQ5/3QVyPBcYF
	fGc=
X-Google-Smtp-Source: AGHT+IGr/mwcyaSVyMhF5CXX0KUmlXvuvpsTk0qiOuWn+/2+2XGp5LLmSgx9yLQFJNaxJbThv/FLew==
X-Received: by 2002:a17:907:6e8b:b0:a9e:c947:8c5e with SMTP id a640c23a62f3a-aa509d7c76fmr286813066b.57.1732281492697;
        Fri, 22 Nov 2024 05:18:12 -0800 (PST)
Received: from localhost (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2f50c2sm99795566b.69.2024.11.22.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:18:12 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 22 Nov 2024 05:17:57 -0800
Subject: [PATCH net-next v2] netpoll: Use rtnl_dereference() for npinfo
 pointer access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-netpoll_rcu_herbet_fix-v2-1-93a41fdbb19a@debian.org>
X-B4-Tracking: v=1; b=H4sIAIWEQGcC/4XNQQqDMBBA0auEWZtiYqytq96jiKiZ6IAkMknFI
 t69kAt0/eH9EyIyYYRWnMC4U6TgoRW6EDAtg59RkoVWgC61UUor6TFtYV17nj79gjxi6h0dsnL
 lYKpqbB73EgoBG6OjI8Nv8JikxyNBVwhYKKbA33zcVe7/8F1JJU3dTLVDfFpnXxZHGvwt8Azdd
 V0/NXjpk8cAAAA=
X-Change-ID: 20241121-netpoll_rcu_herbet_fix-3f0a433b7860
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michal Kubiak <michal.kubiak@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Herbert Xu <herbert@gondor.apana.org.au>, 
 Breno Leitao <leitao@debian.org>, Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=leitao@debian.org;
 h=from:subject:message-id; bh=DxqIwq+oH+nqBU2D8yq0+FmSGijDfRxecy7jjo+U+N0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnQIST8mB6pc51x0KHFDrpsBKZHewPXGMwPR59A
 WVFvNIPw5eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ0CEkwAKCRA1o5Of/Hh3
 bQr2D/oD6CKBniG5sXPfD7ZiLPtu7i2TnlAbqO0LHKzqd8TUhbPVneBOJMHJYrU5GoZwCRnmPzv
 /Fa+ZERjSu369/uoktR4/j1a0gFCDgp22tWiZYFzll+fY6GxQHkpfcXS8vcS0D0VsuGOu+teDYM
 7eJqTbUJI0/35606Oo5xUqTSl6ZlmgqP1Dvvpd+0pUZkO7Aso/nFOMAMCMikcZ7Jr2V618SWN2S
 1HXx4NLDn8RMB+NWrGai6DO9F34SNm6rq2Ht0qvYZJSifr2Ue9a81Kyz4rwJon86TVOZ+/GAHhy
 KDin1ABFklI5JQbXuZdPSqZWHnkw8pTHalXPgQfBQNXdSYIe0WfXqQe5cjy9dbVS/c30Em0C/f3
 wmDiwGYfctUAKvr5YgBrRG1+GC430LRoXjkKLMwqk2iWnt2Ahi9kNFj9jjjru1ThPnDgpMzV0Ck
 6MBrbNeypap5dJmpumdlW/Ihto22KOmpCC+5r+mf7w2OvLd7Kx67SeykVyBZ0z0UE1ZYkW4VmLs
 tmWTSQShFLmaMQ0ZZhCbHK/tmTuvxEslZv13I/rIDDsoOfJ63WYVL2/WEPo6qzWTZ4FoNwr5bss
 xTjwU1lgfuKJ5DA0SBLxbw65yBzTxGlLo4cblUhWb+eACpD43+ZpacgccvvfthJ8hXo3qQXeDSj
 wWB88X+LgF2Nr8A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

In the __netpoll_setup() function, when accessing the device's npinfo
pointer, replace rcu_access_pointer() with rtnl_dereference(). This
change is more appropriate, as suggested by Herbert Xu[1].

The function is called with the RTNL mutex held, and the pointer is
being dereferenced later, so, dereference earlier and just reuse the
pointer for the if/else.

The replacement ensures correct pointer access while maintaining
the existing locking and RCU semantics of the netpoll subsystem.

Link: https://lore.kernel.org/lkml/Zz1cKZYt1e7elibV@gondor.apana.org.au/ [1]
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
Changes in v2:
- Targeting net-next instead of net
- Added the Acked-by and Reviewed-by
- Added the link in the commit summary
- Link to v1: https://lore.kernel.org/r/20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org
---
 net/core/netpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 45fb60bc4803958eb07d4038028269fc0c19622e..30152811e0903a369ccca30500e11e696be158fd 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,7 +626,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!rcu_access_pointer(ndev->npinfo)) {
+	npinfo = rtnl_dereference(ndev->npinfo);
+	if (!npinfo) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;
@@ -646,7 +647,6 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 				goto free_npinfo;
 		}
 	} else {
-		npinfo = rtnl_dereference(ndev->npinfo);
 		refcount_inc(&npinfo->refcnt);
 	}
 

---
base-commit: 66418447d27b7f4c027587582a133dd0bc0a663b
change-id: 20241121-netpoll_rcu_herbet_fix-3f0a433b7860

Best regards,
-- 
Breno Leitao <leitao@debian.org>


