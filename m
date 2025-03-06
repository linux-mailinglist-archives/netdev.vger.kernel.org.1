Return-Path: <netdev+bounces-172673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D4BA55AE0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9CD1897BF9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333027CCFA;
	Thu,  6 Mar 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNK61pSw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C623DE85
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303455; cv=none; b=mb139oLtwsyvxcA2oBKYP37zIGNexbY4ZPSYRmadd7zptdi7jsQSV/4YXApvcx/THshl+tjze58N/MP37sOuwYMxpH2SuWKPweHJxCz3CV1r4MV7GhrM83Urn50DbozryEo85vdTGleIf54OCanYJPER4+axaRL4wrcAiYhMLRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303455; c=relaxed/simple;
	bh=eyWEmYxG3QhV069orC2Rm/85A5m0bhmcxhmdQJQYTZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZiJN6g46JPkuAgHLLYshmDzkP7ijvo7aEM7Ky5nv2kZnTT9tc+OnotspELRQKfCcJUjmcncq5IwP1UH1W+72JHPR2jDQ7shrs4T1haV3LwtwU1o1ASAUnBK1wJt0fF+lnxjRxwZfD9AGaHRgckm4HaXf0jd70H95vIzQgm2J0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNK61pSw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so24512865ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303452; x=1741908252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qBbp7zOpqEZK+KqI13JEkpa3d9ZTwtuQoPdI6m5db4=;
        b=TNK61pSwkTXtxjpcDtShxE+Ucp7dQ+pXJ1TIxpNtS0Ji3ZnPNogkpEBOA7cPviDIcB
         mblShrzp6gX/1fx+JXklFGAQnS6UecT6hc6U4OWimjgvswVqPzempYZM7RZaMu4abdyv
         GFnzTcWg1tqPfNSjmG3zNNGb1yToJNrQN+lcOJ56VvSkoxSxu55ckcYk49Db/khamSBJ
         USCzl2nSOAbOZjGYX/TMCmjMmbOp2WOJbV75RaPeGvVFs71KJzvS00+01W6aGc1Ubt+g
         nd+qyy9xrNCln6SDKXAlJ58o+dStkeF09mCZpX+nWOHmU154WYN1uhw2Jl5lIt/3OMUE
         H67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303452; x=1741908252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qBbp7zOpqEZK+KqI13JEkpa3d9ZTwtuQoPdI6m5db4=;
        b=fiJhqVT9t65zb3lfCiTosGwYndRGlm0ZbliNi4wER6mNMGhXXvRUu8VqM0nSP+fYhY
         O0apLkgAeFtZqJdEzHE0jIwseWJQBOwYWW6+r8v5kIiRLmRB+Y+0VFjV5+b2+QPyG/ez
         WLoeDNGKf49KRM8WLp6wKxU41IqqxiVXrD9Dp0lvQGD2aubEnRXGZAIkN+Nk/X2LqbN0
         wsRJPUEEuVFhlwgk6LmOipWKXsqPDUb4T3fAVDZWRq9tfCes4XFBdz9M9AAlpICs9LF4
         Qn75YZH8zRRr6A/luEqgxX+IICqejwoqxU/oQU4AdZstTO+OOL0MeE/h/bodqLsT7eJL
         V10A==
X-Gm-Message-State: AOJu0Yw8B1vn9GKqrIDZob81+wVt8DzCOjrPQDxKwq3ANPvkwI5/OJLq
	cvRlrJcsUWv2NiMaENeQzEoJmoII/Lun8BihojaxE+XE3bpckeObRIScZg==
X-Gm-Gg: ASbGncsDfVO/D9b5WmTYt4ozx577ye+x5RU4MnhBS7sRSspGy2s+QclaLntbgpencGR
	FrRJj9/8JKFVH5fz9qRyBmXVm6ckaNl0kQLXXiTXyipZ0XYmbpHxnIwm0k72sATSeNYyLSR916j
	DCWMjg8VIoRTRszhHyPLuq2CEz3Ac5qwHC156NYckEvtAob/5RMzoQpySbcc8hbofFrfqk9QZcR
	4KExlgcB34/goyxY40w+oPYLyhsCtXqHCDi51iC6LRaWu2iHY37eUqDvwYuAQQjrhhpX313tkqE
	y/RlbDWBfUI4Ep7oUeNhdZPU1NAtkgStActAzfhLe2ii+V2wk8wJ7HE=
X-Google-Smtp-Source: AGHT+IHsqMI7o93UDZf17RO4zCMks13MUBEB5vYjNGkcP1cNz9bVnWXQyjeBUZsVDX1NYZPXh54lsQ==
X-Received: by 2002:a17:902:da90:b0:220:e156:63e0 with SMTP id d9443c01a7336-22428869a45mr16819995ad.8.1741303452590;
        Thu, 06 Mar 2025 15:24:12 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dddd8sm18006285ad.12.2025.03.06.15.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:24:11 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	mincho@theori.io,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 1/2] net_sched: Prevent creation of classes with TC_H_ROOT
Date: Thu,  6 Mar 2025 15:23:54 -0800
Message-Id: <20250306232355.93864-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function qdisc_tree_reduce_backlog() uses TC_H_ROOT as a termination
condition when traversing up the qdisc tree to update parent backlog
counters. However, if a class is created with classid TC_H_ROOT, the
traversal terminates prematurely at this class instead of reaching the
actual root qdisc, causing parent statistics to be incorrectly maintained.
In case of DRR, this could lead to a crash as reported by Mingi Cho.

Prevent the creation of any Qdisc class with classid TC_H_ROOT
(0xFFFFFFFF) across all qdisc types, as suggested by Jamal.

Reported-by: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_api.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e3e91cf867eb..6c625dcd0651 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2254,6 +2254,12 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EOPNOTSUPP;
 	}
 
+	/* Prevent creation of traffic classes with classid TC_H_ROOT */
+	if (clid == TC_H_ROOT) {
+		NL_SET_ERR_MSG(extack, "Cannot create traffic class with classid TC_H_ROOT");
+		return -EINVAL;
+	}
+
 	new_cl = cl;
 	err = -EOPNOTSUPP;
 	if (cops->change)
-- 
2.34.1


