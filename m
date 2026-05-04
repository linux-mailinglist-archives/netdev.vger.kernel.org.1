Return-Path: <netdev+bounces-283776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNhyLCRy+GlCvAIAu9opvQ
	(envelope-from <netdev+bounces-283776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:17:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF24BB951
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E6813051AA4
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE4E38C423;
	Mon,  4 May 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOWo1IrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FA388E6E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889623; cv=none; b=mSOOk/SM+v9v6PToWrhwuGk+BxrfwDZIOtF7PkwFg1lQbYyX+lVGPi6lRZ+tB3Y5kAf2Xt8PHu3qE+WF71MKWbr4E2V0xIeoepkf7FUQ09gf12mdVAmPPvuhi705kDrnVm/o/ZTAphasUfi3U/v5o0PaOvzZPhhWnXKcTA1Opxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889623; c=relaxed/simple;
	bh=3STGZFIGp1QI0P9KYESK3j78npCaPdnySXuzfK9UW/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJj3NTScc+9eyQWpTxcfj1Wew3Twi5fgkOYwAoyNp5bYwGaBN7T3hLxXAg2gOJSsdWacNckrI31M2Bca2bx5oZ4xEvzKU/QfimcktOapvUhI138P05ilOnCYWaad6q/lyiSoEFu9PwmjC8/Vk+o9iz97UPwBvB4wNad3B2jKjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOWo1IrF; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82fb2d0c5d1so3045124b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889621; x=1778494421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVeN/tIgR68DwC5ZYD/OpJgnTRgKD56zUbPN+aZwxQg=;
        b=KOWo1IrFxJndDFpJiO5wtNLoGnJ/9PGw6Hf0SBnecSwyhW/BSPY8q4T4EvIVQwcI4p
         /+omCbrEyssRR302C5CQIMm3YPg0TsVHx9cgi4jBOpXmOJ+zY2QldHqQ81ztMdqfdwCD
         IykRMhf3E+B58lvNLSrHu8PxP7nBc+O8bTaMh4vVXSkkEoIzzbmAwXeErAqjQAstmvYk
         AXDe1NRET9rMbGxaOtlZptEiLewUOGvnc7LLsqyJSvzXRALFPJ5n2JybMTrCRFXvyPrh
         0DVwrVlYS8tDPVBDaYO2pDYvwfDKbrTGx3Wlpb3qmcker9hnECqx6FP9jH8NOF2cMlUm
         706w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889621; x=1778494421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVeN/tIgR68DwC5ZYD/OpJgnTRgKD56zUbPN+aZwxQg=;
        b=kPyKiLCRHHQvVTIoQ10iGWwo/B8/uwzMQ69KwwqccyIecgJd+cZpHrwV5dmUymmTZz
         QenBll2W4DNHRa1RICaJHjtFtJEqgKEBF5AGnpWDQJdxn1V4lZwHO6EEjvB8qmFBYRte
         JMBH9MG3rgUzWzo/JC0+4bVEY1Iw4K7MWWkhTvQByj5SabHi/5v/FwLfk2i/i9bZX+Es
         AA9B7y28RAKDz8kelLtoy/0GAldnub6KGmAWZQnOukGGCWeSuW1IRpLOK8QUchhoJTf9
         9kgeA+5CEDyxmYbbzBpZEovfJ8dEfxOQ0yS+ckPu6ahtcfJRX9pBNrTj/nCMoa7OjQLW
         bDbw==
X-Gm-Message-State: AOJu0Yxb9vPmBNAaxlWdo1ZBIf4JgrJq/FZoeTNG1Ut/AxuC8Ea1V5A6
	3yn3uTqsy8BEbidbfGLPOzlv7IKpfaJoWD3OyoYcvgGf+XiwSIMCtKGPRfxGTHBk
X-Gm-Gg: AeBDieuQCxYgfkQjnDm+F/kd+fpvqrsxavCfaiN3HZgbEH87zkN36B2KO924ZLZNZqZ
	5oOJQbCBtYV8Uz4xjhtbs9XlAsFfcLM47NReBSWSg+zK2vKPF8SeFFXRw3tZY6GMq6EaXxfGA3i
	RnWPMG9jfet1ta3zBDK94Tg00NtlFoAPoKlVMq4fzT+ixNyo8PceWNgkov1YK/BBwCNwy1tW1V4
	e8z5Rnurj8c3kL6ImFIxMfwcbakUhTvLZzdFdp6zF7C8xpSy+27+VVWXmxNkN7Ta2SX9KsxAHA0
	ttpAZdvnjVBfdOEx0bdIPrh/6mQpwjE5IP+AtHswelaMMdKI5PFw86uNIAhLi1AYXCMDT557R1z
	V0k7CIAW4BBSe2F73r2a+F3hTmpE3gXNDSGsxpx2cZmE0K/OM5DiBxvSsO1PbA0UWsXRuh14LmR
	KZG7ykJTGD2lxGmcaU3MT6KfRCscVrtg/P/DBYftJPY9HtocsIGZ1C9PfxrdtJ
X-Received: by 2002:a05:6a00:aa06:b0:829:7a62:6a with SMTP id d2e1a72fcca58-8352c4fd461mr7141618b3a.22.1777889621211;
        Mon, 04 May 2026 03:13:41 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bd62fsm10813486b3a.24.2026.05.04.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:13:40 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/3] net: sched: tbf: add extack to offload params
Date: Mon,  4 May 2026 18:12:53 +0800
Message-ID: <20260504101258.1608004-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504101258.1608004-1-mmyangfl@gmail.com>
References: <20260504101258.1608004-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 15CF24BB951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-283776-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


