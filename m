Return-Path: <netdev+bounces-87958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E068A5151
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6AD1F22679
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632D84DFA;
	Mon, 15 Apr 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qm7PWi8x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931CE84DEA
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187273; cv=none; b=tH2vO2nbO/hna3W6nFkDupb63EFvCSoxMJLGsmW0VYn2s12jh3OthnBmwobPQx8YUlUgssLyrgqG70wSyLyjFa8A+SoQF2qjjL7HAu6kocMISQpqX+nVfnhsM1t2qNVOotsyvPMBMXt5DHVu0DUUUJ2dYcbHQZ9l5iqH4beKsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187273; c=relaxed/simple;
	bh=HLoq1i+V4ApQOMYBc6PZyJGfENZMo+oN8p9CzxOHy6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QPxM9tSB85iHD+qeuvGrNqVX5UJMtAHBX8Ei8FY4Dkj3OGIN6966e/1bfJT6JdE5zia3Kkbp8KssekLK1aG1BWmiFRgaMLM5nT8eQxgKpByRZBf3V08kDOPTRb5xZ3MW3I3a39eZdSQC+fV0bt7jQereXoFWmM0lbHPj5Vz31oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qm7PWi8x; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618891b439eso49547007b3.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187271; x=1713792071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t2TA0iHMw7gZTifXWG5WTrNRKCCbxVowF92cfYPY/pw=;
        b=Qm7PWi8xAPVgSDAFOHy4av01U0b5iR6yh8R4LE+a2pP52EM4/UjDHnEDQAGzpbEqw8
         PNwqLKYoao3fUCcLO0MDMdtA/sKRdkbnNw6Y2onZXgmzQEKeHlPr9ctxDnNT7ggxyKHE
         uLh/qHQ9LIAaS3nNcct0GAyWNB7AhB47hc6R1Qj2gGIM3J4tiHDKGJPcUWXxjUjNNHuc
         n3GryekXj5urP9d1iqlQYpQMfzv1m/MQjcphbnR8yvlrDexAdXzC2uhAr40/mNb8u2Ei
         OnBDjWUaB22s3l1yw7G7G5C2pMohAneaTydMmRei8AxceEeDb7VV/uJFRX1np5faRALk
         Ernw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187271; x=1713792071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2TA0iHMw7gZTifXWG5WTrNRKCCbxVowF92cfYPY/pw=;
        b=Cxu0aeIJkhVD0OC/RBq9yWDXtHjuHAo2cvPo6YEkdF4am184RMuJtg7Ne14YFXjCv4
         AfSUMgjT1WKY57TydH2dLYZTTPAIMtzMGO4VyMjsfAhW2vZyehPPJu6eyhoVx4FX6Vxp
         reX0d+mTGKGUiA+zjS0+PvhtWPq/QydGeII8dyomRZEr0UTpX4vi8Bzu/4q/Qu6hVzHL
         6EinU7rLKhX0whF2md54NoS+bNQo2DQNTs0rIod9wR3ODRWpOb+5dMVy2YhgcgcHTGHX
         krTMJSWjua+5IEZ7sNzEloPL8YyCSog3Tj7xkTAgZYAndIOGKZkgPN9xterw94W4O+53
         6xEA==
X-Forwarded-Encrypted: i=1; AJvYcCXcO3fBOWwFUD2/HHRZiS/xswbyTKYnp+8upX71sf5hCB5ZXzIjpwMZnIwEQSvFZ/89BX/Oyg2iZvALIJduNQCL3/6qKGeb
X-Gm-Message-State: AOJu0Yxe27xw9S+BVrVUFPeOfOditIbkVLvw472NfamWA/jR/0Zmrrjp
	c0M4qixsFZaYAn8UV98Crc8OCTEJhvROrmHBDfLGb4x81BBw/wYIXBaC4oKzVfnJSpQUB+hUxls
	J1YnOlPyzAg==
X-Google-Smtp-Source: AGHT+IGm877feMvQOycbWKE5li8/Ai0eyKu4WqTrADN/pv2FJs4AXcGIn6zx3MsV+wb3c07fdAMW8mPOO/zndA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a0d:ebc2:0:b0:614:94ef:5027 with SMTP id
 u185-20020a0debc2000000b0061494ef5027mr2309424ywe.10.1713187271745; Mon, 15
 Apr 2024 06:21:11 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:51 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-12-edumazet@google.com>
Subject: [PATCH net-next 11/14] net_sched: sch_hfsc: implement lockless
 accesses to q->defcls
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, hfsc_dump_qdisc() can use READ_ONCE()
annotation, paired with WRITE_ONCE() one in hfsc_change_qdisc().

Use READ_ONCE(q->defcls) in hfsc_classify() to
no longer acquire qdisc lock from hfsc_change_qdisc().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_hfsc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 4e626df742d7a937c219ae9755816f099b6f0680..c287bf8423b47b7ca022fc2e6ca19b77f3ec13a0 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1174,7 +1174,8 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	}
 
 	/* classification failed, try default class */
-	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle), q->defcls), sch);
+	cl = hfsc_find_class(TC_H_MAKE(TC_H_MAJ(sch->handle),
+				       READ_ONCE(q->defcls)), sch);
 	if (cl == NULL || cl->level > 0)
 		return NULL;
 
@@ -1443,9 +1444,7 @@ hfsc_change_qdisc(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	qopt = nla_data(opt);
 
-	sch_tree_lock(sch);
-	q->defcls = qopt->defcls;
-	sch_tree_unlock(sch);
+	WRITE_ONCE(q->defcls, qopt->defcls);
 
 	return 0;
 }
@@ -1525,7 +1524,7 @@ hfsc_dump_qdisc(struct Qdisc *sch, struct sk_buff *skb)
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tc_hfsc_qopt qopt;
 
-	qopt.defcls = q->defcls;
+	qopt.defcls = READ_ONCE(q->defcls);
 	if (nla_put(skb, TCA_OPTIONS, sizeof(qopt), &qopt))
 		goto nla_put_failure;
 	return skb->len;
-- 
2.44.0.683.g7961c838ac-goog


