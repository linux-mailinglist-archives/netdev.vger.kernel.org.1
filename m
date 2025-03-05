Return-Path: <netdev+bounces-172140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304CBA50515
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DEC18831E6
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4C19DF41;
	Wed,  5 Mar 2025 16:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD81922C4
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192661; cv=none; b=OGsK7pDyKGQc6EBjaDHY5u2O+UlmROG1gUUGlECWwJ48gq6230RCF8CBb7KYMIfgO5Tg7mglgaQrEujzht0x5GlYjybh9NYzF2d2A5V4i487gRXKvDbHv3rY1QLSrfJE8Q08avWJIELUkT2AN3O7+5WviUDosaVGHeE+xGUGz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192661; c=relaxed/simple;
	bh=V1yRG3bN8tRFu9JlQ+dTky9jMpbQlF41Pr86/mFyF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oxx2YJipEwQx+K1/EKA2EwhhJ6z2Rb5sRMcx4lASOlcXzuJLzPQIo7fNGafJGbx559oWnGi8hWY1ExmmB76L46wfocqR6atsSpzzOA5Olbkag486wkklUkK0kTmEAU7cbaOUbsh9bwWCyOoGFg9hNo7qOGaIDvm423GQpptx63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22403cbb47fso10570235ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192659; x=1741797459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMzBVdKvGYz1dc59kOZPDz0jlc7LRbU5vadXqqKCTWw=;
        b=n2UEVatR5l/NfpLiHnrbqXz5yk3E035AMHJ1mQGgsE6y+rgqDN32RIK2Bt2UYfSYHA
         o6tNyEhvaVcxS+siK+7RM+YiUG7OG61beOdEE5rweRhYA80jjl5OKsVOmoMCJmQf1Yv3
         QDx6DBY+nrkAo+bQ+1iFnRhCpX658VhE7lFsRf0iGv+SZ3DtJnbxWvFMKMPcA6BZUvBI
         jLX2JBbQuUAJyol1W3tTK87/z7iK+fHmLoy+pq6NPfXEczK1ESIhOTfjoJdny7fw4f7X
         iqCYZ6mn+qGyjdT5C3usA3dG88CLaB/9gdMaUzNj4MmFO01l9LAIvvAcYuMInRj2T/KQ
         Jjdw==
X-Gm-Message-State: AOJu0YxSN9g82TZNsb4rcQrXZwngLB2/F8R/5Wnq+vyQCPfWKPUw9OdE
	RrKsJIqMpIvIyKTDVCl7S07MMXTnox41ffwBFItiNqtzecuu21xKtogQ
X-Gm-Gg: ASbGnct2whzCaaP8N1onekrXdMwUNrFXVJbDbRP29Ovt8cjUE/z2r2pocIH0tS+bwfc
	RI543O4a8WSfZbeGAShfK0II9tBlsMBaRhTx+/9WlBK1BDE7Z7cAdRxD6WMOCi9w6c9vJNJZ+ah
	6CvivRB6XeVHbfABzP7NxVBv6fKFBE2hTCEhvLE7FNidokmLZyucQnWlkPHjRRx/adS1LZ2bzdb
	PdJLHwOZIq8FOSSONb5SNf05dPzwkY0TMtM5ZgJk/+45bFeUDVpcENIvkoK56Tq3A+QS2i2lBpy
	eX3eD+eWVkk2viA0Sk9DvxBhVGyaqS+H6YEqmWTYJbgj
X-Google-Smtp-Source: AGHT+IGO/ywSgzqg6GO1Nf4fcbyFwdB9QkUNdKK0I42aCv1c63m0C+PSdIrw4u20K3+gGPYNhB18Pg==
X-Received: by 2002:a17:902:c94f:b0:216:7926:8d69 with SMTP id d9443c01a7336-223f1d14232mr50572445ad.47.1741192658861;
        Wed, 05 Mar 2025 08:37:38 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224057f9fc7sm4056455ad.59.2025.03.05.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:38 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 04/14] net: hold netdev instance lock during qdisc ndo_setup_tc
Date: Wed,  5 Mar 2025 08:37:22 -0800
Message-ID: <20250305163732.2766420-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qdisc operations that can lead to ndo_setup_tc might need
to have an instance lock. Add netdev_lock_ops/netdev_unlock_ops
invocations for all psched_rtnl_msg_handlers operations.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/sched/sch_api.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 21940f3ae66f..f5101c2ffc66 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1279,9 +1279,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 			 * We replay the request because the device may
 			 * go away in the mean time.
 			 */
+			netdev_unlock_ops(dev);
 			rtnl_unlock();
 			request_module(NET_SCH_ALIAS_PREFIX "%s", name);
 			rtnl_lock();
+			netdev_lock_ops(dev);
 			ops = qdisc_lookup_ops(kind);
 			if (ops != NULL) {
 				/* We will try again qdisc_lookup_ops,
@@ -1591,7 +1593,11 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	if (!dev)
 		return -ENODEV;
 
-	return __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
+	netdev_lock_ops(dev);
+	err = __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
+	netdev_unlock_ops(dev);
+
+	return err;
 }
 
 static bool req_create_or_replace(struct nlmsghdr *n)
@@ -1828,7 +1834,9 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		return -ENODEV;
 
 	replay = false;
+	netdev_lock_ops(dev);
 	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay);
+	netdev_unlock_ops(dev);
 	if (replay)
 		goto replay;
 
@@ -1919,17 +1927,23 @@ static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback *cb)
 			s_q_idx = 0;
 		q_idx = 0;
 
+		netdev_lock_ops(dev);
 		if (tc_dump_qdisc_root(rtnl_dereference(dev->qdisc),
 				       skb, cb, &q_idx, s_q_idx,
-				       true, tca[TCA_DUMP_INVISIBLE]) < 0)
+				       true, tca[TCA_DUMP_INVISIBLE]) < 0) {
+			netdev_unlock_ops(dev);
 			goto done;
+		}
 
 		dev_queue = dev_ingress_queue(dev);
 		if (dev_queue &&
 		    tc_dump_qdisc_root(rtnl_dereference(dev_queue->qdisc_sleeping),
 				       skb, cb, &q_idx, s_q_idx, false,
-				       tca[TCA_DUMP_INVISIBLE]) < 0)
+				       tca[TCA_DUMP_INVISIBLE]) < 0) {
+			netdev_unlock_ops(dev);
 			goto done;
+		}
+		netdev_unlock_ops(dev);
 
 cont:
 		idx++;
@@ -2308,7 +2322,11 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	if (!dev)
 		return -ENODEV;
 
-	return __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
+	netdev_lock_ops(dev);
+	err = __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
+	netdev_unlock_ops(dev);
+
+	return err;
 }
 
 struct qdisc_dump_args {
@@ -2426,7 +2444,9 @@ static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!dev)
 		return 0;
 
+	netdev_lock_ops(dev);
 	err = __tc_dump_tclass(skb, cb, tcm, dev);
+	netdev_unlock_ops(dev);
 
 	dev_put(dev);
 
-- 
2.48.1


