Return-Path: <netdev+bounces-296805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id khLuOsZhJ2pNvgIAu9opvQ
	(envelope-from <netdev+bounces-296805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5200C65B691
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=HVSo5FdC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296805-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296805-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66ED1301AD24
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D223395F;
	Tue,  9 Jun 2026 00:39:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93B1367
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:39:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965546; cv=none; b=hl0TktX91vbR1DpjSxuEqkqrXlsqJGK007VOFmUK0YigV0VvyRCLiyGJxnEooPOGS68aaDXvPPtTwYtflCoYWSe6uvjthHWXns9dc/LPkTIZEneqjR67Vaucm6RYLLmMZEw+v7xvveqnVq3YzrN9PICmFCBGZK0sJrNzLcIpxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965546; c=relaxed/simple;
	bh=Pflr0L2oEG27VZScyo0hSDeKHSm2Dt13WVoEdGYhX10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjjPYhVTJVj45Ew2opMFqLj7MfTf4Hq+0z60Gk1kniieOCAoc0wd9WiII6Ysj6ayPRihyuVuvc5nHIelnGkoRidIzYGDWcDT1+pW+VMpms7vC9ESdimZgDvwaobd7NmSbTK56sQeqR9KO+zwmi40ddOYk+5AX7QsHEWCPIZFhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=HVSo5FdC; arc=none smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176d4c14f5so41314221cf.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965545; x=1781570345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFSdTwQHu2wmF1rbagNQn8qnts6A/lk0fzBG1r82VQA=;
        b=HVSo5FdCnLyP8R3oVujgCYgBnpysHXKBEQoB51138Wr2Odx4ZsjWahBlBadlcjRoqr
         8+N522GXdtVsOgg2pKs8067d04wGz0MxuEAgbPqX6/gxpums1/QLp3jFy+IvOVAdaW7d
         vG6kNffZK/8kAwvjrwMSf/krjE2GH2NxwUOG0LXmwIDidYaiNOS2E7XNIvxpSMuZR6a5
         h2wjJK4aiy8/CdhaNPW8KmlfVZTTNHLumc1DTPCusmdCy5bejnZioZSshNaZ2koEk2Qc
         0mXJJRgMheu/o7L8dnNk8C/3XdC1tLDkWBIRrw2Wss8mtTsoCRVMbxbAV6EZn1iRMfA9
         xZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965545; x=1781570345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFSdTwQHu2wmF1rbagNQn8qnts6A/lk0fzBG1r82VQA=;
        b=CbjmfKPglC+beTQAf60tGUSvpuW5tW0akbZCaHagStRjNa4OEIvrfSg+3kPxTJs8al
         qBk3PhHZJOcDv1tLEI30uQUaZmkzwe+wvo8GfnRpQbpv+mGRZWMCQ2FWirMbPjvr94QH
         RSK49qukzYk6tpITQSV8ecdGjZn4zPIgf4QqWRq2D8ize5rWV//U8U8yKFSQmCRT5/P6
         gHPz6R1IehkG6XnWv0EvRy+z/Qk4jabvKKGbRSLVI9Xgx2Cz1hhjXejYYD8bgi6e8KSU
         DHPIxA7nfdM45pF/KBegEEbQOgvxYN8hL2HyXLZnGzpndpl3ra+un1KRi00FKMHBvCut
         dj9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8x/Rg9rOdgGDwpimWSYUqn8ezPkJx8Z+AqQjCl4ZsbHTUFZPoHm0pQgfFx0th3VfqrLzUkZ28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHWBOEd4WocVKd5fIdU9HP+nLc0MD3wS7PSONESR2Y2WjNqFF
	DFOmq307bcOsc0FIyYHljixiWI6HRcneqmL6LwKWcrLLPF0mn8xMnzbB/UNCW1w1r80=
X-Gm-Gg: Acq92OEA+MAB/AFQ5Oipqd9Zq4pjm9bUamPn13XRe+1lRhmHT/c41xksC3umY5vGrng
	gPnNnOONhcvro0m/6plZ2OQn08JZpay75G+tvfrTG1tDu/WMCP8KFR4vsEFHOIUyjiGfGfKb4VH
	otbRTfmnCvy3GwcaSEOeDLODk4E3GhQfBKxX5EG3k6c3wgCf5VKhNErTU7C96OnvOeq8MnbL4/L
	ZKRjz9DhWT9GDqe10Bxyxr0CWDsGuwT5ahtW9AlIBQYXTBKLl/+dbbTDtPRWn4Y5I6hE92HJCfs
	zis8LzlZnnVT6oA5ugRwIGw2+9jDznCUK1PJbRfh4wriiDTve33AjECGZLe09UtOjoJ3DlZ8w2A
	c+GnFErJjpPN6EociKpWkvR5oh3G6KtrSSPsRUk7mL+kdnVUzFlKiolSb6oj9eZgywp/qJv9Zrd
	rWujDvP5MQnqaEPvGxM/glyhdvd1u+wf87QWzH5A==
X-Received: by 2002:a05:622a:47c3:b0:516:d4b1:48cc with SMTP id d75a77b69052e-51795a4838emr233669771cf.8.1780965544697;
        Mon, 08 Jun 2026 17:39:04 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51789407da8sm138913441cf.19.2026.06.08.17.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:39:03 -0700 (PDT)
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
Subject: [PATCH] net/sched: fq_codel: clamp flow deficit after quantum changes
Date: Tue,  9 Jun 2026 00:38:17 +0000
Message-ID: <20260609003816.1238323.374833610959.fq-codel-change-quantum-stale-deficit@trailofbits.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296805-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5200C65B691

fq_codel updates the configured quantum without adjusting deficits for
flows that are already active.  Those flows can continue to carry credit
calculated under the old quantum.

This can be observed by making a flow active, changing the quantum, and
then dequeuing with the old deficit still present.

Clamp active flow deficits to the new quantum when fq_codel's quantum
changes so the new setting takes effect without waiting for stale credit
to drain.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_fq_codel.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 24db54684e8a..64e86ce3f34b 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -350,6 +350,19 @@ static void fq_codel_reset(struct Qdisc *sch)
 	q->memory_usage = 0;
 }
 
+static void fq_codel_clamp_active_deficits(struct fq_codel_sched_data *q,
+					   u32 quantum)
+{
+	struct fq_codel_flow *flow;
+
+	list_for_each_entry(flow, &q->new_flows, flowchain)
+		if (READ_ONCE(flow->deficit) > quantum)
+			WRITE_ONCE(flow->deficit, quantum);
+	list_for_each_entry(flow, &q->old_flows, flowchain)
+		if (READ_ONCE(flow->deficit) > quantum)
+			WRITE_ONCE(flow->deficit, quantum);
+}
+
 static const struct nla_policy fq_codel_policy[TCA_FQ_CODEL_MAX + 1] = {
 	[TCA_FQ_CODEL_TARGET]	= { .type = NLA_U32 },
 	[TCA_FQ_CODEL_LIMIT]	= { .type = NLA_U32 },
@@ -430,8 +443,10 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 		WRITE_ONCE(q->cparams.ecn,
 			   !!nla_get_u32(tb[TCA_FQ_CODEL_ECN]));
 
-	if (quantum)
+	if (quantum) {
+		fq_codel_clamp_active_deficits(q, quantum);
 		WRITE_ONCE(q->quantum, quantum);
+	}
 
 	if (tb[TCA_FQ_CODEL_DROP_BATCH_SIZE])
 		WRITE_ONCE(q->drop_batch_size,
-- 
2.43.0


