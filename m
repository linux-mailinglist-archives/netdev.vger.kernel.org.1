Return-Path: <netdev+bounces-287898-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP8XFEydBWr4YwIAu9opvQ
	(envelope-from <netdev+bounces-287898-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:00:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E483D5400ED
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC5A30547FD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE0C397E96;
	Thu, 14 May 2026 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZorAMxi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186D3ADB97
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752781; cv=none; b=utWWB696kEwRjNnX/d8fi/H91GrWihT/nz9P2YgwU+CPwqU1CvlSTTjUlAMve5IHoRQm7H9bfcboQ7LFT2ajjKrEFRJt9j6JRYVYMOnpckF6PTx00JwxwYgdY2sjKMYrImv7hesX/ETVX8esZu369JSaF70kT1UF3Epbfc2Gvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752781; c=relaxed/simple;
	bh=Ly5ehrSaqHBqHc1lZxKYpga+ls/Lszh9MDbYdQZAwr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U14tIwg2jysrCz/wvIhxjrZqvEUtKCUdJPapP3LplL7BVDx3LNuzHRz92BBue8vyxea0OcVyM603rpaVyM7lbSRY5vMNVFbjCv0CMBZ8yqtkUDCv8cQ/MFxSzoaD9XG2upv8c0aXNtX76Ts798W6stMxy42Y0oj384dWExSfzEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZorAMxi; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-65c3132b7e5so15767310d50.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778752779; x=1779357579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bvyMB+EDR/2iX86dNYdTQIU1FT08uyBckgYKtaK4PE=;
        b=PZorAMxiZk7D+ZOBnf67c5IHUj0v7s7CfTrk2Uit1V7eE2mJmCLQ0xGKf1aWCAo++l
         8SgSmyGjVD5d7yLJ7ut6OK+hJvhkDpHGD1i5YprDmPSWOr49p3oXw+fnOBnlUc73F+UW
         WIzgIwcWbvBphW6jTZ47QsZAlJuO6qBswo+YujwiCcOYN3YBTd1kJIaAr6v6EQe3g11G
         GtJjl6a4cQSNN0Te7ZrQ87nqMkQY2GcDabDRtTmb5Og0LtiRorOiLCjmC7i5l/2uSgpG
         OxR/UgU64K+FAiNGUjV86QUnZLGcJ52xq6ZhFA1wlMQKa/0i9zyXJJuIhPtcUmgCEONZ
         BePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752779; x=1779357579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bvyMB+EDR/2iX86dNYdTQIU1FT08uyBckgYKtaK4PE=;
        b=Nn8IFAwTG3X0Q6Io9AqMIksYSFOtRzZ6rqBfqebDXDfIBSQhUo8TT+p6xJrDVED1Xr
         wmlNevWlJoL5I/Od1A6ljr0m36HznIqg+nWc29Nw5Pru2wK8XPbuidRiFjowPOxYHJ8J
         UUcA2Ncdv3JNCWCUhskzsiaBh65dQ/9N+eXg5YW4BLmWICGrqJlnji2meAmLSHUMFNXX
         thuwhUaQeWstAXrED6vSDXMII++ZGu4QmrHUCcb2kq/jyVd/w7ucS29MvCq0m0JbavEa
         Ibw6GL1GbRwWdLUjBEpUVh2Zn8/NBMtLIvF26EnzZ8b6CLOZVD+b8W/s8U695DhBUyK3
         1Vpw==
X-Forwarded-Encrypted: i=1; AFNElJ/A21YgUiTvD2lDxUmdtUNpgyJIMjJ9D1IaovBikAishYvVpF7MNuwCOc8bILrHFulPn4Vrpe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgcjX28b4CLX0H5rf0JRaNo4SpFKjz43052Jglu9OcnJBdLjNO
	vZcwET/xRj/jq2zIUCUeJkv0ZdS18LWeieKMfmZxK3ABgjoAaPoXhEP4szEQy9isp2cPdeL8nCk
	sEo5o5gzbE3UOGg==
X-Received: from yxhx4.prod.google.com ([2002:a05:690e:1484:b0:651:c0c7:8277])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:e8b:b0:651:bd70:161b with SMTP id 956f58d0204a3-65df80ff4bemr5756312d50.1.1778752779290;
 Thu, 14 May 2026 02:59:39 -0700 (PDT)
Date: Thu, 14 May 2026 09:59:33 +0000
In-Reply-To: <20260514095935.3926276-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514095935.3926276-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514095935.3926276-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net/sched: sch_htb: annotate data-races (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E483D5400ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287898-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

htb_dump() runs without holding qdisc spinlock.

Add missing READ_ONCE()/WRITE_ONCE() annotations around
q->overlimits and q->direct_pkts.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_htb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 873337ac1cca28ea1a32778d8e91cacb5bd3af9c..5bf1889bc0300e8e3a61d56ddcf1bb1402955107 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -568,7 +568,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
 
 	if (new_mode == HTB_CANT_SEND) {
 		cl->overlimits++;
-		q->overlimits++;
+		WRITE_ONCE(q->overlimits, q->overlimits + 1);
 	}
 
 	if (cl->prio_activity) {	/* not necessary: speed optimization */
@@ -628,7 +628,7 @@ static int htb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* enqueue to helper queue */
 		if (q->direct_queue.qlen < q->direct_qlen) {
 			__qdisc_enqueue_tail(skb, &q->direct_queue);
-			q->direct_pkts++;
+			WRITE_ONCE(q->direct_pkts, q->direct_pkts + 1);
 		} else {
 			return qdisc_drop(skb, sch, to_free);
 		}
@@ -1208,12 +1208,12 @@ static int htb_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct nlattr *nest;
 	struct tc_htb_glob gopt;
 
-	sch->qstats.overlimits = q->overlimits;
+	sch->qstats.overlimits = READ_ONCE(q->overlimits);
 	/* Its safe to not acquire qdisc lock. As we hold RTNL,
 	 * no change can happen on the qdisc parameters.
 	 */
 
-	gopt.direct_pkts = q->direct_pkts;
+	gopt.direct_pkts = READ_ONCE(q->direct_pkts);
 	gopt.version = HTB_VER;
 	gopt.rate2quantum = q->rate2quantum;
 	gopt.defcls = q->defcls;
-- 
2.54.0.563.g4f69b47b94-goog


