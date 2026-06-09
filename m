Return-Path: <netdev+bounces-296792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Kk8N59ZJ2o1vAIAu9opvQ
	(envelope-from <netdev+bounces-296792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:09:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148965B476
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:09:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=Ca3nyHUh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296792-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296792-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD4F1301A338
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1CB42AA9;
	Tue,  9 Jun 2026 00:08:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553DEADC
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:08:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963730; cv=none; b=kSifzDdjgJ3emrCavaKF8Jaz6ThOEF8hiv9iDOmnyc8qO9EOEM70p9fQ3GaW/Uw+I70jHdY8MT54fe6DTaPInfHvcSiqijUH1VmQo0hIN3ABbZm09prHRXMsU2X+go/ENrtAouqLlgWcOcodjJOBqRxv1hwvBR9FaxpUleNvJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963730; c=relaxed/simple;
	bh=5U8oiBdbYg1PZ8fvQYzqAvI34P76dHAIuvIpS2zk8kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ic4catVf09WKYnNw49IoblhUBhErAXN7JvZWyFfGIFMuFL3AqX+106yVcscaOFOA6GtlmEuRMl/orSBnPRSFnp6TB3ve76JaunHzUiFJwm69pcH10gpRZCIt1bAw9a3O+OHp12BR3ZUbZFMlZhQgaYAs/qVAHQWt7yjcHYOhinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Ca3nyHUh; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce0f17a69cso37541306d6.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780963728; x=1781568528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4lidgO5F+++t6EB4HzmUPrlL28tLdwfkd2HVpHaeS1k=;
        b=Ca3nyHUhGBR4sNN4OQxE54zsEuY4z+SQZMOmr+FGIhdes7N+ljm0vatGUS7ePVJYLb
         qGrsilcKTCOJt9BVHG7guwlNM38haYxEjUxoCBh7ilQUsrkifApRhpWmvUdXJHKvPlDv
         C2kza4SdrYWOsvqKEluNqjSAhc1tkJP5S3QxsZ+PmQWyrj3hcg3yg9qOncfhVDOlsDBJ
         SHCcDPPK1VD64ibMbcaxWM24P0IcmpbfR00UmoNzzo7vMLs2spzfzhhZhBi+bvTfIb+r
         N2pEbbKiCstfF5H6Bb7ZZ4kW3dsXKoFcvnGUR4cs07a1wICSfuFslJ+PoOOZ5RdRupij
         dTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963728; x=1781568528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lidgO5F+++t6EB4HzmUPrlL28tLdwfkd2HVpHaeS1k=;
        b=haXi0PcEmIpMti5TfWVzqxRk3vEB7fiDDES/3ftfm0wX5DBjA0yv1QIpx8Lj1M9NA+
         fpZxbOX5lQACuQ0vJziHqTp5vjQGhP8qZ40OiEYxGHndfFj2+WF2m05ww0gV0WALf3kH
         6QzwLOSnz5EeeM6cgVDm6mxyyZaTDB5o/Kyc7D84KKLX+aVitUG392iIEBwNG+eE3tIY
         Qbv/WlqvzpcjEHJgTIMoBDcQr5n1wXPsBax/22NfJGMl0RaQQRT87FJ09VuCNshjfUWK
         UWAJTqvHYmkDOKW1snLYnvIxm3DJtyV8FJ7vJ2d1L3C1xY5DMByy9aFvcybLs7B4yFXV
         Qyrw==
X-Forwarded-Encrypted: i=1; AFNElJ/8g+9hgsnliBGhH5AOi/ha8lQw7zIttxAOAReqNglo21nAosxhJ4TNQrEmHML1E8ZfYvtgxaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ502Ymb0gZMxHWOyp8kOnkC23PWpmN7fnnxKVDapZPIi9UGok
	lmBdxV48Bp/qsIdFnqJZsmTRpwBwFUWPv62esjRpqKXHZSaIMPHA89wGfXDo5onpE3s=
X-Gm-Gg: Acq92OGp50098Obe8ZaU+GcUYMc5fMpohqbk/VrXqXpcO+Ps54AHPq9G+avEjxkb1bv
	AyRDI3u51840Tnp79OOdvNkjCmeMvXj9FxPE4Dyx0HIBvH8kDHuVUUtDX1+/wB1RoIt1psRX3tm
	a66fYkIcm4sqOfoZGLizYCj/3f8avreRfb9TSeA7cKyCkFYAY9Lo+tpBL8pcn6hAhA9Ok2ysROp
	q8av6dFuG6JmKXeiFRKxQr/HY5Dz7e96gK9s1WbhtLkwF4UrZ4bBiB/hTT8YZr+VqqOQUcl/4IC
	6kw1sIsi3T4OXreMi3BjdMeAErJbo4NsWamipG7cDxKGdQX/AoJBZcxC3lB3XjT8x31E1gpjaFV
	iGJUSCyKkIQ/lS1+cRr2tasWR6NXgU+NPEV1qJworwLjv6uRXTOF8w/78wxng/riLWLcucb+kmD
	qGLL4RMaWcoXFESFq9hdvUR67q7kuOJhfvPWgvIzj4plVsSYuU
X-Received: by 2002:a05:6214:4246:b0:8ca:16a6:3d40 with SMTP id 6a1803df08f44-8cee5f9f6c6mr222900836d6.5.1780963728475;
        Mon, 08 Jun 2026 17:08:48 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8ceccdcc968sm192900746d6.22.2026.06.08.17.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:08:47 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net (moderated list:CAKE QDISC),
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: cake: clamp active flow deficit on rate changes
Date: Tue,  9 Jun 2026 00:08:43 +0000
Message-ID: <20260609000605.1234374.9ba17536ec9e.cake-rate-change-stale-flow-deficit@trailofbits.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296792-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:toke@toke.dk,m:sam.moelius@trailofbits.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7148965B476

Changing CAKE rate parameters updates the quantum used for future
scheduling, but active flows can retain deficit computed under the old
rate.

That stale deficit lets an already active flow receive service based on
the previous configuration after userspace changes the shaper rate.

After recomputing rate-derived scheduling parameters, clamp positive
active-flow deficits to the quantum that applies under the new
configuration.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_cake.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 5862933be8d7..048d313e70fe 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2621,6 +2621,36 @@ static void cake_configure_rates(struct Qdisc *sch, u64 rate, bool rate_adjust)
 	qd->rate_shft = qd->tins[ft].tin_rate_shft;
 }
 
