Return-Path: <netdev+bounces-301440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vQ/CEEDIOmo9GwgAu9opvQ
	(envelope-from <netdev+bounces-301440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:54:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA73F6B945B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:54:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aIDnmo7I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301440-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301440-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A794430DC7AB
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D138F633;
	Tue, 23 Jun 2026 17:50:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB07391501
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237019; cv=none; b=JX2VueBfdrhF/qxImlzx9j58S3DuLV00IgB6Qb6mdwlZ12vSnxcxjbCt8lK26oX1yBJxLL8jIAqCu65UUCDhh1PxPcX7dcFsoX1vzGvsgdUK+Y9sLjYIJkhdktnAXIrWQZFsrkxQOKGIkO65YqJuy9cCtsgwLpQHOnwMdFvAd/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237019; c=relaxed/simple;
	bh=vPK7Vn/omoySwDXOlGbKupOxZsD6+JDynojrGEu2s/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsnDCJPZMc9uplC8rVQFZVmP7G3I1knYUfUxLk5sPI+vNXcPgQtsefiVVpKBewuWV8PMHAQ0tFQgWoL0kx9xBWn0wO0uYuvQn30/IppQBj3JoubcDS2Ps9A6tA2D/r25UEBoJE7CB7IWeHJAQ5jaB3qrfk/qA3w6yjIeO50ZWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIDnmo7I; arc=none smtp.client-ip=209.85.167.178
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-486852c7b68so139141b6e.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237016; x=1782841816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ8JjxxRbRZTB/xdTCcikhmUU/ER5vgkd+n59LPEpXE=;
        b=aIDnmo7IEhgQZ7DieB+wMJ3/kSJOprmRvPklW0Bot1KhcicPa/Z44YFVsWcltqxxNh
         X8N+Tc5tzemlSW5fadzal6jGcvDUfGnozlwJsV20JMuTcmD7PQ1TxrsVaLcB/MFDbEbB
         DIvUzP1xR8kdDJRncW/qVjFY5fV2GhTH939ZTbrBp7OF6MTEq4CbhVQEekNAXl8fbMOn
         ZA4/wcW0Fzds2+7kdhG25djg/Cw4tUdTTJad+lF2Pc3LnwjvUA7gCBwpALvDWKZBy42H
         tYosXncHiTouo2EXcBLVVm98Gh8omPZx1jgM48MMIS7fnNVHWlJiwquI8TMV8u2hFO9k
         3aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237016; x=1782841816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJ8JjxxRbRZTB/xdTCcikhmUU/ER5vgkd+n59LPEpXE=;
        b=gdcq5ssKg0Z2xdyqyZ6l9ebjgTMFieoTdi2anBJUo+ZGKIamCRhsgO3h8DG535qb6c
         hMq3TpYuTkgYRSPFktQxWICZPrRUz6lLYKqFf6efwsT4nas9fZAS+HSUlZnIH2xopskp
         32pg9HS0cPYG+5bjVy0R5oyhVYDBjdMfLEni/dIg88WLbX8D/gR8euHfgiLAAjuZ32VI
         n23v11dsnxS945xDabtdDq9DGYIDXPY8WnZKZqHmHW3XaeX3Mb97VmYt4DIHXqnMHOik
         zOaJ55rD6HVzPSh8pxmwPOBBRPHmDIkowRdfdWKgPQj+5MW/pXBWVBooa46j3ceNnkmt
         tnlA==
X-Gm-Message-State: AOJu0YwOCEQqqE0npeV9nIzEl/uJgT1w3DxXMKqxaOltdvFaVH5CAnaG
	AsFXiz9W0hwSODAMtzXIqAp4imPyqDko6KQ68RELNb1yMMfkQNIt0Wfh
X-Gm-Gg: AfdE7ckcRIFdDM+tWHQKLPSdnyvYWdWjxIvbNqKjNexW9YI6xDXx2Ty3XYsY5kNfOVX
	FzHAwkzzV+/yLCElbQ5URXT4gi7O4hmvsRe2QzOFR6Gx9xTp9h8VfyaZR2H+wgEdhCRLsuBnjzv
	jXGqP1hbby+mRlqpWNSW1DmM9S8m1wPZoJkyNjiMDuTLIiGM0LnGxXOSlugausho2H/OPqfjM2o
	Qd3bUMt2YEyHhrMA++TqL9fp9ghe9YgNX26Ws8ih8wRCWHF/nG9fS/BPrhxNPU8yNrhHbWWSFxF
	By8/15efuI9QUo1HYF/yOdvvhESEgtkZhMnIf6QXjsBf343VSL1PRjd7TMx/BW0Vjx+ytIypIfj
	nqFdzv1MInZIPu8Mp99H1KtqL8Apha0a8PoXupmR/ArNWeBAWoK/5LQNfkAencaMAToI3Dayx5L
	DLrA==
X-Received: by 2002:a05:6808:14cb:b0:47b:c2a2:1c79 with SMTP id 5614622812f47-4896aa06ea3mr15642770b6e.1.1782237015659;
        Tue, 23 Jun 2026 10:50:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf23f7bsm7180537b6e.11.2026.06.23.10.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/15] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
Date: Tue, 23 Jun 2026 10:49:53 -0700
Message-ID: <20260623175006.3136053-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-301440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA73F6B945B

From: Martin KaFai Lau <martin.lau@kernel.org>

prog_list_length() and compute_effective_progs() use !prog_list_prog(pl)
to skip a 'detaching' pl.

When pl->link is not NULL, prog_list_prog(pl) returns
the pl->link->link.prog. This does not work for the upcoming struct_ops
patch where pl->link is not NULL but pl->link->link.prog is NULL,
because a struct_ops map is attached to the cgroup instead of a BPF prog.

To prepare for the upcoming struct_ops patch, this patch
replaces the prog_list_prog() test with the
"!pl->prog && !pl->link". In __cgroup_bpf_detach(),
both pl->prog and pl->link are set to NULL, so testing
"!pl->prog && !pl->link" is the same test to tell
if a pl is being detached. This change should be a no-op.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b64f6757096c..b100c04cb9c8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -408,7 +408,7 @@ static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
 	u32 cnt = 0;
 
 	hlist_for_each_entry(pl, head, node) {
-		if (!prog_list_prog(pl))
+		if (!pl->prog && !pl->link)
 			continue;
 		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
 			(*preorder_cnt)++;
@@ -482,7 +482,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
+			if (!pl->prog && !pl->link)
 				continue;
 
 			if (pl->flags & BPF_F_PREORDER) {
-- 
2.53.0-Meta


