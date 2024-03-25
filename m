Return-Path: <netdev+bounces-81635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3288A925
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02901C3875E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C8F158DC1;
	Mon, 25 Mar 2024 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="2A78syOz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B50158D80
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376933; cv=none; b=pqokx2wknM86DTe7xxux7Arur5YJu1Ctxite9fSCi/3WobGAmetFqZWW0hiXbQg7CHJE3rJtfvYyNKM4ifphb6jwHmmiv8cucCMtsr+TZNv16A2bFiQdn1zrt1p+POfBW0LmY4uvT4rW3zRVc1JJ54zz8FON0C/XPNbfedNF9BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376933; c=relaxed/simple;
	bh=+e1OA7Jrn5ctwNqhGqk/KRqwwmxPbyCt+H60w/t/lp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCi9Y5Y0AcX1kMDhZpzLXP9q8yKv+b77CxEBltfz6Cb3ZGSX8hrUgZhgOuyIBlo52yMW53meo8l7Sz6LmHTXiLFAByNG3IAFUpsz+omCxM0GZDErHOuPlPdq52GFUhuXZj7Heeh0qQZxSSnEm4+kxHa+5otVp7xitVPGsr0b7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=2A78syOz; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c3ceeb2d04so450674b6e.1
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1711376930; x=1711981730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtsBe4ABVedqUldLzsr6bK8dTREORzvKiFrKUve9Vxg=;
        b=2A78syOzVIu1n50Xa1WTK4hNXEfXIM65RIhZJSBpbCt8cPK6AOlnuMjs7afj4Lnj9z
         RNmUmrlI8H8vt/fOD7/ESfTi14Ypo3lb8RV4Ks1xUgm0KL4q3kLKr4HneUDwzgwF45To
         1/w3JN9lEq8KXiwTIj9Q9JuYuJMBcEXN1KDTMHdiegqLV4tXuuRrUffF6tTUe2dLQ0u9
         S/n1oavi6y8qwYkFrkz0bKyhVkJ7638Ns9EVExSPMKlFywGkKjMVfZUbSvw6Dt6RIC+3
         KNY3KpwO5BJ/w/sq27WWvKBICawlCfaDPAto5EepFMH1Qd2/bMBXzmBDLHzXlaZnPavz
         NnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711376930; x=1711981730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtsBe4ABVedqUldLzsr6bK8dTREORzvKiFrKUve9Vxg=;
        b=oYVfZUr27q7ki+m91zSq8HnH2dTUJ9+KisRS7/DdNeOoAbi0CBsqguHfGMU1FG2z+G
         YOD2/eN5CFtLrJWrBz8IX5gBQju37N61R3oEcugGvOja04CM4JTD7jL1AzdWyjMCXTA3
         FQEAbT7sGCfaV58XaxnJp1q+IQhh01YxpfKVqdsUhQFiLFmbADq0u0VX4nvJvSPmYcUJ
         Rjm5V543GD+4jipqBB7eGnM+QaFHW97aAfxjVwLxzN5Jar8dG9OUEN8covlmGW4y1kDf
         PyyXl2rPef2PtqIR2tiMh4vv1vL1ku3fjVsfVPG2L4MJSzUPEhk4+XUeFEOuD/h+LzJa
         sLgg==
X-Gm-Message-State: AOJu0YwV9p04QcFEy2/CA6tWwOK+qIDi2s4V0EuLYwzGgStUTJVMMZ2R
	0VEVEQTqaIrE2gHHxtirc+nKAwYLd9lFM7R+QQt8I8tX8GJAujqRmfIowuvb0RMvsmUI8CiZy50
	=
X-Google-Smtp-Source: AGHT+IH1AWfJetRuGCgTH7ii7qarhcLeaIqircvcMz0ntKMhaazsHRK6Ocil/2qFApRnmEaTD5Uy0Q==
X-Received: by 2002:a54:4118:0:b0:3c1:94b3:ebc8 with SMTP id l24-20020a544118000000b003c194b3ebc8mr7506837oic.49.1711376930532;
        Mon, 25 Mar 2024 07:28:50 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id l4-20020ad44bc4000000b0069687cdaba3sm1729255qvw.36.2024.03.25.07.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:28:50 -0700 (PDT)
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
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v13  03/15] net/sched: act_api: Update tc_action_ops to account for P4 actions
Date: Mon, 25 Mar 2024 10:28:22 -0400
Message-Id: <20240325142834.157411-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325142834.157411-1-jhs@mojatatu.com>
References: <20240325142834.157411-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initialisation of P4TC action instances require access to a struct
p4tc_act (which appears in later patches) to help us to retrieve
information like the P4 action parameters etc. In order to retrieve
struct p4tc_act we need the pipeline name or id and the action name or id.
Also recall that P4TC action IDs are P4 and are net namespace specific and
not global like standard tc actions.
The init callback from tc_action_ops parameters had no way of
supplying us that information. To solve this issue, we decided to create a
new tc_action_ops callback (init_ops), that provies us with the
tc_action_ops  struct which then provides us with the pipeline and action
name. In addition we add a new refcount to struct tc_action_ops called
dyn_ref, which accounts for how many action instances we have of a specific
action.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 15 ++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index c839ff57c..59f62c2a6 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -120,6 +120,12 @@ struct tc_action_ops {
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
 			u32 flags, struct netlink_ext_ack *extack);
+	/* This should be merged with the original init action */
+	int     (*init_ops)(struct net *net, struct nlattr *nla,
+			    struct nlattr *est, struct tc_action **act,
+			   struct tcf_proto *tp,
+			   const struct tc_action_ops *ops, u32 flags,
+			   struct netlink_ext_ack *extack);
 	int     (*walk)(struct net *, struct sk_buff *,
 			struct netlink_callback *, int,
 			const struct tc_action_ops *,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 87eb09121..dc5caab80 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1044,7 +1044,7 @@ int tcf_register_action(struct tc_action_ops *act,
 	struct tc_action_ops *a;
 	int ret;
 
-	if (!act->act || !act->dump || !act->init)
+	if (!act->act || !act->dump || (!act->init && !act->init_ops))
 		return -EINVAL;
 
 	/* We have to register pernet ops before making the action ops visible,
@@ -1517,8 +1517,17 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 			}
 		}
 
-		err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
-				userflags.value | flags, extack);
+		/* When we arrive here we guarantee that a_o->init or
+		 * a_o->init_ops exist.
+		 */
+		if (a_o->init)
+			err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
+					userflags.value | flags, extack);
+		else
+			err = a_o->init_ops(net, tb[TCA_ACT_OPTIONS], est, &a,
+					    tp,
+					    (const struct tc_action_ops *)a_o,
+					    userflags.value | flags, extack);
 	} else {
 		err = a_o->init(net, nla, est, &a, tp, userflags.value | flags,
 				extack);
-- 
2.34.1


