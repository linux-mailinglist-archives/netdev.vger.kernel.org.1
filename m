Return-Path: <netdev+bounces-236801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18579C403E9
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 15:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE493AEEDC
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD54B325713;
	Fri,  7 Nov 2025 14:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA62230101E
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524248; cv=none; b=ZjN2jD1/LnS9oNVQSDARCqCnEft3hPW3+emfdUIiUBxPCqaXBi0X8DkKcQcJ06B7VbgV8GgkYpF+2SStCe9uACQXouWsuTyu9q94f4BYwM/QJJsuJwF11lSFUp+yHE5EwmAad50UOQtRxVKjPG2DAjw3xyepttRE0N0/RM73+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524248; c=relaxed/simple;
	bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bk7MWRdBiWNla0dhG7sI+ymkXY+lmCV6wjSAmR+nL8frlWHJrzarRMPaHxUvwJU9Y+Sjm5Y6TyHYfABRTscjVTAQS6sFLLaKWQJrgJlGm6ckXykK3RLmULAcnnYkCh+XyuhdYjhB2pYpD3EmJ9yHcb/4Wc5Xs20WJTnlGH8RGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso1491876a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 06:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524245; x=1763129045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjGKFyPmmnOORJmfJYb79vkMgO3eaKsfbWlFTGwHffE=;
        b=j2K+zJvg349QexR1Mk2sx1cJwnx89RRbxfyS1ZoFMNcGDRTQ8/vyQlB/7sf+gU9MHZ
         ZUPC8gUXu1Bh6cIW4h4XCrV2AsZi49rrFlkxR8gJqisNHujR5RuJmz0scZ1kvE6vicJC
         iEz/PaziGYARr+oU8Mo1dObtF6M0JA5S1t42kqo9wp7cPnEr3V3hn4IGedixoxiXm/7T
         6kSQE6U1OLPwk0qg1HqBQMwTP2LQ8pbmxdcLMdy6S/U7JI+7ULUhTJUlcFT05cz9dU8h
         rKxsTkSGaomdEXV34otMDSmay2xXf3RtcsVIeXR8ckkcCoIOtvmLYM+isgPomaeXa4D9
         4D/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU0uY0GOfMXnU0nL7HcGZz55u27Gisvr7160g8c5oKMEe9ghLh2mmjR5s2AyYOYF4Q69JhqcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOe2lfeunkRDzDPy49lP43oMlFbhWnXBvxO/HLvQwHPIhwGCH
	priP8zRJZCV7qoWO3WjG8EmXSDcq0L3OLw2MSsd5WVmdgAYL5mXX7IuA
X-Gm-Gg: ASbGnctnPIIpn0A5M/KNllK5EojGmIigQNtLL6WjGaIDT0k+RDPRs+W0MsKV2jtO2+v
	TE8SWYRM/7iYyFXLFG6PWE+60/tp4cCWPJR3Y2rGGYhIYIGvuGUSGH/Wzf4+fn6w8q4+UP/wTSH
	9r1NI7yo+zBtsKGQAbVQj48oCfosh/zFBvsx7kzZMNF3BhOj8EIXUCJMCWOdngUKVTiywF5vRW6
	lhrC/rpQMeBnohrF4LYaVlwJdIceT8EZalSvSmPEHsJ/8pd6wvY/gMV3/Wjb/qZPa/SKvTQTSKp
	DD4WCMSBHYTWAahxfAMLNv9njjnz/3qddf9JAFarZ0e4vnwz8orYvfPy5z8Fyqr+S9mxm9DXd8n
	iINQ8dxJyDP2PiHc+i24PdBf4ciXWnvuaO/0LPrqRpNKFKOiQxTgfmD/sUPXqDVukEvqKXY8VCP
	iPyg==
X-Google-Smtp-Source: AGHT+IF0zw7XdYz7vcM3phUQMOrnFBlIHOTr9IuGmwv7KNhzEHTNvBcJ4yY+AVdmmb4MZwhkXftiaQ==
X-Received: by 2002:a05:6402:5112:b0:641:3d64:b120 with SMTP id 4fb4d7f45d1cf-6413ef4f894mr3089941a12.18.1762524244877;
        Fri, 07 Nov 2025 06:04:04 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8578ecsm4116404a12.19.2025.11.07.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:04:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Nov 2025 06:03:37 -0800
