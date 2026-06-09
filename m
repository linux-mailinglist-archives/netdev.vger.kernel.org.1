Return-Path: <netdev+bounces-296819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a1syE25lJ2oTwAIAu9opvQ
	(envelope-from <netdev+bounces-296819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:59:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711065B7D9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=QfmfE8WU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296819-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6373041389
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7E2737E3;
	Tue,  9 Jun 2026 00:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847DC2561A2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:54:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966486; cv=none; b=CCCQjBDxtNjaPxgpOAiHhoMH6kDhEjWwOGu1amhuG+V+h9bIfKiLqHeCxmsDgu66OFIFS2rLGZBrH2S4DSSbRzx6eE1s4M+CFQgXON8uKvHzlcjv/1PUaxZoFwAz2YQS+ZOLay7Dmjox60LyqgGNBd0426XK5YcHdfhuJzIO+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966486; c=relaxed/simple;
	bh=Coixlgv9V4agh8pGeU5pWA5okcTp5+afDwct/tRzHOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yxrhw3vkEuhdukT1WcQdiU+PG4C2r+eRCQ/J6ghNQAvFB6HZD7n/g1nNieDhslMng0Y9W62MVIda9I1W2p6WaRe+f8BZTtiIkUa6JuW8sxyRw043HhwZn7DAPC/r80/CxbelmwEv4W9qGU1OJ1GMljVSKkHfA0dicKwT2QomA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=QfmfE8WU; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ce9e56f68cso41957776d6.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780966484; x=1781571284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NiPtFGmoxQWA1cVM/7OMnTBxFIctHy35uRoJvttDIZQ=;
        b=QfmfE8WUkwQpiACE2lBuLcdX5g97Y2Qm8k+XqXnzjoafkoyV8HISnDbIwpLqsxi9s7
         rV5O1d/oYb0qdDHLFLTGODWIyqAcewQflelfa1MbrWEJj1ZgM8aB68yXojQdBnphqOeJ
         hsjqBahusgUPpChyh6rvX4Fk0/gpkkIXpGBSnA3io2r5xFP46hQvp3V0s1VhGxc0M7KG
         qZJu5ZqmISYEn93mytQMAJBgqy8imh31cs22ogVu65IZwM6qKExUxIk1lEppqG4EKMp5
         Ec7uRKGOLtRuWopt/Y6eMFZngznLrZSiJauUfszFUz+W265NG8Nebs9jvjuZtr6N0n79
         BN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966484; x=1781571284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiPtFGmoxQWA1cVM/7OMnTBxFIctHy35uRoJvttDIZQ=;
        b=c4UVkzb04zdJZyD7hUbSkMCrXmQ8pEwaFTKW8k5lMEkfyEER8EFKY1dCnMp1TpaFd3
         g6K9e1Ogz8G5kmC1oAFsg9wB6eui2y0e652vyIuEutKVpzh6rKYUmY4+YRHPPOJnBiOh
         x+4fqCZir4nFVNZrs/Kb/WNhhW/XuOkcBVOdzJFJ/Zay/9E7H+uPEKEDUStFiVUfntXV
         bGM6XMZA2A4VmpHpJ5KGivorK2CQJUq9lUXLpnMbfm3lOQzSArCEhqd8xeKNbhR9O/tx
         4t8kbhpeoIXFk1PH6fKtr5GHUU2rDzJ3WYZoDpL3B+qWe7pRus7wMp2jiSjWmCpHGH/d
         cZ9g==
X-Forwarded-Encrypted: i=1; AFNElJ8/X/Jgv+09PS2ngHdlrbAQwe4u5r61GP4B4jAcecjo/0nQ32aFN66Vr9btDiIuJmOXTNPPf5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YybH+0bTX+YF/krb/ifVYrf6lCj2j6mGCrfWSU0FFvyPBy+BQlf
	DyYQnWv3glTEhdNWB9BZWVzDn6aW9hlHq+/iJL6WzyPFZdMqN9rhYz4KAhoaHZCaO9p8P0sW0F1
	d7aJBkT4=
X-Gm-Gg: Acq92OEePpEborsZh+qRTUrAVLuzKIQedAMb7g4WiFXs+OEfoULYjWMJOtrUgSTVu/U
	P/y29YEDD1ze+EymgGOVRH6cv+Ti+v5tJhmrXU0njwsO9JOmiwnbdHSxpstEvip+D8QpDSvmbnA
	HhJN6i81qypU3vRQvJW6HVW/crQhhhQxGk03fjs98ANkzh6LL8nIkFhdH+RLdVcePqiN/sxlaIv
	L+ABJN64itajKzijEzNXXhMawQptubwaQuZBGqU3BKhvn44YySWL+D/6alJxKefZFsln5+qObhU
	za2YSapOE2krZWJI1QFQPeOIgltPT/1YsbM3FzFyJdjbbwMN77IAKwz6CY8QqehHuPz81cSEWYd
	VOOF3PK6vkuf8x87WNOEnoNq86Y0mJXso9GzGyNxX6NrQkUeis773c9GzNg+ZgDER4cnXxmw89c
	CBp1Ym7tLCS92UJRm/Dd2n/Rd4C8U45hrrs0JkYw==
X-Received: by 2002:a0c:ebcf:0:b0:8ce:d68f:6723 with SMTP id 6a1803df08f44-8cee611fe62mr247029586d6.28.1780966484399;
        Mon, 08 Jun 2026 17:54:44 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd055181sm182153316d6.30.2026.06.08.17.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:54:43 -0700 (PDT)
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
Subject: [PATCH] net/sched: htb: move active classes after priority changes
Date: Tue,  9 Jun 2026 00:54:04 +0000
Message-ID: <20260609005403.1241111.e9391ba4793d.htb-active-prio-change-stale-row@trailofbits.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296819-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9711065B7D9

HTB lets userspace change the priority of an active class, but the class
can remain linked on the scheduler row for its old priority. Dequeue can
then treat it as if the old priority were still configured.

The scheduler data structures must reflect the new priority immediately.

Relink active classes onto the correct row when their priority changes.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_htb.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index eb12381795ce..dd1c11e1df42 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1770,6 +1770,8 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 	struct tc_htb_opt *hopt;
 	u64 rate64, ceil64;
 	int warn = 0;
+	bool reactivate;
+	u32 new_prio;
 
 	/* extract all subattrs from opt attr */
 	if (!opt)
@@ -2019,6 +2021,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 
 	psched_ratecfg_precompute(&cl->rate, &hopt->rate, rate64);
 	psched_ratecfg_precompute(&cl->ceil, &hopt->ceil, ceil64);
+	new_prio = min_t(u32, hopt->prio, TC_HTB_NUMPRIO - 1);
 
 	/* it used to be a nasty bug here, we have to check that node
 	 * is really leaf before changing cl->leaf !
@@ -2039,8 +2042,15 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 		}
 		if (hopt->quantum)
 			cl->quantum = hopt->quantum;
-		if ((cl->prio = hopt->prio) >= TC_HTB_NUMPRIO)
-			cl->prio = TC_HTB_NUMPRIO - 1;
+
+		reactivate = cl->prio_activity && cl->prio != new_prio;
+		if (reactivate)
+			htb_deactivate(q, cl);
+
+		cl->prio = new_prio;
+
+		if (reactivate)
+			htb_activate(q, cl);
 	}
 
 	cl->buffer = PSCHED_TICKS2NS(hopt->buffer);
-- 
2.43.0


