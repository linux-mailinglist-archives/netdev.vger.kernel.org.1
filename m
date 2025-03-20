Return-Path: <netdev+bounces-176614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C62A6B19B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03D6884614
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F222ACF2;
	Thu, 20 Mar 2025 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOAzoTn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE322A7FD
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513154; cv=none; b=pMZNgP3OMPwtYyOgzCLObG6ziqbK2mBMZ3hzGaEeCIEVM5KmEv/iWFq2OfvoaudYwKfOGhMY9Z62W1I4zMUZaGOFojSq0kzqGyzlJIs54c0FHRFn4lm3c+hWzL+GzzDy8+5o75elcU2JyE+IBI3JBaDhoXPtzn9t4udjuxjOlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513154; c=relaxed/simple;
	bh=ISaSMzrWByvy0aKtLbM0WfTd5Z2PAmIJUgiNxzgXeIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DkuYJDjxfrjPmxYcSRx/eFozVKIx/b36+3iP2Yk+h+50PheVxudqw7FM1/QWL5uJrrfyFVc/yaLWYtHNo97Kd4p3+nTNL9dNoqJh0teJfQ+QwbKh8yxOPTqx5ID2bVV1o1wLvEVIXNUelJamCMo2heSWZJ6HYIz6X/3u3L61nBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOAzoTn1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239c066347so31276475ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513150; x=1743117950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcD927YR4xHTSf6FJJ2CaU42WhtYVC4m/9wxjMe4NXc=;
        b=hOAzoTn1TaqpHl9yXuzkL9BcrHj/0cpqT17WLb80/syU1P5d1PnjrUI1Q8TkZMzed6
         M9OrHEcZhstZLYuPwtP5vjAzoDfDoecZkNl6Npz/uj1L42R5yeVTMCRjUumqwK+0+8If
         e269eWPl/b80s4ZvNlwhbjl9qAmu5GkEyLnyx/amv19QjB07mK+7xFlNSGhdrCj+cUxB
         0GenmJJicGfB/XkK/ZY8d6/RgqJhKouyVHvDiCK5XgIR/BKbPRrBN3OILlmTco/lcPYP
         mOWvbQ5MKv1mKjP8iQ5tF2LoDXjy09Y//D7j2RSUdd2mxNVvTbN7lQdiOWMpd1NK/DSs
         ONHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513150; x=1743117950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcD927YR4xHTSf6FJJ2CaU42WhtYVC4m/9wxjMe4NXc=;
        b=WfCfg9Lnc9VeU0aDqc/BSZ8yzAkdKrsyqEhJoWWBATH4qJHKO0Yd/tqr1qqvxkBVw2
         Np0XC9YJFjUBwa10lzTCLoffgP4oYOsl1Y8/A+7NorIEPJOT/quMf7nVcXiUjOnnWuL7
         9bIPv//a/obWlLI0R9DYG1TCbBtXyXJmTUxNWV3hHlfzfcOJL6oUitYI2S/n8oOnm6ld
         0oPutA9LXp8ma7cZlfc+bwunbmeBI2o0sLZRXefbSGPnUMTHu3PGHsXBP86/twU7BvHH
         9PIMTIJxaW0GVJNZf+4YK8+Ixsc0qB2uBHX73YM3j3KgunLxekeqnTc2FA5VKN4AzvU2
         V37Q==
X-Gm-Message-State: AOJu0Yx6TG4yV4ls5fDpcLSA0NsYhBUofumYf0So1RF+vp5Uo/NY/ape
	i8XjmozQqT3v6c9IAShhKxVuP9nhNF8U5IEbEiFDrj8eHMmE66Eu2hPGAg==
X-Gm-Gg: ASbGncvt8SP8xx7GEF/mTRrb02swXFhr9z1QItElIcJOb7jvlf8BnL0a7SP1dfooTex
	sMxrkG7ih4cnUC5+LnzwkancNGwMu0NOAYCNjZEgfnrzJBlmRtVeANcv4LSG6hptSQTVbIbiBk1
	zsFwGqt1HuO8sAW1jq7Sunnql6y4cv2PK71BcuoK9OmIZuO2MRIbE1MUaEd5a/p1G7JBvPl6Vgq
	/OwNyyZPOa0gu9pKXrMuK/ZHwGc+gDlpL3mxUwI/lVv3WdDBLgQK0TvN7W8Xx3JUvviWAbmy0gw
	EUfh0l0F9Q34A0+GqXnhcg+fzVyhdf4LmRTSd9jcVt+Zfx/tb78xbYc=
X-Google-Smtp-Source: AGHT+IE/RjRC7a53JAlbtIjqcwkXulNwIVT6UIF9zX2BSTOMo6UNP3gVjWrs15Gh8AFjisKQMt9E7Q==
X-Received: by 2002:a05:6a00:3d0a:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-739059667damr2258477b3a.6.1742513149544;
        Thu, 20 Mar 2025 16:25:49 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:48 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 02/12] sch_drr: make drr_qlen_notify() idempotent
Date: Thu, 20 Mar 2025 16:25:29 -0700
Message-Id: <20250320232539.486091-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drr_qlen_notify() always deletes the DRR class from its active list
with list_del(), therefore, it is not idempotent and not friendly
to its callers, like fq_codel_dequeue().

Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
life. Also change other list_del()'s to list_del_init() just to be
extra safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_drr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index c69b999fae17..e0a81d313aa7 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -105,6 +105,7 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		return -ENOBUFS;
 
 	gnet_stats_basic_sync_init(&cl->bstats);
+	INIT_LIST_HEAD(&cl->alist);
 	cl->common.classid = classid;
 	cl->quantum	   = quantum;
 	cl->qdisc	   = qdisc_create_dflt(sch->dev_queue,
@@ -229,7 +230,7 @@ static void drr_qlen_notify(struct Qdisc *csh, unsigned long arg)
 {
 	struct drr_class *cl = (struct drr_class *)arg;
 
-	list_del(&cl->alist);
+	list_del_init(&cl->alist);
 }
 
 static int drr_dump_class(struct Qdisc *sch, unsigned long arg,
@@ -390,7 +391,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			if (unlikely(skb == NULL))
 				goto out;
 			if (cl->qdisc->q.qlen == 0)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 
 			bstats_update(&cl->bstats, skb);
 			qdisc_bstats_update(sch, skb);
@@ -431,7 +432,7 @@ static void drr_reset_qdisc(struct Qdisc *sch)
 	for (i = 0; i < q->clhash.hashsize; i++) {
 		hlist_for_each_entry(cl, &q->clhash.hash[i], common.hnode) {
 			if (cl->qdisc->q.qlen)
-				list_del(&cl->alist);
+				list_del_init(&cl->alist);
 			qdisc_reset(cl->qdisc);
 		}
 	}
-- 
2.34.1


