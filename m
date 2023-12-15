Return-Path: <netdev+bounces-57885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7471814672
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF372860C2
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42FC24A14;
	Fri, 15 Dec 2023 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bGwVccmt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765518029
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5906eac104bso392442eaf.2
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702638665; x=1703243465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+/3WYnJal5qQrhtD/BrhE5I0BuQauaDRcCBCns3ngY=;
        b=bGwVccmtX+tqB78fbUEdVb6VTzxgmGcCVQtaOadZ05tlXs5nHPA4gEEVbmqGZPNnnq
         5KMrOZjPA6sGIQ2q60kPmoKis31qzFPvDnC9Ktvy//0q1UYvhViA/MhXgHPB6SKt1PEi
         Xp9Xu2CxBW/guIh9zYxS/uBWjqY28tNtJoYlH0pBPkzz71C+UkU4pGnGocqrGf2Tl+0n
         c/l/1AXIfeD/az0inWUd9oiI2hkebPdVisBVeBHsu/MLu4Gbse9CYtz/lPftw+tdvyvY
         xvabTQ7DhDu7ko5s2VMf+TQcbOZdbnaWrntQ5L5TEBa8E8obtW4o/2Pj1dU0ciO8nM6M
         CnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638665; x=1703243465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+/3WYnJal5qQrhtD/BrhE5I0BuQauaDRcCBCns3ngY=;
        b=RT2fWx5PqLaiZeQ488Ei943qMU0V5asoR5nzow25FLmZoISunV969y2cQAHqu23Ya6
         Sgp5VbmnqA8zgpVxCEibfSESO3QckDaSVSleYShZDriDjxC3clCLwAc1G/ghavY/YGqP
         hlVijG2fgJCoNOtGIoUWC+80U1MUprhKL8lMeufMxPnHDP10baHNlJ3bFuYB0veR0tWT
         8DWszxre2zim2qOsxcPOwUmIzUXvndLExlp7urCuLaj2krzVxLIs/0FMA97JHfSb3sPr
         ECquDHobdZ02Y93xfXZO/NdQLc2GPCOMe9adQIzjZ4lQPl1OIp64BkKC8Gg8KU5oAKze
         lXYQ==
X-Gm-Message-State: AOJu0YyfsrrvR07Y98lxntjw87Y9EMKiij/JRY+8u66l458dJvsMlR+A
	JL+a1bI9NyQY4SW+NQsJUHQ4mg==
X-Google-Smtp-Source: AGHT+IGmq0WFwAdvKgBBBVEI+OvXj4G8nSMfmteJRz+UH79WNRvIEP0Fc0Uod2yVqksSxv0F7EPM0g==
X-Received: by 2002:a05:6870:4201:b0:1fb:20ca:95df with SMTP id u1-20020a056870420100b001fb20ca95dfmr13298017oac.39.1702638665373;
        Fri, 15 Dec 2023 03:11:05 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id s16-20020a056a00195000b006cb574445efsm13329045pfk.88.2023.12.15.03.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:11:04 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v7 2/3] net/sched: cls_api: Expose tc block to the datapath
Date: Fri, 15 Dec 2023 08:10:49 -0300
Message-ID: <20231215111050.3624740-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215111050.3624740-1-victor@mojatatu.com>
References: <20231215111050.3624740-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The datapath can now find the block of the port in which the packet arrived
at.

In the next patch we show a possible usage of this patch in a new
version of mirred that multicasts to all ports except for the port in
which the packet arrived on.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h | 2 ++
 net/sched/cls_api.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index cefca55dd4f9..479bc195bb0f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -487,6 +487,8 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index);
+
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 6020a32ecff2..618f68733012 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1011,12 +1011,13 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	return block;
 }
 
-static struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
 {
 	struct tcf_net *tn = net_generic(net, tcf_net_id);
 
 	return idr_find(&tn->idr, block_index);
 }
+EXPORT_SYMBOL(tcf_block_lookup);
 
 static struct tcf_block *tcf_block_refcnt_get(struct net *net, u32 block_index)
 {
-- 
2.25.1


