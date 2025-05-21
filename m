Return-Path: <netdev+bounces-192445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC816ABFE89
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B89A167308
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E02237704;
	Wed, 21 May 2025 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ovtTT2tk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0731E235058
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860863; cv=none; b=M7FYSwPEdBMi2inAXA6uTg1JLxVQJ/OGyyMdZRzEkT8zOkdjlXbhszW74v9ctmtz/gk8xIBYh4bfe8vPtpS2mYLqboqCnXm8ZtwVQQEdZV/zezr26/rU/2izIJrOY1yilsWBU1rYOIz4Tv+7PcAdSEDKqzfuW89HdqSdXMAK3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860863; c=relaxed/simple;
	bh=iZ6pIQaKk6w00ix4lxkfh4dyOHs68OUGONPLsz6xbrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z37I24NJxhFC7UEPOWzd1fZTZS5MuysPR6B+3zkuSYV+f+HrlhKyHzeLEKN1jzBBmYHAeX29tpy6klBCeothEv4Pr+rGjaZsR3YR6CIGeyuWFIYxSDAIM1Izsd7OfoBMocqzgUguvB6dKPVzilG/9duH2LxyQhS+GU2wB4HhyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ovtTT2tk; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87bfa88c10eso1142400241.1
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747860861; x=1748465661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VE18n9LKBzBOVRGcVhp1WgFzWPoyq5/DNyNZJvfUluo=;
        b=ovtTT2tkFeycnJR78AE3ZHwmJytDoD4DuxOrQKD7Ww00He95ts19OawHARj1E5salb
         KS2SW/UnLLuLw+xhQ/jOJn/xBpd4zqeeTq3Qb0VtV8gHo8yYqeEfmt5aiHH/7/ogwkZx
         pO83z8wyHc2dKMYDhSW6B88+dNfBQ4sWcgNAwfTPBlf2gQRCWrXH+f95dDcj1ni2kLwe
         O8v6sePKlqc3QlLCEYKpVfMR+JWPF1DeyJR+oIJdB0ZUiK20uO0q3W+L13fujSDMQXvi
         vkxw58DDJcvZT5YkF0KY5uNiSphOOXX4Xye2BE0dFsJHBpJYWJKJxUg1alguqJijg3dW
         j1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747860861; x=1748465661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE18n9LKBzBOVRGcVhp1WgFzWPoyq5/DNyNZJvfUluo=;
        b=v+jdgVld+RtLCY23oPWwQZ/dDuJ6CZFfVNxBzta0cm4C+Px5NibdPC6RZiDRrlOa9s
         R1OWaurGdIexFxOyiJiCwc1/LQ/lv/zg2scDzV4cGLJPHGXQLUNNmxhwioBicmWC+8p3
         ZXMfBRNhrPDU08yMBZ8CaqDkDeo0xIHVdAzxyBO/pVTkO8d6Xj1k//IjKdtFiRMqq8Vp
         wbFWVgZOLZj9pF99QEtNUVG4q2uVVkiy0k0zHyo+iqLj08A68u6plir8czwDQ2LVWiHW
         VyJ8asuaO5OK6Up5O3CoqQ0QsVLRKZ4Kg9+SiXXivJqbMIlquBfSkeJbO2SMH5x0e5gJ
         BuQQ==
X-Gm-Message-State: AOJu0YwsSPlUZWyIjyPIWNXglQRdj/TpYnCbIH8NiC8xTF7g/12hhjBH
	AaYiIk6aN6NDok5z2qQ4dDdn+IPFAetoa62xAbP/x2luLkHpm/KoSiHpX9hfk5LM7qPr/kuiXUi
	oHBApNA==
