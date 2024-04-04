Return-Path: <netdev+bounces-84833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB089874F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 207FDB29A1D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B01292D0;
	Thu,  4 Apr 2024 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eJof1qYX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB586ADB
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233431; cv=none; b=ny4tVqTmSFMFgYPj598IxCWtkKcRmN/nupbEiyLOAZN2lKAd23XcCPc4tCtJquGp7fLSGWR3m6JU7OJUzJQirYfD/vSsnUyEFcN45SI5Hfc2qIstAbkDwX6IeGeYJEP6dggxSLJIOOlq2y6xFrJQDVU4cG4sdcdK0fbgUmjQ92g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233431; c=relaxed/simple;
	bh=b8bptETvG84oiXi8WEQCccf8XZFYg83kzkS/2d51CA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WljzRGc2nbM9S6wPBxX6DLR8V55pk91mItCL8WuYYWnCT1qiodVtuLZ4b9hiq1ZLoGIbTQ3CPALBBdojwBu6f0/qkFXpGXcMdnGhJahm+3m5FLqvr6F+KJCR6mKKJ+GmsFY0DlrZbx7VQdhPQzCQL7JePWOa4v/9ClRL5jcDWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eJof1qYX; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c3aeef1385so634958b6e.3
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712233428; x=1712838228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=eJof1qYXcVwf6Zf86TWt/vsshpLhtV84rsP7pyxuiok7ilDDHZHSvcdDJMO/rjX5sB
         +WTKPIwWUP7x+51s/DaDNwacDXOSDTtzwtome4/wKySxeu+T2EobyLm8xIzimdSwC2VP
         WW8R5f3CixnxEGEH/FeMETrBVGpSU5ktYH5mtLICwbD7JWaau0ual3D4wx3E3OX3sevB
         wHAX/3XnsZgINDPgbujewGN1v6mp/n//MPqaralM/4iO4M1n1VCHosg83kGlpuNzNdDt
         P8OMj2kpAfxIzdxCK6YaXy5pEDocXKgHa5xWgtBqZq9q6zErImkXfWO8aEHC/gvnh1qs
         72Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233428; x=1712838228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ayqzmg/dq1ZxpnFUTOb8nK1tSXrGpGgrmAqxDfILoE=;
        b=ot+/kJunnpRf5ogFpYdxAlmKASK7V4TfnrZA0HCcpvdqNS23612gnpqGwNSGRvtRUn
         hTgTsO8/BWs5PPYw3joi+L4wb0MYkOQfP7U0a6M3jROWvSpdHqe9SMV+eaTx7BgFOa1v
         987hfKux5U0YJYLFMFBxHT+HvbnQwX2+y/DiwxmANkXjtBF34LVr5dihMmdEXNxCDaCL
         RIEqAdHVbJZ45TkGya4/C6lmEOXjeRqCt1TAknGHsk+2hLaPDX0zuEUde4kWkkCxvjlg
         vd45HCQKVxUeTVHgSNdbyRv3sTi1EVKwnM8RwnqhFwUDAl1GFIi8AbgeYO38GeSmeicl
         nLGg==
X-Gm-Message-State: AOJu0YyWFby88/5GnUXKlMWuwG9WOlT7sKOfjntoJEjgzWxXItKROcHt
	s+oa+L8Gi321gDkvzeXRUhAjt5geO3FrTPrrY7va4KzPZHLIrCXUTBtEiBLiN3PtbSW80MX5Rnk
	=
X-Google-Smtp-Source: AGHT+IHWBCwoTzqRECXiQ8oetTuXFAjlVIj4lwfLZn9CbSrt05E081JoGio/ZtBDJxcZlO7m5KFJXw==
X-Received: by 2002:a05:6808:250:b0:3c1:7eac:a8a8 with SMTP id m16-20020a056808025000b003c17eaca8a8mr1876878oie.26.1712233428486;
        Thu, 04 Apr 2024 05:23:48 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id bb19-20020a05622a1b1300b00434508cfb62sm584945qtb.79.2024.04.04.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:23:47 -0700 (PDT)
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
Subject: [PATCH net-next v14  04/15] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Thu,  4 Apr 2024 08:23:27 -0400
Message-Id: <20240404122338.372945-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404122338.372945-1-jhs@mojatatu.com>
References: <20240404122338.372945-1-jhs@mojatatu.com>
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


