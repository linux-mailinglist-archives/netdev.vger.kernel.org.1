Return-Path: <netdev+bounces-37170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77817B40F5
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id EF0951C20B84
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144371549C;
	Sat, 30 Sep 2023 14:36:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0581515AC7
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:36:04 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A58136
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7740aa4b545so1007685485a.3
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084561; x=1696689361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=Tuz+vPHmmwJvbri3u54SnCb3M2Hbx9Vlist2vwABnbCElKZAsFP8IvI36sR6oGlhg8
         Kq+Rn/O07uO9xgZs/Oi0GzJWYcsdLuXUx+FHFPiWasZpS165+59wtCuldLqVOY6tPZij
         zT2J0HDlxbzxRsZcm6GtpkB9EzWDJBfBsQAUi9kWFvDuwixTgg/8rRDg4SPRIqBIehDt
         UbvXr7KIkzSH0IqNmoRE8oIReaRXPgLMhtVt9M9FwvzxuWzOQp4BdqJg5tY0zFm2wjBy
         P1QWmiMXxj3r25th/wJcsRqze0KU4Q+LPr5LkCSoAc3evxXFmyiLlNl7zUN9CIiIdxvY
         w/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084561; x=1696689361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=lKXD+BnurvOKBGLgleK9FH7N91zb2r8V4Vf4SssCSN/fiTgz8OrQJDyb8yf+O77zpy
         jGAxNpfDOxlshrzbIhcmtjFZOGtJyqzptHdpENrLyrCBBS4FpduvQI6dTYgkjEWB7siH
         BkUzWB6mZ0ETqHLkfxyAXMEbGDxjuSBttKxIrDccPdF55ZI/LRqIaPrA+3LnTzCCu/oo
         LPDyGhjShDulGQ8e1AvetQT55pWmFbxjPatAgnv3UANbvVWWoNmPKrl+hSgJD50t8UXC
         j8FYWi5jusdg/D4ab5NXejofffU9Pl4y3uu/p7oKYK4oaO/rfMuwkIMf1ObN5J5X4VyR
         e33w==
X-Gm-Message-State: AOJu0Yz6ywoBwNuITBnQPjlrPHmXSpGNmA8l+yTL3ciz3dpdA3jyGsBQ
	NSiDGyvJR2ytx3ZxQF8BvHyOqnkU6MI1NZ5JMNE=
X-Google-Smtp-Source: AGHT+IEZ8LYY5pecaWMnRkAkVhIbtxATgTjFutcnrcsDDwI1htjLbtFey8ii3NcWh96tr2J+6RMu9Q==
X-Received: by 2002:a05:620a:2996:b0:76e:f279:4c36 with SMTP id r22-20020a05620a299600b0076ef2794c36mr9768832qkp.29.1696084561481;
        Sat, 30 Sep 2023 07:36:01 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:36:01 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	kernel@mojatatu.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH RFC v6 net-next 07/17] rtnl: add helper to check if group has listeners
Date: Sat, 30 Sep 2023 10:35:32 -0400
Message-Id: <20230930143542.101000-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930143542.101000-1-jhs@mojatatu.com>
References: <20230930143542.101000-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As of today, rtnl code creates a new skb and unconditionally fills and
broadcasts it to the relevant group. For most operations this is okay
and doesn't waste resources in general.

For P4TC, it's interesting to know if the TC group has any listeners
when adding/updating/deleting table entries as we can optimize for the
most likely case it contains none. This not only improves our processing
speed, it also reduces pressure on the system memory as we completely
avoid the broadcast skb allocation.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 971055e66..487e45f8a 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -142,4 +142,11 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.34.1


