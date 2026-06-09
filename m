Return-Path: <netdev+bounces-296802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BRaqMGFhJ2oxvgIAu9opvQ
	(envelope-from <netdev+bounces-296802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:42:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F08565B66F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:42:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b="P1n1Kw/s";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296802-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296802-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8804E304409D
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D123EA97;
	Tue,  9 Jun 2026 00:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6C223DFF
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:36:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965418; cv=none; b=ro73jYla+c87vApsu5iEcO1kDRZyNCLqCywxZ0GcF+O0jH2CveuGpsDW9Y1KTAYJ/6oSGZrurSsk0p1yqN+tLWN9rsT5rBQ1qHw/Ynp8Hr6wfL8QR3t5anL9HzxWdG7oXvg4XaSnI0Bim0vw272HglDjdn7sQZmMYdeiqrZyCxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965418; c=relaxed/simple;
	bh=FBLLeI6ImGN0/Ndp2USqZZ9uV2tas/yhtpKmZfg5rlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YGFLNgIga6MuYVb51NQ3kMzhoK74QTyC9L4pqfrwdWL8x1K51zeqnuycnzAxj6ejlvx8fJNAoeMwge5Km0W+QuWq7Tb6fta9z1tztkds16p7a5vuwX8/6+tDI8vI12hPRKBQ7ageXs5Gk4KORKeMUbmuEbRHW8Zov6kUMDlZggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=P1n1Kw/s; arc=none smtp.client-ip=209.85.222.169
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91587626ae1so560232185a.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965416; x=1781570216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTbEcM7UH1FXW0tMJYiIM9Tmk/7dMzRU32PgGhTsnQI=;
        b=P1n1Kw/suFu3AxLYhbxkiG8gTKEjOzGLkQ5ABbq+wLTBT50em+WwaCGCFj+k+F6PYv
         mVt8dklfhGKDaE4njPVsyoJ0P+kgaGWC5FPxUxto0bm9BwP6UxMwhnkzXED5pl3Fmnhz
         flhRwGAX2dxu+//HtNyqmv7CTyqQBGT2Fxp+rGcEzgAjELAdNQEBwv1TMpo9F+SM2HI3
         iTdtqipW0I58REO1xuuy3gaObZGL9OldsmVugxce3I4DUcIl1pYT6IJU0IJX3rDoZmsK
         2K7nWjp2NwDkVj6rdA9k5lyiMhxObp6us8dfhxRf1EO4rEAlNkp9+i9MmCSJdvPesA3Y
         1W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965416; x=1781570216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTbEcM7UH1FXW0tMJYiIM9Tmk/7dMzRU32PgGhTsnQI=;
        b=i79tIuQU5X/TqSyN3AIjBdk3Djd9B4D3o92DvnT6ZzJbN6Q2GUpBf0qqr45reqJXFn
         R+9axe0KIlAN7OpRVPmxHR/v5Jnd7VmbkIfsQ6KLm98Br0S7DnNwHXujodbhftvxNgzd
         cdcIGf81SIUJ3mQIxbks5bwmdrb6l81u+CCLjDni+vS+Xx67UqjUcoC9nfGM3ZXvW/p5
         CDlwEd8VcJz8CCmYGmZd0NgZfplFGyQtlTBgestGbJ5jXC7xKxgVsHdkxeEm6as+dYKD
         CTMWSgVmK8NjZGEob5uuD/2PELfX/UZ/tustdfm779UC/gWVj/okSqS114IJ7MkLebaY
         fqpg==
X-Forwarded-Encrypted: i=1; AFNElJ9yabuOGEfrREDbE5Tb5i1prRkNcG/mUEiP+T1wCmWoi3n204NRXx45bdU8XVvghbgc2I+Bd3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzooay+517wkQdKPAepmyfmAwkwTZfkOEpyGbKynUM81TC/qyVB
	pw/HOQnlt9n7XBVBmxv4UIs43tCPTU+m6nBkyG8S1etculMs6S95JIy2+okx2+AoQC4=
X-Gm-Gg: Acq92OEAyjIcu/CpLHkxblLsrzbhitC2FszC/KVgmxdte/x3Y7GY+UHYEQM3GDJ5C1p
	6ZYlpbpSyaOImkXbQ6M2v4oqoLx8NH+IwcJyoHFtWOJCK+XhQtP7X8Ut1gm9J2m6NAkqRAWGUbp
	kuKsRdhPiSIO633CE/l6lN7GsRgMc5A3BsmJixLF1hiQVIZzvKjuJLlFJua3komEUA/cLr79RJj
	xgAdf4U3fKXl59gI9m8KbDE+vvLi1WxAOJk7h1vL0zFXaxEw+s/bWW67mGazUZBNQNKbPEvEEhi
	FeIQrm56RLTS1aPuGi9tMCg6y/BNo326t1zS5XkNo5i8ELTWiMMg4LY/waH+hsqm/eg4D8HbFnX
	Jj1Uk186vR/DdKR1+ewWpKnTwZEOymbaSqP7uhpgn2QE28qHc3u/7BJkwApb6W23uRZJRLHnIOg
	NdUU40RPz8hmVeM0D+vMTRmShes/8yLOYMSBXkjw==
X-Received: by 2002:a05:620a:404c:b0:911:e74a:1e73 with SMTP id af79cd13be357-915a9e26402mr2802766385a.55.1780965415690;
        Mon, 08 Jun 2026 17:36:55 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-91589ea0bcfsm1924184185a.0.2026.06.08.17.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:36:54 -0700 (PDT)
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
Subject: [PATCH] net/sched: drr: reseed active class deficit after quantum changes
Date: Tue,  9 Jun 2026 00:36:18 +0000
Message-ID: <20260609003617.1237785.3427a8f0e7b0.drr-change-class-stale-deficit@trailofbits.com>
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
	TAGGED_FROM(0.00)[bounces-296802-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1F08565B66F

Changing the quantum of an active DRR class leaves the old deficit in
place.  The next scheduling round can therefore use credit accumulated
under a different quantum.

This can be observed by making a class active, changing its quantum, and
then dequeuing with the old deficit still present.

When an active class quantum changes, reseed its deficit from the new
quantum so the changed class weight is reflected immediately.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_drr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 01335a49e091..b40df8725ba6 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -98,8 +98,11 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 		}
 
 		sch_tree_lock(sch);
-		if (tb[TCA_DRR_QUANTUM])
+		if (tb[TCA_DRR_QUANTUM]) {
 			cl->quantum = quantum;
+			if (cl_is_active(cl))
+				cl->deficit = quantum;
+		}
 		sch_tree_unlock(sch);
 
 		return 0;
-- 
2.43.0


