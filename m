Return-Path: <netdev+bounces-17204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C504750CD5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D31E1C211B2
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6233D39D;
	Wed, 12 Jul 2023 15:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEA34CFB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:16 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E91BEA
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:10 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6237faa8677so36563126d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176409; x=1691768409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=Z8tv301Vew0fhlsTfui9Etu9s68zEcY89YDWVF3Sqi3WM6rmmGM1siTyGljZHtF1n7
         DydkbFWAuddiRdSPtNPGd17SbuuEEcn3qFzDJxWImk6Dr76Fyu16YL4crsw4WA/3iUGY
         0/TusVoi3RhrZin4x5qTKGWkcIPKM7jxbcXR4dN2w3GoHcl3eMrQOglcayHkd0WRRZEz
         JsrbPzNDROW1tbyzny6tlj+8ErXQgDLEKxOta5PvBvq7f/v21Hc3wLmLBGnVE0vTV3+6
         /RQU00/nSWmbUC5bxZ2+ql5jzAc1Gvn6A+VqESWyTQQvgIh6u3/WgyPiyaD6ho0Izb60
         TXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176409; x=1691768409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXDAaty5RvW7sna2sinn3YdzfOivIeDvoqLW5kj1+Sw=;
        b=GkSVmJr0L1NFulMHYutHHPi0clva7uON2e4zPYC3wJDWeYTSYrSbZGHqhlLDTr7Tj8
         +zFK/qSudi6rwhXugTqLljeL1sPXHtdiRVzim53MHJchzNmGZNh1liCuOOWHGiSrS+vQ
         NNxHanJElEfDNnAzAyFY3zGwY5euDWh6FkxAEJio4KSEj3d4ylHp3t0A+Rl0eBNjxbEa
         DS577q9Hwq+vDuKRvmbAwQm4XnxWwWsFRjpwNsMk3lLaAjUbXljeO+oychJWI/JHto5E
         NfW9XvbgNCpP8WwnVSwD1UYv2r4G4/M99+UBy0o4QBoSD1dhxYt7WfVYuDxLq+pitB9+
         YPMg==
X-Gm-Message-State: ABy/qLaAaHOlzRn5Vycvc6kL23/CLo78kixeOGHN48v1UMLiadO0K3EB
	jxF8ZDWgQKP87EST9nvv2Y0d54qkIR55VMpEo0fx3w==
X-Google-Smtp-Source: APBJJlHINOgDqmDRm7JM09bU+IMf/B3pCxHwIju4rDD5Fj5qNEyXJo63WPF2PzVGunPaSEdPS44pIA==
X-Received: by 2002:a0c:8ecb:0:b0:636:39ed:4de0 with SMTP id y11-20020a0c8ecb000000b0063639ed4de0mr12805966qvb.10.1689176409374;
        Wed, 12 Jul 2023 08:40:09 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:08 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v4 net-next 07/22] rtnl: add helper to check if group has listeners
Date: Wed, 12 Jul 2023 11:39:34 -0400
Message-Id: <20230712153949.6894-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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