+static void cake_clamp_flow_deficit(struct cake_tin_data *b,
+				    struct cake_flow *flow,
+				    int flow_mode)
+{
+	s32 quantum;
+
+	if (flow->deficit <= 0)
+		return;
+
+	quantum = cake_get_flow_quantum(b, flow, flow_mode);
+	if (flow->deficit > quantum)
+		WRITE_ONCE(flow->deficit, quantum);
+}
+
+static void cake_clamp_active_deficits(struct cake_sched_data *qd)
+{
+	struct cake_sched_config *q = qd->config;
+	struct cake_flow *flow;
+	u32 tin;
+
+	for (tin = 0; tin < qd->tin_cnt; tin++) {
+		struct cake_tin_data *b = &qd->tins[tin];
+
+		list_for_each_entry(flow, &b->new_flows, flowchain)
+			cake_clamp_flow_deficit(b, flow, q->flow_mode);
+		list_for_each_entry(flow, &b->old_flows, flowchain)
+			cake_clamp_flow_deficit(b, flow, q->flow_mode);
+	}
+}
+
 static void cake_reconfigure(struct Qdisc *sch)
 {
 	struct cake_sched_data *qd = qdisc_priv(sch);
@@ -2628,6 +2658,7 @@ static void cake_reconfigure(struct Qdisc *sch)
 	u32 buffer_limit;
 
 	cake_configure_rates(sch, qd->config->rate_bps, false);
+	cake_clamp_active_deficits(qd);
 
 	if (q->buffer_config_limit) {
 		buffer_limit = q->buffer_config_limit;
-- 
2.43.0


