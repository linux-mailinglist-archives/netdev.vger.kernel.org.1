Return-Path: <netdev+bounces-305164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dXJoCt7mS2rHcQEAu9opvQ
	(envelope-from <netdev+bounces-305164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:33:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBF0713E81
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:33:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mP1C5z5M;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305164-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305164-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B1BA3046355
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691493B8127;
	Mon,  6 Jul 2026 17:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE23B83E1
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358377; cv=none; b=jkD9N+3M5WldTJPTHEmgOgSRBe21E/Qw1UsBgB7+avq/oRsmSRT3OJ6qS8jS2rC5FyNu/a5L8fPKZ/adqVaNQI4+m7RtUisvE4404ZehTEkT+wR9x1kqOmAyrpNnpyGHr/Fgokn7o7gll/b/RPRk0AFF5suKDI8lTeIwJYU4LHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358377; c=relaxed/simple;
	bh=ABd/ww76+k3Cz3HVdTtdsTw2NNqLB395KUoMr1kUL9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oq74deXUVTZmnDZkkE1yFH8s5W4m7Fd3h6dIApGqu87r/IKrdAhUIClyDwLz+ej8V5igIT6buGHYz9vZnRdvZvCuKxYEsjIukguNoznECoJS7HhgW7LDYSqkYTxIHLBhfO3dhSXrPwzmCvUyt2U1XS0WeVeY/IijKMtejti8x2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP1C5z5M; arc=none smtp.client-ip=209.85.161.42
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a30bcadd95so24428eaf.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358375; x=1783963175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwrNws75JbsyW/mUTo2aML94/IobRodHHQrNJC24UiE=;
        b=mP1C5z5M7IjE5wXHUQk3jHzRvZm9jlSiFgPS1Ti4PYmQaKtsUaQ79U8/ERTOfH3EUv
         CrnhtuOGJota5/pqufWw+EQ/BfNyaLyemarshvNw1ZEyH+i6lkX2iZJKETNe8sBqiHvy
         ky+lP+Xs/kpLUSGGnLT2VzlPG1HtbChJuWgPM6nYo5vkDbqg17CYYDeLlYORyQVMrKbU
         WwsRVOMMz2AYPRlCCRPYpXu5CCwp6V4lEN3b3Ea4lxJDpM+1XI/YzIufVyUVxZ7Yf/S1
         DWAyYglinLKywSIyBsD83Qz62BGcAgRkTylvgbNGu1mUJd5AkwO9Cd7/m0J5Lk8314H3
         R6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358375; x=1783963175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fwrNws75JbsyW/mUTo2aML94/IobRodHHQrNJC24UiE=;
        b=H9LDRss4U781PiFszEwCUceZjEEv1I1tOmPWBaBJGKSybO6tMdEonHl4YFML39ylEq
         p1ZJiMlNjTNszU3KmQt9MysAFS1TelNGfi0dz/aMwsqcIASPsddv5P+B8EircqVsHpGN
         ovHCH30pi8yq9RvvjpiFJyAov7xxO50f/iMOUmjRUNM9Aw0az1sKMBOXVcFDeENfdMi8
         +FXxWHwDtFcLyUzr8WJP8cqL1E9iZS199e1ywj8KHLcIwii3sWrxUpKTOV+LfapsN/xm
         6qXhfkiBkqvykxMq1LDa3Pfg6UVsOMjQkbutjmASrQcrwpI8jru8YL+5MsBFHRsjp4hC
         flkw==
X-Gm-Message-State: AOJu0YxDI5WR1FIR6g3+d/o2zwf6WX8sS3qMFeBwG/22nESGa6/ooYZr
	HzsxlBsVzbMrtEKWoKizM9TeGmGHHLWwb4rhlv7Dpngv1XU4k60mdbvR
X-Gm-Gg: AfdE7cny9HQrFIXcM1TvVMzo9vFqLT8GJLVsbiqS1ZpjKA6uuBbLnb4B0s4ya2cFP19
	Fspz/oSsBHPXMQtWLiiFR22JNKdMOid8Ay9pApj12+W7ILHCv6H0muKyE9Ic3oFq3x82rpB0GN9
	vgXE4hxljoi7hrWEJria+KceFv9fE4ew8P9ExfcNPd5D2XhsNSgsM1+gPe08KdWhq1L6m1IPKt/
	PSeBw1++FX0r7iQAK8fw2ZkAfmBG5fnZPBmNhQ1HAUPAux1PdlEGuGe7jCsYIJFAQg2NgcnvCUE
	KJ0iPJ02Cd50R4jcAtEsTC5p8t1iuJ15vsDDdvGxsP0W/j3JmYMNcpbRVEK9anW/R2pX6a9nC6a
	KhrcB1HPFNGy/7Ef7ciqFKPqIig3LjZ2LlpU3F0UCP0PgcTHPMa4+73SU7E1470Y0EqPDFAIwRc
	tQ/A==
X-Received: by 2002:a05:6820:60a:b0:6a1:7c3e:f62a with SMTP id 006d021491bc7-6a354586d88mr785791eaf.12.1783358374491;
        Mon, 06 Jul 2026 10:19:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb544f3d24sm12066292a34.21.2026.07.06.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 06/15] bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
Date: Mon,  6 Jul 2026 10:19:08 -0700
Message-ID: <20260706171918.317102-7-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305164-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CBF0713E81

From: Martin KaFai Lau <martin.lau@kernel.org>

Add three helpers to abstract operations on a bpf_prog_list entry.

Right now, bpf_prog_array_item is initialized from prog_list_prog(pl),
which returns either pl->prog or pl->link->link.prog. This will not work
when struct_ops is attached to a cgroup because the attachment is backed
by a struct_ops map instead of a BPF prog.

The same applies to __cgroup_bpf_query(). Instead of always copying a
prog id to userspace, struct_ops cgroup attachment will need to copy the
struct_ops map id.

Refactor bpf_prog_array_item initialization into prog_list_init_item()
and prog_list_replace_item(), and refactor id lookup into prog_list_id().
These helpers will be extended to support pl->link->map in a later patch.

This is a no-op change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b100c04cb9c8..b43f0bff184c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -399,6 +399,22 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
 	return NULL;
 }
 
+static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	item->prog = prog_list_prog(pl);
+	bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
+}
+
+static void prog_list_replace_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	WRITE_ONCE(item->prog, pl->link->link.prog);
+}
+
+static u32 prog_list_id(struct bpf_prog_list *pl)
+{
+	return prog_list_prog(pl)->aux->id;
+}
+
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
@@ -492,9 +508,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				item = &progs->items[fstart];
 				fstart++;
 			}
-			item->prog = prog_list_prog(pl);
-			bpf_cgroup_storages_assign(item->cgroup_storage,
-						   pl->storage);
+			prog_list_init_item(pl, item);
 			cnt++;
 		}
 
@@ -1015,7 +1029,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		item = &progs->items[pos];
-		WRITE_ONCE(item->prog, pl->link->link.prog);
+		prog_list_replace_item(pl, item);
 	}
 }
 
@@ -1318,15 +1332,13 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
-			struct bpf_prog *prog;
 			u32 id;
 
 			progs = &cgrp->bpf.progs[atype];
 			cnt = min_t(int, prog_list_length(progs, NULL), total_cnt);
 			i = 0;
 			hlist_for_each_entry(pl, progs, node) {
-				prog = prog_list_prog(pl);
-				id = prog->aux->id;
+				id = prog_list_id(pl);
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
 					return -EFAULT;
 				if (++i == cnt)
-- 
2.52.0


