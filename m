Return-Path: <netdev+bounces-192815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBA2AC1320
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3E13A5946
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D21581F8;
	Thu, 22 May 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cwl366i8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8C27715
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937721; cv=none; b=WZ6DvecFI4MjRVx8kq/aXZUU6TThMcdi9TsLvjE7qO6QJKrmF0zPrxROQ4tz0i7wsZWDOfrfwcbO07qajTFIPkLrRFZ80o1ECkk2jVVu2wONujWTEqat8CmIHDdFDdNC/OWK1XogyV/v+hOawBjRUSDGqhn8rCuor4pV8/qAkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937721; c=relaxed/simple;
	bh=GfymHMNTaeTD+b3iLJcROTS48wkchBmDo8Frfgdl8dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvLSc3zm6U/sokYCvUmwP43escIz8TyyZ7aFp0ZCccRgcUDMFJFmG9zaFBn4q0HjvrG58vQkEtftm9auDoemISM1nli641GojuXjijbT5Gnms8nrom/R+ypFao2FidW4hP1aW376jfpHV07vFY28NMb9Dp3/kBc/bX4p/E9D8ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cwl366i8; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5b8d13f73so957112885a.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1747937719; x=1748542519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xD4LEmaTl8Jk7kv/jWLteQU32AjV0DVeZwUFpiWz6c=;
        b=cwl366i8qZFE5waTXK9Zqk3K/rBOxWOz1w5ncISQSzabbQza6D0/YK9XzKzvFi/g/e
         82qK/thlw0QPJKIwOiFJNF7bnNOQl77ighQiispkZJWKSr+wvV9oShXwaGWeYNd7cf9/
         u+uQsZxF5QkswmQmOpKk2RRG+jQQOPYjY7gNHQw6Tyx51U+IY3wIQ5m0AZUOj9EVilun
         m5ljm9jLCjdoZdDKCxX+iOMfTh0l5+HLQXkcPq18zT6Dnlu0Dv5g6YbonfhdD9l6b0p8
         xKr7em0xDT1HEwzpY4Bm26O/UKiRqD/CxscE/Q6lqNAl6vGQBgTpa0AQ2zv8B3ZfRJ0D
         /q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747937719; x=1748542519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xD4LEmaTl8Jk7kv/jWLteQU32AjV0DVeZwUFpiWz6c=;
        b=ixwsStGvtZmLFMQ06jm2hsVZftkehnggu44iFyrxMhUHfyPoIXBMD9MN6IFuBut58z
         +hIdRmFdHVS4+JdKIgNehV0ztEAsxaokm+Pz+ePHwa+IcQf3EYJO8diEjNOCY3AWRGA5
         PjZzSTRqKcvAyP+EaJEIYo45SkE7qUsgciwoYMklM50D2tDqU6J03xFFLJnYtBto1z0k
         e+3o10qtw2ep4wPS+FBs22R545wLUeZ4j1ur4Z0NZn5Q/S9VawzPqAdZqanH/q3zzyb0
         X/V0bZOH1MBjX93yew267LI1ven21FF3EAVSQiH5T+iovpBaKNF2/YqNpv59CsRCvZ3J
         INug==
X-Gm-Message-State: AOJu0YzAIxcMu1T11+QICURiX/Nba+z50ZKsHjF87N56udLY5hCLuziJ
	MpR0wNcLQTR6qMpAMMyd0XL8d9AD4jrooE46h8pigdH25a4xKp4uNYyf+SntabfuRUF+oxebk+1
	hvlfEQQ==
X-Gm-Gg: ASbGncssLLppWzFE8Lg4RZb5P6R0FeJDKUmIy9tGHKawERtlKx43fyn7sltNkUZaA2l
	dE+4BMtuxHHGBf4qHDCiD5r/Ib/ObcpSKS7VQ8w8HJM9CW0mouBmy2UGcH4rDpNkHI7mylA1OA8
	mTQNDurS5b4qvVgo6GTeQrLgmqbhHqE1uSdavDnYON+GmDjcd1gd+9DPtNc7RijNcXaSyfLk2Zf
	J8AYOBtCW+Vn4lmwX7LUMh7SusmtCwVxyeuXL2T/swEojVCrnz5ChFVTznzvxSBdVq1v5hW9Uij
	uxcdFiTqYK3vnmKsA8M1FbrHci99pKmxHiqvibDKCpaSWeT9b7xMeggmNTpUwDVUkX3UZfMwpwA
	=
X-Google-Smtp-Source: AGHT+IG2u/86a+7OPSl5FsOWc8u6HyYJgwP0KLdcYeK4OvDvrQR5GOKGtxjmFSU8W47LvCfaNuoZDA==
X-Received: by 2002:a05:6102:d92:b0:4e1:48ee:6f3e with SMTP id ada2fe7eead31-4e2f1a20f8dmr117032137.20.1747937708121;
        Thu, 22 May 2025 11:15:08 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e125de337bsm10573695137.17.2025.05.22.11.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:15:07 -0700 (PDT)
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
	Savino Dicanosa <savy@syst3mfailure.io>,
	William Liu <will@willsroot.io>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 1/2] net_sched: hfsc: Address reentrant enqueue adding class to eltree twice
Date: Thu, 22 May 2025 15:14:47 -0300
Message-ID: <20250522181448.1439717-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522181448.1439717-1-pctammela@mojatatu.com>
References: <20250522181448.1439717-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Savino says:
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

To fix both the UAF and the infinite loop, with netem as an hfsc child,
check explicitly in hfsc_enqueue whether the class is already in the eltree
whenever the HFSC_RSC flag is set.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=141d34391abbb315d68556b7c67ad97885407547
[2] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L1572
[3] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L677
[4] https://elixir.bootlin.com/linux/v6.15-rc5/source/net/sched/sch_hfsc.c#L1574
[5] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=@willsroot.io/T/#u

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
Reported-by: William Liu <will@willsroot.io>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/sch_hfsc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 7986145a5..5a7745170 100644
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
@@ -1040,6 +1045,8 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (cl == NULL)
 		return -ENOBUFS;
 
+	RB_CLEAR_NODE(&cl->el_node);
+
 	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
 	if (err) {
 		kfree(cl);
@@ -1572,7 +1579,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	sch->qstats.backlog += len;
 	sch->q.qlen++;
 
-	if (first && !cl->cl_nactive) {
+	if (first && !cl_in_el_or_vttree(cl)) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
-- 
2.43.0


