Return-Path: <netdev+bounces-236435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B0C3C33A
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B490189A368
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554F5348865;
	Thu,  6 Nov 2025 15:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2033CEB2
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444621; cv=none; b=IvMoCWYml/8IN1X463agTfzh37BkLwL7atvFkJXpPUBVIr14zaX0eovLWOlFJudjh8B0390C/eF2/pclZ9IJ1nVBQ63QIL7fr+l0iajBz1pIQTzpWfiBZQMvRDaCWa7u6VdxzzrZM0II8pG497VHx2IbMK0k17ZApkjnrIYCvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444621; c=relaxed/simple;
	bh=PBufnVhc0vYw6K1yqEtQER08QOskv29ELpqGFdftBe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUOINMK9MAF0yqhEmDhRN1zi0LJtuHVa0rLknzaxnxdaQ8W8/n6CaIMUVZulRtBrj4TQc3ZrtunzJXB35JuVobF0XnlsO2JTAUvWK0r4RWHmwdBCmJesD9w+SdkjCziK0OHGlBnW9tumIa1NvKbZhF19QN4w9UomBP0a88ZBHas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so188541366b.3
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762444617; x=1763049417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjGKFyPmmnOORJmfJYb79vkMgO3eaKsfbWlFTGwHffE=;
        b=iyaYjxDEULtNfKF6m4hf3DvyCeTsXiib8rIjP/hhB+0Ar2CUgiSDQ8grkmz84j7bQJ
         KlUwJjyQO1cF8F6qN1fKp/+kjmmU1SjLNbvFFMi68GZVu5tMHS6h+80dUBFVQ4jD5+cL
         kilZOScAENk+7xR29nGIW3CehzJmZT2Udohjn7p9v8lh1HIe5Lh4/NMdTNcH1WlS+8f0
         6KVCBJ9oUO2vIHLs3bFr9oC3V40yO1e8JYM9fmZccAnojJhUjon7MZHJALSWH00vxoLq
         ooiMNji9qYbfi0pgGuaZoH7RRQFp2d2CopoxKDNhOqMScu59YaE7D0cDSvmBdp5vKlGD
         15kg==
X-Forwarded-Encrypted: i=1; AJvYcCU/bZeLpjlqizVpy1/bXZYYr2sA9jsYrZqWuQhZ7Q5g5AwJrCoahxOuLy+svdZJx6ToCKey6xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxacufhBsv7LlwG4JamSJhFRgeDo9EPPtx+Qd5EaLIC/u0Tneec
	PJKaXAnfQ5HdAs7K9Dszlkh3hP8krccH92nH9XLX2uZSbtjNBVGH/o0eYoHlbQ==
X-Gm-Gg: ASbGncvqzfg2DNbJnz7KSWShI6SX9/GoVu+ugTFkRqnOQSQIEG/DNLH5JEKc3ZP0+S1
	ZGVjNxoz6KEjrbpzQm0KJAtEvjfgfG5n29gQccwaMkOrmvzwAWecVMgmds3fn/fN0g+hw69aSKh
	VbQDX37Afth5sJMlciG+rCFcRoD8oEZa4vxH0f56hZ/a07W8znvMX2WjiCP08dElgNb4oJurMbp
	eM+K9TkJ72KxegVLOg6Y8K5AjZOy+ROeiJmCcTqKHbBUcg0o3GjJuxF52LISitnoAOmo+1Bs2Vf
	fUiYUYi0ZYS5/kVFGWW/QD6Z1YN/sbuIYgzN1tQ9i+snNF9tKdwZkPLBgIF83fjUy4Fq8ThIUV2
	pL7j/b0/Rx2Vk10hrXIoQ3erOO+a8dlHoJ4yyxeZ1FPpFVyAN6w2wKR6Y/ly/F2Zi3OouFcrg/5
	o/lA==
X-Google-Smtp-Source: AGHT+IE1I3KsdrFfPzR8ZbLblQmlN8xA2lL4chWTQNh9/e/sKcWfQSx/nPRWrqzoh4RnHnBtbfozTg==
X-Received: by 2002:a17:906:f855:b0:b72:95ff:3996 with SMTP id a640c23a62f3a-b7295ff4f7amr227875066b.10.1762444616910;
        Thu, 06 Nov 2025 07:56:56 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289334090sm250482366b.13.2025.11.06.07.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:56:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Nov 2025 07:56:47 -0800
Subject: [PATCH net v9 1/4] net: netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-netconsole_torture-v9-1-f73cd147c13c@debian.org>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
In-Reply-To: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
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
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpDMVFPcvHaEIvqY/K0FMrxc5XuLCG7DPYcVfKr
 zAJADuB4YiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaQzFRQAKCRA1o5Of/Hh3
 baWiD/4+Jm/bGM23oRiaStiDbJzcHe9o+DQub4eeoFUmIU9ViAwTIOYJKC2Nqx44QF5Nx8VSWWf
 U55ww+CydeULqtsdCNc2D1LQf2uqpuVKSY2yEhgy416XNIB960v0vxXwc6PNUWqu9qNtn2GfXoO
 g1zIdEe3lPWnVzETl1lt8lsapfeQ21XNwWIY+QQbD3FICLeTGLhzEOsgFyRjw3M/tdbI5OetPef
 O7qwcMiXmdoZvQP1GpQfwZX+F0rLI4+vAVvI3gWMKlKqYRf33nCY8ErINNcKCcrPI3DVuIojB7G
 eLwPPnpn4RAcs6PAkaoU9Nof5DA50QAndSBbjLMr4E7ez3GtlUE6q5SjnS/HGs/OdgPyf4sL5sz
 lXQI6/GJgcCIhciHAFVD5vlOSderxZGNeEXfvkJGgqtVLnw7EAbH+u0UmQchNTlCixBV4VEpYi1
 4BwLALvT6ST/xqAacz7ffxsGDAMiAAQ5wRy4y72V6kmBu4AvCFyZC9r7Ea4cFuorwtl+Vf3mVPF
 qN1Kwga41B9UVEe/YD9UeNdg+q8E06PtLpdLF96ocI0+VRK0Tt5lGoTpYZgq8ljGhglTbtF7fyN
 Hiaal6823bpg7LCdP7+xCRFdx98EpWj4VoWZWzBhYskGMkmosh1qJAQVUyoybopbHFQM+lXOe+t
 8nTugHL0cqI6kRw==
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


