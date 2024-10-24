Return-Path: <netdev+bounces-138764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C8E9AECC1
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81041C2326F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60751F81B3;
	Thu, 24 Oct 2024 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NvI2LNsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4BE1F80C3
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788971; cv=none; b=jYLZeCSFyOcVn17P5l9oZ4Sbp79obGjW4gLUp/1SpBA/mvfWjefRl4rwj1HfGOKdSNuyJheGsSga2a4SMBvSh26UbolQVYSFVYBEuYZBFIOYeSRphXP4q/RbvB76j5bmPu/0S9SvXaPMFHq7UM3q82OqKDy4D867g0P0nNS2RCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788971; c=relaxed/simple;
	bh=qKqkMGsYmpuy5PSCkQ4EF3lEVszQwWbtNFYJK9p8kao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r0jAfWC1mAR2910vPxRD82f7d43ZII/zhVPJ6XRY84xcpru8cZoUJlC0HS/1wRQx/wKl9yOkIilDyf/H74QyxmwJ053KZTe3f5qXuz+sivbfhFDw90LO5hmc9ILi8XiXZ0aj435L3GbmSDG3SCg5WIz5AQSi7gXyZZ1ABIys1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NvI2LNsb; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1474b1377so79510585a.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1729788968; x=1730393768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPSh3Z+ZTMZDlTdUsv3BdKV7k7VjnJt8nSE7oQ/GPbc=;
        b=NvI2LNsbV0iUgegw5KTNIJ3+g8i0g7N0g8L3Yyw9fOjZRFoPzfeCKu+DDLX00ykkC3
         PMXd5vtAAt4rWnV6YadJT/i/8ymM+7m0pXSvocIXNkYrq0eI3rv5UpepRpmPb6Kptj1E
         SbHkoOqJVgZF7QSGOEn1Zs6Ahal3GAFnqb+PMQPLQ+X5O63hAVwZuwFfWuNAPpkFyglL
         jwd+Ny+9306zmGMgPRqkhqn6KdEukNKsykAZWAhhHIlqFp3AvZr6qe79lmKy0dWTWH77
         n9aMMtLL16XB25e2exzTNjCsTXJ/OXJU4Fv/4hVAm/cMJp7ebOvbhAiQrgb6p0z5CVvo
         m5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788968; x=1730393768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dPSh3Z+ZTMZDlTdUsv3BdKV7k7VjnJt8nSE7oQ/GPbc=;
        b=R1hy1dN6OnkTq+J+HdC4c9RxB8cJYggCDo0I26Zmi0cP74emBVMOlRze18WnBG2V2R
         YGutHuEjPj+NbHtzdwbaRnFrZauBECKXKjGriHvAkr6sVuRjPPOZM+v8aIcGoRXKYcSL
         TPjwEM/J0aE/CWFsQKwYkS1vRstlH+ZP1ISv/4z27MorlEj3hJz5TBTsCL35lWgdqJDL
         zMILjCuPXLpPiy6Q93Il2owm3xiMdaYvsL4K5VSJZ1Q5ynug36kbj2pAUtk6mpEclmhx
         /ZoRSgudR2rBlt4iA4IZ7Xp2iv6GAK+dddZpSnIsBECPAUHmuF30ywyv7qc+KL6GQDDG
         +iSA==
X-Gm-Message-State: AOJu0Yz3tsT7IRvsfxcCkLGTPrLKRXErVfXY8ZU1VhKgz6VHZLa0Jm1f
	qQqj28I50zLcZqoM+a5iMe3eBBvA6TY0gCteXmeaH/xRHbVHZ+6xOSMS92U5iYEuSxAKSxODTQU
	=
X-Google-Smtp-Source: AGHT+IF7eQYrMtAVUppKAeLDMrz3SD35N6qXJSJopnuYFAQi1SBTEN+L8NFbYV0OXaJSZJHIZc2z3A==
X-Received: by 2002:a05:620a:4691:b0:7b1:4480:5d77 with SMTP id af79cd13be357-7b17e5b41ffmr863779685a.49.1729788967685;
        Thu, 24 Oct 2024 09:56:07 -0700 (PDT)
Received: from majuu.waya ([184.146.41.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a7624csm504849785a.108.2024.10.24.09.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:56:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: markovicbudimir@gmail.com,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net-n] net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT
Date: Thu, 24 Oct 2024 12:55:47 -0400
Message-Id: <20241024165547.418570-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pedro Tammela <pctammela@mojatatu.com>

In qdisc_tree_reduce_backlog, Qdiscs with major handle ffff: are assumed
to be either root or ingress. This assumption is bogus since it's valid
to create egress qdiscs with major handle ffff:
Budimir Markovic found that for qdiscs like DRR that maintain an active
class list, it will cause a UAF with a dangling class pointer.

In 066a3b5b2346, the concern was to avoid iterating over the ingress
qdisc since its parent is itself. The proper fix is to stop when parent
TC_H_ROOT is reached because the only way to retrieve ingress is when a
hierarchy which does not contain a ffff: major handle call into
qdisc_lookup with TC_H_MAJ(TC_H_ROOT).

In the scenario where major ffff: is an egress qdisc in any of the tree
levels, the updates will also propagate to TC_H_ROOT, which then the
iteration must stop.

Fixes: 066a3b5b2346 ("[NET_SCHED] sch_api: fix qdisc_tree_decrease_qlen() loop")
Reported-by: Budimir Markovic <markovicbudimir@gmail.com>
Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

 net/sched/sch_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 2eefa4783879..a1d27bc039a3 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -791,7 +791,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
-		if (TC_H_MAJ(parentid) == TC_H_MAJ(TC_H_INGRESS))
+		if (parentid == TC_H_ROOT)
 			break;
 
 		if (sch->flags & TCQ_F_NOPARENT)
-- 
2.34.1


