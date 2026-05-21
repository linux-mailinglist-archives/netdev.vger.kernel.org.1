Return-Path: <netdev+bounces-290185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HuaCPdaDmo4+AUAu9opvQ
	(envelope-from <netdev+bounces-290185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:08:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEB759D862
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0E330E066A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB972C08BB;
	Thu, 21 May 2026 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igHngFhj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E723D7F0
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325450; cv=none; b=sDG96r/9BnmMRKIkkbUT5m4rCsu65GWDBsyg/IXtOo294kmRKXbva9rUajCsMIWdvG4sFcRXKBQGpIDOHhj3r1NGDTWRgDIHltqaM5KIuD8RBaGdrcUF8t7JJ0jBY4gUczAoTMyog9NdecSPBdouIwXc2zkT5jfcpp2aKye9XWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325450; c=relaxed/simple;
	bh=1ZjWBN0yIBNQfqflAGBfSTW8/icSlSo2UT4WXbyWYAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdCfmAmkjLhrAr/hteoVTpBjW8ntOxBZ5enD4u3E2PrvNr06P8g3cYAjlbUj8Q/SELOXOJsWcJ4ZllfGaqzBI+p3y7YTsqhoVlNSWaUv0elqpKB4hdLIXjA11TQBk6mM4FJFoq2clxwilfv8Qqk2nVkTJzyV89mJ0daw8VHb9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igHngFhj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8025500cc7so4261461a12.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325449; x=1779930249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1zAZ9q3hOWLxZR5AYVa5Nm+ouUfN2L7nHWHZTxPEz0=;
        b=igHngFhjo686CUY1sLkUjKTfg2rU6TjQfybS2J1mgowWcRPO3RfnDokgvDDRIM+Al0
         SDVU+2XBUeac0K1CPJurAUa3vqyajWUpJAjmrOMa/M97YKA8GUkhri1mW82z0O9qOqL8
         h3s0rb1OdIj8aoEe0bAluH9Ofot0cxGTWQj+q/5OTqHxLFosLd2JVjexN450baEpo0q3
         pfj7a2mxEb9YDzucvbmnrqXVuBUYkpwthUztWPwQJbDNUkFApaRj19yDsStx+Moe9n6h
         +h/MZ4tAv2CjCWzQeLRqy2iMHNfI8G/HLNHbjZV/imsMaRU9FX9nciDT9WoGLFXXpC3k
         uw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325449; x=1779930249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A1zAZ9q3hOWLxZR5AYVa5Nm+ouUfN2L7nHWHZTxPEz0=;
        b=RN6thwnusEevUk/rRtVw2euCpGLLqub8vXFDO7JnVNcNPRFIdbEbH7z8HJq/iLDqpx
         d/274B0JaouLmcwiMAp49e6gbLY3z0xiCjh5k43ga2/JDj2LqGkwPwEa9jWJSLL8A4Wr
         JCHgX5rAdOfhCIkMJ3UaDstD6fvbb4kvGLTfOlCdvjPaM7uhrzkqhgDyf6R/8cDccgOL
         8/73T38hCyL248xxqJhwDVurAFYaHwuc400o3YOuAD0TiBDocQeNv5LeQDFn1W4X6OWw
         AWH6fAPrgYO11pB6PFZCxTyMSuldgS39JOsjb0c7iVqquWicCrPEiGyE9WbBZ9zd5x/z
         sFcw==
X-Gm-Message-State: AOJu0YwlPTQUusxHepOzMgWo07UaL4ZPqWfpynTBJVVRTEWeFFryyWYQ
	cZVoJfWFS52JnXcgZzsnpu8psu2q5rJlCb4+mcP2i6vF+6ImyRdYhZUzfJP6v7Ww
X-Gm-Gg: Acq92OEe5whrWanUOeUGIOuTm8sgR8a0s4h4gCI5Op6ImulGWPlh77uKR65kP6Lox3s
	XSLHSniLKFBYmOrx893yHtUM9yxU5KLlwYp66ztaZf6ftlyP3Fo5ZGQzhAxAOMouzPzXVbi/+L2
	YQT1SCzSmzV9sTV+lcej/39rLaXLjFWnYK6ISVUyA6omtHHiK7jQ8/U3oHBW5k/M9yslgHgps1N
	kc/UnOp0i4wjdxLtoTyzlU4UUpgbwf/XTqYxowhdmbdoWSmXWYt913d8+KHm3mN1ADWGkY8l/Pq
	iM+ESq+K2MtxC+ctxt2iJuOYw+J0JyJMRt5JznJsrv7J/tnxMeE7lDMT+nYNUgDf2dScCNeVFFr
	CtHQD1eGp2y+RW5dYDULOlHaeDsWjP6BKQ/9Xdi7eGMpkci/rSKY5dhHk6HGECWogNoo1JoQdT2
	P008yYdYxr0VquCOxyDZHq5zqup3dM96NDiGaZtieyIS6bnoPR99DWnqYv8F4m
X-Received: by 2002:a05:6a20:4307:b0:398:6ea8:21d8 with SMTP id adf61e73a8af0-3b3086e6a37mr742936637.15.1779325448508;
        Wed, 20 May 2026 18:04:08 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661f:1232::1d0:bf])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb114a70sm26319616a12.22.2026.05.20.18.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 18:04:07 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/3] net/sched: tbf: add extack to offload params
Date: Thu, 21 May 2026 09:03:06 +0800
Message-ID: <20260521010320.208138-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521010320.208138-1-mmyangfl@gmail.com>
References: <20260521010320.208138-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290185-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7CEB759D862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 67c7aaaf8f60..58c9687efb0f 100644
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


