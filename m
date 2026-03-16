Return-Path: <netdev+bounces-268284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UN6FMi9zuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:16:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D372A0AD4
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F37C3198571
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6593936403B;
	Mon, 16 Mar 2026 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZuAvZ1tU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8835B637
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695482; cv=none; b=kqZPpo9LgXz7lhdHeIVZDBMYYaxDlQXThX91bPMaAMyHIr4ngckhhM3hTW8lihy6ShU9o+0s26XQpNP/n1TsqZtCXtw6Irnxzx6IzHsL3NN0aNSikCp35jlhv9U6sefVBeqYiUKs9SdxwMXHTj2hD2OZO8yj07f/jXfLWFl9hWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695482; c=relaxed/simple;
	bh=3K9nBCzDJBVJjUIU6sgCTuiMswPFoW2aR/YODZj3oNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzNrZ4qdxYfetfbCNuChlaL3WvVEOm2Rnd/thRjgheclfEF6+Jq6NpO71/1bf44+asXj4JVozg5FI1/Q928gefEiO05y0FjA94Sz0DTGWPPqgA9dZmtij32jDS/64wPqJzmO1XDQzSsLi7scfH6zcQgSNtJGZlbZQBcxBMfEVeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ZuAvZ1tU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-89c5340fed0so1700686d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773695475; x=1774300275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMss83GeQvyKtc3cLw5mCZCG0u2qpaRC1Z71ZAjwjoc=;
        b=ZuAvZ1tUuVdutawrLhPxSP1GAo68V+SZmtavFm0Y7rFPJ/vdfyeZIVpol7BB9ETj+J
         moqKgtxUwDPyGAz8tz65SCoo5jereH0XU93aoZBINDjLIqkJVMXyxCCMpgzTwZ/KKj4j
         sv87xQtr01xw9Q1JRUqZnMXV/ZVXP4OTMKHNtKzh0BumkvKyD+YCkmnenk/Cns83J9xa
         pypGmjW1sDz8PHQEoi+zXW2oJy7zNc+0tnlBO7s5GECClwaeaDM4trgHHncKv5iUv+Ky
         IGMk0mViPC9ctKEJjctKj6hYo5xql8M7jUms1wEyGEcafYauqqHgu2lv6DnJ7a5/M2TZ
         Tp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695475; x=1774300275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EMss83GeQvyKtc3cLw5mCZCG0u2qpaRC1Z71ZAjwjoc=;
        b=JRq57fDw4gr1RCinIHAH7zkN2+T/7kDTD8ZWFxk4hQSnMhP2bP35VYHsmyCdvvf/Ci
         2LaA5lixdwPos7ZF44l4/bqze+GOnEaqRzno2oxlVxQxxdAQi5uSm0nFYstgSxQ3+S6c
         wY5XwdykCwywOffzrNbeSqCivwaS9KUiEryHUpacPuvy2YjhGwtm4I9EaEigq/oNIOXo
         UZ7sScAJNKwIdLxvoDvNp7qh79ZRuA+b9pzZbu3qkv8pbTGU00jiJif7jlR0lRJMcm8h
         Am3D166MrvGIVlofm7V5GVNApTjVlo7iyNdKfS3LRG6EwscQgUTlYRtlsVel6TxuhhdR
         bpyw==
X-Gm-Message-State: AOJu0YwQAeQ3cjPlLPF7ZhzBGkD/wYgmnb3wbtVHpKUYhwfhaVp8qr4i
	noNYwmSILM7GmG4brBa54vs3CN+NIBsFuBKz1CgdcQ9xLGFrtombYEmSig4du3S9+AfsBkVlDfI
	LRmo=
X-Gm-Gg: ATEYQzwFDXDxkDnYoAAbx2fKE4g0TIQTkprocmQG3Q+DVsA3o4nOKdyQ4twlRrrVNvI
	pxUju3ZuXwkOM+hZRp+hq/5h5v/A0FTnv8x4tzRim4dAprMWUcBL6CCobtF5Y0GhMbwWYyHEaYw
	xPFfsnJtXc7itRDBhxytq9vpoVyeTPb8ugKRxTIXQy0rqzQLODXiee5Twu7isOJcjcarRxl9Aqa
	rqZD8L5FdqnT1PyYT6QZlctzdtCAG/hc2Kl4ytOe6mhrVGXaXd/b34IdtUNJG5FdkHLpsSavyh8
	rVLzQtFrzvdBFuhfJZvwJkQJoHsE0uzuIf84h958NWy+OgKS2h2jhsmeGzLQar5mJyBcAgP7SF+
	HIxYDnTEeNACKv2EtjuxnO5tevoCE8Hc6nK4iL5j1ipg5sVjFE9VJD0Bj5Auhq7TLBBVfHllgFg
	9gsOaq/SUyiYDgjmsWiMD7YZM=
X-Received: by 2002:a05:6214:4117:b0:89c:58fb:d345 with SMTP id 6a1803df08f44-89c5e36eb44mr13785676d6.17.1773695474625;
        Mon, 16 Mar 2026 14:11:14 -0700 (PDT)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c53374573sm27356266d6.7.2026.03.16.14.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:11:13 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	savy@syst3mfailure.io,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	zyc zyc <zyc199902@zohomail.cn>,
	Manas Ghandat <ghandatmanas@gmail.com>
Subject: [PATCH net v2 3/6] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Mon, 16 Mar 2026 17:10:49 -0400
Message-Id: <20260316211052.332383-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316211052.332383-1-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268284-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com,proton.me,mailfence.com,zohomail.cn];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu.com:mid,proton.me:email,mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailfence.com:email]
X-Rspamd-Queue-Id: 27D372A0AD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.

Reported-by: Ji-Soo Chung <jschung2@proton.me>
Reported-by: Gerlinde <lrGerlinde@mailfence.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Reported-by: zyc zyc <zyc199902@zohomail.cn>
Closes: https://lore.kernel.org/all/19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn/
Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
Closes: https://lore.kernel.org/netdev/f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_netem.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..0ccf74a9cb82 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -974,41 +974,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
-static const struct Qdisc_class_ops netem_class_ops;
-
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
-{
-	struct Qdisc *root, *q;
-	unsigned int i;
-
-	root = qdisc_root_sleeping(sch);
-
-	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
-		if (duplicates ||
-		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
-			goto err;
-	}
-
-	if (!qdisc_dev(root))
-		return 0;
-
-	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
-		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
-			if (duplicates ||
-			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
-				goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	NL_SET_ERR_MSG(extack,
-		       "netem: cannot mix duplicating netems with other netems in tree");
-	return -EINVAL;
-}
-
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1067,11 +1032,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
-
-	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
-	if (ret)
-		goto unlock;
-
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
-- 
2.34.1


