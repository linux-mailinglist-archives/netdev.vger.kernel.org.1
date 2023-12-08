Return-Path: <netdev+bounces-55414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7726080AD01
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BE1281AC6
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C84CB3B;
	Fri,  8 Dec 2023 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KDmyudXu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857CB1706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ceba6c4b8dso1634588b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063754; x=1702668554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud0m8KbKukOW7r18Hnr/+4q4W5vHibKlr9LNz94nyfE=;
        b=KDmyudXuRZKLtQYJ9qPdzC7mqEtk5prGXG+oxKZeKnAXr2Qb9Hi9SjXy4NUQjOUBuu
         jBxj5Oa/nHnXcgTWp2TOb/e16nc0jEX+0ju+5Wkoe/PCWDhmsrTCz65P6i+iXLCSlPAn
         LD6mmDl6aQi56sVRRcE4gqqNmFQBP5S6wVqTdxJ2nGy/Dn6LMh0feEg65bOC5rz5jo1Z
         0OOk3OwUR3IgkimEl9amvUwbDtoK+jL4CAvZ3GVsRPaGB8JWC1P0dqc/zZ0ON20f5hJf
         dgb/mdI2UC8xKq+CwL7omc6wBSIOv4n5TUeqYZIvejiKFIA7AK6W4CpnGIw/tY/uz/rj
         VZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063754; x=1702668554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud0m8KbKukOW7r18Hnr/+4q4W5vHibKlr9LNz94nyfE=;
        b=f+XT77UXVn5+zKq+8ypDoZNGPRKz5t12JuVIhJK3fO1J2NBc3Zb5YlN9Fp+nvim01X
         Zh3kwvImjqGs8Xp2U97qxjUoubf88XaCoM6UP7G4HpaI3iKWryG5pdqUr3JNLN+6T60E
         VhhSLIDNz6Gh/VhzhRzxIadHiyDbHWAxUxFpQIj4JF/SgPRXw8NvvHYsglYWFuaFha9l
         485KqDOCzkpn3c+hnPK3G/Ygm6cxT7pkVl4vnIucQkSNDIe4f4BvavdNtofZDaMVdmF6
         69zEIezu4QFhouIcrZiBNlEiubuBt6gE2R0cp7kfm0Zp40XIiT7hEIJpqUDAmhGSLFzy
         ALeg==
X-Gm-Message-State: AOJu0YxDDbI5myOOtDrY0DZSfGWgAYB7heC6FqB6KvKf5NsndOayHAz4
	NJNloxDwS4xEbukzN49KCvBtTcFf49Y6xRF9Hq0=
X-Google-Smtp-Source: AGHT+IF3NrNTw5CM9dsGyEItJ9hCToYawrUzvaKNaSJDis9h2rDlWxNGKu9NnuLo7IJVYUKmlBrQtA==
X-Received: by 2002:a05:6a00:a8a:b0:6ce:546e:eb1 with SMTP id b10-20020a056a000a8a00b006ce546e0eb1mr599882pfl.39.1702063753881;
        Fri, 08 Dec 2023 11:29:13 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:13 -0800 (PST)
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
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v4 2/7] rtnl: add helper to check if a notification is needed
Date: Fri,  8 Dec 2023 16:28:42 -0300
Message-Id: <20231208192847.714940-3-pctammela@mojatatu.com>
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

From: Victor Nogueira <victor@mojatatu.com>

Building on the rtnl_has_listeners helper, add the rtnl_notify_needed
helper to check if we can bail out early in the notification routines.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


