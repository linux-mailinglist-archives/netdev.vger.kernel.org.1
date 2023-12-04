Return-Path: <netdev+bounces-53644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C80804033
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6F4A28135D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382EF225A6;
	Mon,  4 Dec 2023 20:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MQvV3KOW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED8D6EA0
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:39:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6ce3935ffedso2224178b3a.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701722383; x=1702327183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1rQLF2FFD9E9m66wLjUc3Aw8DImxClYa4KknzX7ZPc=;
        b=MQvV3KOWlptRlrsOFrf7cN1HLjPOQEnh+ZmvLp3AhOXzwO4vexatJPesahiAAhOxju
         vfLnHOSdZQxkI5djFW4TmOTLOO2gHwXnyvwbMV1NcASb/O+kjF5UyaCe4Ij7dFABTOCU
         UTBX1/8IiPgDepu46fP8XPL8DCzBOWJy4/6N8aMgX/NvwJV/9rUq8pliK5xl8rzqYGq4
         PwPkAPBqRb+wPVGXcdDmdO1Liycr9H7QvZnBxXao5JfJpl2fScnfJo0/gUUchxxHlF6J
         yUGeJH3g+wrDv4z8RlI9kHTfzQpMYRemD1ommDCN2GCM/V0IQmLTh/ReW627WVMxluUt
         fsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722383; x=1702327183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1rQLF2FFD9E9m66wLjUc3Aw8DImxClYa4KknzX7ZPc=;
        b=U+qEnqX/hcXYVJ9DJiVJCHw5n4IaTgXvlFd+GgOGlU6+uhn69bL+n/AqTVt7ICiJ76
         5RZkqOIMJTT2TLDWd/GpLg+C5X6xpOixobfqYQ8GHFZeNpYEVzGMLwMi3mYx7vLpsFR9
         /jAIan8LD3dYxyCUWsRj1kKkGbG5Taddy5EV6MFUvg/ZxI8DaSIcSxjCHfDg/TJrHJvq
         ZC6N9ms/BG0pzYRl32zYlFop9P0egrvlPoYJXzu55bIGIbapLsW7VEcZ6ZxyaouD6dug
         yy3PY7Xm8NiR5qMUwLUN7yg5Cn2cJutOtKZhHHucHyrDdIMgwiwfxJh3ca1s/DvS3Sui
         b+1A==
X-Gm-Message-State: AOJu0Yy/zpEOmVlbJV56RYjDHifqpSJxGF6h2vdgKBv6OUMZvztziOnP
	Q6lJH6X44CC489mY6m3lznHKfIG4H/ydubHxETY=
X-Google-Smtp-Source: AGHT+IHGyd8K3Y6B69VAbtwSRj5Pj5MCzjstPEUKx11DZq7gvtla42W73IpYRMQy6Ih6kaX6SLVXZA==
X-Received: by 2002:a17:903:244d:b0:1d0:53b1:400 with SMTP id l13-20020a170903244d00b001d053b10400mr4419483pls.68.1701722383609;
        Mon, 04 Dec 2023 12:39:43 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001cf83962743sm2669584plg.250.2023.12.04.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:39:43 -0800 (PST)
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
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 2/5] rtnl: add helper to check if a notification is needed
Date: Mon,  4 Dec 2023 17:39:04 -0300
Message-Id: <20231204203907.413435-3-pctammela@mojatatu.com>
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

From: Victor Nogueira <victor@mojatatu.com>

Building on the rtnl_has_listeners helper, add the rtnl_notify_needed
helper to check if we can bail out early in the notification routines.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/linux/rtnetlink.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index a7d757e96c55..0cbbbded0331 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -137,4 +137,19 @@ static inline int rtnl_has_listeners(const struct net *net, u32 group)
 	return netlink_has_listeners(rtnl, group);
 }
 
+/**
+ * rtnl_notify_needed - check if notification is needed
+ * @net: Pointer to the net namespace
+ * @nlflags: netlink ingress message flags
+ * @group: rtnl group
+ *
+ * Based on the ingress message flags and rtnl group, returns true
+ * if a notification is needed, false otherwise.
+ */
+static inline bool
+rtnl_notify_needed(const struct net *net, u16 nlflags, u32 group)
+{
+	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.40.1


