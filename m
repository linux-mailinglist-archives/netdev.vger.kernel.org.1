Return-Path: <netdev+bounces-53104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DC68014BE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837BC281E0B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146B75786D;
	Fri,  1 Dec 2023 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="05AjA+KM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E48A10C2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:43:49 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2864a74f297so1682259a91.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701463428; x=1702068228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fvX/TGxfozRCM/n8ckwHzCI9nP403SfPlaIPxthkm4=;
        b=05AjA+KMWh1bfymqsWCliUyFeQLFIGA197YphozIeXfAFOoAwCK6X+8j/riicDySix
         dA5t/3oUTkztUHIrMP+9RcVa90nWeAOoiamYwGHBvcomzpbbh98m39EV91FZt73XmARp
         hkSypLlH1EHkZeSuYdgIvGLq1ukGc9ma/16TJfcGk8noeToLJN1a18sw/St62E1EK6Wc
         b/Fq0VnRBDBnYvwFTE6d08y9U5iM7i0fYT/9SNhLliOAX4u0m+3xbOVbGqew9N+mMJzo
         ACPiO9Iwm4ovAPW5csMDRpUQoExJVkM/RZdmFLyFdOCZlOBLAXw8yICBNkQ8qPSfm478
         8auQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463428; x=1702068228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fvX/TGxfozRCM/n8ckwHzCI9nP403SfPlaIPxthkm4=;
        b=aaPt7c5F0s5XXjRtMBz4+xJuqER9T8mhgHpwNezWj34cczmQ+88nhwrMRANg3T5YmY
         texf5OCXvWSdfLu42WPSL19zV0Jw0tY4isDILnnRKnBEfWcSRGA4wFQPIO2k05VmLxL/
         XS588zQHVobq4BGYYvupOW0NiPr9RBrXiiNqW3ueAwN8Pboqol7xh+0/Zht3UuXU5O7u
         DRNUGH+ZerEBqA1abZ7MtUw+9VfUUHPkSuCzB1LeGAQbZ3yatbqig+AvNA2O59gIMGWn
         54llHj2to2GwJ40Ngi/wYpziHxc13GIG/7rPZ+RhJuhPW1p0RF/AuYD/Cxx5L6lWGx3k
         GZ2g==
X-Gm-Message-State: AOJu0YyKtTh/5WRxtn4+LeX74xBn1uJJ+cYcxKqkIte9Ocs2i5mN2K6c
	uzlEQm8nbYq5hjiYfm6aIsCty+gzW5ymdQA5o4A=
X-Google-Smtp-Source: AGHT+IHcRT+e+Mp5G4AHV3rfLT5rtblpoQQfd3NtPHFcXEKMmLjLbmdibKNI+aSsRGbMXxqKmsf8yg==
X-Received: by 2002:a17:90a:8a93:b0:286:6cc1:5fce with SMTP id x19-20020a17090a8a9300b002866cc15fcemr97523pjn.81.1701463428378;
        Fri, 01 Dec 2023 12:43:48 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id mz18-20020a17090b379200b002865683a7c8sm1933467pjb.25.2023.12.01.12.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:43:48 -0800 (PST)
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
Subject: [PATCH net-next 3/4] net/sched: act_api: conditional notification of events
Date: Fri,  1 Dec 2023 17:43:13 -0300
Message-Id: <20231201204314.220543-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201204314.220543-1-pctammela@mojatatu.com>
References: <20231201204314.220543-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today tc-action events are unconditionally built and sent to
RTNLGRP_TC. As with the introduction of tc_should_notify we can check
before-hand if they are really needed.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c39252d61ebb..2570f9702eeb 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1791,6 +1791,13 @@ tcf_reoffload_del_notify(struct net *net, struct tc_action *action)
 	struct sk_buff *skb;
 	int ret;
 
+	if (!tc_should_notify(net, 0)) {
+		ret = tcf_idr_release_unsafe(action);
+		if (ret == ACT_P_DELETED)
+			module_put(ops->owner);
+		return ret;
+	}
+
 	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
 			GFP_KERNEL);
 	if (!skb)
@@ -1877,6 +1884,13 @@ tcf_del_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 	int ret;
 	struct sk_buff *skb;
 
+	if (!tc_should_notify(net, n->nlmsg_flags)) {
+		ret = tcf_action_delete(net, actions);
+		if (ret < 0)
+			NL_SET_ERR_MSG(extack, "Failed to delete TC action");
+		return ret;
+	}
+
 	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
 			GFP_KERNEL);
 	if (!skb)
@@ -1956,6 +1970,9 @@ tcf_add_notify(struct net *net, struct nlmsghdr *n, struct tc_action *actions[],
 {
 	struct sk_buff *skb;
 
+	if (!tc_should_notify(net, n->nlmsg_flags))
+		return 0;
+
 	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
 			GFP_KERNEL);
 	if (!skb)
-- 
2.40.1


