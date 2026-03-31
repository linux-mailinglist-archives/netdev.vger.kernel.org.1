Return-Path: <netdev+bounces-273462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBs0M3NVy2moGQYAu9opvQ
	(envelope-from <netdev+bounces-273462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:02:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988C363F8E
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 925133018290
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1936A030;
	Tue, 31 Mar 2026 05:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AuCh+Xy6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DC284B25
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933344; cv=none; b=r9yZq5vPH79e2M4qOlLKLsHVoeN+2mPx9wQOHCbi4gtLoHjIgi0vX2MT1ROYMqq1PjUTjNw7HEOZ3Kq2yt1jXRd5tDhwKQywfI6q2EIRx3tCH62CD4JvcdkdWV6zEuxI4gsTFsUrLb882rzKmvlbJKUmXfXHybKRgW4wye4Tsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933344; c=relaxed/simple;
	bh=4pM4X0TTyx8f8m3cRev2LB+1/CpxD07kiZrssE420A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZql4eT4CdmcaaQm2blxvHrHFFa4VmKwReonjzN9mEEDJF6720vX16f+FhgDGPH/YpcIoOvCPaDT3XmqwHkJ2zoU9WsTkF1zpiU/NlRxrwBayZJi9lZWe/CcVhQVjYJ6h5uiVYuv4e4to5eVrjKRY7lCcupqgOvm8le1+4MaW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AuCh+Xy6; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6b0500e06so7018223eec.1
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774933342; x=1775538142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+28oToGXKEjFPdhuVIu3HEFJie+UBH7tgBbNm2s8bNA=;
        b=AuCh+Xy6rFnvpm45N7q2A+slZDGrswXmotoJnPn08FLNlITELmpU3/SqmHsRhDFh1x
         O9dDdkJ4JT+FeRTA03WNFDPp5q92L/9cT4fu32cs+jGfPuw2D4m1IuEnXx3ex/6/y7qe
         RR+wZoVDLL46xpAuNJMPAs+RbanzZLnMgQ5dxE/XLHz7NQq7jnsqSMkLJ2P6IbDLCJB6
         S+MBOMs7JIC6/8MpVxAimi5mgBVR/DboErjxYMMVSVDlMrVM5cMTwD8DTEi7ifPqO5uo
         O2ozYo3FykHXLQsVbh/4wPnzx9E/zYUQfGf4JogGGuRkynUIV8STvYuHV5j+qCEbax1Q
         UNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774933342; x=1775538142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+28oToGXKEjFPdhuVIu3HEFJie+UBH7tgBbNm2s8bNA=;
        b=sycXsAs/t1RVY8IIDB28cajVz2cQ1hFebAaJpJaSkizNyZ4e9EMAX9oneM3Bwah9mw
         IbB52q5iPONlHQ7apBWdKhOE/fKhA4WGqYJHuMpBuM34b6iSolUsigMAn2r0feA8p8Gm
         1FFhkzU1g8D7Qegc5b74y0xoL30ApWKO5lWhDJyNTrLFMzsK1QNYNIctnDt8BcvFECf+
         41E1nJb04F1Ft0yy+a+z7svF38H5mVPmITa/ybf3C6ZbyIk0nV8Pbsd9AMzlFM+Bv6rI
         VO2Y7pnG5kOiDy+rBaNjjUa6ELl8NGf2ap8JOEv1wfR9Td8jCdxVaT9rhJAM5secgcuY
         7skA==
X-Gm-Message-State: AOJu0YzDcrVWmR6OB8Mj4zX59qBb6KvaUSGPoYJrGLQc2uPkrcsqyq1I
	Z5ca7X1ndXN75srm/DOtaw6GVrwZeKmV+s9mLT7zPGsD2RpQpFkJSk77JWqK7svJSk0OADvYJua
	pess=
X-Gm-Gg: ATEYQzzeeBzroAuOV1tlGSHVxUBK2/5B+LfKw+2codh3g2cLLi6McP9XTzs4w9eslQH
	uNixsjYw9AvTubbubBGv0PdET2BWK/nTlwzuTN6Z6lN0wa40/dJw2wnZ+lOpjtW2kxAxpEZsMio
	lweJxkxRKfLmVOchyUkXmuMZ7jG4Ak9fyTBByJn8iFlTte+Kgq7oqKTtXweYtpfEdeqzTDsnP+E
	kzOR83zkkZ6IlX+Mn5ttgPZVIavRVcqQhLWKbDWVs/nSZFJM2ELHKVyETEQaVHPZ02UNKfMNxPA
	7a3jCjf3DLfiwGhdEd8tXQJ6QIWR4lqKqrg3swAb0rehvxZyvo0WOphyNRbpzB5mOMzKH4Sgxue
	Er+ApSi1WmltlvkO3/c/WQLGl8ca8ps2SihZZgAcjkIuxqnqArrEaZDcEj10dMJunXfwm4xY5u+
	oqAx4GYxunksxvachLBFNqnSZaSPEBO5wupJUuVko63thAXfNKjfwdIg==
X-Received: by 2002:a05:7301:7192:b0:2c4:ec89:be2 with SMTP id 5a478bee46e88-2c4ec891567mr2793281eec.17.1774933342093;
        Mon, 30 Mar 2026 22:02:22 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm9853819eec.30.2026.03.30.22.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:02:21 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3 2/3] net/sched: cls_flow: fix NULL pointer dereference on shared blocks
Date: Mon, 30 Mar 2026 22:02:16 -0700
Message-ID: <20260331050217.504278-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331050217.504278-1-xmei5@asu.edu>
References: <20260331050217.504278-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273462-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,asu.edu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2988C363F8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

flow_change() calls tcf_block_q() and dereferences q->handle to derive
a default baseclass.  Shared blocks leave block->q NULL, causing a NULL
deref when a flow filter without a fully qualified baseclass is created
on a shared block.

Check tcf_block_shared() before accessing block->q and return -EINVAL
for shared blocks.  This avoids the null-deref shown below:

=======================================================================
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
RIP: 0010:flow_change (net/sched/cls_flow.c:508)
Call Trace:
 tc_new_tfilter (net/sched/cls_api.c:2432)
 rtnetlink_rcv_msg (net/core/rtnetlink.c:6980)
 [...]
=======================================================================

Fixes: 1abf272022cf ("net: sched: tcindex, fw, flow: use tcf_block_q helper to get struct Qdisc")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Correct 3/3 selftest case
v3: add error message

 net/sched/cls_flow.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_flow.c b/net/sched/cls_flow.c
index 339c664beff6..ab364e4e4686 100644
--- a/net/sched/cls_flow.c
+++ b/net/sched/cls_flow.c
@@ -503,8 +503,16 @@ static int flow_change(struct net *net, struct sk_buff *in_skb,
 		}
 
 		if (TC_H_MAJ(baseclass) == 0) {
-			struct Qdisc *q = tcf_block_q(tp->chain->block);
+			struct tcf_block *block = tp->chain->block;
+			struct Qdisc *q;
 
+			if (tcf_block_shared(block)) {
+				NL_SET_ERR_MSG(extack,
+					       "Must specify baseclass when attaching flow filter to block");
+				goto err2;
+			}
+
+			q = tcf_block_q(block);
 			baseclass = TC_H_MAKE(q->handle, baseclass);
 		}
 		if (TC_H_MIN(baseclass) == 0)
-- 
2.43.0


