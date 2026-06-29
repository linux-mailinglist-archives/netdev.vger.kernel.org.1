Return-Path: <netdev+bounces-302718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vHbuIWeiQmoV/AkAu9opvQ
	(envelope-from <netdev+bounces-302718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550D6DD824
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=TwIrIV5i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302718-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302718-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFF27300AB3B
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF3466B4E;
	Mon, 29 Jun 2026 16:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2444657F3
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 16:50:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751835; cv=none; b=NsGETRZrmC1QIrCvEDjxjK8xxIANJLh9UL++xkL7xn39mWLxLoXnIB8DdCgSHp4whCOXvr/SDY7lsnL6j39chE6bplAIV4/5wgnir+L7G7VubuABgxPcshUM03KM5eRW7R21NqqS99SJzwnpuYxUIysg31V3AfOCHwEmAqKh3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751835; c=relaxed/simple;
	bh=oeupzzhR5Ss49L8dlKMarQJVR5Sczj/faIJrQj/3wY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTaOQf30If4k5DNiwhMAzwzh2p2866aBsc1t0WWvZni/rwcq0jZhMe7ytKTv1Bf/VT701k1HMgFmEILWjOQr3OJqdaPtEoejLw6LmFMVyNUj3B6Zy6Jp1eBvdQb61w9F5nadOzPr/3j4nDvlcu3Oo0S4bl8nqMYZf/XBSL1tie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=TwIrIV5i; arc=none smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51a8f5ef23bso23910321cf.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782751833; x=1783356633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46Ib9vSLcie/ttMUoRjBKHRJGPuNr1Dq2/Usm/hiTwc=;
        b=TwIrIV5i8MpOcqTLpx7D3b8LKC6e1CxAV/l+DSFXbykM8VlU/+qH5Wye4Yq36CRD4q
         DDPP9cTFidd5Q/GVEkgBiBRnb+nNtJUn+7rugXXdyLxR/C/WSGJmvaIoO2gcLH6txkpO
         yg2HzA8rFHQJB7ARCMlnOFXPNKdnhbO3QSsAXUaJtLHkiJyv7WalR69L9G31JmyxeMdu
         pPOKUs0LLS4Lyn4Dyu0i786BRTLT3KbNwrUbLpwNChhgkOOmrOPBcEkjgRMfDaK+nvsp
         KADII2DT5q3GvphFpk0s0NC0CsFR0pxNR34RqhK14q547Zo9ZspyNmYLUolYxXiQCsbZ
         KW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751833; x=1783356633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46Ib9vSLcie/ttMUoRjBKHRJGPuNr1Dq2/Usm/hiTwc=;
        b=MsCWJ5YaguJqBYCzKAuEGwRuKLFk0xJkg4KjuQvEE1aiopVDRmPVbvm6Ap7J3kGbMP
         Jq3p8FUZGIAT4OEtPRE6PLZQQoyUHqbBqqv2egJ9zEmIwMQ9WyEERm/2jpszv2YcpVM4
         +oqes+gkPDoQ9AKaM/37fmkM0DNxrn6mO1JVr+dRUq6YsleagDCEr2yx2ZSuhYTAise7
         RSN5+J4DIpkNdcWCwrB4x99uMw6aHKZYtK6aK7KLJbrMYJsMTxK8/7TboQqUdVAbRZZZ
         zMs+2mezj+c7pBfVaKuC1gopETea9Z383Kmk+HRJUnjxksTP4T0VkYLCERomF4n9rDZ8
         F1Lw==
X-Forwarded-Encrypted: i=1; AFNElJ8ecVEgxTQowK8TptymJbIw0wxfHaBiVBctDnnbN6zv9+PoZiDhxp1ZrL8cKHoLIKB4CFF6/E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKADgh5NlZ9T5WtDml7+aiYLaxhouVd5E6oJQKPFRwZKSom6tz
	vJTo7HSuNJw0/6su137gGL0timaj5jo6Tc2WvDs+v5e1pUlHdtBsHZh6vrl7qfVBOrE=
X-Gm-Gg: AfdE7cmpRPT8gQGl7QI5RGzmUwz7/eDkUty/IC/BnjHFmwX5upVrRF3l3mrD46aoaJK
	rhaDnZDGO3Ikz2OGqjBc5MrYSDVHj/LxUOs5db6y1Zsk1xvqsBpJpy+e/+ZNuP3zPjARIMXfdUa
	yO/xQSnxie3RwSCHC7l9vw2HPQU3aK9mAcvWGlERKUAzgNJ8fENEbb/sQ7jeTm/jHpDi1N3rR+y
	MwaWfcWxpZ3dejz3GoUk6HGRNobFbKUg4LioBlMh+rnkfEQ2098BRdC4krXXrQ7k+ETLcq4PUi3
	9/aNlfR+d/jpuIlQK9zbUnGcjjUdexGQC2quA41Eqx6lJWmsT5awq+0c5JND5D/zjnGqP2/24tp
	tZRG97aR6DqVZAuaMU3eNYPlwi9XP/8oRbIsgmOCvjD7ZDlJ1ViAIHlRAEAqR3DqKI6cadGBXyr
	XEzgN1esB2Mv6XGQDm
X-Received: by 2002:ac8:57ca:0:b0:517:642c:8196 with SMTP id d75a77b69052e-51c10752952mr1693361cf.12.1782751832951;
        Mon, 29 Jun 2026 09:50:32 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51c1080d51bsm506001cf.2.2026.06.29.09.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 09:50:32 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Terry Lam <vtlam@google.com>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] net/sched: hhf: clear heavy-hitter state on reset
Date: Mon, 29 Jun 2026 16:44:59 +0000
Message-ID: <20260629164458.195029.ab92a1db1120.hhf-reset-stale-classifier@trailofbits.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vtlam@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302718-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2550D6DD824

HHF reset does not clear the classifier state used to identify heavy
hitters.  Packets after reset can therefore be scheduled using flow
history from before the reset.

The reset operation should return the qdisc to an empty state.

Clear the heavy-hitter classifier tables when HHF is reset.

Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Ensure no NULL dereference when initialization fails

 net/sched/sch_hhf.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 1e25b75daae2..d85cb0263b67 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -462,12 +462,39 @@ static struct sk_buff *hhf_dequeue(struct Qdisc *sch)
 	return skb;
 }
 
+static void hhf_reset_classifier(struct hhf_sched_data *q)
+{
+	int i;
+
+	if (!q->hh_flows)
+		return;
+
+	for (i = 0; i < HH_FLOWS_CNT; i++) {
+		struct hh_flow_state *flow, *next;
+		struct list_head *head = &q->hh_flows[i];
+
+		list_for_each_entry_safe(flow, next, head, flowchain) {
+			list_del(&flow->flowchain);
+			kfree(flow);
+		}
+	}
+	WRITE_ONCE(q->hh_flows_current_cnt, 0);
+
+	for (i = 0; i < HHF_ARRAYS_CNT; i++) {
+		if (q->hhf_valid_bits[i])
+			bitmap_zero(q->hhf_valid_bits[i], HHF_ARRAYS_LEN);
+	}
+	q->hhf_arrays_reset_timestamp = hhf_time_stamp();
+}
+
 static void hhf_reset(struct Qdisc *sch)
 {
+	struct hhf_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *skb;
 
 	while ((skb = hhf_dequeue(sch)) != NULL)
 		rtnl_kfree_skbs(skb, skb);
+	hhf_reset_classifier(q);
 }
 
 static void hhf_destroy(struct Qdisc *sch)
-- 
2.43.0


