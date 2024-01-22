Return-Path: <netdev+bounces-64823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9098C837314
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466D628E61E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3EA4122E;
	Mon, 22 Jan 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IuN5J1Ht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19A40C03
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952895; cv=none; b=pTqIZUrBJxv+IY+Tr4iR5bbnRjihoizdjA1G8ADic2QhDqVUSJIkN47pLonLMurfui2o+hw/1XSDb0DR521zjlD1k3DpSvz7KTzFzq2c65mcGNde+3x6LXfHKp6PW/aQxoJTYAz54dnUcV748XWCE19cjF9JMOclEjYqiTvStvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952895; c=relaxed/simple;
	bh=JKkWEMInMFi+hM3RqBHWFVycJbeh+r3nIdnfdkvYnuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MozRwSgd+sxkH11/aLaRno3QGoWBNgy9v2grG8pLmogvewnzF5NUECHY/va/L/FKZpt0u5CBiSXDsEWZVu1T251tHGuMzAi0mYHhqb/5vUi1+RT9hhVNxsSmt9WqTgZUH1BmHCF4go6DS1tvTiix2aQ4mKgooYLhVKu0fT8/o30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=IuN5J1Ht; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-68196a09e2eso23351146d6.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705952892; x=1706557692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2dbTO9ihBHJw5+PpbUOe/AqkF1JFPFW8RPaydE5Pls=;
        b=IuN5J1HtAm8rFHemKE2BJP93I3vs1MsgEq/j5pthx6KpTmV4Cnu0U2IxvMfOxwS9D6
         5inM7Z3/FM/y/enkc8Qe8qbGIont0hPcBmG45CGaXS28hnYwlhzPMPitUjO+hqeri5rM
         YPdDZGurjvQ4pq0r8srdUbteOq5Q3Aw7ddH7z4r3jpvbeK10g/vLhJYLkVHNCe1MdacB
         kYeVUj0yJfOR3XM6gn4QNlzC8I7BYhknNlHX5rGAsrkrnU+C7PL7RowqqSfrbjQzKMCK
         bdUo7cO4fhv5SNykitFo05dsVD0RcTKv14DGtfrA9Il0pQojLpi1lK0SkbKuBv0yi1YN
         0lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952892; x=1706557692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2dbTO9ihBHJw5+PpbUOe/AqkF1JFPFW8RPaydE5Pls=;
        b=IljbQ42b4RMXadUikUXQ6wkntotl9R9iZvin2ek7mNG+1QpF7xwxoL6/nszJDe0v2a
         hGt/4CPUlG823Bo+X2iMrsaP/hquyHyQWnWseVMXLOOU+JI6EyYHihAS2VCOO0X4Ul24
         mdf986olAADPK4zj30ZBJ4wY5SwlWdKUuNhkp3/JLzTgTUYf0uLY1yx0ER9PmUw3ueJP
         eGDLvmi5ZahEKnIBRK10lANYAJgok9BbWNrCJVXoe6olR95f0c/oSF4oDjjcx704PYfJ
         X0lq+FGN+Ts1h/98aEVkf8qVQXXa8ByoLt0rMIC/OK/7OaNA8oqq09vArT3q4XC0swCB
         UHAw==
X-Gm-Message-State: AOJu0Yy01T6Go7GAzrZCTrF3SjmChVgasmGv7wGEAUAps0+RQaTrrNEO
	a7//UdZYy6aOKFxZo+6O8FpdgMybyWgltc3vSyLsjrrMsfSX85yRw4g5oKslj1hKqQSCbe9t0ck
	=
X-Google-Smtp-Source: AGHT+IHttjoA/P/DpxaW0QQvblJ4IOLPQHOvuoarZ6WsjdVUR7JpsN/aqJGlSAQDLuJJUKWguUoFYA==
X-Received: by 2002:ad4:4ee1:0:b0:686:3a43:131c with SMTP id dv1-20020ad44ee1000000b006863a43131cmr5344230qvb.102.1705952892777;
        Mon, 22 Jan 2024 11:48:12 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id pf9-20020a056214498900b006818be28820sm1288601qvb.24.2024.01.22.11.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:48:12 -0800 (PST)
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
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH v10 net-next 04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Mon, 22 Jan 2024 14:47:50 -0500
Message-Id: <20240122194801.152658-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122194801.152658-1-jhs@mojatatu.com>
References: <20240122194801.152658-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For P4 actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the P4 action information
for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index bfded7ec6..c60f3ccf2 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -116,7 +116,8 @@ struct tc_action_ops {
 		       struct tcf_result *); /* called under RCU BH lock*/
 	int     (*dump)(struct sk_buff *, struct tc_action *, int, int);
 	void	(*cleanup)(struct tc_action *);
-	int     (*lookup)(struct net *net, struct tc_action **a, u32 index);
+	int     (*lookup)(struct net *net, const struct tc_action_ops *ops,
+			  struct tc_action **a, u32 index);
 	int     (*init)(struct net *net, struct nlattr *nla,
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c6a783a71..869a38570 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -726,7 +726,7 @@ static int __tcf_idr_search(struct net *net,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


