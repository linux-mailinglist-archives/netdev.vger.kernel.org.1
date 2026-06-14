Return-Path: <netdev+bounces-299244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xPTaJSDfLmr95QQAu9opvQ
	(envelope-from <netdev+bounces-299244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC0681B04
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 19:04:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G2FSOKdF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299244-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299244-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2A90301FB1B
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C83CD8AC;
	Sun, 14 Jun 2026 16:59:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8093CB90F
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 16:59:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781456354; cv=none; b=oP93jTsZRxUJsLcNKJvbathbaee7+w/anaIXTkgeZ6Xn3Pdc0qAW1jdTeZriQKkrFPFE6p3qv5z+f1lEJLRfn/pQ/9FqnTCJjzT9kGyk5XoqeCCgsZ2PaiHWUYcH7Zchhc27C22V4H3eY4+Q3ZHnJ9TmK0bc7hBao4WfYh5Sqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781456354; c=relaxed/simple;
	bh=FrdCFvpw9MoOQ0+PkoEs5DFfpaCKlDpBo6fwG5E9ypo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OAEfGPb+9oAPni5V5No2QMUXtrjR4PanYSniNZK6rADszl0hJ6VAZ03drzthPIFZ8tX+uVZfSv5ZmBwc4IOqDYVQbmpWQWk6B+rX1I7+e9r22l6tGwPFsAGMg7Pf4Qiax5lCAwypLAgogNprGNMt2sxbx6qDic7LonONBEc2r2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2FSOKdF; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso1609696a91.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781456353; x=1782061153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3rN8waOyeNHOu4xKjl7MMlKsb/kdxpH+0daFeUyAvA=;
        b=G2FSOKdFwQB13J5J8gIr5yRDvQTS4MNA42/W8Ff/ytJadLTWEpV4xOolmHCDa4e2vg
         lW2u2IsxAQEnZZYxBiQVmXJlaNY0UReLg+yq2Epses5U8MnRJaoqUZoRzkcdfJbr9lWt
         G+FJZV54xgAbL/mZXNatMVBCh2Tx8V8nfreOMJYLB5rTGX+ZMEb6qy8m+hlI9Yrm+Tjs
         IScyLeZkFDk8i++cTsKcWqPl75ed2YLmmPFoaC8a7oeeKAkOIesR3xvPlbtf31tZglWH
         aivb+hHGeEVxZlr/sJltVaWdVHtDL1an5td7hyOF9J5OD4iCzQ2VKjtI8cmvyswz8Ugx
         f1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781456353; x=1782061153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3rN8waOyeNHOu4xKjl7MMlKsb/kdxpH+0daFeUyAvA=;
        b=B7G5orQT6gN1PEosAFNEWeyKEVRqEjvggpVYAr97uHwuZwDHTQO/3Wy1gzhfRPosHh
         ZCLVkYqWROjclDZ/J9D7fMscjNxrJhHs+uZgGrUD6aLDPpOlz11fsRgq8UkIpGLFEnfs
         NGjCZ2HcSguCZriMyxmz7cc938RpIrzc1Lzc7qSyP6U/9u9Gf57BIQgbk6nB3254XFGb
         G0XkJirTwa3ddcW+4SGM0SrQH82emUm+NukK3JBAB3WDV51V1lQHUAysawa+TT4y5IgU
         Bf+M+cIfw/1zjAyfvidtFipn6qG4fk5oGSR7AGXbfAfnR8awxXbmWU8fT80uJHAWIBfm
         aY9A==
X-Gm-Message-State: AOJu0YxttTRpmdNp4bvPVbdG0WfklHoBfen3m+QvXmIyuZ+Z00Gstjhi
	nW1j3fNVTLSUq35Q6yPqVG4a5INbc1O/KG4CpbhorlIluFAsU5cEXPyd
X-Gm-Gg: Acq92OE+rPQxrNncEsdGPSidD7kmHoOxPlPE6fnhkMqWly6tyEbkB0pI0EEKy8p87VR
	z8IIETsn2A0j4AXGJbnEHpE9WUdyPqSq2DdbhR9FQMJbBWzstqWwl7P81GzDS0HmW58o8AIVxjA
	7TpydTsZAF9LgpD+IPeYGCwdtNVeSq/Zve+pATnnUfUsvMboBAu2g/dMNgrP9j+lazr3ob6TWb2
	o8CE01/TmHm/TbS3FWlhHVi2ie7+nt0SGMFzvKSKTL13nBPgTNZ9MHcxVBy0g4G46/hpKICVKDR
	ipZBAVZLBt1MYUnfSmgplrEUKOIQ/ICzE1zoL/xIxRaIbEa4TKJlp4RtlpqG3PzwKgVScb0cwKt
	LhqfWaf1Qo4WZC2W3TvD1tskkCInT6fGQJKYF/4nIwOSo+juBzxfF6xSeJBB2l6UqM6HiNaPRNV
	6vyFA/2YVYOCUFfrkpAMo633JVEo6wVLw=
X-Received: by 2002:a17:903:3887:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2c40e0350d2mr121454055ad.0.1781456352693;
        Sun, 14 Jun 2026 09:59:12 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5b79sm74457405ad.36.2026.06.14.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 09:59:12 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v3 4/4] selftests/bpf: Update comments find_equal_scalars->sync_linked_regs
Date: Mon, 15 Jun 2026 00:58:41 +0800
Message-ID: <3b5b6d9879fac3fb22b76c8249bd7c71609e1c39.1781194510.git.jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299244-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49CC0681B04

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit cfbf25481d6dec0089c99c9d33a2ea634fe8f008 ]

find_equal_scalars() is renamed to sync_linked_regs(),
this commit updates existing references in the selftests comments.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240718202357.1746514-5-eddyz87@gmail.com
[ zhenzhong: only two pre-existing comments still needed updating in 6.6.y. ]
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_spill_fill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 1f71f596d..07a2527a8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -392,7 +392,7 @@ __naked void spill_32bit_of_64bit_fail(void)
 	*(u32*)(r10 - 8) = r1;				\
 	/* 32-bit fill r2 from stack. */		\
 	r2 = *(u32*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
@@ -431,7 +431,7 @@ __naked void spill_16bit_of_32bit_fail(void)
 	*(u16*)(r10 - 8) = r1;				\
 	/* 16-bit fill r2 from stack. */		\
 	r2 = *(u16*)(r10 - 8);				\
-	/* Compare r2 with another register to trigger find_equal_scalars.\
+	/* Compare r2 with another register to trigger sync_linked_regs.\
 	 * Having one random bit is important here, otherwise the verifier cuts\
 	 * the corners. If the ID was mistakenly preserved on spill, this would\
 	 * cause the verifier to think that r1 is also equal to zero in one of\
-- 
2.43.0