X-Gm-Gg: ASbGncvu1tinCH6WptsR+wyOd/UkjQHAq+yjPzH/6AuAU+IR70asWUdhSgxZWUqzaUi
	ca76PfLRHuSIt5M95QBlQ2VGcqFpesJElCydLhSt/8nZsLuBxMgUBQMLx+wFxSljv5Wuixcv95J
	8jfORiWmyOn1Zj2XRPjjDWFyy+I8g6RRyMzmCpAWN32YgrtOq82Sm8LVPWnG+Ca/o766CWybjBY
	1hk/ZFVMGDF5QKdv8HmipWQZ4+syAT8z4ibCFe9kD6T/xMVloUIYb3Sh//IfEl/2fcdZ2Z8PInj
	NseQlsiat3ATqbYSgZ+yWNoC7O6EPjE55xMhZTjP3rNd9wM8erdTKCaHBiUo2P/ZCreyczqA3Iw
	=
X-Google-Smtp-Source: AGHT+IGilXeQBC8KCP9+yDwsjHg5X26fefnlON2Az5BRTsL/k7cGZyvOw5HuEaxlqo7WTYeQQqSokA==
X-Received: by 2002:a05:6102:b15:b0:4cb:5d6e:e6c8 with SMTP id ada2fe7eead31-4dfa6b57c36mr22446266137.9.1747860860649;
        Wed, 21 May 2025 13:54:20 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4dfa66bf405sm10437656137.9.2025.05.21.13.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 13:54:20 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>,
	Savy <savy@syst3mfailure.io>,
	Will <will@willsroot.io>
Subject: [PATCH net] net_sched: hfsc: Address reentrant enqueue adding class to eltree twice
Date: Wed, 21 May 2025 17:53:51 -0300
Message-ID: <20250521205351.1395206-1-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Savy says:
    "We are writing to report that this recent patch
    (141d34391abbb315d68556b7c67ad97885407547) [1]
    can be bypassed, and a UAF can still occur when HFSC is utilized with
    NETEM.

    The patch only checks the cl->cl_nactive field to determine whether
    it is the first insertion or not [2], but this field is only
    incremented by init_vf [3].

    By using HFSC_RSC (which uses init_ed) [4], it is possible to bypass the
    check and insert the class twice in the eltree.
    Under normal conditions, this would lead to an infinite loop in
    hfsc_dequeue for the reasons we already explained in this report [5].

    However, if TBF is added as root qdisc and it is configured with a
    very low rate,
    it can be utilized to prevent packets from being dequeued.
    This behavior can be exploited to perform subsequent insertions in the
    HFSC eltree and cause a UAF."

To fix both the UAF and the inifinite loop, with netem as an hfsc child,
check explicitly in hfsc_enqueue whether the class is already in the eltree
whenever the HFSC_RSC flag is set.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=141d34391abbb315d68556b7c67ad97885407547
[2] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L1572
[3] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L677
[4] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L1574
[5] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/T/#u

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Reported-by: Savy <savy@syst3mfailure.io>
Reported-by: Will <will@willsroot.io>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_hfsc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index cb8c525ea..1c4067bec 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -175,6 +175,11 @@ struct hfsc_sched {
 
 #define	HT_INFINITY	0xffffffffffffffffULL	/* infinite time value */
 
+static bool cl_in_el_or_vttree(struct hfsc_class *cl)
+{
+	return ((cl->cl_flags & HFSC_FSC) && cl->cl_nactive) ||
+		((cl->cl_flags & HFSC_RSC) && !RB_EMPTY_NODE(&cl->el_node));
+}
 
 /*
  * eligible tree holds backlogged classes being sorted by their eligible times.
@@ -1089,6 +1094,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		qdisc_purge_queue(parent->qdisc);
 	hfsc_adjust_levels(parent);
 	sch_tree_unlock(sch);
+	RB_CLEAR_NODE(&cl->el_node);
 
 	qdisc_class_hash_grow(sch, &q->clhash);
 
@@ -1569,7 +1575,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first && !cl->cl_nactive) {
+	if (first && !cl_in_el_or_vttree(cl)) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
-- 
2.43.0


