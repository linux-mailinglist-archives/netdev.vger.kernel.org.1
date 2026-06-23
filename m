Return-Path: <netdev+bounces-301442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cROtJZXIOmpdGwgAu9opvQ
	(envelope-from <netdev+bounces-301442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:55:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C756B947B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:55:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lbyPS67u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301442-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301442-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1A9D310BC63
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2F8390219;
	Tue, 23 Jun 2026 17:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1138D3F9
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237023; cv=none; b=A2hwfFxsqvYT5cyWgZaW7pXlSD+Ek//pfiLelsbv4amCfC9+zBrNXWLOxN2Rs6rcRS8yFuDaxFTVWBlglMmjrs0gXcycU95R7pC1vlzJphCsNC2AmwnZIUzxHuBIODqgX8HMoTbGm8EdLluFxkIUG9I3iinSd1tnnaL6FKciIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237023; c=relaxed/simple;
	bh=e6JAJyZ5twPXQaVy1tlokGPh4iOm+asZ3n9da+paOQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRsMcUTbt3W6n6VKd0kTAjJa1lAFV9EcZT3VKpEM3VK4o6+GyEYccgYUkN0gesTPSdHk84hPjRdHfz4OpMM5YIC6mGynKoIyowrS47LgP7kcE7etOrZUyGR8BSmCkOXW4XOdnlaT8lTW/cb56rue4W7rffRqMv3nTsTP8826DTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbyPS67u; arc=none smtp.client-ip=209.85.167.180
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-48751bd4abeso139524b6e.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237018; x=1782841818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/u4Cl41DQceXJHbU/CnAGu2qq6sXnkAlKiyHbtqa7w=;
        b=lbyPS67uawB00+YB3smXRldoufKR72/yY4BMdf0RDQSvLkLh0fiuDfSMjvAeGD44pA
         Y/89ohtGqsXsvp/hZsMzKMAK6MdY9mq9aDnubdcMRQROgxTw1VuqTN1XEoXhRd2U7bMx
         80kibxoo+RlUt9CE10o0wpAUJHQfCZFOILWAv9ADgWJQCvOsTOpFGmdrZc1FfwFXKJ+O
         HRyK8zLL4uYCMycFH7lB7E6UYsLj6qhxITdVgGjkXyEmWgHHvsTl6h+jjKU1k4jUTly+
         2CEJmR9Ri4wE8p4J7AWIL4n1krAZEg2FkhXD1UeuA6Rq3kBOcHTntRQU6djBRokQILM0
         5DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237018; x=1782841818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/u4Cl41DQceXJHbU/CnAGu2qq6sXnkAlKiyHbtqa7w=;
        b=fvRcvZUCIsJf7N4+sAwCgz7B+rbiat7ETC4jUNp9ZZRIE2LKsi9geOEmg5n0s1RqyW
         nGvI6H0y+jZf+xBc1p7YjGf/BdBalo5OwPG408fnVT9Z8vxxU2tVJNJU5TOSyWyGWG02
         mV6W5fC6ZCbsX8zngR3Rv/hv4hBNMopklTGCTzlyXOnMa6pCkwUQAvXEdBxW2lEt9DC1
         TLVsf4OcfMNdf52zVcqYNHm9WMY1vsQu+vp7nCB/En5FsszK24fVawp2li3IBeGuzr5x
         HlOfCBHkDFned0/dr+8EezDa3CJYv1atc3FpooLFAa+OgNA6AcgdtYxsA6+890OZSptT
         QRLg==
X-Gm-Message-State: AOJu0YwZTbKr/rdvs9+Uc5fI6ELr5ekVnaYl1tEb430MJBzpRrvK3atN
	Gj+DOQZKxSjfMqx3aqf5ksMz6TKh02oYnmLx+8uDBYfrzvP9IaqhpuXh
X-Gm-Gg: AfdE7cnfNpvGkwbs0agThkmhYNIQHr9TCwhlNODE5jIivnOd8ihbQq+TjIKG0HX8v4Y
	N9UuHhfxyf1cQChAZpZQE1Gw5OrVYVz5f1YlebE0jzqepHxDOKRxhUpGZHpLxnpIO3abSB3LjSv
	vntrft7Zcq8KdbJID2AZUwILlaCbNaiUecyTPhPRPVIsv5va5Rh+Q6btSdi8iOBx4wbCw3cy5UB
	cICgh1Rv+8OzWztp4LGM4aI0wLxzQEi5iDkSEvYv+bqX1zyrvp4yhcZQvskK8CIfnpz0RWg5f7g
	NIU1ptH5rg1xbsGwCC0La/ykVUoOHYwjPPgghNpxVSivbSA/z0SfICm4j5/KJyfNdVtuw/Ts3fF
	uwnAO0Thwyj09wzxIRkGHO0HSc/5i7QOCW7khFFxUGukVRey5UlVAYK/NDGqP+DLOEyX70KvWd/
	SG5nY=
X-Received: by 2002:a05:6808:c3ec:b0:489:a388:167a with SMTP id 5614622812f47-48f27f28ba4mr2505819b6e.15.1782237018339;
        Tue, 23 Jun 2026 10:50:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0dcd69sm7685495b6e.5.2026.06.23.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 07/15] bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
Date: Tue, 23 Jun 2026 10:49:55 -0700
Message-ID: <20260623175006.3136053-8-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-301442-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 30C756B947B

From: Martin KaFai Lau <martin.lau@kernel.org>

Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
The purpose is to consolidate the auto_detach cleanup logic.

It prepares for the upcoming struct_ops cgroup attachment patch where
bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
(link->map != NULL).

This is a no-op change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b43f0bff184c..7abbe12e108f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
  */
 static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 {
+	if (link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
+		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
 	cgroup_put(link->cgroup);
 	link->cgroup = NULL;
 }
@@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
 				bpf_prog_put(pl->prog);
 			}
-			if (pl->link) {
-				if (pl->link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
-					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
+			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
-			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
-- 
2.53.0-Meta