Subject: [PATCH net v10 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-netconsole_torture-v10-1-749227b55f63@debian.org>
References: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
In-Reply-To: <20251107-netconsole_torture-v10-0-749227b55f63@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 calvin@wbinvd.org, kernel-team@meta.com, calvin@wbinvd.org, 
 jv@jvosburgh.net, Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686; i=leitao@debian.org;
 h=from:subject:message-id; bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDfxR66IUfHQOCEO81HXwPeIzUPA08Bi6dPx8P
 jKinLB5IwuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQ38UQAKCRA1o5Of/Hh3
 beYAD/9T9FlKvwfyunjOenx5s8BJf0h0BhplLEhAaLaDNUiZlHWNi3TX43tzuhundshN7VfbxQM
 pVqbepfqQhbcRuZ+XIP5kk6ZM2tRJxzMST8l2TZip0e5AvlAuhvEPtF4/yD3ikKTvhyYcJY3XMU
 xRXrHoOdhAaoEKdzqGlz+tjSzod5Do02jr1PfX9KQOVWuOr4xHSI/3JBYnvl9iwQUb9iSBtUOP6
 KBnn7c2jPPdhRaG8iarM4BwxSzmeX6L9gfuFPabSZOAsBzIdgiLYkaEb/UaoI9LQoh2kp7JYXcd
 CQN5157iVL56GTLSBydY9lJZiukoq42Znc/w59iSNMXXrJepry2kbjM13pIrEduoNytvnxvOurO
 5mlSpAg44u5ShzovNmNt2NC+L7bZtBYfa3Vug7iYBvzC2649s/sP6yeBXG2dR+wchkHFlY5nrF6
 X+AIjNFD09oi0+ykEjjCSJ7OwzNPs3yUJpMXNs972QqQ+uvu7dS2fZF76XoIBVKaT9ohH7JNukH
 dIKVdHQZ5x2fjNP4Kvx0I0EwEo8WBMkUA7tyPZmx3ye29ceT6rRxvWs2nTpYDW4NZpT55qQZF1v
 tHozXJes+Akv8AiM4tBsXkbL6RlVxJv2K6Nac8ZOgevHz+gKAEHIfx85IHkydMVoMMjxHxMsZ7j
 0vyXgao7lsr9QdA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

commit efa95b01da18 ("netpoll: fix use after free") incorrectly
ignored the refcount and prematurely set dev->npinfo to NULL during
netpoll cleanup, leading to improper behavior and memory leaks.

Scenario causing lack of proper cleanup:

1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
   allocated, and refcnt = 1
   - Keep in mind that npinfo is shared among all netpoll instances. In
     this case, there is just one.

2) Another netpoll is also associated with the same NIC and
   npinfo->refcnt += 1.
   - Now dev->npinfo->refcnt = 2;
   - There is just one npinfo associated to the netdev.

3) When the first netpolls goes to clean up:
   - The first cleanup succeeds and clears np->dev->npinfo, ignoring
     refcnt.
     - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
   - Set dev->npinfo = NULL, without proper cleanup
   - No ->ndo_netpoll_cleanup() is either called

4) Now the second target tries to clean up
   - The second cleanup fails because np->dev->npinfo is already NULL.
     * In this case, ops->ndo_netpoll_cleanup() was never called, and
       the skb pool is not cleaned as well (for the second netpoll
       instance)
  - This leaks npinfo and skbpool skbs, which is clearly reported by
    kmemleak.

Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
clarifying comments emphasizing that npinfo cleanup should only happen
once the refcount reaches zero, ensuring stable and correct netpoll
behavior.

Cc: <stable@vger.kernel.org> # 3.17.x
Cc: Jay Vosburgh <jv@jvosburgh.net>
Fixes: efa95b01da18 ("netpoll: fix use after free")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/core/netpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index c85f740065fc6..331764845e8fa 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -811,6 +811,10 @@ static void __netpoll_cleanup(struct netpoll *np)
 	if (!npinfo)
 		return;
 
+	/* At this point, there is a single npinfo instance per netdevice, and
+	 * its refcnt tracks how many netpoll structures are linked to it. We
+	 * only perform npinfo cleanup when the refcnt decrements to zero.
+	 */
 	if (refcount_dec_and_test(&npinfo->refcnt)) {
 		const struct net_device_ops *ops;
 
@@ -820,8 +824,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
-	} else
-		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+	}
 
 	skb_pool_flush(np);
 }

-- 
2.47.3


