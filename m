Return-Path: <netdev+bounces-62222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3C826486
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE090B20A3A
	for <lists+netdev@lfdr.de>; Sun,  7 Jan 2024 14:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D68612B6C;
	Sun,  7 Jan 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPhpZAwS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0298E134AF
	for <netdev@vger.kernel.org>; Sun,  7 Jan 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bcc273833so947048a91.1
        for <netdev@vger.kernel.org>; Sun, 07 Jan 2024 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704638657; x=1705243457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KF8wOxvvHyjJ033nqxI8XaGjC2xUhLRm1zgQcrdC0pc=;
        b=DPhpZAwSs4uN7fGxNSXP1NmKF3fIJzJaZYPmS7cn4ZadfMlRlm93DftK0wcMSiVR8p
         0kxySXn9uvcxG7rqJRJ3rlAkhGsBM0cuxTDTDfkyei87Bi7UuA2SaMorsYU7MMRhNEH/
         LeFnajZXixQ/vPG9UY1FQ2/qf2WI2sp45u3lPpnmEQS1v6YvLKfS3on4rQu5n9sE3h89
         FJIeNcXuDXi2aDh3qLPI/A3NBWGYQuAlh8wxiUjtaXzmZXjAhC2IE0M3eaRqGkI9PCg2
         CUW1Vg5RP2WUq7jU9lXuaGHhz2Ste3tLu0eEcXIIJXDVdLqG6nmNwSgHu3iKS9NelpJT
         vL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704638657; x=1705243457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KF8wOxvvHyjJ033nqxI8XaGjC2xUhLRm1zgQcrdC0pc=;
        b=u8jUQujbYqB5CZ1IvIUgBVefYFRGFLxaznZ1f5z8KbB87SPyrMC5WGq03vDskssCcO
         pieJNrRgfhGEX09SuwnIcI0nmo9z9GU/vLiG6Nddpr8ZbWhm3AzTnEechpMAnjGMGw+r
         1FxN0JJNpdnhpxfOwv6DeBpUxcxfzY5j6iD5lNbKeKIrNU78tT2c1TIvg5bCRtsHxbOR
         AmO6P53ahpimOa/ehcBQzkJ6LqU5b/kINY4mC+Iu6lyMJzvwCJaeLgMjiEzLyOnaOuoS
         lmczt5vrgMq6+FattWMNhIqDW6cFo1Tq7UpPTKeY8XxjyR4A1Zl/syy98PAdCZ1O9fak
         YP/Q==
X-Gm-Message-State: AOJu0YzuV4vEy/4JHclb0FinvO44nSg73EHI4FyQSBq13Bi4DgJpfFYS
	dAYV4K4g0GUUlapYkh2B724=
X-Google-Smtp-Source: AGHT+IG9iEH2/bNBgM6nbVHdigrRSf1gd8PAUDu4t7xKxtQ6telGr98Osqumi1ZzEmYESDR/n1lS+Q==
X-Received: by 2002:a17:90a:e544:b0:28b:97af:955b with SMTP id ei4-20020a17090ae54400b0028b97af955bmr993531pjb.38.1704638657172;
        Sun, 07 Jan 2024 06:44:17 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090a8a8300b0028d08a472a0sm4479965pjn.57.2024.01.07.06.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 06:44:15 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: ap420073@gmail.com,
	paulb@nvidia.com,
	jhs@mojatatu.com
Subject: [PATCH net] amt: do not use overwrapped cb area
Date: Sun,  7 Jan 2024 14:42:41 +0000
Message-Id: <20240107144241.4169520-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt driver uses skb->cb for storing tunnel information.
This job is worked before TC layer and then amt driver load tunnel info
from skb->cb after TC layer.
So, its cb area should not be overwrapped with CB area used by TC.
In order to not use cb area used by TC, it skips the biggest cb
structure used by TC, which was qdisc_skb_cb.
But it's not anymore.
Currently, biggest structure of TC's CB is tc_skb_cb.
So, it should skip size of tc_skb_cb instead of qdisc_skb_cb.

Fixes: ec624fe740b4 ("net/sched: Extend qdisc control block with tc control block")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/net/amt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 53415e83821c..68e79b1272f6 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -11,7 +11,7 @@
 #include <linux/net.h>
 #include <linux/igmp.h>
 #include <linux/workqueue.h>
-#include <net/sch_generic.h>
+#include <net/pkt_sched.h>
 #include <net/net_namespace.h>
 #include <net/ip.h>
 #include <net/udp.h>
@@ -80,11 +80,11 @@ static struct mld2_grec mldv2_zero_grec;
 
 static struct amt_skb_cb *amt_skb_cb(struct sk_buff *skb)
 {
-	BUILD_BUG_ON(sizeof(struct amt_skb_cb) + sizeof(struct qdisc_skb_cb) >
+	BUILD_BUG_ON(sizeof(struct amt_skb_cb) + sizeof(struct tc_skb_cb) >
 		     sizeof_field(struct sk_buff, cb));
 
 	return (struct amt_skb_cb *)((void *)skb->cb +
-		sizeof(struct qdisc_skb_cb));
+		sizeof(struct tc_skb_cb));
 }
 
 static void __amt_source_gc_work(void)
-- 
2.34.1


