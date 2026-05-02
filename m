Return-Path: <netdev+bounces-283489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCcgLZNy9ml0VAIAu9opvQ
	(envelope-from <netdev+bounces-283489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:54:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630544B38A9
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 23:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08FE43005AAF
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 21:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8D39A802;
	Sat,  2 May 2026 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co0PlfAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05F39A7EF
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777758849; cv=none; b=aiFjX/7IV8HO2Gr6ynYWk/rN5Rx8/Cdz0ks6XoXJUVDUlOj7OrQJFmVO14+SCOPyS3Chx3gmCU2K8KMT0NywWhWFBCqvUcZ2e5gaLV/aBOKrwICCSc4uw/pGWkZmAq0U70MuVo3CXseZ8Syk16OZXwqrvfHl1CQNB1jx/hHxWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777758849; c=relaxed/simple;
	bh=3STGZFIGp1QI0P9KYESK3j78npCaPdnySXuzfK9UW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IW4xNaNfoN+5kFF2Nszd3tEvzOiPQ5PgtY2In3DNsoArZwza7WgV/wC+9Ad4z/rvpyawgNlSbudNEKTxszpKe4Ybj31Ky8xQr1B2z4LUen2qiiINk6/ZwAzRHI2ImyHccc2lCb7SWxDPHw1ry1FFs75FLJwvBjukRD5xkHRFf2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co0PlfAJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b45cb89f7eso19165175ad.0
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777758848; x=1778363648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVeN/tIgR68DwC5ZYD/OpJgnTRgKD56zUbPN+aZwxQg=;
        b=Co0PlfAJodc+S/IC6WbjtuoV2PvcRiz6jN7dkIZkbpx9mJ1qso55n9H/LfbmSmCebY
         nqNvwDQL5b+QPFDG3UuGyGcQpa6c+GFshsQUEv2XJpYJFuNyNXjT7G7J5gZHLsilZEyy
         JELvIv5jllXseDzUAFpIpXzgjowe5XB3lW/TOrxd9oW8oLPDALcwbWAGH4XJONN2+iiW
         gq1hYVi8bKqDzVD1K0TuecIf7VvV/fNGJfqDankawMQZdjmQU8uq5bFAPlJB6DdEVjyY
         Pp5MZjeAhk6Z7aXKtXymVw5aB9YMML8IH0C3pbJCZaisTIyn2hGFEtBIH8BiyJ7F5FSN
         yJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777758848; x=1778363648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVeN/tIgR68DwC5ZYD/OpJgnTRgKD56zUbPN+aZwxQg=;
        b=ngofxrYteGtdYOWns3fxdgjWrMz4rVDi871/kzcELYxx+IhkkTOrSCT+fJyNcZzM0j
         dwvSPrIX/HT1kL7xOQjnaTJRszONV5yEaZDsPJV8mFa1mGgyRxHlGnYFhPIPuc6LPZmk
         pLJU2EA7b9LYlurt9JR4elKEZ+FnJAUYxf0hs7ht32us5muEusxCPYTQ0zvljgggp1xh
         tKQ1nLwtBlLTQm4bU3Uc4jFX5pPPREjEB3ItNYAyV+0OrddTQ59OeN9eUdx61K7WdXAR
         XFypJJbolwY3HV77fNjpu6VtXn5lVGrCRicikQhXwWIkgSV8tPFvssBbZuVfzWsi+57w
         mZnw==
X-Gm-Message-State: AOJu0YxCrfEHGRl0dQuwRNll1XCbvbS63+8LiOoeNltZxfga/N4GeUUM
	L3ZKyjvgezptF+orbT8AwzteNYqWRtu6vlh1WfnljttZGt14NcXjCQDZ+iwwK50P
X-Gm-Gg: AeBDieuRMN/9xDB4h7ANAXwwM1C5TSW/F7T2h+j2B0M7fTzizistBb5cPkWhliM55Qb
	Nk9dGzFP+glBzhaMcPIpLtUNxCfua4f6yzhcRxXfhxXktkMsvUdv2On3KwBdCMX/f27tOj32wfu
	IS+wYRAk8/f2YPPc7wNhCtc2aF2LNdPujlV0fIH8yiX+DjPsSkk1yOiLg/JydhQZBjq1Sm+ON0D
	7UVUZiE/O8nWkjVrixKvFm2mT9amHfmrM9mIfOv/dGH5dNw5iaX+m7/xtbXcXJaeSl3QYrOZU3M
	NgeEp6qUn92pmXwiXSC2Saj4Zqd9o2Od4y5VPIY8E+v7V+s13jn8fPUgLAhADw8TdIsZatL7e9C
	LLH7E2TeYVdv2Hv+TRvFO9mjR/8sMU334F2A1Tj0hAYnkHCCPX71zm52wgVl1litDXAgeREQihC
	Fhbrz8Eck2xkJ1wAD0V93kstz4BGn507g5BH3RcS8E/t6Ffigpf72qZ2VRxMiD
X-Received: by 2002:a17:902:d58b:b0:2b7:af0e:5942 with SMTP id d9443c01a7336-2b9f25dfb17mr39796375ad.26.1777758847700;
        Sat, 02 May 2026 14:54:07 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae1e293sm60508315ad.45.2026.05.02.14.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 14:54:07 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: sched: tbf: add extack to offload params
Date: Sun,  3 May 2026 05:53:08 +0800
Message-ID: <20260502215314.917687-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502215314.917687-1-mmyangfl@gmail.com>
References: <20260502215314.917687-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 630544B38A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Drivers might have error messages to propagate to user space. Propagate
the netlink extack so that they can inform user space in a verbal way of
their limitations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/pkt_cls.h | 1 +
 net/sched/sch_tbf.c   | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 99ac747b7906..3bd08d7f39c1 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -1046,6 +1046,7 @@ struct tc_tbf_qopt_offload_replace_params {
 };
 
 struct tc_tbf_qopt_offload {
+	struct netlink_ext_ack *extack;
 	enum tc_tbf_command command;
 	u32 handle;
 	u32 parent;
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index f2340164f579..4576111fe075 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -139,7 +139,8 @@ static u64 psched_ns_t2l(const struct psched_ratecfg *r,
 	return len;
 }
 
-static void tbf_offload_change(struct Qdisc *sch)
+static void tbf_offload_change(struct Qdisc *sch,
+			       struct netlink_ext_ack *extack)
 {
 	struct tbf_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
@@ -148,6 +149,7 @@ static void tbf_offload_change(struct Qdisc *sch)
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
+	qopt.extack = extack;
 	qopt.command = TC_TBF_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -166,6 +168,7 @@ static void tbf_offload_destroy(struct Qdisc *sch)
 	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
 		return;
 
+	qopt.extack = NULL;
 	qopt.command = TC_TBF_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -176,6 +179,7 @@ static int tbf_offload_dump(struct Qdisc *sch)
 {
 	struct tc_tbf_qopt_offload qopt;
 
+	qopt.extack = NULL;
 	qopt.command = TC_TBF_STATS;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -193,6 +197,7 @@ static void tbf_offload_graft(struct Qdisc *sch, struct Qdisc *new,
 		.parent		= sch->parent,
 		.child_handle	= new->handle,
 		.command	= TC_TBF_GRAFT,
+		.extack		= extack,
 	};
 
 	qdisc_offload_graft_helper(qdisc_dev(sch), sch, new, old,
@@ -477,7 +482,7 @@ static int tbf_change(struct Qdisc *sch, struct nlattr *opt,
 	qdisc_put(old);
 	err = 0;
 
-	tbf_offload_change(sch);
+	tbf_offload_change(sch, extack);
 done:
 	return err;
 }
-- 
2.53.0


