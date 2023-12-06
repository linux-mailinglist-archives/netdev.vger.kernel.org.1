Return-Path: <netdev+bounces-54511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B980758C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9FD1F21676
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DAC487BB;
	Wed,  6 Dec 2023 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="afAaNNSC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC89FA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 08:44:47 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0521554ddso38042485ad.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 08:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701881086; x=1702485886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7VceqgJeN9nR+D8xWxcQGhtI4oSAvnc7Keqe8LqyhQ=;
        b=afAaNNSCUPWgAdLdLA16HK5w+qxBYeOMp+wPixATkOGpRAHew2d2XsDPgtkYIrqsvD
         PAU0lNFp4dWxsFfeQnW4y3jIKIjcALBNbSjRuzhhCgLNiXpPrsaI04gIFacsclCS5qhY
         PzemMkuZMNLuM7nKcX8whA/6m4JvVlUOZPhhLkQoB7Op8pcxW1wg+AGFYnebxdgtBuxs
         c686jqIoItXmIWX+DWK4AKTHCJGF7hQuCvA0CoYft3qwJ3t3OHd6cfLZrqe6VdjUSKCP
         A+cmELE3u4SBJ2vz0rHiivRvNx2vu8InC99R77imQs/bWB0gf8DP6Wp4HgCLPezK2mKw
         FWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701881086; x=1702485886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7VceqgJeN9nR+D8xWxcQGhtI4oSAvnc7Keqe8LqyhQ=;
        b=N8cYgrGGwiYmnrSyW2/n+uaCTBZ3+P+V/mI3dmCMqnnzfuI1gehryA+D3nvOLlYpy8
         QuC4JzmQIALahsCd6pVH5LKLl6Ces7u1auyQmRYiuxDzY96Pw63UUcr55P3+SXGgp52Q
         WhWN7Te1y/m6zLzEFLTEdqXzknS6iM3zOVUhhc+OKaKpkj9LH8Crvssvy41XB2OQl8u8
         svPaVUhhccXtRmVsgtn1H6Nis7+Jb0TQHy4QFtY0sHNkN8bccKtHNDCnaldTenf7vhN4
         ClNhEmxzrWpshPRBjSTRDaAXDNn1GBsrLmsbwQY3Pca6vJwgHIsxL4LXZCQ3UKzIrPDh
         Ykuw==
X-Gm-Message-State: AOJu0YxxnbIYQeeKkAFx3f0nG+FpRkYWarkJe1m0zdJYZkfWoxCy+uw/
	Lxb44Qg/uWdTkgsHcJVuP0sex8sI4tfjWsKR2h8=
X-Google-Smtp-Source: AGHT+IGbpUOyggOPeTVQ39UeACFhf6IiKLNqSE0Bjy4KObEZryI6ey00sQUOPCpAUPu9qr9E98/cpw==
X-Received: by 2002:a17:902:d4c8:b0:1cc:32df:40e7 with SMTP id o8-20020a170902d4c800b001cc32df40e7mr974981plg.66.1701881086577;
        Wed, 06 Dec 2023 08:44:46 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902740100b001cfc3f73920sm36719pll.227.2023.12.06.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 08:44:46 -0800 (PST)
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
	Jiri Pirko <jiri@nvidia.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3 2/5] rtnl: add helper to check if a notification is needed
Date: Wed,  6 Dec 2023 13:44:13 -0300
Message-Id: <20231206164416.543503-3-pctammela@mojatatu.com>
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

From: Victor Nogueira <victor@mojatatu.com>

Building on the rtnl_has_listeners helper, add the rtnl_notify_needed
helper to check if we can bail out early in the notification routines.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
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


