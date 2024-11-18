Return-Path: <netdev+bounces-145802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DA19D0F68
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E928151B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36007194A63;
	Mon, 18 Nov 2024 11:15:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C019883C;
	Mon, 18 Nov 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928532; cv=none; b=LMlrxOr8zXtY6Er85Z/TqAidlyi2WE7C24MRyJ3S9qpDjRAp7gpjcTigqCLFelLSYEPVd/vKK9YS+ZKck450V85VO4ST2t5fUuawr1RKu49IL5ydREEiYIbgJew4h1sufUjok8K20LxiuDYtOZToTOn/bufkrJ+0XHNXF+DWhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928532; c=relaxed/simple;
	bh=jNsLMGobQevrogIk04wHrOqqXljj734U/1qK3g+NLEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QiKo7CeuGEtKLV6jDjJo1+R6g3Cbwc6uO5c/CmA66EbwP+4aK9B0OrBwdm75OOU5RXKLFcTzLYhbju23inDIzlDt05ye9MF/i0wEGqrvc9R/eR7NrTCZK+NDo8a0ERmcYnfYez6vfihyiqQJyK4ONZ+IThq06SJXEa3EYtN215I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53da353eb2eso2406752e87.3;
        Mon, 18 Nov 2024 03:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928528; x=1732533328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYNQOUHaLoGGDTgK+d85aIvTAPV1PsbIBUKLL0iAuzA=;
        b=oMvVyewIVrmlf+suAL9CKcmKkh8BXvSM7FATU39BZa1q1HcHoU/owvUl/6phvQqREz
         QsbCGNKpvJnMERLPMUIHXezd7gMGjaXJuwPULusZpE5hsoDfsr/WvL2NsMOK9BPpldn/
         nwqvnnuvPNUtEwF+Uag/3ThgOE4FkKm2kS5wlv99PyNY9/aW/rTn0UXrg9XupbUiOL7n
         xlM9sx/Hvyowz02fTyhxF+3i+UT05b9OMPDoXE77/dJXpsvvaXJIQqMhBoSb7QprC0fS
         nzUjhMbiRjtOTxxysRinkbNdckUlgDiG5b/+vwqqPmtq1yDORUVXDhP/tb1BlQw+VkPw
         N8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVGhFPUH4WOAfHsbNWbN6IBRDKkvmVHijdvKMk9qrftrZMxfWxXq8SFcBCJZEFGU7dizxhOcL9CFZNttlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO8f2fEaDtWptvesUaCHTt537FMmOezZLxIM68Wc0nz4kHO1Xc
	dqXOlxWuR6Dk1m0pg0W9wHQgQFgmkqTyhxGMnu3Vaz/MGUJ0a+53QgUgdg==
X-Google-Smtp-Source: AGHT+IGOCnMGMQBO/OIYbCwLEh2a6L9UjxxaAI+Br6/K9J5lua3Oko5YEGdX8NkbWrAFC8wEoIx2Mg==
X-Received: by 2002:a05:6512:3e29:b0:53d:a86e:4200 with SMTP id 2adb3069b0e04-53dab2a634emr6422698e87.21.1731928527836;
        Mon, 18 Nov 2024 03:15:27 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df26c84sm530075566b.35.2024.11.18.03.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 03:15:27 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 18 Nov 2024 03:15:17 -0800
Subject: [PATCH net 1/2] netpoll: Use rcu_access_pointer() in
 __netpoll_setup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-netpoll_rcu-v1-1-a1888dcb4a02@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=leitao@debian.org;
 h=from:subject:message-id; bh=jNsLMGobQevrogIk04wHrOqqXljj734U/1qK3g+NLEc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnOyHMWilra8auAUEEo3NWZFkzLTM0n7FpaSkP/
 LtYioZp9LCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZzshzAAKCRA1o5Of/Hh3
 bXALD/94D1ThBLTcl+Chy4kO6shM14UmOqPmDNQMkP4n7ZVQtjZevVPkALImr3KcYVQ1WFMvBEU
 LqAA6NXOjtHz6TqgyzFIZQaD8BfkPfWVB82yfatJ7UEekTBeU3YxYTJBal3kX73tzjQxswyPRER
 CtsDUkzuyA4JIf/oMavgoSlDSfeywJCfWEwGzj7qIj6I4QzXR5MpQYMVbPxONAIGCp0CjtOQ3Ll
 D7p8otN4ePnVg8sgFs0twHMXfTG1XwaVno+lPm+g3LCE4WncoDRlUsjw6kwEaagwQDRqbh+ha6N
 qOasHFgnAxenGmffttrDgttIRhlqZkmgc7o4vzks1ZVnMEQlxguTnZH3RS+ii6PxPWn6NXcDzJy
 WRyj/xi2oiI0yg2T6olNZLK0yudOGvOAZuMb7JtpkIRBkqwnApsHS79JLNGmxK9jroEKYly+B0v
 4URhXbumrQ3/3GSamr+v/TSxzgLv0qjkYcEPMhBcEuVOkKvHAp6K7lNd4r2Cr8shIip9UT8KTig
 dTjOBCoMTVgP/eD2Hk9cFH4b0e0eTcROxfAO/C1f+mwOjgUPtfczK4NMZ9xgfQBj+i/CX/lyIP6
 e6HXxffhWyTtALoy8j7scQ8G6joktYex8Vhcdj2XZiIm6fHowy4fda6MSQuiYnxmtglizbKjGNZ
 TP0oeKl3BKx5inA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The ndev->npinfo pointer in __netpoll_setup() is RCU-protected but is being
accessed directly for a NULL check. While no RCU read lock is held in this
context, we should still use proper RCU primitives for consistency and
correctness.

Replace the direct NULL check with rcu_access_pointer(), which is the
appropriate primitive when only checking for NULL without dereferencing
the pointer. This function provides the necessary ordering guarantees
without requiring RCU read-side protection.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: 8fdd95ec162a ("netpoll: Allow netpoll_setup/cleanup recursion")
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index aa49b92e9194babab17b2e039daf092a524c5b88..45fb60bc4803958eb07d4038028269fc0c19622e 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,7 +626,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		goto out;
 	}
 
-	if (!ndev->npinfo) {
+	if (!rcu_access_pointer(ndev->npinfo)) {
 		npinfo = kmalloc(sizeof(*npinfo), GFP_KERNEL);
 		if (!npinfo) {
 			err = -ENOMEM;

-- 
2.43.5


