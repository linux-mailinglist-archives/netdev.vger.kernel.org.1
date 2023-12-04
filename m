Return-Path: <netdev+bounces-53645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCF804034
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371D01F2134E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D12C1BF;
	Mon,  4 Dec 2023 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ypw5OdG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF456D72
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:39:47 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cfabcbda7bso24123275ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701722387; x=1702327187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6381YJ0fxKfyYq1VUroGWEYeqoymWgXS4fp6IpGoYHE=;
        b=ypw5OdG3wVlQJ/B+BoULfdCr12/U/u4eBnK5Ldm/+62j9241JIv91GcfMuS10zSgM6
         56rm6eHfmODWh4+GXkSxEI3tPFiges4HJkbrfDjUnq0VSQut/OCc4sH1wbBcpcpF0qx/
         UpHAMrg/zYIwex7emyi+ti5kOt4a0/jddM4PCFxdPya/VrIRX5hQBNv+0UwKiaLYUjIW
         aLFEjoR97I9kgtd6aMK1uisvNnQ4oH+nVQyyU7urZDP7AU/nP+FWUmh6q90VerxutEgj
         QuJjhgm5m8ZsozmXUOpl/TyrYvthBk6lFwjPR/BKn2fmAQS4s4pXTuU1rGfKpBkCXTsZ
         BVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722387; x=1702327187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6381YJ0fxKfyYq1VUroGWEYeqoymWgXS4fp6IpGoYHE=;
        b=Z6x642g13ercw0MWsczoyQodQZWHa4yYIvBZOeWOLSr/wY4PSkMTJqiU9D+h0+tlOZ
         cMCn9kcJ2GoOm7NMlnijDGnFWmRK7UJ24DsEKfpbuCTx0zd/mpLAcL1Q+hhtIdlaHy/4
         7pOz8hzGgW3fLzQMXQO+o6b5sPNZm1cS1e0Nzgr8gSe0Q/THcOJZF3+JX7Q0wL8qr30M
         CV10aOFRi3Qt7EecYH5AGc45lfQBvvmhox+K6wqrCjTFXHIOuAV1SF3JjlVnfJLz4d/m
         F3iIZ0tnDCK904cYO6LKp+vKZFAyw0gJqAKmqFdOiHh5aTF6m2AM5xkyLa3x1x+wmt8h
         bOVw==
X-Gm-Message-State: AOJu0YzFZRvCH4YOP4Jm7ONSw+o8+C/HPtHxsi6VLhazifXpgXUtAYbd
	RwpHD1nPXmNWKQPtoMTX8/pp1d+GAAO70x/izJM=
X-Google-Smtp-Source: AGHT+IF5yhZcfdAjBNlqbtn76TzLizUPC0kmMNUGLLUpBRRTMwzjLLoGJyPqhP6GTC8Zp1SflGFSSw==
X-Received: by 2002:a17:902:c283:b0:1cf:b413:8baa with SMTP id i3-20020a170902c28300b001cfb4138baamr380889pld.25.1701722387120;
        Mon, 04 Dec 2023 12:39:47 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001cf83962743sm2669584plg.250.2023.12.04.12.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:39:46 -0800 (PST)
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
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 3/5] rtnl: add helper to send if skb is not null
Date: Mon,  4 Dec 2023 17:39:05 -0300
Message-Id: <20231204203907.413435-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204203907.413435-1-pctammela@mojatatu.com>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
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


