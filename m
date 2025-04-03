Return-Path: <netdev+bounces-179182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55780A7B0C7
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1212188DC39
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C411494CC;
	Thu,  3 Apr 2025 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJgPTN5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335F12E62BF
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715013; cv=none; b=pMBg9Tc/yz3aUoOhsjupQolontgYdzQxojnKmDqj1mXZLFZIgxGfXxmxo5F3l5VZkBdrxI8icFAeZZumAjUt3k8QU3nLSwTK4pXYd3ZA2BkrPUPNiVoBQFmlfutKQyQUMdmPw7GJTwu9wVFH5Rhsu2L4bcc/uGFtBB5jcf5PdgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715013; c=relaxed/simple;
	bh=t6tu05ly9QjPCEx8sdlAFw0widD9kgarU7JHERAbJmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3IyJ0oYeOmOo1dnYP5TYYimoL4OyORTfzyd4W8UpFnKj9ZzElxDpy+FR2UbVPZ10hGRa+/YdgfQn6AN36ND7zM5ekv1XdJpjEO8sPUj6IAMN1kL5IgQZGHhXhklf5kNscfFW88kdSbipsRdmdriOp9tT5Z+H7uoxAWO+jkUbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJgPTN5n; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso20311625ad.2
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743715011; x=1744319811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzYxyoe/a5YlwqrwUSKlRYIYxamKo+68GX21nB8fjLs=;
        b=aJgPTN5naEwi4TIxF3M8bteezih1OwNqW+B3W6dkRixKCfuwqCaF3GDJl7r1IAJ/lW
         X8En8+qynschQtuqgLGuOWHPnw1AiAXx5H1PTaXFT55lSVk5/8eC/lPkOkR7auBTT3FT
         DMDUussrogDN3AhPUhIx9ZhcHJ4mttBlpextTS7+po2IEnOoNzmxhcwCfFkuGYS7Gj5y
         NAYM08UCpUcuR2YcBKiUvugbeLqzqzldnQe1AUcxQ0Oum8IQy1SGlBKaTcnHbFqhimmY
         fURLU4VwhyhUJqpuax1RejnKyFiLjgv0dO0N0NGzzXFuxANplE9PuZ2R9cAhZXr7atJF
         yyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715011; x=1744319811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzYxyoe/a5YlwqrwUSKlRYIYxamKo+68GX21nB8fjLs=;
        b=cpyU434d3XQ2/T6EnTnOnAuAld2LpoKJfshE4Dq3bBcoA+vmpN7HhJW50kIEO/ug1D
         e0R+9Q7VJTaZJcElhyQysq4Dzw66L5P3lEQ14fQbyFGeGfMsr+6O8WAkeRAFDIQ9pdD+
         nO5gnRAuZN1ajAEHPCdNcvRLmc9LAKyQwdkXQ4deny7yZpm5Jt8JVwpylMGdhlkZC2iq
         F+s4sLD1HUhA+EY9X3chReBMPsN+3IZmla+8yUHoSLt+Raha95IQV197U1zAf0PDQNZN
         5mmIQXKr0wVoOJpl6rlKxaJ/hGMG0qo1LperPIJzpYzJxfLlOMRccOSl8rBhg7HiHmL1
         ZiFA==
X-Gm-Message-State: AOJu0Yzuq1iRZqB2tbZzqxaIDZltZUnEyFMVE5LRFjdracHAbtWh/TLf
	sM+o3eFcnYyecyaxrdQpYIPknsmDzvkm2U4bMzjHYWJw/46Oi4xggl2ctw==
X-Gm-Gg: ASbGnctCFk/gjEwx43RmzdgJ3S4b/E8lPtCh1uy9Pbxj6rY/BVS+qGeNnwFMsgjp1J5
	49fhCx3n08lH1MjQLqgk58Vt01uybvhG3M0Cl5AL1RlgwSnWO9BH/iaYnwYeQZawkW4X7NigVAP
	kcbxtKWhED6x4PnyCo8mBMmfVwKsYamauScB6Y+xOg1JZlqq44GWWbHtwHwA46GTsWr5hdVELXc
	lP9+AljNriYXjxS2edvy2i4mZtFZAv7eb0ynPaUz3OCIidw9/jxVPqO2HjO+VfL52AysCbI1JfW
	8kIADTKmtfXvtZJv41V6ch6vh7rVvEfqtv8T9AkDBdK5kixG/cm87/Q=
X-Google-Smtp-Source: AGHT+IGFZj5G1G7xsCIJHl/I81lAboacRl2MLj8b5PC3HNbblZmf+n27mr5h06Xplgm4QJuoghdwBg==
X-Received: by 2002:a17:902:d487:b0:220:efc8:60b1 with SMTP id d9443c01a7336-22a8a0a38c6mr7123775ad.39.1743715010984;
        Thu, 03 Apr 2025 14:16:50 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm19332145ad.181.2025.04.03.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:16:50 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: [Patch net v2 06/11] codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()
Date: Thu,  3 Apr 2025 14:16:31 -0700
Message-Id: <20250403211636.166257-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After making all ->qlen_notify() callbacks idempotent, now it is safe to
remove the check of qlen!=0 from both fq_codel_dequeue() and
codel_qdisc_dequeue().

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_codel.c    | 5 +----
 net/sched/sch_fq_codel.c | 6 ++----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 81189d02fee7..12dd71139da3 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -65,10 +65,7 @@ static struct sk_buff *codel_qdisc_dequeue(struct Qdisc *sch)
 			    &q->stats, qdisc_pkt_len, codel_get_enqueue_time,
 			    drop_func, dequeue_func);
 
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->stats.drop_count && sch->q.qlen) {
+	if (q->stats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->stats.drop_count, q->stats.drop_len);
 		q->stats.drop_count = 0;
 		q->stats.drop_len = 0;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 799f5397ad4c..6c9029f71e88 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -315,10 +315,8 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 	}
 	qdisc_bstats_update(sch, skb);
 	flow->deficit -= qdisc_pkt_len(skb);
-	/* We cant call qdisc_tree_reduce_backlog() if our qlen is 0,
-	 * or HTB crashes. Defer it for next round.
-	 */
-	if (q->cstats.drop_count && sch->q.qlen) {
+
+	if (q->cstats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
 					  q->cstats.drop_len);
 		q->cstats.drop_count = 0;
-- 
2.34.1


