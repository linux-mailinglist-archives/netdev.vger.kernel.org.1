Return-Path: <netdev+bounces-55415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55C180AD02
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA04B20AFF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49ED4CB54;
	Fri,  8 Dec 2023 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tsNt7n9E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357AD1712
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6cebbf51742so1515332b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063757; x=1702668557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rbqb8Cc3CExBuuVs8fbrLNJK62w6f5syo5JgiMxd5O8=;
        b=tsNt7n9EgenyF9kzCIit53XzWaWtg+XErev6yMwQVZLd9wkgKSLiAEocF8HfABdgwZ
         K8rsPg3Ho98PvBbJ7+IL2GaZdKTRzRi8nJTQ/UVTf7SpkkZZeRdCmu9O8wOwWIdFDvbI
         hkk5AQdqfImPX+BazlXrPE2lRe3S5Nl6Aepy2cYGuYvsBXj+iwnrq7w8w0S3G//3Het7
         rDwRYj8nB1U6DpKVi+bzWh+4u0WKEzMNfgiWGHVsgPIbWuMr1WnLEJoG+t4oyhqMWL2w
         ZNyrqYLyCW21TrXR1daXv6ONwWj6JKwl4vF53+yrF3XG6+i/jfSCCUUrk2AWZhttw8FF
         LVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063757; x=1702668557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbqb8Cc3CExBuuVs8fbrLNJK62w6f5syo5JgiMxd5O8=;
        b=lrg8c1cfhWd5hVUBOVTTzyyzR4LjKCVN3cFGWGNsqmRpiUv4MOm/5vCYy52NmPafPM
         m8DzvFJHTW3mBNGz7pQvzZ7dr6q1Wbh25cSRxEg/BsbEY2SiTcTfpVh7ek6DwFxf09Vv
         lhu8/Irqt+NnCm51SKwN0ZRvrvL1+MTkzhksDBE4/YbXMtyxUFAlPqa2dae0tgtz1dEv
         XMsyIdSJsNBljkIHgA3JcowULeQ3lnV5jfj7VbrU4eCeQc4Oa8jea8BwxcoCiTuNZ8IS
         fWTy0YQs7GNxlQJ7rhv+2cIwy4vKivyHBYJUlaHlWzmafhqqq9WSfN55qvgQqE3wZdpM
         ss0A==
X-Gm-Message-State: AOJu0YxBCFXLPd+K91Bbk3I9QKJzsML+O0Z3q+9Ffu6upV4F0t8po7UZ
	o7StPNkI4Y2rb6Dc5ZX35bwV94afa4zz3R+vlH4=
X-Google-Smtp-Source: AGHT+IG6DfJO5kQya5NbcC0yiTdVcaUMT2kyuXASQAEf/p1l1/eP7heCd92rPMfbNJsn9zzNfVuqRw==
X-Received: by 2002:aa7:888b:0:b0:6ce:6448:4961 with SMTP id z11-20020aa7888b000000b006ce64484961mr1801300pfe.12.1702063757446;
        Fri, 08 Dec 2023 11:29:17 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:17 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v4 3/7] rtnl: add helper to send if skb is not null
Date: Fri,  8 Dec 2023 16:28:43 -0300
Message-Id: <20231208192847.714940-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208192847.714940-1-pctammela@mojatatu.com>
References: <20231208192847.714940-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a convenience helper for routines handling conditional rtnl
events, that is code that might send a notification depending on
rtnl_has_listeners/rtnl_notify_needed.

Instead of:
   if (skb)
      rtnetlink_send(...)

Use:
      rtnetlink_maybe_send(...)

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 0cbbbded0331..6a8543b34e2c 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -10,6 +10,13 @@
 #include <uapi/linux/rtnetlink.h>
 
 extern int rtnetlink_send(struct sk_buff *skb, struct net *net, u32 pid, u32 group, int echo);
+
+static inline int rtnetlink_maybe_send(struct sk_buff *skb, struct net *net,
+				       u32 pid, u32 group, int echo)
+{
+	return !skb ? 0 : rtnetlink_send(skb, net, pid, group, echo);
+}
+
 extern int rtnl_unicast(struct sk_buff *skb, struct net *net, u32 pid);
 extern void rtnl_notify(struct sk_buff *skb, struct net *net, u32 pid,
 			u32 group, const struct nlmsghdr *nlh, gfp_t flags);
-- 
2.40.1


