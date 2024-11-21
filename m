Return-Path: <netdev+bounces-146682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37B9D4F51
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF9C1F212F2
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A031DAC95;
	Thu, 21 Nov 2024 14:59:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12F1D47A3;
	Thu, 21 Nov 2024 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201145; cv=none; b=PDvRs4Sv205+Ue/QKKgsqmicnQRB/1mARJE/i3n6pDizqzmUEI64bKItmrqvZgUmY2cnQ5dUvq982jdPu3ljsBgaOs9qFk2P+NNaB+gev2h9aFZpLR+IiJplrPx5CO3zNXZKMfyl9e0F5bLnIaj15Bb6yKjibhwR3SECXNVPSQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201145; c=relaxed/simple;
	bh=4Ti8G1SA/x6VmROm/Eqi+j3OT/kIiBi+z8sE2UMstog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bQIgsV3H1XZSoXwFUc9hYyhs9SWrEjxYV9IySnHCn1wrkTl071g43rB3S/TN235BVtUGtXvvdyHwqnRriXZS4EqrxUKhvV7uTgNLLH4o1D2/3DTOwvV7HIxwLQzA+DUOTwR/fDsudN6DFzBoaAlMbqNR0JhaYfOAtF87Gz9ub4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfaa02c716so1323164a12.3;
        Thu, 21 Nov 2024 06:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201142; x=1732805942;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i84h9mgk6Jv407onloQl82GqJW32gNnikA0kRTDO5eY=;
        b=bbbi/WqEhs6y9VcvosExUq1O69xGvN/yzxeG/jgzcGvfcATtNJ25eK8nPKN7giWTtq
         3WoemT/dkbGx3TyWnMNik45PNPpXtbowI418uxDS4SzKn8hHAY2GUY//7KyHpfzw0py0
         5IZG7FO4zfPcVy6TiI1leLElpHmvOuQE7nhrGGXcrEEiX2ceNkl/p6eZken5eNVH6UpK
         vynVWlm61zEYLwqLTHK5MQqvSXw/x4hbSk+ZlsRdqSXAJM+rWBSvPYpR9no1VOBcD6bh
         PhOFFoouy8lUJISkM8TeWrskQyMgd7DnpSvSyQvTuw7vRnroXVVq30SHf+3E0UgQ20jW
         dEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVej5Lbb6oIOI/NoYSNDaWEvBioNpsqzB0HJRHLT7Wrpae0VLXHLfb1LvEokhlTygHywMfLp/XwhryOE7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi+LDtvQGEMsfQf18bOo0fh1UC/mISq06jM8Azk3ysa5n8W0Hw
	fnor7uYZwUadMkRPDC8yAfQ0RA6ItiBiEkXNBe37nD8ZTfc6QziT
X-Gm-Gg: ASbGncuE67AxlSJSmch+ttgoJCNlP5Gxs71Z572QXi3nZuxvHxJKh/TlHwRCuGd2vDN
	HpAaOKTmj+vFbpnH0l4UOJr3gVGGF89u7YnBsnG3DBPfCyKGB55yrcvhbABtyZUCIXlB5kuWEk0
	JT1zNAKUblkrBODh6fONq7F1ICApt+Vz1vBPti/Hmtr/2AzYE+4X2e2STANB14V1tiLSfdp7pI4
	QACy/+RoV9EgK+1HM5EEaFbfmoCRgGjeqbrD1Kedkxz9aNgD6QsmwSgkvX9i7ZwFn6XO36EcZ8L
	Xw==
X-Google-Smtp-Source: AGHT+IEShlqnNY5FVfhffJw/uhzvhWwUhEEXQ0aKF3hY/xvTW90Me6YP/foLQy0uC9CE38MS8ka1Iw==
X-Received: by 2002:a17:906:eec9:b0:aa1:f73b:be43 with SMTP id a640c23a62f3a-aa4dd57c3d6mr604475466b.32.1732201141718;
        Thu, 21 Nov 2024 06:59:01 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f418018csm90855766b.62.2024.11.21.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 06:59:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 21 Nov 2024 06:58:58 -0800
Subject: [PATCH net] netpoll: Use rtnl_dereference() for npinfo pointer
 access
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
X-B4-Tracking: v=1; b=H4sIALJKP2cC/x3MWwqDMBAF0K0M99tAHtKWbKWUoHZSByTKJBZB3
 HuhZwHnRGUVroh0QvkrVdaCSK4jTPNQPmzkjUjw1vfOeWcKt21dlqTTnmbWkVvKcpiQ7dCHMN4
 fN4uOsClnOf7xE4UbXtf1A1zdZEhtAAAA
X-Change-ID: 20241121-netpoll_rcu_herbet_fix-3f0a433b7860
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Michal Kubiak <michal.kubiak@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Herbert Xu <herbert@gondor.apana.org.au>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1673; i=leitao@debian.org;
 h=from:subject:message-id; bh=4Ti8G1SA/x6VmROm/Eqi+j3OT/kIiBi+z8sE2UMstog=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnP0q0rCJDyc2+J04wAirfAEZ7EnhcHNuByBGNG
 iaVT56lJiOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZz9KtAAKCRA1o5Of/Hh3
 bSJwEACSC+5nfj70NnIaTRlIaTq8YGHq8fW3x5nXbsAQ5PG8VwMDHmDEXLeZ1UKoodZHzE55Rjd
 cvcDGLNeo3SSh/WXKeR9ZfPGCxp95AaPIRro9pLRUffDtnVPi0N5PLafyKVAOL2ej2Ut7KAm3C/
 bN6PhpHpNGJf3oEoO9j/v3h9zD0HG7LfUwiJSydvOcwg/jfT4fLULcFXhoyhyBD28abKbcXVys/
 yYIqGwExSb1G44DN598Ax4jdUbhOFBFxlqZACG/7smcUpeXu4BUyNPR5j3O+T7glvrKjXXsv5DE
 L1wsDdInmJdD6hqRaNmBWuRw3bwDa9X8TIlpFIbY1bQ8mmP+oUkkZh310LoPDJ67rWCbZDkAB/q
 IBYn86dUSx5b17FMYBupaun04mWPLr8uElkzsNgFwhhojFWRdpNwRgX+v+U+E0McOmIJy3S6Iip
 lkj0E5kUzIkVTXwAWUWhZO6FRnaOA0R3I3drQxxsGVILIZmc8ubDbbvIl6FMT48GlkiwY3Wux24
 9EwVWUtJpfrFiQAcTavSCt1wOp6a4iIy5x6lucEb+dGg+0tI/4iQjrw6s7U0n/LLvFy9d/mrkwW
 m0bJrCtVZqwbxdHmquh/tMrC1H2Vsnlb7bIWpfjGevn0nSdwzLiJOXIBDcupyg6j2wEEu9rGZSr
 8lTVf40nrm2KJ9g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

In the __netpoll_setup() function, when accessing the device's npinfo
pointer, replace rcu_access_pointer() with rtnl_dereference(). This
change is more appropriate, as suggested by Herbert Xu.

The function is called with the RTNL mutex held, and the pointer is
being dereferenced later, so, dereference earlier and just reuse the
pointer for the if/else.

The replacement ensures correct pointer access while maintaining
the existing locking and RCU semantics of the netpoll subsystem.

Fixes: c75964e40e69 ("netpoll: Use rtnl_dereference() for npinfo pointer access")
Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Breno Leitao <leitao@debian.org>
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


