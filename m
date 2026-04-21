Return-Path: <netdev+bounces-280149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNbbNkiK52lY9wEAu9opvQ
	(envelope-from <netdev+bounces-280149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:31:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55143C12F
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 388963079C2E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11023D8106;
	Tue, 21 Apr 2026 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZyvGhlW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D12C2363
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781513; cv=none; b=azU58S/CJP1LlKccpDrjsuqib3uwLYMEsVqWN6DqM3Z2n6N+rnE1RVk2rPleHLfUpF4zrdD6Pfq7GG+IDNuI6LZydg0SoTR0QRhYAO/yMitiSAh+u6NxUDSPqbK13NHHeOJPhY7n23t7rI1v82ttSwx1p0xexeta0MrE/hXMLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781513; c=relaxed/simple;
	bh=iBzNpGaWpljXi2L3jnCeYJsm2vio0w1tlNTlElqFYVU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G3m5WyahWaE4s5wys9R1vGIO9kkRx3dbm3vZ+o2KGZ1EYj5p4AcBRcUnELzWbbBoGug3N6V5PpGimSc2Snx7FQOgmGzUb7B0eJ1x0RkPMLyvX78ehCsltAG7SkKsDW9N03zKhdzcbSd/TA/mzNCJidxPC5qPK+d4SY01W1oTO54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TZyvGhlW; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50e67a4f642so46089041cf.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776781511; x=1777386311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9hEn2EGwJ9pSE0YgR3Wa9zZJb3k3fhtlVuwdMwFFiSk=;
        b=TZyvGhlWa0jcJVt51F+a/Mw4ImkfxLgoTsxgGuM7O4x1dNngyDP65bW394ylx+lSxq
         IjS+N8nMfgX+yR6Wl0wmOAYce2chYwkCETYiyQA3IZc6Z41MhjIMTUnm3xXL4TeSeoBA
         MdlxDhzSN5Sjp6fgEBTsLgvzu2g1e+ViQUhqWAs2qNpe5qj0S0tLv/O5AMCYTW/UPE9Z
         k3vZAS8MFssC/LJdNHN8qOYMLk1CsHCMuNPtUJdDIDdZBjjuJN/aaFY+4QhUo7AywyrH
         kupnch42NAPoH4RQN7VPXJSoHkTbu0+jHSDI8ZDnYOuQnIbRJHmp2cRIXbZUKRMOa9C0
         ZCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781511; x=1777386311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hEn2EGwJ9pSE0YgR3Wa9zZJb3k3fhtlVuwdMwFFiSk=;
        b=JBwaLyxQ771eI1eAmuarLIBMcYr/Hu6+h8/kkOyYsNES6qqEv4UXOfUhGhnSRepgEx
         HXUoJVVNMryxqDIaRbWhV7O+8fAexRP89JUrSL9avyoEoORs1iwK/Cei+w+pmXJGsDiJ
         +X18Jn0/YllR7JVZvyP4rvvw/Jvj8lrlDglT1od2Hy17/TMtxisRosr0/Xg1A9/Er1ye
         Mnro96dahf2/gOw6yBeQ1+SstIk+Kp0R8/ZnRF4i54MoIFhKlccuHXz6P+0j/VaOpkxt
         wDaprDmSse0/kDJlMxrBrjJVFb6P1eAuThKA3RAmh69LLfZ3llbIJa4fW2CFy95OtITY
         iqew==
X-Forwarded-Encrypted: i=1; AFNElJ/XqKPaOxXQ7evYflGgtjBlFNWJ5pvEgYEoRR7AwEP2SpdC1EMLKEVfVdytcjrfQWoZxQs4eHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YweCKPaAzdML52/viKRAPfnXKP975gv+iJfhV7bbmvuX+T7PkcN
	ApIHCu73V4YSnXFf1tp5EGpLznaQCWEZKevo4Qur6Hw8bGxKZD3bz9n93EvZUPsHayMkXeamJbF
	gqxwB4EIXJpPIQQ==
X-Received: from qtjd17.prod.google.com ([2002:ac8:1191:0:b0:509:47c7:1148])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4245:b0:50d:8e6b:96ac with SMTP id d75a77b69052e-50e36ec5cc2mr249801841cf.58.1776781510797;
 Tue, 21 Apr 2026 07:25:10 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:25:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421142509.3967231-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280149-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4C55143C12F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.

Move this acquisition before we fill st.qdisc_stats with live data.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq_codel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 2a3d758f67ab43d17128442fd8b51c6ba7775d52..0664b2f2d6f28041e5250a44fc92311116ae0cf1 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -585,6 +585,8 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	};
 	struct list_head *pos;
 
+	sch_tree_lock(sch);
+
 	st.qdisc_stats.maxpacket = q->cstats.maxpacket;
 	st.qdisc_stats.drop_overlimit = q->drop_overlimit;
 	st.qdisc_stats.ecn_mark = q->cstats.ecn_mark;
@@ -593,7 +595,6 @@ static int fq_codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	st.qdisc_stats.memory_usage  = q->memory_usage;
 	st.qdisc_stats.drop_overmemory = q->drop_overmemory;
 
-	sch_tree_lock(sch);
 	list_for_each(pos, &q->new_flows)
 		st.qdisc_stats.new_flows_len++;
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog


