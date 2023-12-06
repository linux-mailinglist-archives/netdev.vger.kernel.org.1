Return-Path: <netdev+bounces-54512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C253D80758D
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8944C282088
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49D74174D;
	Wed,  6 Dec 2023 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VNutshcp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C30FA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:44:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so36577775ad.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701881091; x=1702485891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q50gZgjqvdcFJYKqj0O7rtzQrOsxGSudN/5LRmofnmw=;
        b=VNutshcppz5Nn1McpesvlaNZcj/e0ywDZmr8RWqDlNIwqIWWFyx+IPUbDhuOG1LJvc
         aF+A4obDMt6FLuMTf6xUmxjaA+6A9NKdifNv3zYTVkYcLSI55s9MOD2zcQy99rt74WgK
         tTHqK3UEsu5VGgUCj/6fcJckZ6zUET3Apv+W6pHdb/MwkYm9+J/30PKSmi+TYBlO7nM5
         cTh5Ifd7ONBYrGOFgKMlcfx0p4q2d4YIzFTF6E8jr5WPOPWv/lqh+ci76EXiIxnsHRQq
         GzkZ8UDT/Mqb5aJMuG8JRoRqMjwTaUXoe4J+zXE1R08hYTyGSduz1toacVl/JpwkSo0f
         P2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881091; x=1702485891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q50gZgjqvdcFJYKqj0O7rtzQrOsxGSudN/5LRmofnmw=;
        b=aKa/hitMKLIXf0LBoJwzGYFAOUqSQU1bckIH4sWdzMGV5UY4Fl9I3mFwbzuqmOzexN
         SMT0okHP+m1PGH07iUyG0rwdUHaxsCcjGssIFSUbBIO72UbOamENmGpGVchnCv8vuFYo
         3PuEmumSHWt8M2YKfYFvSw+rbJsozMGpQXT6DpAbESqUZeGPmAaAIrO2PEZ3LJCawz5N
         o8pzXrkCoZftAizXlIn3Nq8VWCk2YTHoFqaO5+SftzuyyDA3ntRKFklhSeFsC5fmXSeu
         eFqmtq+8X8LgrlFlFoWqp88SBrBwFyK23jwahNf/Vqg42FXxq3fQw0VnXm7aoo2TY/Q/
         E/qQ==
X-Gm-Message-State: AOJu0Yww33Hv/uQJqQzwrq8ZPRHB4UmdHdaXWpc2k3oM/CUjVwWjGKV9
	pHT8G0PVaCK0ObxkiRXr2vnHRsyT7878MEZ6BgY=
X-Google-Smtp-Source: AGHT+IHFxJwMqYGvZaD0RrIkn3oqW0lBit4RMEOFaL426QuxWZx45P8U3X8nHEAl9lxBeqZIG8xDJQ==
X-Received: by 2002:a17:902:d48a:b0:1d0:6ffd:6e7e with SMTP id c10-20020a170902d48a00b001d06ffd6e7emr1135046plg.118.1701881090945;
        Wed, 06 Dec 2023 08:44:50 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001cfc3f73920sm36719pll.227.2023.12.06.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:44:50 -0800 (PST)
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
	Pedro Tammela <pctammela@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v3 3/5] rtnl: add helper to send if skb is not null
Date: Wed,  6 Dec 2023 13:44:14 -0300
Message-Id: <20231206164416.543503-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231206164416.543503-1-pctammela@mojatatu.com>
References: <20231206164416.543503-1-pctammela@mojatatu.com>
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


