Return-Path: <netdev+bounces-296810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZGDfMBphJ2obvgIAu9opvQ
	(envelope-from <netdev+bounces-296810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:40:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF665B65D
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:40:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=CKvGJEwb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296810-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296810-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6F943089F75
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097C233928;
	Tue,  9 Jun 2026 00:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1692472AF
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:40:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965626; cv=none; b=X6rBTozIeZ3dN+Jk11UBgxh7LpYxEm9F7zTfCbPe7ItSmbHcpqrQyWmTjiZvGKHrvAnU5hz/E7zyS+yKUSWajznxSENvyjqxO94O2cj3npke7r7Fi5YnI8lk65/2cL784XVY4MV4/HayRcxY55haGaoBVt03YM4CdtoW0L1huhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965626; c=relaxed/simple;
	bh=RL2nelPuVquWigElAbGuRaJ/oJl0cri7fXzRSPP3f/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQxLFF3MFYbfjeNlWSGdTMeHBEsBqUum4WWMZ5VamYaoxdCUTCxavQwFmFr3ZBD3Fmtdf28G+2QoehW0IoXrpwZZHp5h116rZiEyGB+nofTp5528Msd8/nyffWyMLUzPk+ajo/Je5HW8ZbutiUJ9cdfYkDFbtzG0Ssl/6mx8fDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CKvGJEwb; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9158c621ebbso589587185a.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965624; x=1781570424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YFVBWQFtxi3MWtqjY5JFqeW6UBOy9JZ/sfyVQG1lYc=;
        b=CKvGJEwbIt6+/r3sADgT4v+fW4fvJaSx5wZKAryWxIMLKnz37XKIYrPWhiOSRADmZT
         frER4xk7o/ASzZ71Wmv5+BNXOOpZ3UuFmhmIeJOO4eOfYQfUk6AsS8LhhVakfb+/9KqZ
         8rMcES2MkQUodOVdTBPdim5SaAiR1/NNTOMCwxs58+9PbLhut5wS0mXV+bHo+9qzm8Ay
         uYWZ56kcb5FQ9bNHksIm03NVe58T2Js9BRFvmepTyF8Gmk+V1TMgjF6p9fqRfEfVxfJp
         IXFNRwox+xnM3Ug8QnsobxjhhWPFScAkCONFppBJpZoMNov3sz9gFtIj4dUJY2kVxQJ8
         WvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965624; x=1781570424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YFVBWQFtxi3MWtqjY5JFqeW6UBOy9JZ/sfyVQG1lYc=;
        b=i0NUARw2MvATJWU1pwiLFo6fKlBDJ3QG5PuvE1GD0d37v8Isr/lKyzKCxOVYCY2G9g
         h4JZwga+9ggJqQOGluxetkNIdkU2r7m+6cD2Ql4JSKy77AjG0FobVNBf5rVtKWz5TPr+
         aRJpIjr2O8+G6DvcSTZIYcmv0gO45b8oupW25w2oLb9J0kY3mA8OiaJBrBLC2LKaFGn0
         aimHT50CecVz4uHxzn8yyoj1L/USNqYfYWgU1mdAsR6hXyUG8ocbJnppBxgWT8stwway
         TfrSFC2WQA2y0K4l9POGs6FBCe+W2AFJEA0lKcurt/RjJI55DTdHi34ki1S04SAw1Vco
         SFlA==
X-Forwarded-Encrypted: i=1; AFNElJ9I8Jtm9gs9MOUJeMs0yBgnNenSqIz6ET0OykJAaQcHWU1LiY43Qt5kz+xyryRA9IRYdKzA5bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOMbvUSFx4ySTSv26G5gHXwXw/tqiFAIwlqVLyBifwFbumjMvp
	ncElqMNMUhurf1II8ZeaVU4y0RtX9SKSfebpZgMZOmLzkielQJciXHvJfFYznCNcNxE=
X-Gm-Gg: Acq92OGwLvv49WoX23dz5J0lQJ4MmxfPmotQB/pvbsYgovevh6H1SkyohjoPygZl5Io
	FHSfsyjX89UI60R2ccW59KfEkzgv/8PzrXKMwI7UT47zsnwONYul+bHiAbmKwOlBtum2aLRSEqX
	wtOWFcWsYUtW4zcwpvTt71S8TfSr95bhsoRBvi1JhmGqn6sMqi/n8JXlxzQdnSztOLQivdnSDrC
	MyPYCfl0IG3MHGJzf9RXsNxjDLzxZMrRiu5FUEjeugf+3ASXtn7Oo/BKoRDmf5q3Nb7exnCYGlb
	a55DWuq8ASrDyfxWPu00fQU5kEja9JH9mxPBJzEsNQbj814I6Q5Iz9D93ckfZQ2Ol0ubDlNhln8
	B5vHcSs/fzl5ImtlxyyntbTJ3N/JL+4r89/Cr2u5QuRrr13W7ATY4sfZeA3bz10xmbdfkbKSCQn
	HYktNDdmzmprpWflI64RGS19kXxZoBTsFlBKXDKA==
X-Received: by 2002:a05:620a:40c5:b0:915:c4de:7ac8 with SMTP id af79cd13be357-915c4de8553mr1549647085a.24.1780965623660;
        Mon, 08 Jun 2026 17:40:23 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a243041sm1969686185a.18.2026.06.08.17.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:40:21 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: fq_pie: clamp flow deficit after quantum changes
Date: Tue,  9 Jun 2026 00:39:59 +0000
Message-ID: <20260609003958.1238678.04aa5c10b22f.fq-pie-change-quantum-stale-deficit@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296810-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40DF665B65D

fq_pie keeps active flow deficits when userspace changes the scheduler
quantum.  The next dequeue rounds can therefore spend credit that was
accumulated under the previous quantum.

This can be observed by making a flow active, changing the quantum, and
then dequeuing with the old deficit still present.

Clamp active flow deficits to the new quantum when the configured
quantum changes.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_fq_pie.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 7becbf5362b3..9c551bdb799d 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -284,6 +284,19 @@ static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdisc *sch)
 	return skb;
 }
 
+static void fq_pie_clamp_active_deficits(struct fq_pie_sched_data *q,
+					 u32 quantum)
+{
+	struct fq_pie_flow *flow;
+
+	list_for_each_entry(flow, &q->new_flows, flowchain)
+		if (READ_ONCE(flow->deficit) > quantum)
+			WRITE_ONCE(flow->deficit, quantum);
+	list_for_each_entry(flow, &q->old_flows, flowchain)
+		if (READ_ONCE(flow->deficit) > quantum)
+			WRITE_ONCE(flow->deficit, quantum);
+}
+
 static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 			 struct netlink_ext_ack *extack)
 {
@@ -340,8 +353,10 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->p_params.beta,
 			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
-	if (tb[TCA_FQ_PIE_QUANTUM])
+	if (tb[TCA_FQ_PIE_QUANTUM]) {
+		fq_pie_clamp_active_deficits(q, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
 		WRITE_ONCE(q->quantum, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
+	}
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
 		WRITE_ONCE(q->memory_limit,
-- 
2.43.0


