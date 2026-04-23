Return-Path: <netdev+bounces-280622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG7VI7e96WnijAIAu9opvQ
	(envelope-from <netdev+bounces-280622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:35:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F19A744DA4A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F02533006B42
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964513822AA;
	Thu, 23 Apr 2026 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqKCU/Df"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C753101A7
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926131; cv=none; b=Sd0wUrgm7aLCjnYCxFeCLiUvmrcFZA3sTppLlQooVVmEalpTvOppEjVXrNmGgfLY7vZZKOqe/Zzg5aEC3X2p1xWv8KXEurQEHaaMbFdurEWJHOwj5LZwkUmWLPt0j6IjuLP5jsqDu4+NiOOFrH7MqgdmR1b9VtJxa/CeLyf4hnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926131; c=relaxed/simple;
	bh=cxz2KiGzD3Qss2gSS/NisGV15V/6kFI2Yh17cqNmoMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CeaEi0LPbGWvi9TGe9Wt2sZ4Qnj9X/1HO6TOAqoRXWCl00wdAQibssINcvfcVIY5RRYHxDP9PYzD7pcSIJC96ztigttlOJ5B2xf0NK2By371SURTt9ao61yP54HKXmFtio2zDv8yM8acoVig1jIvGW7lPMkFQF59uAUSiWG1IH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqKCU/Df; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8acadca1ac4so180054446d6.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 23:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776926129; x=1777530929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ox5sew3kehZFDXer8EqslhcqBsxATnmvyhuAOPZiFOs=;
        b=aqKCU/Df4r1CGzo+3PgVT+ca7aZ0ycRGpFuehcPmbOlsI3LMhqKIBYhwDzZglygrWN
         pjPMRkiBMTDRH5hstRUIi7+DA2VB3x1B0z0bIwLT1OYss52b3H5VNY+dgbf+bc5K8q/S
         Hm0cgGgxzC73BdbSvUi5iwMCnMkJ1WkWegYH5d0ousdS0XizKFfIC0rDVZGjQS3UmFkp
         EqS4hGV4pBzuQO0TuWnspSZlBcjfn9o8sB3FqUpR6+VVUVtpbi+9wS5cNUG0Fkzl4xrI
         mCzq3o4pryA5aW0ZUrq4pWQJXQdPmbB0XzuGA5uyaFLkFvurngEDO7+XR0MPFqwOcrJQ
         pZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776926129; x=1777530929;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ox5sew3kehZFDXer8EqslhcqBsxATnmvyhuAOPZiFOs=;
        b=BXBbrlDVuxTBXcRS7hO1ZAPL8A375c+16JgpSkohthClHE2Ji3XytYEgff7h+Fe0is
         +qZlRVGvnd6eOKKtP6exQa+Bka4/9iUofeu4jaItlRTHIlgg70VLrJ993ejczcZC57OO
         tCtlnghu7MlKad/mv97PEUN4R4aWeF3s1RqfMiqSKNgf25yeGPsQqEHDQZulCHjmfsiB
         a8lNIoWtSdUpUL/1hVOrpiAwfO2gz71oPK0+Qr+GaVoDnZVpZs/86XP+yVMpwrYzd5mV
         50QeGu36xuCEs756A6FTpeWDmCmIqzmW/gnOr9bRjxbfkfd1orRNTFhbVOYXqJmZprE0
         xmqg==
X-Forwarded-Encrypted: i=1; AFNElJ9tBVaOU9Rqz1JmScTOe2gYq6pHI2voaWT+p7TCOk8m2DBZrRINte+LwJf2GrYTytqfXZzYnqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFs7VrpO64ndUEYcKUOq86K+UJlw/n2V5F6eRB+AbRaP/3WHRX
	K6MIpzj/XlVCe4UFaflI0bu4FC3gWx4d4Gca6AmHJrNcrub5z2+NuQCC/e3zlRbKagOp804tkNY
	aoGltvbSLqhcQEg==
X-Received: from qvboo32.prod.google.com ([2002:a05:6214:4520:b0:89c:6104:2e8f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1d08:b0:8ac:74f5:fbaf with SMTP id 6a1803df08f44-8b028177e9fmr417491306d6.51.1776926128820;
 Wed, 22 Apr 2026 23:35:28 -0700 (PDT)
Date: Thu, 23 Apr 2026 06:35:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.544.gc7ae2d5bb8-goog
Message-ID: <20260423063527.2568262-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280622-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F19A744DA4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.

Move this acquisition before we fill tc_fq_pie_xstats with live data.

Alternative would be to add READ_ONCE() and WRITE_ONCE() annotations,
but the spinlock is needed anyway to scan q->new_flows and q->old_flows.

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq_pie.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 154c70f489f289066db5d61bb51e58aaf328f16e..7becbf5362b3165bac4517f32887386b01301612 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -509,18 +509,19 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
-	struct tc_fq_pie_xstats st = {
-		.packets_in	= q->stats.packets_in,
-		.overlimit	= q->stats.overlimit,
-		.overmemory	= q->overmemory,
-		.dropped	= q->stats.dropped,
-		.ecn_mark	= q->stats.ecn_mark,
-		.new_flow_count = q->new_flow_count,
-		.memory_usage   = q->memory_usage,
-	};
+	struct tc_fq_pie_xstats st = { 0 };
 	struct list_head *pos;
 
 	sch_tree_lock(sch);
+
+	st.packets_in	= q->stats.packets_in;
+	st.overlimit	= q->stats.overlimit;
+	st.overmemory	= q->overmemory;
+	st.dropped	= q->stats.dropped;
+	st.ecn_mark	= q->stats.ecn_mark;
+	st.new_flow_count = q->new_flow_count;
+	st.memory_usage   = q->memory_usage;
+
 	list_for_each(pos, &q->new_flows)
 		st.new_flows_len++;
 
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog


