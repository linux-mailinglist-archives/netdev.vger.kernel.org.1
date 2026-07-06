Return-Path: <netdev+bounces-305162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W5urCrvlS2pdcQEAu9opvQ
	(envelope-from <netdev+bounces-305162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:28:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C87A713DCE
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:28:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MSauimhA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305162-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305162-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00F72308FDBD
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FD13B7770;
	Mon,  6 Jul 2026 17:19:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE53B6379
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358373; cv=none; b=I5//g7l8PN7th07ejVxxeffoLtp8mS7uJRGSl+UdvsmWGutamCwkS9FbyuSHUqwog6wLNV8UnOKxEFvM2UZCJfIOMyPJatGkp0h+LOo0p7DQLy1YAdvhsJOJ2IZwdX+bIRw7i4iE9F3P5m5uE96X926EIUvtevvNNPj4ppD1W58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358373; c=relaxed/simple;
	bh=XZtVUQcCsDDKg0wSm4JJ3T71Iojch8O+uv9g9Sl3lgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qD48RPsP2sf1cdFSeVPm6RjEXtfqlOHQoZGug6tjK0KmzNFKNgfzn/X2/li2Sy8MW9Q5rWcuy7lpsv8iujhxlBrcxSVnMfBNw32cJ4n0Uy5J0qr27pzEWTHCWdT5sY0wzwnVX1ZLpvd0AEmH2hMw5FJbCaMBfAdfbY17wk4xJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSauimhA; arc=none smtp.client-ip=209.85.161.41
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69e9b037d82so2728271eaf.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358371; x=1783963171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZlV9XfIJTTA6Pu1Hwj8l2qlXdENOMQrIYnP3ua+eJM=;
        b=MSauimhA52MZ/+iiwKRy2XqJ4PQ15qyUBcMyrOySD4eTL1ngC+5yHFb12NEhHRkIUd
         4I8UKIZQvydEGGaXcOa6fmkHsLd5toY8iGJ/nZBf9aXj0a9G6XIpHIuPrrF1OSbkEtoa
         GQlK9mkQvXlKgrjZV0RjRQk2q6SRoGNBwd4GqbXwrXz2p4mL9viRypqpjWoY9JKbh1rb
         ucjo+NKiVfyFp82kKz/dMdpcNs8Y55YAxQ99brjnQVqSzJFLUnxw5XivsvkLLrOWonIn
         b5IRVK7h0PXrrpdn8ptcC41CdojAMIbo1g1I6lfAZB4hNeSHMyr7nITR4HSuEEFzq7oA
         eUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358371; x=1783963171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZlV9XfIJTTA6Pu1Hwj8l2qlXdENOMQrIYnP3ua+eJM=;
        b=X2BwFTl/rBPT3/BzzS6FJv/3OVDoi2gjYGD+9smcU3n8Pn74tOiNv+WwZhrH0fHHnR
         3ktkn7vZ2mLjA+K1NgpBmPWXsIXN1ZyW24ykKNRDi6H3ImxbcJn9tOqU6hSAV0zAbU5L
         HTq+yVi7nOSLFkVvRSmnPnYV5O6WT/jqHwH/b/+FLfTxguAYqVuIK7KnewL60ZHXsV4d
         7mDNrTAog+JPxZl3VGpw0AFgcXuKSiaJ7GKJz7SGFPChJibisjLb+Du2b78k+yUak+we
         HEQu3lp8BRxNLyQfyxxIE2js3//zX8Jljzqaw01/ivwCSU2MuoS3u9enF7kwZki+dTZr
         5ahQ==
X-Gm-Message-State: AOJu0Yyy6P25l9I14evyOi7vSGjFKyYkSPYr/EBAxUMi5fxc7bpoVHxD
	PidyKDXb9+NDL+xBIwQIJ9ALro6KJK/Nk0TJMB66chS/aVTbm63Ovzds
X-Gm-Gg: AfdE7cl710VbstPR1Myhmd58EYFtriAEZm9GDN8RVRSazVSWP1PwDS3cRPSYPNaJP4i
	XBSG4qavWck5pmzBHoMmXdqtCW/5tIK22qKaGUfYeeB25kO/9gfA45QsnZG2gVNLvomjoRb8b6M
	wuaxwuNS0eKbUKZ8j0yGaNc3U4pw0ZmcYpDTbisjl1AmaPzE9NhqCk2i5JzXL9XuONJWqbFuRBf
	fKGHzFbiHVNidtH3dOUBVHFKbnaxfLsVSaz84AxLEYekK55l28cxxS2NqpIl1zmozvJjQHLrVoU
	qZQsRTyPjMCk3lleir4DUm/1BnleyaSHeKBYQZvZeV9bKh4ojIp2FGc7ElQ3pL13t6p5l/CHo1r
	O+0CF43l3EaW5yP2NLYtccIDQmVLkuWWR2/mwVvcFghekb/DBgy9rssfmLVnFmFHMvgnuk8qlnk
	+/aNA=
X-Received: by 2002:a05:6820:a09:b0:6a3:2b61:4cc7 with SMTP id 006d021491bc7-6a355597cdbmr958874eaf.72.1783358370791;
        Mon, 06 Jul 2026 10:19:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a30ffce324sm9600123eaf.5.2026.07.06.10.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 04/15] bpf: Remove unnecessary prog_list_prog() check
Date: Mon,  6 Jul 2026 10:19:06 -0700
Message-ID: <20260706171918.317102-5-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305162-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C87A713DCE

From: Martin KaFai Lau <martin.lau@kernel.org>

effective_prog_pos(), called from replace_effective_prog() and
purge_effective_progs(), tests "!prog_list_prog(pl)" to skip a
'detaching' pl.

When detaching a pl, pl->prog and pl->link are set to NULL in case
the update_effective_progs() failed.

However, replace_effective_prog() is not detaching a pl,
so the case "!prog_list_prog()" will not happen.

In purge_effective_prog(), the pl->prog and pl->link are restored
before calling purge_effective_progs(), so the case "!prog_list_prog()"
will not happen either.

This patch removes them as a prep work for the upcoming work
in attaching struct_ops to cgroup. When attaching a struct_ops
to cgroup, there is a link->map case and the prog_list_prog()
will not consider the link->map. The replace_effective_prog()
and purge_effective_progs() will then incorrectly skip a pl
with struct_ops map attached to it.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4355ccb78a9c..b64f6757096c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -965,9 +965,10 @@ static int effective_prog_pos(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
-				continue;
-
+			/*
+			 * No detaching pl (NULL prog and link) is visible to the callers,
+			 * so skip the check compute_effective_progs() needs.
+			 */
 			if (pl->flags & BPF_F_PREORDER) {
 				if (pl == target_pl)
 					pos = bstart;
-- 
2.52.0


