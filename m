Return-Path: <netdev+bounces-305163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Re0dLhD7S2oOeAEAu9opvQ
	(envelope-from <netdev+bounces-305163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:59:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988A714BE6
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:59:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Cm7EiRyg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305163-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305163-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE04A323DD04
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD863B776A;
	Mon,  6 Jul 2026 17:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A63B7B79
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358374; cv=none; b=FSAqA9FjfkOkseOngvHUJr4rcttUTVk/2VXmY8T1uXdxfQn/v6RV0JGPtSqaTNhbP+3cSaWzSjXsd5zeSC3MA6pC+PBbYoejTi9GCN2WgFvFhXnB4D9gCa72gEd7KFAnFV0PukXTUly8e+YEO2lPkL/npfNM/oLkBY895guHHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358374; c=relaxed/simple;
	bh=GOAtJKCzwiblZs1VJ+WSQarZsvZ3QcT8bQEfgh6ksYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwKzSliHjjXEL7+v0I/omlqZ8bszbggJqS+yfpq4hXJrlKXcQflHdiO2OgnytryWcGzGC4t7p8qFIpAh8mOOu85NZ65H3qa4P7pm6TnsyvfuT34K5aHga0MdL8q7fmQPJmClEHn+jOBJJNR8jVbztJYP67myma+MobTDdMSLGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cm7EiRyg; arc=none smtp.client-ip=209.85.210.52
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9fa42f08cso2179246a34.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358372; x=1783963172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GBIsMFu08y+xjMRxdkuwbm8NAaYbn72hr3Au+U5gJ8I=;
        b=Cm7EiRygGhqu2jsbFDLduaaPJN9SRdRj0X/0BilpHUz9xi8m/ooo8yELjg1saem+fb
         SZLHmP4ayxzBcKMG6NB9r/acmPgAq5wh8FEsyPaQfy1ae0PXWJVny/4RE8klh+dOfHHS
         AoqyiTsJ4OwPTKuKtHm+9c+Rvuibrx8OmCoD/q+UU8TIGuE0defPVQMWcw7dBavuSWPv
         RbEdPPbkeFDWG/uu+5NNXq1ZUOGhWy4ENxPeaojUtGqeKm7FJWsJIyJcRDB/akiNGsSt
         nuMdfyizjyeO8dw1WTNJ5s1/76Uy+jS+Qo+aR/jusrLt0/yRexPGoDNPf11q0Q/mwWFf
         QZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358372; x=1783963172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBIsMFu08y+xjMRxdkuwbm8NAaYbn72hr3Au+U5gJ8I=;
        b=bs/xC8Nu/hn1mHgdGA0WdIogzCwSkBS0dSDsFs8JkjJTCcAdgfnqgR00Yjz3DvBGgk
         Vu51YlVpREoT3XGowrbHkogq3lHM9KHyQQGXynxdWLXF3f4OdFSxilKPg1LyEsdRajRp
         eydKW0hp5m2pqr9pE///5xKzljtKBLZA3jzcvaP8eRBXKtuzuarEpKa+mzqTScgvHGMK
         kcg8zrwNrIqAn7nZLswWjXPzNmc6lG08uFksQMSRrb15BEfTaq86MNNX/zLa58t88WeN
         2u9kfZ7gZXAlY9VRbNEm8JcMJ0aYcOV0tEW+6xykCMAHP1jWbvYyCorvQVkxpGX6wpa7
         FJ5Q==
X-Gm-Message-State: AOJu0Yyz7n31e2OglMdkFicEqDQ3s0b/X/kEuD25tCo28tf5Bi0V8HiB
	9sa37WnTVDZNEa9GlRvui0iNcWrBi2Il0WvRzihYpIm10rpKvYTyK0Vo
X-Gm-Gg: AfdE7cnfzZT9FRcfUqNw+nz5zw7P1aEQMdnw93EbEnz16vUKbs7p0EGn0+4n1HY+lnt
	djqE4G33fSp5c+bAWOqZJ/iEoVXJnZAxeEvKSRYaM6EsvMG+nPZWd4pJiQzcA1SK+8i8ylXnrgD
	jwdaqG+J9KPCIqcNcKmuZCoRqH2G6NAvAYnjqSRKRZV6svmpDlXsgBRHW23tk0pPMELfzNLcunf
	bWeXI0elDPjE3p7mLkIuK+969pn0GBP/zJFtBuIjyGcfLgz6PBomZKP7E/qrR0bpDhq45TLWzzP
	hL9ar8EQJgakNgnsoCg2UiUYkRngtdcVuiHz4kLDr/O1leG5fE5LxvBON83xT5pwJctYg2V+kF5
	E+i9RXWQ6rd4iAChpeHARyYh0V5FHi/9z94m4evEKYiMDjnkXpo7qMl5iYndefQt4GPhlV0AHwx
	H/ng==
X-Received: by 2002:a05:6820:4d06:b0:6a1:50ec:440b with SMTP id 006d021491bc7-6a3556e9ac2mr897770eaf.72.1783358372570;
        Mon, 06 Jul 2026 10:19:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310375f72sm9721786eaf.10.2026.07.06.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 05/15] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
Date: Mon,  6 Jul 2026 10:19:07 -0700
Message-ID: <20260706171918.317102-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-305163-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1988A714BE6

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
2.52.0


