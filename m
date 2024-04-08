Return-Path: <netdev+bounces-85721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE189BEC6
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65713283836
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DF26FE1A;
	Mon,  8 Apr 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wvjwbxo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62C6F060
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578821; cv=none; b=DyGZHLPgHn/RaBXHbSYfAfjVghe7mC4rnxrEptW7iXpgnJRXVXWXeFlQdBybFu/vSd9hdZWowfhyge0z6+Y0ijljBfUrOKSSeDVy9jUmpt/C5FMsWOsroTfv/Ub9QkBMmKvpHAmbXjroxFAfIjeN2t7vFrbsc6gTqg6OM/9JbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578821; c=relaxed/simple;
	bh=b8bptETvG84oiXi8WEQCccf8XZFYg83kzkS/2d51CA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbVgCIYZJ9rIRh49nYStyp+BGKuopLoq8mnBBmyq/V1SzWFiaxigDtvWPFCazw46p7lmbiFg7bd7I3RTDvyKGqzKw1MHW7lo/rwgNVCdK6Itc9HaxsPFRPZf+8AXsGdJ2TuGI/Y9F6fC/tCSUJh5fM09eW15jMqQrhKTZS3RPuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wvjwbxo5; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-229661f57cbso2375887fac.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 05:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712578819; x=1713183619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=wvjwbxo5damCd/0JNxSCHwxSlRC49LLI8jVShmSLNyr2WKt4QeOYWGleNwIVfYN34C
         ZIw0qbtFsuM8vzSQlT++aKO8H/rvbJAQotSFhbGdpZgpd67EbvGNQv61VXfosIP7k7s0
         BHirWHm+yhMZwcnKv/oDHmB9i9Jdn5/d6vV4SkQe4anZ2oWmd75La9gwEwg/kwsbXhp0
         p7/s6y/kQs1ih4WNy+Liyefm2WvZAs1Oxo6RjB+aoGvn3eF9+dGKyKkGlfZuEprwJDgX
         cwFOovCrASOH328VvjVY/UT1umSBnHbz3G60kXx6R+GtZqnHT+4a96TM6svD2zxifOPQ
         PC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712578819; x=1713183619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=QbpKMkq5a7T47tsugnA8YseulktupCvt31EFvvBgwwqC4G0txGIyzhOKq+cYi0J+eY
         TN45ChXl3xMXKATU0xnCfXWfrTTYmUyl7+yq1I0QcWFZ9HHmNK/gmZmxZoavadEX+qKP
         ZP7QSc+4MexYSJbrdmFQssR9VtPYjd5vE3Pz7ETs1Vp3UktfpxX+t2gBqYZ0GUdsFbgZ
         mjhG123/SMGtYlhfoMHxfMmj16Gy47zvEyT6B7FGUHcnJbX5CR9UBmYiUheUPS+7R2DS
         KCiSvNY2m7KbUZpKjUfyQaabXch3IrEaozes7uC1p3z7bQsiVtpF+5S6EjRTlzwE+dmO
         G11w==
X-Gm-Message-State: AOJu0YxNT9nXaluOtim6OccIp5Gocqn8Myi8CGzAPPdHvYyrxGOW2vHg
	2fc3GbneuC8z3Rjhwd8GezJTxkBLBDPTrSIuWQ2iEz4XJlPCTP/HEAmmQWRFNsmlAcpSGdxMmuY
	=
X-Google-Smtp-Source: AGHT+IGmIy3e7no2s4+pW7wEMrWTS5LYSv9QWlbc1ecMpjivcdifPUgAT1ROvKjwHb4YaHn0TbnuCg==
X-Received: by 2002:a05:6871:8801:b0:221:96b2:5a4e with SMTP id te1-20020a056871880100b0022196b25a4emr9343695oab.58.1712578818949;
        Mon, 08 Apr 2024 05:20:18 -0700 (PDT)
Received: from majuu.waya ([174.94.28.98])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a148a00b0078d5d81d65fsm1936142qkj.32.2024.04.08.05.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:20:18 -0700 (PDT)
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
Subject: [PATCH net-next v15  04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Mon,  8 Apr 2024 08:19:49 -0400
Message-Id: <20240408122000.449238-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408122000.449238-1-jhs@mojatatu.com>
References: <20240408122000.449238-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For P4 actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the P4 action information
for the lookup operation.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 59f62c2a6e..52aab6dd8a 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -115,7 +115,8 @@ struct tc_action_ops {
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
index c094a57ab7..87b6d30077 100644
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


