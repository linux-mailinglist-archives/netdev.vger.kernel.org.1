Return-Path: <netdev+bounces-159030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D0A142A5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD72188CC76
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769D22FDF5;
	Thu, 16 Jan 2025 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="pkylbECm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398118FC8F
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057438; cv=none; b=GRut569R49yHLOiHchnWeTTFHvoNuu50tCnresW2MdGKyy0mJm+eh+1YujU7ilHl87vgYejpYV8UwvOVoIpLBa58gWIwTy6ZPy15v5y34+/z8Tivvk9bhph9CEZ1V0cTsc161KtCU85brLHNGMGG79QqSOcglNX2nuyIfS43rUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057438; c=relaxed/simple;
	bh=vgGPySTWHFH69cmgTbe5BlKqDOPi9B9W5htrrLa/Ktg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0sDjKAPuMPyqjpeOfmet+xRVErdBbIMuM2/BmLtj1vSNljEaWJmywNDJJq0CR33ID9EpiDUb/w/P/mHh8XrpyyFj2aAaTfx5YDQ6TkHRFMGokZExe+VvzUSsnQSHXfG/rWNeyWQ7p/xd0M8+MKwdXKTxLWNDE3AA8bDMJPO/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=pkylbECm; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eRKziJB1S2amRJerLCGXAMP9M+eTh8ejMrg81K2RUME=; t=1737057437; x=1737921437; 
	b=pkylbECmafrr8Np66nadlAYd5tHnvbiSqyYt5/vgiA8ZDOkcmave1gObme4BoY+mK0j56bVlIBz
	XN0lXmK3fi9OwB1nh1j+TN2L2XvrRwZOpxopr93rPqaj9qKZvGOTPnFMkM6j6KlP3SwXJr8RqjWoq
	7lk62+iP+bCiroZaBXrkGD+RTybJiAOAWeqXG/NBpW8CMsSK1foxky/KSwqM7I3vFZtiQXIQG3bvv
	ih1tLEVd7eTa3NGtiwG4C1AwfOC9KuRIyR2Qwg2oVP7jtIp/PlcJYJ8d8qQkN4bnpQG3gvJ4PBDqI
	6V8tzWbG9MoNWaPFyEQaYtCW+mjeiVSXW29g==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:52807 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tYVzJ-0005uB-LP; Thu, 16 Jan 2025 11:57:10 -0800
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH netnext] net: tc: improve qdisc error messages
Date: Thu, 16 Jan 2025 11:56:41 -0800
Message-ID: <20250116195642.2794-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: d3e02c565cd5ac634b2ff74b6ba3e13d

The existing error message ("Invalid qdisc name") is confusing
because it suggests that there is no qdisc with the given name. In
fact, the name does refer to a valid qdisc, but it doesn't match
the kind of an existing qdisc being modified or replaced. The
new error message provides more detail to eliminate confusion.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/sched/sch_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 300430b8c4d2..5d017c06a96f 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1560,7 +1560,7 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	}

 	if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], q->ops->id)) {
-		NL_SET_ERR_MSG(extack, "Invalid qdisc name");
+		NL_SET_ERR_MSG(extack, "Invalid qdisc name: must match existing qdisc");
 		return -EINVAL;
 	}

@@ -1670,7 +1670,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				}
 				if (tca[TCA_KIND] &&
 				    nla_strcmp(tca[TCA_KIND], q->ops->id)) {
-					NL_SET_ERR_MSG(extack, "Invalid qdisc name");
+					NL_SET_ERR_MSG(extack, "Invalid qdisc name: must match existing qdisc");
 					return -EINVAL;
 				}
 				if (q->flags & TCQ_F_INGRESS) {
@@ -1746,7 +1746,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 		return -EEXIST;
 	}
 	if (tca[TCA_KIND] && nla_strcmp(tca[TCA_KIND], q->ops->id)) {
-		NL_SET_ERR_MSG(extack, "Invalid qdisc name");
+		NL_SET_ERR_MSG(extack, "Invalid qdisc name: must match existing qdisc");
 		return -EINVAL;
 	}
 	err = qdisc_change(q, tca, extack);
--
2.34.1


